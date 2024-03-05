Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F15C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaEO-0003nK-E4; Tue, 05 Mar 2024 14:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rhaEM-0003n1-9n
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:13:38 -0500
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rhaEK-0002rf-2v
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:13:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.west.internal (Postfix) with ESMTP id 9573F18000D5;
 Tue,  5 Mar 2024 14:13:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 05 Mar 2024 14:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1709666011; x=1709752411; bh=VSUlkpuYOEcRplvlXrjlVafcExCQb+jf
 CPZC81dIcIs=; b=EVK+O2lxJWxJMjL8Oz2Ln1tBkVKuV/WmtIkwnGMYtjdQR57j
 6RJ3sUPaktu1KQ/hDsH9MuntTEwWscWxOpyXdZAVeR1HDGm2Vlg7Hd7lph9Bunjg
 rUGQlXZN5DauNZchbhTVNcVPEMuusvo7zB3+w/4+42WmfPwse7zXdmkC65kBoO0y
 Yxh8fdzLB+w60FMcxA+qsaE+ShPFWsFvc06lN3mXV6hnKezs+W2nXrp6QfiOj563
 ExhpFgwLMfjuabTXq1fSXwKsy4M94aMYqBnrnoKvnVgQJ3QLUVsVt6ChzGwBnze3
 t0FGKN9t/kKdW1veUNNBJiyIQJcd6VTiBxxzXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1709666011; x=1709752411; bh=VSUlkpuYOEcRp
 lvlXrjlVafcExCQb+jfCPZC81dIcIs=; b=qkaTI3+FUieGvdWlljrO44qas8wzF
 irqTvhOq699K6VfLAbSR/soYcSPh1/aJOOwr8zhS6VFx9GqpV7psSo1WYfMuvqLk
 0gry0PSzPdRUHlWsAc8JHcZTPx3JDLe0iOJ9xDSrn+I80hgV8sRedfNZGxNs9ROY
 a66VjjnjxaYn/1H0aT72UOVsmRgN5U3/70EYi516VZg8Ax4C8F0yVO6H4QNzRrU8
 EZMsnWumZa1D72vAAoIl3h0Xith7VTGL1jYIqJ9C/XEzaPecFRqX4+ZPfTUNAgjT
 MX2rXHJtuPSOF8s0yWdRwcqHC/hfCv3QSYmwaKjqAByXdC1HwJMtgU0sA==
X-ME-Sender: <xms:2m7nZWE1lza5p4rOPJy3hgNffTitUBYBk9yK4303__vLkAY2fcodAw>
 <xme:2m7nZXX8uLPnDITswcN8q8nxvjbhA9-xj6QaY8AqgUTxNpWGHNhgAI_gi1C0HD2NL
 XovxQkVWaWsug>
X-ME-Received: <xmr:2m7nZQL00OE653sb9kpyBCZPtFycLXDKbZCGWsZE8NGM98d-TyNhBpPucqxdfxaSjWvQzBVXK-2zOHPgS9iyfv6OnMdVjOk1Hkci3ws0Uz0c1rf5Q6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelkefh
 udelteelleelteetveeffeetffekteetjeehlefggeekleeghefhtdehvdenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
 ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:2m7nZQEd7dNhshAAvFLNNCvQ-8It477Pz5wWmFrVNwlOxAFMK5U6EQ>
 <xmx:2m7nZcUDNBuOd5a7NfbfwM1hdk0U_lsKny4TQxo2RFulxHpYLrmlmg>
 <xmx:2m7nZTM1CyHc4nF0cUbAjzYBmYLIpPmKJ4f8cnGJTxbhauDFM5s5kA>
 <xmx:227nZeK0MEbDpp6aBs-zT9bA32nfgte8re4UnPZWUlCinDdkHuFWFesaclE>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 14:13:29 -0500 (EST)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: Jason Andryuk <jandryuk@gmail.com>,
 =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v2 1/2] hw/xen: detect when running inside stubdomain
Date: Tue,  5 Mar 2024 20:12:29 +0100
Message-ID: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
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

Introduce global xen_is_stubdomain variable when qemu is running inside
a stubdomain instead of dom0. This will be relevant for subsequent
patches, as few things like accessing PCI config space need to be done
differently.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
Changes in v2:
- use sigend int for domid to match xenstore_read_int() types, domid is
  in a signed range anyway
- fix code style
---
 hw/xen/xen-legacy-backend.c | 16 ++++++++++++++++
 include/hw/xen/xen.h        |  1 +
 system/globals.c            |  1 +
 3 files changed, 18 insertions(+)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 124dd5f3d6..6bd4e6eb2f 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -603,6 +603,20 @@ static void xen_set_dynamic_sysbus(void)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
 }
 
+static bool xen_check_stubdomain(void)
+{
+    char *dm_path = g_strdup_printf("/local/domain/%d/image", xen_domid);
+    int32_t dm_domid;
+    bool is_stubdom = false;
+
+    if (!xenstore_read_int(dm_path, "device-model-domid", &dm_domid)) {
+        is_stubdom = dm_domid != 0;
+    }
+
+    g_free(dm_path);
+    return is_stubdom;
+}
+
 void xen_be_init(void)
 {
     xenstore = qemu_xen_xs_open();
@@ -616,6 +630,8 @@ void xen_be_init(void)
         exit(1);
     }
 
+    xen_is_stubdomain = xen_check_stubdomain();
+
     xen_sysdev = qdev_new(TYPE_XENSYSDEV);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
     xen_sysbus = qbus_new(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 37ecc91fc3..ecb89ecfc1 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -36,6 +36,7 @@ enum xen_mode {
 extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
 extern bool xen_domid_restrict;
+extern bool xen_is_stubdomain;
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 int xen_set_pci_link_route(uint8_t link, uint8_t irq);
diff --git a/system/globals.c b/system/globals.c
index b6d4e72530..ac27d88bd4 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -62,6 +62,7 @@ bool qemu_uuid_set;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_DISABLED;
 bool xen_domid_restrict;
+bool xen_is_stubdomain;
 struct evtchn_backend_ops *xen_evtchn_ops;
 struct gnttab_backend_ops *xen_gnttab_ops;
 struct foreignmem_backend_ops *xen_foreignmem_ops;
-- 
2.43.0


