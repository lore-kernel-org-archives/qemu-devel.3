Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D57C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMdb-0007gY-Ua; Fri, 25 Jul 2025 13:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMdY-0007aQ-Lb
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:55:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMdW-0001kf-OB
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:55:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so2188493f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753466113; x=1754070913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fpWsVIpbRIPv6w7KxrovXKukFVA19a4pGzRW94hYbM4=;
 b=SqZV927qtPwe/YRCD87WAkpBnH2IE9ilKwyp4XziyisfzpWcIhy0VIC4xYH0fSO2zp
 j92QYVWIwxmMWzNRPIbobUP5tz0alUJ2ztWxGa+Cu2dj9eup99jtGbOTBPr6ajIf5Thk
 gU8DT2TFJoPePkHoIUy0WpGEPdrD2rs8q54QqruMCigOlIGeBkgDap26nGKOG+FWNUw4
 8zHGmLHLPbqo9fzaOPh9J/5i9C0QMT/hwphg/CkIyiM/ITwSe+iDxMSlIJSnh/QpKNvq
 xapHNO58TX8uY8OAyqa2nA/L4rG9f31X+OTaaqMDyOV4giRynzXw2rtIQHbPmDGVFjWl
 rJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753466113; x=1754070913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fpWsVIpbRIPv6w7KxrovXKukFVA19a4pGzRW94hYbM4=;
 b=myaNQEynGY+gCwR57nLsLPB2HAtdlYpYNvIj3Dy6lmwFeuicl74YAZ6+hfuMUN7Yi+
 +YQLWLsFhSCYn5xvLFOx1RRlOS1mPXe11KI1Qm7KWwWDtVibEla0xX8d/KjMB8p79kMp
 J3n85+V+C2RuxXJ+N39UXqkZUk0pNLsKtsiRBvEKz/Z2aH6nDDxE7wgFlt7qXSfIK1lQ
 ED2RJnRhhX8k/fX4Sjp8Hf9Y5vGsHBbcQKVzhG5SouwxaaU+vy02ytUAHSSOJkzIY/iW
 HpB0TMaXOD5MxRgdM/LFP+eQukVxeVdo5N91+NSjdB1QxjYWYy22kiBnSQ3K9L8TCyrP
 zwkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6yEptgKv2p3iq0XkLkrfvXcNPTuy/DoLZLXY/Uu/zVu1ZfwskHT1CNzhtDFQlfEp0cqlmrtamYmXK@nongnu.org
X-Gm-Message-State: AOJu0Yx/7Im+swTEbGh76pH5IP8XDEHtmoC4TBAJrvqTXK8PnAheKpKc
 IvXyP43HB1dGlnayv5Q+Kve5D0dn0stl00+7Sz7BofOkmh+mSMcJSSea+EX+dPHQOYc=
X-Gm-Gg: ASbGnctbDRSjxJPbF9V6nelm7WX3CLrWVc2Q6WNGPm/1rftfRWXpDeprFb8EhhxIGxy
 ZcepqPy2QYJ+eYYU3brA4QqPLQHc5/18YrRSQ2mZTe7GP9NfO9OsceoYbI7JU+SsN+OlCA3HHVa
 01zpdpdnlNj7VFqxS6OtYlhF7HwYGraNi2J8kEXMvECGfZeR3fvT3qgTr/vCDpmh6MkbunOnu1U
 2fSCpEV4i/CogYkV3XAvp3ARtaIDqCKigC9vTa80oMoh+vlUPhEa+iYnFFfBo5Gw3W2mdmFgd5n
 KB8tEswsMK2TJFNJIlP6S8MFSIFGOmxscbC1EHU3HWh8A5IctKS6118x0uh2N9ATjFsRCadHrTH
 X3Y+wKshRtky18mF9rBIdWy9I5JiN
X-Google-Smtp-Source: AGHT+IEwWNPnUMH7sf6MUfn8SL6Xh2VhTMkhvevQcRMGYF4HK8Gs8wsnTeNhi40DRpEzLVfbMxUTuA==
X-Received: by 2002:a05:6000:4310:b0:3a1:fcd6:1e6b with SMTP id
 ffacd0b85a97d-3b7766aaf74mr2681753f8f.57.1753466112779; 
 Fri, 25 Jul 2025 10:55:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f16819sm499036f8f.67.2025.07.25.10.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 10:55:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 for-10.1 0/3] linux-user/aarch64: Fix SME/SME2 signal frame
 handling
Date: Fri, 25 Jul 2025 18:55:07 +0100
Message-ID: <20250725175510.3864231-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

This patchset fixes some bugs in our SME-related signal frame
handling for linux-user:

 * we need to make the equivalent change to a recent kernel
   bugfix/ABI change: TPIDR2_EL0 should be cleared when delivering
   a signal
 * we forgot the TPIDR2_MAGIC signal frame record (which is necessary
   for SME v1)
 * we forgot the ZT_MAGIC signal frame record when implementing SME2

These bugs generally only surface when guest code attempts to
unwind an exception from inside a signal handler and SME is
involved. Discovered (and the fixes tested) by some new gcc
test cases which implement their part of the bugfix/ABI change
 https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b5ffc8e75a8

v2: quick respin to address RTH's code review comments. I know
I only sent v1 earlier this evening but I wanted to get this
out of the door as I'm not going to be working the first half
of next week (back Thurs).

v1->v2:
 * patch 1: drop unnecessary if(), update comment
 * patch 2: do "has sme" check in better place, drop unneeded
   argument, return type
 * patch 3: do "has sme" check in better place, check the
   incoming SVCR value, not the old one

thanks
-- PMM


Peter Maydell (3):
  linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
  linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
  linux-user/aarch64: Support ZT_MAGIC signal frame record

 linux-user/aarch64/signal.c | 139 +++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 3 deletions(-)

-- 
2.43.0


