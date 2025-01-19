Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA8EC0218A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtD-000513-6e; Sat, 18 Jan 2025 20:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtA-0004oI-TI
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:09 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJt9-0003J8-60
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:08 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so6087027a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249246; x=1737854046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7TFB4wgLSjm+8sg62VV/jZBqX5r4K428u5pVR59C3c=;
 b=mKWj7lg81VcN01vPWyKuM6CtRoqwRuIazLxUuofvgKjEpRwt2j6VxUM/0tHo+ND0aG
 3qTs0WqzGZmOkA2p9c9zh2B3la7c35dtkGhAjLjo70Tg7TNhcOotv2Ul+rBzGk4MV3E3
 AN/6G+lhyRIVHrXDjD3jbnUwdSN8OXaZQLqxGRQAjm5cctnJfphMop89x+Ejtm2jCdZ9
 ZRZ4TqgokH7QoSzWS8fpo9Oci0hv9kMaPJ3aFrT8NwZuZ77a2tN5EYwRu2qKRlyhFOMT
 xNVt8OYV4GyFnm80v7V6WI4ADE5LtvW9ziKBYqvf9snzwqcE+aLir3w5jPvUhAirvjRg
 wDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249246; x=1737854046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7TFB4wgLSjm+8sg62VV/jZBqX5r4K428u5pVR59C3c=;
 b=DywLShR4Hqiw7hrK4KMVgs3D+T3xDl4Jmt2ZXOm9mXSDPuVjMVlLZapRoRFfuinV+c
 snJgf0tZ9V7ad6VEM6UIuXjnfGgNduy+m3clT9wg7BDWvuN1RpuTqcMuhN0OgeIVqHya
 L8toBOlwWETHdsn6nC91fU2CfIRvJnJGribdOogYEsUSaRRtln1uW+IwlAsqhDyw5gfE
 +/5oWIS8BmadWp5c54pFz8e99a5DMXMH1QndlHRdCwwqiXctm2m96/CkMkN133s9BYeU
 c/ZhkkmInN1IvZz3hwVOxyv/iM+XFSiDHg+2sx6vrcXKzHvFB4rgtjSJ1r9SWilMS+MK
 TGsA==
X-Gm-Message-State: AOJu0Ywc4SqaYVvvo4DSbJam2Y24GJlr1Zk+HNffqT5Y4QBC1yjy0pNt
 yJU2DxY+XqIB8qZ7yc/FXKLptzTpLmcRuiJkVFb/3clBsd7PO0JcqHl3SLHr
X-Gm-Gg: ASbGncubRcm7j7dfND9FlvujIwSv+xxT7U/oozs8y8HV7rVTmzjYY9DzEg+2ek6Bb3h
 JN2gh1CU6nxnKr9xLvglX0KnnBsQsC9vYfX9Kkz+VytBI7ntWafG9o1pUNKFrn/5y0xojoOZheI
 J8MJUyX6lrhC3DnYPIucUWts5Lx5BW3xzjgU8+ANO1I5EfGJlKXq3SwkT4BgOcttCuFNPTm9sWm
 nFMOAh2vVZ9XesjkYIdQIORSJVgo+Fjq6MfPYPMu9RxuYag4d6/aNK/3SaBfgr5sH7eSC4X8AFB
 2MZNKImh6TePeVOFJ9W/ye6Q8tbcyBNigrcsmeQWjrAXHiOxyTmZMHDGSSgm//f+9eLIpyv7LQ=
 =
X-Google-Smtp-Source: AGHT+IHa2wYDLqFcL+S178J+hwuJW93lRHr94MpAsx4W3zrsmQiuaNYkUr3+d4THaScsDK3uBGo6sg==
X-Received: by 2002:a17:90b:2703:b0:2f4:f7f8:f70c with SMTP id
 98e67ed59e1d1-2f782d4f17emr11818151a91.28.1737249245630; 
 Sat, 18 Jan 2025 17:14:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 25/50] target/riscv: Add Zicfilp support for Smrnmi
Date: Sun, 19 Jan 2025 11:12:00 +1000
Message-ID: <20250119011225.11452-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
The MNPELP field holds the previous ELP.

When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
value y, then ELP is set to the value of MNPELP if yLPE is 1;
otherwise, it is set to NO_LP_EXPECTED.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-7-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 11 ++++++++++-
 target/riscv/op_helper.c  |  9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32525f00d6..d51f3d8cef 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -613,6 +613,7 @@ typedef enum {
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPELP     0x00000200
 #define MNSTATUS_MNPP       0x00001800
 
 /* VM modes (satp.mode) privileged ISA 1.10 */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4c70db6def..3318ce440d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1966,6 +1966,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mnepc = env->pc;
         env->pc = env->rnmi_irqvec;
 
+        if (cpu_get_fcfien(env)) {
+            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+        }
+
         /* Trapping to M mode, virt is disabled */
         riscv_cpu_set_mode(env, PRV_M, false);
 
@@ -2133,7 +2137,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* handle the trap in M-mode */
         /* save elp status */
         if (cpu_get_fcfien(env)) {
-            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            if (nnmi_excep) {
+                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
+                                          env->elp);
+            } else {
+                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            }
         }
 
         if (riscv_has_ext(env, RVH)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index bb022d89e2..c825336519 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -409,6 +409,15 @@ target_ulong helper_mnret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mnpelp in mnstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mnstatus, MNSTATUS_MNPELP);
+    }
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, 0);
+
     return retpc;
 }
 
-- 
2.48.1


