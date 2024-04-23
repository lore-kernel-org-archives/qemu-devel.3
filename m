Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8399BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1B-0005HK-2F; Tue, 23 Apr 2024 09:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG18-0005GT-AZ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG14-00024Y-L8
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ix972OjlVv+H+RCINGBZg6nWKRaQ1bOVlFizytKWt6E=;
 b=dveaeeky6rPurAq0pgRtG49Z4C9lI9dOVBjMYH1/NdL2KX3bb8+6Cq66jKeuVKMftkXyWp
 F+Ei9d7O6Evgftf7+ccgxqlroKEzgfSKW/0nE/jUGRn9IX1FmdDA48VluP3MkcghSu6pm8
 eBHl631aS56k+/pInUOyQX3nAmNLLqY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-h0uWz5pGO-aBIhOiNI4Wrw-1; Tue, 23 Apr 2024 09:16:56 -0400
X-MC-Unique: h0uWz5pGO-aBIhOiNI4Wrw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56bf2d59fceso4069296a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878214; x=1714483014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ix972OjlVv+H+RCINGBZg6nWKRaQ1bOVlFizytKWt6E=;
 b=aEdBg4lAbu9Pce2JKhw47fxS1niktIHOfv137GjYYiYA5Sob19Mu6iqqoYi6i930BB
 tk7TeyPJvt+WHkiLT6Kn+lXf6e83HJHxboHps5P4q5dvR29rXVcTXiIvIk9qn086IMV7
 ekYC3N4xAVA9pIDPZY0rwMSu3U98yD6BWyUWTJqhOfbD5oCATpp82T2n4WjWbHr8vpWn
 zyoO01LLqjQoVg//scp9W5BXFmjtgArHKfWJ9uCT30EfLaYxDpwxPOGlZNlV8B71nK7a
 q3lxT5QThqOgjVMVPnfHtXofrO+sdUDaovvHL5ylRD+ii97yqBxO9nxdC1Y9M3qizmmE
 HwNw==
X-Gm-Message-State: AOJu0YwZBSdMRZHiAKC4HdR3+1PXj8S7b3CPD9KOwfJZunzOs5pIV2np
 qIqYxihRCXVvf5kexrI+9OCg1ffQ0zRimXg+c/GuSrq6Maqdu5D1cBxuGXk+Lq3Sieu+7BxKKw+
 3bk2mAcA/W+zO1o2KJAtKcM1o3BS3ubnk9agKR3/anXAiCFSJuXJkbKWz+ze6uncR7LNfl2m6XG
 xiJCZffbCtHHzIF+BQVJ9vM1luPvU5xvcers1z
X-Received: by 2002:a50:8e1a:0:b0:570:5214:f62 with SMTP id
 26-20020a508e1a000000b0057052140f62mr10204847edw.0.1713878214538; 
 Tue, 23 Apr 2024 06:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbL5OHsHA9YlRhIla8gu6FfhnaSGqCb1jfJaxyrcJIpQvgHYCqfUaMPcplFjTrM3HJQKOj0w==
X-Received: by 2002:a50:8e1a:0:b0:570:5214:f62 with SMTP id
 26-20020a508e1a000000b0057052140f62mr10204835edw.0.1713878214225; 
 Tue, 23 Apr 2024 06:16:54 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 eg13-20020a056402288d00b00572224855b8sm573762edb.27.2024.04.23.06.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 15/22] ppc: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:05 +0200
Message-ID: <20240423131612.28362-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Continue with PowerPC/POWER.

No changes to generated config-devices.mak files, other than
adding CONFIG_PPC to the ppc64-softmmu target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/ppc-softmmu/default.mak   | 26 ++++++++++++-----------
 configs/devices/ppc64-softmmu/default.mak |  8 +++----
 hw/ppc/Kconfig                            | 26 +++++++++++++++++++++++
 target/ppc/Kconfig                        |  1 +
 4 files changed, 44 insertions(+), 17 deletions(-)

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


