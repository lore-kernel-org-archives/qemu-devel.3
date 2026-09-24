Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD8CC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9phF-0001EC-5l; Thu, 24 Sep 2026 16:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1x9ph9-0001Dg-Rj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:05:27 -0400
Received: from mail-lr2-x0f.google.com ([2a00:1450:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1x9ph4-0001EN-7c
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:05:24 -0400
Received: by mail-lr2-x0f.google.com with SMTP id
 38308e7fff4ca-3a64b06fc66so471601fa.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790280320; x=1790885120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KPbQs5BTQ8nMQTXbBgLc3nF9iq7pKBcE9Di5TvzCmRY=;
 b=meAVeZ39UdukJ4oJS79D0HPTUQfEBS/Bn/hHLGF07Ts4YjgAZlAZuIFdacUYOiLwbS
 VwkwKGPEVeJu2TEjAz3QFoujpSWPKGeWP6nBZMra2xdcrOzaUF5fSqbEEeMI9mmJLKPa
 NUyuTYMG54wz5vK1KUIPUUnb5U28ek529ZJFQnodGby9MUzGJduQNUwwoo7oDRLx5V71
 wCI6Q7m9GEegNwXuZEB4AN1SNnEvKIlgWUDfrrAacp7YnDp79xdqnh3pTF6wT/XyIcT6
 lblhbGZ9bCDhCUU6vHMS2zvKclix9lYwZUODUpmAd8+i9hC6uv2rmpbxvRNM3ziI1fxq
 Hw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790280320; x=1790885120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KPbQs5BTQ8nMQTXbBgLc3nF9iq7pKBcE9Di5TvzCmRY=;
 b=2Nn5al0dQtmGc0lUM/OK/qbh9BV8fK8fCdEydnN7VnjdOUxR8F+z5EPcD+v7VgiXMk
 lLG/VXlJzsDBjw7ufOMNAby+VXPnPm6dpFqNgToyWhUlEEx6itHojjpPqyulzXypn0w1
 hByLEd1XAHAqPvc1EYj7raVCwGCX73StkyCAs4DJShP4ow1XddElF4NJ84tmdE805REJ
 J32rvWaRmhikPeEBbm7Kv/FYbxeAHT/imG24EEX3X13ixvFKPEwYMeU2vvBfw7aFtPcm
 skP3vU+kkW0K/zLMxxvihWYLbHu8hQc41KB5NOvSco8jrRH3Lh3hEZP6YbgsX9yyk70f
 aMew==
X-Gm-Message-State: AFuF++ma8wmWpBe+d88aymzcmWJJH1dH2Dq9Mizu9jz5xJKTWSzI+MS8
 c8B8duvnnWUHPrjp0pHvar7w5Cb5Nmfe89gW6ad/1QBtic1bl+jJ31RdG86zQg==
X-Gm-Gg: AYBFou3AmHkVFkBk7ejBKP9UqpsUw5Ycck7QDCoNtdU1KTRCiyMS7iFRk6GBkTo0O1v
 MRo/BY4MCDFS3yhJgVi9nXY9EkvffP+W1+XwASQGM9m0TPb4loc/rNjUQLKrAtYjQc5k3usXrhU
 ackpW3g0Jqt05Cn9S4VwQQIdBX0+THU/l55I8qPr6MTRWX5OjY64xkeQuqQeMchAIenfo48AmSy
 7mAIb92OtTsL8qA3ZYOD32sZZhRa+EdjTlxZtZPExNyB9e/oxhaLLUZAggtqmGC79bttUnixHJt
 zADisHNcApjPX0jQCAjq3W2pIYDKTw8UeOiAFFMVgftbnUsmL/ZLhsJz7WfK4rKM+DCtTGVTYw0
 n7z5OTCtpg1Pzb5pfqV3tFoiuwBYl8fsEYlu5q56qeeEipIKDTGmOhAJDShetaV70ZlAM+d8t1i
 xNGwsCoPlRknHwr2Tr1+I/Lqi649sDGirQbrmm4QPX9msHs/PgDxbMDVvKxmcBrBfOpaD6m/HgW
 mNJbsOioip2sppwLwEOtd4q4tAGOiAw3gurGkJVG/LhsJS2dDRmEO9+JWjMVrxRpsij
X-Received: by 2002:a05:651c:43d3:20b0:3a1:8558:56a2 with SMTP id
 38308e7fff4ca-3a63bf54319mr6596851fa.6.1790280319350; 
 Thu, 24 Sep 2026 13:05:19 -0700 (PDT)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a64c2fa412sm354941fa.22.2026.09.24.13.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 13:05:17 -0700 (PDT)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: fix immediate stack adjustment for RET and RETF
Date: Thu, 24 Sep 2026 23:04:20 +0300
Message-ID: <20260924200420.21068-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:38::f;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The imm16 operand of RET and RETF specifies an unsigned 16-bit count
of additional bytes to release from the stack.

Previously, gen_RET() and gen_RETF() stored this operand in an int16_t.
For example, 0xcaf5 was interpreted as -13579 instead of 51957.

Use uint16_t for the adjustment in both functions to preserve the
immediate's unsigned value.

Tested locally with near and far returns in both 32-bit and 64-bit
modes. Each combination covered the form without an immediate and
immediate values 0x0000, 0x0001, 0x7fff, 0x8000, 0xcaf5, and 0xffff.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2599

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 target/i386/tcg/emit.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 473f415766..0c35403ebc 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3598,7 +3598,7 @@ static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
+    uint16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     MemOp ot = gen_pop_T0(s);
     gen_stack_update(s, adjust + (1 << ot));
@@ -3609,7 +3609,7 @@ static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
+    uint16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     if (!PE(s) || VM86(s)) {
         gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
-- 
2.55.0


