Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1852C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t99-0005wB-Sj; Mon, 06 May 2024 03:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8l-0005nw-Vj
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8k-0001dE-9L
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLtwWTWfNv2VfsTY39DtTXStmqm0cUSHqzSKDrvw7yw=;
 b=M8q1Jx2Z04f/wb2ARp7ElrZ2VwflmeVi39QTSk0wkYRh2dxSw6eoynTD7dUCRY2JdSnQSX
 ubKjQIysQzhi9B6bz1rxGD42xiVTsn8RDUE31aYLyGf9eBJZ/oQli1G4qKDMzI1d7w2Sah
 13P2HtY54h94OHW3+OHe5esidMMlKcs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-lIHBQG9dPbuYH7BYjg2xZg-1; Mon, 06 May 2024 03:51:59 -0400
X-MC-Unique: lIHBQG9dPbuYH7BYjg2xZg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so65095766b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981918; x=1715586718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLtwWTWfNv2VfsTY39DtTXStmqm0cUSHqzSKDrvw7yw=;
 b=Ba7U60HzlLmasRIlLnnrh8+jWP3TXon4SebY3PLzeNXFf+Rligf0HM3Ha0fUnv17Kp
 0GA8CFTRqy/krI5GjPHUAt27s1mxWmMUXLXLn2kHf4BbsOoVHa726Yg+CDyQrxh1en+O
 g5Dx3WkkFp3QmDr5/cFsUQY/sv8M2fHXmx76LkH5p1I0fw3WANquMDG0ferilI9wk4FT
 P9RtG9riC392lFHgaPE8115R3NexAo6SPet745Ih11auP4PjShmd1nfIc5jWTUIBKmEt
 9WXPkd29m378eOlujt9WjtMv15DTC8p0MSgPfJSm0a7Ju4qbzvqkBeKoiPB/rOonW5Or
 cQ4Q==
X-Gm-Message-State: AOJu0YwO/O21wpgEQHrruuvfiI09Ux60arKXyUqF6v3e47InZxeSg6Ad
 NR7QSHmsSmZc0jBpmPzEaYZfigDqf+0YlMA15f1ysdKi03W6byLngR9BWgIkvoFe6tL+wL2y6R8
 zlAIAogwf1XhOL4/wcoeXENhR94uWxe30OfuOUl8NFaoy8V3WlSx6ClE/meEhZA6EJwH/iM172d
 yQNWeodeOC5jXKi+7rbnyDJwNTZVp/ozUzpP4c
X-Received: by 2002:a17:906:3c59:b0:a59:ab57:7418 with SMTP id
 i25-20020a1709063c5900b00a59ab577418mr2632456ejg.71.1714981918341; 
 Mon, 06 May 2024 00:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgCG9AfPlAsDNGUXVrEoK7u/PvLi5jA/zEgiCva7eGVY/2DNlSoCfAtBZwr5hBBo46k+RXFA==
X-Received: by 2002:a17:906:3c59:b0:a59:ab57:7418 with SMTP id
 i25-20020a1709063c5900b00a59ab577418mr2632449ejg.71.1714981917954; 
 Mon, 06 May 2024 00:51:57 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm1510345ejp.80.2024.05.06.00.51.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/46] i386: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:51 +0200
Message-ID: <20240506075125.8238-13-pbonzini@redhat.com>
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with i386.

No changes to generated config-devices.mak files, other than
adding CONFIG_I386 to the x86_64-softmmu target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/i386-softmmu/default.mak | 11 +++++------
 .gitlab-ci.d/buildtest.yml               |  3 ++-
 hw/i386/Kconfig                          | 10 +++++++++-
 target/i386/Kconfig                      |  1 +
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 598c6646dfc..448e3e3b1ba 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -24,9 +24,8 @@
 #CONFIG_VTD=n
 #CONFIG_SGX=n
 
-# Boards:
-#
-CONFIG_ISAPC=y
-CONFIG_I440FX=y
-CONFIG_Q35=y
-CONFIG_MICROVM=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_ISAPC=n
+# CONFIG_I440FX=n
+# CONFIG_Q35=n
+# CONFIG_MICROVM=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 6531758d968..75222c4450b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,7 +648,8 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm
+# requires libfdt: aarch64, arm, i386, x86_64
+# does not build without boards: i386, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6ee052f9a1..4362164962c 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -66,6 +66,8 @@ config PC_ACPI
 
 config I440FX
     bool
+    default y
+    depends on I386
     imply E1000_PCI
     imply VMPORT
     imply VMMOUSE
@@ -81,6 +83,8 @@ config I440FX
 
 config ISAPC
     bool
+    default y
+    depends on I386
     imply VGA_ISA
     select ISA_BUS
     select PC
@@ -91,6 +95,8 @@ config ISAPC
 
 config Q35
     bool
+    default y
+    depends on I386
     imply VTD
     imply AMD_IOMMU
     imply E1000E_PCI_EXPRESS
@@ -108,6 +114,8 @@ config Q35
 
 config MICROVM
     bool
+    default y
+    depends on I386
     select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
     select APIC
@@ -142,4 +150,4 @@ config VMMOUSE
 config XEN_EMU
     bool
     default y
-    depends on KVM && (I386 || X86_64)
+    depends on KVM && I386
diff --git a/target/i386/Kconfig b/target/i386/Kconfig
index 46898946394..ad9291d3b8f 100644
--- a/target/i386/Kconfig
+++ b/target/i386/Kconfig
@@ -5,3 +5,4 @@ config I386
 
 config X86_64
     bool
+    select I386
-- 
2.44.0


