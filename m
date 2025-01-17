Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD5DC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1t-0003z7-2w; Fri, 17 Jan 2025 13:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1o-0003uj-T3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:08 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1m-0007pr-CX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:08 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2164b662090so47456075ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138305; x=1737743105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DcTEozh86Xrwd11aGFdHOjTtoqytx9vFk9B8/PjCx4=;
 b=uds1S6Z3GxU0a78eUecYP0zVfgSLhfPuHJRCQUDcqT8sn0q9IS0TcQnh/vfPcd5Pti
 9SzHyKPjzkHPP/ApZJ8Kyd8m4x5WQGY8QOg1PoUqGC6f7UuqzTQAh77jImnc17XMTo7e
 2Il+7qU8YNQb9PUq4H9hJuVo8c/paB4FL1+oR7FH/iMSNIaQ2we/bZbUk3kXyQntSh48
 8b21Hz6FVsbg4xUKU8ujE20LlaS8OAOBsuIqGow8tlqoyfd6SSc1LxQfQsPe/lh7hMKc
 ia4Oe35G9TlmTwLr9rEtfYlKYx1JyNwJZ+JI9PIw2LBRM/HCkTPg6zJeHaSHpB/3tsvr
 VoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138305; x=1737743105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DcTEozh86Xrwd11aGFdHOjTtoqytx9vFk9B8/PjCx4=;
 b=wsuq4NiHYiL6ugZP1941QsJYbXOjXg2SoE2HfFxEaHvqqcL2rt0pAjMZ0XAGW9K/9Y
 sO4cf6J+kXtzShp5YCMUVntAIBx/aTORTRjYPPsQt2j6lqDvjbTi8zLd5rBTT1WdtqMY
 pcfu96ZxrzxoJ8j8bTkQTKrkHXMXlQQcYxx2+WTUliGN4uGxxXdBxylXixnfvCvoC1bX
 JBEqfWD1+ZhFO5bPt7cdukpsTdkAyQry2xfG8GeHYxuy19JKq1DmXlELovK9j38z2N06
 2VpaRsRJv+vl4O8G66ATxKIqwe350G8ksMZ1l3wtzPFUovaM44op/ZDY2y1HWcAXNcop
 WdYA==
X-Gm-Message-State: AOJu0YyTZgn0aK8AiNEis3eRJ63+u+cc3VUxhMuBc3pOl5Da0XTOMid7
 ZOX3+jrnUAXUICbBeEWPOLzZ1Dlq5sbmY9sq2abW4GHuGJQ07/nKRepZEza/lpWOpsgdSoONlFo
 S
X-Gm-Gg: ASbGncuqIDNrcZfL3PVKcTlil1JomVzN7FaFDDm6nZXpNYExAoxy9757xz62OrpBamk
 ZkjmSaBHrmYRXc3AvsE+cjYPB0z4fSNcZkRgjbBXhAM8Vg2B8nOHwIZBm6RhBRrwG8KnQhzpFwx
 2turaoCX8XC3Q8FFlkG2pLLTsA3pfIyiPDZNDyL0B3BWgvSOaHgzEN9F24/RmSl9NZ1cQCytusY
 ASC66SFrd4VcwSipsKuAtigdenb11JpJXug9bDECvvPk+xRHVcSQ0sVWfjS0eA5OmP4ADgQUtOZ
 jXxT+7SIJoV0WqA=
X-Google-Smtp-Source: AGHT+IFwaAwnEdWxBdnVFigXyxHeHby66+lvd5/aV3/VCmbgCnSPcACDEBx4EPoQLsvXUVTzRXoILA==
X-Received: by 2002:a17:902:e74c:b0:216:31aa:12eb with SMTP id
 d9443c01a7336-21c355932e4mr58775965ad.31.1737138304938; 
 Fri, 17 Jan 2025 10:25:04 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/68] target/tricore: Use tcg_op_supported
Date: Fri, 17 Jan 2025 10:23:58 -0800
Message-ID: <20250117182456.2077110-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Do not reference TCG_TARGET_HAS_* directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 0ef3743f3e..6819b77668 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3980,7 +3980,7 @@ static void decode_bit_andacc(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_and_tl);
         break;
     case OPC2_32_BIT_AND_NOR_T:
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_andc_tl);
         } else {
@@ -4113,7 +4113,7 @@ static void decode_bit_orand(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_or_tl);
         break;
     case OPC2_32_BIT_OR_NOR_T:
-        if (TCG_TARGET_HAS_orc_i32) {
+        if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_orc_tl);
         } else {
-- 
2.43.0


