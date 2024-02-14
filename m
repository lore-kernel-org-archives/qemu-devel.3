Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F2C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 01:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra41w-00077u-Dn; Tue, 13 Feb 2024 20:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra41u-00076l-SW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 20:25:42 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra41t-00014x-0Q
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 20:25:42 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e0aa4bb62fso1247459b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 17:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707873939; x=1708478739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ+rg6GvMFeyTnvfLciFKKr2/Cz68cvZzuQCWDme714=;
 b=MuI4Y1Flr3XP18ujMB10NhoMYMJLpEamntKmFw+kiyrxDmRQrwf7viH2qoE+5pLISs
 QS5Bx6efplQ7BV5USN9n1n3OTWlbyGNDzh42ElXXPr+T3R9KFPVUTyjhELTBKRdxJ9eG
 oTThN9oylYPwpL2/KSPQo1TlWspMCe+LA9A/0wyVi4raBLqem05mcO4PR/8VGht7yzq0
 bTYUnBiZFswzU8N67109rAlYrvgSJnCOH0oYVona6eMpglLa3pnRahQjvGtgEvzJGue7
 iQ8UXfVAcbh2kYG1j1DLIM1KXJIAqykbJ1+xRsAuP92Nk3UihrKpFEbSR+qRBIWw7vOI
 WDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707873939; x=1708478739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ+rg6GvMFeyTnvfLciFKKr2/Cz68cvZzuQCWDme714=;
 b=JGXMBSCqi4Q6UZ9siXtHriT1fznKyOUYQeFKZmsnLAFv89BViwISgX4BR48UAzuQhF
 3DZsHWWGSoSvBxzCz69r+n2CaQlG2FBq8EPHwTQLnGQYRnSwZvTIvMEF4ImpOMuMOe2T
 2KtRZOao/SG50Z1KpPEDxmvchcKD/ZSZq8Lf20dDyG1eIOBCfP+zl646QUcm/vGR50dm
 P2yIiE9ZrwN9SRH4ieFpm0TJwmWfMAHRY8xnwUc8XEllGVmanpOKjPB9FWPAdlwcmqS6
 4WQfnD23MIOF0iuhS3FchV4h0HhJgG100GQZgfAJUz+j4/5qS0v86bY4PZpEn+Bjz05j
 v/pQ==
X-Gm-Message-State: AOJu0Yzjnbt1b1TwqVcW0ETCVYoGeblZmD28n4UtSsPkLKwMqrsGZ2gh
 m6MdRjup6Zv8ITJM7b34kdRggDx9GBNU3+5PeQRsURVAo/CNFtFgUYHP6Motc/GKzPVxwIuyqpB
 u
X-Google-Smtp-Source: AGHT+IHagfRqxj7S3pshb/c5xJNCuPY0rL8Hw30tG+C0TVa+5a4feQko+578f6y8KrNeCzuqWVItwg==
X-Received: by 2002:a17:902:c105:b0:1d8:deb5:3390 with SMTP id
 5-20020a170902c10500b001d8deb53390mr1243933pli.42.1707873939673; 
 Tue, 13 Feb 2024 17:25:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVfepIAtWCfJtOjlUW1qXabBi09UqaZtjz2DhIDQdWiaZJ2jZMkgEjmvNvY4LHs1tf41SrFLb7T7/kBza4npA==
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170902cecb00b001d961f28b0asm2660333plg.270.2024.02.13.17.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 17:25:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/2] tcg/arm: Fix goto_tb for large translation blocks
Date: Tue, 13 Feb 2024 15:25:33 -1000
Message-Id: <20240214012533.453511-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214012533.453511-1-richard.henderson@linaro.org>
References: <20240214012533.453511-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Fixes: 79ffece4447 ("tcg/arm: Implement direct branch for goto_tb")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1714
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
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


