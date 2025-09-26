Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B2CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AC-0000xE-6q; Fri, 26 Sep 2025 10:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299O-0000Bn-Jh
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298d-0005mr-1Y
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:16 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso1839734f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895766; x=1759500566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6CNBDVRbhEagCdpp+s+XfPoXED4J+gbWqZ29Lsly9k=;
 b=sqIeUCpzbCTGsvKCc6RtUyUdbVQ8L4M2yjrRUZWS8cgynHfFrpT5rjHShathmMAjpH
 oRLVpYv8XMmHUqxI5/+tKUNijpPlPfZfnZ7NYHyhoT6ch3Y22iyPYhCSe9JOAdFtiN4U
 djG2XOhkBWpdXSftMMbyeU2s/XbVZuJlSk70cEs3sRqE1pg2keBN+lZIgoIYjE4KYWpJ
 ocSFrnWDgdShsMq3swTcUqonuQNmSOGfUIOH5oyOsl8tdKOt+OMdEVfYAbaDcV/h0sAW
 ihBTEpqGhufK8B/iNu+fq3eMEcF9uDQNaZrJi3aUI18v7T1In8gdi1/7kcXZBwsM/ZCZ
 Xq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895766; x=1759500566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6CNBDVRbhEagCdpp+s+XfPoXED4J+gbWqZ29Lsly9k=;
 b=g70grYJ59Wrc9sgW79YWVUVIM4kKL1FC8p8gxtePHc9PlJ/UMGE/lIJlL0dPjJxqa7
 OMAE91hSS7VolRBZ7hqJuCvfzMZVV6WCZfiag2h18/zKJXyl4TsO9VVhyFaoG4XZ7Bjw
 d+sNlaJrF/vMrGZc0hUUtkUfZiFMm450eCqeVKKbDZr0h19+UBNlyEIV/4S+caBi8OQd
 T3l9kWHYWc2GhOibsdI+Wv/PsNiUg6UgNZAa0Ti4cYvSjop3eydkidNJpBA7dkCMWNcv
 4U1eHiwh6vXmR+WNtkKh9TEPoxYllkk9jFxDZyOF9JRVLRnsb/Wkfwwq4wdQ3FDCacqh
 c+fQ==
X-Gm-Message-State: AOJu0YzJ6dTAPvN++5xPRlvzUDCLUaGipWLsZtOI5dhr1OQavgpCQWe6
 iwGA5cDzMKe4JmdX1CGP6H6Qbh89acrYxLRf1V3A2/RvnVNx2jmAlDlIzYl5S3ZpG/NNjwf8bx7
 6W4B1
X-Gm-Gg: ASbGnctmCsS2kkYk3epLfY3OEVIZTIApzhcW5Q+8pPP8A+vtZ4A27oKLTN57sAByy1c
 JHiciGnsP/QBe47X4rIvPULStD0aGhNmf20o7aCdkbfh1VT/Q/PP9cMcVEfcBoifBALGuNmhv3t
 I68XNIJ+PUQt2W3IPflCl0tuVyD6JEyfolU5p5oiOYi5SJ7tovZUffMFCvmARxDk65V+HlxPs3m
 2mynVs/ahqds5OScWt49N3jo/k64kyI+xHmBG06/ZK8xkUYFG7vO4M6hOKnZGbDcV+xMDg4Tj4x
 X2u+1UXRAwAiv3/HbKgmfdvPesQKY+1qdxwUxPdlNt7UMQhboMkWJfCac6ZIioQjMsWsvPi/XaD
 FfweF374VFabwtzEx8wK6nkar2cV4
X-Google-Smtp-Source: AGHT+IFxZL5yP8oEeQlzXtaf+LzMg4BR2ZQIg0We5fDFt9ihOhoXfYDN9RZvxLiE7+aKnJz58q0sRQ==
X-Received: by 2002:a05:6000:2002:b0:3ea:f4a1:f063 with SMTP id
 ffacd0b85a97d-40e4dabef59mr7224131f8f.55.1758895766097; 
 Fri, 26 Sep 2025 07:09:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/44] target/arm: Replace magic GIC values by proper
 definitions
Date: Fri, 26 Sep 2025 15:08:39 +0100
Message-ID: <20250926140844.1493020-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prefer the FIELD_DP64() macro and self-describing GIC
definitions over magic values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c5a8ef50493..a18d920ac18 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5007,7 +5007,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t pfr1 = GET_IDREG(&cpu->isar, ID_PFR1);
 
     if (env->gicv3state) {
-        pfr1 |= 1 << 28;
+        pfr1 = FIELD_DP64(pfr1, ID_PFR1, GIC, 1);
     }
     return pfr1;
 }
@@ -5018,7 +5018,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t pfr0 = GET_IDREG(&cpu->isar, ID_AA64PFR0);
 
     if (env->gicv3state) {
-        pfr0 |= 1 << 24;
+        pfr0 = FIELD_DP64(pfr0, ID_AA64PFR0, GIC, 1);
     }
     return pfr0;
 }
-- 
2.43.0


