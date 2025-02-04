Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB61C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO3-00007x-8V; Tue, 04 Feb 2025 07:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINe-0008JT-S7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:19 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINc-00029P-7C
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:18 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38daf09d37fso267193f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673414; x=1739278214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG5YvjSZwhc9TBWdlzGFshXDfcxcwdL+WhbKE+SqJUk=;
 b=giGXHBhze8BKLoUpD1/nzJaRUPOJRKkjNwAv1KQf/M+UJ0F1XuL6AoZNfQpR9iXTva
 pGd80DyzQBXgDf3LMvkhr0+NsThqb4uoqcYhpmD37ImyGScTgks5ugdrtYz1Bj5yoKoA
 Z9cyHeV3Cm0sgSNpATFycj082JN5rJe9U+grZ59pJZgltta8I7ebAkZ4belYEKiPcVSR
 YQNVDDXCBR8VKcqEUoBukJauFxelCARJVD5a+JSOLhM4oWjJOLbKtyzpdfrxWu7Lh7rt
 oyTOyHNRB12ZstwoSKTYJpLZNQMPEts08m9ryWfyvJh3Xh/ONCogGK2IkWJFhDw5x+3w
 9sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673414; x=1739278214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG5YvjSZwhc9TBWdlzGFshXDfcxcwdL+WhbKE+SqJUk=;
 b=TCapBxynE3zIfs21bpyFvhtn/fG8213esJLwwAcbWZOZjkOcPWKPxm4MqKDZ6Zga1P
 ncv4RT2I0bhjqKwO6/RF4L7I/f8hogmzyNyuyNuhZSIYVmCsQYrhqjb/No5pQ9T3alfz
 tfxGjojNFGKqI81a7O14Fd7VaA83C0Ae8lgavwo13CBRRSPU03AiCiU81WICSJpWyt5k
 k5ZqNDopjMPw+XVI0w7z8wlRW/tIx5Bh+AYf9E/xQ1vdSJCS4gSIaUXoiBQjpPpBzINU
 5HcZFP1VFvQOkE07Cb39pgj6+z53/gh4aC4wdBfJjZvrx8nGso9h50G8QwfXk99Z1oiJ
 EvUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMkg/ArxUDeLibCflSc0GffmEnE73x43RNm1iWEmq5xuHQBAjxzKKSAkl0Nb/U40t4hKMGrViYhKz8@nongnu.org
X-Gm-Message-State: AOJu0YzY1goIP2dwbL4iLC5Hh3/+5iZpPusaN8qk9kl6KO65pMQPnKOt
 cw7AAIrboRdg2hfSGmC4N5c5DEEbosD0XL23hmMNVjobhnZdbna+jNfVl3LIeG4=
X-Gm-Gg: ASbGncv93SvSyljzGD4n2MZnQYt2486BYFDTC4Ey7OxnivNJp78Qmg2CP3Nt899m+Gi
 NWl3+Fs6/c1yTO4KuZvXdmm575/e2TDizcJzSfmOmqU5MOvCktlGKCCRjIiR5/DqU0//a2f9GFZ
 fJwZzQuNwLt4OQSBPGazqYycOgazLjJwxCothZlKYYkmuse26oHkoLnJ72CyKdAEJXvKrbTDzLy
 +YHHXUVZ2Wlqh/zn17IBkfA0SnOZ2Otu6jxOw9lcZyLbzpnhiseMwBuCuOj0gQgG0xrZbshD3LZ
 Ul743UwvXSFj2YsIbsEp0g==
X-Google-Smtp-Source: AGHT+IHgLh+EWaE8oaEYxTNWnzFvvFosBsOIVVYVXWKquQnZ99/Ic74vCOlOuJYBN1p3txo2Tyoxqw==
X-Received: by 2002:a05:6000:1884:b0:388:e377:8a1b with SMTP id
 ffacd0b85a97d-38c51b60c11mr20563034f8f.28.1738673414159; 
 Tue, 04 Feb 2025 04:50:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 2/9] target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
Date: Tue,  4 Feb 2025 12:50:02 +0000
Message-Id: <20250204125009.2281315-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

The CNTVOFF_EL2 offset register should only be applied for accessses
to CNTVCT_EL0 and for the EL1 virtual timer (CNTV_*).  We were
incorrectly applying it for the EL2 virtual timer (CNTHV_*).

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 049362a5500..ac8cb428925 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2604,7 +2604,6 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
-    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     case GTIMER_PHYS:
@@ -2624,7 +2623,6 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
-    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     case GTIMER_PHYS:
-- 
2.34.1


