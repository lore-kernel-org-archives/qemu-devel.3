Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8468E9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1L-000742-Al; Wed, 04 Feb 2026 11:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1B-000715-Td
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:18 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng18-0004XM-NX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:17 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 1312C1D00168;
 Wed,  4 Feb 2026 11:46:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 04 Feb 2026 11:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223572; x=
 1770309972; bh=wc5/CA1CTZ2XV6+LGH2Lp1kbRIEEc2t8V0W1vjZuoYM=; b=k
 1LRvY7FLFOfugsgyTuUJ3Or9QB9pWA34/yYAIhNuMytOCE5VXrIJCTJcxQRUdqsK
 AQ/Qgu3kjf+aWVf2mKmU3O6+vqCtAIzqfsfoHDbkMdw4xx9LkNIQCY0fRLCOuXsa
 A9rKrL+TxaNd3d6abtkLdkAJ8C8IS5xIUvHe3hZnteiRVBp4ghK2jG0CBQWkZ3WC
 u/AD6n70teLUJ23ED3qdjoHDGvcVlXFKK8iln+xzH/hZGFHjrDkChUj2fF33wmRG
 y+/AC7f20SLj0LDH/5LPL//8WVAL8a4nhst07PeratPlFvW9m1CgfegVz4wYAf1b
 26I73Ge/g6z4KYF7gc6Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223572; x=1770309972; bh=w
 c5/CA1CTZ2XV6+LGH2Lp1kbRIEEc2t8V0W1vjZuoYM=; b=pIA0Gnlmht2Pk+2nH
 ZFui0C72YhZbOiENLjMLDXWGGl/FBRTzO3WaZ4UnTKiS9Emr9OdP+g60qUjrSsKU
 7umIKyBJUFqvIsXc0hvG72u+IP/DQGO+/Dj5k40qcISNmbbzTRn7kJNxwujTNY+A
 kFaGpEO1kgt5KQv/nkgbrBGlWv1aoiMIhZD2Wt6YesFJ9l/NAu7iWYOdmEkOxOxM
 hohq677gDGLqB1O6B97e7Bt/6aEAY+bC10qo5qf5IyI6uQKEczsMECRuNHBt4NAd
 nDTgJoqsRZ0RjHTaenKWCQIK6xSjAKfCfJAS6ReTm6PJcipMhpFoWNc2VT9UwWH6
 7PAIg==
X-ME-Sender: <xms:1HeDaTyXScbTCTNgt3anC3FP4oqBLswtcmp0TXHGIb--EctDw_6BQg>
 <xme:1HeDaStEV7DOeyJtaXYTr3F5zFX41tIRDZucoYMm7KRs_hIdV2PyIdSTVUHLgn4_4
 nVtXxVisk4Qe_HDOBwWOw9iZX1Ol7Ncv2MzZEnw0Vnpc8gqmEiLwWY>
X-ME-Received: <xmr:1HeDaauwiNKjxTibWrtj-FRpfWGhplicjmN0K2XB5nBrEKTdTVWctt5EC5nT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1HeDaXNeW4O03HG9-2sxjVu4GSn50V8Wjl9dRFP18bDhA59QhTEsTQ>
 <xmx:1HeDaY0EKDswCzCBiirt8xYNGLgotReCsADBJKuzOxGwjby3a-fyJA>
 <xmx:1HeDaTMfrqbO_s9COF8yzjNBhExrIODRYzpREeGnhYAHTaO4FRIsnA>
 <xmx:1HeDaY0kAtNECbfE3nAmbzIt4K_0VAKnNeTXA60uk74LaPXCVK8Rjw>
 <xmx:1HeDaQ6Q7TcwlGC8CAxFvNJgxk9oiTuRKc-pAzNHvqegIdSI8brUyarL>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8b477faf;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 08/18] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
Date: Wed,  4 Feb 2026 11:45:56 -0500
Message-ID: <20260204164606.3425246-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
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


