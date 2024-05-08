Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C4C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c5y-0007d4-3S; Wed, 08 May 2024 03:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c5M-0006tg-IL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c5G-0003eX-JU
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHfp4hyic82q83vzDg4ggug031W0Z3Ar7QGHLKU1pSg=;
 b=NbxMFf75UqEuSCi4bBSf+Fdthl7UnNYZfSPfr8dwczYlL5lWtqNzzQKquWlMwuCF+ICL3n
 ZTxNoC7na4Wzp76jqvHN1GXm8QMV0bHtldUXNP2o4CvynzgmFHX8DGar16RzLxauhdFLb7
 kDX3xYrV3ZasXlmwjY2JJJHGW+w2I94=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-ATWlCSg4OGqKgV_SG-9b8w-1; Wed, 08 May 2024 03:51:24 -0400
X-MC-Unique: ATWlCSg4OGqKgV_SG-9b8w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59aedbd9a9so266999266b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154682; x=1715759482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHfp4hyic82q83vzDg4ggug031W0Z3Ar7QGHLKU1pSg=;
 b=Lh5UhrKTYwrkAVYEp9Ok6ECqtLF/TCkyFI8jT9juSQ1FusGXjev1U6lxj3df4L8Fnb
 2btWJGa6nxwKyYB6sdooRBQm2Tcsp4upsseEGFpH9jpF2N1omRoXgWYiMILgKjPtsKnj
 rSX3CJDvfS9IwvdyGUnwk5NGF2gk1e0ezTq0gfZZntHcrhEXkFg+vK3Lnt3XMtZIMCN5
 exjvtEq+3IRtKoA9F3FH2AhXpeEG++bqu0JM/rQxnfjFZH4/9pDmP4P/9NemxB+MmaMI
 aPeWQ6ZByB0Q0MEFnuD3pPSf9PDgTzuqF599QrK5/7HDqU5XF8GNZXwdx/AlwL27blNs
 S1VQ==
X-Gm-Message-State: AOJu0YwdkiZnw/Ttb+IMDkFqRwthU0oP0se+57jphEGuozUDyZUsTokD
 iT5W1DX2o91C1recNny8MmiYDEGrmHytbOBDNVHdz67S7LtRRBqyl9V3z/m/2VRXuxkDydGFJ8Y
 3M1y22psa38mBcr7uxCm/Jo4x65iTd/myvQRUAKkN0RbZcY+lL5oK2qfoTP0bqVQPGvYZ6a1yH/
 A1Q7Hwz7++0E79BgpIDkMRKjDXZGAzhyCth70/
X-Received: by 2002:a17:906:c795:b0:a59:8cd2:5b2c with SMTP id
 a640c23a62f3a-a59fb95d98dmr100844366b.39.1715154682176; 
 Wed, 08 May 2024 00:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZcTnzPQRmpanHE3pOoAg/8fe+TT0COPQJMYqgPSPqm5bkgFP5U/Mz+tB7xe3Yrud9EChOsA==
X-Received: by 2002:a17:906:c795:b0:a59:8cd2:5b2c with SMTP id
 a640c23a62f3a-a59fb95d98dmr100842866b.39.1715154681764; 
 Wed, 08 May 2024 00:51:21 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 kh24-20020a170906f81800b00a59bf40ba6dsm4256676ejb.7.2024.05.08.00.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:51:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 6/6] configs: disable emulators that require it if libfdt is
 not found
Date: Wed,  8 May 2024 09:51:05 +0200
Message-ID: <20240508075105.15510-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508075105.15510-1-pbonzini@redhat.com>
References: <20240508075105.15510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d8f259d2610..b8b3e7d73f5 100644
--- a/meson.build
+++ b/meson.build
@@ -3059,7 +3059,11 @@ foreach target : target_dirs
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


