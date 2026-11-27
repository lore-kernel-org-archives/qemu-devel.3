Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1E606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWpzr3/2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWx8i-0003TX-6j; Fri, 27 Nov 2026 09:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWx8X-0003Sp-C9
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWx8U-0007bc-UG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795790474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTbgwhmSpTd9eg2qLGpW3Upaf3EmO0MwLQYWFdZu9RQ=;
 b=hWpzr3/2VySsRvBDD3mIuhDBe2Csl+QC29gobxl+w77WZRFTgG8bIQxF9nyfBiqX3L44Ok
 E6D1o4BYDqlYQYSSHVWUl3XREY2A5VB/tmJiun7+Mjsh5P38SVu5Bbfhl78NJfvANVNq6S
 7k0vbZhhxTX6QpJAvLoBh6jxY/qFYFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-7nhMlRYGMDaT0tUUQxEjVw-1; Fri,
 27 Nov 2026 14:41:06 +0000
X-MC-Unique: 7nhMlRYGMDaT0tUUQxEjVw-1
X-Mimecast-MFC-AGG-ID: 7nhMlRYGMDaT0tUUQxEjVw_1795790465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DE101955DA0; Fri, 27 Nov 2026 14:41:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FB6A1801977; Fri, 27 Nov 2026 14:41:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] hw/i386: Remove the code of the obsolete pc-q35-4.1 and
 pc-i440fx-4.1 machines
Date: Fri, 27 Nov 2026 15:40:58 +0100
Message-ID: <20261127144059.278754-2-thuth@redhat.com>
In-Reply-To: <20261127144059.278754-1-thuth@redhat.com>
References: <20261127144059.278754-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

These machines have been disabled already since they are older
than 6 years. Let's clean up the related code now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 3 ---
 hw/i386/pc_piix.c    | 9 ---------
 hw/i386/pc_q35.c     | 9 ---------
 4 files changed, 24 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 844ae835784..4aa5b02fe35 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -277,9 +277,6 @@ extern const size_t pc_compat_5_0_len;
 extern GlobalProperty pc_compat_4_2[];
 extern const size_t pc_compat_4_2_len;
 
-extern GlobalProperty pc_compat_4_1[];
-extern const size_t pc_compat_4_1_len;
-
 #define DEFINE_PC_MACHINE_EXTENDED(suffix, namestr, initfn, optsfn, issecure) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4737eb471c1..d14a8210641 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -182,9 +182,6 @@ GlobalProperty pc_compat_4_2[] = {
 };
 const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
 
-GlobalProperty pc_compat_4_1[] = {};
-const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 446590e4e55..6d04d1c75be 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -622,15 +622,6 @@ static void pc_i440fx_machine_4_2_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(4, 2);
 
-static void pc_i440fx_machine_4_1_options(MachineClass *m)
-{
-    pc_i440fx_machine_4_2_options(m);
-    compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
-}
-
-DEFINE_I440FX_MACHINE(4, 1);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c3ce9c56492..e6a6c711f47 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -598,12 +598,3 @@ static void pc_q35_machine_4_2_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(4, 2);
-
-static void pc_q35_machine_4_1_options(MachineClass *m)
-{
-    pc_q35_machine_4_2_options(m);
-    compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
-}
-
-DEFINE_Q35_MACHINE(4, 1);
-- 
2.56.1


