Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8DA10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYX1-0001JJ-D1; Wed, 08 Apr 2026 15:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wAY7X-0007k6-0C; Wed, 08 Apr 2026 14:59:23 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wAQmk-00035r-6R; Wed, 08 Apr 2026 07:09:29 -0400
DKIM-Signature: a=rsa-sha256; bh=KlR/xKoP61qzgFLUnyAa73Pb9AfwGBhgmoS7vXNN5Ko=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1775646439; v=1;
 b=aDQA5PmVYnRB727xlZGgImNavpV5CwEGHn3HknW2drPVNs3YQHno6biDANIfF5SHGKtAeD92
 90D56OMvWmj29NNWyqEaroepJ3UZuYkPIPTPlYeC88qRQjCXQyXh9TbdZFipfNaMasEYKtgp3gR
 jWLVmB10LzHRs/ac+7KXi1rzxUzMaideZVsk1Rx3IIpgqUDunAiRH0L/QGpZ5DOWkepiHoZKrf+
 DtmFnrb92puLy/CX6kt2+F9SuxecfOVaB0glQKVhazxtyhDFo5+P8+TNOFpCYbQDjRfB6DmzP1x
 defzld9X0Do9NGiEQ1zfIbExxKvfeBj8BtE3KymounYhQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 15017207F4;
 Wed, 08 Apr 2026 11:07:19 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Wed, 08 Apr 2026 11:07:18 +0000
Subject: [PATCH qemu v2 0/7] Update opentitan uart (part of supporting
 opentitan version 1)
MIME-Version: 1.0
Message-ID: <177564643888.23414.7922925369077631439-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Second revision of the patch set that updates the OpenTitan uart to
version 1

I have made changes as per the review comments from last time. This is
now split into smaller commits. The first renames ibex_uart to ot_uart,
and the rest introduce the various changes step by step.

The details of the version 1 of the UART are found here:
https://opentitan.org/book/hw/ip/uart/index.html
(This URL is added to the file header in one of these commits)

The changes, as split across these commits, are: switching to new reset
api, updating the register and field definitions to match the latest
version of the UART, adding the missing IRQs required for the latest
version, implementing the features the various hardware features that
were missing.

Finally, I have also updated the file headers and added the tracing
changes.

Lex Bailey (7):
  Rename ibex_uart to ot_uart
  ot_uart: move to new reset API
  ot_uart: update register defs, switch to Fifo8 for tx/rx buffers
  ot_uart: replace individual IRQ fields with array, add missing IRQs
  ot_uart: implement missing features
  ot_uart: update file headers with new authorship and documentation URL
  ot_uart: add tracing

 MAINTAINERS                  |   1 +
 hw/char/Kconfig              |   3 +
 hw/char/ibex_uart.c          | 569 ---------------------------
 hw/char/meson.build          |   2 +-
 hw/char/ot_uart.c            | 741 +++++++++++++++++++++++++++++++++++
 hw/char/trace-events         |   8 +
 hw/riscv/Kconfig             |   1 +
 hw/riscv/opentitan.c         |   3 +-
 include/hw/char/ibex_uart.h  |  73 ----
 include/hw/char/ot_uart.h    |  61 +++
 include/hw/riscv/opentitan.h |   4 +-
 11 files changed, 820 insertions(+), 646 deletions(-)
 delete mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/char/ot_uart.c
 delete mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/char/ot_uart.h

-- 
2.49.1

