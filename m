Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00370C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkUE-0007hB-Nc; Fri, 17 Jan 2025 06:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1tYkUB-0007VH-Kn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:25:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1tYkU2-00043h-7G
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:25:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283dedso18844625e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737113147; x=1737717947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5wjwd6q8UnhUnTa43+OL9ohUBWY6rIZTfEFEYu8NWdc=;
 b=EF3qKuCU7KHdd94OvIxTFjUM0e/HakMv27hn5738lFUuMIg8c309VIRewhcdUEHaOg
 zrtGz+ooS+CN2pxx/tDwDPus/YBiGO1BPoPSRLmUVHB7pNIYzihLOy5gcGo28fQRUYTL
 AzLr2RupQLmfn3PG+bTRFeTd1jKOK2yu3qbDkvuc36/b5YGi6g4FUocFQ/bqr1NvV3ox
 2sj9aIJybyEyOl0kT2E1xAwMwc4X0kqmv2+le3DMYCy6Cvoz4TyL/801tBM/fiWsGvER
 ueWBJIwQ8gC+Byh2lwnEJ/HNxqZisTU/79YyJzXpQYBuzdoMeO59cCNVtLI1EEwKynWd
 M6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737113147; x=1737717947;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5wjwd6q8UnhUnTa43+OL9ohUBWY6rIZTfEFEYu8NWdc=;
 b=qFI7+L7BuCnr4MysazKMxcRsL+b8UbLTz5HNO8VdodXVRGsyBz+og5PUoxeLHjCafY
 DKobqMGzt+8sWtpSbe/n5nkK+yliNlljlXRUExk5VjqpfDir87zIaxz7rP3o9x5Hzu3h
 kGFS6rKdVUp1V1swL19TwAPCh6xg7mkkJuB1/st+8LbLfcAcKyEyjj+3w0eyDtpRjYLb
 8Rx+w369e54f1sk9gJo507iH6AYj3bEd7UIzouaxFQpIQ5U2KhsjuNZpQpH1dQDbUZeU
 Y6z2GTwOs9OhXdAr9KFLs+6U8r1jWmzZLOkIL1DjW6LCJl8R42eenpM/yU7XrFoyE9nU
 rSQg==
X-Gm-Message-State: AOJu0YyuJ/QebZEvMIj6s27M67syhSGxizVrHcEpOiO5a1ZG5Rcl/pw9
 flW5NIr/4muLFfTw6QUZEfNnJCIMRcyIXgEvd2Rg2X4a3GP2RdvOCsqpsXGsh/f7RZa9NIb3KjY
 m1Wvq4nZbMdjUMM0S8p0ks7ZBels=
X-Gm-Gg: ASbGncvouQLCBce7uwrMpxf2EpEMKoVPL/vbYkKU0kmCglRBPWzTqmkqqrp8oasTsba
 9RSyZQRn+oi7iRgaQiDiygkJlBfctFkMEYNlBm0o=
X-Google-Smtp-Source: AGHT+IGObZkVp1aoUKTe934w6/jE2xV6Hq//+9xnr4ecKox81ih85F2v5JqTiawnlk2BQVj4ZpqYaBfqprDmBbRQdNA=
X-Received: by 2002:a5d:5848:0:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-38bf57b7fb2mr2103718f8f.36.1737113146562; Fri, 17 Jan 2025
 03:25:46 -0800 (PST)
MIME-Version: 1.0
From: Yang Dongshan <east.moutain.yang@gmail.com>
Date: Fri, 17 Jan 2025 19:25:35 +0800
X-Gm-Features: AbW1kvYEAMD4wn7s1GO_YBcReE98wmZLM5WGGdNxsHu_RIaYVb689ZO0aUegJxU
Message-ID: <CALrP2iVMOYorBJ+drXXeDhHvkMencxMXR3YJ-xhru5=_ic_Ckw@mail.gmail.com>
Subject: Re: [PATCH] vfio: Support P2P access in confidential VM
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "clg@redhat.com" <clg@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, 
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, 
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000009216e062be52c96"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000009216e062be52c96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi, Alex



> Where's the kernel patch that implements the MMIO map flag.  That needs
> to come first.



The kernel patch is on the way, I have submitted patch to linux kernel,
waiting for review.

Patch link:
https://lore.kernel.org/all/20250117071423.469880-1-east.moutain.yang@gmail=
.com/

> I also don't understand why we're creating multiple read-only and
> ramdev flags to distill back into vfio mapping flags.  Thanks,



Read-only is one of memroy access attributes, page table entry has
corresponding bit for page R/W.

There is another bit on page table entry to control whether the page should
be encrypted or

decrypted when writing to or read from the page, this is usually done by
hardware engine in memory

controller according to the encrytion bit in bus address. The actual
physical address will not include

encryption bit when the it reaches to real DRAM.



|CPU| ---va---| page table |---enc+pa---| mem ctrl |---pa---| DRAM |



When it comes to perpherial device mmio memory, access the other device=E2=
=80=99s
mmio memory,

The memory controller is not get involved,  so the encryption bit is
carried to dest physical

address, which is not expected.



| devA |---iova---|io page table|---enc+pa---X---|devB|   <-- incorrect pa

| devA |---iova---|io page table|---pa---|devB|   <-- correct pa



Here I use ramdev flag to tell IOMMU driver the memory range is device
mmio, so

that IOMMU dirver will not set encryption bit on IOMMU page table entry.



Thanks.



On Fri, Jan 17, 2025 at 1:47=E2=80=AFAM Alex Williamson <alex.williamson@re=
dhat.com>
wrote:

On Thu, 16 Jan 2025 17:53:55 +0800
Wencheng Yang <east.moutain.yang@gmail.com> wrote:

> On confidential VM platform, for example, AMD-SEV, P2P doesn't work.
> The underlying reason is that IOMMU driver set encryption bit on
> IOMMU page table pte entry, it's reasonalbe if the pte maps iova
> to system memory. However, if the pte maps iova to device's
> mmio bar space, setting encryption bit on pte would cause IOMMU
> translates iova to incorrect bus address, rather than mmio bar
> address.
>
> To fix the issue, the key point is to let IOMMU driver know the
> target phyical address is system memory or device mmio.
>
> VFIO allocates virtual address and maps it to device mmio bar,
> the member @ram_device of MemoryRegion indicates the memory
> region is for mmio. The patch passes the info to VFIO DAM API,
> IOMMU driver would do the correct thing.
>
> Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> ---
>  hw/vfio/common.c                      | 67 +++++++++++++++++----------
>  hw/vfio/container-base.c              |  4 +-
>  hw/vfio/container.c                   |  6 ++-
>  hw/vfio/iommufd.c                     |  4 +-
>  hw/virtio/vhost-vdpa.c                |  6 +--
>  include/exec/memory.h                 |  7 ++-
>  include/hw/vfio/vfio-common.h         |  4 ++
>  include/hw/vfio/vfio-container-base.h |  4 +-
>  linux-headers/linux/vfio.h            |  1 +
>  system/memory.c                       | 11 +++--
>  10 files changed, 74 insertions(+), 40 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f7499a9b74..2660a42f9e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -247,31 +247,42 @@ static bool
vfio_listener_skipped_section(MemoryRegionSection *section)
>
>  /* Called with rcu_read_lock held.  */
>  static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only,
> +                               ram_addr_t *ram_addr, uint32_t *flag,
>                                 Error **errp)
>  {
>      bool ret, mr_has_discard_manager;
> +    uint32_t mr_flag =3D 0;
>
> -    ret =3D memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> +    ret =3D memory_get_xlat_addr(iotlb, vaddr, ram_addr, &mr_flag,
>                                 &mr_has_discard_manager, errp);
> -    if (ret && mr_has_discard_manager) {
> -        /*
> -         * Malicious VMs might trigger discarding of IOMMU-mapped
memory. The
> -         * pages will remain pinned inside vfio until unmapped,
resulting in a
> -         * higher memory consumption than expected. If memory would get
> -         * populated again later, there would be an inconsistency
between pages
> -         * pinned by vfio and pages seen by QEMU. This is the case until
> -         * unmapped from the IOMMU (e.g., during device reset).
> -         *
> -         * With malicious guests, we really only care about pinning more
memory
> -         * than expected. RLIMIT_MEMLOCK set for the user/process can
never be
> -         * exceeded and can be used to mitigate this problem.
> -         */
> -        warn_report_once("Using vfio with vIOMMUs and coordinated
discarding of"
> -                         " RAM (e.g., virtio-mem) works, however,
malicious"
> -                         " guests can trigger pinning of more memory
than"
> -                         " intended via an IOMMU. It's possible to
mitigate "
> -                         " by setting/adjusting RLIMIT_MEMLOCK.");
> +    if (ret) {
> +        if (flag) {
> +            if (mr_flag & MRF_READONLY)
> +                *flag |=3D VFIO_MRF_READONLY;
> +
> +            if (mr_flag & MRF_RAMDEV)
> +                *flag |=3D VFIO_MRF_RAMDEV;
> +        }
> +
> +        if (mr_has_discard_manager) {
> +            /*
> +             * Malicious VMs might trigger discarding of IOMMU-mapped
memory. The
> +             * pages will remain pinned inside vfio until unmapped,
resulting in a
> +             * higher memory consumption than expected. If memory would
get
> +             * populated again later, there would be an inconsistency
between pages
> +             * pinned by vfio and pages seen by QEMU. This is the case
until
> +             * unmapped from the IOMMU (e.g., during device reset).
> +             *
> +             * With malicious guests, we really only care about pinning
more memory
> +             * than expected. RLIMIT_MEMLOCK set for the user/process
can never be
> +             * exceeded and can be used to mitigate this problem.
> +             */
> +            warn_report_once("Using vfio with vIOMMUs and coordinated
discarding of"
> +                             " RAM (e.g., virtio-mem) works, however,
malicious"
> +                             " guests can trigger pinning of more memory
than"
> +                             " intended via an IOMMU. It's possible to
mitigate "
> +                             " by setting/adjusting RLIMIT_MEMLOCK.");
> +        }
>      }
>      return ret;
>  }
> @@ -298,9 +309,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n,
IOMMUTLBEntry *iotlb)
>      rcu_read_lock();
>
>      if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> -        bool read_only;
> +        uint32_t flag =3D 0;
>
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only,
&local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &flag, &local_err))
{
>              error_report_err(local_err);
>              goto out;
>          }
> @@ -313,7 +324,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n,
IOMMUTLBEntry *iotlb)
>           */
>          ret =3D vfio_container_dma_map(bcontainer, iova,
>                                       iotlb->addr_mask + 1, vaddr,
> -                                     read_only);
> +                                     flag);
>          if (ret) {
>              error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx", %p) =3D %d (%s)",
> @@ -363,6 +374,7 @@ static int
vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                         int128_get64(section->size);
>      hwaddr start, next, iova;
>      void *vaddr;
> +    uint32_t flag =3D 0;
>      int ret;
>
>      /*
> @@ -377,8 +389,10 @@ static int
vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                 section->offset_within_address_space;
>          vaddr =3D memory_region_get_ram_ptr(section->mr) + start;
>
> +        flag |=3D section->readonly? VFIO_MRF_READONLY: 0;
> +        flag |=3D section->ram_device? VFIO_MRF_RAMDEV: 0;
>          ret =3D vfio_container_dma_map(bcontainer, iova, next - start,
> -                                     vaddr, section->readonly);
> +                                     vaddr, flag);
>          if (ret) {
>              /* Rollback */
>              vfio_ram_discard_notify_discard(rdl, section);
> @@ -563,6 +577,7 @@ static void vfio_listener_region_add(MemoryListener
*listener,
>      hwaddr iova, end;
>      Int128 llend, llsize;
>      void *vaddr;
> +    uint32_t flag =3D 0;
>      int ret;
>      Error *err =3D NULL;
>
> @@ -661,8 +676,10 @@ static void vfio_listener_region_add(MemoryListener
*listener,
>          }
>      }
>
> +    flag |=3D section->readonly? VFIO_MRF_READONLY: 0;
> +    flag |=3D section->ram_device? VFIO_MRF_RAMDEV: 0;
>      ret =3D vfio_container_dma_map(bcontainer, iova, int128_get64(llsize=
),
> -                                 vaddr, section->readonly);
> +                                 vaddr, flag);
>      if (ret) {
>          error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                     "0x%"HWADDR_PRIx", %p) =3D %d (%s)",
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 749a3fd29d..7cee2ac562 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -17,12 +17,12 @@
>
>  int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                             hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly)
> +                           void *vaddr, uint32_t flag)
>  {
>      VFIOIOMMUClass *vioc =3D VFIO_IOMMU_GET_CLASS(bcontainer);
>
>      g_assert(vioc->dma_map);
> -    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
> +    return vioc->dma_map(bcontainer, iova, size, vaddr, flag);
>  }
>
>  int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4ebb526808..90c32cd16d 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -176,7 +176,7 @@ static int vfio_legacy_dma_unmap(const
VFIOContainerBase *bcontainer,
>  }
>
>  static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer,
hwaddr iova,
> -                               ram_addr_t size, void *vaddr, bool
readonly)
> +                               ram_addr_t size, void *vaddr, uint32_t
flag)
>  {
>      const VFIOContainer *container =3D container_of(bcontainer,
VFIOContainer,
>                                                    bcontainer);
> @@ -188,9 +188,11 @@ static int vfio_legacy_dma_map(const
VFIOContainerBase *bcontainer, hwaddr iova,
>          .size =3D size,
>      };
>
> -    if (!readonly) {
> +    if (!(flag & VFIO_MRF_READONLY)) {
>          map.flags |=3D VFIO_DMA_MAP_FLAG_WRITE;
>      }
> +    if (flag & VFIO_MRF_RAMDEV)
> +        map.flags |=3D VFIO_DMA_MAP_FLAG_MMIO;
>
>      /*
>       * Try the mapping, if it fails with EBUSY, unmap the region and try
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3490a8f1eb..c773b45b5d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -28,14 +28,14 @@
>  #include "exec/ram_addr.h"
>
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr
iova,
> -                            ram_addr_t size, void *vaddr, bool readonly)
> +                            ram_addr_t size, void *vaddr, uint32_t flag)
>  {
>      const VFIOIOMMUFDContainer *container =3D
>          container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>
>      return iommufd_backend_map_dma(container->be,
>                                     container->ioas_id,
> -                                   iova, size, vaddr, readonly);
> +                                   iova, size, vaddr, flag &
VFIO_MRF_READONLY);
>  }
>
>  static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..dea733ef8a 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -226,15 +226,15 @@ static void
vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>
>      if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> -        bool read_only;
> +        uint32_t flag;
>
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &flag, NULL,
>                                    &local_err)) {
>              error_report_err(local_err);
>              return;
>          }
>          ret =3D vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
> -                                 iotlb->addr_mask + 1, vaddr, read_only)=
;
> +                                 iotlb->addr_mask + 1, vaddr, flag &
MRF_READONLY);
>          if (ret) {
>              error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
>                           "0x%" HWADDR_PRIx ", %p) =3D %d (%m)",
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9458e2801d..24405af0be 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -104,10 +104,15 @@ struct MemoryRegionSection {
>      hwaddr offset_within_region;
>      hwaddr offset_within_address_space;
>      bool readonly;
> +    bool ram_device;
>      bool nonvolatile;
>      bool unmergeable;
>  };
>
> +/* memory region flag */
> +#define MRF_READONLY 0x1
> +#define MRF_RAMDEV   0x2
> +
>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>
>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
> @@ -742,7 +747,7 @@ void
ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   * Return: true on success, else false setting @errp with error.
>   */
>  bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> +                          ram_addr_t *ram_addr, uint32_t *flag,
>                            bool *mr_has_discard_manager, Error **errp);
>
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 0c60be5b15..48018dc751 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -43,6 +43,10 @@ enum {
>      VFIO_DEVICE_TYPE_AP =3D 3,
>  };
>
> +/* vfio memory region flag */
> +#define VFIO_MRF_READONLY 0x1
> +#define VFIO_MRF_RAMDEV   0x2
> +
>  typedef struct VFIOMmap {
>      MemoryRegion mem;
>      void *mmap;
> diff --git a/include/hw/vfio/vfio-container-base.h
b/include/hw/vfio/vfio-container-base.h
> index 4cff9943ab..bb473e7201 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {
>
>  int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                             hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly);
> +                           void *vaddr, uint32_t flag);
>  int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                               hwaddr iova, ram_addr_t size,
>                               IOMMUTLBEntry *iotlb);
> @@ -113,7 +113,7 @@ struct VFIOIOMMUClass {
>      bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
>      int (*dma_map)(const VFIOContainerBase *bcontainer,
>                     hwaddr iova, ram_addr_t size,
> -                   void *vaddr, bool readonly);
> +                   void *vaddr, uint32_t flag);
>      int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                       hwaddr iova, ram_addr_t size,
>                       IOMMUTLBEntry *iotlb);
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 1b5e254d6a..4a32e70c33 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
>  #define VFIO_DMA_MAP_FLAG_READ (1 << 0)              /* readable from
device */
>  #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)     /* writable from device */
>  #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
> +#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)

Where's the kernel patch that implements the MMIO map flag.  That needs
to come first.

I also don't understand why we're creating multiple read-only and
ramdev flags to distill back into vfio mapping flags.  Thanks,

Alex

>       __u64   vaddr;                          /* Process virtual address
*/
>       __u64   iova;                           /* IO virtual address */
>       __u64   size;                           /* Size of mapping (bytes)
*/
> diff --git a/system/memory.c b/system/memory.c
> index b17b5538ff..71c54fc045 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -223,6 +223,7 @@ struct FlatRange {
>      uint8_t dirty_log_mask;
>      bool romd_mode;
>      bool readonly;
> +    bool ram_device;
>      bool nonvolatile;
>      bool unmergeable;
>  };
> @@ -240,6 +241,7 @@ section_from_flat_range(FlatRange *fr, FlatView *fv)
>          .size =3D fr->addr.size,
>          .offset_within_address_space =3D int128_get64(fr->addr.start),
>          .readonly =3D fr->readonly,
> +        .ram_device =3D fr->ram_device,
>          .nonvolatile =3D fr->nonvolatile,
>          .unmergeable =3D fr->unmergeable,
>      };
> @@ -252,6 +254,7 @@ static bool flatrange_equal(FlatRange *a, FlatRange
*b)
>          && a->offset_in_region =3D=3D b->offset_in_region
>          && a->romd_mode =3D=3D b->romd_mode
>          && a->readonly =3D=3D b->readonly
> +        && a->ram_device =3D=3D b->ram_device
>          && a->nonvolatile =3D=3D b->nonvolatile
>          && a->unmergeable =3D=3D b->unmergeable;
>  }
> @@ -657,6 +660,7 @@ static void render_memory_region(FlatView *view,
>      fr.dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
>      fr.romd_mode =3D mr->romd_mode;
>      fr.readonly =3D readonly;
> +    fr.ram_device =3D mr->ram_device;
>      fr.nonvolatile =3D nonvolatile;
>      fr.unmergeable =3D unmergeable;
>
> @@ -2184,7 +2188,7 @@ void
ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>
>  /* Called with rcu_read_lock held.  */
>  bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> +                          ram_addr_t *ram_addr, uint32_t *flag,
>                            bool *mr_has_discard_manager, Error **errp)
>  {
>      MemoryRegion *mr;
> @@ -2246,8 +2250,9 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb,
void **vaddr,
>          *ram_addr =3D memory_region_get_ram_addr(mr) + xlat;
>      }
>
> -    if (read_only) {
> -        *read_only =3D !writable || mr->readonly;
> +    if (flag) {
> +        *flag |=3D (!writable || mr->readonly)? MRF_READONLY: 0;
> +        *flag |=3D mr->ram_device? MRF_RAMDEV: 0;
>      }
>
>      return true;

--00000000000009216e062be52c96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div lang=3D"en-CN" link=3D"blue" vlink=3D"purple" style=3D"word-=
wrap:break-word"><div><div><div><p class=3D"MsoNormal">hi, Alex</p></div><d=
iv><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p class=3D"Ms=
oNormal">&gt; Where&#39;s the kernel patch that implements the MMIO map fla=
g.=C2=A0 That needs<br>&gt; to come first.</p></div><div><p class=3D"MsoNor=
mal"><u></u>=C2=A0<u></u></p></div><div><p class=3D"MsoNormal">The kernel p=
atch=C2=A0is on the way, I have submitted patch to linux kernel, waiting fo=
r review.</p><p class=3D"MsoNormal">Patch link: <a href=3D"https://lore.ker=
nel.org/all/20250117071423.469880-1-east.moutain.yang@gmail.com/" target=3D=
"_blank">https://lore.kernel.org/all/20250117071423.469880-1-east.moutain.y=
ang@gmail.com/</a><br><br>&gt; I also don&#39;t understand why we&#39;re cr=
eating multiple read-only and<br>&gt; ramdev flags to distill back into vfi=
o mapping flags.=C2=A0 Thanks,</p><p class=3D"MsoNormal"><u></u>=C2=A0<u></=
u></p><p class=3D"MsoNormal">Read-only is one of memroy access attributes, =
page table entry has corresponding bit for page R/W.</p><p class=3D"MsoNorm=
al">There is another bit on page table entry to control whether the page sh=
ould be encrypted or</p><p class=3D"MsoNormal">decrypted when writing to or=
 read from the page, this is usually done by hardware engine in memory</p><=
p class=3D"MsoNormal">controller according to the encrytion bit in bus addr=
ess. The actual physical address will not include</p><p class=3D"MsoNormal"=
>encryption bit when the it reaches to real DRAM.</p><p class=3D"MsoNormal"=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 </p><p class=3D"MsoNormal">|CPU| ---va---| page table |---enc+pa-=
--| mem ctrl |---pa---| DRAM | </p><p class=3D"MsoNormal"><u></u>=C2=A0<u><=
/u></p><p class=3D"MsoNormal">When it comes to perpherial device mmio memor=
y, access the other device=E2=80=99s mmio memory, </p><p class=3D"MsoNormal=
">The memory controller is not get involved,=C2=A0 so the encryption bit is=
 carried to dest physical</p><p class=3D"MsoNormal">address, which is not e=
xpected.</p><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><p class=3D"MsoN=
ormal">| devA |---iova---|io page table|---enc+pa---X---|devB|=C2=A0 =C2=A0=
&lt;-- incorrect pa</p><p class=3D"MsoNormal">| devA |---iova---|io page ta=
ble|---pa---|devB|=C2=A0 =C2=A0&lt;-- correct pa</p><p class=3D"MsoNormal">=
<u></u>=C2=A0<u></u></p><p class=3D"MsoNormal">Here I use ramdev flag to te=
ll IOMMU driver the memory range is device mmio, so</p><p class=3D"MsoNorma=
l">that IOMMU dirver will not set encryption bit on IOMMU page table entry.=
</p><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><p class=3D"MsoNormal">T=
hanks.</p></div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><div><div><p=
 class=3D"MsoNormal">On Fri, Jan 17, 2025 at 1:47<span style=3D"font-family=
:&quot;Arial&quot;,sans-serif">=E2=80=AF</span>AM Alex Williamson &lt;<a hr=
ef=3D"mailto:alex.williamson@redhat.com" target=3D"_blank">alex.williamson@=
redhat.com</a>&gt; wrote:</p></div><blockquote style=3D"border:none;border-=
left:solid #cccccc 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin=
-right:0cm"><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On Thu, 1=
6 Jan 2025 17:53:55 +0800<br>Wencheng Yang &lt;<a href=3D"mailto:east.mouta=
in.yang@gmail.com" target=3D"_blank">east.moutain.yang@gmail.com</a>&gt; wr=
ote:<br><br>&gt; On confidential VM platform, for example, AMD-SEV, P2P doe=
sn&#39;t work.<br>&gt; The underlying reason is that IOMMU driver set encry=
ption bit on<br>&gt; IOMMU page table pte entry, it&#39;s reasonalbe if the=
 pte maps iova<br>&gt; to system memory. However, if the pte maps iova to d=
evice&#39;s<br>&gt; mmio bar space, setting encryption bit on pte would cau=
se IOMMU<br>&gt; translates iova to incorrect bus address, rather than mmio=
 bar<br>&gt; address.<br>&gt; <br>&gt; To fix the issue, the key point is t=
o let IOMMU driver know the<br>&gt; target phyical address is system memory=
 or device mmio.<br>&gt; <br>&gt; VFIO allocates virtual address and maps i=
t to device mmio bar,<br>&gt; the member @ram_device of MemoryRegion indica=
tes the memory<br>&gt; region is for mmio. The patch passes the info to VFI=
O DAM API,<br>&gt; IOMMU driver would do the correct thing.<br>&gt; <br>&gt=
; Signed-off-by: Wencheng Yang &lt;<a href=3D"mailto:east.moutain.yang@gmai=
l.com" target=3D"_blank">east.moutain.yang@gmail.com</a>&gt;<br>&gt; ---<br=
>&gt;=C2=A0 hw/vfio/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 67 +++++++++++++++++----------<br>&gt;=C2=
=A0 hw/vfio/container-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 4 +-<br>&gt;=C2=A0 hw/vfio/container.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++-<br>&gt;=C2=A0 hw=
/vfio/iommufd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>&gt;=C2=A0 hw/virtio/vhost-vdpa.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +--<br>&gt;=C2=
=A0 include/exec/memory.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 7 ++-<br>&gt;=C2=A0 include/hw/vfio/vfio-common.h=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++<br>&gt;=C2=A0 include/hw/vfio/v=
fio-container-base.h |=C2=A0 4 +-<br>&gt;=C2=A0 linux-headers/linux/vfio.h=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>&gt;=C2=A0 system/=
memory.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 11 +++--<br>&gt;=C2=A0 10 files changed, 74 insertions(+=
), 40 deletions(-)<br>&gt; <br>&gt; diff --git a/hw/vfio/common.c b/hw/vfio=
/common.c<br>&gt; index f7499a9b74..2660a42f9e 100644<br>&gt; --- a/hw/vfio=
/common.c<br>&gt; +++ b/hw/vfio/common.c<br>&gt; @@ -247,31 +247,42 @@ stat=
ic bool vfio_listener_skipped_section(MemoryRegionSection *section)<br>&gt;=
=C2=A0 <br>&gt;=C2=A0 /* Called with rcu_read_lock held.=C2=A0 */<br>&gt;=
=C2=A0 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,<b=
r>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_addr_t *ram_addr, bool *re=
ad_only,<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_addr_t *ram_addr=
, uint32_t *flag,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error =
**errp)<br>&gt;=C2=A0 {<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool ret, mr_has_discar=
d_manager;<br>&gt; +=C2=A0 =C2=A0 uint32_t mr_flag =3D 0;<br>&gt;=C2=A0 <br=
>&gt; -=C2=A0 =C2=A0 ret =3D memory_get_xlat_addr(iotlb, vaddr, ram_addr, r=
ead_only,<br>&gt; +=C2=A0 =C2=A0 ret =3D memory_get_xlat_addr(iotlb, vaddr,=
 ram_addr, &amp;mr_flag,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;mr_has_discard_manager, errp);<br>&gt; -=C2=A0 =C2=A0 if (ret &amp;=
&amp; mr_has_discard_manager) {<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>=
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Malicious VMs might trigger disca=
rding of IOMMU-mapped memory. The<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* pages will remain pinned inside vfio until unmapped, resulting in a<br=
>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* higher memory consumption than e=
xpected. If memory would get<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* p=
opulated again later, there would be an inconsistency between pages<br>&gt;=
 -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* pinned by vfio and pages seen by QEMU=
. This is the case until<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* unmap=
ped from the IOMMU (e.g., during device reset).<br>&gt; -=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* With malici=
ous guests, we really only care about pinning more memory<br>&gt; -=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* than expected. RLIMIT_MEMLOCK set for the user=
/process can never be<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* exceeded=
 and can be used to mitigate this problem.<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*/<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot=
;Using vfio with vIOMMUs and coordinated discarding of&quot;<br>&gt; -=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot; RAM (e.g., virtio-mem) works, however, malicious&quot;<=
br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot; guests can trigger pinning of more memory th=
an&quot;<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; intended via an IOMMU. It&#39;s po=
ssible to mitigate &quot;<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; by setting/adjus=
ting RLIMIT_MEMLOCK.&quot;);<br>&gt; +=C2=A0 =C2=A0 if (ret) {<br>&gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (flag) {<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (mr_flag &amp; MRF_READONLY)<br>&gt; +=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flag |=3D VFIO_MRF_READONLY;<br>&gt; +=
<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mr_flag &amp; MRF_R=
AMDEV)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *fl=
ag |=3D VFIO_MRF_RAMDEV;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; +<b=
r>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mr_has_discard_manager) {<br>&gt; +=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* Malicious VMs might trigger discarding of IOMM=
U-mapped memory. The<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* pages will remain pinned inside vfio until unmapped, resulting in a<br=
>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* higher memory cons=
umption than expected. If memory would get<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* populated again later, there would be an incon=
sistency between pages<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* pinned by vfio and pages seen by QEMU. This is the case until<br>&g=
t; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* unmapped from the IOM=
MU (e.g., during device reset).<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
With malicious guests, we really only care about pinning more memory<br>&gt=
; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* than expected. RLIMIT_=
MEMLOCK set for the user/process can never be<br>&gt; +=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0* exceeded and can be used to mitigate this pro=
blem.<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>&gt; +=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot;Using vfio=
 with vIOMMUs and coordinated discarding of&quot;<br>&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot; RAM (e.g., virtio-mem) works, however, malicious&qu=
ot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; guests can trigger pinning=
 of more memory than&quot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; in=
tended via an IOMMU. It&#39;s possible to mitigate &quot;<br>&gt; +=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot; by setting/adjusting RLIMIT_MEMLOCK.&quot;);=
<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;=C2=A0 =C2=A0 =C2=A0 }<br>&g=
t;=C2=A0 =C2=A0 =C2=A0 return ret;<br>&gt;=C2=A0 }<br>&gt; @@ -298,9 +309,9=
 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotl=
b)<br>&gt;=C2=A0 =C2=A0 =C2=A0 rcu_read_lock();<br>&gt;=C2=A0 <br>&gt;=C2=
=A0 =C2=A0 =C2=A0 if ((iotlb-&gt;perm &amp; IOMMU_RW) !=3D IOMMU_NONE) {<br=
>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool read_only;<br>&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t flag =3D 0;<br>&gt;=C2=A0 <br>&gt; -=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (!vfio_get_xlat_addr(iotlb, &amp;vaddr, NULL, &amp;read_on=
ly, &amp;local_err)) {<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vfio_get_x=
lat_addr(iotlb, &amp;vaddr, NULL, &amp;flag, &amp;local_err)) {<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<=
br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; @@ -313,7 +324,7 @@ static voi=
d vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D vfio_container_dma_map(bcontainer, iova,<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb-&gt;addr_mask =
+ 1, vaddr,<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0read_only);<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0flag);<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>&g=
t;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;vfio_=
container_dma_map(%p, 0x%&quot;HWADDR_PRIx&quot;, &quot;<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;0x%&quot;HWADDR_PRIx&quot;, %p) =3D %d (%s)&quot;,<br>&g=
t; @@ -363,6 +374,7 @@ static int vfio_ram_discard_notify_populate(RamDisca=
rdListener *rdl,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int128_get64(section-&gt;size);<br=
>&gt;=C2=A0 =C2=A0 =C2=A0 hwaddr start, next, iova;<br>&gt;=C2=A0 =C2=A0 =
=C2=A0 void *vaddr;<br>&gt; +=C2=A0 =C2=A0 uint32_t flag =3D 0;<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 int ret;<br>&gt;=C2=A0 <br>&gt;=C2=A0 =C2=A0 =C2=A0 /*<br=
>&gt; @@ -377,8 +389,10 @@ static int vfio_ram_discard_notify_populate(RamD=
iscardListener *rdl,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0section-&gt;offset_within_address_space;<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vaddr =3D memory_region_get_ram_ptr(section-&gt;mr=
) + start;<br>&gt;=C2=A0 <br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D se=
ction-&gt;readonly? VFIO_MRF_READONLY: 0;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 flag |=3D section-&gt;ram_device? VFIO_MRF_RAMDEV: 0;<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vfio_container_dma_map(bcontainer, iova, n=
ext - start,<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vaddr, section-&gt;readonly);<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vaddr, flag);<br>&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (ret) {<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Rollback */<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vfio_ram_discard_notify_discard(rdl, section);<br>&gt; @@ -563,6 +577,7=
 @@ static void vfio_listener_region_add(MemoryListener *listener,<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 hwaddr iova, end;<br>&gt;=C2=A0 =C2=A0 =C2=A0 Int128 l=
lend, llsize;<br>&gt;=C2=A0 =C2=A0 =C2=A0 void *vaddr;<br>&gt; +=C2=A0 =C2=
=A0 uint32_t flag =3D 0;<br>&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>&gt;=C2=A0=
 =C2=A0 =C2=A0 Error *err =3D NULL;<br>&gt;=C2=A0 <br>&gt; @@ -661,8 +676,1=
0 @@ static void vfio_listener_region_add(MemoryListener *listener,<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;=C2=A0 =C2=A0 =C2=A0 }<br>&gt;=
=C2=A0 <br>&gt; +=C2=A0 =C2=A0 flag |=3D section-&gt;readonly? VFIO_MRF_REA=
DONLY: 0;<br>&gt; +=C2=A0 =C2=A0 flag |=3D section-&gt;ram_device? VFIO_MRF=
_RAMDEV: 0;<br>&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D vfio_container_dma_map(bcon=
tainer, iova, int128_get64(llsize),<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0vaddr, section-&gt;readonly);<br>&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0vaddr, flag);<br>&gt;=C2=A0 =C2=A0 =C2=A0 if (re=
t) {<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;err, &quot;v=
fio_container_dma_map(%p, 0x%&quot;HWADDR_PRIx&quot;, &quot;<br>&gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
0x%&quot;HWADDR_PRIx&quot;, %p) =3D %d (%s)&quot;,<br>&gt; diff --git a/hw/=
vfio/container-base.c b/hw/vfio/container-base.c<br>&gt; index 749a3fd29d..=
7cee2ac562 100644<br>&gt; --- a/hw/vfio/container-base.c<br>&gt; +++ b/hw/v=
fio/container-base.c<br>&gt; @@ -17,12 +17,12 @@<br>&gt;=C2=A0 <br>&gt;=C2=
=A0 int vfio_container_dma_map(VFIOContainerBase *bcontainer,<br>&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0hwaddr iova, ram_addr_t size,<br>&gt; -=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0void *vaddr, bool readonly)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vo=
id *vaddr, uint32_t flag)<br>&gt;=C2=A0 {<br>&gt;=C2=A0 =C2=A0 =C2=A0 VFIOI=
OMMUClass *vioc =3D VFIO_IOMMU_GET_CLASS(bcontainer);<br>&gt;=C2=A0 <br>&gt=
;=C2=A0 =C2=A0 =C2=A0 g_assert(vioc-&gt;dma_map);<br>&gt; -=C2=A0 =C2=A0 re=
turn vioc-&gt;dma_map(bcontainer, iova, size, vaddr, readonly);<br>&gt; +=
=C2=A0 =C2=A0 return vioc-&gt;dma_map(bcontainer, iova, size, vaddr, flag);=
<br>&gt;=C2=A0 }<br>&gt;=C2=A0 <br>&gt;=C2=A0 int vfio_container_dma_unmap(=
VFIOContainerBase *bcontainer,<br>&gt; diff --git a/hw/vfio/container.c b/h=
w/vfio/container.c<br>&gt; index 4ebb526808..90c32cd16d 100644<br>&gt; --- =
a/hw/vfio/container.c<br>&gt; +++ b/hw/vfio/container.c<br>&gt; @@ -176,7 +=
176,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontain=
er,<br>&gt;=C2=A0 }<br>&gt;=C2=A0 <br>&gt;=C2=A0 static int vfio_legacy_dma=
_map(const VFIOContainerBase *bcontainer, hwaddr iova,<br>&gt; -=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ram_addr_t size, void *vaddr, bool readonly)<br>=
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_addr_t size, void *vaddr, uin=
t32_t flag)<br>&gt;=C2=A0 {<br>&gt;=C2=A0 =C2=A0 =C2=A0 const VFIOContainer=
 *container =3D container_of(bcontainer, VFIOContainer,<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bcontainer);<br>&gt; @@ -188,9 +188,11 @@ static i=
nt vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,<br=
>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D size,<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 };<br>&gt;=C2=A0 <br>&gt; -=C2=A0 =C2=A0 if (!readonly) {<br>&gt=
; +=C2=A0 =C2=A0 if (!(flag &amp; VFIO_MRF_READONLY)) {<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 map.flags |=3D VFIO_DMA_MAP_FLAG_WRITE;<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 }<br>&gt; +=C2=A0 =C2=A0 if (flag &amp; VFIO_MRF_RAMDEV)<=
br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 map.flags |=3D VFIO_DMA_MAP_FLAG_MMIO;=
<br>&gt;=C2=A0 <br>&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0* Try the mapping, if it fails with EBUSY, unmap the region and try<b=
r>&gt; diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c<br>&gt; index 349=
0a8f1eb..c773b45b5d 100644<br>&gt; --- a/hw/vfio/iommufd.c<br>&gt; +++ b/hw=
/vfio/iommufd.c<br>&gt; @@ -28,14 +28,14 @@<br>&gt;=C2=A0 #include &quot;ex=
ec/ram_addr.h&quot;<br>&gt;=C2=A0 <br>&gt;=C2=A0 static int iommufd_cdev_ma=
p(const VFIOContainerBase *bcontainer, hwaddr iova,<br>&gt; -=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ram_addr_t size, void *vaddr, bool readonly)<br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ram_addr_t size, void *vaddr, uint32_t flag)<br>&gt;=C2=A0 {<=
br>&gt;=C2=A0 =C2=A0 =C2=A0 const VFIOIOMMUFDContainer *container =3D<br>&g=
t;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(bcontainer, VFIOIOMMUFDCo=
ntainer, bcontainer);<br>&gt;=C2=A0 <br>&gt;=C2=A0 =C2=A0 =C2=A0 return iom=
mufd_backend_map_dma(container-&gt;be,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0container-&gt;ioas_id,<br>&gt; -=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova, size, vaddr, readonly);<br>&=
gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova, size, vaddr, f=
lag &amp; VFIO_MRF_READONLY);<br>&gt;=C2=A0 }<br>&gt;=C2=A0 <br>&gt;=C2=A0 =
static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,<br>&gt; =
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c<br>&gt; index =
3cdaa12ed5..dea733ef8a 100644<br>&gt; --- a/hw/virtio/vhost-vdpa.c<br>&gt; =
+++ b/hw/virtio/vhost-vdpa.c<br>&gt; @@ -226,15 +226,15 @@ static void vhos=
t_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 }<br>&gt;=C2=A0 <br>&gt;=C2=A0 =C2=A0 =C2=A0 if ((iotlb-&=
gt;perm &amp; IOMMU_RW) !=3D IOMMU_NONE) {<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool read_only;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t flag;<=
br>&gt;=C2=A0 <br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!memory_get_xlat_ad=
dr(iotlb, &amp;vaddr, NULL, &amp;read_only, NULL,<br>&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (!memory_get_xlat_addr(iotlb, &amp;vaddr, NULL, &amp;flag,=
 NULL,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;loc=
al_err)) {<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_re=
port_err(local_err);<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_=
ASID, iova,<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb-&gt=
;addr_mask + 1, vaddr, read_only);<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0iotlb-&gt;addr_mask + 1, vaddr, flag &amp; MRF_READONLY);<br>&=
gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;vhost_vdpa_dma_map(%p, 0=
x%&quot; HWADDR_PRIx &quot;, &quot;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;0x%=
&quot; HWADDR_PRIx &quot;, %p) =3D %d (%m)&quot;,<br>&gt; diff --git a/incl=
ude/exec/memory.h b/include/exec/memory.h<br>&gt; index 9458e2801d..24405af=
0be 100644<br>&gt; --- a/include/exec/memory.h<br>&gt; +++ b/include/exec/m=
emory.h<br>&gt; @@ -104,10 +104,15 @@ struct MemoryRegionSection {<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 hwaddr offset_within_region;<br>&gt;=C2=A0 =C2=A0 =C2=
=A0 hwaddr offset_within_address_space;<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool re=
adonly;<br>&gt; +=C2=A0 =C2=A0 bool ram_device;<br>&gt;=C2=A0 =C2=A0 =C2=A0=
 bool nonvolatile;<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool unmergeable;<br>&gt;=C2=
=A0 };<br>&gt;=C2=A0 <br>&gt; +/* memory region flag */<br>&gt; +#define MR=
F_READONLY 0x1<br>&gt; +#define MRF_RAMDEV=C2=A0 =C2=A00x2<br>&gt; +<br>&gt=
;=C2=A0 typedef struct IOMMUTLBEntry IOMMUTLBEntry;<br>&gt;=C2=A0 <br>&gt;=
=C2=A0 /* See address_space_translate: bit 0 is read, bit 1 is write.=C2=A0=
 */<br>&gt; @@ -742,7 +747,7 @@ void ram_discard_manager_unregister_listene=
r(RamDiscardManager *rdm,<br>&gt;=C2=A0 =C2=A0* Return: true on success, el=
se false setting @errp with error.<br>&gt;=C2=A0 =C2=A0*/<br>&gt;=C2=A0 boo=
l memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,<br>&gt; -=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ram_addr_t *ram_addr, bool *read_only,<br>&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ram_addr_t *ram_addr, uint32_t *flag,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ool *mr_has_discard_manager, Error **errp);<br>&gt;=C2=A0 <br>&gt;=C2=A0 ty=
pedef struct CoalescedMemoryRange CoalescedMemoryRange;<br>&gt; diff --git =
a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h<br>&gt; ind=
ex 0c60be5b15..48018dc751 100644<br>&gt; --- a/include/hw/vfio/vfio-common.=
h<br>&gt; +++ b/include/hw/vfio/vfio-common.h<br>&gt; @@ -43,6 +43,10 @@ en=
um {<br>&gt;=C2=A0 =C2=A0 =C2=A0 VFIO_DEVICE_TYPE_AP =3D 3,<br>&gt;=C2=A0 }=
;<br>&gt;=C2=A0 <br>&gt; +/* vfio memory region flag */<br>&gt; +#define VF=
IO_MRF_READONLY 0x1<br>&gt; +#define VFIO_MRF_RAMDEV=C2=A0 =C2=A00x2<br>&gt=
; +<br>&gt;=C2=A0 typedef struct VFIOMmap {<br>&gt;=C2=A0 =C2=A0 =C2=A0 Mem=
oryRegion mem;<br>&gt;=C2=A0 =C2=A0 =C2=A0 void *mmap;<br>&gt; diff --git a=
/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-bas=
e.h<br>&gt; index 4cff9943ab..bb473e7201 100644<br>&gt; --- a/include/hw/vf=
io/vfio-container-base.h<br>&gt; +++ b/include/hw/vfio/vfio-container-base.=
h<br>&gt; @@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {<br>&gt;=
=C2=A0 <br>&gt;=C2=A0 int vfio_container_dma_map(VFIOContainerBase *bcontai=
ner,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr iova, ram_addr_t size,<br>&=
gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0void *vaddr, bool readonly);<br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0void *vaddr, uint32_t flag);<br>&gt;=C2=A0 int vfio_container_=
dma_unmap(VFIOContainerBase *bcontainer,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hwaddr iova, ram_addr_t size,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0IOMMUTLBEntry *iotlb);<br>&gt; @@ -113,7 +113,7 @@ struct VFIOIOM=
MUClass {<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool (*setup)(VFIOContainerBase *bcon=
tainer, Error **errp);<br>&gt;=C2=A0 =C2=A0 =C2=A0 int (*dma_map)(const VFI=
OContainerBase *bcontainer,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr iova, ram_addr_t size,<br>&gt;=
 -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void=
 *vaddr, bool readonly);<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *vaddr, uint32_t flag);<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 int (*dma_unmap)(const VFIOContainerBase *bcontainer,<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0hwaddr iova, ram_addr_t size,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOMMUTLBEntry *iotlb);<=
br>&gt; diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.=
h<br>&gt; index 1b5e254d6a..4a32e70c33 100644<br>&gt; --- a/linux-headers/l=
inux/vfio.h<br>&gt; +++ b/linux-headers/linux/vfio.h<br>&gt; @@ -1560,6 +15=
60,7 @@ struct vfio_iommu_type1_dma_map {<br>&gt;=C2=A0 #define VFIO_DMA_MA=
P_FLAG_READ (1 &lt;&lt; 0)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* readable from device */<br>&gt;=C2=A0 #define VFIO_DMA_MAP_FLAG_WRITE (1=
 &lt;&lt; 1)=C2=A0 =C2=A0 =C2=A0/* writable from device */<br>&gt;=C2=A0 #d=
efine VFIO_DMA_MAP_FLAG_VADDR (1 &lt;&lt; 2)<br>&gt; +#define VFIO_DMA_MAP_=
FLAG_MMIO (1 &lt;&lt; 3)<br><br>Where&#39;s the kernel patch that implement=
s the MMIO map flag.=C2=A0 That needs<br>to come first.<br><br>I also don&#=
39;t understand why we&#39;re creating multiple read-only and<br>ramdev fla=
gs to distill back into vfio mapping flags.=C2=A0 Thanks,<br><br>Alex<br><b=
r>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64=C2=A0 =C2=A0vaddr;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* Process virtual address */<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64=C2=A0 =
=C2=A0iova;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* IO virtual address */<br>&gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0__u64=C2=A0 =C2=A0size;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Size o=
f mapping (bytes) */<br>&gt; diff --git a/system/memory.c b/system/memory.c=
<br>&gt; index b17b5538ff..71c54fc045 100644<br>&gt; --- a/system/memory.c<=
br>&gt; +++ b/system/memory.c<br>&gt; @@ -223,6 +223,7 @@ struct FlatRange =
{<br>&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t dirty_log_mask;<br>&gt;=C2=A0 =C2=A0 =
=C2=A0 bool romd_mode;<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool readonly;<br>&gt; +=
=C2=A0 =C2=A0 bool ram_device;<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool nonvolatile=
;<br>&gt;=C2=A0 =C2=A0 =C2=A0 bool unmergeable;<br>&gt;=C2=A0 };<br>&gt; @@=
 -240,6 +241,7 @@ section_from_flat_range(FlatRange *fr, FlatView *fv)<br>&=
gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D fr-&gt;addr.size,<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset_within_address_space =3D int128_=
get64(fr-&gt;addr.start),<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .readon=
ly =3D fr-&gt;readonly,<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ram_device =
=3D fr-&gt;ram_device,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .nonvolati=
le =3D fr-&gt;nonvolatile,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .unmer=
geable =3D fr-&gt;unmergeable,<br>&gt;=C2=A0 =C2=A0 =C2=A0 };<br>&gt; @@ -2=
52,6 +254,7 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)<br>&=
gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; a-&gt;offset_in_region =3D=
=3D b-&gt;offset_in_region<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&=
amp; a-&gt;romd_mode =3D=3D b-&gt;romd_mode<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;&amp; a-&gt;readonly =3D=3D b-&gt;readonly<br>&gt; +=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;&amp; a-&gt;ram_device =3D=3D b-&gt;ram_device<br=
>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; a-&gt;nonvolatile =3D=3D=
 b-&gt;nonvolatile<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; a-&=
gt;unmergeable =3D=3D b-&gt;unmergeable;<br>&gt;=C2=A0 }<br>&gt; @@ -657,6 =
+660,7 @@ static void render_memory_region(FlatView *view,<br>&gt;=C2=A0 =
=C2=A0 =C2=A0 fr.dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);<b=
r>&gt;=C2=A0 =C2=A0 =C2=A0 fr.romd_mode =3D mr-&gt;romd_mode;<br>&gt;=C2=A0=
 =C2=A0 =C2=A0 fr.readonly =3D readonly;<br>&gt; +=C2=A0 =C2=A0 fr.ram_devi=
ce =3D mr-&gt;ram_device;<br>&gt;=C2=A0 =C2=A0 =C2=A0 fr.nonvolatile =3D no=
nvolatile;<br>&gt;=C2=A0 =C2=A0 =C2=A0 fr.unmergeable =3D unmergeable;<br>&=
gt;=C2=A0 <br>&gt; @@ -2184,7 +2188,7 @@ void ram_discard_manager_unregiste=
r_listener(RamDiscardManager *rdm,<br>&gt;=C2=A0 <br>&gt;=C2=A0 /* Called w=
ith rcu_read_lock held.=C2=A0 */<br>&gt;=C2=A0 bool memory_get_xlat_addr(IO=
MMUTLBEntry *iotlb, void **vaddr,<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr_t *ram=
_addr, bool *read_only,<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr_t *ram_addr, uint=
32_t *flag,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *mr_has_discard_manager, Err=
or **errp)<br>&gt;=C2=A0 {<br>&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr;<br=
>&gt; @@ -2246,8 +2250,9 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb,=
 void **vaddr,<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ram_addr =3D memo=
ry_region_get_ram_addr(mr) + xlat;<br>&gt;=C2=A0 =C2=A0 =C2=A0 }<br>&gt;=C2=
=A0 <br>&gt; -=C2=A0 =C2=A0 if (read_only) {<br>&gt; -=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *read_only =3D !writable || mr-&gt;readonly;<br>&gt; +=C2=A0 =C2=A0 =
if (flag) {<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flag |=3D (!writable || m=
r-&gt;readonly)? MRF_READONLY: 0;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fla=
g |=3D mr-&gt;ram_device? MRF_RAMDEV: 0;<br>&gt;=C2=A0 =C2=A0 =C2=A0 }<br>&=
gt;=C2=A0 <br>&gt;=C2=A0 =C2=A0 =C2=A0 return true;</p></blockquote></div><=
/div></div></div></div>
</div>
</div>
</div>
</div>

--00000000000009216e062be52c96--

