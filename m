Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E35CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeK-0004vG-9v; Mon, 15 Jun 2026 18:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WHowagcKCmcOWMNQPJLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--jrhilke.bounces.google.com>)
 id 1wZFeE-0004um-LI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:15 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WHowagcKCmcOWMNQPJLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--jrhilke.bounces.google.com>)
 id 1wZFe9-0008M5-AP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:12 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2bfdd99f6b7so61348185ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561944; x=1782166744; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z5W3uNKE1Spgdm9oEa4S/g520hIjDwRk62evg4fMwX4=;
 b=UwMrV1vCV4cHF4nQYpuFD3x1XKCgEV1ANMHeLrgA1DAPqe0svHywSDOFrKcejSjwzs
 ATuzI6ohPV4pjpxzo14IKhcCRgRL5a8a0wExFl9TBBzosvMcaE92nqPceCUbdvlkjBep
 MrEjhpo8LoQX4XS9dsW1fbSL0yeBJ2JhIyC48Y36Nrkje0HTNmtNo5mp73swI5NmN3Y1
 UH6btGR9AOHEIhp/k9aExp+3x3vBq9Znz03pBYMNGYvji841qeGFH1wmoPhOVQPlTCya
 Xf3Kj6uq1tMk4rKCKijxTgE/HtqquoxcZTtU4VMwQgokCh8PqIVzHSb25gGSHSH/s/at
 jBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561944; x=1782166744;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z5W3uNKE1Spgdm9oEa4S/g520hIjDwRk62evg4fMwX4=;
 b=CImwlIdTNGr9wN9aYRiyvHh7h3iayEVpUQDqciUIgGbA7SnupGIP0W2Fknvd2M6fPX
 joAjGUBK8kvJervGvQkUmPBd4ZTXCUhQORiiD7qJEsFz7sA1S896ImUuhKN8Z5AnWOCX
 6agM/aKP1vUJNgT9P7QjaKE+EsrxvJcf4Xrd95tXhaB7Kc7juA8AKzuvnAcTqE1o3zi+
 z19y80Q9XP3l+ivb84ucpOSwHm2stYUT8WaZwYlC2tURMV6+eNQ6VIw5n3sCLrQPgn5u
 UB6DF2AB56gsFwOKjCFb3J9JHV8WAMMvhvS2vbi786jzbmAtcv+Ph5O2PWSNedAEHPSY
 6AVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Thv20ciKfIvtPf+RYzzfd1aRdaAS0F0uLHA2lEA+ms59H6DaK1g+/Jd6D6KpM4JnJm8v/uffIzDk0@nongnu.org
X-Gm-Message-State: AOJu0YwI015QtMWyDoZPGI5lxEcIkQfGCDItXgV3sM/gkWVZgFr8pt/b
 A8+NeuH9FTLWwmR9Y46JApc2nmO4n1ZFKtDipFaDsAqnEK5l4pE/G6oietXEHphTjYYQtsh51aF
 dBd+a8+aT
X-Received: from plgy5.prod.google.com ([2002:a17:903:22c5:b0:2c1:a16:bedc])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:950:b0:2c0:b319:fb43
 with SMTP id d9443c01a7336-2c69a1731a1mr11393535ad.21.1781561944298; Mon, 15
 Jun 2026 15:19:04 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:02 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Subject: [PATCH v4 0/7] igb: Implement Transmit Rate Limiting (TRL)
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
 envelope-from=3WHowagcKCmcOWMNQPJLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--jrhilke.bounces.google.com;
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

This is v4 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v3: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03044.html

Changelog:

v4:
  - Remove unused masks.
  - Use BITS_PER_BYTE in definition of E1000_LINK_RATE_1GBPS.
  - Add helper function to get rate factor and unify comments.
  - Add helper function to return if TRL is enabled for a queue.
  - Get packet length after calling igb_tx_insert_vlan().
  - Use NANOSECONDS_PER_SECOND instead of 1000000000ULL.

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
 hw/net/igb_core.c      | 164 ++++++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  13 +++
 hw/net/igb_regs.h      |   6 ++
 tests/qtest/igb-test.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 431 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


