Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D97606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xVs+Jlxd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVws3-0006ot-Rh; Tue, 24 Nov 2026 15:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavogyn@gmail.com>)
 id 1xVws1-0006o3-EL
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:12:05 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavogyn@gmail.com>)
 id 1xVwry-0002zV-Fn
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:12:05 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so681551866b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:12:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795551120; cv=none;
 d=google.com; s=arc-20260327;
 b=AgmQx073xwsLz5zv0ZWUdVB3Y1gxm+RzaDGZYYJbowioPLY77nZNu/eDpsIMYTbusl
 7z9c4xe6vRYgACuG8fNpkTQJYVALhsWQ5T2TF38x4qSAL1hu5bqpzrBBp9NNHlZ+VZd7
 p4v7vAxaJD8lRWymwCvO04PXeakr/VFSUCqctEBvoalwkSEPN+igiNmqMEWhAa+vWuxx
 xade7zCGd4Gh0VND87bNtpsQL6eoIHJ9XRi/8I6bjdoBm1K/Cg/Zssrzf10rAmlqFfdX
 q3WHp3U9w7vDmIKw5YwGvF20OWxFW1rPa7an3qvafjcQfdGrNO/XyEmPEwKqZOvQNBxS
 Z+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=m8J61ssBQ3siUwz2aS+2pvfGvkYvFivWnsmhf8SQBmI=;
 fh=2tLSd4TCpvZvZN2g21t8VLm2BXyMdemyFybvVLISJQ8=;
 b=LCGoxqsuRhG0R23UbCcAF8oiRYzTVmU1VDAvFo20UcZTYMHuVG7Wqid8O87FUyGYqJ
 hqTQVtkiU2nCQ51HRA5E026/ygLZpQ4zE5mlLRHpWzj/virPEf3w5jHVKoagTK+LS3r4
 tywJcdcYfBGXnN2AUv7raEJIRz1ST5LvjXx9vv5Ua8RXN/RiR21ue7Vyv/qQb90sqwQ7
 zT6E8C/Mcy0fY2oszfjtwn261rewfi5ttS+XPnCtnK3bQpP212FmNIRH2dwAcTJ0TGaZ
 GXEuZe5xGxk3UNQlAKRMvprUhb2vpSdVnKmmnR36KurvhxCp4f/xrM7gRsjBG/G0dmIZ
 Ec3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795551120; x=1796155920; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8J61ssBQ3siUwz2aS+2pvfGvkYvFivWnsmhf8SQBmI=;
 b=xVs+JlxdlTofDTCg/5t3WF67ZRuSMMg26WrIW3/5yOf1+35QSKg+tYRp0HOiqL4K1z
 OjLxDaak6Yul+1xGWwMuIwrA/s1CEK1Roy0y3wuCV+p+r1PkBeNmjWHlQ56/LqBQ2TG+
 lXNpP3rIu03UpWbH4EP6Caj+2Ee7jB6UJC73BoXtcWlZt4efc+oWgP1LNfoA7roIWi3N
 BhRxgIvnkd2krI0Gg9bP/Pos2w9SqnwZdJQBSZWqxFjV2FUVx9T2Gv+XJVMhoYjSi1IO
 C/+Mv7WFoW2HTKU2X0iPg3Y2VDL/ksfzMq1PN5G4LFnVNnMGRSPPnTUkaL0MnPCWKCT9
 BGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795551120; x=1796155920;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m8J61ssBQ3siUwz2aS+2pvfGvkYvFivWnsmhf8SQBmI=;
 b=OomIbLibFvIiE8Tnjc2p5dv3tDue2do86ywujjIkHG3uCiBd7G8Lk2yyh1s1Py3I4t
 lEgKbzCgZ3gFxDjrcC2o3WCXT7I+1lWqiN+XIYBrvAlDBgqniVx2gkqNkQ4LIyu3FyHr
 ueW8XCHNUwnqFwbeTYasKQm4UU+oaEP2w4JzZBM+tZWr5Xrce7lxFDOawGLPFUSJUBOQ
 uRr4Xip36b2AWB57S+b3AW2dDvtJnODgLWwXT85gXAI3MO8lUM4ZXjnEvSPUp7gm63X1
 cKUcZyKpIt/3JZ9qvwdHMu8v3BKU3LXNEGQOdgXGUxfmEe6p1jEL7AmMiFyNa5q5Ld3W
 AUxg==
X-Gm-Message-State: APuU4Z8hJ8ahqSB2Ytl5rMiTaVqaGMUOYFxjsD5V7xAfOeF1IUoXB6E6
 yHmVQRYmDpaQ5F8oWw/s2XTiHX0ex54zN8mM1s06itgM5KpACmjczpIbD4hcKwvr8gAYtNhzMD6
 zizTK7f5db9Gvtl/SSKbM/Uw/40ErBkNxgnl4
X-Gm-Gg: AZFdTZdTSzuDz03G+0dypEFBOHbxWNVszeDMnw973v6jQJChbqhFzZs67Zrzi+WlZxC
 aL0WYKDzW+vcgyogXO7hION/gaBG9s+uZL/jCP9/ItRA9hL7HHdi6KBbRVEmqK93wAN/95YGNvn
 imR6YCQnIywXrPNg97HYV6XskcjzlqNyDZsXOZf8WdicSYmh5AUJ1/9+75roja79/+5pRlsfFA7
 sIO0b64/oFXjL27/PDplwClgNMj/fsg7ttNfPP/S7O4VHqBno1rCeOuqKAdhajshe7eQXeX9S4k
 DXuRUHRGP45bfZe4FJ5ifYeeaUKj/CvOW5sK3E4UOBrSFeHwLqmw8N//GplQN3cvdCWkqfJ0VS2
 lxMJ6b8eXCPOjKCQs+mTuW216dMfQOrK3WLMl/Y5sECsMUZ56gyfg60bgYmATG3IpcIpL
X-Received: by 2002:a17:907:ea8e:b0:c49:a235:8e0c with SMTP id
 a640c23a62f3a-c513aadb22dmr1240681566b.22.1795551119990; Tue, 24 Nov 2026
 12:11:59 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Tue, 24 Nov 2026 12:11:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Gustavo Andrade <gustavogyn@gmail.com>
Date: Tue, 24 Nov 2026 12:11:59 -0800
X-Gm-Features: Aa3M54oQ-pWgeOXptQkgHU5tey2Tasnk-epleFbl6eU3WIWKDbbszd5TyWeTnEg
Message-ID: <CAPZV9qUfPnXf_UN0A99VQ0rSiU2VmROGxjjjJ3_UhjT2+St1YA@mail.gmail.com>
Subject: [RFC PATCH v2] vfio/pci: Wait for RTX 5090 firmware after reset
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=gustavogyn@gmail.com; helo=mail-ej1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Gustavo A." <gustavogyn@gmail.com>

Updating the host from CachyOS 7.2.10 to 7.3 exposed grey display output
on an RTX 5090 passthrough setup after the guest booted Linux. The
triggering kernel change is unknown. Restricting BAR1 to 4 KiB mappings
masks the failure; waiting for firmware readiness also restores output
with stock KVM, unmodified VFIO and verified 1 GiB BAR1 mappings.

The RTX 5090's Firmware Security Processor (FSP) can still be
initializing after PCI reset completes. Poll for the BAR firewall to
open and the FSP boot status to report ready before guest firmware runs.
Match the physical RTX 5090 PCI ID before applying guest overrides,
prevent guest overrides from selecting Radeon reset quirks on an RTX
5090, and honor x-no-geforce-quirks.

Run the wait in the reset exit phase rather than a device resetfn.
During a VM reset, VFIO's shared bus reset handler runs in the hold
phase and can execute after the GPU's own reset callback. Guest config
writes requesting FLR or a D3hot-to-D0 transition go through VFIO
separately from this QEMU reset path.

Use raw VFIO region access for the config and BAR reads. Temporarily
enable PCI memory decoding via byte writes (preserving the kernel-managed
INTx-disable bit) if needed, then restore it on exit. Bound both polls
with one five-second monotonic deadline. A completed read of all ones
can occur while registers are inaccessible and satisfies neither
readiness check, so polling continues until ready or timeout while
explicit VFIO I/O errors return immediately. Report readiness and
cleanup failures separately without terminating QEMU.

Link: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/fsp/arch/blackwell/kern_fsp_gb202.c
Link: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/bif/arch/blackwell/kernel_bif_gb202.c
Signed-off-by: Gustavo A. <gustavogyn@gmail.com>
---

Hi Alex,

Resending as v2 because Gmail's web UI wrapped lines in v1 and broke the
diff on Patchew.

I moved the wait out of resetfn into ResettableClass phases.exit since a
shared VFIO bus reset in the hold phase can still run after the GPU's
own reset callback. Other changes since v1:

- Detect the physical RTX 5090 in vfio_pci_config_setup() before guest
  ID overrides, block Radeon resetfn selection for it, and honor
  x-no-geforce-quirks.
- Poll with raw VFIO region_read() at 10 ms intervals under a single 5 s
  deadline; keep polling on transient 0xffffffff reads and return
  immediately on VFIO I/O errors.
- Retry -EINTR and report PCI_COMMAND_MEMORY restore failures separately.
- Rebased onto master (6bf90d4fc502).

Note that AI tools assisted with this patch. I know QEMU declines
AI-derived submissions unless an exception is granted, so let me know if
an exception makes sense here or if the findings are only useful as
reference for a clean-room implementation.

Hardware display testing on the RTX 5090 (1 GiB BAR1, stock KVM, native
VFIO) was done on the earlier revision; this reset_exit revision has
been build- and smoke-tested on master and 11.1.3.

Main thing I'd like feedback on is whether phases.exit is the right
place for this wait, and whether the 5 s timeout and report-and-continue
behavior look reasonable.

Thanks,
Gustavo

 hw/vfio/pci-quirks.c | 129 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |  36 +++++++++---
 hw/vfio/pci.h        |   6 ++
 hw/vfio/trace-events |   1 +
 4 files changed, 163 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index a38a0e7..6b03d8b 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1354,8 +1354,137 @@ out:
     return ret;
 }

+/*
+ * GB202's Firmware Security Processor can still be initializing when PCI
+ * reset completes.
+ */
+#define NVIDIA_GB202_BAR_FIREWALL 0x2b8
+#define NVIDIA_GB202_BAR_BLOCKED BIT(24)
+#define NVIDIA_GB202_FSP_STATUS 0xad00bc
+#define NVIDIA_GB202_FSP_READY 0xff
+
+/*
+ * PCI_COMMAND_MEMORY is in the low byte. Leave the kernel-managed INTx
+ * disable bit in the high byte alone, and verify that the write took effect.
+ */
+static int vfio_gb202_set_memory_decode(VFIOPCIDevice *vdev, bool enable,
+                                        bool *restore_decode)
+{
+    bool wrote = false;
+    uint8_t command;
+    int ret, retries = 3;
+
+    /* Cleanup must also be able to retry after the readiness timeout. */
+    do {
+        ret = vfio_pci_config_space_read(vdev, PCI_COMMAND, 1, &command);
+        if (ret != 1) {
+            continue;
+        }
+        if (command == UINT8_MAX) {
+            return -EIO;
+        }
+        if (!!(command & PCI_COMMAND_MEMORY) == enable) {
+            return 0;
+        }
+        if (wrote) {
+            return -EIO;
+        }
+
+        /* Even a failed write may have changed the device. */
+        if (restore_decode) {
+            *restore_decode = true;
+        }
+        command ^= PCI_COMMAND_MEMORY;
+        ret = vfio_pci_config_space_write(vdev, PCI_COMMAND, 1, &command);
+        wrote = ret == 1;
+    } while (ret == 1 || (ret == -EINTR && retries-- > 0));
+
+    return ret < 0 ? ret : -EIO;
+}
+
+static int vfio_gb202_poll(VFIODevice *vbasedev, uint8_t region, off_t offset,
+                           uint32_t mask, uint32_t expected, int64_t deadline)
+{
+    for (;;) {
+        int64_t remaining;
+        uint32_t value;
+        int ret;
+
+        ret = vbasedev->io_ops->region_read(vbasedev, region, offset,
+                                            sizeof(value), &value);
+        if (ret == sizeof(value)) {
+            /* An all-ones read during reset matches neither ready state. */
+            if ((le32_to_cpu(value) & mask) == expected) {
+                return 0;
+            }
+        } else if (ret != -EINTR) {
+            return ret < 0 ? ret : -EIO;
+        }
+
+        remaining = deadline - g_get_monotonic_time();
+        if (remaining <= 0) {
+            return -ETIMEDOUT;
+        }
+        g_usleep(MIN(remaining, 10 * G_TIME_SPAN_MILLISECOND));
+    }
+}
+
+void vfio_pci_gb202_wait_ready(VFIOPCIDevice *vdev)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    VFIORegion *bar0 = &vdev->bars[0].region;
+    int64_t deadline = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    bool restore_decode = false;
+    int ret, restore_ret;
+
+    if (vdev->config_size < NVIDIA_GB202_BAR_FIREWALL + sizeof(uint32_t) ||
+        vdev->bars[0].ioport || !(bar0->flags & VFIO_REGION_INFO_FLAG_READ) ||
+        bar0->size < NVIDIA_GB202_FSP_STATUS + sizeof(uint32_t)) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    /* The BAR firewall must open before BAR0 can be accessed. */
+    ret = vfio_gb202_poll(vbasedev, VFIO_PCI_CONFIG_REGION_INDEX,
+                          NVIDIA_GB202_BAR_FIREWALL, NVIDIA_GB202_BAR_BLOCKED,
+                          0, deadline);
+    if (ret) {
+        goto out;
+    }
+    ret = vfio_gb202_set_memory_decode(vdev, true, &restore_decode);
+    if (!ret) {
+        ret = vfio_gb202_poll(vbasedev, VFIO_PCI_BAR0_REGION_INDEX,
+                              NVIDIA_GB202_FSP_STATUS, UINT32_MAX,
+                              NVIDIA_GB202_FSP_READY, deadline);
+    }
+
+out:
+    if (ret) {
+        error_report("vfio: %s: GB202 firmware readiness check failed: %s",
+                     vbasedev->name, strerror(-ret));
+    }
+    if (restore_decode) {
+        restore_ret = vfio_gb202_set_memory_decode(vdev, false, NULL);
+        if (restore_ret) {
+            error_report("vfio: %s: failed to restore GB202 PCI memory "
+                         "decoding: %s", vbasedev->name,
+                         strerror(-restore_ret));
+            if (!ret) {
+                ret = restore_ret;
+            }
+        }
+    }
+    trace_vfio_quirk_nvidia_gb202_reset(vbasedev->name, ret);
+}
+
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
 {
+    /* Guest ID overrides must not select a Radeon reset on an RTX 5090. */
+    if (vdev->is_rtx_5090) {
+        vdev->resetfn = NULL;
+        return;
+    }
+
     switch (vdev->vendor_id) {
     case 0x1002:
         switch (vdev->device_id) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9607866..791a116 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1141,8 +1141,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice
*vdev, Error **errp)
 }

 /* "Raw" read of underlying config space. */
-static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
-                                      uint32_t size, void *data)
+int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                               uint32_t size, void *data)
 {
     return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
                                               VFIO_PCI_CONFIG_REGION_INDEX,
@@ -1150,8 +1150,8 @@ static int
vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
 }

 /* "Raw" write of underlying config space. */
-static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
-                                       uint32_t size, void *data)
+int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                uint32_t size, void *data)
 {
     return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
                                                VFIO_PCI_CONFIG_REGION_INDEX,
@@ -3428,6 +3428,12 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev,
Error **errp)
         return false;
     }

+    /* Match the host RTX 5090 before applying guest PCI ID overrides. */
+    vdev->is_rtx_5090 = !vbasedev->proxy && !vbasedev->mdev &&
+        pci_get_word(pdev->config + PCI_VENDOR_ID) == PCI_VENDOR_ID_NVIDIA &&
+        pci_get_word(pdev->config + PCI_DEVICE_ID) == 0x2b85 &&
+        pdev->config[PCI_CLASS_DEVICE + 1] == PCI_BASE_CLASS_DISPLAY;
+
     /* vfio emulates a lot for us, but some bits need extra love */
     vdev->emulated_config_bits = g_malloc0(vdev->config_size);

@@ -3767,9 +3773,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     }
 }

-static void vfio_pci_reset(DeviceState *dev)
+static void vfio_pci_reset_hold(Object *obj, ResetType type)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);

     /* Do not reset the device during qemu_system_reset prior to cpr load */
     if (cpr_is_incoming()) {
@@ -3811,6 +3817,16 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }

+static void vfio_pci_reset_exit(Object *obj, ResetType type)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
+
+    /* Shared VFIO bus resets also run in the hold phase. */
+    if (vdev->is_rtx_5090 && !vdev->no_geforce_quirks && !cpr_is_incoming()) {
+        vfio_pci_gb202_wait_ready(vdev);
+    }
+}
+
 static void vfio_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
@@ -3952,8 +3968,10 @@ static void vfio_pci_class_init(ObjectClass
*klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);

-    device_class_set_legacy_reset(dc, vfio_pci_reset);
+    rc->phases.hold = vfio_pci_reset_hold;
+    rc->phases.exit = vfio_pci_reset_exit;
     device_class_set_props(dc, vfio_pci_properties);
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
     dc->vmsd = &vfio_cpr_pci_vmstate;
@@ -4019,8 +4037,8 @@ static void vfio_pci_class_init(ObjectClass
*klass, const void *data)
                                           "clique for device [0-15]");
     object_class_property_set_description(klass, /* 2.12 */
                                           "x-no-geforce-quirks",
-                                          "Disable GeForce quirks
(for NVIDIA Quadro/GRID/Tesla). "
-                                          "Improves performance");
+                                          "Disable GeForce MMIO quirks and "
+                                          "the RTX 5090 firmware wait");
     object_class_property_set_description(klass, /* 2.12 */
                                           "display",
                                           "Enable display support for
device, ex. vGPU");
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7ff52e9..951b77a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -179,6 +179,7 @@ struct VFIOPCIDevice {
     bool no_kvm_msi;
     bool no_kvm_msix;
     bool no_geforce_quirks;
+    bool is_rtx_5090;
     bool no_kvm_ioeventfd;
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
@@ -226,6 +227,10 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev);
 void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);

 /* Config space */
+int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                               uint32_t size, void *data);
+int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                uint32_t size, void *data);
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
@@ -256,6 +261,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
+void vfio_pci_gb202_wait_ready(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index bfdaf22..7c64373 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -80,6 +80,7 @@ vfio_quirk_ati_bonaire_reset_no_smc(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_timeout(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_done(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset(const char *name) "%s"
+vfio_quirk_nvidia_gb202_reset(const char *name, int ret) "%s ret %d"
 vfio_ioeventfd_exit(const char *name, uint64_t addr, unsigned size,
uint64_t data) "%s+0x%"PRIx64"[%d]:0x%"PRIx64
 vfio_ioeventfd_handler(const char *name, uint64_t addr, unsigned
size, uint64_t data) "%s+0x%"PRIx64"[%d] -> 0x%"PRIx64
 vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size,
uint64_t data, bool vfio) "%s+0x%"PRIx64"[%d]:0x%"PRIx64" vfio:%d"
-- 
2.56.1

