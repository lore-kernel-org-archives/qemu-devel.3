Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05366C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8CP-0003Ni-GK; Mon, 19 Feb 2024 13:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rc8CJ-0003MY-K1
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:17:03 -0500
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rc8CH-0004gp-KQ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:16:59 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id 55BAA1C000A1;
 Mon, 19 Feb 2024 13:16:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 19 Feb 2024 13:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1708366614; x=1708453014; bh=RDKr5KOEyU
 1P8HpgXnlUzz0XOtyo12r8pUxs5poAuEI=; b=zuCssHKJsXrqqdpwdr9qMqSihV
 HJCmLV+5lv6v6kePzbI2GZYLyzLs/4OT0rct2ONgqs1JGp8XO7QKisx+9aHaYG28
 N33bWum9KxSS6LQmDbDDW/TZSMyO/CT427ViZVzal5xRNnZyP8z4hNXI0g2soJ1w
 RsyR1nSHBetSEXP6Xoas6XWuw+4rsEp4BJm1q9Nv/TaLQ2CbqLI8A5uDAdClTpSZ
 NSlRZH4G6lKdJk9RP2Eloi1rA6K+2aUHaSmidPheFD/mLuvaG5cuSze2tGSRZa2n
 pvDg/Ja9Dr+q62N/D168YGLYAPb4w7uigVx7u9J+jix1AvwElqheC5mhIEIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708366614; x=
 1708453014; bh=RDKr5KOEyU1P8HpgXnlUzz0XOtyo12r8pUxs5poAuEI=; b=h
 gMR+6RhKHwa2e2m2gYM0oq0AWmtRxJLoYYcSrU73SNDH5uzaqT/IVAwFUnt7uuKm
 qAoZhQeg0BLjQJtTn3YLiTdxtrydSwN/nvY8F/wkS2/8YZUlryaam4gGrsLHE0bY
 TxMLTGH4wK8p5sxshGNr/yfB0pgNidxLujfYH1ZmCxBV2IrGe7C49uQQMAP5rC/T
 ujd5r6+avwgnlw677EYDZOJXOH+SWHAeLNic4egCQMdNh+7+nSn59GgKIUB+dzA2
 EUdiD3bT3Al/shDZ2oP93iS9U3JPSHjWvESHwnQ966lEJKH7XKGWzK6cUlEZ5Zv+
 bKC7oeF6YQQWEnmabGsHA==
X-ME-Sender: <xms:FpvTZY7WhVT3Z6agUZFsoA-Qatkr3h36vo3uEWkDYsTY4I96v_86QQ>
 <xme:FpvTZZ4KnnL6m9bioHZYUQ_n4UqqhFInCw-csAdpqAQHeUo4Bf6nhl7Flr952J0xP
 fgyw7X-G2qr0A>
X-ME-Received: <xmr:FpvTZXfR3I9hADHysYXteWjwUeH8CEwb_Od9miHKD6TcKRFfk3SPLDxQHGt2spqErG9b_bFIwibqT0m0UpByYDFyiLrWX_ctAe_gAVRx28TRDTITyEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghr
 vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
 hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefg
 ueduhefgvdefheehudejheefudevueeghfekhfehleegveduteeuiedugffgffenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgv
 khesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:FpvTZdKFzTVfMSVz2plmDB5X91E1l6WFTHsSWp2hcbJcWgZ59ca1kA>
 <xmx:FpvTZcJqmEQUm86f6ArVCAHuqp9ROBFM7Sa_oxjetksiIdFqscQ--g>
 <xmx:FpvTZexcjkx6BLdzEy1WdUeGikx644qGEpNiF6zAeIxs4lbVXzz3vg>
 <xmx:FpvTZU_7baUyXe-ka8eYsk5-kgavH_kt7pef17snKnPX9-JUzSM3OrsBLis>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 13:16:53 -0500 (EST)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?=
 <frederic.pierret@qubes-os.org>, 
 =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 2/2] xen: fix stubdom PCI addr
Date: Mon, 19 Feb 2024 19:16:06 +0100
Message-ID: <20240219181627.282097-2-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.148;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Frédéric Pierret (fepitre) <frederic.pierret@qubes-os.org>

When running in a stubdomain, the config space access via sysfs needs to
use BDF as seen inside stubdomain (connected via xen-pcifront), which is
different from the real BDF. For other purposes (hypercall parameters
etc), the real BDF needs to be used.
Get the in-stubdomain BDF by looking up relevant PV PCI xenstore
entries.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 hw/xen/xen-host-pci-device.c | 77 +++++++++++++++++++++++++++++++++++-
 hw/xen/xen-host-pci-device.h |  6 +++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716..3f8a6f84a8 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "hw/xen/xen-legacy-backend.h"
 #include "xen-host-pci-device.h"
 
 #define XEN_HOST_PCI_MAX_EXT_CAP \
@@ -33,13 +34,76 @@
 #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
 #define IORESOURCE_MEM_64       0x00100000
 
+static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **errp)
+{
+    unsigned int num_devs, len, i;
+    unsigned int domain, bus, dev, func;
+    char *be_path = NULL;
+    char path[80];
+    char *msg = NULL;
+
+    be_path = qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", &len);
+    if (!be_path)
+        goto err_out;
+    snprintf(path, sizeof(path), "%s/num_devs", be_path);
+    msg = qemu_xen_xs_read(xenstore, 0, path, &len);
+    if (!msg)
+        goto err_out;
+
+    if (sscanf(msg, "%u", &num_devs) != 1) {
+        error_setg(errp, "Failed to parse %s (%s)\n", msg, path);
+        goto err_out;
+    }
+    free(msg);
+
+    for (i = 0; i < num_devs; i++) {
+        snprintf(path, sizeof(path), "%s/dev-%u", be_path, i);
+        msg = qemu_xen_xs_read(xenstore, 0, path, &len);
+        if (!msg) {
+            error_setg(errp, "Failed to read %s\n", path);
+            goto err_out;
+        }
+        if (sscanf(msg, "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+            error_setg(errp, "Failed to parse %s (%s)\n", msg, path);
+            goto err_out;
+        }
+        free(msg);
+        if (domain != d->domain ||
+                bus != d->bus ||
+                dev != d->dev ||
+                func!= d->func)
+            continue;
+        snprintf(path, sizeof(path), "%s/vdev-%u", be_path, i);
+        msg = qemu_xen_xs_read(xenstore, 0, path, &len);
+        if (!msg) {
+            error_setg(errp, "Failed to read %s\n", path);
+            goto out;
+        }
+        if (sscanf(msg, "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+            error_setg(errp, "Failed to parse %s (%s)\n", msg, path);
+            goto err_out;
+        }
+        free(msg);
+        d->local_domain = domain;
+        d->local_bus = bus;
+        d->local_dev = dev;
+        d->local_func = func;
+        goto out;
+    }
+
+err_out:
+    free(msg);
+out:
+    free(be_path);
+}
+
 static void xen_host_pci_sysfs_path(const XenHostPCIDevice *d,
                                     const char *name, char *buf, ssize_t size)
 {
     int rc;
 
     rc = snprintf(buf, size, "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
-                  d->domain, d->bus, d->dev, d->func, name);
+                  d->local_domain, d->local_bus, d->local_dev, d->local_func, name);
     assert(rc >= 0 && rc < size);
 }
 
@@ -342,6 +406,17 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     d->dev = dev;
     d->func = func;
 
+    if (xen_is_stubdomain) {
+        xen_host_pci_fill_local_addr(d, errp);
+        if (*errp)
+            goto error;
+    } else {
+        d->local_domain = d->domain;
+        d->local_bus = d->bus;
+        d->local_dev = d->dev;
+        d->local_func = d->func;
+    }
+
     xen_host_pci_config_open(d, errp);
     if (*errp) {
         goto error;
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 4d8d34ecb0..270dcb27f7 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -23,6 +23,12 @@ typedef struct XenHostPCIDevice {
     uint8_t dev;
     uint8_t func;
 
+    /* different from the above in case of stubdomain */
+    uint16_t local_domain;
+    uint8_t local_bus;
+    uint8_t local_dev;
+    uint8_t local_func;
+
     uint16_t vendor_id;
     uint16_t device_id;
     uint32_t class_code;
-- 
2.43.0


