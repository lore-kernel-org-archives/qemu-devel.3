Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1DDCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwgE-0002aE-Tk; Wed, 17 Jun 2026 16:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hAAzagcKCqkSaQRUTNPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--jrhilke.bounces.google.com>)
 id 1wZwgD-0002Zu-Hi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:09 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hAAzagcKCqkSaQRUTNPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--jrhilke.bounces.google.com>)
 id 1wZwgB-0002of-Mc
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:09 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2c6a20348ceso2796515ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781727365; x=1782332165; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FLFuhHtCE6WRyQNfkOAmW29U+8qQebonO56U583YO44=;
 b=dLljgIQo7lt7ktmdehaWu0npii17uP2wi3haLJW1tvYmcbv0uJpGrKwWjDUkFqG5l9
 tOmICgpilX6EaAZg1UVO9oc5RQn77VUrvQGGCnRD8xUuFluVXPpQujCzmN9j9oR0nHb2
 zSGNXc2oPmOyDFJYTLLzSsgCj5V4Pf0Bzi2g3BrJVVl1610fSyE5kThcWy73d55ffSnp
 QOf70WXJKdvm/RpoPzYke/45EchWqbJ76fjn/kMPv0hAKPtCYpk6axFxA3pSfCZEPNLH
 HYSPeEoX/R/E88OWuBoUGlKCHFyfYxzOOD9GQsTydVRCkcKkQtYFsr7DRpd0gA9otnDX
 0RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727365; x=1782332165;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FLFuhHtCE6WRyQNfkOAmW29U+8qQebonO56U583YO44=;
 b=qIF7XIP0V57YlfIyXCQAI/XX6l2XaXBoEZqOkNdYMKpiILOW5E4RsVKHHJMw+subQ0
 Ks2biGD4/wdcNGlZL2oy2dCE9UUMKFS/57+HKlM1MphPnNB850Il1DgPy/DwoPcWeAhF
 ngbzqr7+PFawh8uddmMisU2/wuFjeOhO/bne22AQWAQJAMUwYS1Ji3on/wiN0F2uJJs3
 CFfyKCCtIDq3ensbI3svb/GxYSEN2uxRkpVRFHpjhEqiB9XG+xilUnMtUa3+ruymNQ+u
 myC1GeISdpskDVI+QcSOonn9hZWK7P2wfczBHHun2+17GjYDODLvwmX9HvW6FYF5fXgp
 AKdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BxVvUw9TNJMJrNEsbu6DEqLXkLPT0rfpwJzI4J7SpBE1FDZqMgNNSbHvMzixd2CLGGYxhOpe/+otZ@nongnu.org
X-Gm-Message-State: AOJu0YxrPaHi9zIXdH+gXv0Eg5MPWNmjnbusryLONobU7Yv7RcSbs9Eq
 5rJUC3q78drm+RW5JdiOf0JL4isQ6Xoh0bL8ZnJNwYdU7h1cXAs1oawcNatNlQi7F0wzgFBwFsp
 9IYOzu/VC
X-Received: from pll17.prod.google.com ([2002:a17:902:c211:b0:2c6:b42a:f959])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da8d:b0:2c2:62ee:5a0d
 with SMTP id d9443c01a7336-2c6bc0bdc32mr51941665ad.14.1781727364772; Wed, 17
 Jun 2026 13:16:04 -0700 (PDT)
Date: Wed, 17 Jun 2026 20:15:45 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
Subject: [PATCH v6 0/7] igb: Implement Transmit Rate Limiting (TRL)
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3hAAzagcKCqkSaQRUTNPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This is v6 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v4: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03717.html

Changelog:

v6:
  - Use extract32() to get scaled rate factor from register.
  - Use extract32() in igb_set_trldqsel() to extract queue index.
  - Use uint32_t for qidx.
  - Change igb_trl_enabled() signature to take const IGBTrlQueue* instead of register value.
  - Merge target rate and delay calculation into igb_trl_calculate_delay() using muldiv64() and clamping.
  - Change igb_trl_needed() to check for any non-zero trlrc value instead of just enabled state.
  - Add trailing comma to TRLRC in igb_macreg_writeops.
  - Remove flushing logic when TRL is disabled for a queue.
  - Modify igb_trl_disable() to only clear the RS_ENA bit instead of setting TRLRC to 0.
  - Update igb_reset() to explicitly clear TRLRC registers.
  - Extract TRL queue initialization to a new helper function igb_trl_init().
  - Introduce igb_trl_uninit() helper function to match igb_trl_init().
  - Introduce igb_trl_reset() helper function to set trlrc to 0 and delete timers.
  - Modify igb_set_trlrc() to only disable the queue if the guest explicitly cleared RS_ENA.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Josh Hilke (7):
      igb: Define TRL registers and core state
      igb: Add VMState support for TRL state
      igb: Implement TRL register write and configuration
      igb: Refactor TX path to return processed byte count
      igb: Implement TRL throttling and timer resumption
      igb: Add QTest for Transmit Rate Limiter register multiplexing
      igb: Add QTest for Transmit Rate Limiter traffic throttling

 hw/net/igb.c           |  43 ++++++++++
 hw/net/igb_common.h    |   1 +
 hw/net/igb_core.c      | 144 ++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  12 +++
 hw/net/igb_regs.h      |   6 ++
 tests/qtest/igb-test.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 410 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


