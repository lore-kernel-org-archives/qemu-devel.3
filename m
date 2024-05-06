Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBF8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9Q-0006dE-VR; Mon, 06 May 2024 03:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9E-00067Y-2P
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9A-0001i9-Tn
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2j7P3TXePI6sdhQMICKDlQARo6sQhFnL+fIFYEDqzOI=;
 b=Jc6JYpjWSzbDm8d02tjWDUvRDaZP95VLfqcyWVAM2z3FpghYN8lNfVPkbEipPuyjQDdZb0
 fxLu8uug26U/jVmlBO17R5hYjj1ZojKObgXzo9cTmhVKARAtn5huSGTvMFKlyTyj8BBuLe
 7nDPeg2r+ZAcA0N8Lg0hpzla76vr/X8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-DF35RQfGPau7W343LxDczg-1; Mon, 06 May 2024 03:52:26 -0400
X-MC-Unique: DF35RQfGPau7W343LxDczg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59cb20ea3bso57586166b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981944; x=1715586744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2j7P3TXePI6sdhQMICKDlQARo6sQhFnL+fIFYEDqzOI=;
 b=C9Vmh/ZAgaNRTBiUr+pwvZKtUhQZa8dmUbNcq1hMx3GGa4QpMm0m/gu6dySWk5YfWN
 asiQl4Xe9wOhDPICRbe0oDa5R+NsENSrPQzgbfR1p2Ml1ofr/Xkd5mbaM/ScX4XiGiey
 JbsYlN8IUWJ8yz50s+LR8MeFVEOLklK2I/47HJNMl3L4+uSl1KPPE8DBNnDG1E8aQ5dt
 6yc/Fn5FMh7cZj7HoprFBWDtMg+rPtAWe9c+zIbe7eM07qIdPJrBsKls06S7qVjEPRhG
 TDQWXkpEC/5z5On/6hUtNhBBnUr+bkAWTXw3ZRpUqQiqaAqJOoDPTTJHZ47c5pHjlKrJ
 ZaMw==
X-Gm-Message-State: AOJu0Yx0/GOeo1qkNYuP6xGe3HwsS3AbKusMLZax9R1A/H1jKSY/ouCZ
 Cp5i7qLvQoDekXty6lthuqfYonDNX5uIGL2ETdqEOWUrfETLaKRr15iANPFj6PaYmBs+rn1PKyB
 dJJBTaYnuCPPyEpSM9wTq4itnywc5Gm503C63a6vWKxz7naoZzUqZPGzy+qavVVrD+Dktvj1R6Z
 PE6l8KMZdY+I1IqT1aE5wvfqnywBWL/k4cBrj4
X-Received: by 2002:a17:906:2bd6:b0:a59:d4f0:cfc3 with SMTP id
 n22-20020a1709062bd600b00a59d4f0cfc3mr752505ejg.59.1714981944323; 
 Mon, 06 May 2024 00:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzO2xg7a/lLihw3DtoyRaN1Fee881hP1Vi2lJBANXR/MrddwW5LRDanE7DmUTHRVcMv0NkJA==
X-Received: by 2002:a17:906:2bd6:b0:a59:d4f0:cfc3 with SMTP id
 n22-20020a1709062bd600b00a59d4f0cfc3mr752486ejg.59.1714981943907; 
 Mon, 06 May 2024 00:52:23 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a1709062b5300b00a59a05a8030sm3157895ejg.25.2024.05.06.00.52.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/46] sh4: switch boards to "default y"
Date: Mon,  6 May 2024 09:51:02 +0200
Message-ID: <20240506075125.8238-24-pbonzini@redhat.com>
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
Continue with SH.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/sh4-softmmu/default.mak | 7 +++----
 .gitlab-ci.d/buildtest.yml              | 3 +--
 hw/sh4/Kconfig                          | 4 ++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/configs/devices/sh4-softmmu/default.mak b/configs/devices/sh4-softmmu/default.mak
index 565e8b0b5df..c06a427053a 100644
--- a/configs/devices/sh4-softmmu/default.mak
+++ b/configs/devices/sh4-softmmu/default.mak
@@ -5,7 +5,6 @@
 #CONFIG_PCI_DEVICES=n
 #CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_R2D=y
-CONFIG_SHIX=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_R2D=n
+# CONFIG_SHIX=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 2475262c5c8..fd665931847 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, loongarch64, s390x, x86_64
+# does not build without boards: i386, loongarch64, s390x, sh4, sh4eb, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -666,7 +666,6 @@ build-without-defaults:
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu
-      sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index e0c4ecd1a53..99a76a94c3f 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -1,5 +1,7 @@
 config R2D
     bool
+    default y
+    depends on SH4
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply RTL8139_PCI
@@ -13,6 +15,8 @@ config R2D
 
 config SHIX
     bool
+    default y
+    depends on SH4
     select SH7750
     select TC58128
 
-- 
2.44.0


