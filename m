Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E710FCD11DB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYS-0002H1-8l; Mon, 25 Mar 2024 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYR-0002Gi-Ds
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYP-0005d6-QY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41488d6752eso5837105e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370152; x=1711974952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oEOK2Zm2h8ZJIo9UJWkaYcRFSXaqVZtInAXQGN/ZqdM=;
 b=pTwGUVfzXwkDGpiWTypTpzOMq2IOIgIx1zSpicrzEEIc8zthDg4eJ002F2uKlcPsOi
 DyKp+JcV/Ln4+ExqHTMm4yoBa4OvzHE8xKTZjhXyCFRlqn3FvRY3sz/feaNvRTxS0d3Y
 1KSlCnK5FocTZ2Jm2TgdVOKJOkiu9iX2R9w6VD1ufsTGu/TJOh8lTxAe/5Sv6befDp1j
 Mbz6JYsR50cMh9ViMt7WN2LHo6lQFp/H1bqxOOaAfmJWhgXtzUDZtrAU8T1EX+0a6drR
 gBvr7rB5lffnXuuRRFz44+oFVtoWPphh2DGAe0F5ftZ2CnL2z4nOTmfGXgM0YwKsC94Y
 vn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370152; x=1711974952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEOK2Zm2h8ZJIo9UJWkaYcRFSXaqVZtInAXQGN/ZqdM=;
 b=jOim278wzmD5oqTwFvXOSpOluuhUH7VVViW6rPVqpzUF4A2lszxWqEwMQQwB9R9Ell
 BHHXUdBaVTKtAuQ1ZuPzyt0f80vXHL2ad+4UuxG4wC8CtXAGPjS5djAVJi6kbXFueCu+
 p5As7pH6UqF86sahPLC1lEPaEl3oDvqikP8GRxN0rKbO2jF+Kn5/5x00gA4PKvtBRS7f
 SQcykWka8j7RKysAaJwNupATFxCsV6NMzSpJHeyiBGAeo0kh/RoasXuQN6vLwrnZrh9g
 j/fissT9nau7vmGtLGbay3Fa0Ofl2ZxNGVTJrNLB2rASIgifa5pMqEkMfeXN44TbLjAZ
 yPwA==
X-Gm-Message-State: AOJu0Yw8fHg70pH6sFQep8QwsJIRsJNKVcpDEpQOTa57T7D2eZ3N9wpc
 mRGeMXbMsyWDKBqDw2h2b4Arr1MRsiMTldjkvm76A/Y1Er+XJcgHwUlFyuY96pOd4X9Y3xylr7X
 1
X-Google-Smtp-Source: AGHT+IGnI74U/ctx1r7D1pfdJ0rnkhBKG9yzQ37gnldpFKThD4EaqOof0lL0QeTMsvW1sdaUHAYH4A==
X-Received: by 2002:a05:600c:1c1c:b0:413:f7a2:55e0 with SMTP id
 j28-20020a05600c1c1c00b00413f7a255e0mr4775395wms.30.1711370152097; 
 Mon, 25 Mar 2024 05:35:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] target-arm queue
Date: Mon, 25 Mar 2024 12:35:43 +0000
Message-Id: <20240325123550.1991693-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

It's been quiet on the arm front this week, so all I have is
these coverity fixes I posted a while back...

-- PMM

The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:

  Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240325

for you to fetch changes up to 55c79639d553c1b7a82b4cde781ad5f316f45b0e:

  tests/qtest/libqtest.c: Check for g_setenv() failure (2024-03-25 10:41:01 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fixes for seven minor coverity issues

----------------------------------------------------------------
Peter Maydell (7):
      tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
      tests/unit/socket-helpers: Don't close(-1)
      net/af-xdp.c: Don't leak sock_fds array in net_init_af_xdp()
      hw/misc/pca9554: Correct error check bounds in get/set pin functions
      hw/nvram/mac_nvram: Report failure to write data
      tests/unit/test-throttle: Avoid unintended integer division
      tests/qtest/libqtest.c: Check for g_setenv() failure

 hw/misc/pca9554.c              | 4 ++--
 hw/nvram/mac_nvram.c           | 5 ++++-
 net/af-xdp.c                   | 3 +--
 tests/qtest/libqtest.c         | 6 +++++-
 tests/qtest/npcm7xx_emc-test.c | 4 ++--
 tests/unit/socket-helpers.c    | 4 +++-
 tests/unit/test-throttle.c     | 4 ++--
 7 files changed, 19 insertions(+), 11 deletions(-)

