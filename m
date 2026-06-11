Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE55CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXhHy-0003I7-2O; Thu, 11 Jun 2026 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXhHw-0003HR-Fe
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXhHt-0003CO-C4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781191544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAoEGuY/puHq06ub49xjJg6klfeu4BFAJ/C8SL4D97U=;
 b=aVgyF1OA/ebh5fj6RQInxWUtwhIX++Z+N71szQsSI58oRIHzhCrD6UMAcely639lryc0D/
 Z3skp+FZhFTHZUMi3uXaZvKyzc4/XuFXYww1kjQQsYIT+QBZghd3oUwBU2gOkNwKGg9NkZ
 HoQwM/SHQmHWyCFTRyfRR0tDC5dcKKc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-8zx7_G2pPzKKYwyOfYgArw-1; Thu, 11 Jun 2026 11:25:43 -0400
X-MC-Unique: 8zx7_G2pPzKKYwyOfYgArw-1
X-Mimecast-MFC-AGG-ID: 8zx7_G2pPzKKYwyOfYgArw_1781191542
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eef10d5ebso4241679f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781191542; x=1781796342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAoEGuY/puHq06ub49xjJg6klfeu4BFAJ/C8SL4D97U=;
 b=HIm4/p1dsYIk21NT4doplrtyVFe1KjsqqU0bY5i1aQikqxF5HDcKVZRDDNLP0zDm62
 IV0ZpNpzmqMAiK74YHR5v/xKmDrLoJkTru83xAYY4VtpQEu52ZwEDG4o7MDMOnWkpXZ+
 xr4hCT6j5Wl2nxTgs3Vd8Av2kVOOGmPcN54QpC9U6D1pDZxxGT5Rh9Djy5HClqLHJDxu
 0FyJ1+qDURJ3V3L/Vt0efmPbJSjzn0+3w0nfQF4em0tgSbgRzc2NWTnvqDZ8e977hy0F
 G5Pj4fpvA3momtaYcYFG2sUNeTjgwMcRVSyjFnBXs17Jwy1Q8C230amaVl6fKD6o0lU+
 XvJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SDW75mxAriu0EIMiG8mWTzeSEAIbd1DNNAEd/zulGnRM0ym+/XHM+GYBDnOUM5Px7lIwYwO6x9qMO@nongnu.org
X-Gm-Message-State: AOJu0YxmJl5W7SzMHo9hfUed/Tu1VXlYeS2sTsBqMN8BHe5GmjIsVtl7
 HH+AC1rL2pSrbv5Eulfnn0B9YOASQhWRz5zuLFWLdKQait1g7BRed+r4BJg+maBfsIQ9/fIn8OK
 oiHo778POM0oLD4f6l8pSpHWZCZVBXy8qSOINIprUpL4iHvU/ZYGN7I/V
X-Gm-Gg: Acq92OFRMIgn5leX7ax66iVmDvC2a3Y4eNP3E/uhhQ1dlxHOkggy07aYUBEjADFZbWz
 h3xZPo6P2xQEOBoa0dQdTcmCr3DXZKGbpk1MDJosa2KRSWdNsXL7oTL8pzNDyyw5eNHU5erGz0K
 iO/0pVCIYow33MFgimv/H4vAprzIRdZF+Ig4mNu7Qx1Vwl0KCLCBVkvGNIpFT7eGLppRqlEJkWW
 mwwQaMfTSQ6ln6S3Ijce6bOdY+m6f6TP4dzvmi1u58nZ9GRECJ2khFp+jn/qN1OlIjwVkk5rsZ3
 ePh+p1cEGoEgZ4w/E2qd6YmtijWdki781u7R8/y6dbgI+uNKQ8+gAY7VNYN3icV/yUBljwoDxU1
 6tDaczXs+nqbyxqXQBTmPqS7qipH7aex/ODDXCUDoGZ0Ryfzg/KAPwCHYQGMH60EjUmPB1eTQ3L
 StgBh7
X-Received: by 2002:a05:6000:461e:b0:43f:e990:2f5d with SMTP id
 ffacd0b85a97d-460677c0674mr5286699f8f.35.1781191541754; 
 Thu, 11 Jun 2026 08:25:41 -0700 (PDT)
X-Received: by 2002:a05:6000:461e:b0:43f:e990:2f5d with SMTP id
 ffacd0b85a97d-460677c0674mr5286594f8f.35.1781191541074; 
 Thu, 11 Jun 2026 08:25:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35eae5sm83289182f8f.33.2026.06.11.08.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 08:25:40 -0700 (PDT)
Message-ID: <596d3847-87a0-40e3-b5ea-b2989c7373f6@redhat.com>
Date: Thu, 11 Jun 2026 17:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV design
 and lifecycle
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <20260609112552.378999-31-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260609112552.378999-31-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/9/26 1:25 PM, Shameer Kolothum wrote:
> Add an overview describing the Tegra241 CMDQV passthrough model, MMIO
> layout, guest-driven lifecycle, and per-VM isolation.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/tegra241-cmdqv.c | 100 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index d821eafca1..29c488e0e4 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -7,6 +7,106 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +/*
> + * Tegra241 CMDQV - overview
> + * =========================
> + *
> + * NVIDIA Tegra241 extends SMMUv3 with a Command Queue Virtualization (CMDQ-V)
> + * block. It lets a guest issue SMMU invalidation commands directly to
> + * dedicated hardware queues (vCMDQs) without trapping into the hypervisor on
> + * the fast path. vCMDQs are exclusively allocated to Virtual Interfaces
> + * (VINTFs); the host kernel allocates one VINTF per emulated SMMUv3 instance
> + * via iommufd. QEMU emulates the CMDQV MMIO region and drives the host kernel
> + * calls (VIOMMU_ALLOC, HW_QUEUE_ALLOC, mmap); the actual command processing
> + * happens on real hardware.
> + *
> + * A vCMDQ becomes functional only once allocated to the host VINTF; until then
> + * no command processing happens, and trapped register accesses fall back to a
> + * QEMU-side cache. After allocation, the cached register state is migrated to
> + * the hardware and command processing runs on the host; guest accesses to the
> + * live control/status registers then bypass QEMU and reach the host directly.
> + *
> + * MMIO layout (64KB pages, total TEGRA241_CMDQV_IO_LEN)
> + * -----------------------------------------------------
> + *   0x00000  CMDQV Config page: QEMU-trapped.
> + *   0x10000  Direct vCMDQ Page 0 (control/status): QEMU-trapped and routed
> + *            to either the mmap'd host VINTF Page 0 (if the vCMDQ has been
> + *            allocated to a VINTF) or a per-vCMDQ register cache (otherwise).
> + *   0x20000  Direct vCMDQ Page 1 (BASE / DRAM addresses): QEMU-trapped.
> + *   0x30000  VINTF Page 0 (per-VINTF control/status): the guest's virtual
> + *            VINTF Page 0 aperture, backed by the host VINTF Page 0 (mmap'd
> + *            via iommufd) and installed into guest MMIO as a RAM-device
> + *            subregion when VINTF is enabled; subsequent accesses bypass QEMU.
> + *   0x40000  VINTF Page 1 (per-VINTF BASE): QEMU-trapped. Although this is
> + *            a HW alias of the direct Page 1, the kernel only exposes mmap
> + *            for the host VINTF Page 0; the host VINTF Page 1 is not mmap'd
> + *            and stays trapped.
> + *
> + * The direct vCMDQ apertures (0x10000/0x20000) are HW aliases of the VINTF
> + * apertures (0x30000/0x40000); they expose the same per-vCMDQ register slots
> + * under different addressing.
> + *
> + * The direct vCMDQ Page 0 stays trapped rather than aliased to the host VINTF
> + * Page 0 mmap. The CMDQV architecture allows software to program a vCMDQ
> + * through the direct aperture before allocating it to a VINTF; aliasing to
> + * the host VINTF Page 0 mmap would route those accesses into unallocated
> + * logical slots where the hardware silently drops them, so trapping keeps
> + * accesses well-defined for an unallocated vCMDQ.
> + *
> + * Lifecycle (driven by guest events)
> + * ----------------------------------
> + * 1. First vfio-pci device attach (.set_iommu_device) triggers:
> + *    - tegra241_cmdqv_probe(): IOMMU_GET_HW_INFO confirms host CMDQV support.
> + *    - IOMMU_VIOMMU_ALLOC: the kernel allocates and enables a VINTF for this
> + *      VM, configures the VM's VMID (from its stage-2 HWPT) in VINTF_CONFIG,
> + *      forces HYP_OWN=0, and returns the mmap offset/length for the host
> + *      VINTF Page 0, which QEMU then mmap()s.
> + *
> + * 2. Guest writes VINTF_CONFIG.ENABLE = 1:
> + *    QEMU installs the mmap'd host VINTF Page 0 into guest MMIO as the guest's
> + *    virtual VINTF Page 0 aperture (a RAM-device subregion) and reports
> + *    STATUS.ENABLE_OK = 1. The aperture is now a direct window onto the host
> + *    page, so accesses no longer trap into QEMU; a vCMDQ within it operates as
> + *    a real command queue only once it has been allocated (step 3).
> + *
> + * 3. Guest completes vCMDQ setup (BASE, CMDQ_ALLOC_MAP.ALLOC, CMDQV_EN,
> + *    VINTF.ENABLE, in any order; each precondition write retries the HW queue
> + *    allocation):
> + *    IOMMU_HW_QUEUE_ALLOC grants the guest a new host vCMDQ in this VM's
> + *    VINTF, binding the guest BASE GPA (translated through stage-2 and pinned
> + *    by the kernel) to it.
> + *
> + * 4. Guest SMMU driver programs a Stream Table Entry for a passthrough
> + *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE in this VM's
> + *    VINTF so that the HW translates the device's guest vSID into its host
> + *    pSID. Commands referencing unmapped SIDs are rejected by HW.
> + *
> + *    This reflects the current accel SMMUv3 design, which allocates the
> + *    vDEVICE when the guest programs the STE.
> + *
> + * Per-VM isolation
> + * ----------------
> + * - Each VM has its own iommufd FD; all iommufd objects (VINTF, vdevices,
> + *   hw_queues, mmap regions) belong to that FD. Cross-FD lookups fail, so
> + *   one VM cannot reach another VM's IDs.
> + * - IOMMU_VIOMMU_ALLOC configures the VM's VMID in VINTF_CONFIG; the CMDQV
> + *   hardware substitutes / checks VMID on every command the guest issues.
> + * - The kernel allocates the VINTF with HYP_OWN = 0, which restricts the
> + *   guest to a safe subset of commands.
> + * - IOMMU_VDEVICE_ALLOC populates SID_MATCH/SID_REPLACE so invalidations
> + *   only reach the host StreamIDs assigned to this VM (see step 4).
> + * - IOMMU_HW_QUEUE_ALLOC binds each vCMDQ to a single VINTF, so a guest
> + *   cannot reach a vCMDQ that belongs to another VM.
> + *
> + * Limits exposed to the guest
> + * ---------------------------
> + * One VINTF per emulated SMMUv3 and two vCMDQs per VINTF. The HW maximum
> + * vCMDQ size is 8MiB, but the size QEMU exposes to the guest may be smaller.
> + * The queue must be physically contiguous in host memory, so QEMU caps the
> + * exposed size to the host memory-backend page size. Use hugepage backing to
> + * reach the 8MiB maximum.
> + */
> +
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  


