MODULE ICONTEXT
   USE, INTRINSIC :: ISO_C_BINDING
   USE CONTEXT_INTERFACE
   USE IDATE
   USE IDURATION
! USE icontext_attr
   TYPE xios_context
      INTEGER(kind = C_INTPTR_T) :: daddr
   END TYPE xios_context
   INTERFACE xios_set_current_context
      MODULE PROCEDURE xios_set_current_context_hdl, xios_set_current_context_id
   END INTERFACE xios_set_current_context
   CONTAINS ! Fonctions disponibles pour les utilisateurs.
   SUBROUTINE xios_get_context_handle(idt,ret)
      IMPLICIT NONE
      CHARACTER(len = *) , INTENT(IN) :: idt
      TYPE(xios_context), INTENT(OUT):: ret
      CALL cxios_context_handle_create(ret%daddr, idt, len(idt))
   END SUBROUTINE xios_get_context_handle
   SUBROUTINE xios_get_current_context(context)
      IMPLICIT NONE
      TYPE(xios_context), INTENT(IN) :: context
      CALL cxios_context_get_current(context%daddr)
   END SUBROUTINE xios_get_current_context
   SUBROUTINE xios_set_current_context_hdl(context, withswap)
      IMPLICIT NONE
      TYPE(xios_context) , INTENT(IN) :: context
      LOGICAL , OPTIONAL, INTENT(IN) :: withswap
      LOGICAL (kind = 1) :: wswap
      IF (PRESENT(withswap)) THEN
         wswap = withswap
      ELSE
         wswap = .FALSE.
      END IF
      CALL cxios_context_set_current(context%daddr, wswap)
   END SUBROUTINE xios_set_current_context_hdl
   SUBROUTINE xios_set_current_context_id(idt)
      IMPLICIT NONE
      CHARACTER(len = *) , INTENT(IN) :: idt
      LOGICAL :: withswap
      TYPE(xios_context):: ret
      CALL xios_get_context_handle(idt,ret)
      CALL xios_set_current_context_hdl(ret, withswap)
    END SUBROUTINE xios_set_current_context_id
   LOGICAL FUNCTION xios_is_valid_context(idt)
      IMPLICIT NONE
      CHARACTER(len = *) , INTENT(IN) :: idt
      LOGICAL (kind = 1) :: val
      CALL cxios_context_valid_id(val, idt, len(idt));
      xios_is_valid_context = val
   END FUNCTION xios_is_valid_context
END MODULE ICONTEXT
