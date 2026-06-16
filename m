Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9E6CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZcO7-0007MO-OV; Tue, 16 Jun 2026 18:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30s8xagcKCpE4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com>)
 id 1wZcO6-0007Lu-86
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:06 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30s8xagcKCpE4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com>)
 id 1wZcO4-0001bm-HU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:05 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c8628dc1802so5390570a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781649362; x=1782254162; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CvIx8a7wZ4qfp3zMAliIsAoJwCNjZVgVABttiZsq5yY=;
 b=ej0oQfP1KcQMhUpLIFdmOR/huRbEKp/JgsL7gGUNmvM9G3P5OFQwHwMmGB3UfNgSRq
 0UQqaH+VWPBLMSIzK7fV4sdvL4Hg4SesVO0RXj8NMZSvWftQ+awJpZRq8sCek+QZKtRH
 JFccxsQiIYBqcSUSUOQb6jJYs3vnWvsY+54d9S5XtF8n6lTOR3HKWxuFP48YIYdR3qOA
 9fYfCqcrn4dqZyD+XGC5YrRwT9bLTHEE+b2DKKVtN///GL1CFDy3hpjl0DZAwLlzest4
 uhEKEb4gYpg2DTb6639r5k1rR2CxVYl9YvFOBoHAE//S4lcGbDJ2/zjcsLI+YEVyS1VT
 P9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649362; x=1782254162;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CvIx8a7wZ4qfp3zMAliIsAoJwCNjZVgVABttiZsq5yY=;
 b=i+X1Sde2ASdsfzNGzErIe6rKNsU0QTt6eGTaaYFvtYrKbegt3vPvVceScU7WVe5poe
 XwDjY2wBXjo+m+Pflq3F44ODKQKAWxX2VxnKGYZZHBhHjpX4O0E5y4eDZ1eGTWoVH/SG
 51xVWgOfAEiBa3IVmBGFT0LFtLjbNfRiXDG8Jm0PQ2rEjvso0hgf/Ot25ubIrYcK7hr4
 vtEHeNjoO8GocrHNGwQNLTjO7KNq5s1tTtAnaGAtQiCOtyhxoZrp9ZL4MqbzRPYjjtqg
 IilTHwBbRsZGdjPkAVIu5AeuvPIT8+LtwD9TEXa4scRXulgnj6rh53wLy0TuVW5SlDEX
 3y8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+smtQNpM6EU+UBKJiBgZP27mnay37gn3DF5o812OYW9CwJp1TU0+RORGtvmGDHoDcWpmZBkBToXEJc@nongnu.org
X-Gm-Message-State: AOJu0YyahqpQUz+/j1mHPnLKD5rbi1IuqG2GfpQASWSNLlrKuzuCwFc7
 2Yb6mfa1BS7hjyJ6imW6t2r8TrcQJOTXlLiEXWJ8bQqJ4vnn5oStzlTWc5myFJzPa4jlDZ8uI3M
 6/iu9xa8J
X-Received: from pggi20.prod.google.com ([2002:a63:cd14:0:b0:c82:798f:6285])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3115:b0:398:8870:b58f
 with SMTP id adf61e73a8af0-3b8bce998f6mr1146029637.14.1781649362194; Tue, 16
 Jun 2026 15:36:02 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:35:27 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
Subject: [PATCH v5 0/7] igb: Implement Transmit Rate Limiting (TRL)
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=30s8xagcKCpE4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

This is v5 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v4: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03717.html

Changelog:

v5:
  - Use extract32() to get scaled rate factor from TRLRC register.
  - Use extract32() in igb_set_trldqsel() to extract queue index.
  - Use unsigned int for qidx.
  - Change igb_trl_enabled() signature to take const IGBTrlQueue* instead of register value.
  - Make igb_trl_get_target_rate() static.
  - Move igb_trl_get_target_rate() and igb_trl_get_scaled_rate_factor() to from Patch 1 to Patch 5 (where they are used).
  - Use divu128() and mulu64() helpers in igb_trl_calculate_delay() for safe 64-bit division.
  - Change igb_trl_needed() to check for any non-zero trlrc value instead of just enabled state.
  - Add trailing comma to TRLRC in igb_macreg_writeops.
  - Remove flushing logic when TRL is disabled for a queue.
  - Modify igb_trl_disable() to not flush pending packets and not overwrite TRLRC
  - Extract TRL queue initialization to a helper function igb_trl_init().
  - Introduce igb_trl_uninit() helper function to match igb_trl_init().
  - Introduce igb_trl_reset() helper function to clear TRLRC and delete timers.
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
 hw/net/igb_core.c      | 160 +++++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  12 +++
 hw/net/igb_regs.h      |   6 ++
 tests/qtest/igb-test.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 426 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


