Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA40F9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChSH-0005tR-KS; Tue, 14 Apr 2026 13:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChS9-0005rs-G1; Tue, 14 Apr 2026 13:21:33 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChS7-0007Hq-Pr; Tue, 14 Apr 2026 13:21:33 -0400
DKIM-Signature: a=rsa-sha256; bh=P8dgVOGwTlEde/3soL3XZGyks4q2sUF3UObCz6fViOM=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1776187285; v=1;
 b=TvEjlW9LgT25aHBuuayjD/sa/m4JRYmrCBecaoN/NRejvH1beJdliiZXg5TIaOmjlCHE+Xe5
 dF0pbzyQCZr1nuXcacAgb60m0zwWc0Zih8+O7BhQFeO/Y9j159Nfp5kt+N6yDYqisj/sJbzAQKy
 qo4iZAZGcPMQknMreIt+zCZlhLN9ZWMmaGZnwU6FGXbCAYwCf1neYwVaxpVRpRi2fU50fz4I9BV
 ipVXSUKk/RyKsRKi+qVFiKyuhQYE3e92e3BEgra0jLyI7DE9etjXJ+7495va2e7woVY+ZFhHkw6
 MeWt+xLkAGxnG8+OicmacsqiZ/SLf9QrDuN4rfh2ulMtg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 8020120A30;
 Tue, 14 Apr 2026 17:21:25 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 14 Apr 2026 17:21:25 +0000
Subject: [PATCH qemu v3 00/10] Update opentitan uart (part of supporting
 opentitan version 1)
MIME-Version: 1.0
Message-ID: <177618728515.4917.14466194789826252277-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
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

Thanks for the review comments again!

this is the third revision of the patch set that [starts to] update
the OpenTitan uart to align with earlgrey version 1.0.0. I can't really
give a specific commit hash, but the there is a branch on the opentitan
repo which represents this version:
https://github.com/lowRISC/opentitan/tree/earlgrey_1.0.0

I can't give a specifc hash because these changes do miss out two
important parts of the UART device. The clock manager is not yet present
in upstream qemu, only in the lowRISC fork, so for now it is not
connected here. The other issue is that the alert handler block is
missing, and thus the alert test feature of the UART will not work. This
can only be fixed after the alert handler is also upstreamed. that will
come later.

as before, the details of the version 1 of the UART are found here:
https://opentitan.org/book/hw/ip/uart/index.html
(and this URL is still added to the file header in one of these commits,
as before)

I have now split up that large commit into logical steps, which included
splitting out that change that removes the timer. You commented on this
in the last revision. I have put this commit last because it's not
strictly required yet. It is a change that is included on our own fork,
and will be needed when we add the rest of the clock handling from our
fork. For now though, you can take or leave it as you see fit. I'm happy
for this patch set to merge with or without it.

I think I fixed all the other comments too, sorry if I missed anything.
Thanks,
Lex.


-----
Lex Bailey (they/them)
lowRISC C.I.C. 7 Hills Road, Cambridge, CB2 1GE, UK. Registered in
England & Wales 09272283 lex.bailey@lowrisc.org

Lex Bailey (10):
  Rename ibex_uart to ot_uart
  ot_uart: move to new reset API
  ot_uart: update register defs, switch to Fifo8 for tx/rx buffers
  ot_uart: replace individual IRQ fields with array, add missing IRQs
  ot_uart: gather similar behaviours togeter in register read and write
  ot_uart: implement RX fifo and loopback
  ot_uart: handle break condition
  ot_uart: update file headers with new authorship and documentation URL
  ot_uart: add tracing
  ot_uart: switch from clock driven transmission to reg R/W driven
    transmission

 MAINTAINERS                  |   1 +
 hw/char/Kconfig              |   3 +
 hw/char/ibex_uart.c          | 569 --------------------------
 hw/char/meson.build          |   2 +-
 hw/char/ot_uart.c            | 759 +++++++++++++++++++++++++++++++++++
 hw/char/trace-events         |   8 +
 hw/riscv/Kconfig             |   1 +
 hw/riscv/opentitan.c         |   3 +-
 include/hw/char/ibex_uart.h  |  73 ----
 include/hw/char/ot_uart.h    |  61 +++
 include/hw/riscv/opentitan.h |   4 +-
 11 files changed, 838 insertions(+), 646 deletions(-)
 delete mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/char/ot_uart.c
 delete mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/char/ot_uart.h

-- 
2.49.1

