Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B425C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYT3-0005PQ-Vv; Mon, 12 May 2025 15:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT0-0005LD-QP
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYSz-0007Tg-17
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIXuZiZ9l8l1+2kKqvwfb3vC3OPO6dOzGvsREz22T5c=;
 b=A/vVzYVAxgieCmjSkR9bcFhNvjq5tsh+YmESCRLCKnO+lR5/F+ro2C0kKqQsrhI+oBpPmq
 TQz6tBeB9KDoX7K5Bn2I8JEoTkzC4DhQfZEegGRFR9+L5X/f9G5jM+Lw4Ye63O3MfKnxGm
 arCUCClEyXv2YGh8JlKySAhkPhCqqkY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-qzjMuYRkOxejG_iTBCVVEA-1; Mon, 12 May 2025 15:05:29 -0400
X-MC-Unique: qzjMuYRkOxejG_iTBCVVEA-1
X-Mimecast-MFC-AGG-ID: qzjMuYRkOxejG_iTBCVVEA_1747076729
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442d472cf7fso27620465e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076728; x=1747681528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIXuZiZ9l8l1+2kKqvwfb3vC3OPO6dOzGvsREz22T5c=;
 b=m/cVBZu+g73ITE1nPQa2DcR5tnEbNH5Hk+VHTuCvPArkDOD6lwUlPZBzTGzAPe2pGI
 qzAef0XcnkineW+nsfHM+6H/4MirpEXqIg1CkQ9zTJq4JCMPlL8kiQYBEzQlutRzfz21
 R/JZcZ0I3EwxM+egGJom1G1elD1L5if3QbfS3blDnaomuEE3JyJWN+3E7Tb9n62/1OFD
 eJMjQNJvxWjMAKl4kOOjPBq2/boWNxWSC0iG4FD4lFrEZylBIB/nH43EYyFpGxVbvODI
 yt1o8aDHCdERuZ09qpUmJfstPwBcr0xWQMrTyyXCu93wMnREfM3czCNTQnG2oEt6ij7Z
 pvoQ==
X-Gm-Message-State: AOJu0YxPVDVG9h9MLFVIhqd3L0cj5ihgFBrEwGgMHq6IhYTThoMJrAYp
 nTxcHErS8NygAdsxKhBkETjsqJJC6nujzh5L0hySO65wCV6IId5wUKfNuHSVnVmiIYIjSby39rL
 pcvsNe9bOJohToq62m6dfP4RximVKgilicmMg95xh9R4xa07rvY+iSS2Mu3AjYSbrhuZd8b07Uk
 DuZEqLR7623gcEoMYs0VeMqfqKOmvpJDXHhpmu
X-Gm-Gg: ASbGncuVSg2aQNr4MBzuDa26cccLznv3lkX6r5+OThOMFZbxqzthvJmHsbVHGawjM1S
 fddQM1rgcSKSNURfkIKtSu8Dl2y7BTvUlMs0NFOJvKLpJ2GlXYMDyG1VjqBQrCr0JKp9j3z09jT
 DsUVtWLhPqYEIXgPIvORjdviL3HKxdXBc2hwYGUPV1YeP6C5E2/R6qGmlF6RNeroBpaONAEbqdk
 SbYlSI9NrcwcCO7hOK9pYiz3+55jvN3H7gcftynu+JVZLDAatrjb3ybER5jxoMOLBvRLsOlNFMN
 IZUzo3hzfkDKwZ0=
X-Received: by 2002:a05:600c:3d05:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-442d6dbd4f3mr141644615e9.16.1747076728311; 
 Mon, 12 May 2025 12:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ2uy9cpn23eFjIVFEX3ZCymSkFgbnjeQOcETVnRr0L3Hkg4ap4H3EnadgfeSosppZM3fiyg==
X-Received: by 2002:a05:600c:3d05:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-442d6dbd4f3mr141644365e9.16.1747076727895; 
 Mon, 12 May 2025 12:05:27 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f396asm13642884f8f.59.2025.05.12.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/16] meson: drop --enable-avx* options
Date: Mon, 12 May 2025 21:05:09 +0200
Message-ID: <20250512190524.179419-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 30 +++++++++++++++++++-----------
 meson_options.txt             |  4 ----
 scripts/meson-buildoptions.sh |  6 ------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index e819a7084ca..f20a172299b 100644
--- a/meson.build
+++ b/meson.build
@@ -3097,22 +3097,16 @@ config_host_data.set('CONFIG_ASM_HWPROBE_H',
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
@@ -3120,7 +3114,21 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
       return res[1];
     }
     int main(int argc, char *argv[]) { return bar(argv[0]); }
-  '''), error_message: 'AVX512BW not available').allowed())
+  ''')
+  if get_option('x86_version') >= '3' and not have_avx2
+    error('Cannot enable AVX optimizations due to missing intrinsics')
+  elif get_option('x86_version') >= '4' and not have_avx512bw
+    error('Cannot enable AVX512 optimizations due to missing intrinsics')
+  endif
+else
+  have_avx2 = false
+  have_avx512bw = false
+  if get_option('x86_version') >= '3'
+    error('Cannot enable AVX optimizations due to missing cpuid.h')
+  endif
+endif
+config_host_data.set('CONFIG_AVX2_OPT', have_avx2)
+config_host_data.set('CONFIG_AVX512BW_OPT', have_avx512bw)
 
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
diff --git a/meson_options.txt b/meson_options.txt
index cc66b46c636..a442be29958 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -123,10 +123,6 @@ option('valgrind', type : 'feature', value: 'auto',
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
index 8a67a14e2e2..f09ef9604f0 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -97,8 +97,6 @@ meson_options_help() {
   printf "%s\n" '  alsa            ALSA sound support'
   printf "%s\n" '  attr            attr/xattr support'
   printf "%s\n" '  auth-pam        PAM access control'
-  printf "%s\n" '  avx2            AVX2 optimizations'
-  printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -244,10 +242,6 @@ _meson_option_parse() {
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
2.49.0


