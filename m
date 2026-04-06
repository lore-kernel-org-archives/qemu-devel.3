Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD467F46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oek-0007SQ-Pg; Mon, 06 Apr 2026 14:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeg-0007PH-FW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:36 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oee-0002P8-Dx
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:33 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d9827661bso2081604a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499991; x=1776104791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=SlW3uNlLwrd6c21OAXl+ZhX9F+wpl9TSFE3wPb2wKYResFSuqL7MLPhWQRbA476XfO
 ILsCVIh5wDXK2aK2AkYGmCb8qwcpzMqpSmAqZjomLG7F2GzExtFOq9zhbnuxE/QGsmXL
 b2kK/cnfgyocO4WWPBP6uoOtJXzzEx0pV+tYNUuAI2o8cyl+aSxA2msVm5Ee6o5zNouV
 MBL8OGs3t5KfKQDBHn6V9GnFQDRJNvlGMR1ZUlRhEdFuakULGUT03bGwROjWyOF+Kibu
 3aEGOA6FT4lCAfb1CaDkNRla+Fg2+X1m0aU9TADJ5RVYoqrdQxjfI6F+F04eXKLz9kyA
 dqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499991; x=1776104791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=h9ePGb8+uSyDUSSoTmEyWTJ25NRHkiYlf/OscU6L7YruCegVwImZ2aEjgeqFZ7u293
 TM8aSTrjEi12UBj7Nf9mAjbffkY2IZNR360jjY29vF3NMDvhCl3lAFhUhmmfSQzYLqXo
 E5VAaKSTkfaGHhcaK75inN2M2aOJETtS3ydbEHQUPJxCSn7Z25aPRRu6/9I4jwoU4MbP
 b4SpXnG0R505qoDbKhJk0uciXd275lxO5QO3m7FjGLV5asPpv1wGdthqvjWdvzEI0TwR
 sdZ5v7EGDhyrWiMbJ/BsShR4SycArCCiA/P2nCftoeW/Yb8OhQtlTYL5qfMYvgfg9XnH
 BrNw==
X-Gm-Message-State: AOJu0YyroW6/JFEhX1EEOb3NnBk2rSm4Spg3A04WyY5z/iLX2YvGSRkL
 NJ1/6pLLyeho/Kx3sh7M2AShJdkUkPRjX6lsESVofm7fsMU2GDYmiYkRio+r3TrXNZF9/d/1swe
 S0XOF8iFS2w==
X-Gm-Gg: AeBDieu/obgz7uvp9TdlM6TzrR9i+TTfrCFHkd9AvQffNtvNOt5Poq0B9tZoUNRUtMw
 Xy2RxP+vGShhjMvH0NOO9C05AUIGETZEPhWkXMTiXQeyfj6RvVZ9Ic+r6oSfIJnNW3LLug72b36
 6DP909ZkPIbIVWlOCP0QVkZ37jHGarMp0UIqTybp/nQDAIHZNFpPu6kVu896P4twriqC3IFy27r
 m0+NFq6YlukcghbfxXu/smdKpPmGMwcIdpcE0fG2t1WapqNs+jfj5NkU/ZoAcRWoDL8MjHvt1KZ
 4rxkOb22lYhLH3NvFQ5+nBJgvdvVJ4j02uQyQ3Jjm6X+9Gn90sYMcVQIyW0MC3Dah310LfdjP5w
 hYfypttHWBVoOZOm5/5TwgcXnBm300AZS/tWMuLM2CvebIpgufG46F7HUX8L5A3oKdQz3bYMKTb
 2gJqvWfOWrHjshIfwMmV7FpbOa+Tq7pM4C4cQ4kIPSoyvJaVI6OMUj04gxdnbFxCJxRuNZ33CNn
 FA8
X-Received: by 2002:a17:90b:3e43:b0:35d:a4c0:a0ac with SMTP id
 98e67ed59e1d1-35de6813794mr13641773a91.3.1775499990957; 
 Mon, 06 Apr 2026 11:26:30 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 12/20] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Mon,  6 Apr 2026 11:26:01 -0700
Message-ID: <20260406182609.193886-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


