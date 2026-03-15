Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F18F3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1oxQ-00064q-JD; Sun, 15 Mar 2026 13:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxN-00062r-Sr
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:08:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxK-0007DE-3a
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:08:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so42215595e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773594523; x=1774199323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aV0uPjxZ6bWki0zMCXJl76aFzyARhWh3CQmy3CpQ/eM=;
 b=RJCkXhM1qsLtbcGOYpDSh6YUeyuS1VlEWOg5ybDCZWhncs8bapskAcxNwQnRjAxWet
 ldFI58157NS0BIkeAf3QUUvjQ0a4Idkd5vuqAXPCXoO+hTDxS/8gkNDnrjDIeaCrEFmq
 bv2Y7pWC9R3NtiX5z5Z/fvkyRAST6wN0ei/sYDO7Uzu5nc2VgMOHZwB7aJvyBq/OYuXt
 QavPLaR2SPRFdzuk5evCWSzDfzA4F7N5fRtX7LeR9jh+4lbSe422JUHjBiP2kHzput8Q
 LJnmserxcgunlUvNX2vVWRuwUTZKNRkzMSa54jC5t/7J+GSsFxvf2IokOOVSoO/Ub7AW
 4HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773594523; x=1774199323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aV0uPjxZ6bWki0zMCXJl76aFzyARhWh3CQmy3CpQ/eM=;
 b=Yxn4NzW9gwkYFF9r141+POkCho43JifjEdmCnAV8pm0GzhHBnVCginA/i+iaoli4s4
 WtwG9cdwE73NwMVIwrq/OnFC+Z0YPk5xU0S57ROx85D8lpaoHwCaNPlPVYc8sExJcuBK
 32uIiNysvdb9AmteKiyeiym+Cuo40m+S/JrILarpfPBvOzvhlEiihBo4qosm4Cdly+SA
 nrwNOeBI8Ww8PKGiwYKsyW3KyXagOYf5Kxx1sBdg3uwnbMrzbXMzXntlYB/rXO8DW32C
 WTPGftO/9wnH9NNley5hur4xLQYf4aXLou8pH0QMkW4tjPz6bmxZvAK3EWARCfe+lWFx
 N+Bg==
X-Gm-Message-State: AOJu0YxgGXSiH37Yu4hu3hipW0K3QEjqfSzQnW6kx77T3TF+3wsKuuy9
 9Ff2axsVrUF90nLFzV8t7zMQJ1LEqFDJ5p3ea7Wn49BIKPDKYfmOZgEl6RgeuR0kUMgVslMAv2A
 3vpFtzpY=
X-Gm-Gg: ATEYQzz5rUqRN3rgVvoqSAn99SlgyDfjllb/qn48Bh54/E86b9C/m8uXxJAsD2Dct2q
 C09czvIAL+SNjTxjS6w3GhwnJH4NgjyeLWYm21PC3dKn+U7jTxSXWGzRyRRiQr4AOdA3+zrLUJ4
 e/x2S01vp5RA7jfbd354sBGY0AccaPjW9w4WZS7hT6H0PUaEdb2tOT07W0TwhqgFlTJArn8Rkja
 SyrjuZbjeciaipZzE+sgmOea446RgnE+8hhklA1FrbQhiGqrThAnrN66nXlx0xydc7Aljrbb9Gf
 RiSGowQxNMD78a4PMLIGQdGTLBJYLmVReKeFqPUaguiA19RbQjXu+fVcljbIc6R7wtE0tQKxJgQ
 xnCaJTT+plBYYWMK13M4tHePrMD4W8SCONKVzIEmvHTd1sY1jZHYRd7LVepDUdEPQ+GLGmoqb5V
 sV5BdQpuys4rejQlLopGaKXnyHgGcnAAW8R61P/5G88dG220SWCGP1Ps6cF5Aht603gS1GIHdq
X-Received: by 2002:a05:600c:8b6f:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-485566d92f3mr168031225e9.10.1773594523252; 
 Sun, 15 Mar 2026 10:08:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485564043a2sm101688075e9.2.2026.03.15.10.08.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 10:08:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/ppc: Explicitly declare CFAR register as 64-bit
Date: Sun, 15 Mar 2026 18:08:29 +0100
Message-ID: <20260315170832.40331-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315170832.40331-1-philmd@linaro.org>
References: <20260315170832.40331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Come-From Address Register (CFAR) register is only available
on 64-bit CPUs, and is 64-bit wide. Prefer the 64-bit APIs over
the 'target-long' one. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h       |  2 +-
 target/ppc/translate.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index aba8109bbba..63c8fa25acc 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1285,7 +1285,7 @@ struct CPUArchState {
     target_ulong ctr;
     uint32_t crf[8];       /* condition register */
 #if defined(TARGET_PPC64)
-    target_ulong cfar;
+    uint64_t cfar;
 #endif
     target_ulong xer;      /* XER (with SO, OV, CA split out) */
     target_ulong so;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f26b0281737..0fc81570a8b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -69,7 +69,7 @@ static TCGv cpu_msr;
 static TCGv cpu_ctr;
 static TCGv cpu_lr;
 #if defined(TARGET_PPC64)
-static TCGv cpu_cfar;
+static TCGv_i64 cpu_cfar;
 #endif
 static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
@@ -124,8 +124,8 @@ void ppc_translate_init(void)
                                 offsetof(CPUPPCState, lr), "lr");
 
 #if defined(TARGET_PPC64)
-    cpu_cfar = tcg_global_mem_new(tcg_env,
-                                  offsetof(CPUPPCState, cfar), "cfar");
+    cpu_cfar = tcg_global_mem_new_i64(tcg_env,
+                                    offsetof(CPUPPCState, cfar), "cfar");
 #endif
 
     cpu_xer = tcg_global_mem_new(tcg_env,
@@ -626,12 +626,12 @@ void spr_write_lr(DisasContext *ctx, int sprn, int gprn)
 /* CFAR */
 void spr_read_cfar(DisasContext *ctx, int gprn, int sprn)
 {
-    tcg_gen_mov_tl(cpu_gpr[gprn], cpu_cfar);
+    tcg_gen_mov_i64(cpu_gpr[gprn], cpu_cfar);
 }
 
 void spr_write_cfar(DisasContext *ctx, int sprn, int gprn)
 {
-    tcg_gen_mov_tl(cpu_cfar, cpu_gpr[gprn]);
+    tcg_gen_mov_i64(cpu_cfar, cpu_gpr[gprn]);
 }
 
 /* Breakpoint */
-- 
2.53.0


