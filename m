Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E156D6D25A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 03:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGV3v-0007nF-69; Wed, 27 Nov 2024 22:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@gmail.com>)
 id 1tGV3t-0007mw-GQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 22:19:25 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@gmail.com>)
 id 1tGV3r-0007pg-Ar
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 22:19:25 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea1c453f0eso325082a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 19:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732763961; x=1733368761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYv1eUv3BGm49nW/KdfOLSrjJ7+sMkpuRG/sftEq2IY=;
 b=PyVzOFEP8yBbOcXLp4SKJrZN514wqUb0aMvlJE0uLfr7x9utMMsr2EFTrf/YXA/MMl
 7bT5ImdxzteYW40J2HVRI4Ma/bxmI+a9OFehvoSZc55TFh8ezYUpiGPGO8mbGLzqM7J3
 8hmpIQCJHHCgxpXuh2uY1OZuZOcNY1ZFKfPtg/t8NuyoGXmllXHqOpeeBOi1WY1WGZVg
 ylyYyetm9XMQftASnGBKFHXxxulfRMGzIvdvZSScGcyA5drb5R8NkVIa8VXSZ/B79Efp
 2opjDxxWn8wfuwDo+WDJ6ylZGF9xNTpqKJmmoycQKHtwFDZ5Vn5MgxqjabaVYhWMNgs3
 Gtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732763961; x=1733368761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYv1eUv3BGm49nW/KdfOLSrjJ7+sMkpuRG/sftEq2IY=;
 b=H1BSgW2dyS/HqpOxFdVCz+Y/nk6lA74UL2cfdZn0mc4iyLow96RpUswv85a0pnpoMm
 lOQtkSqCGaq8IbYUdIBRN/9d3PxyVSlxKEZZZECZthAIly93DXShYWJxfdQbWkOUP752
 Jt4mFY7wbkIkbhT0qEpbJ7LXgYYjpzpk5hp0r12NlCiOwJxUGZUP4nLyTWxqEYfyC48d
 DdHjQxK3d7O0QMPF127DZdtiw2CMb+VgdihL7CD02wgmEKmWxjI06HUGFNbl1HshfOCR
 zAE1CudRi0ZRkg1zNckdkhm3lDZ/pumsx8PFmByeiUGo8yEKC0qZ1SpeoNHcNwIq9FAz
 0EtA==
X-Gm-Message-State: AOJu0YxsFabnA9VhhkXJqTLaA7wALq9NNRGOH7/xhUccqtFKlDngFFA3
 v7AK9dT00JGhTNs236bHHWeu8OBtJYaC2PwbB9cNhL2D+dM6p/CQlfRCLDOSYHOi8DDnGPhSXfU
 MMtDwGALnF5VSpjIxCPhE304j9gc=
X-Gm-Gg: ASbGncvGl9d1GpXdla3shYnUcr6Fem4GdbxRkzbROo3Na1Lj61bQ/sfXImvsfj6A0fR
 84D1b26zEAyav37qRDCkBjk6U50ch
X-Google-Smtp-Source: AGHT+IHkKHpqB5BRnp6ODwqJbhO/9bYxXLg/kCsc3WJhEt7dGlbRq4x4z1Cn2OnuKNo9DRWmasaS7MWtD/Ut/UPru4M=
X-Received: by 2002:a17:90b:3886:b0:2ea:476d:9da with SMTP id
 98e67ed59e1d1-2ee097bf3ccmr6001205a91.26.1732763960013; Wed, 27 Nov 2024
 19:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Thu, 28 Nov 2024 11:19:07 +0800
Message-ID: <CAMj5Bki5gaHrOnj=JSrv3nmva6N2Y2OrDB7sE03WQHkqyXSheQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=zhangfei.gao@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Joao

On Fri, Jun 23, 2023 at 5:51=E2=80=AFAM Joao Martins <joao.m.martins@oracle=
.com> wrote:
>
> Hey,
>
> This series introduces support for vIOMMU with VFIO device migration,
> particurlarly related to how we do the dirty page tracking.
>
> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
> provide dma translation services for guests to provide some form of
> guest kernel managed DMA e.g. for nested virt based usage; (1) is special=
ly
> required for big VMs with VFs with more than 255 vcpus. We tackle both
> and remove the migration blocker when vIOMMU is present provided the
> conditions are met. I have both use-cases here in one series, but I am ha=
ppy
> to tackle them in separate series.
>
> As I found out we don't necessarily need to expose the whole vIOMMU
> functionality in order to just support interrupt remapping. x86 IOMMUs
> on Windows Server 2018[2] and Linux >=3D5.10, with qemu 7.1+ (or really
> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
> can instantiate a IOMMU just for interrupt remapping without needing to
> be advertised/support DMA translation. AMD IOMMU in theory can provide
> the same, but Linux doesn't quite support the IR-only part there yet,
> only intel-iommu.
>
> The series is organized as following:
>
> Patches 1-5: Today we can't gather vIOMMU details before the guest
> establishes their first DMA mapping via the vIOMMU. So these first four
> patches add a way for vIOMMUs to be asked of their properties at start
> of day. I choose the least churn possible way for now (as opposed to a
> treewide conversion) and allow easy conversion a posteriori. As
> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
> allows us to fetch PCI backing vIOMMU attributes, without necessarily
> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
> was doing in v3.
>
> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
> DMA translation allowed. Today the 'dma-translation' attribute is
> x86-iommu only, but the way this series is structured nothing stops from
> other vIOMMUs supporting it too as long as they use
> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
> the toggle/report DMA_TRANSLATION attribute. With the patches up to this =
set,
> we've then tackled item (1) of the second paragraph.
>
> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the comple=
te
> IOVA address space, leveraging the logic we use to compose the dirty rang=
es.
> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
> addressing limits. This tackles item (2). So far I mainly use it with
> intel-iommu, although I have a small set of patches for virtio-iommu per
> Alex's suggestion in v2.
>
> Comments, suggestions welcome. Thanks for the review!
>
> Regards,
>         Joao
>
> Changes since v3[8]:
> * Pick up Yi's patches[5][6], and rework the first four patches.
>   These are a bit better splitted, and make the new iommu_ops *optional*
>   as opposed to a treewide conversion. Rather than returning an IOMMU MR
>   and let VFIO operate on it to fetch attributes, we instead let the
>   underlying IOMMU driver fetch the desired IOMMU MR and ask for the
>   desired IOMMU attribute. Callers only care about PCI Device backing
>   vIOMMU attributes regardless of its topology/association. (Peter Xu)
>   These patches are a bit better splitted compared to original ones,
>   and I've kept all the same authorship and note the changes from
>   original where applicable.
> * Because of the rework of the first four patches, switch to
>   individual attributes in the VFIOSpace that track dma_translation
>   and the max_iova. All are expected to be unused when zero to retain
>   the defaults of today in common code.
> * Improve the migration blocker message of the last patch to be
>   more obvious that vIOMMU migration blocker is added when no vIOMMU
>   address space limits are advertised. (Patch 15)
> * Cast to uintptr_t in IOMMUAttr data in intel-iommu (Philippe).
> * Switch to MAKE_64BIT_MASK() instead of plain left shift (Philippe).
> * Change diffstat of patches with scripts/git.orderfile (Philippe).
>
> Changes since v2[3]:
> * New patches 1-9 to be able to handle vIOMMUs without DMA translation, a=
nd
> introduce ways to know various IOMMU model attributes via the IOMMU MR. T=
his
> is partly meant to address a comment in previous versions where we can't
> access the IOMMU MR prior to the DMA mapping happening. Before this serie=
s
> vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by t=
he
> guest. As well as better tackling of the IOMMU usage for interrupt-remapp=
ing
> only purposes.
> * Dropped Peter Xu ack on patch 9 given that the code changed a bit.
> * Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers=
.
> * The patches that existed in v2 of vIOMMU dirty tracking, are mostly
> * untouched, except patch 12 which was greatly simplified.
>
> Changes since v1[4]:
> - Rebased on latest master branch. As part of it, made some changes in
>   pre-copy to adjust it to Juan's new patches:
>   1. Added a new patch that passes threshold_size parameter to
>      .state_pending_{estimate,exact}() handlers.
>   2. Added a new patch that refactors vfio_save_block().
>   3. Changed the pre-copy patch to cache and report pending pre-copy
>      size in the .state_pending_estimate() handler.
> - Removed unnecessary P2P code. This should be added later on when P2P
>   support is added. (Alex)
> - Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
>   (patch #11). (Alex)
> - Stored vfio_devices_all_device_dirty_tracking()'s value in a local
>   variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
> - Refactored the viommu device dirty tracking ranges creation code to
>   make it clearer (patch #15).
> - Changed overflow check in vfio_iommu_range_is_device_tracked() to
>   emphasize that we specifically check for 2^64 wrap around (patch #15).
> - Added R-bs / Acks.
>
> [0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvid=
ia.com/
> [1] https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a=
3b@oracle.com/
> [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/oem-kernel-dma-protection
> [3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvid=
ia.com/
> [4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvi=
dia.com/
> [5] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.co=
m/
> [6] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.co=
m/
> [7] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/
> [8] https://lore.kernel.org/qemu-devel/20230530175937.24202-1-joao.m.mart=
ins@oracle.com/
>
> Avihai Horon (4):
>   memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
>   intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
>   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>   vfio/common: Optimize device dirty page tracking with vIOMMU
>
> Joao Martins (7):
>   memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
>   intel-iommu: Implement get_attr() method
>   vfio/common: Track whether DMA Translation is enabled on the vIOMMU
>   vfio/common: Relax vIOMMU detection when DMA translation is off
>   vfio/common: Move dirty tracking ranges update to helper
>   vfio/common: Support device dirty page tracking with vIOMMU
>   vfio/common: Block migration with vIOMMUs without address width limits
>
> Yi Liu (4):
>   hw/pci: Add a pci_setup_iommu_ops() helper
>   hw/pci: Refactor pci_device_iommu_address_space()
>   hw/pci: Introduce pci_device_iommu_get_attr()
>   intel-iommu: Switch to pci_setup_iommu_ops()
>

Would you mind pointing to the github address?
I have some conflicts, and the github will be much helpful.


Thanks

