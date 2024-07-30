Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B39C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLV-0004K5-IG; Tue, 30 Jul 2024 05:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLO-0003rG-L8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLM-0000cw-KL
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso20884055e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332431; x=1722937231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rm4cAgPkSZIkkBZ/4z1vocwRbdja/wzHAdJooiJoAB0=;
 b=Mg//dpd3EZ8cAA+pczh29wbZphM7sdJM8IoaQXqHGbQEXaLryji8D3RKOFzFUNt2mt
 6yyCGCtYhsA0DtRaTIVvK7KZT/PLlW92NEJPHF4WYtqSIxLEhKt/5x0MvK99CbB6D0D0
 /rLhEBY+ZxATtMuY8Zwjpqema43oOsKd/eR+xrIjZlA4uyl63Kw5/1Boga8BejNr30IZ
 5P2CFJ9ka3tMVfnaDewZHsbHdE5TwGv3PhQQYdrfSdeDd1Lx/6XW5Ibzqh815l5hoFUR
 vOAmgfGi35MTny1obxQ/tpjeloWbbfoF8IiTn/RN7MGOkRWVXLow71b3r12AjgAOJ5D+
 h6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332431; x=1722937231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rm4cAgPkSZIkkBZ/4z1vocwRbdja/wzHAdJooiJoAB0=;
 b=ui9WKgCOzf5oZ7gKCxuuNpVgqXgLV4WGjFUO3Y7v2VLKFM998yfW9CxV/rrR708c0G
 v5X+0MCKMlzkpZztPDay7S4d4D916adFHRhzvCQsi5Uxi8PhrggADR0kZTqAICV2jIUQ
 pjhBdU+mHufgds8Ink1xXdIjvOUoYD32BKkIy2GxqXo8zqCX8t3DZ5tqNeKJoI7BLPx+
 OJB2ej2gC2pzvzvaLsg/VA4AZzXI0LM+Z/iEO1LAleFFtjoQzZDTT+iRo/TaHdbYKYho
 GiWeJF7NcJ+DIXa5xoBx1e+Mi+tYaq/0eHZp3YMJpd5NuRP39uIVit3tiq0ue8zQNWSw
 lz0g==
X-Gm-Message-State: AOJu0Yz9UlkooTJPL2eVWpgLGAhbwuHAvxdKUMLLsSkEdFfLLCsaBS+U
 n2+aoeYnpCDgtL8siz+D7XJ28/LNXCc13MN17SCbRvSLpli1ga1jXagqlPb0qB/jIuu0fTRyp2+
 W
X-Google-Smtp-Source: AGHT+IGlO75m1Hn93j1EXTOTaS2rzk6rt/iDwBeeCAgSV3xt7YSgz8xNOhQW19fci+oKFqWg3St2IA==
X-Received: by 2002:a05:6000:4d1:b0:367:8847:5bf4 with SMTP id
 ffacd0b85a97d-36b5cee9bbbmr7710993f8f.10.1722332430904; 
 Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] target/tricore: Use unsigned types for bitops in
 helper_eq_b()
Date: Tue, 30 Jul 2024 10:40:15 +0100
Message-Id: <20240730094020.2758637-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Coverity points out that in helper_eq_b() we have an int32_t 'msk'
and we end up shifting into its sign bit. This is OK for QEMU because
we use -fwrapv to give this well defined semantics, but when you look
at what this function is doing it's doing bit operations, so we
should be using an unsigned variable anyway. This also matches the
return type of the function.

Make 'ret' and 'msk' uint32_t.

Resolves: Coverity CID 1547758
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240723151042.1396610-1-peter.maydell@linaro.org
---
 target/tricore/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index ba9c4444b39..a0d5a0da1df 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -1505,8 +1505,8 @@ uint32_t helper_sub_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
 
 uint32_t helper_eq_b(target_ulong r1, target_ulong r2)
 {
-    int32_t ret;
-    int32_t i, msk;
+    uint32_t ret, msk;
+    int32_t i;
 
     ret = 0;
     msk = 0xff;
-- 
2.34.1


