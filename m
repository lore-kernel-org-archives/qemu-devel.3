Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B477C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7Ja-00063t-Oi; Fri, 13 Jun 2025 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7JY-00063b-Rd
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:31:37 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7JW-0004t1-VR
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749832258;
 bh=bBxwc8JjqT4Vivv5StJ1LWVPPELu658+aS5h8kkRlpo=;
 h=From:To:Cc:Subject:Date:From;
 b=fuYWgNKjMNQIRI3sWuK4yQhgRAiG1QeTwPj6SpF3LQrmas65ihjOQ2MnR/GlT8Y3b
 t84ppu3vfy+QuaRHyW1daz8llylX7WXnJCF9XfLLPmxa6uEsNBU1lSArwEsEYA8SEo
 fc46QPEgrwlhZzrFEzjvqOfJa9PnNaWI+FduARk8Gn7flIJO5PMLcjJF4gVvH/ulY3
 wqWC1QkauPPKHl4wRIsuJ1dBKZ0VGlVYbCPVtYUZfbqoJDNay4zXLi3iVnOV3caLuw
 sOWV44n5jut0GTgpS4u3AF6Eq4OtBOtbPrQ14HtHaSYYgfCc65Yme7akeYe8b3ooP+
 8GW8Obc4ENUbQ==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 468BB54A0;
 Sat, 14 Jun 2025 00:30:55 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, "Thomas Huth" <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/12] Replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:30:00 -0400
Message-ID: <20250613.qemu.patch@sean.taipei>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The boiler-plate licence headers in several parts of QEMU still contain
the obsolete “51 Franklin Street" contact line.

The Free Software Foundation now recommends using the canonical URL:

    https://www.gnu.org/licenses/


This patch updates those headers. The patches are comment-only;
no source code changes.

Please review and let me know if any patch should be split, squashed
or dropped. This is my first patch for the QEMU project, so any
feedback is greatly appreciated.

Thanks to Thomas Huth <thuth@redhat.com> for proposing this issue and
outlining the steps, and to Daniel P. Berrangé <berrange@redhat.com>
for the clarifications.


Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2438

Signed-off-by: Sean Wei <me@sean.taipei>

--

Sean Wei (12):
  COPYING: replace FSF postal address with licenses URL
  linux-headers: replace FSF postal address with licenses URL
  libdecnumber: replace FSF postal address with licenses URL
  include/libdecnumber: replace FSF postal address with licenses URL
  include/hw: replace FSF postal address with licenses URL
  include/qemu: replace FSF postal address with licenses URL
  util/rcu.c: replace FSF postal address with licenses URL
  hw: replace FSF postal address with licenses URL
  scripts: replace FSF postal address with licenses URL
  contrib: replace FSF postal address with licenses URL
  target/xtensa: replace FSF postal address with licenses URL
  target/i386/emulate: replace FSF postal address with licenses URL

 COPYING                                        | 5 ++---
 COPYING.LIB                                    | 5 ++---
 contrib/elf2dmp/pdb.c                          | 4 ++--
 hw/net/vmxnet3.h                               | 4 ++--
 hw/scsi/vmw_pvscsi.h                           | 4 ++--
 include/hw/i2c/aspeed_i2c.h                    | 3 +--
 include/hw/pci/pci_bridge.h                    | 4 ++--
 include/hw/timer/aspeed_timer.h                | 3 +--
 include/libdecnumber/dconfig.h                 | 5 ++---
 include/libdecnumber/decContext.h              | 5 ++---
 include/libdecnumber/decDPD.h                  | 5 ++---
 include/libdecnumber/decNumber.h               | 5 ++---
 include/libdecnumber/decNumberLocal.h          | 5 ++---
 include/libdecnumber/dpd/decimal128.h          | 5 ++---
 include/libdecnumber/dpd/decimal128Local.h     | 5 ++---
 include/libdecnumber/dpd/decimal32.h           | 5 ++---
 include/libdecnumber/dpd/decimal64.h           | 5 ++---
 include/qemu/rcu.h                             | 4 ++--
 include/qemu/rcu_queue.h                       | 4 ++--
 libdecnumber/decContext.c                      | 5 ++---
 libdecnumber/decNumber.c                       | 5 ++---
 libdecnumber/dpd/decimal128.c                  | 5 ++---
 libdecnumber/dpd/decimal32.c                   | 5 ++---
 libdecnumber/dpd/decimal64.c                   | 5 ++---
 linux-headers/LICENSES/preferred/GPL-2.0       | 5 ++---
 linux-headers/asm-arm/kvm.h                    | 4 ++--
 linux-headers/asm-powerpc/kvm.h                | 4 ++--
 scripts/device-crash-test                      | 3 +--
 target/i386/emulate/x86_emu.c                  | 4 ++--
 target/i386/emulate/x86_flags.c                | 4 ++--
 target/i386/emulate/x86_flags.h                | 4 ++--
 target/xtensa/core-dc232b/gdb-config.c.inc     | 5 ++---
 target/xtensa/core-dc232b/xtensa-modules.c.inc | 5 ++---
 target/xtensa/core-fsf/xtensa-modules.c.inc    | 5 ++---
 util/rcu.c                                     | 4 ++--
 35 files changed, 67 insertions(+), 90 deletions(-)

-- 
2.49.0


