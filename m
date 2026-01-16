Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709D1D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoU-00060Y-WF; Thu, 15 Jan 2026 21:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo0-0005qY-Om
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:23 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnw-0002Ra-Dj
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:18 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 1E9A51D00091;
 Thu, 15 Jan 2026 21:43:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 21:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531392; x=
 1768617792; bh=+/FyD+vMcIQ9VqCK0mlHx+J4DTJhXkCV6w8jNgGWsJY=; b=f
 tCYX8VxzOiCSBS7/oaxPxWC18g5yAfKqaB8dP241l/5f+IOUDfaZJEw061aihrXa
 dIHkRIiFFfrsyZb09uzCx07jZ9PmN7wUaOxFzZSLhFXRz/AiacNceAxTOv3js0aK
 7Z+B/uzX0ed40KdUzkzsRN7dSzdz154dlfu0e4bSmdWsGgqlXBYUR9wPTlzLsqlN
 Hm02wDX09585pMJyTofbx5zZZ58k1pFZCuL13ULfc3NAApNtSJpyfd3Smm7ZkNf0
 L0sm598NE4QaTFQyw5NzngBHES62BFleEL+lEBWWbOcP9lNuKIdPihafbb0tPKom
 27iXuaXdDa3W4+QUY6eZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531392; x=1768617792; bh=+
 /FyD+vMcIQ9VqCK0mlHx+J4DTJhXkCV6w8jNgGWsJY=; b=XrwnQoSALE+jlpj5y
 hncevzHxYZgcDjukbpn6bJ1tHUMiU0kogvmhT28NS/F1dZhaSpzOgHJimNQly1VY
 5qkvHyEqIQP137sXodgatD5/VNUL/M3igfRbKqa7hHnfM91++iKUm8EjDC+YAfj4
 epJT7Q7WLrrESQovOxxtOIPN31mga9p6F4TGrrjJbLrIzvLv5VUsiFp2r8gB0r11
 RiaHC4MgJMRP5+/yUu6hfmpwQoxkwyz2YPu51rc5xohZNrrButSR/bChSaoLWbk7
 34cHFFsp005psKUKBFUJBj7uU5h+Dcs4oF3rkER/fvbTNjy+oB0q0CW0VazCDVep
 i+trg==
X-ME-Sender: <xms:wKVpaaRunNqcKc0WQj_aW11SBJd-u1ulvA_GGVXPwh8PM_AQ-K54zA>
 <xme:wKVpaXNrBIl8Mzp63RE-FG3-DawOQRCn_9KCHQo3-PTn2espEYW3nH40F7NsxFuzh
 OiGi6HdzBpQPF1i5ThE8p2vd1av0bzGOy18kKXBvvKfz6SVs3F7m6E>
X-ME-Received: <xmr:wKVpaVMa7Uv7kdG12CBFJIWnT_7z7uq6Gbdik8llWTr7Ouy_zz4abwBsfePW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:wKVpaftK6YB0j2ZPhL5EE9U5Xas74SB72snqRBkxhjUdsy85TjYuGQ>
 <xmx:wKVpaXXqd7CdZ_bIZ0hHuxTYdDh8wLQ5crsnhPhYG9r3uniSoUIVqQ>
 <xmx:wKVpaftyIYSw5_e5sW5Xgi7Pbpg39oCiBBswnR0NP75aGLYqZnWgwQ>
 <xmx:wKVpabWAwmbRBi_sBSellP0JTgO_-UA5-NeMhmP_KRdbtfw41RFzfw>
 <xmx:wKVpaRbhA2KfR5t_JK9ANMFxitA5m-2vS7o3s06PcFdV9sOwfBV-lbmx>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ab29ab07;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 08/12] ati-vga: Consolidate set dirty and dst update
Date: Thu, 15 Jan 2026 21:42:54 -0500
Message-ID: <20260116024258.1487173-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260116024258.1487173-1-chad@jablonski.xyz>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hardware testing revealed that the Rage 128 does not update dst_x or dst_y
after a blit, regardless of the source. This removes the update for the
Rage 128 device.

Note that there is a behavior change here in that previously the "fill"
ROPs updated only dst_y and SRC_COPY updated dst_y and dst_x. The
Mobility M6 register reference (DST_HEIGHT_WIDTH) states that dst_y is
updated after a blit but doesn't mention dst_x.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

---

I plan to validate the above Radeon behavior in the future but I don't
have the best test environment set up for that card at the moment.
Zoltan if you've seen the dst_x behavior is required then we can modify
this but otherwise it felt safe to me to follow the docs for now.
---
 hw/display/ati_2d.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 91fd3b7827..38390f2da8 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -207,18 +207,6 @@ void ati_2d_blt(ATIVGAState *s)
                 memmove(&dst->bits[i], &src->bits[j], dst->rect.width * bypp);
             }
         }
-        if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst->bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                    s->regs.dst_offset +
-                                    dst->rect.y * surface_stride(ds),
-                                    dst->rect.height * surface_stride(ds));
-        }
-        s->regs.dst_x = (dst->left_to_right ?
-                         dst->rect.x + dst->rect.width : dst->rect.x);
-        s->regs.dst_y = (dst->top_to_bottom ?
-                         dst->rect.y + dst->rect.height : dst->rect.y);
         break;
     }
     case ROP3_PATCOPY:
@@ -260,20 +248,29 @@ void ati_2d_blt(ATIVGAState *s)
                 }
             }
         }
-        if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst->bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                    s->regs.dst_offset +
-                                    dst->rect.y * surface_stride(ds),
-                                    dst->rect.height * surface_stride(ds));
-        }
-        s->regs.dst_y = (dst->top_to_bottom ?
-                         dst->rect.y + dst->rect.height : dst->rect.y);
         break;
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
     }
+
+    if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        /*
+         * Hardware testing shows that dst is _not_ updated for Rage 128.
+         * The M6 (R100/Radeon) docs state however that dst_y is updated.
+         * This has not yet been validated on R100 hardware.
+         */
+        s->regs.dst_y = (dst->top_to_bottom ?
+                        dst->rect.y + dst->rect.height : dst->rect.y);
+    }
+
+    if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+        dst->bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
+        memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
+                                s->regs.dst_offset +
+                                dst->rect.y * surface_stride(ds),
+                                dst->rect.height * surface_stride(ds));
+    }
 }
-- 
2.51.2


