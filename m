Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05C7EE57CE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9ob-0002Gc-Ug; Wed, 31 Dec 2025 22:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oa-0002FU-8X
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oY-0003iI-8X
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5E5707A008F;
 Wed, 31 Dec 2025 22:57:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 31 Dec 2025 22:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239849; x=
 1767326249; bh=1/oQvf+7oFxMlLhS7xldh1B7Xf0xiDTcW0n9KdiVD7A=; b=A
 dBLFivlpcUhXnCSG15WQE5B466tPty38JrMrbWDEYJGOXO4OEo2/7tljD9xS4DZX
 lsh/Jjeg2JhTY6qeZDnHMx+A0zuN4MWdsJeOyaLy6cSfrml9pZt+gTT2fChjEXvL
 rHbx1+pxWVIKeC3swfbczSKQNx7RTDscghKY/EvmO9WlCVYoErkEDlQupz7g/sQh
 qPuWMQhIihGegJa7ovp8BfM5QpMJV81kDL4jHoywZWehLXg9ifArctKLuOdlPOzV
 x08vbnMT0DytpoTvM0UHRThyCbE+CieyizoHjiAdokOfVtNFr4W1qDhDd488ZMzw
 7bMOLR+UbQkw5jdjH0/Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239849; x=1767326249; bh=1
 /oQvf+7oFxMlLhS7xldh1B7Xf0xiDTcW0n9KdiVD7A=; b=riugsOYB8ukZCRFUl
 rsaX2T7b3eW5dnUpaVIUYWnutVcZWdfnl163l2GZxw08F6sXhb6yMOtYNY1X9PGv
 W0brtfTBSVxnP1aXPw45cue5tSXeEOzhd+ef3+zWtdfdnBGgairElY7v5puI2i6R
 s1+wrCSKy0CnxqCDY+PM3r2mbbT2zlB8P3kBHxaL4wPWnUZxM7d0EhjeeqGzA7Re
 2+ZBXZIGgySwfcZpHm7hd+OhEJmpQZwBsy62TVPirl3w6JHeCYYnYWmjImOYqGFV
 AbdY0ZB3qKI1OP4IFp9sN0msmWa0927w2pg4LyuaRBKu/0a4BccGnINExBhQOFKv
 8zNyQ==
X-ME-Sender: <xms:qfBVaTsQM_zhnTLHPMUU9uDhUQhGQIvMVzW4rl_u8sI5wiP5OSX3Qg>
 <xme:qfBVab7iiBTNMot44cL7H920GnWfxwyMmXwzetR7Wvkn6whflfLUI4YPnxj3r3zj9
 4Fb-R9WO1ZUpqIZeC6O48N64Tb8fejgdd3SE9m5WbkKtWAF8ke01K8>
X-ME-Received: <xmr:qfBVaUJHpblxGPFSX3YPniiq9Ad1C8qI8f_L-VT9Xa08_zGHAN6WhEQT-dpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhn
 segvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:qfBVab4mB1-aqTEvmNZ85rdP5HXf1aYoCFIdhqzXM5NMpldmkj9Erw>
 <xmx:qfBVaXyuY8hwdtSJPQOgkCKuB-kb5-TcItdy2CzDJ8tDdgdYyaQFyQ>
 <xmx:qfBVafYzFk4zLeVxkXTD7bfWRpRIZHC9__62nY7ni5Ex0TII1BWu1A>
 <xmx:qfBVaZQtvtqYFPmPtT-0jMaaESoWbNLFsOjHytGmMuYfWCOFy8RQow>
 <xmx:qfBVaYlLpa10Ry9Sen-_l4CUQ2LrPSaLGpgHaxwst8O3WsrcCCxXJY07>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:28 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id cf25ce26;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 2/7] ati-vga: Implement CCE/PM4 microcode register handling
Date: Wed, 31 Dec 2025 22:55:50 -0500
Message-ID: <20260101035555.1300511-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Implement registers used for loading and reading microcode for the CCE
engine. Loading the microcode is the first step for any driver
implementing CCE. Reading, while not used by drivers is very helpful for
any reverse engineering and testing work. The microcode is currently
stored but not used. This lays the groundwork for future RE work on the
microcode.

There's some quirky behavior around microcode reads that isn't
documented elsewhere. There appear to be two internal pointers, one for
reading and one for writing that can get out of sync. Comments in the
code expand on this.

Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446).

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 47 ++++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_cce.h | 26 ++++++++++++++++++++++++
 hw/display/ati_int.h |  2 ++
 3 files changed, 75 insertions(+)
 create mode 100644 hw/display/ati_cce.h

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 33f8e211dc..e291926470 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -510,6 +510,31 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DEFAULT_SC_BOTTOM_RIGHT:
         val = s->regs.default_sc_bottom_right;
         break;
+    case PM4_MICROCODE_ADDR:
+        val = s->cce.microcode.addr;
+        break;
+    case PM4_MICROCODE_RADDR:
+        val = 0;
+        break;
+    case PM4_MICROCODE_DATAH:
+        val = (s->cce.microcode.microcode[s->cce.microcode.raddr] >> 32) &
+              0xffffffff;
+        break;
+    case PM4_MICROCODE_DATAL:
+        val = s->cce.microcode.microcode[s->cce.microcode.raddr] & 0xffffffff;
+        s->cce.microcode.addr += 1;
+        /*
+         * The write address (addr) is always copied into the
+         * read address (raddr) after a DATAL read. This leads
+         * to surprising behavior when the PM4_MICROCODE_ADDR
+         * instead of the PM4_MICROCODE_RADDR register is set to
+         * a value just before a read. The first read after this
+         * will reflect the previous raddr before incrementing and
+         * re-syncing with addr. This is expected and observed on
+         * the hardware.
+         */
+        s->cce.microcode.raddr = s->cce.microcode.addr;
+        break;
     default:
         break;
     }
@@ -932,6 +957,28 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
     case DEFAULT_SC_BOTTOM_RIGHT:
         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
         break;
+    case PM4_MICROCODE_ADDR:
+        s->cce.microcode.addr = data;
+        break;
+    case PM4_MICROCODE_RADDR:
+        s->cce.microcode.raddr = data;
+        s->cce.microcode.addr = data;
+        break;
+    case PM4_MICROCODE_DATAH: {
+        uint64_t curr = s->cce.microcode.microcode[s->cce.microcode.addr];
+        uint64_t low = curr & 0xffffffff;
+        uint64_t high = (data & 0x1f) << 32;
+        s->cce.microcode.microcode[s->cce.microcode.addr] = high | low;
+        break;
+    }
+    case PM4_MICROCODE_DATAL: {
+        uint64_t curr = s->cce.microcode.microcode[s->cce.microcode.addr];
+        uint64_t low = data & 0xffffffff;
+        uint64_t high = curr & (0xffffffffull << 32);
+        s->cce.microcode.microcode[s->cce.microcode.addr] = high | low;
+        s->cce.microcode.addr += 1;
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
new file mode 100644
index 0000000000..f2ef1345de
--- /dev/null
+++ b/hw/display/ati_cce.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU ATI SVGA emulation
+ * CCE engine functions
+ *
+ * Copyright (c) 2025 Chad Jablonski
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ATI_CCE_H
+#define ATI_CCE_H
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+typedef struct ATIPM4MicrocodeState {
+    uint8_t addr;
+    uint8_t raddr;
+    uint64_t microcode[256];
+} ATIPM4MicrocodeState;
+
+typedef struct ATICCEState {
+    ATIPM4MicrocodeState microcode;
+} ATICCEState;
+
+#endif /* ATI_CCE_H */
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index ea1a8bceab..ed6307151b 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -14,6 +14,7 @@
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
 #include "qom/object.h"
+#include "ati_cce.h"
 
 /*#define DEBUG_ATI*/
 
@@ -100,6 +101,7 @@ struct ATIVGAState {
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
+    ATICCEState cce;
 };
 
 const char *ati_reg_name(int num);
-- 
2.51.2


