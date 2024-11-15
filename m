Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0E0D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBynO-00048u-JP; Fri, 15 Nov 2024 11:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31nA3ZwYKCtUIFHL587FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--roqueh.bounces.google.com>)
 id 1tBynM-00048G-52
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:40 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31nA3ZwYKCtUIFHL587FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--roqueh.bounces.google.com>)
 id 1tBynK-0003jm-Db
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:39 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e3808cc775bso3601486276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731686614; x=1732291414; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1Jao6wFY8gON0NOG+NANqTtWcVC5+rnyn6sEoCRpZUA=;
 b=pOBlZSJjZ0BVU7V1uFDnRBHhSabAavTSyFfy/cYNmP3CoTbacsjAussDedwoZ0lTEq
 18UA16diUB9XT2jyDlbNzK2vqpZOUcrLg73UXP1DSJ3bgTsQOdpkHc9IG0iaynKzVBQC
 G+g6t2MGOWFgdJMY9avZG4Bk9eyvRl1RqWZw6SVrkTZK6lzEqPKa9VFaqj6qNh6dsnwg
 zwOrRguAQFVDyDk2KdWj53RMGOnZl9AiFXbrKjYuakKO1JnzfnLY0j3tauGGYmGSW3ry
 y57Wt28a0d+HMOp9rsMxbWFUqgXQA0SiNytQnNgdXlkOIa21Y1o/6pdR9oVyqDx+sN62
 OdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686614; x=1732291414;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Jao6wFY8gON0NOG+NANqTtWcVC5+rnyn6sEoCRpZUA=;
 b=QaGCWGg3iyGhQ7nsYnsGbRI8c0+Mw2JZ/VdwgwoCldZSum6dChVcD5s7D5xMVs9Lya
 qNhxx6/Ml68xeXg7kwA/l7rzB3TLiO+s9dxHehywjq/ZZcWA3xfz+GBmskxfxMWsDHSq
 aQ0c0m5e0KEvuZzfl6HJsDxPlP/TMCLb7u5w2Rtwuqt7GnIY8uIvPEbF6dYik+f+j3Nt
 jP5vOWXFN5R/4f8Cr+233bMiYwnCum9ccpuXWxMNcvu5iejmxfkrzPxOnW2NLg25mdCt
 HHGFmXv5cIXJ/NpnFnyzZGu2QMJz0h106EtPg9S21rfpQ+6UZirAiLk6CV3+kmrb28Gi
 5YTw==
X-Gm-Message-State: AOJu0YzRs7i8cb9zNs6hsgdrXkCEi63JPZgaqT1XoOnEfrWABCommTIC
 DpVzRJRSnMUrtroRAg3E6G1R4/78fTIp9xLXHQ3/9TlIzvURSRySuvH9GEaZXHvbuyJA4iWjShA
 cCg==
X-Google-Smtp-Source: AGHT+IFGh0BzK4WA1jBwf6vz3UTxl1Hm0leOpmd6C0Tpqe6lMHyV0c957etRVD2xQSSkCGwb8fmMqcoIDjg=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:886:0:b0:e2e:3328:7a00 with
 SMTP id
 3f1490d57ef6-e3825d4d1a9mr200320276.3.1731686614700; Fri, 15 Nov 2024
 08:03:34 -0800 (PST)
Date: Fri, 15 Nov 2024 16:03:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115160328.1650269-1-roqueh@google.com>
Subject: [PATCH 0/5] Make WDOGCONTROL.INTEN the counter enable of the CMSDK
 APB Watchdog
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=31nA3ZwYKCtUIFHL587FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Roque Arcudia Hernandez (5):
  hw/watchdog/cmsdk_apb_watchdog: Fix broken link
  hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
  tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
  tests/qtest/cmsdk-apb-watchdog-test: Don't abort on assertion failure
  tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as counter enable

 hw/watchdog/cmsdk-apb-watchdog.c      |  38 ++-
 tests/qtest/cmsdk-apb-watchdog-test.c | 328 +++++++++++++++++++++++---
 tests/qtest/meson.build               |   3 +-
 3 files changed, 329 insertions(+), 40 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


