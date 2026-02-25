Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C4DFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9N-0004t3-Gg; Wed, 25 Feb 2026 18:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9G-0004MT-25
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9E-0003Bd-7w
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43992e14638so234050f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061505; x=1772666305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SO+BmBnQLITRK+3WmiBg9o20m8SXEc4CsqPTzeBabiE=;
 b=q5oUWSRE+ACcDsQAU67dnTNpaFeJ6yA4w6qikGYmwf2dmU4Ckf7E+VBq/qB57ivxaX
 eka6UWsUxHNQbDt/9cmjKp9IHD36KH/C1kPZwlfYvsNy3oUqsL8b1pRowaQ9bLqS6BjN
 /lnQ/AKNzFk6+rRKGG6XOpAI5NMU0CU+bXRgjme25+pBgTGnA3tEZ/Wl5Yjon8vU6UC2
 j5/FyJLty/7cB0NSzLbEoRgIJPXu0zRMCxVeXp/Zf/6fyjhH85rhlic0qtAUolJId224
 Hnf23sbl/C0VqKBqls1WFYdEmrnq8d1JbhyO9/qrDpVntr0w/yrfqXuwn44cAINIPX2N
 m20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061505; x=1772666305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SO+BmBnQLITRK+3WmiBg9o20m8SXEc4CsqPTzeBabiE=;
 b=GYzgy1AirEcb36mrl/Ly+fMLG9/rjmq9IszaM1QZceU3cPEKI0sMdAe5vcTJ3WkSCG
 ybWhHRtQWDvtqTOCotIASMjeVYQo5u5+EB+QNv78FDlyPWJm0+KdRKtRPt9PtDtTHCA7
 19k7leSU052wTRsSz2p5t3kqbtoxHsjYj23EnBtZGvrt1El4kFNGUdts96aDm9aRdUfp
 xw2w2rQuWuuMJrlwm4T2/gSNw6LkakwQnTEbn8Z9+xQTW9d9Wdr/IGnXg4+s8cropgTq
 7AcP1xmD5pjsqzOsjzaHwTb45JRQ3J/JZAAtsJAHfXGJMWZfWRgjotNMF/2LZxwhhtpK
 sWfg==
X-Gm-Message-State: AOJu0Yz3Duv+UIPzmRyO5wzg6k70UEpg7sLhS9GeNNBoKwrrSDh7GmQi
 x9VvpPkvxC2wxq3aEE56W4Tj5439prJuHIaeOP0RZWc9VdJ0XxhXU7IjUI83TuS86F6FDo/JcP9
 etqunPCk=
X-Gm-Gg: ATEYQzxRVOy+hGgy8Wg+cz+UJvltQsL2x1q9+/Gb2yi0Udy56lR3986i/U34GIMgGr3
 E4dN1ryAaBRkhGfz1MpcWzoSuPS+mfprNBYt97mOJ34hEMM2ov8xCEreCrIfvxcCyjKVs0zTfUJ
 eX0TySe/1dt0WQK5/CeUdQHBVCvq+BZ29DzUK7ES325zqxQboO9rim7OWdNIAyV5l7N6CdyXyAl
 dSDuR1WbG6MU0miIfh4J/tBWbgqkHFTAO4Jeqvd9A1a0YLW2IFl12e/KA5a/UDOc4eXPGXNnbFo
 g1QfhpVeaNVqvEaNTC6vt2ySgjAtPQqslmXXiBBWUfHkGWeyTFuGKrX/aHK7QISUZInXPl7hkbL
 Wedv+khxsy5WBGO53dDWlZwmi+I+4LwdN+ac/OoMZqWNZcRbim0YETloZjnwTcxf3tP7jSNi2Q0
 8Gho7yu5poWMhfiNjbJs5s2G6e6X2isno7Ejq2ltOKKp5jtF2bJQbiUKVHYPgD6xejvbDqg1Th
X-Received: by 2002:adf:f6d2:0:b0:439:872f:b49c with SMTP id
 ffacd0b85a97d-439872fb5e8mr11611025f8f.3.1772061505516; 
 Wed, 25 Feb 2026 15:18:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c95dsm41121204f8f.33.2026.02.25.15.18.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/70] target/i386: Replace ldtul_p() -> ldn_p()
Date: Thu, 26 Feb 2026 00:13:37 +0100
Message-ID: <20260225231411.96482-38-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prefer ldn_p(target_long_bits) over target-specific ldtul_p().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260219191955.83815-30-philmd@linaro.org>
---
 target/i386/gdbstub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 291d56b8e13..f358bcf9e86 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -459,6 +459,7 @@ static int i386_cpu_gdb_get_egprs(CPUState *cs, GByteArray *mem_buf, int n)
 
 static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    const unsigned regsz = target_long_bits() / 8;
     CPUX86State *env = &X86_CPU(cs)->env;
 
     if (n >= 0 && n < EGPR_NUM) {
@@ -467,7 +468,7 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
          * XCR0[APX_F] (at least for modification in gdbstub) to be enabled.
          */
         if (env->hflags & HF_CS64_MASK && env->xcr0 & XSTATE_APX_MASK) {
-            env->regs[gpr_map[n + CPU_NB_REGS]] = ldtul_p(mem_buf);
+            env->regs[gpr_map[n + CPU_NB_REGS]] = ldn_p(mem_buf, regsz);
 
             /*
              * Per SDM Vol 1, "Processor Tracking of XSAVE-Managed State",
@@ -486,7 +487,7 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
                 env->xstate_bv |= XSTATE_APX_MASK;
             }
         }
-        return sizeof(target_ulong);
+        return regsz;
     }
     return 0;
 }
-- 
2.52.0


