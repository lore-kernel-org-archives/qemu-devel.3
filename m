Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107F3CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3db-00037K-U6; Tue, 09 Apr 2024 01:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3da-00036u-Cb
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:14 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dY-0005E4-Ji
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:14 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5a4f608432bso3887834eaf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638991; x=1713243791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hfT+4T/tbtQh8YAz/UBeFKLC0zLop+UH8ip/+XkWEh8=;
 b=R7ftRM1aDw/21xoTbXxfQjwyr6mTTKsvLVI+xU5p8wktv3S0Diu4Bjo6bvIsCGwOgF
 sy/u/rAeYf/qtSFMPquPf8BWQO3mtR5uIJrK/Mq+J9Ih2N4W1Q4Gzil5wSe6b9Ki1ZPR
 Qn0PjkvVuYYUz3WoBXdsakfsW2L64twX9s2JrHZE+R0yQAsO6lytSVkKYGcBPvVhRGN0
 MasdlTSQ8Wcruyw7k7mTzSbnXYagi3zQTEUE2DaJqWcA6QbhWADat0HVkx8sKBEKeHv7
 touAMIktUb8QKozERCqM6/mlsHEFdh6tMzlMSTSOHtBWjoijJMbJ2Jx8aAuFCiPY9TXb
 SMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638991; x=1713243791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfT+4T/tbtQh8YAz/UBeFKLC0zLop+UH8ip/+XkWEh8=;
 b=OMG3MvQ16jOrD8MTqkK67J4iTTAnzGKy4XvVcpPEYueACUPJk1jh/R4d0TMc734kfA
 HUtDUAkZ52YPjY+U0CXPe2xtNPBWWnKSnjbjRtBOnNMpUwZ8H3eDw3xjlOjNixS+cM4M
 g9AXtzSyw51qhQuS72JDW6MuCmYOIYf34zzciHfFmZug0sj0FV3AbSdDTVPPiXfHAQ81
 P+f6Qrrz1enf0lwbFvIpKALVM8K9M0KRPKMfZGMslS0A7D4V6fC2CYX8/U5FRY068oM/
 qLdPH4QJgHjNgGIZXaxUCR55UPYSGFgGOqmyDGHB8nq+AkG/1WUOHBtFifvGL/g/myKP
 6G/g==
X-Gm-Message-State: AOJu0YyYqNXz2TFC4kXtbmz4rdTEm1QWu4aD1s5h+5Xo/ouY/+5ZCvpt
 c/gQqx16Oe66sKqHvATduinSoLysA/BWIv7H/1PDPncDVOQsk64sLGqRyJ6QFaE35yUWzlzIzZY
 R
X-Google-Smtp-Source: AGHT+IHQShsUyqMwsqZxBNQqrNLDsB0HmQIZp8yQMnhwdn8aV9fIKfGiI5FUaZyb79jFkAtAXH4e7Q==
X-Received: by 2002:a05:6870:a927:b0:22e:e46f:57e3 with SMTP id
 eq39-20020a056870a92700b0022ee46f57e3mr10882383oab.35.1712638991273; 
 Mon, 08 Apr 2024 22:03:11 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/28] target/i386: Convert do_fstenv to X86Access
Date: Mon,  8 Apr 2024 19:02:39 -1000
Message-Id: <20240409050302.1523277-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 45 +++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 28ae8100f6..25074af0ce 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2372,9 +2372,9 @@ void helper_fxam_ST0(CPUX86State *env)
     }
 }
 
-static void do_fstenv(CPUX86State *env, target_ulong ptr, int data32,
-                      uintptr_t retaddr)
+static void do_fstenv(X86Access *ac, target_ulong ptr, int data32)
 {
+    CPUX86State *env = ac->env;
     int fpus, fptag, exp, i;
     uint64_t mant;
     CPU_LDoubleU tmp;
@@ -2401,28 +2401,31 @@ static void do_fstenv(CPUX86State *env, target_ulong ptr, int data32,
     }
     if (data32) {
         /* 32 bit */
-        cpu_stl_data_ra(env, ptr, env->fpuc, retaddr);
-        cpu_stl_data_ra(env, ptr + 4, fpus, retaddr);
-        cpu_stl_data_ra(env, ptr + 8, fptag, retaddr);
-        cpu_stl_data_ra(env, ptr + 12, env->fpip, retaddr); /* fpip */
-        cpu_stl_data_ra(env, ptr + 16, env->fpcs, retaddr); /* fpcs */
-        cpu_stl_data_ra(env, ptr + 20, env->fpdp, retaddr); /* fpoo */
-        cpu_stl_data_ra(env, ptr + 24, env->fpds, retaddr); /* fpos */
+        access_stl(ac, ptr, env->fpuc);
+        access_stl(ac, ptr + 4, fpus);
+        access_stl(ac, ptr + 8, fptag);
+        access_stl(ac, ptr + 12, env->fpip); /* fpip */
+        access_stl(ac, ptr + 16, env->fpcs); /* fpcs */
+        access_stl(ac, ptr + 20, env->fpdp); /* fpoo */
+        access_stl(ac, ptr + 24, env->fpds); /* fpos */
     } else {
         /* 16 bit */
-        cpu_stw_data_ra(env, ptr, env->fpuc, retaddr);
-        cpu_stw_data_ra(env, ptr + 2, fpus, retaddr);
-        cpu_stw_data_ra(env, ptr + 4, fptag, retaddr);
-        cpu_stw_data_ra(env, ptr + 6, env->fpip, retaddr);
-        cpu_stw_data_ra(env, ptr + 8, env->fpcs, retaddr);
-        cpu_stw_data_ra(env, ptr + 10, env->fpdp, retaddr);
-        cpu_stw_data_ra(env, ptr + 12, env->fpds, retaddr);
+        access_stw(ac, ptr, env->fpuc);
+        access_stw(ac, ptr + 2, fpus);
+        access_stw(ac, ptr + 4, fptag);
+        access_stw(ac, ptr + 6, env->fpip);
+        access_stw(ac, ptr + 8, env->fpcs);
+        access_stw(ac, ptr + 10, env->fpdp);
+        access_stw(ac, ptr + 12, env->fpds);
     }
 }
 
 void helper_fstenv(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fstenv(env, ptr, data32, GETPC());
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 14 << data32, MMU_DATA_STORE, GETPC());
+    do_fstenv(&ac, ptr, data32);
 }
 
 static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
@@ -2470,12 +2473,12 @@ static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
 {
     X86Access ac;
     floatx80 tmp;
-    int i;
+    int i, envsize = 14 << data32;
 
-    do_fstenv(env, ptr, data32, retaddr);
+    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_STORE, GETPC());
 
-    ptr += (target_ulong)14 << data32;
-    access_prepare(&ac, env, ptr, 80, MMU_DATA_STORE, GETPC());
+    do_fstenv(&ac, ptr, data32);
+    ptr += envsize;
 
     for (i = 0; i < 8; i++) {
         tmp = ST(i);
-- 
2.34.1


