Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A766CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAP-00068Z-1q; Tue, 16 Jun 2026 15:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-0004b0-EA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8G-00013t-35
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso37313495e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636846; x=1782241646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXTnLo9AYMynqhYOAlIEHSPGTicUDN6Avwxqc5XliDA=;
 b=cT8M3iET7T18YC1KcYN2E+iQXQ/dTDyxYqxDkdQxUAE2pE5ZXD/5Hkn21NJNjqUeO9
 V+Gv55s2BBdxU5gO/yg1nmOTFM83rzHJ95FPzgr7a/e0yCxzG2eoj1JN6PkUUcRAmU8A
 oeS2uEvzD+0cRwdc153HAXy4jAnRW6kMR1WFdJss1X4TqA+SKfFpzLxhXGh306nybyFj
 RkYPd3xkFQKYTZEgNavJhmiM9SzVj3RRIHTBJmVzhH+CIy69X4ghMQ1gOvpCsOvpWo7/
 Pfbz25PQC5VaMye84CjDu1sGWgT+byFycuSDrZIrEQuPvyboQZukYVnsWgkWcl6XF/5X
 jPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636846; x=1782241646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lXTnLo9AYMynqhYOAlIEHSPGTicUDN6Avwxqc5XliDA=;
 b=FDC4LlI0CKnPwRM7L/fFHAHVVnjPFNuO5WlC56Kpv3cdrfTx0vIFticcFfsjih+x2D
 XZFLV4GLwRAhZCHpPtE09YN0eemMei4h1X0+PYA4Q8vaNQqAOZPO4wMtIgQayg5ujUeJ
 LAPZmHppqR74g9XTXp7fxSi1cWFxnN36eJPn0bSz/bhVuX6ACBPRll/LmHfvRpHzQZoK
 6cTaGu0+B/gtFk8fajnj6U/3nYcKLfkv1d7H/es7Azp40jPpSmEp7Bh5i2TYSWyjbjOU
 x+bwFfOH75fKH/WNKbosm3yX34zEx7lxiKChtnnUtAFRWHH7EI7FKX/MZ++/t/jtueGH
 86tg==
X-Gm-Message-State: AOJu0YwrRdS4rsJ+syopVB97MdaKbk6MyrSyTJwmNbFIzYrYLVqvWI/S
 fFrVKa7aFQusM5NMDlL7gRtjPWJkkT4aECBii4WWzt9OlOxL+mlDdJTzJpsOyJrlkQc1FcPzNty
 kajIv
X-Gm-Gg: Acq92OHaOXzHwvuedTwnPao4XCSP9Be9SBQbtdCN4Gr68wxJvqfTJ1XhDsk//PHe2Q+
 5dd4OxKQlxQKY85l0KHFg0AnPROESNKUVgqfkLTU+ODrC07DylkP3dRMpl0AfFdNEtMSC2ZAH8M
 R2DTueHYVpb41rbCjJoIcBHlT6C52KLRzIEHQEzD9l7kARW026dWOyS6MhgMbf6NH1w6RskYAET
 P6mVMqAbaXPAhcpHR+F0JsMjL9uQhbAw+kbH8M766NsJ5OOmQrCjj/z+1s238BpGiAKQAQhtaLQ
 h67+DT+6zb2rp+N093zFlUiLdAx5OgAqoXY5/32+u1Qkmg+rL84SYzcw2h11xVvDyB9ATYu750E
 klEc9b2uCBeMk7v+jnNTR8kzuMmX+Vi1uuQgMLaSGMSNXCa4VhHf59MR9qM+KsrYm2Zx7jfa7J6
 wkQNHXAF/H8mMkA/AYKWDkApue9V5B4HytgcYwQ+swvBJnZ1bqzU1oJfcdwUQ3ULQFH537TKrkn
 8ZYfmOhC8Msvxf0gDw9U1HCabv2FNX25J8xpmsXDjU=
X-Received: by 2002:a05:600c:19cb:b0:490:bb45:79f0 with SMTP id
 5b1f17b1804b1-492333ba306mr13126225e9.3.1781636846123; 
 Tue, 16 Jun 2026 12:07:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/61] hw/arm/tegra241-cmdqv: Document the CMDQV design and
 lifecycle
Date: Tue, 16 Jun 2026 20:06:17 +0100
Message-ID: <20260616190639.3462006-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

Add an overview describing the Tegra241 CMDQV passthrough model, MMIO
layout, guest-driven lifecycle, and per-VM isolation.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20260609112552.378999-31-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 100 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d821eafca1..29c488e0e4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -7,6 +7,106 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+/*
+ * Tegra241 CMDQV - overview
+ * =========================
+ *
+ * NVIDIA Tegra241 extends SMMUv3 with a Command Queue Virtualization (CMDQ-V)
+ * block. It lets a guest issue SMMU invalidation commands directly to
+ * dedicated hardware queues (vCMDQs) without trapping into the hypervisor on
+ * the fast path. vCMDQs are exclusively allocated to Virtual Interfaces
+ * (VINTFs); the host kernel allocates one VINTF per emulated SMMUv3 instance
+ * via iommufd. QEMU emulates the CMDQV MMIO region and drives the host kernel
+ * calls (VIOMMU_ALLOC, HW_QUEUE_ALLOC, mmap); the actual command processing
+ * happens on real hardware.
+ *
+ * A vCMDQ becomes functional only once allocated to the host VINTF; until then
+ * no command processing happens, and trapped register accesses fall back to a
+ * QEMU-side cache. After allocation, the cached register state is migrated to
+ * the hardware and command processing runs on the host; guest accesses to the
+ * live control/status registers then bypass QEMU and reach the host directly.
+ *
+ * MMIO layout (64KB pages, total TEGRA241_CMDQV_IO_LEN)
+ * -----------------------------------------------------
+ *   0x00000  CMDQV Config page: QEMU-trapped.
+ *   0x10000  Direct vCMDQ Page 0 (control/status): QEMU-trapped and routed
+ *            to either the mmap'd host VINTF Page 0 (if the vCMDQ has been
+ *            allocated to a VINTF) or a per-vCMDQ register cache (otherwise).
+ *   0x20000  Direct vCMDQ Page 1 (BASE / DRAM addresses): QEMU-trapped.
+ *   0x30000  VINTF Page 0 (per-VINTF control/status): the guest's virtual
+ *            VINTF Page 0 aperture, backed by the host VINTF Page 0 (mmap'd
+ *            via iommufd) and installed into guest MMIO as a RAM-device
+ *            subregion when VINTF is enabled; subsequent accesses bypass QEMU.
+ *   0x40000  VINTF Page 1 (per-VINTF BASE): QEMU-trapped. Although this is
+ *            a HW alias of the direct Page 1, the kernel only exposes mmap
+ *            for the host VINTF Page 0; the host VINTF Page 1 is not mmap'd
+ *            and stays trapped.
+ *
+ * The direct vCMDQ apertures (0x10000/0x20000) are HW aliases of the VINTF
+ * apertures (0x30000/0x40000); they expose the same per-vCMDQ register slots
+ * under different addressing.
+ *
+ * The direct vCMDQ Page 0 stays trapped rather than aliased to the host VINTF
+ * Page 0 mmap. The CMDQV architecture allows software to program a vCMDQ
+ * through the direct aperture before allocating it to a VINTF; aliasing to
+ * the host VINTF Page 0 mmap would route those accesses into unallocated
+ * logical slots where the hardware silently drops them, so trapping keeps
+ * accesses well-defined for an unallocated vCMDQ.
+ *
+ * Lifecycle (driven by guest events)
+ * ----------------------------------
+ * 1. First vfio-pci device attach (.set_iommu_device) triggers:
+ *    - tegra241_cmdqv_probe(): IOMMU_GET_HW_INFO confirms host CMDQV support.
+ *    - IOMMU_VIOMMU_ALLOC: the kernel allocates and enables a VINTF for this
+ *      VM, configures the VM's VMID (from its stage-2 HWPT) in VINTF_CONFIG,
+ *      forces HYP_OWN=0, and returns the mmap offset/length for the host
+ *      VINTF Page 0, which QEMU then mmap()s.
+ *
+ * 2. Guest writes VINTF_CONFIG.ENABLE = 1:
+ *    QEMU installs the mmap'd host VINTF Page 0 into guest MMIO as the guest's
+ *    virtual VINTF Page 0 aperture (a RAM-device subregion) and reports
+ *    STATUS.ENABLE_OK = 1. The aperture is now a direct window onto the host
+ *    page, so accesses no longer trap into QEMU; a vCMDQ within it operates as
+ *    a real command queue only once it has been allocated (step 3).
+ *
+ * 3. Guest completes vCMDQ setup (BASE, CMDQ_ALLOC_MAP.ALLOC, CMDQV_EN,
+ *    VINTF.ENABLE, in any order; each precondition write retries the HW queue
+ *    allocation):
+ *    IOMMU_HW_QUEUE_ALLOC grants the guest a new host vCMDQ in this VM's
+ *    VINTF, binding the guest BASE GPA (translated through stage-2 and pinned
+ *    by the kernel) to it.
+ *
+ * 4. Guest SMMU driver programs a Stream Table Entry for a passthrough
+ *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE in this VM's
+ *    VINTF so that the HW translates the device's guest vSID into its host
+ *    pSID. Commands referencing unmapped SIDs are rejected by HW.
+ *
+ *    This reflects the current accel SMMUv3 design, which allocates the
+ *    vDEVICE when the guest programs the STE.
+ *
+ * Per-VM isolation
+ * ----------------
+ * - Each VM has its own iommufd FD; all iommufd objects (VINTF, vdevices,
+ *   hw_queues, mmap regions) belong to that FD. Cross-FD lookups fail, so
+ *   one VM cannot reach another VM's IDs.
+ * - IOMMU_VIOMMU_ALLOC configures the VM's VMID in VINTF_CONFIG; the CMDQV
+ *   hardware substitutes / checks VMID on every command the guest issues.
+ * - The kernel allocates the VINTF with HYP_OWN = 0, which restricts the
+ *   guest to a safe subset of commands.
+ * - IOMMU_VDEVICE_ALLOC populates SID_MATCH/SID_REPLACE so invalidations
+ *   only reach the host StreamIDs assigned to this VM (see step 4).
+ * - IOMMU_HW_QUEUE_ALLOC binds each vCMDQ to a single VINTF, so a guest
+ *   cannot reach a vCMDQ that belongs to another VM.
+ *
+ * Limits exposed to the guest
+ * ---------------------------
+ * One VINTF per emulated SMMUv3 and two vCMDQs per VINTF. The HW maximum
+ * vCMDQ size is 8MiB, but the size QEMU exposes to the guest may be smaller.
+ * The queue must be physically contiguous in host memory, so QEMU caps the
+ * exposed size to the host memory-backend page size. Use hugepage backing to
+ * reach the 8MiB maximum.
+ */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 
-- 
2.43.0


