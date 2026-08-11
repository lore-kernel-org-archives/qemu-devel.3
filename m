Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CD1C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXC-0005PD-RT; Tue, 11 Aug 2026 00:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXA-0005My-63
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:16 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX8-0002mV-NG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:15 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1901230a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424173; x=1787028973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MvU5RuUyvaJ0QVBA1caUeoSC+hVj3RDceXJncQ30EH4=;
 b=GM/STCKyGAR4ktR6+e34jhweXlz+qVp2NHquIUh0LhrOvTNYxirCM3PvLerqHk1UzW
 InWCbk4i9GCJHU7elMECsMdfsLitJ0d7yPSEO7UynJSqi8jqMP45PLbxVonawKXg5rWX
 qTWsVw66FGsEzylDTKQV0fqb+Un9PTmFfEoujwTvjlLHGIeyw0nvxnB8IsQdNISX3G1u
 L0RmFCTCM/VTytzOzvaJyczDA9VdLyrbwQ3jH+OcLv7b0D1OzI1U1+AKZHaDt54SPtDC
 OcIpAAiCecttX4UJLgQUuSINBv7qu7gR++qfwKnDgoNVM9YHbmwaarDgovycqDHQiSk3
 Bi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424173; x=1787028973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MvU5RuUyvaJ0QVBA1caUeoSC+hVj3RDceXJncQ30EH4=;
 b=Jjy6n6s0NaAaxHrxh6gkPPN/GRoND2VzYWgcrMtCymVjGseGEgVueZXlEfo+h4W8ev
 +PtIpfHkNQoFPnZVCl3mGmAod2twHpYupXHewipT/6b895/GFg2R//fTuyyIcwAQr8/B
 jObAVFOrpSwgM8u7jk0QmkLD+6wJuHB+J5TeZc06Y5iwS7pvTZv9jmojzHpS3lYqHTAE
 G8FN2RwCjCF8XCxM462Dla+S69zhFV+WxNyMr4IKuOp430AIiVmpW8cdReJm7+dXMHYU
 hzqcdx4W2c4kW6o2l/Ub1yNT7jBygbvJN/kbxYX/lo1D2gHsMUf355djSfPwEWU6dM24
 9PmA==
X-Gm-Message-State: AOJu0YzmIRWl/Gn4RLCQcfvqvCyQzJjnTfl28WeGItaWEp1B2MeaYnd4
 x74RgVNgeBV0EFOq+61eHIX9KA0Gvn8RMBeBdohNmhLI121shY0QFxpWcwcJFTRxPyG/a/HjdOS
 yKVwz
X-Gm-Gg: AR+sD13KQ3PfdXgd33Fy7zfmD1F7EkEXwp3l89eM+ImObaa0Rh+rs+2797xUwghvBP3
 y6B8yKVwNm7rYgNobBvnu/R41SYGZR+yxzaFZ+IJW6svLuzPcoE/1ygN9xcn1pBTla7Fc67++on
 +OL1RZ9nzKe+snCrmiVmY2GQZihws2/qjlXbAz1RQiDPhseJjqR2aWRax7IRi/0PZx3sIqHDLvk
 pf7pX6/LtD7yu94VpGKY5m+/2XInFK8xDSymzID59Ks42LQNqcavhDKJrAxIQiAMCIdOSfubeZm
 nNpLkrnbAhPp2WR5onyWRtrI1avLqq6vRT2qVU5pATqtiErlcp24aASfky6GPA5rbXvd+EkHXD0
 4qLELhsS6IQIdQAl5T/i5BgyVI0E5htsKYBFrHnrTAttXiWkoSgvLuEUPqL89Y2JWwAG7wtxakx
 512BilZyRN5HJJ1iiegAqY9o04Mrmkx7kkiRf83gnCXkr0lseczGoD13IF4VQmhqgRFQxh2KTyV
 Wdl1ODQ+/rG83agTst5
X-Received: by 2002:a17:90b:3b42:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-392ec56af08mr631155a91.11.1786424173277; 
 Mon, 10 Aug 2026 21:56:13 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/16] target/riscv: Use generic tcg_gen_revbit8
Date: Mon, 10 Aug 2026 21:55:56 -0700
Message-ID: <20260811045605.1246543-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                       |  1 -
 target/riscv/tcg/bitmanip_helper.c          | 15 ---------------
 target/riscv/tcg/insn_trans/trans_rvb.c.inc |  2 +-
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 542b7c264f..4fc2d3a155 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -79,7 +79,6 @@ DEF_HELPER_FLAGS_2(froundnx_d, TCG_CALL_NO_RWG_SE, i64, env, i64)
 /* Bitmanip */
 DEF_HELPER_FLAGS_2(clmul, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_2(clmulr, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_1(brev8, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
index 1156a87dd3..d8d94bca7b 100644
--- a/target/riscv/tcg/bitmanip_helper.c
+++ b/target/riscv/tcg/bitmanip_helper.c
@@ -52,21 +52,6 @@ target_ulong HELPER(clmulr)(target_ulong rs1, target_ulong rs2)
     return result;
 }
 
-static inline target_ulong do_swap(target_ulong x, uint64_t mask, int shift)
-{
-    return ((x & mask) << shift) | ((x & ~mask) >> shift);
-}
-
-target_ulong HELPER(brev8)(target_ulong rs1)
-{
-    target_ulong x = rs1;
-
-    x = do_swap(x, 0x5555555555555555ull, 1);
-    x = do_swap(x, 0x3333333333333333ull, 2);
-    x = do_swap(x, 0x0f0f0f0f0f0f0f0full, 4);
-    return x;
-}
-
 static const uint64_t shuf_masks[] = {
     dup_const(MO_8, 0x44),
     dup_const(MO_8, 0x30),
diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index e4dcc7c991..3e74be223b 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -522,7 +522,7 @@ static void gen_packw(TCGv ret, TCGv src1, TCGv src2)
 static bool trans_brev8(DisasContext *ctx, arg_brev8 *a)
 {
     REQUIRE_ZBKB(ctx);
-    return gen_unary(ctx, a, EXT_NONE, gen_helper_brev8);
+    return gen_unary(ctx, a, EXT_NONE, tcg_gen_revbit8_tl);
 }
 
 static bool trans_pack(DisasContext *ctx, arg_pack *a)
-- 
2.43.0


