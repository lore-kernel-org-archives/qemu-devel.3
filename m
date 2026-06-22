Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D162BCDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjy8-0000VJ-6o; Mon, 22 Jun 2026 15:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lIc5agcKCuEMUKLONHJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--jrhilke.bounces.google.com>)
 id 1wbjy6-0000T2-Fd
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:02 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lIc5agcKCuEMUKLONHJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--jrhilke.bounces.google.com>)
 id 1wbjy4-0002kY-Nk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:02 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c898897816fso2871919a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782155157; x=1782759957; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aTKb0Q0dRE+Fc9YLHQ++Tn9K6nM7Cd4QftzASM2jGz8=;
 b=Nz2K/g/OeszdRiQxQgp9kv8Ugy14Kp+X0LPIZoOwfUqWShVCWIJIAUKZbqcqzCfB1E
 RbnukGIx79AFm96563pFPDD8OqAxhdZOnrDcmz4Q4Ck2lEM2c/xLNgtzeyPItJlqM/t4
 aZmqMwX4iJcfF5fJN7ft3obetyjWWETa+hhlBeC/dAvBIbBwUS4WTVh3E2nOXtXTn3uu
 3cgLf+hJilLTbXkEZo4HkwV4y3J6QZPDDvNfNSrHX2grHIRlnX3KGiZ+HrW/l15Nm6gz
 PULrjkYdeKf7ALYwK46wn3o2E801pS+8Q/mzn2D5IzyqRYMSpmZo8nn/9LRKlexhiOTy
 ZxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155157; x=1782759957;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTKb0Q0dRE+Fc9YLHQ++Tn9K6nM7Cd4QftzASM2jGz8=;
 b=jK8wDxa5mmjObWqDNKdt8p1J8HF5FfaQ8hsPvbLFG4P+vGXuDu3pdJglVPXTJCNoVU
 6dtBeOCWZYqgFDr5QJQRgAXv4Ki349JUpzjzNxFHAiNZ7Ekhkh10zZvlF1QCMLyBbSZw
 wBqfOjkIOQhz+Olq5VsfRLimL+iJwanJonv3tiZ5GLt0D5Xr4isc6/WOcNk7Hcg0Bzqi
 5+cKqIHRubnlkSN84OUYuMoTOR0Lzxkju8W/hCyyhgTfQ1IA/a6pc7bAF2/BQ3TWOYVx
 OnkY0GLVVPB8TGyXvpVUuJc8mgeW7RIbRPybPWLS70qbP3LUBxlvn3ySEixJvSrPBj77
 +4CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rHx8eyjj8UJ6ybGgohgtKCk8pTJmtq8WxWes1O69Pe5LxxKh3N9Hu5inzNpCtFqg5v45sIyo+Y1pi@nongnu.org
X-Gm-Message-State: AOJu0YwSuvIAcn2QGS5W+VSNK5KdHNkglA4hZvAPfuOS2B1Lku0ndq8N
 H2t5hBkwDoaK7I2dWDuWSb8hbDTWA+k4F4M5c1utcLo2tkDYX3jCj4MqZDK3eRUqVyBRUjyifbx
 /9lpRjN5p
X-Received: from pgac9.prod.google.com ([2002:a05:6a02:2949:b0:c8d:1b0:ab70])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6684:b0:398:c0ba:9ceb
 with SMTP id adf61e73a8af0-3bb6a2ddb3amr16945193637.12.1782155156970; Mon, 22
 Jun 2026 12:05:56 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:05:37 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Subject: [PATCH v7 0/7] igb: Implement Transmit Rate Limiting (TRL)
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
 envelope-from=3lIc5agcKCuEMUKLONHJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--jrhilke.bounces.google.com;
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

This is v7 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v6: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg04562.html

Changelog:

v7:
  - Inline igb_trl_disable() since it's only needed in one location,
    igb_core_set_link_status().
  - Fix indentation in QTest.
  - Don't set PCI_MSIX_ENTRY_CTRL_MASKBIT when clearing pending
    interrupts in Qtest.
  - Fold calculations igb_trl_calculate_delay() to simplify logic.

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

 hw/net/igb.c           |  43 +++++++++++
 hw/net/igb_common.h    |   1 +
 hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  12 +++
 hw/net/igb_regs.h      |   5 ++
 tests/qtest/igb-test.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 404 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


