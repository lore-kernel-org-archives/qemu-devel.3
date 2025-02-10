Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B6C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3A-0007M7-MT; Mon, 10 Feb 2025 10:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2g-0007DB-FV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:50 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2e-0004gs-T3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:50 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dc0cd94a6so2075578f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202587; x=1739807387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FO85tXvs/pUPFn5N5WJ2viYG9RIRLbfEX4UNIOcXTy8=;
 b=Hbsu1lHUbE/BlZOjrX0COUFaoRMXxe0pvViHt9fF6Tq7Pz5uS8zYAYMTzoiREFmlvJ
 dU3c6wKuIZDZVdeyskIJFs4LHgf2dPK7hGkMkUsLqFe2DhbhBuhFL2TBGlNBE7TsnE4U
 xCii21wgjE6tWPpdqQuVFeGTcnPiMRirh3wHzUdMXyooDN3kYFQj8xQNL0FnmKAMOCXI
 xs3/vfLmg4j9cMC1o/j1QQhPUWLnHdYaaCMv81X6vFCig63Zo7SdHALT1QVtppLRCDAc
 myLiHogDX+ZYPw2YpuP3Tx3TBYtJlDHiozm6zODi2pG8tTro8XeddhUK6XgmSTJ2hul3
 HToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202587; x=1739807387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FO85tXvs/pUPFn5N5WJ2viYG9RIRLbfEX4UNIOcXTy8=;
 b=qNpXLDeeXd8kqnCcpg2AaryXvtQeohVl0zw7yqf79bziB8RMUyAvYy92F3Dw4whvM+
 dvBbktZH1q6KofbpD5ry+5BEd4EGu5/TtAM3swUEHjLfwsMs0GZojo3Ui6Ce50UOvj0U
 g6nx9Ze7D0WVHSaUnpUWaS+Yu83spYg0b7+GBeysMdmxQLFNgbKobPlYlh617vbbwJxG
 x6+Qdi/sJk4H7ZtGX8XkERPbsh7a+iOwggPtqf8lb8JQvmARBSLKUu+PZrl5/gQA10kS
 cMVszWXOyYqPrRRVgSr6ZQShR6Yg3sE7JPI7RQXKQOnZMU4zM0a2FAZJu0Z5v8pnQL/t
 gGTQ==
X-Gm-Message-State: AOJu0Ywhl2aAc+fAe9aut+jX8gvGuZxxZ1bFvd4xunXCTyPnmpxKOFVm
 ZIjERtZ5aZgpXeUfIjMPwDAk2NhqGigiJ3TmWHbeahTr5zAKqxJA3FjaIC4ZD8T/uFxlJxJWmxG
 0
X-Gm-Gg: ASbGncs3qM4FW5+OWGo3yptxm6pRhEx/uiDB4CwAdZwuxwJkob2iwUedpjy4NxBMlg0
 rHzHtlqNSPCIHpkkFGsHu3Hw9ZjUHACNU/7EbfDdwy1y1V79NPzOp9M880ZYy1o3cYdnB28qhCX
 NyXu3lVf2w8pRqT4xShkOYNt1c6281GVl7ka8g0Y9dK31xYy37lK6fQRxWDFaTiNgd/fvp1P4Oh
 JtE/AsZ6x0pL3xHIjG4xVsdN0sikFJej++KuvhSaIG5vd+O41kIVOI66FV23WweGN4BYl56VXyI
 2UKQGlKL8C+m2+XQAMVk
X-Google-Smtp-Source: AGHT+IFd+xct7LjbrAtvigeJj1xVNHhhUI44C7OHh+nyXvlBJC7WFGCzBMWQXjXyoWBWhrWBiqj4hw==
X-Received: by 2002:a05:6000:2ad:b0:38d:e02d:5f43 with SMTP id
 ffacd0b85a97d-38de02d60a6mr2624344f8f.2.1739202587419; 
 Mon, 10 Feb 2025 07:49:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] target/arm: Drop unused AArch64DecodeTable typedefs
Date: Mon, 10 Feb 2025 15:49:33 +0000
Message-Id: <20250210154942.3634878-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

We removed the old table-based decoder in favour of decodetree, but
we left a couple of typedefs that are now unused; delete them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250128135046.4108775-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b76a2cdb78..d6ac2ed418a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -75,17 +75,6 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
 #include "decode-sme-fa64.c.inc"
 #include "decode-a64.c.inc"
 
-/* Table based decoder typedefs - used when the relevant bits for decode
- * are too awkwardly scattered across the instruction (eg SIMD).
- */
-typedef void AArch64DecodeFn(DisasContext *s, uint32_t insn);
-
-typedef struct AArch64DecodeTable {
-    uint32_t pattern;
-    uint32_t mask;
-    AArch64DecodeFn *disas_fn;
-} AArch64DecodeTable;
-
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
-- 
2.34.1


