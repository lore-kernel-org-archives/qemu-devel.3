Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0039BC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaEQ-0003np-5W; Tue, 05 Mar 2024 14:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rhaEM-0003n9-I8
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:13:38 -0500
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rhaEK-0002rp-L7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:13:38 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id C2CF518000D6;
 Tue,  5 Mar 2024 14:13:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 05 Mar 2024 14:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1709666014; x=1709752414; bh=nvOByvjx8k
 WPG63sTIRe1BmgTRsqS6ZcwNedyy8aBUw=; b=L6mvHLd9wrihsHtOosYggrdoiw
 ZFihyd4oYfbtRnm4FKjyjxkTdLCcU25GEKv0b8kZmzHRqwoZbxNvtbMridFrya65
 wXfSegSOTFQ1wKym+NPQFvSZY+Hm6NpcKXMxMJK20PuiLmiLAgtWh4MCrLaiaSSE
 ZImwdSQ3JXurzgEeVa8A0m6cKDInjax1xZ4jfoeUb/NgCYcQ3cbqOz61cxb2ujMB
 d5RQNrt8D4NFDHhZWy+o/znXhLGNHyeLoHJjqwAKoEQgM4Hi53Osu0WqTyo56Jyi
 ItEKIx061RI/IJu9vtyVmrTUCGJ3UsaEqBsYBbUvPjs8K4dNJWIXYTWtHU0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709666014; x=
 1709752414; bh=nvOByvjx8kWPG63sTIRe1BmgTRsqS6ZcwNedyy8aBUw=; b=m
 duf5xbhB+kuAWGNS/+tzky4SMcW1CNQijU+qO3HPNujymJjZjucR9UK/Uf5cLaSk
 rvdUxa6ZGf6zAtaKNOSi3mv8Dkhtx9fcUs7bc4aqWZkLxc35HpG3xzIyPdaQM3Ox
 J5NxLDaur+XqRy+fM2q9GqU5b2uSD3KptMjOeV1cK9GyriupEGZ0yhEFZvXuDrp5
 0f5PYZipxF9g+npcWUKlQzFjiWV4r/5iKD3yCnIPiCdNr1aT2UtaWjwRUVSe2Uyu
 0TWNblTpPydOHrzO14JLfC603glPDk3EjgU+pMorfY3CUC8uYr7pWi/kyR4g+Y/F
 harrfNhgTQHSFkfllWsNA==
X-ME-Sender: <xms:3m7nZWRm49Zp1QEUJuC2yjKAigaPQMSAmucSoDqmYe-E5zEkzSlpJg>
 <xme:3m7nZbyM9jB4SpcOQ8JcB3_GTxNOlAhB9OTzvhqWrHkkhA1Fo_Io0d2NNeqlbp3vx
 wIw9NFRKB4rLA>
X-ME-Received: <xmr:3m7nZT0sGxitUm7P8jKYW1dZfOi6q33gXD9OSAf-lHAP4SjxefitLkfd-du6gtEfAoIGRaKheYe9p2qzql0MO1ZjXcxBR4gTIagCPI72gL8xjkrOPls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghr
 vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
 hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefg
 ueduhefgvdefheehudejheefudevueeghfekhfehleegveduteeuiedugffgffenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgv
 khesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:3m7nZSAQcKD_byCa-aHKFZeHh6NegEEh7Tw2wLIOJMgly-VbYgjYdQ>
 <xmx:3m7nZfhh99cauj60AqUvY3-nLCvebW2RbUivv-FlTUnaLZQ_Fu0gcg>
 <xmx:3m7nZeoi4BcxeME6Yj1K7-wd59RX_Xdj9GzABINaVsbbRkOv_B7kGQ>
 <xmx:3m7nZfi9TJOO3_BeGP0Olp0tiozO7VlSt7z6LzYHfb6lB5GU-apFGFH0MLo>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 14:13:32 -0500 (EST)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: Jason Andryuk <jandryuk@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?=
 <frederic.pierret@qubes-os.org>, 
 =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v2 2/2] xen: fix stubdom PCI addr
Date: Tue,  5 Mar 2024 20:12:30 +0100
Message-ID: <20240305191312.321127-2-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
References: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.156;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfhigh5-smtp.messagingengine.com
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
Changes in v2:
- use xs_node_scanf
- use %d instead of %u to read values written as %d
- add a comment from another iteration of this patch by Jason Andryuk
---
 hw/xen/xen-host-pci-device.c | 69 +++++++++++++++++++++++++++++++++++-
 hw/xen/xen-host-pci-device.h |  6 ++++
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716..8ea2a5a4af 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "hw/xen/xen-legacy-backend.h"
+#include "hw/xen/xen-bus-helper.h"
 #include "xen-host-pci-device.h"
 
 #define XEN_HOST_PCI_MAX_EXT_CAP \
@@ -33,13 +35,67 @@
 #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
 #define IORESOURCE_MEM_64       0x00100000
 
+/*
+ * Non-passthrough (dom0) accesses are local PCI devices and use the given BDF
+ * Passthough (stubdom) accesses are through PV frontend PCI device.  Those
+ * either have a BDF identical to the backend's BDF (xen-backend.passthrough=1)
+ * or a local virtual BDF (xen-backend.passthrough=0)
+ *
+ * We are always given the backend's BDF and need to lookup the appropriate
+ * local BDF for sysfs access.
+ */
+static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **errp)
+{
+    unsigned int num_devs, len, i;
+    unsigned int domain, bus, dev, func;
+    char *be_path = NULL;
+    char path[80];
+
+    be_path = qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", &len);
+    if (!be_path)
+        goto out;
+
+    if (xs_node_scanf(xenstore, 0, be_path, "num_devs", NULL, "%d", &num_devs) != 1) {
+        error_setg(errp, "Failed to read or parse %s/num_devs\n", be_path);
+        goto out;
+    }
+
+    for (i = 0; i < num_devs; i++) {
+        snprintf(path, sizeof(path), "dev-%d", i);
+        if (xs_node_scanf(xenstore, 0, be_path, path, NULL,
+                          "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+            error_setg(errp, "Failed to read or parse %s/%s\n", be_path, path);
+            goto out;
+        }
+        if (domain != d->domain ||
+                bus != d->bus ||
+                dev != d->dev ||
+                func!= d->func)
+            continue;
+        snprintf(path, sizeof(path), "vdev-%d", i);
+        if (xs_node_scanf(xenstore, 0, be_path, path, NULL,
+                          "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+            error_setg(errp, "Failed to read or parse %s/%s\n", be_path, path);
+            goto out;
+        }
+        d->local_domain = domain;
+        d->local_bus = bus;
+        d->local_dev = dev;
+        d->local_func = func;
+        goto out;
+    }
+
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
 
@@ -342,6 +398,17 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
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


