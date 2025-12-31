Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5BEEE645A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 21:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb3dR-0000rN-W3; Wed, 31 Dec 2025 16:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dL-0000pg-9a
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:33 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dI-0003ht-RY
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:31 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 178BE140004A;
 Wed, 31 Dec 2025 16:21:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 16:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767216087; x=
 1767302487; bh=OI8WnzWIVeXiJRW3YtmlUBe4/95BHsFFTDuGNHEnk4U=; b=X
 BfH0m6HhPjRO5R8WDQM2f/bzGZAU2bcZxEljb09LZAhNjB7k2Z/yni4WFbDwNVL7
 fMZnohtwa1QsJhMQgrSgms8GYJdfqG6b+IoePynuQb3LBKgfKijlOn/CUkK7GnKz
 V6DDCpO8xQUenQx5gw/Xt0VLOYXUeDru1AD+Q+m7YTFDWghnC1dQ3GjPiWGGMkmR
 QyWacrUvhloKhsfTv91K3jtAbg+ED7QEGepZhs+DFPD2gbVKZ3TFSycT4fxR2YKu
 Tt9+E1bEZmjPfnQYFDZy/PijIwFUobfb4Wuh90jpiV1gY4PLj2QG+KrCx3mcnbpf
 dohEH1LXVJDfFmRfIe6sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767216087; x=1767302487; bh=O
 I8WnzWIVeXiJRW3YtmlUBe4/95BHsFFTDuGNHEnk4U=; b=TdcWRQEBs1OmlGkKl
 EH14P7ee+ZHirUl+XYiBt9WU5FCSzMO4/nC/D5cmL+zhygatqRQIVlknRwJESH0b
 C0LGvP1dUvjvZq7NiEBu0tlad8GjFZbVgcfz3tJ5RqDzUWvh4XOzd8312EC3Thmh
 J+q0njP9jSX/LFNwVmgLtMU4UQIRyUj7NYSXwnm7sAVc9rsMPT34hLNc7cgauwss
 T0tELvCTbM9lNQGY0/nRYqH8FoJ1alwlYhYE/7uxKVvz51EAoHtIW1WFuepxKC8D
 /e1jwY9PfzrqFcptpkeQ1A66ZC1gf4AI2n8y8JBgRREx3h//gqLonE9A9PM7dRGX
 g0hUQ==
X-ME-Sender: <xms:15NVabNSyQ2bw24DttCnHaRujfNmX0UYG9xHldRLWYh0UcMi8QGdFg>
 <xme:15NVadb_2ueyHTbb5chFvyJuRqhgaD8pT8nbE6SzHUJO540__DKBajg7dphggEfrA
 kiXkWOEbF-4qz8wi_NozivLj0r1RgmsXI9zroLiyP7vBH_LYdEmIhs>
X-ME-Received: <xmr:15NVaXo63xsZlRTfQOYy-QKQabMiKJnNl7qtNJ42sxGFYPNpFA-8pKNekPMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeliecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtth
 hopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgr
 sghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:15NVaZYF2An44fd1u5OqZyLcsKkQmo2U3Px2PdYTdlrulEa5Atzupw>
 <xmx:15NVaXSgqOodLTPKq4sl7FcucwNWTa1pJ1SZuHXvgwKrQ6NS_x3Sog>
 <xmx:15NVaY4KdvcUNoGpEN2jo1bW86uXXb7v1d8iZSZaPj9ESr7m_JHL6g>
 <xmx:15NVaUwcebfEv2q2L59HRuiwaJWqfBMjQAX6UzaRxWFgGAgRSVLbzQ>
 <xmx:15NVaeFLX45onGpbLDhP3reKbdlKAhayQG-lqy63qJuKZJELtw1qZHhL>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 16:21:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 84d6c871;
 Wed, 31 Dec 2025 21:21:25 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 2/7] ati-vga: Implement CCE/PM4 microcode register handling
Date: Wed, 31 Dec 2025 16:21:02 -0500
Message-ID: <20251231212107.1020964-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231212107.1020964-1-chad@jablonski.xyz>
References: <20251231212107.1020964-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a8-smtp.messagingengine.com
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
index f9be5b302c..bac0ceaa79 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -535,6 +535,31 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Read from write-only register 0x%x\n", (unsigned)addr);
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
@@ -1052,6 +1077,28 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         ati_flush_host_data(s);
         ati_host_data_reset(&s->host_data);
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
index 3ee891c888..416275ae0d 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -16,6 +16,7 @@
 #include "vga_int.h"
 #include "qom/object.h"
 #include "qemu/units.h"
+#include "ati_cce.h"
 
 /*#define DEBUG_ATI*/
 
@@ -123,6 +124,7 @@ struct ATIVGAState {
     MemoryRegion mm;
     ATIVGARegs regs;
     ATIHostDataState host_data;
+    ATICCEState cce;
 };
 
 const char *ati_reg_name(int num);
-- 
2.51.2


