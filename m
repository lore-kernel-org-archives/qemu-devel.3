Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635C6EB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7dx-0006Np-Rg; Mon, 02 Mar 2026 13:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7di-0006HQ-Vb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:09 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dh-0006Xk-7z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:06 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id ABBD4EC0608;
 Mon,  2 Mar 2026 13:05:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 13:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474704; x=
 1772561104; bh=/8gQrPLmCC6i3JQzdW1xashObqgDvg5nx94NGxDJ1P0=; b=e
 Txm0W4E5qqvwMJOLmyGNknjlrkmefVjDNuKAJR4YIYPllKTHlSOVylVYX0yvdddB
 TByx5fxTaJl8HYBHISJatekLZH7+zaKOVfvyUtIDynoG6MX4liqWVNvyMKrIWggh
 wgJKT+Pyu6Bf8xfhqVvfMhA/0aZXFGkwE6RZ5V2IiBS2ipNuW1IUCkmJU5eTQ8st
 Sr9bQd+kn1O3AFX5Fnx60EQlReM/8JqVRC5lxLrV7R2wR0Tor6H1FB4VvfYHNobQ
 iUmcB5dfJ4o0mKtT4RZ7+0IOEmiftN++dQjxp2l4fGAvUnJUoLQyzqgB0LpPwHWK
 /Fljz+dlVdXxGGq4RySQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474704; x=1772561104; bh=/
 8gQrPLmCC6i3JQzdW1xashObqgDvg5nx94NGxDJ1P0=; b=O9x1774GabFlqqwQs
 Zamp/sqz2gZc55ovGah3Ch+i8rKfWSxDsiV2Wv3W7+T6inq4+LQEPyf20DFmpAXN
 1R6ONDxNcCICCQgVgh1kIAcM7FHhBe6XX5LECW5pAVeg7M0ZbTx9+FRDs4EwQEF/
 zNS2vPHEkC9T8zj90MmuWh9BO7/LuKOU2P+tA1MQZrMcfISNZmxWhNCFB8Vet5lo
 ByDpkCKbQXuEb/HII64VrHtddVSjBxP863I78vajZIBmAmobVUKi0ZJPK0nvlDSl
 VMqXkGeDqKAg/Sbw7lIvwR0Umt8+vaotsMlrjQHr0wdjCP9wsGjEZMjxRpx8jlSl
 3aCeA==
X-ME-Sender: <xms:UNGlaUFSlC2oDrXkQ9l0GuS54gn4QQyEd85kALHIIuLgcyxJA6BBPA>
 <xme:UNGlaUNSJvc3MMws58MtiYyvziTUZsZ4CpS8kHVdDJIPHHHI9bWIKuAH3U_a89gS8
 R9EFDIJBaUY-6aeTLQ0hjhpCr-dK0sJ3rFvwn6T0691q0jw9z2M9e0>
X-ME-Received: <xmr:UNGlaWfLDzz1eQggoO5hZtXV9hJyYVcjeuNc_d82i4Nop6iPjCd5w3-ggTis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:UNGlaRtPDR4QmqPESi95Gf6Fx58CJUYthTK2VDzGjDuwvCtxylLI5Q>
 <xmx:UNGlaXmttkw7VSFdMerAe8W6vw4wUk7fFgmt3Ls6aNs_cvT8NaMOBg>
 <xmx:UNGlaTzsKqffVbeLG1TwaM8NQDZ8E8dPo9gSOh9bK4CGv55H6or4ZQ>
 <xmx:UNGlaZPFDeNt1ABOghPT5RY13yl8N1BaQXYMg0wZii7QTs1qY1wIfA>
 <xmx:UNGlaYoS_rlbu4Q-nq5O7gE42JvUEL63ttz8KLFqluqa7j-_RncEvAze>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:02 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id bfb26fb6;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 08/17] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
Date: Mon,  2 Mar 2026 13:04:38 -0500
Message-ID: <20260302180447.1078098-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cfc7bf9789..980cdd6ac0 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -43,15 +43,28 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+static void ati_set_dirty(ATIVGAState *s,
+                          const uint8_t *dst_bits, unsigned dst_y)
+{
+    VGACommonState *vga = &s->vga;
+    DisplaySurface *ds = qemu_console_surface(vga->con);
+
+    DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
+            surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
+            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    if (dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
+        dst_bits < vga->vram_ptr + vga->vbe_start_addr +
+        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
+        memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
+                                s->regs.dst_offset + dst_y * surface_stride(ds),
+                                s->regs.dst_height * surface_stride(ds));
+    }
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    DisplaySurface *ds = qemu_console_surface(s->vga.con);
-    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
-            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
-            surface_bits_per_pixel(ds),
-            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
     unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
                       s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
     unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
@@ -166,14 +179,6 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -216,18 +221,13 @@ void ati_2d_blt(ATIVGAState *s)
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
     }
+
+    ati_set_dirty(s, dst_bits, dst_y);
 }
-- 
2.52.0


