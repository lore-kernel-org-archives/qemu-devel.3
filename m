Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202B7C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9B-0005xr-5q; Mon, 06 May 2024 03:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t95-0005th-Nd
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t90-0001fW-Mp
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2O6NkoKmrksa12eVEharYVLqF8b32WlHGoQ/R+mZ2AE=;
 b=iEVY5SOSDSkmkxSxJLDOLYuQ6Mqbsg0SCMDCoo+qbm0Rasr7DcEtdplTugdtrOYjebUQh1
 IGEIKRX2wHD2D3xwUheYyCwqupZOd2xhu8QauZzH8JqBBikwngKK/7KsmefGX4lT62Neu0
 7J6I3upHrD2qU22sxhOSavU0bGLtUkY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-6emRyYctNGy4UCknkRyvbg-1; Mon, 06 May 2024 03:52:16 -0400
X-MC-Unique: 6emRyYctNGy4UCknkRyvbg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59ad486084so71590866b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981935; x=1715586735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2O6NkoKmrksa12eVEharYVLqF8b32WlHGoQ/R+mZ2AE=;
 b=ZrMhpU5EV5blfxumT68uG72KDUoovoMO+O59ENks7GuOtszgQ2FIuwDMFvyl7AEBHg
 Av9MNAZetIydPGmm346oJyQNqy980GmHE9dYIMg6cl3ZR/SnIYCnylkhVUjc1rsATuah
 zQvaSe6KK6MWsd5mghHUcX7V72VhGkTi0SmgrjMoC89zI61vOkUSlybPWy2kfUh1090Z
 ic5S5m9WfvcdpKB6YRgBXCiUita1SATeQaF08n/gUqQk/zYH2ODno1WTpR56elw/eVUn
 kN60CcVjlCnfV8vBJUwBw6HqaTMr0Ignrwa8snWWPablK5K4DDoT4KR56aP3UW+NQLT5
 nV7Q==
X-Gm-Message-State: AOJu0YxCu6dJNWD607e5omPyLyAGUhrEQtXIgZOIykWvf80zhsmPVEex
 ssKxyykjbHcE1hekwTzTMH0OmFHyR6Y1pD7KoFxTS2I+boD5RrSQ16kPAapIzQjncmRvPlUYhoW
 IWsg9Ml1aCXzg5rkGLAZh3sSABlMcUmZbi5FYfEkVS05khPgTMAnjamUuf3p62KUSV640Vk+Vpd
 WspmJmMhFq9prDRN3X9i5aKgvB6toYxZNCgPLP
X-Received: by 2002:a17:906:19d7:b0:a59:a8a4:a5a0 with SMTP id
 h23-20020a17090619d700b00a59a8a4a5a0mr3503942ejd.36.1714981935193; 
 Mon, 06 May 2024 00:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmoGLiWDHzydWXV6uKXo1yW7H+wLVfziRcfKHjcay8cZumtiJRRVSTNbNu3r8Bz/D09ekmiQ==
X-Received: by 2002:a17:906:19d7:b0:a59:a8a4:a5a0 with SMTP id
 h23-20020a17090619d700b00a59a8a4a5a0mr3503923ejd.36.1714981934600; 
 Mon, 06 May 2024 00:52:14 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170906c30a00b00a59a08c722fsm3148752ejz.184.2024.05.06.00.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/46] ppc: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:58 +0200
Message-ID: <20240506075125.8238-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Continue with PowerPC/POWER.

No changes to generated config-devices.mak files, other than
adding CONFIG_PPC to the ppc64-softmmu target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/ppc-softmmu/default.mak   | 26 ++++++++++++-----------
 configs/devices/ppc64-softmmu/default.mak |  8 +++----
 .gitlab-ci.d/buildtest.yml                |  2 +-
 hw/ppc/Kconfig                            | 26 +++++++++++++++++++++++
 target/ppc/Kconfig                        |  1 +
 5 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index 3061b26749a..460d15e676b 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -4,22 +4,24 @@
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
-# For embedded PPCs:
-CONFIG_E500PLAT=y
-CONFIG_MPC8544DS=y
-CONFIG_PPC405=y
-CONFIG_PPC440=y
-CONFIG_VIRTEX=y
+# Boards are selected by default, uncomment to keep out of the build.
+
+# Embedded PPCs:
+# CONFIG_E500PLAT=n
+# CONFIG_MPC8544DS=n
+# CONFIG_PPC405=n
+# CONFIG_PPC440=n
+# CONFIG_VIRTEX=n
 
 # For Sam460ex
-CONFIG_SAM460EX=y
+# CONFIG_SAM460EX=n
 
 # For Macs
-CONFIG_MAC_OLDWORLD=y
-CONFIG_MAC_NEWWORLD=y
+# CONFIG_MAC_OLDWORLD=n
+# CONFIG_MAC_NEWWORLD=n
 
-CONFIG_AMIGAONE=y
-CONFIG_PEGASOS2=y
+# CONFIG_AMIGAONE=n
+# CONFIG_PEGASOS2=n
 
 # For PReP
-CONFIG_PREP=y
+# CONFIG_PREP=n
diff --git a/configs/devices/ppc64-softmmu/default.mak b/configs/devices/ppc64-softmmu/default.mak
index b90e5bf4558..e8ad2603133 100644
--- a/configs/devices/ppc64-softmmu/default.mak
+++ b/configs/devices/ppc64-softmmu/default.mak
@@ -3,8 +3,6 @@
 # Include all 32-bit boards
 include ../ppc-softmmu/default.mak
 
-# For PowerNV
-CONFIG_POWERNV=y
-
-# For pSeries
-CONFIG_PSERIES=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_POWERNV=n
+# CONFIG_PSERIES=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 49cd50c354d..a5f4b4d3793 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -649,7 +649,7 @@ build-tci:
 
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   mips64el, or1k, x86_64
+#   mips64el, or1k, ppc, ppc64, x86_64
 # does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 37ccf9cdcaf..78f83e78ce5 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -1,5 +1,7 @@
 config PSERIES
     bool
+    default y
+    depends on PPC64
     imply USB_OHCI_PCI
     imply PCI_DEVICES
     imply TEST_DEVICES
@@ -23,6 +25,8 @@ config SPAPR_RNG
 
 config POWERNV
     bool
+    default y
+    depends on PPC64
     imply PCI_DEVICES
     imply TEST_DEVICES
     select ISA_IPMI_BT
@@ -38,6 +42,8 @@ config POWERNV
 
 config PPC405
     bool
+    default y
+    depends on PPC
     select M48T59
     select PFLASH_CFI02
     select PPC4XX
@@ -45,6 +51,8 @@ config PPC405
 
 config PPC440
     bool
+    default y
+    depends on PPC
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply E1000_PCI
@@ -62,6 +70,8 @@ config PPC4XX
 
 config SAM460EX
     bool
+    default y
+    depends on PPC
     select PFLASH_CFI01
     select IDE_SII3112
     select M41T80
@@ -75,6 +85,8 @@ config SAM460EX
 
 config AMIGAONE
     bool
+    default y
+    depends on PPC
     imply ATI_VGA
     select ARTICIA
     select VT82C686
@@ -82,6 +94,8 @@ config AMIGAONE
 
 config PEGASOS2
     bool
+    default y
+    depends on PPC
     imply ATI_VGA
     select MV64361
     select VT82C686
@@ -90,6 +104,8 @@ config PEGASOS2
 
 config PREP
     bool
+    default y
+    depends on PPC
     imply PCI_DEVICES
     imply TEST_DEVICES
     select CS4231A
@@ -106,6 +122,8 @@ config RS6000_MC
 
 config MAC_OLDWORLD
     bool
+    default y
+    depends on PPC
     imply PCI_DEVICES
     imply SUNGEM
     imply TEST_DEVICES
@@ -117,6 +135,8 @@ config MAC_OLDWORLD
 
 config MAC_NEWWORLD
     bool
+    default y
+    depends on PPC
     imply PCI_DEVICES
     imply SUNGEM
     imply TEST_DEVICES
@@ -147,14 +167,20 @@ config E500
 
 config E500PLAT
     bool
+    default y
+    depends on PPC
     select E500
 
 config MPC8544DS
     bool
+    default y
+    depends on PPC
     select E500
 
 config VIRTEX
     bool
+    default y
+    depends on PPC
     select PPC4XX
     select PFLASH_CFI01
     select SERIAL
diff --git a/target/ppc/Kconfig b/target/ppc/Kconfig
index 3ff152051a3..0283711673e 100644
--- a/target/ppc/Kconfig
+++ b/target/ppc/Kconfig
@@ -3,3 +3,4 @@ config PPC
 
 config PPC64
     bool
+    select PPC
-- 
2.44.0


