Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDAACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYg-0006OT-Fz; Tue, 12 May 2026 02:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYO-00063y-6H
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYL-0006we-Tt
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so62557445e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567111; x=1779171911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r8+NFf9FyKxtvMfqFZnOV5rrCCyn81He/Ss7zMXlTQc=;
 b=qg7kKjDMMWMkjgXBOBtbaqe+FN3cV4Xsip92k2GqBg+gxoL2SJko/sOOmOQvqPnu41
 E8puf4v0D7CHElsP2fjXEJQTWgfjIZ8ODCg0egsBrGs2xJUCM8mU3xTOo8WxChoowpPc
 rbpOyMLujLo1TaLhf6CpsmgwoUijduAUbc6nbQcr6bethAMogBXY1lxpCINm3Zzk6Jck
 GICkUapFkyytw5oq7b9yiBHK+6uESxJyyNwLtGaD6swcah6EcyGy/DZHeeCxdlxa/ysp
 YhtiRHhRDFe8+IfxLluVSLdBaI/xhnmWlzgQ90a0G2bBnU77ZbfejOjwpI2Jk87LiX2s
 IBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567111; x=1779171911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r8+NFf9FyKxtvMfqFZnOV5rrCCyn81He/Ss7zMXlTQc=;
 b=MY+T8X1kM6S1O/kXwmkIMLrXns990jTi7yMqrmPHuVfOLzGYudMCEq2C7qIXfWC1/U
 HSmhGT/eNXW2g1qSYIFKTCZK6E1WDuT7RbtGKGtq09DF4Oi8+0iRmd/fygHJsxfFyDkZ
 NKIt9Xk4fu1M2UVt4d4D/KzS2N6o4YeJtzbGBYTV/XpVYqKkckhqCIuaZJ2ZTJDxmLwh
 Ieg9BAh6gJcbjJdA8dFtIOdVNH9iRQb6Rg/nleaoWbpTBkP5umaJwgqgUfX5fVX42OBq
 ggl3mKaUAg4kgQQlrD0LUz68hRfaRm19vBfdK2nlB03dGsLBeGnj5E2HMkwHVR+r8naD
 Hhnw==
X-Gm-Message-State: AOJu0YwXt+CuD99U765SFm92fdcEFrA/KtobaHjNP140eCRPPXJMmwm1
 Zs2PeANDS7N+F/0CtyIftuMiWtbGVW7GMBY/8agrOpVIDezm4gqZYN/qqRaK70WZU00Ou5Tj2FE
 pw9SWvaE=
X-Gm-Gg: Acq92OHnvWD4AMQZKHWeLZ+MvEnEDCBDoUEQLtsID5HFFMGEH6e6i9vbsxmMwFm2aJ7
 Glaf5IAYbh1WAugBNkSVDQDClcN+mzJjPtlWHpgImvVURr5Y1KpumuuX16pjkskApIWhorCHNJ5
 jDgUtVHoWDBK4V3qdwjjsHYaMMKChZJGo7gH5o17BMp3I8GmRC9fTBBGKaHP4Hw0XFZPyEmCww8
 ++VyTbAdSFEBThozOQKzWvYWU7wbJdkpeiBiT6HoEganyREPnbyfiYsvsZxkT7VX8dq6KzQVDxW
 1ePOA0Fs4lEqv03OH2Ed83+JI2umEJPcaly2Mc8GX8yGr7sf4Vu0s7EwQnvr+I/TkohROZ2+m97
 4QhP38p0UDMeS+LMekgu0MklsJh9iyhvLFiq8TgKRLiWCsm483L+RR7s/iC11M9M4s4Cfekhaub
 irU6UleBTZsepauIJQQQq+QzwJpqQ3YQfjWqa5aAfUMT8Ye7bQdJkIOF8qAWdPsz8hXHT4aUu+
X-Received: by 2002:a05:600c:37c3:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48e8fe7cdb0mr22005855e9.21.1778567111363; 
 Mon, 11 May 2026 23:25:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f435a76sm11424065e9.21.2026.05.11.23.25.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/41] target/sparc: Use cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:30 +0200
Message-ID: <20260512062142.67998-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We want to remove the cpu_get_phys_addr_debug() function; update the
sparc dump_mmu() function to use cpu_translate_for_debug() instead.

The "mmu_probe succeeds but debug translate fails" cases are probably
not possible in practice; since cpu_get_phys_addr_debug() would
return -1 in that situation we make this conversion retain that
behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260430093810.2762539-21-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/mmu_helper.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index e1abd520c49..e441ffb8f7e 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -360,26 +360,39 @@ void dump_mmu(CPUSPARCState *env)
     unsigned int n, m, o;
     hwaddr pa;
     uint32_t pde;
+    TranslateForDebugResult tres;
 
     qemu_printf("Root ptr: " HWADDR_FMT_plx ", ctx: %d\n",
                 (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
         pde = mmu_probe(env, va, 2);
         if (pde) {
-            pa = cpu_get_phys_addr_debug(cs, va);
+            if (!cpu_translate_for_debug(cs, va, &tres)) {
+                pa = -1;
+            } else {
+                pa = tres.physaddr;
+            }
             qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
                         " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
-                    pa = cpu_get_phys_addr_debug(cs, va1);
+                    if (!cpu_translate_for_debug(cs, va1, &tres)) {
+                        pa = -1;
+                    } else {
+                        pa = tres.physaddr;
+                    }
                     qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
                                 HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
                                 va1, pa, pde);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
-                            pa = cpu_get_phys_addr_debug(cs, va2);
+                            if (!cpu_translate_for_debug(cs, va2, &tres)) {
+                                pa = -1;
+                            } else {
+                                pa = tres.physaddr;
+                            }
                             qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
                                         HWADDR_FMT_plx " PTE: "
                                         TARGET_FMT_lx "\n",
-- 
2.53.0


