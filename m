Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F39606A88E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=flcZ0Rec
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFl-0007kq-RH; Fri, 13 Nov 2026 13:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFH-0007Im-K8
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFF-0005QA-Uq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jY7cwWDnssXWxeK/VSmybTy70JOwXP4zGPZ9rVcDbc8=;
 b=flcZ0Recnw2MNAMOCRX6qWwe6bgssFuZiC/PxPpQlICPYMWiHGOvlrwcXE6sk0dlfMM2Bq
 Dk+vmjTDqmzxYFHc4nMCkcOqjVPHv4WHuKC6DVnRm5awKmiybVhRi0Q3yBs7US9maZYwEv
 BtUp2R+wozW/ny1tiDRKwoGuz5xXu4g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-zRYqwsSaOsmkinqw_i4UGQ-1; Fri,
 13 Nov 2026 13:43:27 -0500
X-MC-Unique: zRYqwsSaOsmkinqw_i4UGQ-1
X-Mimecast-MFC-AGG-ID: zRYqwsSaOsmkinqw_i4UGQ_1794595407
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E392C195604B
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:26 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A40861955DB9; Fri, 13 Nov 2026 18:43:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 16/26] hw/tpm: mark all TPM implementations as secure
Date: Fri, 13 Nov 2026 18:42:44 +0000
Message-ID: <20261113184254.2524253-17-berrange@redhat.com>
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

All of the TPM implementations are in scope of virtualization
usage, so mark them all as secure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ppc/spapr_tpm_proxy.c | 1 +
 hw/tpm/tpm_crb.c         | 1 +
 hw/tpm/tpm_spapr.c       | 1 +
 hw/tpm/tpm_tis_i2c.c     | 1 +
 hw/tpm/tpm_tis_isa.c     | 1 +
 hw/tpm/tpm_tis_sysbus.c  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 19889e80bc1..bb6efec20c9 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -166,6 +166,7 @@ static const TypeInfo spapr_tpm_proxy_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SpaprTpmProxy),
     .class_init    = spapr_tpm_proxy_class_init,
+    .secure        = true,
 };
 
 static void spapr_tpm_proxy_register_types(void)
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 78db2205207..ab6121ed9e6 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -558,6 +558,7 @@ static const TypeInfo tpm_crb_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(CRBState),
     .class_init  = tpm_crb_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 19075d1f012..3957c5268b7 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -414,6 +414,7 @@ static const TypeInfo tpm_spapr_info = {
     .parent        = TYPE_VIO_SPAPR_DEVICE,
     .instance_size = sizeof(SpaprTpmState),
     .class_init    = tpm_spapr_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index b4f258c7bcb..302296affb6 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -551,6 +551,7 @@ static const TypeInfo tpm_tis_i2c_info = {
     .name          = TYPE_TPM_TIS_I2C,
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(TPMStateI2C),
+    .secure        = true,
     .class_init    = tpm_tis_i2c_class_init,
         .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 2b1267133ac..da3a932b033 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -187,6 +187,7 @@ static const TypeInfo tpm_tis_isa_info = {
     .instance_size = sizeof(TPMStateISA),
     .instance_init = tpm_tis_isa_initfn,
     .class_init  = tpm_tis_isa_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { TYPE_ACPI_DEV_AML_IF },
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index a7b0002d826..0afb52c3be3 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -167,6 +167,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
     .instance_init = tpm_tis_sysbus_initfn,
     .instance_finalize = tpm_tis_sysbus_finalize,
     .class_init  = tpm_tis_sysbus_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
-- 
2.56.1


