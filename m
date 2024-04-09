Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A4CCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3da-00036t-Aa; Tue, 09 Apr 2024 01:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dX-00035o-Qf
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dW-0005Cj-1q
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ecee1f325bso4670950b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638989; x=1713243789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hw+ackY6dyXP/DNnptVLPX26mJCPUv8gsFb56I8Q9dg=;
 b=kTCMswH+fGSysYiTUJ2HrRXet8dlj1sJUNWegGB9xSDgG9rqTV6U1iRckdb946cL3C
 REBnn+yD6boz4YlhhJlIP8Ox0BcF2AiWS48D2p7OM37dzaVa3Eg1Sx4WY6OJaK+0MmP1
 qr0zH5xVB7nEGqoiSQ2O+aHlYee4p7zJPHF4jQZc5oP4JcjsX/DZtwppmiLvMwDnDJFb
 Fhpen0fs6NdR5CWFkhtOzGmdWF1FWzg7+A+LVu1QOH06/Al3PrhzidjSqhOFO3Fj13aL
 wKbRi5vNQ1ETdQWZEBZnX3yB1JI05dw20ZkYWKCv9QMOoNXME+kd5KklWppdF2ZISwiV
 hNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638989; x=1713243789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hw+ackY6dyXP/DNnptVLPX26mJCPUv8gsFb56I8Q9dg=;
 b=VRecvfOAqqqOJO0Snqkz2K8Y/6fzzGEFnKK2f0Hp0DwLnddu5Y0TYxEByCsKzH/77K
 0JgpbZtnvBazSBhbEJx74bG5SRa0dyi0qjESZaDfFygDbhImY4Dsf0sM6+NYcKgnqyXA
 DLINUBu6ZWjH+gGPVh6C74Axm6eIvAX/nrBnkJpkWW+ruRQipJdbkzevdkQgctaVyV3x
 wKEvUtNJALJzV/wpEBKlyW139BY4Ef/fTlAhyC52FUPPNe4wttD3z72ZNVBEpbJHriHX
 HrCE36J4fdlKRzGOTduMaFy6sGKA6wXMV5rAvt8w3sLxGvnxtljOvRXG2BCWbMS1hFtv
 dQMg==
X-Gm-Message-State: AOJu0Yy5AT60DXujQ5D8G/4lFbq1DcXtsbNAKyjr/yWmiAfwV5fCU52X
 7xSro1xMTRw4Kb1amMarNSxXuuWsxWplErWu9jS6GFCD4gFYDGj5lO35UDsVvCb/ae0decyBybz
 4
X-Google-Smtp-Source: AGHT+IFLL5yN8wZxC5ovZ+XS8xR66fDqipeQZlcd+8RVSBCRNBJt0WQTguLLzI5KUgLB3NpekbA+qA==
X-Received: by 2002:a05:6a00:1250:b0:6ea:8b0c:584 with SMTP id
 u16-20020a056a00125000b006ea8b0c0584mr12316148pfi.9.1712638988740; 
 Mon, 08 Apr 2024 22:03:08 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/28] target/i386: Convert helper_{fbld,
 fbst}_ST0 to X86Access
Date: Mon,  8 Apr 2024 19:02:37 -1000
Message-Id: <20240409050302.1523277-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/i386/tcg/fpu_helper.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 878fad9795..ad8b536cb5 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -772,18 +772,21 @@ void helper_fninit(CPUX86State *env)
 
 void helper_fbld_ST0(CPUX86State *env, target_ulong ptr)
 {
+    X86Access ac;
     floatx80 tmp;
     uint64_t val;
     unsigned int v;
     int i;
 
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_LOAD, GETPC());
+
     val = 0;
     for (i = 8; i >= 0; i--) {
-        v = cpu_ldub_data_ra(env, ptr + i, GETPC());
+        v = access_ldb(&ac, ptr + i);
         val = (val * 100) + ((v >> 4) * 10) + (v & 0xf);
     }
     tmp = int64_to_floatx80(val, &env->fp_status);
-    if (cpu_ldub_data_ra(env, ptr + 9, GETPC()) & 0x80) {
+    if (access_ldb(&ac, ptr + 9) & 0x80) {
         tmp = floatx80_chs(tmp);
     }
     fpush(env);
@@ -797,7 +800,9 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     target_ulong mem_ref, mem_end;
     int64_t val;
     CPU_LDoubleU temp;
+    X86Access ac;
 
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_STORE, GETPC());
     temp.d = ST0;
 
     val = floatx80_to_int64(ST0, &env->fp_status);
@@ -805,20 +810,20 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     if (val >= 1000000000000000000LL || val <= -1000000000000000000LL) {
         set_float_exception_flags(float_flag_invalid, &env->fp_status);
         while (mem_ref < ptr + 7) {
-            cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
+            access_stb(&ac, mem_ref++, 0);
         }
-        cpu_stb_data_ra(env, mem_ref++, 0xc0, GETPC());
-        cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
-        cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
+        access_stb(&ac, mem_ref++, 0xc0);
+        access_stb(&ac, mem_ref++, 0xff);
+        access_stb(&ac, mem_ref++, 0xff);
         merge_exception_flags(env, old_flags);
         return;
     }
     mem_end = mem_ref + 9;
     if (SIGND(temp)) {
-        cpu_stb_data_ra(env, mem_end, 0x80, GETPC());
+        access_stb(&ac, mem_end, 0x80);
         val = -val;
     } else {
-        cpu_stb_data_ra(env, mem_end, 0x00, GETPC());
+        access_stb(&ac, mem_end, 0x00);
     }
     while (mem_ref < mem_end) {
         if (val == 0) {
@@ -827,10 +832,10 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
         v = val % 100;
         val = val / 100;
         v = ((v / 10) << 4) | (v % 10);
-        cpu_stb_data_ra(env, mem_ref++, v, GETPC());
+        access_stb(&ac, mem_ref++, v);
     }
     while (mem_ref < mem_end) {
-        cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
+        access_stb(&ac, mem_ref++, 0);
     }
     merge_exception_flags(env, old_flags);
 }
-- 
2.34.1


