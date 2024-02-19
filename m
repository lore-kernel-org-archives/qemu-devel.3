Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4A6C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8CN-0003MX-VB; Mon, 19 Feb 2024 13:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rc8CH-0003M9-W9
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:16:58 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rc8CG-0004gZ-3c
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:16:57 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 722FE3200922;
 Mon, 19 Feb 2024 13:16:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 19 Feb 2024 13:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1708366611; x=1708453011; bh=Uo8NGN15Y+wR+Mg2EFtNRg5h410lOfUh
 X9FiMUkUpNM=; b=ePuwMlpkFCfcozI+MhZqTBm/Dg8ocqkEHLyQsWztZqNGpe9s
 nCqPrTjcFqSoUCgm04bnW1Yymew4DGgov8d55FlgtUzGeq5mFqkbCDDdPb74gbRb
 8181nh6MIynBD3h22iGeiLurm0BK3Xcb/FMpihuMHPK2n52+7z4J0t7c98jcLFch
 wqcQDmy/iUeSLMYlPzTc1EtYqrrfflSGCg+UZgLG5GdUPO9badV6jAKGmfTCa7iX
 KCsn/kiovcGBl2CXn2PHaEDDynOt/ncBEThP+jYpdzujAkLb4AqhG+sVC887CwWl
 o2XERoGrbgTVPWr6Dte/6tYGLYUCGZFw2fM+9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1708366611; x=1708453011; bh=Uo8NGN15Y+wR+
 Mg2EFtNRg5h410lOfUhX9FiMUkUpNM=; b=NwiBHl2JlPG4RfBLrLc3Di0dZEGVk
 1sxrKKmwlUQgPG5xaTShd7X6H56R1Ug/GnCCGIZU1P3qBwgQrb3IP1eEchGYJ5c8
 WqeXs9YER/iDyHtzeySPS/sZsXeEwJl1p0sL5z7Qg6tMk9QoWnO1Rovw6reHREUz
 r5/WwlnAPPVlNWqlVCT05NuUaz1FKPbhaLFaOjhJSOhkqVddHZlrUB1hYRzc/qk2
 Oc2EAiiC46G+AQ1WZRQ+dzeJgfAjr1C7gk+8AdJTjg0rwVNqyBqCDoDm7hoDKrw0
 yo5oRXjabMXLNexRNy8Lh3dkxT9NadIWrz5jse8jAGD+gmTFCOIdvnf0Q==
X-ME-Sender: <xms:E5vTZfqMG8b-uLaFuCcGyr3VfYk09m_3_nyKYJJsNy-dLZZOuQcjcg>
 <xme:E5vTZZq-0ST2NthJrPCm1Yh5tCuFztXwviIqJ9s1Dw-pxYbGfzdDMZjS2SuBLAbdF
 uRJ5_ysYr9etg>
X-ME-Received: <xmr:E5vTZcPb5FccXDpLCin3inCl0UXD9OP6FeWVQUtBIpUY2FBK6V57og2HDpI3e3s4pdipexfHOunEGZnoUlCh6WX74CzlkqbIQOCAWPUrN4yWus9DQbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelkefh
 udelteelleelteetveeffeetffekteetjeehlefggeekleeghefhtdehvdenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
 ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:E5vTZS4wigD3HxxyaUXVa3yrppnf2lVQzErSE97wvRlJ51bq0Oz4tA>
 <xmx:E5vTZe6by-yFSfjQZqBAdQM-IPOa9iatqsDrOjZRjjr_zCrKbYxjyw>
 <xmx:E5vTZajUF2XL490zVSESdjVosKLRrVwYEAqNkzY8vDbh-qqhjcVG4w>
 <xmx:E5vTZZ3vBlgtfMM6kfe-6PiIL-_US0XMQeXbwFkeQvjM4BfuFO71ww>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 13:16:50 -0500 (EST)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 1/2] hw/xen: detect when running inside stubdomain
Date: Mon, 19 Feb 2024 19:16:05 +0100
Message-ID: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.21;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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
 hw/xen/xen-legacy-backend.c | 15 +++++++++++++++
 include/hw/xen/xen.h        |  1 +
 system/globals.c            |  1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 124dd5f3d6..4a09ea2561 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -603,6 +603,19 @@ static void xen_set_dynamic_sysbus(void)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
 }
 
+static bool xen_check_stubdomain(void)
+{
+    char *dm_path = g_strdup_printf("/local/domain/%d/image", xen_domid);
+    uint32_t dm_domid;
+    bool is_stubdom = false;
+
+    if (!xenstore_read_int(dm_path, "device-model-domid", &dm_domid))
+        is_stubdom = dm_domid != 0;
+
+    g_free(dm_path);
+    return is_stubdom;
+}
+
 void xen_be_init(void)
 {
     xenstore = qemu_xen_xs_open();
@@ -616,6 +629,8 @@ void xen_be_init(void)
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


