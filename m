Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF36C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74K-0000Vb-Gi; Tue, 12 Mar 2024 14:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk749-0000Oj-E7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk747-0001NK-9z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc09556599so48619115ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268887; x=1710873687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3znfmNL10eLlxG5NYqWnRcVawBnQ4i751296Itk41Q=;
 b=Z8OJwFWsDF/tj9sOZgxNZ9rh6WJMum95sYh9c/i7bxmptTDfemZXA1oBvlyTzEHbIi
 RALrOCi1LlO3K7Zotpwl0Pvd1eHeTXg3tiJTe7rEItKkGrG0Ooh3Cyi7eiOhJOHA0sSx
 KMR7voa4SeymqrodYUH1dDisfTpT/up0ET67yNki1CrTxwT6sSEROzjU9oW2CTyP8Bvq
 09BvLjZvdpE56iZKNd26NcSB2t2mNkL19ZLtGmm6AO6lgYQdMERkoa4VCJIRmgvqWpwJ
 PotsB5sCO74a+SKhQ656xFO9VkGSqU+jfR6w8RrEokk5o7sce2xE4v46OieDf70pbPWO
 URlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268887; x=1710873687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3znfmNL10eLlxG5NYqWnRcVawBnQ4i751296Itk41Q=;
 b=FcmAJrXpL6IxdTe0X7L/EtNGUdJdX4a4Q9Qgb0+4h7Ak9fXT3CwLn1vdTIw7SJFMBa
 sgyvwiZ3vdX3JDRLYogXJFnqL1RH+hXnNB6XfqCC/f51ww6omnROkBmeHU2uQiWVOCPx
 szuqt0x9jgFdRM5Y696Sdcb48JJ18m8RQMbqlDrfZUqaqBTI7CD9XXw88yPADIqkf9LP
 DF25+0Q42rhuk3u8DLjh/3EOrCqX2psJvF2/bFPPmHZ3gcG1FVVDq/frXCxsZBZzN3U9
 9Dfx5pBpdTlZGA87BMc7d2727C1kzqkaGYqJYmC7f0ti8tp7TBpjPVR0U+aua+d3+3dy
 jIFQ==
X-Gm-Message-State: AOJu0YwN139S0+PbYH0k8jbv1Rxjleq/3bhxSMlbfYedI3IHS8t0V1Mb
 zJtiVXcHHGV5MaUv3DrpfBuv9VjM+HLCreoDCC2a/FLy7YnQ1fEImVZy3D2xsosr1UPrv6IBHnu
 8
X-Google-Smtp-Source: AGHT+IEymnULxbjX7RwzVW6Eo6baKvDY/VhBDehRQoZDgFBh9RHSKQLexjAGmxw0tUQEUIWoEuGY0A==
X-Received: by 2002:a17:902:cf02:b0:1dd:a529:f355 with SMTP id
 i2-20020a170902cf0200b001dda529f355mr4948777plg.10.1710268887303; 
 Tue, 12 Mar 2024 11:41:27 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 7/8] tcg/aarch64: Fix tcg_out_cmp for test comparisons
Date: Tue, 12 Mar 2024 08:41:14 -1000
Message-Id: <20240312184115.365415-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Pass the type to tcg_out_logicali; remove the assert, duplicated
at the start of tcg_out_logicali.

Fixes: 339adf2f38e ("tcg/aarch64: Support TCG_COND_TST{EQ,NE}")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dec8ecc1b6..38446c167e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1388,8 +1388,7 @@ static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGCond cond, TCGReg a,
         if (!const_b) {
             tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
         } else {
-            tcg_debug_assert(is_limm(b));
-            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, a, b);
+            tcg_out_logicali(s, I3404_ANDSI, ext, TCG_REG_XZR, a, b);
         }
     } else {
         if (!const_b) {
-- 
2.34.1


