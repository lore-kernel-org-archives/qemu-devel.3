Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82600C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1c-0005qI-Dk; Tue, 23 Apr 2024 09:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1A-0005HL-Rh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG16-00024n-CE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmVtYtDmh9CH4Dz0ElP8oCAfndmlK0fA6Ny/6wh5zWc=;
 b=JhBDIN4I+8JXugLUqVp14gmHTrZ74JI6rHonmHBmBqIqKXZmFuJVNS9HqQwJuhsxHs3Aef
 OA9krPdek/AgWbMYFqc7KsHrtvzn2ZXyTqCwfssV+Gei8nZYWm2WZa3541VrSura5/oe4m
 GD3RJb6L8CoxWoyetUZTkW7GNqDXex8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-p4pXayTPNkKzzrGhfwAcwA-1; Tue, 23 Apr 2024 09:16:58 -0400
X-MC-Unique: p4pXayTPNkKzzrGhfwAcwA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a5564a2e3a5so389885866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878217; x=1714483017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmVtYtDmh9CH4Dz0ElP8oCAfndmlK0fA6Ny/6wh5zWc=;
 b=n+4uJ7Y0SNcfsc4wF/Dzn8hvCZg06uA5LlgmxImhjE6CjXk6gcVbbDLFM1gM6ikSe6
 4XcHyeEG/gHR72sR5ggmh0XeacF9hLCkhqX6lZbbkkT0OHdGH/beRCycA5kCzPrzN11w
 6KpkjnL+Oz+UFPtrc3l8KTJlnOw5o6mHA6j7PpHUy4kpWHkbsy5SAqV0cbPy5thhv3Jw
 /Q/K0vDdytvYljRTjGF5BBftfWG1i/9kKGIbwRC3+ldHSjXKnxAld8hSpCBnGbUOUSUX
 v4cNj4UCRTPVufLElbNRjNOavi7us9gv2nNIESiXOiTcxu9Gfb+pyn1U87hynh9FEdE1
 ws8Q==
X-Gm-Message-State: AOJu0YwpC4UGRCxjOoedj/pKisiChBrOcbNxQdWU9IdblyNcoerw1GzO
 4txB3LqJxw3dGusmn5RPs1XGQM9vnie2cXkl65y5Sj68Dpe7xHZXQjSIGj7RIZp4hVAmhSyPjwh
 ztQWzQbxY4giAQ6kpW0ygydvnmSM7tjIKfV6I+kW8r649pBcY/LJlijNElmxGUxaDxDwgM8gqXP
 FDaUTV1cU+zycG3p9HESPu7bRGZAF6KLHSx0pB
X-Received: by 2002:a17:906:aa0e:b0:a53:3ffe:e818 with SMTP id
 ko14-20020a170906aa0e00b00a533ffee818mr7472513ejb.77.1713878216805; 
 Tue, 23 Apr 2024 06:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuVrc2vx4WhkuUH+QAAFH1AjApj5Coa1QJb/q+l88RLFK78lk14gQCKhsh78QskpmS7ExknQ==
X-Received: by 2002:a17:906:aa0e:b0:a53:3ffe:e818 with SMTP id
 ko14-20020a170906aa0e00b00a533ffee818mr7472505ejb.77.1713878216491; 
 Tue, 23 Apr 2024 06:16:56 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 qq22-20020a17090720d600b00a554f6fbb25sm7006836ejb.138.2024.04.23.06.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 16/22] riscv: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:06 +0200
Message-ID: <20240423131612.28362-17-pbonzini@redhat.com>
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
Continue with RISC-V.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/riscv32-softmmu/default.mak | 13 ++++++-------
 configs/devices/riscv64-softmmu/default.mak | 15 +++++++--------
 hw/riscv/Kconfig                            | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 15 deletions(-)

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
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5d644eb7b16..b2955a8ae77 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -8,6 +8,8 @@ config IBEX
 
 config MICROCHIP_PFSOC
     bool
+    default y
+    depends on RISCV64
     select CADENCE_SDHCI
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
@@ -20,12 +22,16 @@ config MICROCHIP_PFSOC
 
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
@@ -50,6 +56,8 @@ config RISCV_VIRT
 
 config SHAKTI_C
     bool
+    default y
+    depends on RISCV64
     select RISCV_ACLINT
     select SHAKTI_UART
     select SIFIVE_PLIC
@@ -57,6 +65,8 @@ config SHAKTI_C
 
 config SIFIVE_E
     bool
+    default y
+    depends on RISCV32 || RISCV64
     select RISCV_ACLINT
     select SIFIVE_GPIO
     select SIFIVE_PLIC
@@ -67,6 +77,8 @@ config SIFIVE_E
 
 config SIFIVE_U
     bool
+    default y
+    depends on RISCV32 || RISCV64
     select CADENCE
     select RISCV_ACLINT
     select SIFIVE_GPIO
@@ -83,6 +95,8 @@ config SIFIVE_U
 
 config SPIKE
     bool
+    default y
+    depends on RISCV32 || RISCV64
     select RISCV_NUMA
     select HTIF
     select RISCV_ACLINT
-- 
2.44.0


