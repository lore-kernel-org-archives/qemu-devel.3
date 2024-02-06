Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248C6C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWC-0000cy-5k; Tue, 06 Feb 2024 08:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW6-0000OC-6V
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:38 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW3-0008Cw-6e
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:37 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-339289fead2so641597f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226173; x=1707830973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oZgFljSXzG1VImEUFoQLz/HGzGAKeDy/fNBogZHhH70=;
 b=cHxc/Z5CNx1DXq/tkCS5TxQEmms/y+jU2GhwqQasfEo7ee2KRjGsEK1NRro8E4T5Bb
 5R65QjzqwjQdHbHL314TVQzYY8SYOHmW4a1AAUyLRgzYbDLMlojx+y7PZR45LqaRVlNR
 j5EMDBY9hewtoCF5CvXwW29LeUDCeBkjLy7RaHVuoL2OEt8LkcMAxnOf7oZ+Jf9hVE9u
 xxpWgFJh96Y2XcNhisce2xunLoqQrfHRqwShIRNVTz5hJa3DPVO1BKahPDbUT4KRt2ZD
 5Qq6SY3Q2Pn/hDAlLrqVX84AqbWr6F6TaZkYIvMWj2b+GjH0N5oVN694KS/euT3ZuWA0
 pPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226173; x=1707830973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZgFljSXzG1VImEUFoQLz/HGzGAKeDy/fNBogZHhH70=;
 b=NLv6otSkgnl1/Idc8RhJneI79V7u5LZ9+5ypR05YZiGI8CblhAu9Xv4dAGA/8YKO7/
 Y8mlJaqDTXap00qqP2w9F7/mlzOzqYD45JVdUGm3sNm9RLvIMOmnDH1hFVZDeTzEof0G
 lyzK3xnehFFre1zBjMFR9z2LsoHOonoKH3hXFepgTP/DjiWH5G17NmtSU4UeJKiiSaSZ
 UClwS9XQIOTxQPPN/sZkg1C3++dKBGl5KgfDet6/YAkTsralHEJbxeY3LOIFkI6qwXdh
 37M8fyLYepSvD2aDfaEK2ONBekwFBO/NUzMFFw1w+AEHUcCyFBhNq9DCSfNDmMLV/v+4
 xdqQ==
X-Gm-Message-State: AOJu0YyDh1cyBFYhzsaeCzZiPiZG/UcpVjOkQtZK3UQI9gvsgQS0gOOm
 bilRgh0FcCu9RqFml/i1pW2rlaMJztPjADU6OXrWw+CLgwzd1mOXkVXj9ke6U+0=
X-Google-Smtp-Source: AGHT+IG8kT0OopRP0FnBlh/k9L5AhZYrWcb4hSHKS05yr9FPmB/ZOLOEC8aegLBqSQ0N9SxEmL+ddA==
X-Received: by 2002:a5d:6da2:0:b0:33b:48ee:8a35 with SMTP id
 u2-20020a5d6da2000000b0033b48ee8a35mr1339202wrs.3.1707226173085; 
 Tue, 06 Feb 2024 05:29:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVt6wfrgPuWJrtV4jgVhPouQACGhuayC/NBZIDHzOCnrNGvpeCBLXr1DqETfCpbUXX36HzIZGxN2DqubvEZQ5Dg8SPD+bQ=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/13] target/arm: Use new CBAR encoding for all v8 CPUs,
 not all aarch64 CPUs
Date: Tue,  6 Feb 2024 13:29:19 +0000
Message-Id: <20240206132931.38376-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

We support two different encodings for the AArch32 IMPDEF
CBAR register -- older cores like the Cortex A9, A7, A15
have this at 4, c15, c0, 0; newer cores like the
Cortex A35, A53, A57 and A72 have it at 1 c15 c0 0.

When we implemented this we picked which encoding to
use based on whether the CPU set ARM_FEATURE_AARCH64.
However this isn't right for three cases:
 * the qemu-system-arm 'max' CPU, which is supposed to be
   a variant on a Cortex-A57; it ought to use the same
   encoding the A57 does and which the AArch64 'max'
   exposes to AArch32 guest code
 * the Cortex-R52, which is AArch32-only but has the CBAR
   at the newer encoding (and where we incorrectly are
   not yet setting ARM_FEATURE_CBAR_RO anyway)
 * any possible future support for other v8 AArch32
   only CPUs, or for supporting "boot the CPU into
   AArch32 mode" on our existing cores like the A57 etc

Make the decision of the encoding be based on whether
the CPU implements the ARM_FEATURE_V8 flag instead.

This changes the behaviour only for the qemu-system-arm
'-cpu max'. We don't expect anybody to be relying on the
old behaviour because:
 * it's not what the real hardware Cortex-A57 does
   (and that's what our ID register claims we are)
 * we don't implement the memory-mapped GICv3 support
   which is the only thing that exists at the peripheral
   base address pointed to by the register

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 945d8571a61..2a2659aade2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9519,7 +9519,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * AArch64 cores we might need to add a specific feature flag
          * to indicate cores with "flavour 2" CBAR.
          */
-        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        if (arm_feature(env, ARM_FEATURE_V8)) {
             /* 32 bit view is [31:18] 0...0 [43:32]. */
             uint32_t cbar32 = (extract64(cpu->reset_cbar, 18, 14) << 18)
                 | extract64(cpu->reset_cbar, 32, 12);
-- 
2.34.1


