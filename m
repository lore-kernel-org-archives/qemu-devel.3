Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC8BD46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGy8-0005cN-4H; Wed, 28 Jan 2026 20:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGy4-0005aL-2c
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:37:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGy2-0003u4-95
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:37:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a7bceb6cd0so2900345ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650624; x=1770255424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dWYbdPtZTYbk5J2bnVj6Hm0Lv7DaVkGptES4Eu0gJbU=;
 b=cG5WpER+EleJ1clGpJ0ZnhuR0VUWUGpLGRKJikXvmjTjKbn0ApLATF7bj1PfEppnrF
 Dkg2s1PYEIpbaxMOs4AHaJh1qPOESuFdi9wCpf73b5KaxLTaUjz5ihrCfp43qmdB7jKr
 yxtNq2hr5FusYP4OmZ2ug8mUt6f3g7KOL3u/2IfMCrHerMcRuG/ivApbb3g7ybGh7T6S
 f3fgejLBoVyNyPkQRuZwurwTHhIfNuPEWj35bSUp1QAabaTcQlewwyuVtGijuP8Tofbz
 HQxUNqswMJ9pbrODXZ8/j+s+g+EheXIs8GoZz4r6//9SIgPzmIXYJKFakIIBRB6pS+2F
 LVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650624; x=1770255424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWYbdPtZTYbk5J2bnVj6Hm0Lv7DaVkGptES4Eu0gJbU=;
 b=FH1SmW7MvWX4kwbe7Wa/wBPV+beBoLF7A+y0It8Rh2BCOmdIFMS6ozDSBVhCUqdpwp
 G7e/bRFDsFivbMgDecR5KYmWIGVGdtY5oKtg3ALPgNYlCq+dTol4eDsJUkR0v95GXSlf
 15Mz59pKziI+u52/2bOeG0IYgyvUxl3C7EByQ2xhVDMDH3/rB0s3091NT30rNhyo9KOd
 PEP/h1zZRa/WcmbHU2DHLjwRYGo4QIyQf89cSp3NeNjTyLWdPkCtY2kyKf29PmEpNqzs
 hPSQ8Y4MVHY7IeBngeG3/aCfTtvF9bhjnRv1RRc4EcjhygAmYi5pvCYMDfAE7xfl+NiS
 mIHQ==
X-Gm-Message-State: AOJu0Yxzuw3zRKZMCculV5C7iPA30yllcYg61eG1IN6uJs8ubgt2kaas
 7+kRyfe1mWYEY+QCOz3Sf2SQ7vKUeGjY11jZp4axdsCAf2RjvSNAUjFRYFYvT/ueIiOCkVBUfFc
 DZ4f5
X-Gm-Gg: AZuq6aIOEeGeDdyF1qohFHaOrWPDY8eWbZ2/XL3AKL2uVlRddZK2cUnv06mwmhRQRNK
 xNPSec+9IMksuWM8KyXw0ZXDG2Mk1uu7wk6aKwnceikiQBCZNREuss/e4u0G6p1K4OIVZuVxqYo
 1AkIyUfXHT0cPzEbBPNKsejRrPue3ACpFPomrJsYmitf0NUOprzrym79x/A2Ld0fIUn4lZiYOrP
 rfwfPqkotGVUcMr2h6C1mKybTtZOH2YHvXvmrYGPxPV7Jj/95+2VhFMcqcivCxf2cVAvf9eM4u+
 AE8BxIOhqT5iv6QUdOMep4o3uw5CwmGKaoKU0Utrko+bn1THyNCqnLBf96btfcrfEnnxjT15o9q
 QKefuZNqsqvfnH+2Arupmswcsag1eclehJLL0PJ8cm7yr3c3k+ISAZxq5S6ZblG0SP1jgfYbtpp
 vfLAUr7Sn7mYgzbL9ap5YXPbCDvbiP0gTe9JXeiFWdNFK0pW6ND+R1Pp37J0hIjber
X-Received: by 2002:a17:902:cec6:b0:2a7:af02:2fb9 with SMTP id
 d9443c01a7336-2a870dbbfe2mr68240535ad.36.1769650624311; 
 Wed, 28 Jan 2026 17:37:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4173a2sm34889095ad.30.2026.01.28.17.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:37:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 0/1] Build fix with --enable-modules
Date: Wed, 28 Jan 2026 17:36:57 -0800
Message-ID: <20260129013658.3961469-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

The following changes since commit 9ad7f544c696d73ce377bbad83f3cf8b4dd8dcac:

  Merge tag 'pull-request-2026-01-27' of https://gitlab.com/thuth/qemu into staging (2026-01-28 10:04:17 +1100)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-build_fix-20260128

for you to fetch changes up to 8eff45dfe93b34b1a027bd22fd8dffe6424f480d:

  meson: fix build of qemu-system-microblaze with --enable-modules (2026-01-28 17:35:52 -0800)

----------------------------------------------------------------
Fix build with --enable-modules

----------------------------------------------------------------
Pierrick Bouvier (1):
      meson: fix build of qemu-system-microblaze with --enable-modules

 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

