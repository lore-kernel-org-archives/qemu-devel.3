Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8F2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t96-0005tr-9e; Mon, 06 May 2024 03:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8f-0005kC-NK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8d-0001ak-Bx
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CW/1kX4ANigUxRpi1OYcRoObb0Qjg2nEgWj2lY20vQ4=;
 b=LdX+lzKtL2XlIQhmlB/Is/BCqgHFTZrAY7ZZ6BJ3CUaJFsY0N0r23jbyvUMmewg2W9n7B9
 UvXgTNJXWGXRLmp4nxs64nyV82FPw2Rt8baPy91UpULgE/8+vW/H2lbTJu9VrNAofPodYK
 Mx9Qq+wbi5cyRk7+y4LH4yrRVc2lu4s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-GLP3x1P0PaCl_CdQccsjXA-1; Mon, 06 May 2024 03:51:50 -0400
X-MC-Unique: GLP3x1P0PaCl_CdQccsjXA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a51fdbd06c8so127629066b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981908; x=1715586708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CW/1kX4ANigUxRpi1OYcRoObb0Qjg2nEgWj2lY20vQ4=;
 b=NiV9G3ZW7cMLnmt/8tfb34MqzVpQTrkOm8uGKmaQRAJ841P+v5X/Ur31xIqK3p0RA9
 AUZj+1vnsx1DgDyGgfORhhe5yecBOc+hanzDn2cmHzfHDvyZzby+wGWFTZek6EXHqOrE
 vHyN/OY9D6d0YI+bQvkoYQRN1nGzG6Ipc+CaBYkpVj/+8ycgdc/9luxf4LD78VWtGgfs
 IgZxFhLmELBA1DC6pISqrGrwp0GEbFE/7Y7Ng9wOpp4gZF+iccS9F72Kx6YU+rt3p5Dy
 NbxaDS5H0SM05DO+VYFBouKAowDDbg9xW3VIMBnCvYMbwi/atrnUxH/Vo1wMYifeuvtL
 YHHg==
X-Gm-Message-State: AOJu0Yyyalk9j1CWoU+7RcD2pvBzRNoedQMksHXBcni5I5wVx9TQsFWb
 8gFEa3ZW5wG6v2+PK93h6ufsr4wWC10LJLg6ww7EKYLG4X3QysD36aEUYPXIe9iuEgG2SgQjsIo
 SF0GNla6PpNvJMtI+Qn1vGKnU63cP/PqtnQaDwsi6fAnpeREcybbIyPCaqQPiXDd2hAwgV0bWyC
 hVsU4El+TSXgnYJ+xWV7XChUL7c20DewFweDCF
X-Received: by 2002:a17:907:724b:b0:a59:b88c:2b2a with SMTP id
 ds11-20020a170907724b00b00a59b88c2b2amr3267938ejc.50.1714981908520; 
 Mon, 06 May 2024 00:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBoPltGXRGumTyJYsUXMm4/PQziMWcmaXmvnlga41lsQIkSyc8SbGS9TMQUw2dA+e+iGCfBQ==
X-Received: by 2002:a17:907:724b:b0:a59:b88c:2b2a with SMTP id
 ds11-20020a170907724b00b00a59b88c2b2amr3267919ejc.50.1714981907915; 
 Mon, 06 May 2024 00:51:47 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a170906135300b00a599e418208sm3304946ejb.9.2024.05.06.00.51.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/46] arm: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:47 +0200
Message-ID: <20240506075125.8238-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For ARM targets, boards that require TCG are already using "default y".
Switch ARM_VIRT to the same selection mechanism.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/arm-softmmu/default.mak | 3 ++-
 .gitlab-ci.d/buildtest.yml              | 1 +
 hw/arm/Kconfig                          | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index c1cfb3bcf75..31f77c20269 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -5,7 +5,8 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-CONFIG_ARM_VIRT=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_ARM_VIRT=n
 
 # These are selected by default when TCG is enabled, uncomment them to
 # keep out of the build.
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index c6c9c242c5c..3a03cdb0151 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,6 +648,7 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
+# requires libfdt: aarch64, arm
 build-without-defaults:
   extends: .native_build_job_template
   needs:
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fe1f9643bd9..98c264ed219 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,5 +1,7 @@
 config ARM_VIRT
     bool
+    default y
+    depends on ARM
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_AMD_XGBE
-- 
2.44.0


