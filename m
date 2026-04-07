Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D2AF9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChSJ-0005v9-MO; Tue, 14 Apr 2026 13:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSE-0005sU-8r; Tue, 14 Apr 2026 13:21:40 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSB-0007Km-IP; Tue, 14 Apr 2026 13:21:37 -0400
DKIM-Signature: a=rsa-sha256; bh=PlhA+f2IZd8IcCVPTtjXpKLc7zQX/PWU3bGKcmfeaoo=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1776187286; v=1;
 b=bONWszH4bPsmkZVggR2/HXX05iKpe0UN7E0iR4Dq/8dfunv6piZavjwbkYsxRYYLEMDI9W1I
 v35X92xmujPsSghdaOC50PpOiOY6uSCGuZqbAFnW6/d8l629NzzV1ikLcboOv9XExjNUKoK3or3
 dmMnL4kqva+WUgv4iv/f7jriFQW02pBCRmYplne+O3ikgDaMmxtVqaZWpWB/fcIxqguM19LsksD
 c3xwYjoIPL0m/eVK/j4j8H/Ky4GQktf7zDtHDflGiKjvYI0bxuTJ8qspL5m3nu/GaCq01/12B7M
 RZa9kvQMWHG6QXHoH8naavRZaWmWkCNQYJNWAP7bwjMvA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 8565520A3C;
 Tue, 14 Apr 2026 17:21:26 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 15:11:43 +0100
Subject: [PATCH qemu v3 08/10] ot_uart: update file headers with new
 authorship and documentation URL
Message-ID: <177618728515.4917.14466194789826252277-8@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177618728515.4917.14466194789826252277-0@git.sr.ht>
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
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Lex Bailey <lex.bailey@lowrisc.org>

The documentation has moved, URL updated.
This file is now a combination of code from various people/organisations.
Took the opportunity while editing this to switch to just using
the SPDX ID.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 24 ++++++++----------------
 include/hw/char/ot_uart.h | 25 ++++++++++---------------
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index cdf02da62b..d00f7bee66 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -2,27 +2,19 @@
  * QEMU OpenTitan UART device
  *
  * Copyright (c) 2020 Western Digital
+ * Copyright (c) 2022-2025 Rivos, Inc.
+ * Copyright (c) 2025-2026 lowRISC contributors.
  *
  * For details check the documentation here:
- *    https://docs.opentitan.org/hw/ip/uart/doc/
+ *    https://opentitan.org/book/hw/ip/uart/doc/
  *
- * Permission is hereby granted, free of charge, to any person obtaining a c=
opy
- * of this software and associated documentation files (the "Software"), to =
deal
- * in the Software without restriction, including without limitation the rig=
hts
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
+ * Author(s):
+ *  Alistair Francis <alistair.francis@wdc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *  Lex Bailey <lex.bailey@lowrisc.com>
  *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
+ * SPDX-License-Identifier: MIT
  *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING F=
ROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
  */
=20
 #include "qemu/osdep.h"
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index 997bf2f367..4dc51142f7 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -2,24 +2,19 @@
  * QEMU OpenTitan UART device
  *
  * Copyright (c) 2020 Western Digital
+ * Copyright (c) 2022-2025 Rivos, Inc.
+ * Copyright (c) 2025-2026 lowRISC contributors.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a c=
opy
- * of this software and associated documentation files (the "Software"), to =
deal
- * in the Software without restriction, including without limitation the rig=
hts
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
+ * For details check the documentation here:
+ *    https://opentitan.org/book/hw/ip/uart/doc/
  *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
+ * Author(s):
+ *  Alistair Francis <alistair.francis@wdc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *  Lex Bailey <lex.bailey@lowrisc.com>
+ *
+ * SPDX-License-Identifier: MIT
  *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING F=
ROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
  */
=20
 #ifndef HW_OT_UART_H
--=20
2.49.1


