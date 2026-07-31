Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6F4C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQK-0007lz-3R; Fri, 31 Jul 2026 14:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPT-0007RR-Cl
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPR-0002EL-BD
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ccf2360620so11949135ad.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524200; x=1786129000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=loo/8EGbpZlV9iSoQij+lYt62Z9p7jf/y3gViUCxGWA=;
 b=PngKcZk+HDbisy3gRfW0HzORlojwduWYeyp/86RDpecCbmgb6HKyh9vnw3x43HO2r2
 emB2Agck02fHVcOIsqBNdQ0Gd7V3/DHdya6eNVJt6fIx/naaiu/tjbkfH1L9Qee369kv
 V4fRuH00mn06ooE+YIa6Ub/HMxvl8hDjEckZcjluNekfvhBCUTUKk6eE9JjE0saIOBqG
 TYNKnav/3zcWOr5kTDaY+IwUfqHX91L50jJ6TaJyFqojwd+5luYxznno9/PJbj7J6M+a
 Ve9TNeZLNrZ+BHjDVgGBeKuuRKlztqJaC44Y4QnNTlZpwR6Ehlf/32fmZqkBPooNln4A
 YWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524200; x=1786129000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=loo/8EGbpZlV9iSoQij+lYt62Z9p7jf/y3gViUCxGWA=;
 b=d4smoOisvjOKpzp7GqkjWHpkm7ibVCuEhAuViPOMiZDoVRR8IqK4bFuWELI28OLt0X
 T5dcDWXx79WEPphzp4wBElBvv+mxSacYNZP2GBrhhyWY/gPtWifBCVLfAm12gVIFftrK
 gVp+v3iWKMfDOuKqljei/rmDs3/3WQK9N7WSkwE7w7y/8ruPAGTjrEPrFTQiqWmIrCmS
 QPdiY3/UoFgYDmUDRQFXDkXULK4Wypey2JjyDPA9zgylpAAItkDk804eDTb31W8bB5Zx
 CGgKaFXpAqlKOhMMljmlmNyN7qvLrMluKe94lcl/TswnGxFFKN+DtUTnGXhHk7QdvX/G
 F0Qw==
X-Gm-Message-State: AOJu0YyHQ3eADp5hYmG6YPMBM05/IdBcRUrmvxLtiw+lyyp5ndQv9Ke+
 B+eSSaZmWcum1XtXHpJ0ef+uy02FcJXxRnsroHAxIwjDxx0sjc2plntgGuvA34eqp+i+fh7pPzq
 hUNkz
X-Gm-Gg: AR+sD11XkLuvvCEVlcdM6vAr0fCcxDK6CcKtxPtLZ4vxvrwUXseG+U9pClSveA85ojQ
 QA9azf5absCnX8Vvu0bYMD0M/2DsAex5hIMxmFQ226CJAW337tS0UvIXhUicoAOCFCUuglzOZwY
 D3c65XABixGFrWoirCOJoRN466XNcrz3FwyB9lBkuoemwgKocp+/6ws5WXfMxTFfdOCNphZEJvw
 wrRpwK3WK/Rx5nIuCT1y6MCteXiJpHz5FW+2Cewh5pjWfKrp9bpTF00pW8LNrmAFzKzOQHt+Onj
 mr9g7VZnH9B0pSFIteXKjHTBXdTTYlwWzoYsMV3oSgJ6AQItSaPhJB1x4soPi0BuSeZJkZhV2Fs
 4fVKexrSFywUPdTZ32FqNyQl4LbzGFnX6uyTOTUYOPm3cjY95Ndh6InN2Wk3Dg3P7qT1/Gf58Hx
 jTbIT80BAavtTU7oQTjagK/qPa6i41DyMLhT0DQKoRD6rmKFhq8AyGHsymM+KSqQB0NHP2qLBez
 d000eesoxPsQ1mpnMv2
X-Received: by 2002:a17:903:3843:b0:2c6:a012:6241 with SMTP id
 d9443c01a7336-2d05219f33fmr10702685ad.6.1785524199735; 
 Fri, 31 Jul 2026 11:56:39 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 11/14] target/s390x: Convert op_st64 to op_st
Date: Fri, 31 Jul 2026 11:56:24 -0700
Message-ID: <20260731185628.23161-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/s390x/tcg/translate.c     | 7 -------
 target/s390x/tcg/insn-data.h.inc | 8 ++++----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 5cfa4d7d1a..61793a9e80 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4348,13 +4348,6 @@ static DisasJumpType op_st(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st64(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-                        MO_BEUQ | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_stam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_constant_i32(get_field(s, r1));
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 54234ffb57..3611da1ef3 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -850,14 +850,14 @@
 /* STORE */
     D(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_BEUL)
     D(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_BEUL)
-    D(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st64, 0, 0)
-    E(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
-    E(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
+    D(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_BEUQ)
+    E(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st, 0, MO_BEUQ, IF_AFP1)
+    E(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st, 0, MO_BEUQ, IF_AFP1)
     E(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
     E(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
 /* STORE RELATIVE LONG */
     D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUL | MO_ALIGN)
-    D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0, MO_ALIGN)
+    D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUQ | MO_ALIGN)
 /* STORE CHARACTER */
     D(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_UB)
     D(0xe372, STCY,    RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_UB)
-- 
2.43.0


