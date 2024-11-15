Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE09D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzX0-0007w7-Pl; Fri, 15 Nov 2024 11:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWy-0007uz-6b
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWw-0003ah-43
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so15983695e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731689443; x=1732294243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4o50frKdRk5B+qe4iFKjaoYsk7e3gHs+0Y11JdkCyVE=;
 b=GPhKBvfyXeTw+9glO3VSJbXCSxcruAUWqHAor3qnskbyvUdZY5dTnCWcYXvzzixaNn
 SL04xLf5fUW0jj7Yu40JqVBptWwB+f3m0IGynGPurB2nwYe2XE7PfTdMb1J+VdlqrQaX
 JvcU4LzSHjt0wBevZyyXOpRQtR55dfblfFDMy9voxp7F2pKCiJe+4GKZ1TS/VP2SiDVn
 dY0JUwAWU1vEuMqZuiGqC+sSO9Q0zfg8AhHkfDGfPjsic3evxubAhkWu08QMbEGacXmD
 wGmaLGKb2t8sBrhyIL/e0PNdL9xShO/UwAtCPI5XZ25T+7aPaWW0cwfjMBphFO+gN02H
 cirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689443; x=1732294243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4o50frKdRk5B+qe4iFKjaoYsk7e3gHs+0Y11JdkCyVE=;
 b=Cw9DKtvVX/DnPLx72SIpau7Ud3gMAzEeWXnb0qXTZ28Qpeb45D58hPepu5Y2us0ANf
 R7LzH2ydvs89+TvQI63XzrA9cFJBFC4+7XUhCuDmrXe4FBykHsnfivbLSjgJ+L/ZK2YK
 X36w5sk+wwoMD2eWhpJ4ncXHPxtuIw19VyovlBDxC/5bXD8MtYVLgj3HU7JYNMlCA2Az
 2F8oLrNdDyPFy8B14WIagCzNV+e3mpfUNUMObLn2GNW8VaCV9vwdXz5/dXudBBU04I83
 1RHo6o9lEbYhdxumNMBcmH5M2n9mN+hodRZCqfPeCOU3Vjt8swmpBV7F9WLm9VJV+2ip
 wEkQ==
X-Gm-Message-State: AOJu0YzCYgBmGf0MuXXu71335nrgErEojHBQMcfTI0DbzNpbxKSNpTct
 Pc2zWPNMRyV3Sj0BZx64OqH9c3COB0LRMSSXUqaRmAjy4qkAsn+2lty0liMSlpJVyJYUlwrqGNq
 a
X-Google-Smtp-Source: AGHT+IHNDjM+GyTRBn+acy299qUSq5QHiA8J2G5pZbUOg4Q8s9wORhz3YGXSXua3Bo9Z2fF4qyTFSg==
X-Received: by 2002:a05:600c:3b99:b0:431:6052:48c3 with SMTP id
 5b1f17b1804b1-432df74cbffmr32808765e9.16.1731689443342; 
 Fri, 15 Nov 2024 08:50:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aef0sm60386405e9.28.2024.11.15.08.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:50:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
Subject: [PATCH 0/3] qtest: Provide and use function for doing system reset
Date: Fri, 15 Nov 2024 16:50:38 +0000
Message-Id: <20241115165041.1148095-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

I noticed while reviewing Roque's patchset that adds tests
for the CMSDK watchdog device that we are gradually accumulating
tests in tests/qtest which open-code "now reset the QEMU system".
Moreover, several of those tests get it wrong, by failing to
wait for the QMP RESET event that signals that the reset has
completed.

This series adds new functions qtest_system_reset() and
qtest_system_reset_nowait(), which send the QMP system_reset
command and then either do or do not wait for the RESET event.
It uses them to replace all the places in the test suite
that currently hand-craft sending a system_reset command.

The tests that previously forgot to wait for RESET and now
do so are bios-tables-test, q35-test, stm32l4x5_gpio-test,
and stm32l4x5_syscfg-test.

thanks
-- PMM

Peter Maydell (3):
  tests/qtest: Add qtest_system_reset() utility function
  tests/qtest: Use qtest_system_reset() instead of open-coded versions
  tests/qtest: Use qtest_system_reset_nowait() where appropriate

 tests/qtest/libqtest.h              | 25 +++++++++++++++++++++++++
 tests/qtest/bios-tables-test.c      |  4 ++--
 tests/qtest/boot-order-test.c       |  7 +------
 tests/qtest/device-plug-test.c      | 11 +----------
 tests/qtest/drive_del-test.c        |  7 +------
 tests/qtest/hd-geo-test.c           |  9 +--------
 tests/qtest/libqtest.c              | 16 ++++++++++++++++
 tests/qtest/q35-test.c              | 12 ++----------
 tests/qtest/qos-test.c              |  3 +--
 tests/qtest/stm32l4x5_gpio-test.c   | 10 +---------
 tests/qtest/stm32l4x5_syscfg-test.c | 12 ++----------
 11 files changed, 53 insertions(+), 63 deletions(-)

-- 
2.34.1


