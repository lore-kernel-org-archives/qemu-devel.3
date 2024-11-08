Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4404FD64078
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UNP-0000aG-9K; Fri, 08 Nov 2024 14:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JGIuZwYKCuEURTXHKJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--roqueh.bounces.google.com>)
 id 1t9UNM-0000WB-Tc
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:32 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JGIuZwYKCuEURTXHKJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--roqueh.bounces.google.com>)
 id 1t9UNL-0002Qr-5z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:32 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e32e8436adso34674887b3.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731093028; x=1731697828; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dXKjCtgB4NlPQ0iMDkTUNQya8PszAV5pFwFKgi96zto=;
 b=gaKg5KoAqNDyp1NeUYchfQbxl7HA9SEMZAm+tXXeizocUs2TZuTZqjlvoE5t8w9fd3
 gC3V21HSDJldnd4dBrDGTHNFVCPrh7vlfF3BwUuqMp8dLF1kjB131OOSfZ4yMho8Z2nJ
 G8vXcYvFyaafMLdx+dDnKk0HK3/d8JV6kMjU5IUUubeLB0hBcmWVicEPV2q1nG4uPUYN
 didPIiRuB5Md5FBZIomp5DqeFIQC1CbLd19UNxIcNSwdDpS6p42wi20eYsBsk7WIABP0
 tWPVDeE4ra/+Yh81SUgt0bdhTYod7E3d2TSNNbD+LDxo4cCjNSUetM5vwMn+FNI678qa
 7nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093028; x=1731697828;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXKjCtgB4NlPQ0iMDkTUNQya8PszAV5pFwFKgi96zto=;
 b=BMqwHU/WzUscZ7Fj9nZEULgp8dC9tkFMNvuoxBUPGul7lEMkZ3wuj/KSAkmLwy7/U3
 m00gic2YSWjL/X7QUYFN/XTnRJ2PNUFpfb7p9Qn9LJ0B5mrGt30t/81DSlCa1mXH6pOY
 Bygv5WiiRh8sD5spkVBFD5cBGYWQlOFhQD/YXd2P6Thb7bMRQHx4LQcUTBe2dcOji4Ej
 lV6rAweczrNBjOUExxQIPF7SLKlkNGVJEzzShGMgvjlvuYUAU4oNLiPTbnBLcwONF9F9
 10Z4fgY02MXMpr4Bkw+o7UTz+WoDvNFqB6acXAdah/xcSoAGNlYMEt1IeFOk8NXq8D2u
 LjvA==
X-Gm-Message-State: AOJu0Yz906Vcjo/+qMBiCvrP6wzR6h3SJbMqRuUN93dEmQK4p9yCaOnn
 w0Dq2NfqYkKHSa25y14u0wIln2rfM8ZSR5OZwP4ILt/C0cL4gRyqZYk4QJfYpaHxctoLDfRaatt
 kwQ==
X-Google-Smtp-Source: AGHT+IHbJKzP2rXKRQlbHkD6uYV0U1yR7on49+ZrikMDkyROyFBpYd57DtD+H/czCnat0oUM/Ic0ybLGh1k=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:264d:0:b0:e25:d46a:a6b6 with
 SMTP id
 3f1490d57ef6-e337f8d405emr5295276.8.1731093028655; Fri, 08 Nov 2024 11:10:28
 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191024.2931097-1-roqueh@google.com>
Subject: [PATCH 0/3] Make WDOGCONTROL.INTEN the counter enable of the CMSDK
 APB Watchdog
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3JGIuZwYKCuEURTXHKJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The following patchset tries to address an issue where the watchdog
counter was running as soon as the device is out of reset. This
created a few problems with the firmware under test. It was pointed
out that the firmware under test was already working on an emulator
using the real RTL. Further review showed that the WDOGCONTROL.INTEN
is also expected to be the counter enable as it is defined in this
page from ARM:

https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model?lang=en

     |       | Enable the interrupt event, WDOGINT. Set to 1 to
     |       | enable the counter and the interrupt, or to 0 to
 [0] | INTEN | disable the counter and interrupt. Reloads the
     |       | counter from the value in WDOGLOAD when the interrupt
     |       | is enabled, after previously being disabled.

The second half of the patch is focused on adding tests for this
behavior. It was required to modify the test to be able to run some
test cases in the MPS2 since the the stellaris machine had 2 issues:

  - The stellaris machine did not run the counter out of reset
    because of the way it is reset. The function
    ssys_calculate_system_clock is not called until the reset phase
    stellaris_sys_reset_hold which is after the watchdog executes its
    reset, so the watchdog would not start the counter due to the
    clock not being set up at the time of reset.

  - The Stellaris machine uses a derived watchdog and not the
    original CMSDK one which has a special behavior where it cannot
    be stopped.

The MPS2 machine on the other hand uses the standard CMSDK watchdog
and could expose the problems we were dealing with.

Roque Arcudia Hernandez (3):
  hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
  tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
  tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as counter enable

 hw/watchdog/cmsdk-apb-watchdog.c      |  29 ++-
 tests/qtest/cmsdk-apb-watchdog-test.c | 327 +++++++++++++++++++++++---
 tests/qtest/meson.build               |   3 +-
 3 files changed, 325 insertions(+), 34 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


