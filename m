Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F02E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyb-00023M-Ql; Tue, 03 Feb 2026 10:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyA-00013v-7t
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHy4-0001il-LC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:31 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so61116835e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131126; x=1770735926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+uQCwvBnaPsyq5wIkzAZIdRNBbumuPIrG5riVXAybmE=;
 b=lWSJdsERidgfguFV6sOoIejUsMZnsEU6NgOQ5BQeebLlgLbDVTBrWvxZ9oeo1LbpQ9
 a1Rsh+gQe2lgHdMcv9PYsKpkJiAbQ2dJZWUPPKqcFbaXl6GqrvXiUGdbCcsM8Q56z6Ak
 LpEHPHc5ZB2jdG9l64Mrr76GU2S6DRrij80AwgyzaOpXfybcpsx04o/yILzOSMG/6+Lm
 p3dMZZDWGkDLAOsBx+MjJS20YL7GP82YDiLhsMLfZammcRtbJRxZqIsSXdVAbh/f+OvV
 fmQMHHoEuy/53MdZ3HUY58EXpy+GJD8LSR6xsElHI6MYq8o2+pXFQweMxmEtvpneHc46
 dU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131126; x=1770735926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+uQCwvBnaPsyq5wIkzAZIdRNBbumuPIrG5riVXAybmE=;
 b=BTyCQuK790ZaZmg1dWKPuaalJfUGoA+L5FATCGakQCXqhy5vnx/djDenIdE8KbqxPr
 ivdQvd2WKh4CV+9lVb6SUT8WnxIw72Ut7pdWJc5yz0jFqv6aWBZOe6AOgxAGjHUQ5GEV
 AzElaTtiUgFNhA1dMvKKNl8qYdCsonOwUJGSWeJ34wmnaHUJpTPNln2g3rGVZW4Jjcc/
 45CFylu2zgg+n2pzOJnKCdHPWJsjpe3Z6gIoaBZ3tF6hEnzNNV4rwaHMEMaScrrU3B8Q
 xh9NBMV/YRT2zDCxpJSVQJXPaESVOlPKbTqYeDG9fkxntGPnmMqSxSHRErXTO5GmaFnp
 Cydw==
X-Gm-Message-State: AOJu0YzbuL9m22s2DvIlO958Ol0ReLV1yWXIUiOvbS6CZT6JZJtpUy56
 pRVxrxisWtLb57PHd8GU5ZbBRZy03fTea8kBEWgCjfTBl8DR4VYCI7W+SxwJQxH8Iz7lAIZ+ruY
 htSLlszo=
X-Gm-Gg: AZuq6aI3H0AHMn0mqohvkTnqnApPVREe2SxpCrzGR7OmHj5+d7ncXE+IkmNQLo70y90
 Ea5tG5cDI6bQlEV3bxkMn+pmQF2ndvtMFKILKvw8JVu6ZViqqUcsLclTuNkzdwvPf9QodZ7XYBv
 FEpIIwUabXYhVnhPlDJevL/UupKxAg8kadbNACpiLWYj0rlYlsqOk2bk+i3lLDFYZGlf4Gr4tyz
 jRKZZxzxJ62xA+xRrnPhKr2inzN38NGjJf4+40PraQJ0jwqycgHyVx7i677aJPtXsdO9CP6Dyq1
 HkJo/P9BAru5IiuQXbRzzex+IN5svGHV0O0NxZuZ/zyvGbeourP6F/Gq/kHWKSnq3Kyf2lhns5E
 8lgVo1YawFX8309cxyR2YJsjD7WnmFZWb+6Ej+scOi9Q9y6k6XABmw+o16xz24MYo6wxFbZsgIw
 ktln0X25ijamHt9qu94Quz7CkSeh35ScH0v3d9gWMrYKngtaz0QYm8GcItiQzK
X-Received: by 2002:a5d:64e9:0:b0:435:afa5:c27 with SMTP id
 ffacd0b85a97d-435f3aafcbfmr24769051f8f.52.1770131126152; 
 Tue, 03 Feb 2026 07:05:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm51540887f8f.14.2026.02.03.07.05.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/30] target/ppc: Introduce ppc_code_endian_dc() helper
Date: Tue,  3 Feb 2026 16:04:12 +0100
Message-ID: <20260203150436.71907-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Introduce the ppc_code_endian_dc() helper which returns the
MemOp endianness for the CODE path.

Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.

Note, the target MemOp endianness can be evaluated as (see
commit 5c43a750b67 "accel/tcg: Implement translator_ld*_end"):

    MO_TE ^ (do_swap * MO_BSWAP)

For PPC we use the DisasContext::le_mode field to swap the
default (big-endian) order, so to get the PPC MemOp endianness
we can directly use:

    MO_BE ^ (ctx->le_mode * MO_BSWAP)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260202210106.93257-7-philmd@linaro.org>
---
 target/ppc/translate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 17e6d07c8c2..e1753ce19ce 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -214,14 +214,21 @@ static inline bool is_ppe(const DisasContext *ctx)
     return !!(ctx->flags & POWERPC_FLAG_PPE42);
 }
 
+/**
+ * ppc_code_endian_dc:
+ * @dc: the disassembly context
+ *
+ * Return the MemOp endianness of the CODE path.
+ */
+static inline MemOp ppc_code_endian_dc(const DisasContext *ctx)
+{
+    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
+}
+
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
-#if TARGET_BIG_ENDIAN
-     return ctx->le_mode;
-#else
-     return !ctx->le_mode;
-#endif
+    return ppc_code_endian_dc(ctx) != MO_TE;
 }
 
 /* True when active word size < size of target_long.  */
-- 
2.52.0


