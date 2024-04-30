Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80143C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rMw-0002Ym-GH; Tue, 30 Apr 2024 13:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s1rMv-0002YB-0i
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:34:17 -0400
Received: from wfhigh8-smtp.messagingengine.com ([64.147.123.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s1rMr-0007wW-29
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:34:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2A6BA1800131;
 Tue, 30 Apr 2024 13:34:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 30 Apr 2024 13:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1714498450; x=1714584850; bh=nuTget59Mx
 Wc4IfoutnOU8Z20vpZN60QWE54LVhF6ms=; b=t4Ug7DTH9FfnRfuc/DODFmSS+l
 mD3jFWNfTrDtk7In2zJy+/OPeCt3KXtdl2nJV4pPZ2pvRXZrzLRMaQ4HSJh2nmh0
 V5gEtjUJIw9ZR7MvqvJgq4O+gGn7AcMRtE/Z1CXm3dUdod15IuAk59wpsntnewXt
 WTuR8l8zcOqHlNITJrI2WGfCL9LTNvJrfdZIXIotk+26lkHQJ1fwnUhSgllKhIQY
 WzAMxX0WVQx6yRos3yZfcn29od3bqXl2hh+aIr8v7tigAEI/8wfIAaXcwpQukTOK
 aR9Z3QgUv9XdkNhO7eVOd5bKqcf9rjUNAM35ioRx88Gnk345JrHRpZ2aXUpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714498450; x=
 1714584850; bh=nuTget59MxWc4IfoutnOU8Z20vpZN60QWE54LVhF6ms=; b=M
 a5VxVonW0Qm9fs0XA8C4EYYeA8DQOTjBKfXaGV/IyykiUtCZvtyM/uTomp4mv1fn
 dRdED+lgGT4CKODfGELmTYvp7vP6OTKsISeGWLdzSTEZO7wY3tUS3wsdAojn4SO2
 rbFknN3N+VsLGoW4xZ+csJs64Hm21a33zH94MPXbzfU7vahcAVrRjSE1iBEzTPiT
 CZ9/tvnSkkAJsp6ZU7j2SwY3/xC2nzylX1sEZdGPGGhVU/Qxf8UAXZXdgMDG+7VT
 eLeS0QMaUQbrJLxdg7fhC7q6D8fG0sWT0AX1lAy8PhmERJ+colLa7cCICJUEvNhO
 OS6YCyB70T/AkM8N25Qkw==
X-ME-Sender: <xms:kisxZh0Fo4lMf2nSVZu4SyOZzK5kxzdH4kL7NUyeoyW_z_QEKVRf3w>
 <xme:kisxZoFXszW32A-TTvRXzlkKiPhNl1JIWJlD_SAXzAF3l93G0wzyAnVx7IboPNH1Q
 SaacV4Rs8Fu6Q>
X-ME-Received: <xmr:kisxZh6ARn4DD695f7h_6_8F0pjACmIStS_M2ww1QwIZYOwK-Awkhu7Qvy0CoZGokGlr3zIG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgudduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgr
 rhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghkse
 hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhep
 gfeuudehgfdvfeehhedujeehfeduveeugefhkefhheelgeevudetueeiudfggfffnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghr
 vghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:kisxZu3sqn_kCe8IxidhA89Idnv0ff0ssnKP-hyd_Tf7SHZfsV_R2w>
 <xmx:kisxZkGTYxkpPG3HIUpIsg4xKpQrvThJLiq8_IfLB-VEPeFSYyHTSA>
 <xmx:kisxZv-0hOQmKdJXx-FMJwXnhHoWnVA5ASLPzuKTBB7f7KGfdqEm0w>
 <xmx:kisxZhm8z_a6Ti25Z7Dr_DceznWeqzME7RGli6flyZ_b-qySe4Wh0Q>
 <xmx:kisxZpNap_XR-F0uWa0HzYv_wpAK3Kh1uxNyGxxn6LOlhSlJkfvFeHtC>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 13:34:09 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v2 1/3] hw/xen/xen_pt: Save back data only for declared
 registers
Date: Tue, 30 Apr 2024 19:33:09 +0200
Message-ID: <3cc5a7d2e0338112fb87806c813627bdf5dbd2a5.1714498385.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.ea761e8c87cc41550b01d6fbc1cd1116af55e288.1714498385.git-series.marmarek@invisiblethingslab.com>
References: <cover.ea761e8c87cc41550b01d6fbc1cd1116af55e288.1714498385.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.159;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfhigh8-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Call pci_default_write_config() in xen_pt_pci_write_config() only for
registers that have matching XenPTRegInfo structure, and do that only after
resolving any custom handlers. This is important for two reasons:
1. XenPTRegInfo has ro_mask which needs to be enforced - Xen-specific
   hooks do that on their own (especially xen_pt_*_reg_write()).
2. Not setting value early allows hooks to see the old value too.

If it would be only about the first point, setting PCIDevice.wmask would
probably be sufficient, but given the second point, restructure those
writes.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
v2:
 - rewrite commit message, previous one was very misleading
 - fix loop saving register values
 - fix int overflow when calculating write mask
---
 hw/xen/xen_pt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b..cea2e18 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -256,6 +256,7 @@ static void xen_pt_pci_write_config(PCIDevice *d, uint32_t addr,
     uint32_t find_addr = addr;
     XenPTRegInfo *reg = NULL;
     bool wp_flag = false;
+    uint32_t emul_mask = 0, write_val;
 
     if (xen_pt_pci_config_access_check(d, addr, len)) {
         return;
@@ -311,7 +312,6 @@ static void xen_pt_pci_write_config(PCIDevice *d, uint32_t addr,
     }
 
     memory_region_transaction_begin();
-    pci_default_write_config(d, addr, val, len);
 
     /* adjust the read and write value to appropriate CFC-CFF window */
     read_val <<= (addr & 3) << 3;
@@ -371,6 +371,9 @@ static void xen_pt_pci_write_config(PCIDevice *d, uint32_t addr,
                 return;
             }
 
+            emul_mask |= ((1L << (reg->size * 8)) - 1)
+                         << ((find_addr & 3) * 8);
+
             /* calculate next address to find */
             emul_len -= reg->size;
             if (emul_len > 0) {
@@ -397,6 +400,25 @@ static void xen_pt_pci_write_config(PCIDevice *d, uint32_t addr,
     /* need to shift back before passing them to xen_host_pci_set_block. */
     val >>= (addr & 3) << 3;
 
+    /* store emulated registers after calling their handlers */
+    write_val = val;
+    for (index = 0; index < len; index += emul_len) {
+        emul_len = 0;
+        while (emul_mask & 0xff) {
+            emul_len++;
+            emul_mask >>= 8;
+        }
+        if (emul_len) {
+            uint32_t mask = ((1L << (emul_len * 8)) - 1);
+            pci_default_write_config(d, addr + index, write_val & mask,
+                                     emul_len);
+        } else {
+            emul_mask >>= 8;
+            emul_len = 1;
+        }
+        write_val >>= emul_len * 8;
+    }
+
     memory_region_transaction_commit();
 
 out:
-- 
git-series 0.9.1

