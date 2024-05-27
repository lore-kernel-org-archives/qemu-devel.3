Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF4EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZI-0007AR-Je; Sun, 26 May 2024 20:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ0-00072Y-RL
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:12 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOYw-0003Zm-7J
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:07 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-24ca21014ccso1196415fac.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771005; x=1717375805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65Gkdr7ftr6lyKPmfr51rDrQ5Maa9PeaHdOx7rkPnQ4=;
 b=X0BMB9D1sPZEruKCW9zHr6aE4QBObc7JhVwqIk5JeuQy33QQ7lhThjgSenfmGb52ll
 yqQLSL8LB116aoduKIsynKNd1szYIs0NHSKtlIJfIy3hcWBZF2+GRlbh6Ch+X3MUJYt7
 yRUsqui3DLIgZKGb9fx7P/OyA6ev2THQQaJvsX3dIklf8VGYTiPfiUK6rzQQFCl4QZhX
 2t5P8Tec9FL/yVqojFYYa+owqOKh/k6BzFkYP+YMr6dW19pj8gsdbSD77QcJzshUb7S9
 XOXrjr3uxWmqaftXrQF9yyu2A0PfMXHNT+lJ3rAoZITpuwFE9rc4eI3+kIWxXrftr9gr
 oFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771005; x=1717375805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65Gkdr7ftr6lyKPmfr51rDrQ5Maa9PeaHdOx7rkPnQ4=;
 b=taPrVXSsq0xUrx4nVvVzMzl72DWkX7xao2p2WaPyClzJ0KUnhankRtWaCyEecNWQgw
 VAEHsUJjTnp19RbFeRlU76hxyiyJA2fe7dUpRBnXZrrQwQGTpOjD1cYvE5QBR301eDt+
 hkpt2oJ0T6+/JRQnGVxaEFOu1RA0ZWeR5nL8rjDZxIO2TDKpxOsfCRVHeJSLZzN+RBhx
 0VUo0FBJK+O/czp5iSEsYD//aADu9SDyc5Y3PgD5tKc6o5KRKz7JPxIL5FXVvfFhOqVY
 icfdHwUAOCxPc/R3z2mIBZw1txhGctnkKUO8mHdZm0dZnPf6dc1bdfhKO7KAA2TikbGK
 xqJA==
X-Gm-Message-State: AOJu0YypHHJ8q3Gb7yJNRQfs1a2DCRaA1eud9BJlNmxagAPudJf7NVHm
 2yp6WZGUBeANxe5iEKl4xEfnPCRcOObiMm2KE0yauSeuHZewkVktfNFcDbWizOPyK7Shq5Y0OD8
 z
X-Google-Smtp-Source: AGHT+IHA0G32uGPnCXSNNEPt6AHr6XzhQZnF2PvsagB0EJi1B1ZzHas/dFNpZBi1od9KeXtkZE+sPA==
X-Received: by 2002:a05:6871:5222:b0:24f:ea59:4e3d with SMTP id
 586e51a60fabf-24fea596470mr2981296fac.43.1716771004822; 
 Sun, 26 May 2024 17:50:04 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/28] target/i386: Convert helper_{fbld, fbst}_ST0 to X86Access
Date: Sun, 26 May 2024 17:49:36 -0700
Message-Id: <20240527005001.642825-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
 target/i386/tcg/fpu_helper.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1662643a8f..6237cd8383 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -773,18 +773,21 @@ void helper_fninit(CPUX86State *env)
 
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
@@ -798,7 +801,9 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     target_ulong mem_ref, mem_end;
     int64_t val;
     CPU_LDoubleU temp;
+    X86Access ac;
 
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_STORE, GETPC());
     temp.d = ST0;
 
     val = floatx80_to_int64(ST0, &env->fp_status);
@@ -806,20 +811,20 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
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
@@ -828,10 +833,10 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
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


