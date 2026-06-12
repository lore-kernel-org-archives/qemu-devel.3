Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A123CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9m2-00021P-1i; Fri, 12 Jun 2026 17:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3L38sagcKCjgdlbcfeYaiiafY.WigkYgo-XYpYfhihaho.ila@flex--jrhilke.bounces.google.com>)
 id 1wY9m0-000217-GQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:44 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3L38sagcKCjgdlbcfeYaiiafY.WigkYgo-XYpYfhihaho.ila@flex--jrhilke.bounces.google.com>)
 id 1wY9ly-0005IB-L6
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:44 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c85a2ed88c8so1376541a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781301040; x=1781905840; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kXapgnjlScmn4HAt1sYOrDJiP0MZupIbpOLNgyAKE0g=;
 b=FjeOqrVTNo6cDo5xOS2YBbJepIpaCEcVkoMybwstMQmmzmrruSwg5hcjAP5SQrKrq0
 zhMhMzhIRWCOdmdAQwGX63xkBRT5bIAEBWfXOlEA9V6iLlW048QgCZfjZ+FbcDzOZ9G+
 6bejzPrXp9nLhytnjq+2bYuItTt2lrX19cGckUp3pXHgWNsO/eaSZ3QHi/nBGL7yfs8i
 SUhdh0cPcbsFk0erLJCJzKUytJiqyn3BfX5AdUjsvNGRzaZFeuBCIpVoiM0l9kcFHcNV
 QZz4GXOfSXn6QONP3Tv/0fgbqVpS7jdzFdfAQ1lsBrykBolpSOaWSBqo0+7sA1j4W6AG
 +bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781301040; x=1781905840;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kXapgnjlScmn4HAt1sYOrDJiP0MZupIbpOLNgyAKE0g=;
 b=qFB2BoYyPQk+/KwFnEJM6c5yev1xFTE9hhtioOgCS+5OWpu9BXLptv6KfkMt9kdUlj
 UYWj+OncruVare52c/3/kwhcxUcPKLyXejtVhQ0QPKsoAn7LFuzqD+hateCu+CcT2tKI
 geNV87VF5E847SufXmsUTVd9eVd4AcOx63tsXzdIfiU2es6h9He7iJyEIVHOZNMCFVo9
 woqx9t5Huw3R76kNebSDolrS7j0Fsa9UVdkmZ3Rv6c2xDwSGlKQyaMtcx1+gUkHId819
 zt+Yq0Y6ZB4FY/l5ocOxkFitcHXF/hXkv9sNojyDtrugTSxNh73En2naHzctVuARPInB
 GWNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YFSPK7fcehTkasv+ftBWHPWwal4zOA08E6pzP7o+Z+h8//vU6sENeM/9RVeP4Tm7s7kOTbxGpGamS@nongnu.org
X-Gm-Message-State: AOJu0Yy7kL4SVvK4GmAWZvNHGsg6F1UaoXzB6EKPLa4YsSvqj9pQED+p
 9JQJaJL8WEacTPxW1PvAhH4pdChalYQi7+5aiTGNkhxdAPoTjRJBlJUgJo7laf0vyBLVvR1Ma7T
 w5FHUzH9C
X-Received: from pfn35.prod.google.com ([2002:a05:6a00:a223:b0:842:b0e7:887d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2305:b0:842:3f9e:a72f
 with SMTP id d2e1a72fcca58-8434cc16bdemr5246983b3a.3.1781301039399; Fri, 12
 Jun 2026 14:50:39 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:50:11 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
Subject: [PATCH v3 0/7] igb: Implement Transmit Rate Limiting (TRL)
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
 envelope-from=3L38sagcKCjgdlbcfeYaiiafY.WigkYgo-XYpYfhihaho.ila@flex--jrhilke.bounces.google.com;
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

This is v3 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v2: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg02879.html

Changelog:

v3:
  - Remove redundant target_rate state and recalculate it dynamically from trlrc.
  - Flush the transmit ring when TRL is disabled while a queue is throttled to prevent packet stall.
  - Remove redundant updates to core->mac[TRLRC] since reads are multiplexed.

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
 hw/net/igb_core.c      | 155 ++++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  12 +++
 hw/net/igb_regs.h      |  11 +++
 tests/qtest/igb-test.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 426 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


