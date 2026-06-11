Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FFFCD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLs-0002AO-Ik; Thu, 11 Jun 2026 20:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xCQragcKChM2A0143xz77z4x.v759x5D-wxEx4676z6D.7Az@flex--jrhilke.bounces.google.com>)
 id 1wXmhe-0000yf-E9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:42 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xCQragcKChM2A0143xz77z4x.v759x5D-wxEx4676z6D.7Az@flex--jrhilke.bounces.google.com>)
 id 1wXmhc-0003mz-AK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:41 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-84240683a82so209530b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212357; x=1781817157; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qPusLYx00wWGaKv7qv8DPq1wTz97v6z7EwoV+3s6rPQ=;
 b=Mr9XuV6uf6cwPVF6vcVU75IoCsLIc1fc2h7bMZVRgBCEJqhQYxt++1EqorNc6DHiIK
 ZYrNIJBWZOQ83Q+JML0DV5Cwf20/o8iTWg+54OAMPP2ssra6NZ4WRBN8wvcz3TYTKqrZ
 sTeSFhs38zrFcbEYuDqt6vBbF+tdlnWby675ufsuE/jEErO5f6/6nb7I+36uuhZvj5zH
 EOwp+IxPksFkHKIDO0xDeZuUDQgA8n+xjqBhSNprImyNXNkXH+t89IFXJcu3L1puXOfz
 UKB8rRnEqvuANAFnjMezxBuE7v3z9NQuoqLd0FT0UNyS9483sC/KyJo4Bs8EP/vIBxob
 ft/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212357; x=1781817157;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qPusLYx00wWGaKv7qv8DPq1wTz97v6z7EwoV+3s6rPQ=;
 b=gmtge0TadGFFGLmw4SGDbgLHM2H34egDM3wl5f5gd2TmoJAjTBXbHKl2oevf7AG34z
 HXjq+yyfGL2Px16p/poFh5RMWfAaQtwvCFM9IgOASfR2pFJIDfyxpJGLKU7G7ssIKFGH
 sLswTbxIoM0lAcF/tLTvajtGf2eb84gfM00tUglwGFgsPWN8bMQT4oJ0aGS2XUK9N9+1
 QrTlFILpcdERhsF80HEynzGLy+8LqmZc4lsdd7epJtvU3Ep3gEBIRKQCqO/NhmwIb4ee
 W2fAuSf7WTbBlQ7bDqU4aELogfaxFsDoG+/eZnC50D+Nt8YQIFfH47l3qojp1AriTSR4
 t5lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qSWDSQyrATl4FGU0daMY4RPsuRkotPlpQypiV7IoAhj0btvC5/SkvqpZoz6kpehrgr2TLqo0LgXMi@nongnu.org
X-Gm-Message-State: AOJu0YzyA15m0CcEUd+MyOkfocoH92orsilx55I9/3BqFNK1+FgTceJi
 ppvjE2+ZZ2vcrJZIwhEmwYGaiKC+nkC14slqga42RSjIYfFx01CECQBY5CKHpRgc0FmjZTpLsM5
 jD8zOu/oJ
X-Received: from pfbgi9.prod.google.com ([2002:a05:6a00:63c9:b0:842:7020:db6])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2ea5:b0:842:994:939e
 with SMTP id d2e1a72fcca58-843497db05cmr326910b3a.35.1781212356377; Thu, 11
 Jun 2026 14:12:36 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:25 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Subject: [PATCH v2 0/7] igb: Implement Transmit Rate Limiting (TRL)
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3xCQragcKChM2A0143xz77z4x.v759x5D-wxEx4676z6D.7Az@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 20:02:23 -0400
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

This is v2 of a patch series implements the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v1: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg02516.html

Changes in v2 are minor refactors based on Akihiko's review, and adding an
additional Qtest to verify register state. See the changelog below for more
details.

Changelog
=========
v2:
 - Add VMState for TRL
 - Refactored TRL state in IGBCore to encapsulate all per-queue fields in a
   single IGBTrlQueue structure.
 - Add TRLRC to the TRL state struct to ensure that the rate limit is tracked
   per queue (Akihiko)
 - Add a commit with an additional Qtest to verify TRLC state is per-queue.
 - Fix indentation in Qtest (Akihiko)

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

 hw/net/igb.c           |  44 +++++++++++
 hw/net/igb_common.h    |   1 +
 hw/net/igb_core.c      | 138 ++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  11 +++
 hw/net/igb_regs.h      |  11 +++
 tests/qtest/igb-test.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 409 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


