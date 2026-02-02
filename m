Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A88E7FDCD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qa-00085t-Rf; Mon, 02 Feb 2026 15:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q3-0007IR-8T
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:03 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0pz-0001oQ-My
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:02 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F00307A0129;
 Mon,  2 Feb 2026 15:47:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Mon, 02 Feb 2026 15:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065278; x=
 1770151678; bh=lJwdGWGm0WCYMn5yewhyAuzgs9lLPJTMXAV8nHZt22I=; b=F
 nIa+SMtRgqleP/rpPN6xjNNcLPjbhoQdt1GBhOVKFiB8v0FfohfTX6lfbGxm+Mo6
 E/krA7VY8geudR6sl45UIQpHt2BFdqaWI2fkNDNXz6lnaOj0jpkIWuy+WgeGt3B7
 XURp/Ve+tWUuZ648ZXHpCDB6P2nQ57cONlJkUrkMa93BXD5Da1S9un8oKCqHhJVO
 axsC/Ex5YO9k7wdp/r8+MHmplT/1cH4WfKRZVXaJmpwjqhpqFFNSuRySs2mqHSVE
 LHWruF/PXJST/1ilTdJxqvrCRxk10ajb70o7MQoVj0r0deo3YDR7CN+tUM/8WXKG
 WUnpxXXclD9ky9cEaDiPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065278; x=1770151678; bh=l
 JwdGWGm0WCYMn5yewhyAuzgs9lLPJTMXAV8nHZt22I=; b=Y0gHgpY/vf+6zSoWd
 SCqyoRgzVg7ssz0UPzQAm7U6MQFxayAAWMDlLy/fvjHy3XF53hkxal31dz2IO5jV
 BAx7fwGJmMT9rZlmrvMSZ9gY85bHZIVEpBfK+shMJoMQEgXR9yOsA5jbF4yGpLvW
 Typ342IAkG9p7H7yQkzVTUr+O6AkAM84kIemF1VttQl/MRUK6nFcs4nyKT++yfIU
 vT9Xkwn3rN0mCD3wIAb5AK0AzgSYEgt14tT8Gc8D7+3Z8TKtIarABd9ceL4SsrFZ
 izY4DsDzrPJnA+VB6OhIGl3x4dc/BeY9sOcC7X2SyedRQmIDr3ZjQvogqP8cXkBI
 csYqw==
X-ME-Sender: <xms:fg2BaeiYoYFuBoMdo6YDpVoHjpdoVPjxCHo1LMnFouSbZAjYnygKQA>
 <xme:fg2BaWeC4DhVv-x26aOgV2yYuliimkLYgBfYpXOCVBzPWbxYFQnIHDiBO9RRYAXUD
 FuHkvvItoBI8xQKIjsA0G6GL4L6lO0fmXsTxA2WHZmJneVM_Zy7zA>
X-ME-Received: <xmr:fg2BaTcYMqrbuMHiNYoSa0XMlTK3xUmlP1V5_iwUGJMeLRjR6RP4ILCtS0i5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fg2BaQ89lGZW_yasusjNmTpEIWvf2gjygxJH9UrhcmP8KYwOCieioA>
 <xmx:fg2Bafn0LpLMPWN7soujCXi985qWsgv7C6rtC6__OuMWmrq01N3vwQ>
 <xmx:fg2BaS-FMzxBG8juPXbrmZWRD5yBir6q69k09R5HXqLwt2-aFg56ug>
 <xmx:fg2Badn4vuJafFRVv_pr1Oq2cXKAMXQWmudJcT-flam6Ju2KA1P8Kg>
 <xmx:fg2BaWqaGWi3WhjZGbAddJo8qCsfu4oDTMSbgCUZnjgMviF53t0u4LPk>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:58 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 945d8683;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 08/19] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
Date: Mon,  2 Feb 2026 15:47:26 -0500
Message-ID: <20260202204738.3080092-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
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
 hw/display/ati_2d.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cfc7bf9789..5d24d11d7a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -43,15 +43,29 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+static void ati_set_dirty(ATIVGAState *s, const uint8_t *dst_bits,
+                          unsigned dst_y, unsigned dst_height, unsigned rop3)
+{
+    VGACommonState *vga = &s->vga;
+    DisplaySurface *ds = qemu_console_surface(vga->con);
+    unsigned dst_offset = dst_bits - vga->vram_ptr;
+    DPRINTF("%p %u ds: %p %d %d rop: %x\n",
+            vga->vram_ptr, vga->vbe_start_addr,
+            surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
+            rop3 >> 16);
+    if (dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
+        dst_bits < vga->vram_ptr + vga->vbe_start_addr +
+        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
+        memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
+                                dst_offset + dst_y * surface_stride(ds),
+                                dst_height * surface_stride(ds));
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
@@ -166,14 +180,6 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -216,18 +222,14 @@ void ati_2d_blt(ATIVGAState *s)
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
+    ati_set_dirty(s, dst_bits, dst_y, s->regs.dst_height,
+                  (s->regs.dp_mix & GMC_ROP3_MASK));
 }
-- 
2.52.0


