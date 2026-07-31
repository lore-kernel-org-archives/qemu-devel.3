Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFDFC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsPY-0007T5-Qg; Fri, 31 Jul 2026 14:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPP-0007Pv-1d
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPL-0002Bp-Q1
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso15495525ad.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524194; x=1786128994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gM4b4z249JqdXNGEc6PkyqoCWTNGF1ul9Lvs/sJ0Pqc=;
 b=GyvgD8EnjChyNAbM2rdSiB30hF9CDt1dBUKLH7LxGHrruR2SBsXmBnodhcdhykOo4X
 f+95ptkiElpMTnXa1J1YJNljlFxyWBPwQgyNfX+Np/EDKOcIfZAAL0T3X+PG5f9DxKJ4
 /i1zvhil/nXVbLy1iDhWxF+BcPck23btLFdnWnRcvmI/V4hCO2fcJeSJ3kGfGVcZhkhX
 ylosD2Fqu9CjR6JSiyeP/5ibw/q1CVagNy4v9AcyOKy17bdGoyY5RBnWvqjPA01kK2LT
 HkNaB5U8D8DYx9EuO9ht8zVLG2F7KNqktaKjVc7VK5ubSNeEVhDns7mumdrymEqlHBth
 wDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524194; x=1786128994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gM4b4z249JqdXNGEc6PkyqoCWTNGF1ul9Lvs/sJ0Pqc=;
 b=LAMslPJbI+XKomNCAakFIPUliLMCubJslFFIp4oQiT70Y4zA9XJI64Dlq5PkLZbsAu
 CX/sQPnMDg7OrZkeH2HHIY9UYAPeDoDCK4q4tSgXISXs2NPZTv7Q9qLhssd3vRJdmXh7
 Kx8CNvKD6Ktt+rdc+5Kc1cimAypV721YqHosl518hFwxNdpLf1NTQ0t64IfRgDJ2skmB
 2PLYj5YwjVwfIlutO66djIFaoyeF8u9k5ae31xXdc2pWwG6SQfkk6VVMCYOMvl3kBKGp
 KcnO02vxkGd3Jh93n855q0xxDhw3yfAbFEnCNmFysEErK6zgAgxgDOop/TWvrCbWiwim
 rcNQ==
X-Gm-Message-State: AOJu0YxIDI9mBRScqUUAKUEjP5Yxv0GhVacxvqk7qxO922QweE2FiPzw
 HqK3eQAk3OC3EozU1RmRucQ3NBJwvqqJfc6odmESlYjjM8s8X/kTUztza5MfXNa4pLWJ/fb2g9J
 Su/Hd
X-Gm-Gg: AR+sD138SFY58LkLW/yjNPqdn+aFdnvN8au9rV9nRCvxye3hMSPinw7Trgm/QzNH+D7
 ycPNTjWXqr6MoAAlgUQDvjLzNzWUuMC9HTYCN8F4K/YI+3DAJYr15ZcmrWWpDSV5Vm1XZTS8hxB
 8yjtgTS39gopL1TIcmXsQWEVCt8rXcjjOgi+Gn6mWFeDMKyd1f2UboTU8Rg6H4eKtrlJL6wyycE
 FHuakU3U/f8d9L5bO47V2I5VLvIfxJQZ+baXrXmMsrJgiJ4wBbflnZ66hmazAOc4nJ77cSOYbEf
 6Fctb0fJ/S4ve4bkwqlyR+fkbTRhSwQfpjyXA5MgFF0KJh2gWKFX42B3y7/BmdvhJOpvZDLxgeZ
 d2YL4FD3IucCLEJTMVxtNAN+6ud7KaQsjOYK9/Chd7YGyMahO/pgMqqaXyqyYUTr1Le8n7EtHF8
 NDJkqIApyYa7RxjTfl85u+CRWtQ4X8ligLhmyUSPRRsRxUtbFeG4WG1hovfhWFegRrbRQ4WRCY/
 ouHEFnaxE4WuTorSuLS
X-Received: by 2002:a17:903:26c4:b0:2c9:97a8:8c17 with SMTP id
 d9443c01a7336-2d05247261dmr10007305ad.42.1785524193884; 
 Fri, 31 Jul 2026 11:56:33 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 05/14] target/s390x: Convert op_ld32s to op_ld
Date: Fri, 31 Jul 2026 11:56:18 -0700
Message-ID: <20260731185628.23161-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Note that op_ld32s already or'd in insn->data, with the only
use being MO_ALIGN.  We now put the entire MemOp in insn->data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     |  7 -------
 target/s390x/tcg/insn-data.h.inc | 14 +++++++-------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index d18450f764..79e02534cd 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,13 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_BESL | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index d6cc157cb2..46a4a23d2a 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -418,12 +418,12 @@
 
 /* LOAD */
     C(0x1800, LR,      RR_a,  Z,   0, r2_o, 0, cond_r1r2_32, mov2, 0)
-    D(0x5800, L,       RX_a,  Z,   0, a2, new, r1_32, ld32s, 0, 0)
-    D(0xe358, LY,      RXY_a, LD,  0, a2, new, r1_32, ld32s, 0, 0)
+    D(0x5800, L,       RX_a,  Z,   0, a2, new, r1_32, ld, 0, MO_BESL)
+    D(0xe358, LY,      RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_BESL)
     C(0xb904, LGR,     RRE,   Z,   0, r2_o, 0, r1, mov2, 0)
     C(0xb914, LGFR,    RRE,   Z,   0, r2_32s, 0, r1, mov2, 0)
     D(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld64, 0, 0)
-    D(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld32s, 0, 0)
+    D(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BESL)
     F(0x2800, LDR,     RR_a,  Z,   0, f2, 0, f1, mov2, 0, IF_AFP1 | IF_AFP2)
     F(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0, IF_AFP1)
     F(0xed65, LDY,     RXY_a, LD,  0, m2_64, 0, f1, mov2, 0, IF_AFP1)
@@ -434,9 +434,9 @@
 /* LOAD IMMEDIATE */
     C(0xc001, LGFI,    RIL_a, EI,  0, i2, 0, r1, mov2, 0)
 /* LOAD RELATIVE LONG */
-    D(0xc40d, LRL,     RIL_b, GIE, 0, ri2, new, r1_32, ld32s, 0, MO_ALIGN)
+    D(0xc40d, LRL,     RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESL | MO_ALIGN)
     D(0xc408, LGRL,    RIL_b, GIE, 0, ri2, r1, 0, ld64, 0, MO_ALIGN)
-    D(0xc40c, LGFRL,   RIL_b, GIE, 0, ri2, r1, 0, ld32s, 0, MO_ALIGN)
+    D(0xc40c, LGFRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESL | MO_ALIGN)
 /* LOAD ADDRESS */
     C(0x4100, LA,      RX_a,  Z,   0, a2, 0, r1, mov2, 0)
     C(0xe371, LAY,     RXY_a, LD,  0, a2, 0, r1, mov2, 0)
@@ -464,9 +464,9 @@
     C(0x1200, LTR,     RR_a,  Z,   0, r2_o, 0, cond_r1r2_32, mov2, s32)
     C(0xb902, LTGR,    RRE,   Z,   0, r2_o, 0, r1, mov2, s64)
     C(0xb912, LTGFR,   RRE,   Z,   0, r2_32s, 0, r1, mov2, s64)
-    D(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld32s, s64, 0)
+    D(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld, s64, MO_BESL)
     D(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld64, s64, 0)
-    D(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld32s, s64, 0)
+    D(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld, s64, MO_BESL)
     F(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32, IF_BFP)
     F(0xb312, LTDBR,   RRE,   Z,   0, f2, 0, f1, mov2, f64, IF_BFP)
     F(0xb342, LTXBR,   RRE,   Z,   x2h, x2l, 0, x1_P, movx, f128, IF_BFP)
-- 
2.43.0


