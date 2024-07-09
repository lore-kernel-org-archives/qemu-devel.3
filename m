Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2A6C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRB9v-0001po-8B; Tue, 09 Jul 2024 09:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRB9m-0001gZ-Tw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:45:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRB9Z-0002Ic-BX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:45:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso28645745e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720532707; x=1721137507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Dy9tTmWCONrl3V4OHSFlfMTEYKzq0YJeFJJEkMNS3s=;
 b=alWsvwfhzHnK2URrWjrt8vbIVzzFbZM9aBR8ufViCm4XnoxDUoDTBHR19/R6xIhjHd
 T/P0aaGy9r7Nt+pMGTCsdihfNQuxq0P2Kntu/XLzufb+7wta7J7LCy4ka1HFcAxHhjU6
 oKjTkUaJ8NeaylYWs7uKQbp+w/TIT6ixi7pt9Q7b3R9SpumbgHH2Jid0pH3HYA3B0tKh
 W0rtYY+1PBNL5lLk5wgZJnHX54Jyjm2F2baqBKgi8wd1e6pI4cqECHm34DXmll1W3l6c
 bKxo4ouiZUUVcOsaSTcy7fbH1l1CK3ix6DchyxXrD/sHIM5/YOikCux4+EfVs26kG58W
 eZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720532707; x=1721137507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Dy9tTmWCONrl3V4OHSFlfMTEYKzq0YJeFJJEkMNS3s=;
 b=E+QEiQ5vaMT2AB3MAmvdVcG9IovBPAIoDIYplWKbHRmfMhnXdNP095WBpZRPid43KD
 h0j2H3fxExaqqTc3Lf+zbZAVCd6lqXl6XOIbPPxahQyOoRLG9ufxpuW0GShC/AOBMPqy
 DwBnsyBAkxkDfc4QbxpoGrPI2xikaGaWeLxoBLAh/+D6Gsd5vr9F/+S5L7hMuytiq+BJ
 DQNkb8UVWXpwocODaWoXYtgEzvFivza8zlK6dETLov50bL92pg1nv2d0OjIN5aR5j+fX
 LCG2COaRfiIO89abctaZV6puDCs3fkjfV0of/G84XKvYpHrRcam3pRbmU0gnJBTV4oVC
 e0AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoptHHpOJjI0rmWiWbJ/+rDsN7V5qpp5d2qGX1Hb2zVh2Dqy7scSV3RIkviypBmaeuQJOHH9pRnr/g/4BdSV3nko0DSY8=
X-Gm-Message-State: AOJu0Yy4rAz6q5BPd1WJUOmVJeN9D9F4eVbb1tCZQVwDP7x+nenP+QcR
 H3BcuYY6lFMdAMyZ2i3HWnnfEwMCMsg4rq+eOo36GeRsFgo+pt8BqjrYnh1wbZS6kAJisJAKrTe
 xpOQ=
X-Google-Smtp-Source: AGHT+IEp/dMayW4UQ93nGxgYCGP/0yh3e/c0RnkuTfvSS5LZbFcCO6nfLd53cOiNVs7nQj1t+qdwYQ==
X-Received: by 2002:a05:600c:4a98:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-426707cf1bdmr19111725e9.8.1720532706866; 
 Tue, 09 Jul 2024 06:45:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f22acsm210426605e9.24.2024.07.09.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 06:45:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: LDAPR should honour SCTLR_ELx.nAA
Date: Tue,  9 Jul 2024 14:45:04 +0100
Message-Id: <20240709134504.3500007-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709134504.3500007-1-peter.maydell@linaro.org>
References: <20240709134504.3500007-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In commit c1a1f80518d360b when we added the FEAT_LSE2 relaxations to
the alignment requirements for atomic and ordered loads and stores,
we didn't quite get it right for LDAPR/LDAPRH/LDAPRB with no
immediate offset.  These instructions were handled in the old decoder
as part of disas_ldst_atomic(), but unlike all the other insns that
function decoded (LDADD, LDCLR, etc) these insns are "ordered", not
"atomic", so they should be using check_ordered_align() rather than
check_atomic_align().  Commit c1a1f80518d360b used
check_atomic_align() regardless for everything in
disas_ldst_atomic().  We then carried that incorrect check over in
the decodetree conversion, where LDAPR/LDAPRH/LDAPRB are now handled
by trans_LDAPR().

The effect is that when FEAT_LSE2 is implemented, these instructions
don't honour the SCTLR_ELx.nAA bit and will generate alignment
faults when they should not.

(The LDAPR insns with an immediate offset were in disas_ldst_ldapr_stlr()
and then in trans_LDAPR_i() and trans_STLR_i(), and have always used
the correct check_ordered_align().)

Use check_ordered_align() in trans_LDAPR().

Cc: qemu-stable@nongnu.org
Fixes: c1a1f80518d360b ("target/arm: Relax ordered/atomic alignment checks for LSE2")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6c07aeaf3bd..5ea204d5009 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3543,7 +3543,7 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
     if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
-    mop = check_atomic_align(s, a->rn, a->sz);
+    mop = check_ordered_align(s, a->rn, 0, false, a->sz);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
                                 a->rn != 31, mop);
     /*
-- 
2.34.1


