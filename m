Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180AAC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nN-0004AJ-NG; Sun, 12 May 2024 06:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66nL-00046e-EY
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66nJ-0006Bl-Cv
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z95fa2E35Jl4s9V/yvyVBOkIzk4ipLBHiC4HHDcdlo=;
 b=M+uolwmnlZuLOKuIyP6aos6qRoSVELYs0JbgcNtN9rfKKj9Vw+WdTaIkkTTvTiX3MVUKwK
 6wKPXjkvrbypFrv3raVXmS+sfHFGRQA3Mv7gf0omqj7KMysdPt3e3IPFpfjrHMSQLe6rG1
 1V5G/j9z/pID7abPTRhQECuYjWMPZ7U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HdRAi_FBOmCCzo1KS44WlQ-1; Sun, 12 May 2024 06:50:57 -0400
X-MC-Unique: HdRAi_FBOmCCzo1KS44WlQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59d0fb7731so229792466b.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511055; x=1716115855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+z95fa2E35Jl4s9V/yvyVBOkIzk4ipLBHiC4HHDcdlo=;
 b=k5Nh03ptMO8P6bpUPvOc3pLUCbIeKvXfY9ZBWtn867PvqDL6J18ptJc/JxzUc+IP0N
 lStovkb9ujM+Yp9hF6aOVXSq1jZ5UlxgDuPptOxG12y1z9L+J9e0nzqHgq1V737jSLJE
 Z4MFVHlX4GK/JAnDy72DlLC5vcKWmg1dyefysEd4i5R3PF9giTi1LPTJbu5I9ECBwBAH
 s4B23EQN9ZXCDlyb0UcSlXg3/j6Pg0RsM5D0rQ2wue0Geh0rYplrYlM7bjido2zSGJRV
 HWPTqmz8GUWW0IN6Of8k3gnrLaTSwZ61IXwLCJf2lTl2jOuX939VKp7gxsnO+cmkShKV
 TI/g==
X-Gm-Message-State: AOJu0YwjQrtWdKGfYoN2sb1TB7Y3G0P0jQCXOteuWVfmxThrfoyByo13
 /31aEakjAKlLS4oU5joPrzIpDbd9r9rNnZeAM0Np0wTzXzDSknYbzw5V2I0seLjFIeheEWLHgaT
 lQ+kGhYtLwdfHhfLFC7lf6Q7rJudRENZBiwGqUOfRqh79P+8VzD99S4/km0BxlLyLW/LlsBq8c/
 uamGS69D3PO3hLoysGtvw7JDxk8tLGU0TV9qOQ
X-Received: by 2002:a17:906:b0ca:b0:a59:9c58:763a with SMTP id
 a640c23a62f3a-a5a2d5ccb27mr461242166b.46.1715511055632; 
 Sun, 12 May 2024 03:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcKAipnkp9vQkyCl2tbWRqsmQVPcR9QwgosZzXNFoUdCoRqT9XgaPM5bH52OtE/sdU0WnADQ==
X-Received: by 2002:a17:906:b0ca:b0:a59:9c58:763a with SMTP id
 a640c23a62f3a-a5a2d5ccb27mr461241266b.46.1715511055236; 
 Sun, 12 May 2024 03:50:55 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cd85sm450948766b.15.2024.05.12.03.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/27] configs: disable emulators that require it if libfdt is
 not found
Date: Sun, 12 May 2024 12:49:45 +0200
Message-ID: <20240512104945.130198-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

Since boards can express their dependency on libfdt and
system/device_tree.c, only leave TARGET_NEED_FDT if the target has a
hard dependency.

Those emulators will be skipped if libfdt is disabled, or if it
is "auto" and not found and --disable-download is passed; unless
the target is mentioned explicitly in --target-list, in which case
the build will fail.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/aarch64-softmmu.mak      | 1 +
 configs/targets/arm-softmmu.mak          | 1 +
 configs/targets/i386-softmmu.mak         | 1 -
 configs/targets/loongarch64-softmmu.mak  | 1 +
 configs/targets/microblaze-softmmu.mak   | 1 +
 configs/targets/microblazeel-softmmu.mak | 1 +
 configs/targets/mips64el-softmmu.mak     | 1 -
 configs/targets/or1k-softmmu.mak         | 1 +
 configs/targets/ppc-softmmu.mak          | 1 -
 configs/targets/ppc64-softmmu.mak        | 1 +
 configs/targets/riscv32-softmmu.mak      | 1 +
 configs/targets/riscv64-softmmu.mak      | 1 +
 configs/targets/rx-softmmu.mak           | 1 +
 configs/targets/x86_64-softmmu.mak       | 1 -
 meson.build                              | 6 +++++-
 .gitlab-ci.d/buildtest.yml               | 8 ++++----
 16 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 83c22391a69..84cb32dc2f4 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -3,4 +3,5 @@ TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
+# needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index 92c8349b964..bf390b7a8de 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
+# needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index d61b5076134..2ac69d5ba37 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
-TARGET_NEED_FDT=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index f23780fdd89..84beb19b90a 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
+# all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index e84c0cc7283..eea266d4f3d 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=microblaze
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+# needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 9b688036bd3..77b968acad3 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=microblaze
 TARGET_SUPPORTS_MTTCG=y
+# needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 8d9ab3ddc4b..3864daa7364 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
-TARGET_NEED_FDT=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 432f855a30a..0341cb2a6b3 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=openrisc
 TARGET_SUPPORTS_MTTCG=y
 TARGET_BIG_ENDIAN=y
+# needed by boot.c and all boards
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index f3ea9c98f75..53120dab41d 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -2,4 +2,3 @@ TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
-TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 1db8d8381d0..40881d93968 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -4,4 +4,5 @@ TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+# all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index d8b71cddcd4..338182d5b89 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
+# needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 7c0e7eeb429..f688ffa7bce 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+# needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 0c458b2d07c..706bbe6062c 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
+# all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c5f882e5ba1..e12ac3dc59b 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
-TARGET_NEED_FDT=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/meson.build b/meson.build
index 8b90ea6cf70..9c141925144 100644
--- a/meson.build
+++ b/meson.build
@@ -3058,7 +3058,11 @@ foreach target : target_dirs
   config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
   if 'TARGET_NEED_FDT' in config_target and not fdt.found()
-    fdt_required += target
+    if default_targets
+      warning('Disabling ' + target + ' due to missing libfdt')
+    else
+      fdt_required += target
+    endif
     continue
   endif
 
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 7af5c1ce8ad..372404fc85f 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,8 +648,8 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
+# requires libfdt: aarch64, arm, loongarch64, microblaze, microblazeel,
+#   or1k, ppc64, riscv32, riscv64, rx
 # fails qtest without boards: i386, x86_64
 build-without-defaults:
   extends: .native_build_job_template
@@ -665,8 +665,8 @@ build-without-defaults:
       --disable-qom-cast-debug
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
-      mips-softmmu mips64-softmmu mipsel-softmmu
-      s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
+      mips-softmmu mips64-softmmu mipsel-softmmu mips64el-softmmu
+      ppc-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
       sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
       hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
-- 
2.45.0


