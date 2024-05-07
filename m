Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A93EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4F7W-0007iC-CL; Tue, 07 May 2024 03:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7S-0007gx-Ne
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7P-0004iU-IG
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyNCn6KfhclgXn49ilb7iSwuej0wWE0rdShomgLaqNo=;
 b=C5bpftMkmRvcEFH30ANdja4FZFG6Vz5X9jksD7CKaG0gD7Be1FSEpCUYWMOYJylL0Qcvsx
 ySLJtbYjkKhhuGcfQPFlFsqaJi6tY9Db9VjHgT2Zp110fyx2GpVe+HK+IImN9QpZwmZ/uy
 EjxIFC0QmSCiuxXMwQ371gy/1IO60ps=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-b6E0bbZ4OfaOEaSim6aGLg-1; Tue, 07 May 2024 03:20:05 -0400
X-MC-Unique: b6E0bbZ4OfaOEaSim6aGLg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51f843d9194so2495513e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066403; x=1715671203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyNCn6KfhclgXn49ilb7iSwuej0wWE0rdShomgLaqNo=;
 b=Dien2EaSu4T1BxO1VtQ2Esb4xS8iUmj2g6zmQ7y4fB+QZR77AHSxKsiy6CxdFDzQqN
 +y48kOofSpyq3T2eXD2jPQD+b1O7S0UnYebkzjSDbf230mCMmw6olR5SSldSMV9NRRY2
 4Kzg5NHOct/I+uYbhT3c9WGz1rOnYqXHVZhKfdFSwONXgu68gUuELTjZS4Gl+cbwn5Wv
 9+toDvbJmmYQWTBdIhZolCOg4Sqdxs9vw2+t44T3nG8bnicKAD9cwRQy2SA2fjUIZ0PB
 j9bMJgZea3DfdEO9RFdBfaJrE18n0VvA7IVJMe1Lw9ENGw27govIFP/dMQby4ztLlX4+
 x3Dg==
X-Gm-Message-State: AOJu0YxsD+h90k/4dzmeL0zZMSOkgmJk2KjML2luafkVQnBOSAIz6+sG
 kIjswPC/g4RvPKer/RydNTlAENAM2nfMmrt6MJSuCYZcC6qWT+PtmpWYz53WZ2bM+2aQB0ME2YS
 ilLyqM8yLQhG47F3Gl1GrDbnL2ZVAI0A2PCiz76ON2gnx4yDQXZ9nRehoO5svlm6RyP8W12u5CK
 VyPH3vaSiLKmkUDfqPmlFFAGqPB/KU7TRZJZOs
X-Received: by 2002:ac2:596f:0:b0:518:dae6:d0ec with SMTP id
 h15-20020ac2596f000000b00518dae6d0ecmr8289269lfp.4.1715066402963; 
 Tue, 07 May 2024 00:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGO/a81xOdbWPhVKH/89rEqunJmLYFrggp4MZDjwlnY+zRmwxeguO8jgKW8mIwaDBZxX6Azw==
X-Received: by 2002:ac2:596f:0:b0:518:dae6:d0ec with SMTP id
 h15-20020ac2596f000000b00518dae6d0ecmr8289250lfp.4.1715066402364; 
 Tue, 07 May 2024 00:20:02 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fj20-20020a0564022b9400b00572336c900asm6013682edb.74.2024.05.07.00.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 00:20:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 4/4] configs: disable emulators that require it if libfdt is
 not found
Date: Tue,  7 May 2024 09:19:48 +0200
Message-ID: <20240507071948.105022-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507071948.105022-1-pbonzini@redhat.com>
References: <20240507071948.105022-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

By default, unless --enable-libfdt is passed (in which case the
dependency is mandatory, as usual for --enable-* options) or the
target is mention in --target-list, those emulators will be skipped if
libfdt is not present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/aarch64-softmmu.mak      |  1 +
 configs/targets/arm-softmmu.mak          |  1 +
 configs/targets/i386-softmmu.mak         |  1 -
 configs/targets/loongarch64-softmmu.mak  |  1 +
 configs/targets/microblaze-softmmu.mak   |  1 +
 configs/targets/microblazeel-softmmu.mak |  1 +
 configs/targets/mips64el-softmmu.mak     |  1 -
 configs/targets/or1k-softmmu.mak         |  1 +
 configs/targets/ppc-softmmu.mak          |  1 -
 configs/targets/ppc64-softmmu.mak        |  1 +
 configs/targets/riscv32-softmmu.mak      |  1 +
 configs/targets/riscv64-softmmu.mak      |  1 +
 configs/targets/rx-softmmu.mak           |  1 +
 configs/targets/x86_64-softmmu.mak       |  1 -
 meson.build                              | 14 ++++++++++----
 .gitlab-ci.d/buildtest.yml               |  7 ++++---
 16 files changed, 24 insertions(+), 11 deletions(-)

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
index 3ae95215083..365213e21f2 100644
--- a/meson.build
+++ b/meson.build
@@ -3051,14 +3051,20 @@ foreach target : target_dirs
     error('No accelerator available for target @0@'.format(target))
   endif
 
-  actual_target_dirs += target
   config_target += keyval.load('configs/targets' / target + '.mak')
   config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
-  if 'TARGET_NEED_FDT' in config_target
-    fdt_required += target
+  if 'TARGET_NEED_FDT' in config_target and not fdt.found()
+    if default_targets
+      warning('Disabling ' + target + 'due to missing libfdt')
+    else
+      fdt_required += target
+    endif
+    continue
   endif
 
+  actual_target_dirs += target
+
   # Add default keys
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
@@ -3146,7 +3152,7 @@ genh += custom_target('config-poison.h',
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
 
-if fdt_required.length() > 0 and not fdt.found()
+if fdt_required.length() > 0
   error('fdt disabled but required by targets ' + ', '.join(fdt_required))
 endif
 
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e9402a68a79..92ca396c195 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,8 +648,8 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
+# requires libfdt: aarch64, arm, loongarch64, microblaze, microblazeel,
+#   or1k, ppc64, riscv32, riscv64, rx
 # does not build without boards: i386, loongarch64, s390x, sh4, sh4eb, x86_64
 build-without-defaults:
   extends: .native_build_job_template
@@ -665,7 +665,8 @@ build-without-defaults:
       --disable-qom-cast-debug
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
-      mips-softmmu mips64-softmmu mipsel-softmmu sparc-softmmu
+      mips-softmmu mips64-softmmu mipsel-softmmu mips64el-softmmu
+      ppc-softmmu sparc-softmmu
       sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
       hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
-- 
2.45.0


