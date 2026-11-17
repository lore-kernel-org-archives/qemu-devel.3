Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D1606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRH9omix
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTAp0-00047s-Tx; Mon, 16 Nov 2026 23:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavogyn@gmail.com>)
 id 1xT7lw-0003J0-K2
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 20:14:08 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavogyn@gmail.com>)
 id 1xT7lt-0004gO-4p
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 20:14:08 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so6920824a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:14:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794878043; cv=none;
 d=google.com; s=arc-20260327;
 b=DwdZA9UG7Aq+1Dc+vyWlyHAvDAhS+L8a4YW0cWJ8O6ks3UlaPF2pIWu/Jqyr4f9pqE
 I6WX+SLENWtlZ9kiUB8K7rOeAq3jFCxDLAsgPfpQ1HJjbRoDIUBx8s74dHgwTSTD7dKU
 6dlzkLyV7tYB8z/PinPad+ElLytXjaPgneLUWIUN/cBfRLGNnVAG6cqpXuyP882xQRcY
 lGlytstd/JOq5eVeHXOh38YSiuRutBGqgAs3nVtTI3posgFTj0glrTIQlJHP7dDTaxSe
 x2OQx2VK7MYKkulrv7R+XQt6OV9giPqWm3FtpH0dmaQTtUTEw9cAoa9fQLp/B9pclxhX
 A0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xu4UWRKv+upXLTwhxWeiH4oIOBy0HRQKJfFD995hPkc=;
 fh=2tLSd4TCpvZvZN2g21t8VLm2BXyMdemyFybvVLISJQ8=;
 b=kWWMTtdNiIn7jC6PKg/e+FI6Q/wPbdbghp1LklhnQx6Vnu3UIwXsKIqpQjLwsQJc6T
 ALpTqo4y635X1ZNL8h690kHav+M08a33pifcJ9fx9xweRx7RGPeq9gzFk/953OYirty6
 2noz4orh7e5PJBHNRvSytHItabS8IYXSP56WtxITuy/nVOuhQWt9aSs0uAcz1zV0oU8q
 UCxALu4qs93hdt72IiNAzCWT9fOiR6pBRZxsRckZQefJ94pvuC4l6Pqd2GvkIUSI+qMr
 2d5E+XZLpwgMWd0kijPMc0UtHWWSkbziE2hdaOzJZwbeTG1SF7oYawoKXX9v5Kzw3Mn0
 09+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794878043; x=1795482843; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xu4UWRKv+upXLTwhxWeiH4oIOBy0HRQKJfFD995hPkc=;
 b=vRH9omixpnFgZ1QE+S/Yqj0SWiS9nZYR3F/TVT4vQQW2tuSwmmFRx1DC3E6TkJL87q
 lr2z8/k8aMbeVXaw1ZzrDvGo5ZSx/dfhkpU1Q0MHAWSe+at9Qe6Soer0Op0PP8w4Tg64
 h6gCS2oC4yeUf8oKQiiIJ0sIHogcbCoePWAy8FGYH3PD/Rajng4v7XNKV+pHBXo2c0Ow
 rYomfS8dq31+QZJ1ejEFOBj5+gTjXn2x/9tAJgKNQFUjLbsFYYMaNcsWck43zWw3bgGa
 oHGv+BTmzEjUWxrgg73wnB/KTOEIBT7JYmmhdTZ9LapEkd/5h6EHyT93C74ch3htEbZU
 OMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794878043; x=1795482843;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xu4UWRKv+upXLTwhxWeiH4oIOBy0HRQKJfFD995hPkc=;
 b=Raf+lAaO6t3bP+8HqEAJ5Epsk/4XsgKBsZezBsrEiMOf1kdtvWUP8Bl7SOTBxtmIxk
 T3B99FiQVYuHksnRSPrniN5VnEIiMfO5sWtya9KE+qhyWfsFuU1yDheMTuofTQDJwOTL
 0gQ9ntrEls9/kYMEkXoMUNvm0Obrf0aCkoK68akxWWmT9wSwafRkD781knN3CAu203jh
 7T5ATNRZ0kzzK/fX7WIR/C1SBIGxaGV15hwX3UGzASPFTKHY0uXCe64lZuo5JUHxSmIo
 fgrt5ovpOPRWkrOAwW3a3thM7SwbgIA76uYQJlsIH3rS7N4TNkT3k/CSIfbeNwi3zfi8
 urAA==
X-Gm-Message-State: APuU4Z9oDHwXIvWfcIqvcYJgHo7ubH+IoUTHTxBVMe8k//OQN2Cw0V4f
 hfUZZCSvUIyHzmWyAH9thTfeQWFhBesoU45yoaOzNi8zIzs5NqJRWNKzW5uS8001TDo6vyR/kHC
 pkyPx2qvtilpglvzzOv5eanp+YESEqTW/5YenwuA=
X-Gm-Gg: AYBFou3tOtJeDf24Rr1wLy+SQSumbA8O5+m/30EA3AbSIrPMqTwUF2DxnfJPCNnO3O0
 Da0L5Av+iHOG50aPlbuB10MkAjELQZ1fnHNW1WWOjFFuD6+oGsi5BtSg7V99NcAT382ytmQiqKq
 WXz5lGBSSlI+lTMu21svGMrg6HlIGmziLgFL4aLffaZwqt/ZSrGsVS3yg7wbjw6bX3NkbgGVJFA
 6Sdqse8vs9+gi157e6EYEeBOji2QZChA9X3Gtb5mQHiMyZC+A4lvYz4AIXqYGm2tRJeVnjDu1yl
 Q/GX2Kn1sZ8Wy6ZhefIQ7tHUQ62DZ5JDv7MP6LLPFyXQEG4QNl63hs/eaBL74uWCtWneq3DpSsR
 udrG+k6ZLax8oZGoBImWPyQ+SugiPCoRIqVtA3iawIxioYDoaxG8kMFYYhXN3Y1AoVkE/M0E=
X-Received: by 2002:a17:907:d7cb:b0:c50:6222:7b0b with SMTP id
 a640c23a62f3a-c509619b3c6mr1003581466b.2.1794878042643; Mon, 16 Nov 2026
 17:14:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Gustavo Andrade <gustavogyn@gmail.com>
Date: Mon, 16 Nov 2026 22:13:46 -0300
X-Gm-Features: AclHuK8VfibGd8d7uczan0zCZQUpHUx4xTGpMTtfZ7ppk3VM6TWn07oEyRHjX4U
Message-ID: <CAPZV9qWBRELt7H8S05+=3Tb7y8e8gsRD2Xu02xbXPhH_YpYNPw@mail.gmail.com>
Subject: [RFC PATCH] vfio/pci: Wait for RTX 5090 firmware after reset
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000259f9906606e9ccb"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=gustavogyn@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Nov 2026 23:29:30 -0500
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000259f9906606e9ccb
Content-Type: text/plain; charset="UTF-8"

Updating the host from CachyOS 7.2.10 to 7.3 exposed grey display output
on an RTX 5090 passthrough setup after the guest booted Linux. The
triggering kernel change is unknown. Restricting BAR1 to 4 KiB mappings
masks the failure; waiting for firmware readiness also restores output
with stock KVM, unmodified VFIO and verified 1 GiB BAR1 mappings.

GB202's Firmware Security Processor can still be initializing when PCI
reset completes. Wait for the BAR firewall to open and the FSP boot
status to report success before guest firmware runs. Limit the quirk
to the validated physical RTX 5090 product ID, independent of guest
identity overrides.

Preserve the existing function, bus and PM reset order. Bound both
polls with one five-second deadline. Temporarily enable BAR0 memory
decoding through raw VFIO configuration access and restore it on exit.
Byte writes preserve the kernel-managed INTx-disable bit.

Report readiness failures without terminating QEMU. The reset has
already been attempted, so consume the callback without triggering
another reset and allow the normal post-reset cleanup to run.

Link:
https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/fsp/arch/blackwell/kern_fsp_gb202.c
Link:
https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/bif/arch/blackwell/kernel_bif_gb202.c
Signed-off-by: Gustavo A. <gustavogyn@gmail.com>
---

Hi Alex,

Thanks for your reply to my kernel RFC, "vfio/pci: Wait for GB202
firmware after reset". I tried the QEMU resetfn approach you suggested,
using vfio_radeon_reset() as a reference, and the QEMU-only tests restored
normal display output. I'm following up here with the patch and results
for your feedback.

This RFC was developed with AI assistance. I understand QEMU's current
policy declines contributions derived from AI-generated content. Would
an exception be appropriate here, or would these test results help a
maintainer develop an independent fix?

The readiness wait was tested on a Palit RTX 5090 GameRock using QEMU
11.1.3, stock KVM, unmodified VFIO, tracing disabled and verified 1 GiB
BAR1 mappings. Output and refresh were normal on repeated boots. An
unmodified QEMU control, built with the same compiler and configuration,
reproduced grey output under the same conditions.

I would appreciate feedback on whether the reset quirk is the right place
for this wait, whether the five-second timeout and report-and-continue
policy are appropriate, and what evidence would justify adding other
GB202 product IDs.

Thanks,
Gustavo

 hw/vfio/pci-quirks.c | 129 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |  48 ++++++++--------
 hw/vfio/pci.h        |   5 ++
 hw/vfio/trace-events |   1 +
 4 files changed, 161 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index a38a0e7..f00f62c 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1354,8 +1354,137 @@ out:
     return ret;
 }

+/*
+ * GB202's Firmware Security Processor can still be initializing after
reset.
+ * Wait before guest firmware runs.
+ */
+#define NVIDIA_GB202_BAR_FIREWALL 0x2b8
+#define NVIDIA_GB202_BAR_BLOCKED BIT(24)
+#define NVIDIA_GB202_FSP_STATUS 0xad00bc
+#define NVIDIA_GB202_FSP_READY 0xff
+
+/* Byte writes preserve concurrent updates to the INTx-disable bit. */
+static int vfio_nvidia_gb202_set_memory_decode(VFIOPCIDevice *vdev,
+                                               bool enable, bool
*was_enabled)
+{
+    uint8_t command, value;
+
+    if (vfio_pci_config_space_read(vdev, PCI_COMMAND, 1, &command) != 1 ||
+        command == UINT8_MAX) {
+        return -EIO;
+    }
+    if (was_enabled) {
+        *was_enabled = command & PCI_COMMAND_MEMORY;
+    }
+    value = enable ? command | PCI_COMMAND_MEMORY :
+                     command & ~PCI_COMMAND_MEMORY;
+    if (value == command) {
+        return 0;
+    }
+
+    if (vfio_pci_config_space_write(vdev, PCI_COMMAND, 1, &value) != 1) {
+        return -EIO;
+    }
+    if (vfio_pci_config_space_read(vdev, PCI_COMMAND, 1, &command) != 1 ||
+        command != value) {
+        return -EIO;
+    }
+    return 0;
+}
+
+static int vfio_nvidia_gb202_wait_ready(VFIOPCIDevice *vdev)
+{
+    VFIORegion *bar0 = &vdev->bars[0].region;
+    int64_t deadline = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    bool memory_was_enabled = true;
+    uint32_t value;
+    int ret, restore_ret;
+
+    if (vdev->config_size < NVIDIA_GB202_BAR_FIREWALL + sizeof(value) ||
+        vdev->bars[0].ioport || !(bar0->flags &
VFIO_REGION_INFO_FLAG_READ) ||
+        bar0->size < NVIDIA_GB202_FSP_STATUS + sizeof(value)) {
+        return -ENODEV;
+    }
+
+    /* The BAR firewall must open before BAR0 can be accessed. */
+    for (;;) {
+        ret = vfio_pci_config_space_read(vdev, NVIDIA_GB202_BAR_FIREWALL,
+                                         sizeof(value), &value);
+        if (ret != sizeof(value) || value == UINT32_MAX) {
+            return -EIO;
+        }
+        if (!(le32_to_cpu(value) & NVIDIA_GB202_BAR_BLOCKED)) {
+            break;
+        }
+        if (g_get_monotonic_time() >= deadline) {
+            return -ETIMEDOUT;
+        }
+        g_usleep(G_TIME_SPAN_MILLISECOND);
+    }
+
+    ret = vfio_nvidia_gb202_set_memory_decode(vdev, true,
&memory_was_enabled);
+    if (ret) {
+        goto out_restore;
+    }
+
+    for (;;) {
+        value = vfio_region_read(bar0, NVIDIA_GB202_FSP_STATUS,
sizeof(value));
+        if (value == UINT32_MAX) {
+            ret = -EIO;
+            break;
+        }
+        if (value == NVIDIA_GB202_FSP_READY) {
+            break;
+        }
+        if (g_get_monotonic_time() >= deadline) {
+            ret = -ETIMEDOUT;
+            break;
+        }
+        g_usleep(G_TIME_SPAN_MILLISECOND);
+    }
+
+out_restore:
+    if (!memory_was_enabled) {
+        restore_ret = vfio_nvidia_gb202_set_memory_decode(vdev, false,
NULL);
+        if (restore_ret) {
+            ret = restore_ret;
+        }
+    }
+    return ret;
+}
+
+static int vfio_nvidia_gb202_reset(VFIOPCIDevice *vdev)
+{
+    int ret;
+
+    /* A shared bus reset may already have run; keep the normal reset
policy. */
+    vfio_pci_reset_device(vdev);
+    ret = vfio_nvidia_gb202_wait_ready(vdev);
+    trace_vfio_quirk_nvidia_gb202_reset(vdev->vbasedev.name, ret);
+    if (ret) {
+        error_report("vfio: %s: GB202 firmware readiness check failed: %s",
+                     vdev->vbasedev.name, strerror(-ret));
+    }
+
+    /* The reset was already attempted; do not repeat it on a wait
failure. */
+    return 0;
+}
+
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
 {
+    uint8_t config[PCI_STD_HEADER_SIZEOF];
+
+    /* Match physical RTX 5090 identity, independent of guest overrides. */
+    if (!vdev->vbasedev.mdev &&
+        vfio_pci_config_space_read(vdev, 0, sizeof(config),
+                                   config) == sizeof(config) &&
+        pci_get_word(config + PCI_VENDOR_ID) == PCI_VENDOR_ID_NVIDIA &&
+        pci_get_word(config + PCI_DEVICE_ID) == 0x2b85 &&
+        config[PCI_CLASS_DEVICE + 1] == PCI_BASE_CLASS_DISPLAY) {
+        vdev->resetfn = vfio_nvidia_gb202_reset;
+        return;
+    }
+
     switch (vdev->vendor_id) {
     case 0x1002:
         switch (vdev->device_id) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0da2e14..55fddb4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1141,8 +1141,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev,
Error **errp)
 }

 /* "Raw" read of underlying config space. */
-static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
-                                      uint32_t size, void *data)
+int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                               uint32_t size, void *data)
 {
     return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
                                               VFIO_PCI_CONFIG_REGION_INDEX,
@@ -1150,8 +1150,8 @@ static int vfio_pci_config_space_read(VFIOPCIDevice
*vdev, off_t offset,
 }

 /* "Raw" write of underlying config space. */
-static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
-                                       uint32_t size, void *data)
+int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                uint32_t size, void *data)
 {
     return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,

VFIO_PCI_CONFIG_REGION_INDEX,
@@ -3767,6 +3767,27 @@ static void vfio_exitfn(PCIDevice *pdev)
     }
 }

+void vfio_pci_reset_device(VFIOPCIDevice *vdev)
+{
+    if (vdev->vbasedev.reset_works &&
+        (vdev->has_flr || !vdev->has_pm_reset) &&
+        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
+        trace_vfio_pci_reset_flr(vdev->vbasedev.name);
+        return;
+    }
+
+    /* See if we can do our own bus reset */
+    if (!vfio_pci_hot_reset_one(vdev)) {
+        return;
+    }
+
+    /* If nothing else works and the device supports PM reset, use it */
+    if (vdev->vbasedev.reset_works && vdev->has_pm_reset &&
+        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
+        trace_vfio_pci_reset_pm(vdev->vbasedev.name);
+    }
+}
+
 static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
@@ -3788,24 +3809,7 @@ static void vfio_pci_reset(DeviceState *dev)
         goto post_reset;
     }

-    if (vdev->vbasedev.reset_works &&
-        (vdev->has_flr || !vdev->has_pm_reset) &&
-        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
-        trace_vfio_pci_reset_flr(vdev->vbasedev.name);
-        goto post_reset;
-    }
-
-    /* See if we can do our own bus reset */
-    if (!vfio_pci_hot_reset_one(vdev)) {
-        goto post_reset;
-    }
-
-    /* If nothing else works and the device supports PM reset, use it */
-    if (vdev->vbasedev.reset_works && vdev->has_pm_reset &&
-        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
-        trace_vfio_pci_reset_pm(vdev->vbasedev.name);
-        goto post_reset;
-    }
+    vfio_pci_reset_device(vdev);

 post_reset:
     vfio_pci_post_reset(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7ff52e9..de04761 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -226,6 +226,10 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev);
 void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);

 /* Config space */
+int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                               uint32_t size, void *data);
+int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                uint32_t size, void *data);
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
@@ -272,6 +276,7 @@ extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 struct vfio_pci_hot_reset_info;

 void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
+void vfio_pci_reset_device(VFIOPCIDevice *vdev);
 void vfio_pci_post_reset(VFIOPCIDevice *vdev);
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
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
 vfio_ioeventfd_handler(const char *name, uint64_t addr, unsigned size,
uint64_t data) "%s+0x%"PRIx64"[%d] -> 0x%"PRIx64
 vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size,
uint64_t data, bool vfio) "%s+0x%"PRIx64"[%d]:0x%"PRIx64" vfio:%d"
--
2.56.1

--000000000000259f9906606e9ccb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Updating the host from CachyOS 7.2.10 to 7.3 exposed grey =
display output<br>on an RTX 5090 passthrough setup after the guest booted L=
inux. The<br>triggering kernel change is unknown. Restricting BAR1 to 4 KiB=
 mappings<br>masks the failure; waiting for firmware readiness also restore=
s output<br>with stock KVM, unmodified VFIO and verified 1 GiB BAR1 mapping=
s.<br><br>GB202&#39;s Firmware Security Processor can still be initializing=
 when PCI<br>reset completes. Wait for the BAR firewall to open and the FSP=
 boot<br>status to report success before guest firmware runs. Limit the qui=
rk<br>to the validated physical RTX 5090 product ID, independent of guest<b=
r>identity overrides.<br><br>Preserve the existing function, bus and PM res=
et order. Bound both<br>polls with one five-second deadline. Temporarily en=
able BAR0 memory<br>decoding through raw VFIO configuration access and rest=
ore it on exit.<br>Byte writes preserve the kernel-managed INTx-disable bit=
.<br><br>Report readiness failures without terminating QEMU. The reset has<=
br>already been attempted, so consume the callback without triggering<br>an=
other reset and allow the normal post-reset cleanup to run.<br><br>Link: <a=
 href=3D"https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579f=
bbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/fsp/arch/blackwell/=
kern_fsp_gb202.c">https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6=
a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/fsp/arch/b=
lackwell/kern_fsp_gb202.c</a><br>Link: <a href=3D"https://github.com/NVIDIA=
/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/=
nvidia/src/kernel/gpu/bif/arch/blackwell/kernel_bif_gb202.c">https://github=
.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9=
bd8bd9/src/nvidia/src/kernel/gpu/bif/arch/blackwell/kernel_bif_gb202.c</a><=
br>Signed-off-by: Gustavo A. &lt;<a href=3D"mailto:gustavogyn@gmail.com">gu=
stavogyn@gmail.com</a>&gt;<br>---<br><br>Hi Alex,<br><br>Thanks for your re=
ply to my kernel RFC, &quot;vfio/pci: Wait for GB202<br>firmware after rese=
t&quot;. I tried the QEMU resetfn approach you suggested,<br>using vfio_rad=
eon_reset() as a reference, and the QEMU-only tests restored<br>normal disp=
lay output. I&#39;m following up here with the patch and results<br>for you=
r feedback.<br><br>This RFC was developed with AI assistance. I understand =
QEMU&#39;s current<br>policy declines contributions derived from AI-generat=
ed content. Would<br>an exception be appropriate here, or would these test =
results help a<br>maintainer develop an independent fix?<br><br>The readine=
ss wait was tested on a Palit RTX 5090 GameRock using QEMU<br>11.1.3, stock=
 KVM, unmodified VFIO, tracing disabled and verified 1 GiB<br>BAR1 mappings=
. Output and refresh were normal on repeated boots. An<br>unmodified QEMU c=
ontrol, built with the same compiler and configuration,<br>reproduced grey =
output under the same conditions.<br><br>I would appreciate feedback on whe=
ther the reset quirk is the right place<br>for this wait, whether the five-=
second timeout and report-and-continue<br>policy are appropriate, and what =
evidence would justify adding other<br>GB202 product IDs.<br><br>Thanks,<br=
>Gustavo<br><br>=C2=A0hw/vfio/pci-quirks.c | 129 ++++++++++++++++++++++++++=
+++++++++++++++++<br>=C2=A0hw/vfio/pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A048 ++++++++--------<br>=C2=A0hw/vfio/pci.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 5 ++<br>=C2=A0hw/vfio/trace-events | =C2=A0 1 +<br>=C2=A04 files cha=
nged, 161 insertions(+), 22 deletions(-)<br><br>diff --git a/hw/vfio/pci-qu=
irks.c b/hw/vfio/pci-quirks.c<br>index a38a0e7..f00f62c 100644<br>--- a/hw/=
vfio/pci-quirks.c<br>+++ b/hw/vfio/pci-quirks.c<br>@@ -1354,8 +1354,137 @@ =
out:<br>=C2=A0 =C2=A0 =C2=A0return ret;<br>=C2=A0}<br><br>+/*<br>+ * GB202&=
#39;s Firmware Security Processor can still be initializing after reset.<br=
>+ * Wait before guest firmware runs.<br>+ */<br>+#define NVIDIA_GB202_BAR_=
FIREWALL 0x2b8<br>+#define NVIDIA_GB202_BAR_BLOCKED BIT(24)<br>+#define NVI=
DIA_GB202_FSP_STATUS 0xad00bc<br>+#define NVIDIA_GB202_FSP_READY 0xff<br>+<=
br>+/* Byte writes preserve concurrent updates to the INTx-disable bit. */<=
br>+static int vfio_nvidia_gb202_set_memory_decode(VFIOPCIDevice *vdev,<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bool enable, bool *was_enabled)<br>+{<br>+ =C2=A0 =C2=A0uint8=
_t command, value;<br>+<br>+ =C2=A0 =C2=A0if (vfio_pci_config_space_read(vd=
ev, PCI_COMMAND, 1, &amp;command) !=3D 1 ||<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0command =3D=3D UINT8_MAX) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;=
<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (was_enabled) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*was_enabled =3D command &amp; PCI_COMMAND_MEMORY;<br>+ =
=C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0value =3D enable ? command | PCI_COMMAND_M=
EMORY :<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 command &amp; ~PCI_COMMAND_MEMORY;<br>+ =C2=A0 =C2=A0if (value =3D=
=3D command) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=A0=
}<br>+<br>+ =C2=A0 =C2=A0if (vfio_pci_config_space_write(vdev, PCI_COMMAND,=
 1, &amp;value) !=3D 1) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>+=
 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (vfio_pci_config_space_read(vdev, PCI_=
COMMAND, 1, &amp;command) !=3D 1 ||<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0command=
 !=3D value) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>+ =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0return 0;<br>+}<br>+<br>+static int vfio_nvidia_gb20=
2_wait_ready(VFIOPCIDevice *vdev)<br>+{<br>+ =C2=A0 =C2=A0VFIORegion *bar0 =
=3D &amp;vdev-&gt;bars[0].region;<br>+ =C2=A0 =C2=A0int64_t deadline =3D g_=
get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;<br>+ =C2=A0 =C2=A0bool memor=
y_was_enabled =3D true;<br>+ =C2=A0 =C2=A0uint32_t value;<br>+ =C2=A0 =C2=
=A0int ret, restore_ret;<br>+<br>+ =C2=A0 =C2=A0if (vdev-&gt;config_size &l=
t; NVIDIA_GB202_BAR_FIREWALL + sizeof(value) ||<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vdev-&gt;bars[0].ioport || !(bar0-&gt;flags &amp; VFIO_REGION_INFO_FL=
AG_READ) ||<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bar0-&gt;size &lt; NVIDIA_GB202=
_FSP_STATUS + sizeof(value)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOD=
EV;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0/* The BAR firewall must ope=
n before BAR0 can be accessed. */<br>+ =C2=A0 =C2=A0for (;;) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ret =3D vfio_pci_config_space_read(vdev, NVIDIA_GB202_B=
AR_FIREWALL,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(value), &amp;value);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
ret !=3D sizeof(value) || value =3D=3D UINT32_MAX) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(le32_to_cpu(value) &amp; NVIDIA_GB202_BAR=
_BLOCKED)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_get_monoton=
ic_time() &gt;=3D deadline) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -ETIMEDOUT;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0g_usleep(G_TIME_SPAN_MILLISECOND);<br>+ =C2=A0 =C2=A0}<br>+<br=
>+ =C2=A0 =C2=A0ret =3D vfio_nvidia_gb202_set_memory_decode(vdev, true, &am=
p;memory_was_enabled);<br>+ =C2=A0 =C2=A0if (ret) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out_restore;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0for =
(;;) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D vfio_region_read(bar0, NVI=
DIA_GB202_FSP_STATUS, sizeof(value));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (v=
alue =3D=3D UINT32_MAX) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
 =3D -EIO;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =3D=3D NVI=
DIA_GB202_FSP_READY) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_ge=
t_monotonic_time() &gt;=3D deadline) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -ETIMEDOUT;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0g_usleep(G_TIME_SPAN_MILLISECOND);<br>+ =C2=A0 =C2=A0}<br>+<br>+out_rest=
ore:<br>+ =C2=A0 =C2=A0if (!memory_was_enabled) {<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0restore_ret =3D vfio_nvidia_gb202_set_memory_decode(vdev, false, NUL=
L);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (restore_ret) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D restore_ret;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0return ret;<br>+}<br>+<br>+st=
atic int vfio_nvidia_gb202_reset(VFIOPCIDevice *vdev)<br>+{<br>+ =C2=A0 =C2=
=A0int ret;<br>+<br>+ =C2=A0 =C2=A0/* A shared bus reset may already have r=
un; keep the normal reset policy. */<br>+ =C2=A0 =C2=A0vfio_pci_reset_devic=
e(vdev);<br>+ =C2=A0 =C2=A0ret =3D vfio_nvidia_gb202_wait_ready(vdev);<br>+=
 =C2=A0 =C2=A0trace_vfio_quirk_nvidia_gb202_reset(vdev-&gt;<a href=3D"http:=
//vbasedev.name">vbasedev.name</a>, ret);<br>+ =C2=A0 =C2=A0if (ret) {<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;vfio: %s: GB202 firmware rea=
diness check failed: %s&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev-&gt;<a href=3D"http://vbasedev.name">v=
basedev.name</a>, strerror(-ret));<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=
=A0/* The reset was already attempted; do not repeat it on a wait failure. =
*/<br>+ =C2=A0 =C2=A0return 0;<br>+}<br>+<br>=C2=A0void vfio_setup_resetfn_=
quirk(VFIOPCIDevice *vdev)<br>=C2=A0{<br>+ =C2=A0 =C2=A0uint8_t config[PCI_=
STD_HEADER_SIZEOF];<br>+<br>+ =C2=A0 =C2=A0/* Match physical RTX 5090 ident=
ity, independent of guest overrides. */<br>+ =C2=A0 =C2=A0if (!vdev-&gt;vba=
sedev.mdev &amp;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0vfio_pci_config_space=
_read(vdev, 0, sizeof(config),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 config) =3D=3D sizeof(config) &amp;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0pci_get_word(config + PCI_VENDOR_ID) =3D=3D PCI_VENDOR_ID_NVIDIA &amp=
;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_get_word(config + PCI_DEVICE_ID)=
 =3D=3D 0x2b85 &amp;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0config[PCI_CLASS_=
DEVICE + 1] =3D=3D PCI_BASE_CLASS_DISPLAY) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0vdev-&gt;resetfn =3D vfio_nvidia_gb202_reset;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return;<br>+ =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0switch (vdev-=
&gt;vendor_id) {<br>=C2=A0 =C2=A0 =C2=A0case 0x1002:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0switch (vdev-&gt;device_id) {<br>diff --git a/hw/vfio/pci.=
c b/hw/vfio/pci.c<br>index 0da2e14..55fddb4 100644<br>--- a/hw/vfio/pci.c<b=
r>+++ b/hw/vfio/pci.c<br>@@ -1141,8 +1141,8 @@ static bool vfio_pci_load_ro=
m(VFIOPCIDevice *vdev, Error **errp)<br>=C2=A0}<br><br>=C2=A0/* &quot;Raw&q=
uot; read of underlying config space. */<br>-static int vfio_pci_config_spa=
ce_read(VFIOPCIDevice *vdev, off_t offset,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t size, void *data)<br>+int vfio_pci_=
config_space_read(VFIOPCIDevice *vdev, off_t offset,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t size, void *data)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0=
return vdev-&gt;vbasedev.io_ops-&gt;region_read(&amp;vdev-&gt;vbasedev,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0VFIO_PCI_CONFIG_REGION_INDEX,<br>@@ -1150,8 +1150,8 @@ =
static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,<br=
>=C2=A0}<br><br>=C2=A0/* &quot;Raw&quot; write of underlying config space. =
*/<br>-static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t of=
fset,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint3=
2_t size, void *data)<br>+int vfio_pci_config_space_write(VFIOPCIDevice *vd=
ev, off_t offset,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t size, v=
oid *data)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0return vdev-&gt;vbasedev.io_op=
s-&gt;region_write(&amp;vdev-&gt;vbasedev,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VFIO_PCI=
_CONFIG_REGION_INDEX,<br>@@ -3767,6 +3767,27 @@ static void vfio_exitfn(PCI=
Device *pdev)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><br>+void vfio_pci_res=
et_device(VFIOPCIDevice *vdev)<br>+{<br>+ =C2=A0 =C2=A0if (vdev-&gt;vbasede=
v.reset_works &amp;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0(vdev-&gt;has_flr =
|| !vdev-&gt;has_pm_reset) &amp;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0!ioct=
l(vdev-&gt;vbasedev.fd, VFIO_DEVICE_RESET)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0trace_vfio_pci_reset_flr(vdev-&gt;<a href=3D"http://vbasedev.name">vbase=
dev.name</a>);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<=
br>+<br>+ =C2=A0 =C2=A0/* See if we can do our own bus reset */<br>+ =C2=A0=
 =C2=A0if (!vfio_pci_hot_reset_one(vdev)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0/* If nothing else wo=
rks and the device supports PM reset, use it */<br>+ =C2=A0 =C2=A0if (vdev-=
&gt;vbasedev.reset_works &amp;&amp; vdev-&gt;has_pm_reset &amp;&amp;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0!ioctl(vdev-&gt;vbasedev.fd, VFIO_DEVICE_RESET))=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vfio_pci_reset_pm(vdev-&gt;<a href=
=3D"http://vbasedev.name">vbasedev.name</a>);<br>+ =C2=A0 =C2=A0}<br>+}<br>=
+<br>=C2=A0static void vfio_pci_reset(DeviceState *dev)<br>=C2=A0{<br>=C2=
=A0 =C2=A0 =C2=A0VFIOPCIDevice *vdev =3D VFIO_PCI_DEVICE(dev);<br>@@ -3788,=
24 +3809,7 @@ static void vfio_pci_reset(DeviceState *dev)<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0goto post_reset;<br>=C2=A0 =C2=A0 =C2=A0}<br><br>- =C2=
=A0 =C2=A0if (vdev-&gt;vbasedev.reset_works &amp;&amp;<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(vdev-&gt;has_flr || !vdev-&gt;has_pm_reset) &amp;&amp;<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0!ioctl(vdev-&gt;vbasedev.fd, VFIO_DEVICE_RESET))=
 {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vfio_pci_reset_flr(vdev-&gt;<a hre=
f=3D"http://vbasedev.name">vbasedev.name</a>);<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0goto post_reset;<br>- =C2=A0 =C2=A0}<br>-<br>- =C2=A0 =C2=A0/* See if=
 we can do our own bus reset */<br>- =C2=A0 =C2=A0if (!vfio_pci_hot_reset_o=
ne(vdev)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0goto post_reset;<br>- =C2=A0 =
=C2=A0}<br>-<br>- =C2=A0 =C2=A0/* If nothing else works and the device supp=
orts PM reset, use it */<br>- =C2=A0 =C2=A0if (vdev-&gt;vbasedev.reset_work=
s &amp;&amp; vdev-&gt;has_pm_reset &amp;&amp;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0!ioctl(vdev-&gt;vbasedev.fd, VFIO_DEVICE_RESET)) {<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0trace_vfio_pci_reset_pm(vdev-&gt;<a href=3D"http://vbasedev.na=
me">vbasedev.name</a>);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0goto post_reset;<br=
>- =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0vfio_pci_reset_device(vdev);<br><br>=C2=
=A0post_reset:<br>=C2=A0 =C2=A0 =C2=A0vfio_pci_post_reset(vdev);<br>diff --=
git a/hw/vfio/pci.h b/hw/vfio/pci.h<br>index 7ff52e9..de04761 100644<br>---=
 a/hw/vfio/pci.h<br>+++ b/hw/vfio/pci.h<br>@@ -226,6 +226,10 @@ void vfio_p=
ci_intx_eoi(VFIODevice *vbasedev);<br>=C2=A0void vfio_pci_teardown_msi(VFIO=
PCIDevice *vdev);<br><br>=C2=A0/* Config space */<br>+int vfio_pci_config_s=
pace_read(VFIOPCIDevice *vdev, off_t offset,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t size, void *data);<br>+int vfio_pci_config_space_write(VFIO=
PCIDevice *vdev, off_t offset,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t size, void *data);<br>=C2=A0uint32_t vfio_pci_read_config(PCIDevice =
*pdev, uint32_t addr, int len);<br>=C2=A0void vfio_pci_write_config(PCIDevi=
ce *pdev,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t addr, uint32_t val, int len);<=
br>@@ -272,6 +276,7 @@ extern const PropertyInfo qdev_prop_nv_gpudirect_cli=
que;<br>=C2=A0struct vfio_pci_hot_reset_info;<br><br>=C2=A0void vfio_pci_pr=
e_reset(VFIOPCIDevice *vdev);<br>+void vfio_pci_reset_device(VFIOPCIDevice =
*vdev);<br>=C2=A0void vfio_pci_post_reset(VFIOPCIDevice *vdev);<br>=C2=A0bo=
ol vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);<br>=
=C2=A0int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,<br>diff --gi=
t a/hw/vfio/trace-events b/hw/vfio/trace-events<br>index bfdaf22..7c64373 1=
00644<br>--- a/hw/vfio/trace-events<br>+++ b/hw/vfio/trace-events<br>@@ -80=
,6 +80,7 @@ vfio_quirk_ati_bonaire_reset_no_smc(const char *name) &quot;%s&=
quot;<br>=C2=A0vfio_quirk_ati_bonaire_reset_timeout(const char *name) &quot=
;%s&quot;<br>=C2=A0vfio_quirk_ati_bonaire_reset_done(const char *name) &quo=
t;%s&quot;<br>=C2=A0vfio_quirk_ati_bonaire_reset(const char *name) &quot;%s=
&quot;<br>+vfio_quirk_nvidia_gb202_reset(const char *name, int ret) &quot;%=
s ret %d&quot;<br>=C2=A0vfio_ioeventfd_exit(const char *name, uint64_t addr=
, unsigned size, uint64_t data) &quot;%s+0x%&quot;PRIx64&quot;[%d]:0x%&quot=
;PRIx64<br>=C2=A0vfio_ioeventfd_handler(const char *name, uint64_t addr, un=
signed size, uint64_t data) &quot;%s+0x%&quot;PRIx64&quot;[%d] -&gt; 0x%&qu=
ot;PRIx64<br>=C2=A0vfio_ioeventfd_init(const char *name, uint64_t addr, uns=
igned size, uint64_t data, bool vfio) &quot;%s+0x%&quot;PRIx64&quot;[%d]:0x=
%&quot;PRIx64&quot; vfio:%d&quot;<br>--<br>2.56.1<br></div>

--000000000000259f9906606e9ccb--

