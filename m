Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BA6CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3db-000373-6B; Tue, 09 Apr 2024 01:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dZ-00036j-RR
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:13 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dX-0005DZ-51
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:13 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ea0c8237d2so1422575a34.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638990; x=1713243790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d7e1o1kdWD6RW81p7hz4Hv5E+EYx9lw2VzyOZjbmFo0=;
 b=oHGYgXcdhOG2DZhcprKKyMqE5PiXAMs35/aOf8Qr9SIamFGgjPkKBW1cO3KJ+DoREr
 VJBrYvS8/cd7Nz3MIqFZrqjQ6QU82BVIt30Re3hHg/wHJOfOxtmlK2TjOTXCnnEY9j+6
 /jxSYy9jt88jueOjA5DBAAo28OHK4kX39Vs8lMLOHiCt2jZVvPQbJPDv1axA5g66UTrX
 6OyyuHHmcuLMNS9XH4+VkuvGHA99OYG76SYK4OQ3O9dIsLfV37CqYy67HT3vG7i2K+Ko
 LiOobdJ9B7joYKnYp7Khs3OsAVVTUXGVXOZ7DPl9z2jn0bXuPcSaJqszK0UFJuFkoM9J
 m2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638990; x=1713243790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7e1o1kdWD6RW81p7hz4Hv5E+EYx9lw2VzyOZjbmFo0=;
 b=AnMQqtQYM2f2wNvK/Du0W7immxXhHnZDtN/jU5AmLwViFiu0D7MU4HR6f35UYpfVEQ
 m7ivSlfIrtDRLgrjK9DowsfuXJ0sEFhsREEE8zbp0hojOGDFk3yYsHm/3f1OMoi6PxmK
 tTYoBxoGgKPmvqms6qEjdQcDfxiCTmJP8UgnO746BXoejkaambcQrTJ/v0NZ+R+kTjP6
 m6pQH2VHpqkKETGm5N2NAV6sUqxGuUutDejt2AAWz1JgX9bSrWGqEgaVoqmX2z6EevOu
 ENxMRLt/QvT6aXE7BMXssnFwEgCSdPpRF8hMlIHYbuq/7/2wKOVZruaw4LwAaeWCI4dn
 PCWg==
X-Gm-Message-State: AOJu0Yxw6+ri3JRU06qEUJKp/2iyLjijJ6lwDmzbCzTsxhO8rQNfNnwU
 3IwaAQrApXmzG6UxRAwPAXWXhKGxYtZYvKYS+YcaeWNNNpUevtMGjVA4SYQIXyn0pdYttdSaNv+
 Z
X-Google-Smtp-Source: AGHT+IHUA5Xgsy7HAV4SPfqkuiAOBnGLhHc4BlaHv2W6ZsKRd4+pmhiGdpvRg6Lzp8tz+bTjy50TNg==
X-Received: by 2002:a05:6808:1412:b0:3c5:d6d5:b1c7 with SMTP id
 w18-20020a056808141200b003c5d6d5b1c7mr13284261oiv.25.1712638989847; 
 Mon, 08 Apr 2024 22:03:09 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/28] target/i386: Convert do_fldenv to X86Access
Date: Mon,  8 Apr 2024 19:02:38 -1000
Message-Id: <20240409050302.1523277-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
 target/i386/tcg/fpu_helper.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index ad8b536cb5..28ae8100f6 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2441,20 +2441,15 @@ static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
 #endif
 }
 
-static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
-                      uintptr_t retaddr)
+static void do_fldenv(X86Access *ac, target_ulong ptr, int data32)
 {
     int i, fpus, fptag;
+    CPUX86State *env = ac->env;
+
+    cpu_set_fpuc(env, access_ldw(ac, ptr));
+    fpus = access_ldw(ac, ptr + (2 << data32));
+    fptag = access_ldw(ac, ptr + (4 << data32));
 
-    if (data32) {
-        cpu_set_fpuc(env, cpu_lduw_data_ra(env, ptr, retaddr));
-        fpus = cpu_lduw_data_ra(env, ptr + 4, retaddr);
-        fptag = cpu_lduw_data_ra(env, ptr + 8, retaddr);
-    } else {
-        cpu_set_fpuc(env, cpu_lduw_data_ra(env, ptr, retaddr));
-        fpus = cpu_lduw_data_ra(env, ptr + 2, retaddr);
-        fptag = cpu_lduw_data_ra(env, ptr + 4, retaddr);
-    }
     cpu_set_fpus(env, fpus);
     for (i = 0; i < 8; i++) {
         env->fptags[i] = ((fptag & 3) == 3);
@@ -2464,7 +2459,10 @@ static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
 
 void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fldenv(env, ptr, data32, GETPC());
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 14 << data32, MMU_DATA_STORE, GETPC());
+    do_fldenv(&ac, ptr, data32);
 }
 
 static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
@@ -2498,12 +2496,12 @@ static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
 {
     X86Access ac;
     floatx80 tmp;
-    int i;
+    int i, envsize = 14 << data32;
 
-    do_fldenv(env, ptr, data32, retaddr);
-    ptr += (target_ulong)14 << data32;
+    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_LOAD, retaddr);
 
-    access_prepare(&ac, env, ptr, 80, MMU_DATA_LOAD, retaddr);
+    do_fldenv(&ac, ptr, data32);
+    ptr += envsize;
 
     for (i = 0; i < 8; i++) {
         tmp = do_fldt(&ac, ptr);
-- 
2.34.1


