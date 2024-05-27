Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402CBC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZL-0007GS-Mu; Sun, 26 May 2024 20:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ8-000775-S3
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ2-0003a2-Tb
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6fbbd937719so1507274b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771006; x=1717375806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTjFqZGfIgyyuZashU0miJrDlkwdhgdcBxd/4Tmn0sc=;
 b=DFfQv3ULFmGnf3HpQd7rFKZEXnkEE4BCJ1cp0knxse7w4IImx2KqRVT/pw6tbGiF9P
 1lm/seR62w2ZwDD2PP2+c6AEiSISJS0oGewVLlNxYzxRb0dRi4o0AWK4KDkts/shBW7y
 zOtyTiCtprm9N1GYaXsud9B+s6tDiQ5z7BgHCyKqEDIgxnUT7nnSQ1ZgTecTpNaN7bzm
 4QdU6Wu6FiNKXj5WM3DCpkjnwd9L3AYT3tOH6+Zxg9iro1PYQEy63GcWtvTlfc2OUpAe
 n2o94DIHKsqGFBQBIvm1cNwFrNQ6eHEhAXXS2TF0AchHTrFzB1x0iVUM2didqxUd3wBW
 kzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771006; x=1717375806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTjFqZGfIgyyuZashU0miJrDlkwdhgdcBxd/4Tmn0sc=;
 b=uLAOH6mO+f8TJX93rKQelSJptlGzp8q5+rW5OwiXeHReG8CNRuGhEABrhwTaxBYRc2
 pc+JCc/7zTV/xEgsdqsv0IGSuKkGS3hLR5J/+TCOkorCTGb+sMwzd9eoDo/elvc+rUU9
 WBtQNzQ1qdhZnDLMCaiJFbcH4AfqAWjO6oRl2CEAq40Uvtw+tG7A4h+BHFo5kno7mnO/
 WBDXp1oAc79EC1HEJlHlL9iatYk9jYtgzsU7omJenSq/aJ2eexyu74H4JHlLNwlzj/pq
 DpIRR3rXrQ3186hp4qJMrVwNMgd1Oi0wa9XKkHEUIy71ZYrNuHHKLfDrmsYEIlmAj/Q3
 9XmQ==
X-Gm-Message-State: AOJu0YyGnLo490BnTAV/taxH/ufl4r1fusjWDJzTavGebeV+vfrVZSCx
 z9I8qTU2BsS5CvPN+2Wm3GLYD516Yu2SggapPqcSB0aeZ+mjTikv8NhuG3Ghop6pSkMt+MJJAxe
 H
X-Google-Smtp-Source: AGHT+IGUYZRA98XHUQt/DK6uWp1kMV5tUH2iUJ1PLkd7UxR8Kb56BA/CjzfWk7WCMavXfBsffrRkoA==
X-Received: by 2002:a05:6a00:808c:b0:6f4:5531:7ce4 with SMTP id
 d2e1a72fcca58-6f8f41b2d8fmr8568683b3a.33.1716771006316; 
 Sun, 26 May 2024 17:50:06 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/28] target/i386: Convert do_fstenv to X86Access
Date: Sun, 26 May 2024 17:49:38 -0700
Message-Id: <20240527005001.642825-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 45 +++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 5ad6e04639..01e9a1fbbf 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2373,9 +2373,9 @@ void helper_fxam_ST0(CPUX86State *env)
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
@@ -2402,28 +2402,31 @@ static void do_fstenv(CPUX86State *env, target_ulong ptr, int data32,
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
@@ -2471,12 +2474,12 @@ static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
 {
     X86Access ac;
     floatx80 tmp;
-    int i;
+    int i, envsize = 14 << data32;
 
-    do_fstenv(env, ptr, data32, retaddr);
+    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_STORE, retaddr);
 
-    ptr += (target_ulong)14 << data32;
-    access_prepare(&ac, env, ptr, 80, MMU_DATA_STORE, retaddr);
+    do_fstenv(&ac, ptr, data32);
+    ptr += envsize;
 
     for (i = 0; i < 8; i++) {
         tmp = ST(i);
-- 
2.34.1


