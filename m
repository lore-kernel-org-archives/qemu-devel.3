Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8241090236
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3EgI-0007mU-Bw; Thu, 19 Mar 2026 10:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1w3EgE-0007m6-Vg; Thu, 19 Mar 2026 10:48:58 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1w3Eg9-0007ZP-Fk; Thu, 19 Mar 2026 10:48:58 -0400
DKIM-Signature: a=rsa-sha256; bh=vFrhAqEGGGAAUQkQfNi7nWVuFmtfTglkQkDzFWJ1NW8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1773931727; v=1;
 b=HPWGG85qTjQtcGF1LsECWSQ4V076Wpr82xKVtPZRhuiQ9vXh4F3FmltD9OSz9whYel0ytTkj
 8KagxMPfNiBSJbSy8CEp5l0rFlDT5bGbOVuv7WX6cyBQHZxhmlsrq4VlscmVorDJFQ1723ijIGD
 d+NxAtS5G0SIRQ0uWlcSp3uJQhQXQLO3kmFnU/PV6BqFVrfn4q3+GnrfWB8zPhzY473YWPf9mNN
 6bC2+PgeGTrdQO6lFoONS3ajpQSuObRhbXvXLZFweVIYqnvdi8fY91VxgAmLocHqPtkcjzhbneJ
 3IiQBEdFejbQ1azbZWee+f7gflQlO3RkGGh1Eum3Wq6zQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 3A5752065C;
 Thu, 19 Mar 2026 14:48:47 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Thu, 19 Mar 2026 14:48:47 +0000
Subject: [PATCH qemu 0/1] Update opentitan uart (part of supporting opentitan
 version 1)
MIME-Version: 1.0
Message-ID: <177393172713.10003.9577410064303581086-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Lex Bailey <lex.bailey@lowrisc.org>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-maintainers@lowrisc.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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


This commit is part of our efforts to get support for opentitan version
1 in qemu, it replaces the previous proposed change, and incorporates
some requests from review comments.

The changes are now being made in the existing opentitan machine,
instead of in a new machine. We have also avoided adding any new helper
units.

This updates the UART device to match our branch, and to match version 1
of opentitan.
This is not where we were going to start previously, but now this is the
easiest starting point.

This commit adds a file that is a substantial copy of code already
published under the MIT licence, and we aren't able to relicence it as
GPL. (unable to get unanimous author agreement)

Lex Bailey (1):
  Replace opentitan UART device with newer version (opentitan 1.0)

 hw/char/ibex_uart.c          | 569 -------------------------------
 hw/char/meson.build          |   2 +-
 hw/char/ot_uart.c            | 635 +++++++++++++++++++++++++++++++++++
 hw/char/trace-events         |   8 +
 hw/riscv/opentitan.c         |   3 +-
 include/hw/char/ibex_uart.h  |  73 ----
 include/hw/char/ot_uart.h    | 133 ++++++++
 include/hw/riscv/opentitan.h |   4 +-
 8 files changed, 781 insertions(+), 646 deletions(-)
 delete mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/char/ot_uart.c
 delete mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/char/ot_uart.h

-- 
2.49.1

