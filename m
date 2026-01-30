Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A517EE6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppO-0004iz-Gf; Fri, 30 Jan 2026 09:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppM-0004hK-8Z
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:28 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppJ-00037L-1f
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:27 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 4AC7B1D0012E;
 Fri, 30 Jan 2026 09:50:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Fri, 30 Jan 2026 09:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784624; x=
 1769871024; bh=OB+Y5ldVrvbwaTQUotUJwNjbQKQjghNXkQgvaG0C/dk=; b=e
 AFA3q1GySW6oIsRN3Sk2Tx+zzAqnhIgotkuE8AScivZ5/8X8/tJUhm2Umsejm/Kl
 cBrHkoMBFv1JtzmqXwnzfIzDxrBDOF0G0QBi6BlPgWes+moASejQHJAWsh4Mph+a
 SYpShYpSltCbx8zVlrWfUQxtIzpI4lALMLyJA6zKf+sHsCZS/MhrSYq4PB/LS2Pl
 +qyo5Vg1qdO5kBF545x5Dpk9IxRKxvXLU7ytLquEYDBBMPaJ8nppVnusPpvXiZXB
 VTaIi040OxO/hTgO2Ax16dT1uYABAJXe+7r2m/y0c3bF+m4bBMWVjND6/+nr6cw8
 Q2wyR5V7157rzxqGa5yVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784624; x=1769871024; bh=O
 B+Y5ldVrvbwaTQUotUJwNjbQKQjghNXkQgvaG0C/dk=; b=izqJZsi8AnCIS7SZW
 4mCHgs15x/og1WPUNglus9yQaywrTv6mSk2Qv2vpkFjaqD+9RaonZ3YyfEGAsHLm
 opeA0ERxO8xmWa54UklfrwXHWb1wtF9KzcwOtVGKxiF2II+GRVs9ngbqM5E/xe7K
 j+D9MM0AEWT0Nl+z40pIutm8rg+gV1J3J3uW04y7y4fiiitI59FIOpCG3wJwfhIm
 k0cVItYwg8QQ3kUSxPCGc3mHHzXFpqAcVGCWshG3yHA94/5ecI9DHQ/4zuXXvl/A
 hdzUfyJfN9WDE0Fb1Isf4eSe7O0dNioZtesUznfh0TI7CjwlccYC80r6pE2Ly7O8
 nsTPQ==
X-ME-Sender: <xms:L8V8ae2AZ4Y_h7BojmJ10zB_ackUngEzBrSEjREYXxt_7bG2LdgYjg>
 <xme:L8V8aYjKNEqBleZXcxO-CvLKNvHHDEw4AJ64Lc3zXiYZVMnqLUL6UptygKhfU_dQ2
 judHGeAiBrFR22aFLun-Su2Sn7JI0IlDaZMoD4YFuk1jfmRMXbNwQg>
X-ME-Received: <xmr:L8V8aUR0TuDBSMhKx1CrTnZ3NHbEJjYCfWKF9kMAXWIjJmJl1BCHnxvRWQWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:L8V8aZgcVw3vxHNztyVmYJoAyXeGmy4wXbY6wRyzZtSkE0tVaCBxBw>
 <xmx:MMV8aU44SYi7Uo1wWOd5j96WAnRxB17CCfPXdzPToXW0idTVylb5cw>
 <xmx:MMV8aWCOPGZnFOBsymn5Ow1RPCQ_LrpapbiBhrffXesI72nytjiCLg>
 <xmx:MMV8abboBd4Wv_1HALPF6aI7W_NpUoe6Po-APUnY7tN1WBnkW1RcLQ>
 <xmx:MMV8aQPKtMAs9GAygVQ6iLFLTIGabQWrJ_tG6ceXaD5uwYUw_u40PETZ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:23 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 42ce9045;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 08/20] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
Date: Fri, 30 Jan 2026 09:49:53 -0500
Message-ID: <20260130145005.731129-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Both supported ROPs follow the same memory set dirty logic.
This consolidates that logic to remove the duplication.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cfc7bf9789..846f83e747 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -166,14 +166,6 @@ void ati_2d_blt(ATIVGAState *s)
                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                    s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
-        }
         break;
     }
     case ROP3_PATCOPY:
@@ -216,18 +208,19 @@ void ati_2d_blt(ATIVGAState *s)
                 }
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                    s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
-        }
         break;
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+        return;
+    }
+
+    if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+        dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
+        memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
+                                s->regs.dst_offset + dst_y * surface_stride(ds),
+                                s->regs.dst_height * surface_stride(ds));
     }
 }
-- 
2.52.0


