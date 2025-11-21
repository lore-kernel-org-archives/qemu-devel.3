Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36F8CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd3T-00027a-Hw; Fri, 21 Nov 2025 21:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcMR-0004e0-B2
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:24:24 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcKQ-0007bV-Pw
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:24:21 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5942bac322dso2342688e87.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763774518; x=1764379318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVumjk0F6Tq93V240FNbMOnFtVOEoBWTLGnL0WT9/nA=;
 b=jMbb2yiSOdt2uILhfhJEmF5R8ApUdYzVxANuGv8G48jzAMXEnOInkRRmgPDXjEpGxk
 VpdFvQS230boWIfxp+Pdk0qSb0XKruowUxJ0Pab6MJm5TJv69QOayEVNO1mhbjzZr7lE
 nPngsht1BECUB4F/uFapd6VzgOmUxxBjj0I2lr86zqKUhonTpOkeHd6jy3Lw+revEIe4
 vb21GmrQD3GzDp+Jk7fg+Uvr6MEEZyIOBigCzmLsV/LjHOX9HchLwmwfItxKlaYQdCN5
 Gh3T04cR89mRKkW95YSZ0witGZyo1ZFV6Nma+HLlt7etOoqxkYRRac1vxSX1XkSOMKNp
 Y7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763774518; x=1764379318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVumjk0F6Tq93V240FNbMOnFtVOEoBWTLGnL0WT9/nA=;
 b=bsQU/XN+6CzTu9o6sxohaCQsemcCLoQmFlK6z8GQb5cVSeOritP/h2cUn9BJ0zSTHW
 4dSEz13fdkDEwHfIAIn/UcjWX+Jn/K2OyQyMnEtjQUQxnuBSb1DPGLgSp6V1MeM2jhr1
 Y231NYV7kCBImI2ckTj1i1Edc8HmLGzB2BK1RB8RVGYDI2/4Cayko+wmvXAI4WVdb/sg
 fmDYMtQ6n4QIZyjvJz1k+Rq+QGJx4NL5WVWF1n0n9FXMxsATG6AK5ikNFMzrTYvr2zkm
 y9kQh0TBL9fiZrfK10yphdn+nEgTs1Kl4NTGA9WeaPP4csmAPdNombixfmpsVVna0s0C
 2XCA==
X-Gm-Message-State: AOJu0YxqJkahTZl6KBR6Oz6K+EuvShsiMNpa9VZOLnOA6cnNyDFcLVe1
 4VaPdM7H9mZBh767oF9XICAFwmSR1/oXRuL1oJoNsdyXTxt46hluT9FZQ4GJTC0Gaozxgq2S+0T
 zj3OOsmqTog==
X-Gm-Gg: ASbGncvdVVQ3TJ6c+5d+h48/51ajgZsMTuMfWy0Lqx+kB96gS6b0gYqDzOxQt+4xgf/
 1+fCo8KKMC0GjJPnUePYjw2dNQeF16dmAYwkmyZhbVqbcYLlgtgBXFb9qKaSCIcRn8fC10OBNud
 87yLWP09nQz1umCHythGqXNaFZQD0+sVi3ST/JKkyEN3u8SpyBxnFsUN5iq1+LuWVsSBncflds/
 xMSoS9bcQ5rPG4gQdAwyZ2y9xigRGDjKtUZkzIqDLd0GXnVHxtu5Gy/6FziTP257JUUDVdlwCCt
 78nIEC9RjRIZn62Tgwc3zGsLOAQHGECyDiFy2OFdT40fhC6aoJ7634V98dY520890pBVp5zAJsG
 51olE5kLXkKcyAzOCpcRuB/tbCWcj2zlQifqY7bUjqR5hBh5r+GlQhFCc2ijJ+xLnl5b3qpVARN
 06K+MFWJmAp+B8hOdin+LW3GU3bHuR45vNzf01J/P7N1Mmz04ibWbMTXa7KYMJhalXMNdvLj0=
X-Google-Smtp-Source: AGHT+IGEW71gfF7lovLtWNbtIwcDPhHZqsiycXLmAUHc1Dw+R/7rWjyTPaOkB2voMZKJno5HXJvLtA==
X-Received: by 2002:a5d:5f44:0:b0:42c:a4e7:3975 with SMTP id
 ffacd0b85a97d-42cc1cf3be2mr2438747f8f.30.1763732785412; 
 Fri, 21 Nov 2025 05:46:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa41d2sm10949079f8f.22.2025.11.21.05.46.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 12/21] target/rx: Use little-endian variant of
 cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:54 +0100
Message-ID: <20251121134503.30914-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

We only build the RX target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=rx; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/helper.c    | 14 +++++++-------
 target/rx/op_helper.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index e9a7aaf610d..83cd491eb4a 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -68,10 +68,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
     } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        cpu_stl_le_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
         env->psw_ipl = env->ack_ipl;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         qemu_set_irq(env->ack, env->ack_irq);
@@ -82,14 +82,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         const char *expname = "unknown exception";
 
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
+        cpu_stl_le_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         } else {
-            env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
+            env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
 
         if (vec == 30) {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 2b190a4b2cf..ca3e9e85fc7 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -217,20 +217,20 @@ void helper_scmpu(CPURXState *env)
 static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static void (* const cpu_stfn[])(CPUArchState *env,
                                  abi_ptr ptr,
                                  uint32_t val,
                                  uintptr_t retaddr) = {
-    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
+    cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
 void helper_sstr(CPURXState *env, uint32_t sz)
-- 
2.51.0


