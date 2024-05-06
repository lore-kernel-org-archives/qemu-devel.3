Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE10C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9H-0006De-MB; Mon, 06 May 2024 03:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t97-0005uM-4W
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t95-0001h6-GL
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCgAKilFMtFyGnLR98ktMLMEg7TiqKvecQepTbmci8Q=;
 b=JOk1NQhXoaVBh7sVZYyVBqoSAijGo1kYHThjmkpCS+S4gpZRSp9Nl6GlqAyao/l4doP9ij
 GkvW5IWCJtWlEGNP3l8MVB+vkx8kWIIfIBq42a1Koc4b2d5cAdnZiZ40KDjp2bncdAw6Ev
 d57Q1mykU6eGSNry+lsMXqeoRnEdsM4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-BLgFiuNtMuqOZKaNYMxxkQ-1; Mon, 06 May 2024 03:52:18 -0400
X-MC-Unique: BLgFiuNtMuqOZKaNYMxxkQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572a98b4020so822929a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981937; x=1715586737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCgAKilFMtFyGnLR98ktMLMEg7TiqKvecQepTbmci8Q=;
 b=Wh0tcb9sz6AB52cqx26zC4dSwyPW9upchSlQkvzHkh6S85evjSi0lSli/PX2z+dhpI
 1xlmR2DBNT8IkbNWmcDNcO+CJLaU1J3m4CIc/Fr+S/5Dq/Iewj8fqYJHHEERpt4jdOYu
 +yvo5Jam1ZIWPTaCf9n1svbdN8J2vPNDug0iCtjrjM7yZEnerxDr+Th2E19Ps0nilTAu
 jflfvaUKIESrCNSPFcahFH3UL8b1+1TqADbKwtRVNOVHm8k1RDxMXgJn7dUCD0FAKl3w
 Vy+4JMI1bcO3wlLPTk++9TlZJ5P6Eh9eoDiBB9xHfdhxjS1SifYhn3rYuvFP3+uoqSBn
 8J2A==
X-Gm-Message-State: AOJu0YxA7O1wMeloHj+3/jomzGz/kaDv1VwfZdgIWBLUFXbENtjHGFAK
 nbHrZ1qMYEUWM0nnwrLLyxwoP7FM7Pup7RNIoYt/SeqnaqIbDaJ2QqxQo1mLs+PZwTZqStaVwOX
 tCUk3J+GXJZpGOyOPTYIq22hBBfzLYSQgSmOZFbdMmhtqaw2PjWpqkPlVG+mCP7f99waBQv9nvZ
 xbrffHxxorV/ezjUnhp3zcwQNwu6N42wMENHbH
X-Received: by 2002:a50:99d8:0:b0:56c:d47:e403 with SMTP id
 n24-20020a5099d8000000b0056c0d47e403mr5838528edb.28.1714981937437; 
 Mon, 06 May 2024 00:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMVJ1toRyPZ/8sV9SH+Ji+ajKkaP/dhcVhLvj9diMv9vn/FcANNl2HJ0F1yD89gwHIuWbwfw==
X-Received: by 2002:a50:99d8:0:b0:56c:d47:e403 with SMTP id
 n24-20020a5099d8000000b0056c0d47e403mr5838511edb.28.1714981937055; 
 Mon, 06 May 2024 00:52:17 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a0564020f0f00b005726dceb2easm4907453eda.20.2024.05.06.00.52.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/46] riscv: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:59 +0200
Message-ID: <20240506075125.8238-21-pbonzini@redhat.com>
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
Continue with RISC-V.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/riscv32-softmmu/default.mak | 13 ++++++-------
 configs/devices/riscv64-softmmu/default.mak | 15 +++++++--------
 .gitlab-ci.d/buildtest.yml                  |  2 +-
 hw/riscv/Kconfig                            | 14 ++++++++++++++
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/devices/riscv32-softmmu/default.mak
index 07e4fd26df3..c2cd86ce05f 100644
--- a/configs/devices/riscv32-softmmu/default.mak
+++ b/configs/devices/riscv32-softmmu/default.mak
@@ -4,10 +4,9 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_SPIKE=y
-CONFIG_SIFIVE_E=y
-CONFIG_SIFIVE_U=y
-CONFIG_RISCV_VIRT=y
-CONFIG_OPENTITAN=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_SPIKE=n
+# CONFIG_SIFIVE_E=n
+# CONFIG_SIFIVE_U=n
+# CONFIG_RISCV_VIRT=n
+# CONFIG_OPENTITAN=n
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index 221963d4c5c..39ed3a0061a 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -4,11 +4,10 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_SPIKE=y
-CONFIG_SIFIVE_E=y
-CONFIG_SIFIVE_U=y
-CONFIG_RISCV_VIRT=y
-CONFIG_MICROCHIP_PFSOC=y
-CONFIG_SHAKTI_C=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_SPIKE=n
+# CONFIG_SIFIVE_E=n
+# CONFIG_SIFIVE_U=n
+# CONFIG_RISCV_VIRT=n
+# CONFIG_MICROCHIP_PFSOC=n
+# CONFIG_SHAKTI_C=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a5f4b4d3793..a65b5fc9560 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -649,7 +649,7 @@ build-tci:
 
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   mips64el, or1k, ppc, ppc64, x86_64
+#   mips64el, or1k, ppc, ppc64, riscv32, riscv64, x86_64
 # does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc72ef03799..5f5f9e31bb0 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -8,6 +8,8 @@ config IBEX
 
 config MICROCHIP_PFSOC
     bool
+    default y
+    depends on RISCV64
     select CADENCE_SDHCI
     select CPU_CLUSTER
     select MCHP_PFSOC_DMC
@@ -21,12 +23,16 @@ config MICROCHIP_PFSOC
 
 config OPENTITAN
     bool
+    default y
+    depends on RISCV32
     select IBEX
     select SIFIVE_PLIC
     select UNIMP
 
 config RISCV_VIRT
     bool
+    default y
+    depends on RISCV32 || RISCV64
     imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
@@ -51,6 +57,8 @@ config RISCV_VIRT
 
 config SHAKTI_C
     bool
+    default y
+    depends on RISCV64
     select RISCV_ACLINT
     select SHAKTI_UART
     select SIFIVE_PLIC
@@ -58,6 +66,8 @@ config SHAKTI_C
 
 config SIFIVE_E
     bool
+    default y
+    depends on RISCV32 || RISCV64
     select RISCV_ACLINT
     select SIFIVE_GPIO
     select SIFIVE_PLIC
@@ -68,6 +78,8 @@ config SIFIVE_E
 
 config SIFIVE_U
     bool
+    default y
+    depends on RISCV32 || RISCV64
     select CADENCE
     select CPU_CLUSTER
     select RISCV_ACLINT
@@ -85,6 +97,8 @@ config SIFIVE_U
 
 config SPIKE
     bool
+    default y
+    depends on RISCV32 || RISCV64
     select RISCV_NUMA
     select HTIF
     select RISCV_ACLINT
-- 
2.44.0


