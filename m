Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCA4CF07DC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypEl-0005rj-QC; Thu, 10 Oct 2024 05:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sypEi-0005rQ-P2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sypEf-0002Mi-Od
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728551608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8dBP4NPtr0z+oUGmP5YfN2W+z5ZOMtf9sRJMlJs8ng4=;
 b=hDlF/P0L5/zy/F4I384eV/XRDnDfTbqg9t6zNndBDZY3zIkpDbG+dsa4Z5p0HnyFZPfQ88
 LVe+TL2o7ghA5mmVN1XBV1VofIX2myXT/+ogML4rnappY2AqZ0hWFLNC93wMgsUmAAp6I2
 tSjiUA5TGhv00v4Y2p+4i36zv0nMMJ0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-42NlOdxROFSZenlDfNDIAA-1; Thu, 10 Oct 2024 05:13:27 -0400
X-MC-Unique: 42NlOdxROFSZenlDfNDIAA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99501c3a13so72352666b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 02:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728551605; x=1729156405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dBP4NPtr0z+oUGmP5YfN2W+z5ZOMtf9sRJMlJs8ng4=;
 b=pcpeUNNrf7WyGHVJLSqT8bBDlyAMG9pPvdB3T3gFXJ2jUsIrijJj2ogyFocu4J7/eO
 i26mi/g6/8VGY3zP4p5bJMMirqmcnca1VdN+zu1zSvEGduDXxNigIiYPGyPz71WHB30q
 qSU5FMq7ft5rG0PeManHcwVJ7L0lU2WonZoBSTKmjMvoBZ5bokHQ147ukPxR1e+NEvkj
 Paz1+0ny/sxkVsLsYxpD/rdk6JYLBLgmNGjZIULBAcOrx9gnf6GjCivK47eqK7gNjhbg
 xwOW63TUs3ywdRLdwmYSgpkV6AT9IN2MUYLF9fiQfpfNq7xIZnsPgA7Wg/p2wRlvKfJf
 iTfQ==
X-Gm-Message-State: AOJu0YxX/HUqtRF2+jlKHSniRt2ylAp2eK7ocSc2lvKVE5ViJ9P6Wfx5
 dIJ/ret8oWDUzy8+/IAjNdBaluj7HGE3azY7PZm4hqvE7oXspJPveSXIAiOe9dmtKwlkqNw6mvl
 9LuqtKNutsKIE1I6wWF4ev2zM757S6WFjFdwBnZULpjZb1X578eDnliHeZI0noF8lBmo22NAO6m
 7CMAq/iA6/2xWQGUpWiMDE36h/coSrLZJN4nM5iyk=
X-Received: by 2002:a17:907:1c91:b0:a99:5687:496 with SMTP id
 a640c23a62f3a-a99a13d89f7mr233303866b.30.1728551605378; 
 Thu, 10 Oct 2024 02:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGthHJX+HFgLlvFJIkDSlAdszM01OEgTh3MIuY9TMII5Sbq3wSZUQ3WsEc/l+Bg0za0cuKBCQ==
X-Received: by 2002:a17:907:1c91:b0:a99:5687:496 with SMTP id
 a640c23a62f3a-a99a13d89f7mr233300766b.30.1728551604853; 
 Thu, 10 Oct 2024 02:13:24 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7ede920sm60391966b.8.2024.10.10.02.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 02:13:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] meson: drop --enable-avx* options
Date: Thu, 10 Oct 2024 11:13:22 +0200
Message-ID: <20241010091322.1790604-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Just detect compiler support and always enable the optimizations if
it is avilable; warn if the user did request AVX2/AVX512 use via
-Dx86_version= but the intrinsics are not available.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 30 +++++++++++++++++++-----------
 meson_options.txt             |  4 ----
 scripts/meson-buildoptions.sh |  6 ------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index e4b2af138da..b4418d54e0a 100644
--- a/meson.build
+++ b/meson.build
@@ -2955,22 +2955,16 @@ config_host_data.set('CONFIG_ASM_HWPROBE_H',
                      cc.has_header_symbol('asm/hwprobe.h',
                                           'RISCV_HWPROBE_EXT_ZBA'))
 
-config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
-  .require(cc.links('''
-    #include <cpuid.h>
+if have_cpuid_h
+  have_avx2 = cc.links('''
     #include <immintrin.h>
     static int __attribute__((target("avx2"))) bar(void *a) {
       __m256i x = *(__m256i *)a;
       return _mm256_testz_si256(x, x);
     }
     int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
-  '''), error_message: 'AVX2 not available').allowed())
-
-config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
-  .require(cc.links('''
-    #include <cpuid.h>
+  ''')
+  have_avx512bw = cc.links('''
     #include <immintrin.h>
     static int __attribute__((target("avx512bw"))) bar(void *a) {
       __m512i *x = a;
@@ -2978,7 +2972,21 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
       return res[1];
     }
     int main(int argc, char *argv[]) { return bar(argv[0]); }
-  '''), error_message: 'AVX512BW not available').allowed())
+  ''')
+  if get_option('x86_version') >= '3' and not have_avx2
+    warning('Cannot enable AVX optimizations due to missing intrinsics')
+  elif get_option('x86_version') >= '4' and not have_avx512bw
+    warning('Cannot enable AVX512 optimizations due to missing intrinsics')
+  endif
+else
+  have_avx2 = false
+  have_avx512bw = false
+  if get_option('x86_version') >= '3'
+    warning('Cannot enable AVX optimizations due to missing cpuid.h')
+  endif
+endif
+config_host_data.set('CONFIG_AVX2_OPT', have_avx2)
+config_host_data.set('CONFIG_AVX512BW_OPT', have_avx512bw)
 
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
diff --git a/meson_options.txt b/meson_options.txt
index 5a5c2300261..d5abf5193f5 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,10 +119,6 @@ option('tpm', type : 'feature', value : 'auto',
 option('membarrier', type: 'feature', value: 'disabled',
        description: 'membarrier system call (for Linux 4.14+ or Windows')
 
-option('avx2', type: 'feature', value: 'auto',
-       description: 'AVX2 optimizations')
-option('avx512bw', type: 'feature', value: 'auto',
-       description: 'AVX512BW optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6d08605b771..dc796f48bad 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -94,8 +94,6 @@ meson_options_help() {
   printf "%s\n" '  alsa            ALSA sound support'
   printf "%s\n" '  attr            attr/xattr support'
   printf "%s\n" '  auth-pam        PAM access control'
-  printf "%s\n" '  avx2            AVX2 optimizations'
-  printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -238,10 +236,6 @@ _meson_option_parse() {
     --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
     --enable-auth-pam) printf "%s" -Dauth_pam=enabled ;;
     --disable-auth-pam) printf "%s" -Dauth_pam=disabled ;;
-    --enable-avx2) printf "%s" -Davx2=enabled ;;
-    --disable-avx2) printf "%s" -Davx2=disabled ;;
-    --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
-    --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.46.2


