module CNNitrogenStateType
  use clm_varcon     , only : spval, ispval, c14ratio
  use shr_kind_mod       , only : r8 => shr_kind_r8
  use decompMod      , only : bounds_type
  use clm_varpar     , only : ndecomp_pools, nlevdecomp_full
implicit none

  type, public :: nitrogenstate_type
    real(r8), pointer :: decomp_npools_vr_col         (:,:,:) => null()! col (gN/m3) vertically-resolved decomposing (litter, cwd, soil) N pools
    real(r8), pointer :: smin_no3_vr_col              (:,:)  => null() ! col (gN/m3) vertically-resolved soil mineral NO3
    real(r8), pointer :: smin_no3_col                 (:)   => null()  ! col (gN/m2) soil mineral NO3 pool
    real(r8), pointer :: smin_nh4_vr_col              (:,:)=> null()   ! col (gN/m3) vertically-resolved soil mineral NH4
    real(r8), pointer :: smin_nh4_col                 (:)   => null()  ! col (gN/m2) soil mineral NH4 pool
    real(r8), pointer :: sminn_vr_col                 (:,:)=> null()   ! col (gN/m3) vertically-resolved soil mineral N
    real(r8), pointer :: sminn_col                    (:) => null()
    real(r8), pointer :: cwdn_col                     (:) => null()
    real(r8), pointer :: totsomn_col                  (:) => null()
    real(r8), pointer :: totsomn_1m_col               (:) => null()
    real(r8), pointer :: totlitn_1m_col               (:) => null()
    real(r8), pointer :: totlitn_col                  (:) => null()
    real(r8), pointer :: pnup_pfrootc_patch           (:) => null()
    real(r8), pointer :: som1n_col                    (:) => null()
    real(r8), pointer :: som2n_col                    (:) => null()
    real(r8), pointer :: som3n_col                    (:) => null()
    real(r8), pointer :: domn_col                     (:) => null()
  contains

    procedure, public  :: Init
    procedure, private :: InitCold
    procedure, private :: InitAllocate
  end type nitrogenstate_type


contains
  !------------------------------------------------------------------------
  subroutine Init(this, bounds)

    class(nitrogenstate_type) :: this
    type(bounds_type), intent(in) :: bounds

    call this%InitAllocate ( bounds )

    call this%InitCold ( bounds )

  end subroutine Init
  !------------------------------------------------------------------------
  subroutine InitAllocate(this, bounds)
    !
    ! !DESCRIPTION:
    ! Initialize module data structure
    !
    ! !USES:
    use shr_infnan_mod , only : nan => shr_infnan_nan, assignment(=)
    !
    ! !ARGUMENTS:
    class(nitrogenstate_type) :: this
    type(bounds_type), intent(in) :: bounds
    !
    ! !LOCAL VARIABLES:
    integer :: begp, endp
    integer :: begc, endc
    !------------------------------------------------------------------------

    begp = bounds%begp; endp= bounds%endp
    allocate(this%decomp_npools_vr_col(begc:endc,1:nlevdecomp_full,1:ndecomp_pools));
    this%decomp_npools_vr_col(:,:,:)= spval
    allocate(this%smin_no3_vr_col          (begc:endc,1:nlevdecomp_full)) ; this%smin_no3_vr_col          (:,:) = spval
    allocate(this%smin_nh4_vr_col          (begc:endc,1:nlevdecomp_full)) ; this%smin_nh4_vr_col          (:,:) = spval
    allocate(this%smin_no3_col             (begc:endc))                   ; this%smin_no3_col             (:)   = spval
    allocate(this%smin_nh4_col             (begc:endc))                   ; this%smin_nh4_col             (:)   = spval
    allocate(this%sminn_vr_col             (begc:endc,1:nlevdecomp_full)) ; this%sminn_vr_col             (:,:) = spval
    allocate(this%pnup_pfrootc_patch (begp:endp)); this%pnup_pfrootc_patch (:) = spval
    allocate(this%cwdn_col(begc:endc)); this%cwdn_col(:) = spval
    allocate(this%totlitn_col(begc:endc)); this%totlitn_col(:) = spval
    allocate(this%totsomn_col(begc:endc)); this%totsomn_col(:) = spval
    allocate(this%totlitn_1m_col(begc:endc)); this%totlitn_1m_col(:) = spval
    allocate(this%totsomn_1m_col(begc:endc)); this%totsomn_1m_col(:) = spval
    allocate(this%som1n_col(begc:endc)); this%som1n_col(:) = spval
    allocate(this%som2n_col(begc:endc)); this%som2n_col(:) = spval
    allocate(this%som3n_col(begc:endc)); this%som3n_col(:) = spval
    allocate(this%sminn_col(begc:endc)); this%sminn_col(:) = spval
    allocate(this%domn_col(begc:endc)); this%domn_col(:) = spval
  end subroutine InitAllocate

  !-----------------------------------------------------------------------
  subroutine initCold(this, bounds)
    !
    ! !USES:
    use spmdMod    , only : masterproc
    use fileutils  , only : getfil
    use clm_varctl , only : nsrest, nsrStartup
    use ncdio_pio
    !
    ! !ARGUMENTS:
    class(nitrogenstate_type) :: this
    type(bounds_type), intent(in) :: bounds
    !
    ! !LOCAL VARIABLES:
    integer               :: g,l,c,p,n,j,m            ! indices
    real(r8) ,pointer     :: gdp (:)                  ! global gdp data (needs to be a pointer for use in ncdio)
    real(r8) ,pointer     :: peatf (:)                ! global peatf data (needs to be a pointer for use in ncdio)
    integer  ,pointer     :: soilorder_rdin (:)       ! global soil order data (needs to be a pointer for use in ncdio)
    integer  ,pointer     :: abm (:)                  ! global abm data (needs to be a pointer for use in ncdio)
    real(r8) ,pointer     :: gti (:)                  ! read in - fmax (needs to be a pointer for use in ncdio)
    integer               :: dimid                    ! dimension id
    integer               :: ier                      ! error status
    type(file_desc_t)     :: ncid                     ! netcdf id
    logical               :: readvar
    character(len=256)    :: locfn                    ! local filename
    integer               :: begc, endc
    integer               :: begg, endg


  end subroutine initCold

end module CNNitrogenStateType
