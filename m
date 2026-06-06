Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAA4CD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4T-00065D-1z; Sat, 06 Jun 2026 15:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4R-000645-05
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:39 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4N-00013v-8z
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:38 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 58EC67A0070;
 Sat,  6 Jun 2026 15:52:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 06 Jun 2026 15:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775553; x=
 1780861953; bh=2VeNkuSwTRHwnB48WGCYuIqYgfb69jJV67hR1HWKWEE=; b=n
 GfNzQlpC/tSDy9Ik0aJHwskar2tGzIr6eH9DNWnIacvT3O6ti0mMRdzOAW8eAa92
 QGxNAXc7zAHGNJMOZKAg4ehdEpPb8GIJ+fQ4zBx94sYKs2EArRXHxggSCL1/mjCl
 8j3UXDKIooBPnVmzxY0X6Wo6Fvx8gTpxAXpDRZSba0L77iD9WUNFd0gGOADrn0ti
 5fydspVVsL35Fi54Eg5RY14R2Conlu00venfVqqnDxya1OxeBqex+EuKRiQTterc
 WtycxjMPZNqockTuURKeOVOY9JqpEqOu35szlgfMPW6NPUEmcUyYI4+X0GaJ+coL
 fFDdHdIKnneVmlPCI/Tqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775553; x=1780861953; bh=2
 VeNkuSwTRHwnB48WGCYuIqYgfb69jJV67hR1HWKWEE=; b=haqHawQG/hxI8z2xc
 0Z9FnNh0V2Lqp2CrJgQ4YKQPl/Pg47rgJJXdY1wrG/Ma28Ez6/Lri+j0IDG/rQNv
 VH2aPBq3VaoNONG1IjeVrKacodbHrSLLfUqS4MhsiY/F2Ekup8EHaIbJ+O1W8AjL
 4/ltHdaHt1RB6Fl3N8S8eZLmgFZxH3lcOUb0JpHjimvo/vHxLnMzM3CRVypowQXL
 G+sce4lDogcAowyZG5I/T/iQt0Ywgypp3Jb9A1zEcilUJGdX5l1DQW3EphwIibHo
 cnzcud7MncNJlGKmorBRqUuBdA8gmzhrqa3jx7SvBkM9SJEXsyBbj7qrCpE3EcEl
 vPqIw==
X-ME-Sender: <xms:gXokasDQ_8FOYXDfwy1wOrRqNhulGZxNzb4vwUJQP8O58tESxiKqsg>
 <xme:gXokal9ZShLIAGdv5ZwNl7dp2vrWWi4Gq71EUDFxNC8zzLWTjpdv5JX4BMP462LRU
 MEj4hE5Vazgn1PP3qQX9qVGhibf2EhL_2tAJcNTaLqDlHDB9hBsmrc>
X-ME-Received: <xmr:gXokas9vBZBf-Lvmmp2a2IHsapWnVBCRllJBIOUtPFHO41ugeCtIsIGqnqFz>
X-ME-Proxy-Cause: dmFkZTF5V5TJt4YyOidEvSaeu/MRla4xP+DmdZQhB39MOi6suQo+ewwhopiobLPZpZFZya
 cAlJGIfDtnd9YI9euUev0/BPlhx7gFnO282gf6qihxTXQ9XGsNSFgetoCcqBrBvyjHrANh
 atTdGgjKUldYBX7wk7l0Cl09WJIHvldYLH4ZomEKYEpVZT82+Oh5snshv7XK6+9Sb5cWbw
 e84vQB5olzLLZrdcgzNge+k12PyvF6W544E61zazKBZo950akvs+WrgTOdnqD9gQaa29eu
 Mvbl6jhgYAGUnVDqLD0fWkRRImSA3/gMsTXu4gQwDYtEjGvTqg8SUjhCR0pAYP3BvhiEAH
 Zie9i8A4J39iZopFcKMgWMcRg64QDG9jeXSZVNau0p5n2Wwa2m4Ea3TOEVhCwfzD58lUR4
 tIFvqCDlxSR6VfEMsecSo/Y9bA1m1eiAWyJYnHy4ibN1etgzzUOBcNn3fqouJiER+tU0jR
 Ccxp2VNSdSw30dwskYq0sACNwvjfV2J50r3g2ETtw7YY3k9YqD7T/8oPXhBHnqXdREySoO
 R22KgaUXNf1zUuY4H1lvoN/3ikgLqrlaikNEMn8NJyG7pqQ9hR3dZqvUsM9d8TWHagITix
 Ou7qHKXpnQ8Y6oXoalZOWfoCj1IuQ08Ln0h+WW8G7o3qXVjC3B+3vqJlN+qQ
X-ME-Proxy: <xmx:gXokascYY7JQi-9I2L31LEcQ9ca6AgYHD1kLsyboVhmxOCe5ZCBQOA>
 <xmx:gXokalHSSdDarWpb5-HiJhO-nP99TVb1YL-6AB08BN3PXsYFf09SrQ>
 <xmx:gXokaqfToC3PaqssZT1N5DSvfmNi5x3nzsN_2CWz0SPWgMwGKu7pCw>
 <xmx:gXokavExaUmjuRYiRRZp0M18O6IGxzop_QYHfQ7OU1LbdGASdDd4ZQ>
 <xmx:gXokaqJ1Nz9LutD5tpHsKAak_eimWCxbz-438Wc4YoRuvlYjQHXE0zNU>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:32 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 90b1e46c;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 3/7] ati-vga: Implement CCE microcode register handling
Date: Sat,  6 Jun 2026 15:52:12 -0400
Message-ID: <20260606195216.2524314-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606195216.2524314-1-chad@jablonski.xyz>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Implement registers used for loading and reading microcode for the CCE
engine. Loading the microcode is the first step for any driver
implementing CCE. Reading, while not used by drivers, is very helpful for
any reverse engineering and testing work. The microcode is currently
stored but not used. This lays the groundwork for future RE work on the
microcode.

There's some quirky behavior around microcode reads that isn't
documented elsewhere. There appear to be two internal pointers, one for
reading and one for writing that can get out of sync. Comments in the
code expand on this.

Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
Radeon QY (RV100) (PCI 1002:5159).

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h | 11 ++++++++
 2 files changed, 72 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 826c856b1c..73fd5e7d23 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -579,6 +579,36 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Read from write-only register 0x%x\n", (unsigned)addr);
         break;
+    /* r100: CP_ME_RAM_ADDR */
+    case PM4_MICROCODE_ADDR:
+        val = s->cce.microcode.addr;
+        break;
+    /* r100: CP_ME_RAM_RADDR */
+    case PM4_MICROCODE_RADDR:
+        /* Always returns 0. Tested on hardware. */
+        val = 0;
+        break;
+    /* r100: CP_ME_RAM_DATAH */
+    case PM4_MICROCODE_DATAH:
+        val = (s->cce.microcode.microcode[s->cce.microcode.raddr] >> 32) &
+              0xffffffff;
+        break;
+    /* r100: CP_ME_RAM_DATAL */
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
@@ -1087,6 +1117,37 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
             ati_host_data_flush(s);
         }
         break;
+    /* r100: CP_ME_RAM_ADDR */
+    case PM4_MICROCODE_ADDR:
+        s->cce.microcode.addr = data;
+        break;
+    /* r100: CP_ME_RAM_RADDR */
+    case PM4_MICROCODE_RADDR:
+        s->cce.microcode.raddr = data;
+        s->cce.microcode.addr = data;
+        break;
+    /* r100: CP_ME_RAM_DATAH */
+    case PM4_MICROCODE_DATAH: {
+        uint64_t curr = s->cce.microcode.microcode[s->cce.microcode.addr];
+        uint64_t low = curr & 0xffffffff;
+        /*
+         * DATAH mask is one bit wider on r100. Avoid duplicating otherwise
+         * identical handlers for r128 and r100
+         */
+        uint64_t high = (data & (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+                        0x1f : 0x3f)) << 32;
+        s->cce.microcode.microcode[s->cce.microcode.addr] = high | low;
+        break;
+    }
+    /* r100: CP_ME_RAM_DATAL */
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
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 18dca730c3..eae3e89617 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -105,6 +105,16 @@ typedef struct ATIHostDataState {
     uint32_t acc[4];
 } ATIHostDataState;
 
+typedef struct ATIMicrocodeState {
+    uint8_t addr;
+    uint8_t raddr;
+    uint64_t microcode[256];
+} ATIMicrocodeState;
+
+typedef struct ATICCEState {
+    ATIMicrocodeState microcode;
+} ATICCEState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -125,6 +135,7 @@ struct ATIVGAState {
     MemoryRegion mm;
     ATIVGARegs regs;
     ATIHostDataState host_data;
+    ATICCEState cce;
 };
 
 const char *ati_reg_name(int num);
-- 
2.53.0


