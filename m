Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0882CC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQT-0007uP-SE; Fri, 31 Jul 2026 14:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPT-0007RS-BM
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPQ-0002Dz-Tp
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:42 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso13925355ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524199; x=1786128999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWM4JA8VnQBvekbyzY3EUU1t/xEo1p1HoBiLiKwlsVI=;
 b=SSUfKS3eitzGG2ud+4zA8lfvvfODvpn3W60DartdRbiJn+v8/yhMaTq+baPvwXir4p
 EJyzaw1jHmfjkZyd83gYZtZz+gflqoEEc4jOHQeYXX2JIvvhBypjfyCnrvQZCI8dySJ9
 971utnxVIW/rtt7jW7S1uSfuxlVz0QYUgJSg67CpDh1IzrB0gUByIjg3IhLytutPqEkt
 cTIYzBa2V/PZwR4K4vNl2UqZnD2yqMkXWJFGjA00Kk97U1ogXRV5Wcd6vpMkKdZQ7RS4
 iWFNELN2HKvpLojfMq7YFbXUSR9RtheyWA7cy7PHTp+9xG8f/eHCm2D/CXVDDTThrlZs
 8mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524199; x=1786128999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWM4JA8VnQBvekbyzY3EUU1t/xEo1p1HoBiLiKwlsVI=;
 b=lPzSsmE99dof+MyW8XnVANdDEYtQpcaQ5qXTPcrhxkGpKTJOJrfxMvthDb3mtnKEF3
 bvXIHHiD/nHFHlWrzFvUgO6RQNFliu9X7xi5vMfck8ELblg0W1e7eAfUq95qmxzOAu64
 iOdXgarLHcBSSgPk/WmLubD5XhHqSmkoks1pdBmNeFygdYxxCOQRemcl3bVysikh74aT
 A3346Ml9O5uHHPlGGxG5HwMHHIK8M34LSBcvl75w91QTDIG1dmDrn23nLb1NS0Rg2WLM
 ZKIQNSnbI4iMJ9vtG6gMCOS8tbpn4EopxpcWrLdSa6JV0ss59/ETTasHjyOiN9EdMAz1
 lQdA==
X-Gm-Message-State: AOJu0Yy0+a1ST8LIZg+Bbw7u03+DMyQFC2q2N6d8aR+sCKd+uUbr31G7
 CKGXeFYrQ/5Fi3uo6b4pDzgruPmblk2zm+u0enwWQL+KT5XWhvxGpypNoenmUjrrPf85b+hMdhd
 ksnn0
X-Gm-Gg: AR+sD10tq0CsZU40iP0llamcSE/F+p3brnNp7D92zJi6BRhF0BE1kTQX7E9jyvSuoZm
 +j2BMuy0ccxuAwR30e9aUpFQFmLPauZ7rJZfgDEx01yg7zFPZdb9e1TsLRaLvluUnA5L4BIM8Gh
 rsBzDAybMgExSIQXQPnPMAq/3Ziju2mQBv5gEcbcE0PFNSNS+WvMPI3m9iT5+SY9rfx/revaZrT
 W3s7Ppm5hUk0EKD1nJVPJsRlpN2d8oslfvyC8IZHNgN/jv1atLw20bAXbiUMCaKFHolXSk2DNCS
 gR0wPfRI1fuIBM3qJS3xCBU3/Jkj0leD/UcZYbNPpqsm8iLbEGORvq/MsHXqFRAvqKhro4R/JEY
 UkMbibmOmEnE4oU1D34EgDCY3noE/CWbCLZ/mdY03Qy/PsaljIlK8v3+HzJfSbl4VS1C6StpgAD
 8ydVFBxQreOWLNj7MptkFrTS15RuDEeh0fBKmS5xbI9nnYQez+F2L3nvp3og89mE1zBtf41jp24
 ragGL45fC+Q47EkJ1AlmeafMzrvVgo=
X-Received: by 2002:a17:902:c40b:b0:2ca:bb5b:3c92 with SMTP id
 d9443c01a7336-2d05244ce77mr9802115ad.35.1785524198975; 
 Fri, 31 Jul 2026 11:56:38 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 10/14] target/s390x: Convert op_st32 to op_st
Date: Fri, 31 Jul 2026 11:56:23 -0700
Message-ID: <20260731185628.23161-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Note that op_st32 already or'd in insn->data, with the only use
being MO_ALIGN.  We now put the entire MemOp in insn->data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     |  7 -------
 target/s390x/tcg/insn-data.h.inc | 12 ++++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 8339a7868c..5cfa4d7d1a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4348,13 +4348,6 @@ static DisasJumpType op_st(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-                        MO_BEUL | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_st64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index ca495d1dd4..54234ffb57 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -848,15 +848,15 @@
     F(0xed15, SQDB,    RXE,   Z,   0, m2_64, new, f1, sqdb, 0, IF_BFP)
 
 /* STORE */
-    D(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st32, 0, 0)
-    D(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st32, 0, 0)
+    D(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_BEUL)
+    D(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_BEUL)
     D(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st64, 0, 0)
     E(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
     E(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
-    E(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st32, 0, 0, IF_AFP1)
-    E(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st32, 0, 0, IF_AFP1)
+    E(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
+    E(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
 /* STORE RELATIVE LONG */
-    D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st32, 0, MO_ALIGN)
+    D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUL | MO_ALIGN)
     D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0, MO_ALIGN)
 /* STORE CHARACTER */
     D(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_UB)
@@ -875,7 +875,7 @@
 /* STORE HALFWORD RELATIVE LONG */
     D(0xc407, STHRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUW)
 /* STORE HIGH */
-    D(0xe3cb, STFH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st32, 0, 0)
+    D(0xe3cb, STFH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st, 0, MO_BEUL)
 /* STORE ON CONDITION */
     D(0xebf3, STOC,    RSY_b, LOC, 0, 0, 0, 0, soc, 0, 0)
     D(0xebe3, STOCG,   RSY_b, LOC, 0, 0, 0, 0, soc, 0, 1)
-- 
2.43.0


