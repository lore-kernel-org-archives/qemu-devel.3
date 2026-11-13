Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC67606BDE3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O6hTMMIR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFm-0007mz-Mi; Fri, 13 Nov 2026 13:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFH-0007Ik-Fp
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFE-0005Q2-7p
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQWrbyN03NrE6RccAdvjuCyfjQ0cnSkZs096XP3OYoc=;
 b=O6hTMMIRoZnfl/OaVjW5xX7d86BgEE2lcV/5oZIzE19jlgr448J49wR96vLJasX1V+6+eh
 cGGZd6tDUriRlv10E4Yb/xjqme8mFJKQFVozScO8VjRRsrMad2n2vp8FjtA+hqJRZURpjR
 6HoZSAuQsBypgBXPTZrAZ+nCCk/WV68=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-e3kO1EjPPau4GWILlFSS1A-1; Fri,
 13 Nov 2026 13:43:26 -0500
X-MC-Unique: e3kO1EjPPau4GWILlFSS1A-1
X-Mimecast-MFC-AGG-ID: e3kO1EjPPau4GWILlFSS1A_1794595405
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53F071955E99
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:25 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEB6B1955DB9; Fri, 13 Nov 2026 18:43:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 15/26] hw/display: mark bochs, ramfb and VGA as secure
Date: Fri, 13 Nov 2026 18:42:43 +0000
Message-ID: <20261113184254.2524253-16-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Most of the display adapters are emulating old hardware which is not
relevant to virtualization use cases.

The clear exceptions are the generic, simple devices that should be
considered secure: Bochs, RAMFB, VGA (PCI, not MMIO / ISA).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/bochs-display.c    | 1 +
 hw/display/ramfb-standalone.c | 1 +
 hw/display/vga-pci.c          | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 64e669429c4..5f3ba80f990 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -374,6 +374,7 @@ static const TypeInfo bochs_display_type_info = {
     .instance_size  = sizeof(BochsDisplayState),
     .instance_init  = bochs_display_init,
     .class_init     = bochs_display_class_init,
+    .secure         = true,
     .interfaces     = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 8e8ba37514a..9427009acc8 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -85,6 +85,7 @@ static const TypeInfo ramfb_info = {
     .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(RAMFBStandaloneState),
     .class_init    = ramfb_class_initfn,
+    .secure        = true,
 };
 
 static void ramfb_register_types(void)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index d089847bdae..8559d7aa8f0 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -407,6 +407,7 @@ static const TypeInfo vga_info = {
     .name          = "VGA",
     .parent        = TYPE_PCI_VGA,
     .class_init    = vga_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo secondary_info = {
@@ -414,6 +415,7 @@ static const TypeInfo secondary_info = {
     .parent        = TYPE_PCI_VGA,
     .instance_init = pci_secondary_vga_init,
     .class_init    = secondary_class_init,
+    .secure        = true,
 };
 
 static void vga_register_types(void)
-- 
2.56.1


