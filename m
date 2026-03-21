Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506CB109447E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3woo-0008Qx-Mz; Sat, 21 Mar 2026 09:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3won-0008Qn-LQ
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:56:45 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3wom-0000V6-8U
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:56:45 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c757a9251faso562267a12.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101402; x=1774706202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M4ucEH6jgNvziEcY1IkILlW5nK/zX9LJO8HCq9EYnP8=;
 b=PSvnmeVqWx/KnQ07mVrAtn/4hdgVTaBsE06wu6q/yoGxaRxomKsb1puSgVeP/L2+rT
 c6Q+fT/1blbF6Z/7KsmM0RrNeabrTmy9xPbrruO5PDRxDvs1UA+RWm5C4/KD+lEgW+Gb
 LKfP1Ln66ka8YA7BWBMmTEwKSSc2Xms/bZXS7rM0Nkf0DpCPVQwIvguQMqhvO0vYtjgI
 6HObZ5Fi0j2H10mY1ry+LafHrJMap1wRLkBeM9z/a04ZWv0uZt8i3ktrJQ5v1hsgOhuz
 aSB5cCMVQtaCFBLNDPv5oVOYPD1+ONMsKGXpLKxvMgMlxHEdmF11htAj0Xrcpk2SU++s
 VPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101402; x=1774706202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4ucEH6jgNvziEcY1IkILlW5nK/zX9LJO8HCq9EYnP8=;
 b=l7OU1A2l8+328ffYuxJmr8NYQR+c7t9q4aeK4kfgZzesNrOBYc0WYfEZ05GuJuV8kx
 yZWSy0M1mUBl3UwZ6Wbkh90dZrINM+ADy80A/ORP9eMfec6g3JayPkCs+dNdOZEgnhtO
 Ii1RhsDkJXI14mr+vxz8uXGsvRkkBtMXLarorKO1jH4ybroBlyz9XiZrTnlY+VTvYDIV
 8LRYifvCx4PlwNyBrRdvhACnVOjFG5vh+HdqZI/2Hjb3uEJCnSW4b0/IeLka7WYP3nTa
 6bCsJZffeanWw2tTVoyzEoA85LcGci+uV8aS0hHRKhjXU2K0QnTto7r8VeBucOqFYZfc
 +p2w==
X-Gm-Message-State: AOJu0YzlZqdpXn4phyGHmYmk4VH6uHyC39wbvwcL6KW0dmIY2RhFYc9k
 jaJQ+pmMgGANgNgQhKNzHZ3tqiBawveYrkcspTuDwGT5TFWoHEz43Iwx5+sRkw==
X-Gm-Gg: ATEYQzxWirNCpLAHRql/fpnQt8AM5xYMQzligJof5nPh9zZFbX0asfcog01vJRYJM5f
 zrqcjypZb+4/vB6wzCE4EvxQh+yngaMgZ4YCRGjDo3YNTf5Wmz233sTjz6kSwl5KoxgyQJxSnXr
 AYZMczXSpLcMRsM0659XwIMxTTxSvH2pDwguq9Xc/CL2bLb6gLHj+9Y41ns19Qkb+R9Z8XQDf1l
 x56MPOO0r8jjZgjm1OjKKzKQ9RSaidK/zopu0nUV9nR6IoSBY5cO9VUPCw7Ad2FHzcY65ZZDtMd
 ki1PwJaCFTiTIuTAI00475RZNL5sBfobOpGcDGTQ9RvRERsw+UeB+CPjPSZUms/+y7keowSYErC
 GlDOMmWK26D8GaLyjh5WDrZrfKt25EJM7vlMfC0xjjlK538f8KtS9JfB6gaFlRJeCOQQiE+a0mC
 V7Q9lQh1XYx9xqr2Qit0DtVjT5wZ6FU+Jropfnr6s+Qq7gVSYxYoaK/qHRWS7wZplcr3E4
X-Received: by 2002:a17:903:15c7:b0:2b0:73d2:219e with SMTP id
 d9443c01a7336-2b08280025bmr58416615ad.47.1774101401847; 
 Sat, 21 Mar 2026 06:56:41 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08354bce3sm66285675ad.32.2026.03.21.06.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:56:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/3] user: recursive signal delivery fix and test
Date: Sat, 21 Mar 2026 23:56:20 +1000
Message-ID: <20260321135624.581398-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I found this recursive delivery problem when testing new riscv vector
state support patches (plus a minor lock user balance bug).

This or similar type of issue was fixed with 8bd3773cce1 but I couldn't
see exactly what scenario that was addressing. Is there any other way a
signal can be generated during handle_pending_signal()? The SIGTTIN
case, perhaps?

Thanks,
Nick

Nicholas Piggin (3):
  linux-user: sigaltstack lock_user_struct missing unlock
  bsd-user, linux-user: signal: recursive signal delivery fix
  tests/tcg: add recursive signal delivery tests

 bsd-user/signal.c            |  10 +-
 linux-user/signal.c          |  36 +++---
 tests/tcg/multiarch/badsig.c | 226 +++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/multiarch/badsig.c

-- 
2.51.0


