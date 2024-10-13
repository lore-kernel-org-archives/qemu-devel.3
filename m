Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E12CF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pQ-00077U-Gw; Sun, 13 Oct 2024 18:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pP-00076X-4W
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:43 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pN-0000ti-D4
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e30fb8cb07so1074818a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857560; x=1729462360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvIjzJygM9GXaQbwvZ4DDVniWBW4y8rSWWHM++5r4d8=;
 b=MCSbN0vGBpp39O4DbjSYZpKBpDQcdIUxsB8piL2aUmJt+Jn1qfzgSUYmP+I3QFWS2H
 R9n0o2U0Ll5buFKCAQJVSzYu+JGc6OMjHUp0Sw2haxOw8qysQ4cv7I06Yrvf7deHqDyf
 dptfoCo/yh3Ip+7KaCQFM7Hb59WWIHB3Eu4vh/vPsTXEVLe6w/3kChO7o9jOSAiJkY6T
 0/sQ1qjnpMYBGbiDyv8f9Vkb9/L+Pq4Sfw0T6ECpI7J9V8g0EOaHQbYFlW9z3bRgw59c
 Q2Y/43zHQ1Uo9t2YrsYSXq6xIyg3DnbcUMiWp57D+SNWt0WWtVNc6zt112bR0cESv5i0
 ieuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857560; x=1729462360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvIjzJygM9GXaQbwvZ4DDVniWBW4y8rSWWHM++5r4d8=;
 b=T2vGjS5b4smum3S0AEXwFxTpyXkvALM638hotJycYccVlb5P2avR560d4EJGcOKDa7
 5zcXTVm5k4ZFoQWKGrJEotMi/OA9QorFm90u00YW48rXJJqRgukXD0t+JnrN7BaldED1
 bWugWmjK5t/dSmRDnfQl5fmroFwX2yrDjopcbhsdhfWvvcfFBpGdpMkJaUQMOQAy0ZsD
 cDvIExnIXDmbS77bGg5FluPOTIPDi2PRYt0JYwwxIZ1xoFqzNpN3Dc6WyhgGCD1jZnfl
 lfy9FFzoaOqiFxe4YrNCjUyregCayaVUEbMjV5AA1vMxKspG6ehNSinaUW5bhL4Cw2gN
 mJZg==
X-Gm-Message-State: AOJu0Yy85TmEGkgMGEmfaaOBaGsjEYOqIzqyrgVIUq0SjoGN2TZ4uR5B
 UnZpa+qlDmVDeyo6W0pi2Hujb/joKKyc+DqbOInsnslfrH6ryueS+G6uCQZTz9+wHHOXyZdsR4l
 i
X-Google-Smtp-Source: AGHT+IGF7Q6fFVCU1niAkh2cLm+98BGwRlsq39FJzFy4TlrNYj7PVFe2vmGuoQNPXLYNnUyF4DqkWA==
X-Received: by 2002:a17:90a:67c6:b0:2e0:f896:b806 with SMTP id
 98e67ed59e1d1-2e2f0d7aa36mr12236464a91.27.1728857560094; 
 Sun, 13 Oct 2024 15:12:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 04/27] target/i386/gdbstub: Factor out gdb_get_reg() and
 gdb_write_reg()
Date: Sun, 13 Oct 2024 15:12:12 -0700
Message-ID: <20241013221235.1585193-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

i386 gdbstub handles both i386 and x86_64. Factor out two functions
for reading and writing registers without knowing their bitness.

While at it, simplify the TARGET_LONG_BITS == 32 case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240912093012.402366-4-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/gdbstub.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 4acf485879..cc5eceeb7e 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -96,6 +96,19 @@ static int gdb_write_reg_cs64(uint32_t hflags, uint8_t *buf, target_ulong *val)
     return 4;
 }
 
+static int gdb_get_reg(CPUX86State *env, GByteArray *mem_buf, target_ulong val)
+{
+    if (TARGET_LONG_BITS == 64) {
+        if (env->hflags & HF_CS64_MASK) {
+            return gdb_get_reg64(mem_buf, val);
+        } else {
+            return gdb_get_reg64(mem_buf, val & 0xffffffffUL);
+        }
+    } else {
+        return gdb_get_reg32(mem_buf, val);
+    }
+}
+
 int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -137,15 +150,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            if (TARGET_LONG_BITS == 64) {
-                if (env->hflags & HF_CS64_MASK) {
-                    return gdb_get_reg64(mem_buf, env->eip);
-                } else {
-                    return gdb_get_reg64(mem_buf, env->eip & 0xffffffffUL);
-                }
-            } else {
-                return gdb_get_reg32(mem_buf, env->eip);
-            }
+            return gdb_get_reg(env, mem_buf, env->eip);
         case IDX_FLAGS_REG:
             return gdb_get_reg32(mem_buf, env->eflags);
 
@@ -248,6 +253,21 @@ static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
     return 4;
 }
 
+static int gdb_write_reg(CPUX86State *env, uint8_t *mem_buf, target_ulong *val)
+{
+    if (TARGET_LONG_BITS == 64) {
+        if (env->hflags & HF_CS64_MASK) {
+            *val = ldq_p(mem_buf);
+        } else {
+            *val = ldq_p(mem_buf) & 0xffffffffUL;
+        }
+        return 8;
+    } else {
+        *val = (uint32_t)ldl_p(mem_buf);
+        return 4;
+    }
+}
+
 int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -288,18 +308,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            if (TARGET_LONG_BITS == 64) {
-                if (env->hflags & HF_CS64_MASK) {
-                    env->eip = ldq_p(mem_buf);
-                } else {
-                    env->eip = ldq_p(mem_buf) & 0xffffffffUL;
-                }
-                return 8;
-            } else {
-                env->eip &= ~0xffffffffUL;
-                env->eip |= (uint32_t)ldl_p(mem_buf);
-                return 4;
-            }
+            return gdb_write_reg(env, mem_buf, &env->eip);
         case IDX_FLAGS_REG:
             env->eflags = ldl_p(mem_buf);
             return 4;
-- 
2.43.0


