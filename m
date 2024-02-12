Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D85C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 21:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZeHd-00068u-E7; Mon, 12 Feb 2024 16:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZeHb-00068R-JN
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 16:56:11 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZeHZ-0005z3-Ul
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 16:56:11 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso2463814a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 13:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707774968; x=1708379768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GMgxTbShd6YoiVAVVKaYI4ENWNLYFhquA/29o6heTkY=;
 b=DPONxKSG5T27OULSxsbAtH431T2h/yyQhW1wj/6vU5kWUn6KmY429Y7Q20FsQuDmAf
 zZ8ONrszAjI8CRqwVjaidTvrzWMaHG5xj89G3sd4xb/myncgfPTiwV75Eb2pD1tA+6ro
 6vHfT6dXFRtjmURHoxydHhLwXZ5dZ9xak3Ytc2eksM0G73y8d2BGMPhCVWEn6e/dA5KM
 YShV9WU3OA5UnOWDc1Y9cuxz0NozR1Lc3dCsQnlKyXf/xTDcEbzuB+Tn5mWrv4Ng4G69
 3yQ3BWtCmgMYqc/4Rt/ioxNYSVaEkr0XPCliE3NzUejuC9k4Ljf9aJ8mgk3egMfKkrOO
 R79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707774968; x=1708379768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GMgxTbShd6YoiVAVVKaYI4ENWNLYFhquA/29o6heTkY=;
 b=XOtezWSelb73DvkiKScDmH7Wve+5/hswAs+R1Pn1WPQZOeLyGad+3WW3wvJgi199mY
 4BKGXeRmuf05CYFtfafFXlqqQUnQfA7s0xsL3BHZXAz+7YsnmYXE/P30gtqM/d8FZ3CG
 2YbulMGPbiybACVQs+DYXWM9rMcPqV8EJR4t1dwPNy5T+gYGjZf8OYkmewzleDquSdKZ
 BVHtxj9MR3pZZSWMhFDkebmFpZdJ6to1BISOBk0vLZYwkpuv+ULjgJh3nBlaItBHNV+E
 4xUTHyTovd0IYLo7Vcuj7iaGItLGQZLO3qvVIGXI9EJjleOXEYywaDDOj/BThPivKJCd
 yR7Q==
X-Gm-Message-State: AOJu0YzE3rv/wL3Kr9ERfPQisCzZOrywD2qsJ/StVuVQXJeZaQ0tVUXj
 eBOPhlQB/RWUd2ZFqWPGzaB85DmyRiC8zOWDXy27gdSn+j9r0yAT+I8Q8vtkceuOi0TtUCdwEht
 y
X-Google-Smtp-Source: AGHT+IH/kXowxi9VwRlfstjEvBe/rQjQcmbV4Z+ptB4AAs/pmtAoX5YYvOcDQf5CVVwtGDPYpbkc2w==
X-Received: by 2002:a05:6a20:d708:b0:19e:aa03:19b0 with SMTP id
 iz8-20020a056a20d70800b0019eaa0319b0mr7450550pzb.0.1707774967760; 
 Mon, 12 Feb 2024 13:56:07 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 fb15-20020a056a002d8f00b006e035133b72sm6031559pfb.134.2024.02.12.13.56.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 13:56:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/arm: Fix goto_tb for large translation blocks
Date: Mon, 12 Feb 2024 11:56:04 -1000
Message-Id: <20240212215604.27999-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Correct arithmetic for separating high and low
on a large negative number.

Fixes: 79ffece4447 ("tcg/arm: Implement direct branch for goto_tb")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1714
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index ffd23ef789..6a04c73c76 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1771,9 +1771,9 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
          * shifted immediate from pc.
          */
         int h = -i_disp;
-        int l = h & 0xfff;
+        int l = -(h & 0xfff);
 
-        h = encode_imm_nofail(h - l);
+        h = encode_imm_nofail(h + l);
         tcg_out_dat_imm(s, COND_AL, ARITH_SUB, TCG_REG_R0, TCG_REG_PC, h);
         tcg_out_ld32_12(s, COND_AL, TCG_REG_PC, TCG_REG_R0, l);
     }
-- 
2.34.1


