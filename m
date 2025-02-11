Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4973C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5j-0006Wm-4r; Tue, 11 Feb 2025 11:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5b-0006UN-JH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:23 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5Z-00038z-Vq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:23 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so57591325e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291180; x=1739895980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FcnrnsckR1OD412ID9ZJRPMogiWCiovwkf1+NdWwpic=;
 b=iOWsxJn/rgvWU0o++IvzXu5jGGW/CylTKnBhvqVFlM1J4onaCPShZIeeoci/+puS2f
 8+taYKIoMsI8Ek2HAsifOoXqOKpvxavh76eV4xHLCV/t3Ic8z7WjhTJCRqo1WiQvvko2
 BWYWHQkpo5fPQ0qQQzF+Ao2IUKn5ap6tGiSOhDcvOpYA/5/h30cpzA+I4Wt20dk+tTFo
 4X1aAUniS6Gr2Ua0ZfYUoTDFphOfJfEwES4Jxkf9VMi0izd+fSAifCc3L51GLO4sEqnr
 fH52EQPbvT4bb8+bNSf9csU2yhZw066h9djSSrYhh1m9D5V2Fu3NWOxvd45CJbp/qNFh
 i79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291180; x=1739895980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcnrnsckR1OD412ID9ZJRPMogiWCiovwkf1+NdWwpic=;
 b=VEjE7OF+W9aVPNxfqbZzdNUiSu7AyEZ7bAKYPUKstqDkdGCGWYshpPvzvaViNjCorh
 J28m3jFvDbQ7FX3yhOoYyoQNesvdXcczD+dSoyOiQvAhehYuaC0RTfjBErE7pIrQbYBv
 qe01idXiySpiC9JV9yHFq+Bx07e7sUbh7477EaAlxreMhkUBKwcQ+HOt5ST2ut5neVYt
 LqZBhy8FZlM84J+EksMUzM0w7ubXJ4asMqXskDyyX1PSi5rULfwRwisGqwbZP9TBHpWb
 1k7VXyQsDHigLz++Gsaefs231OOZ75xD+skIeBRz1k4f7er5veYpjqwTRGjzc3IQKmzR
 Hhlw==
X-Gm-Message-State: AOJu0YwhmCf91/oJPdOX5vrX2BbWtygSwgeHdg4wd4RbaliU0pfLl0HG
 KpX0PLSzt5XiYO5Yba+zPC3T80ppbaO1qT5aE6AqVoeQPiNSedVbP6CbdRCeXxabq7jfSTwYv32
 5
X-Gm-Gg: ASbGncug2WJ22xaoP6ixHDaRZ2mR/TBIVIRic0v6QvkvbFnDE8zJPPNpE7QYB1p2BWb
 r+DKnJt7V7Jkl+LCi2sAhLIn8ql8AhRzOhet1BUQTWLYKKTODAtHWRTLQiTaIzuGMtxu4LFXQ6e
 uGKsBFV7ypahwWoRMfO/jS8sjG3hIdelEwO6Ta2apNplZLAVl88bAWFP6bF3/2ezFwMBsRrcJnF
 D6aWxM/bab0BYDgLSpPN/UmLmAnnPEkHSacms9KCRz/xrBpPjLkCHAxXPIB+yQj8Jm+RWg8JDBW
 U3Y7r8pfhthUk3+6/mGs
X-Google-Smtp-Source: AGHT+IHjX+LRUKrWxmcO7L00dYBT81fLav5FYBBUhgsg4MFLMx9s3UWJziSb7QfQak+wbuN6lSpsnQ==
X-Received: by 2002:a05:600c:1910:b0:439:4d10:16ce with SMTP id
 5b1f17b1804b1-4394d10174cmr39584315e9.14.1739291180234; 
 Tue, 11 Feb 2025 08:26:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/68] target/arm: Handle FPCR.NEP for NEP for FMUL,
 FMULX scalar by element
Date: Tue, 11 Feb 2025 16:25:08 +0000
Message-Id: <20250211162554.4135349-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

do_fp3_scalar_idx() is used only for the FMUL and FMULX scalar by
element instructions; these both need to merge the result with the Rn
register when FPCR.NEP is set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac8196136c4..f31acee30aa 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6296,7 +6296,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element(s, t1, a->rm, a->idx, MO_64);
             f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     case MO_32:
@@ -6306,7 +6306,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_32);
             f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     case MO_16:
@@ -6319,7 +6319,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
             f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     default:
-- 
2.34.1


