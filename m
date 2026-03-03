Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7426DEB3658
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFna-00080G-1c; Mon, 02 Mar 2026 21:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnS-0007oe-EU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:42 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnQ-0002qL-2x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:42 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4C5E914001B4;
 Mon,  2 Mar 2026 21:47:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 21:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506059; x=
 1772592459; bh=/8gQrPLmCC6i3JQzdW1xashObqgDvg5nx94NGxDJ1P0=; b=C
 gMfFLyWNgGfqJHOlOG8KL8KUhBcuPUtf8Ym6gEDKACZqxTbnFgJAIWh3njmahENh
 p4eBpOiH+a2toqyLMvYAQiNkvBXjjSdsvnaiDMV6uVAe3M+dn8I8CHthAYtrLbvU
 tsgy5PQ4G4za45MobB2nRwhHRufoWgomBGLj0resmrizjDWxnnsNvrcRmL0TcnmB
 6wwNovVV3K3+vSkmlr+V2U1QPIqxymqxxAAB47pU0a7xjfRqRCcRwE9byB+VvzkL
 yF8lGPDSslU9fA/ruXe7xbMX6mOP8Ui8VV5nnzRIP7JOcYbSGpow9SBLyfxIzuwv
 7ixm/7ygvF+G9l4q/hKpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506059; x=1772592459; bh=/
 8gQrPLmCC6i3JQzdW1xashObqgDvg5nx94NGxDJ1P0=; b=Ta7qdWrKSHAz2p96v
 axdc4efz4k0uJyD+8u0wO/+pTPua0Jxce5F0WV4s5LIxqDwXZZ4b1uNce4jf119l
 vT+npLHf/0S5qJDmmHnwJHH++WRczs9MyIdjUTtQRkkPRqWnXMej2FmlyI6MvX45
 FRqIBWfsgnP+vDsAu1fLIMKMBlIeTe51yNwngQjazG5kkbDRqmjv8ZF2UZ1Uo9BS
 2IH6x4MGSUcjWhuoZMZ4I6Le0W99nDnT5gDhy9ASgzcwaBLFcyilN0mrXm9Rvadc
 18SyQCIhtGXdT7UUQG054nmnqaBcHuHp67Szlh4LbdQ900iWPCSVpR6GHQVbZSID
 6u80A==
X-ME-Sender: <xms:y0umadMORmNCrzHtJmVXq8E9L4xYzUcK4aVQDm1unsmFZqkctqjfVw>
 <xme:y0umaW3I1vXIXBdREzoqhHQxcOy8XYp1wRv19_uKBbDWgTcY_6FzUCNIoxvDZ9uSs
 M4N1rrgig-7aZYu9l7TD25jKXeFwJjWVKg82RfpQE5ny_r8sknEpAM>
X-ME-Received: <xmr:y0umaUnXE5L3DNAVxdSusuBd6eDjV9Fvlx9-ca6bIKP2DD0trWGKmV9LOpmJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgv
 rdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:y0umaVVqy1CFejhCPo5RZ5B3HXFrubgYJ71BW-aJEkesLTQIxZJstA>
 <xmx:y0umaSthlhlII_JTDOchffQURHDUDD9_UWP7HsvfeWHKHMaZtAw73w>
 <xmx:y0umaQZb9OGPvLjK1EOJ5Y11TbiguhtOCe_IIxftdwuykmWl6eKuGQ>
 <xmx:y0umaZVtkzKuZ4L2ZEsnugH_yoR-Jn8clZD5zOJRCKwEfSVsvtHq-g>
 <xmx:y0umadQ0jwLfYEF4lDHM5jrA2dBL6Ow7Vcb_t1PIeZzVLWZbJaMy2736>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:38 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 66650ea3;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 08/17] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
Date: Mon,  2 Mar 2026 21:47:21 -0500
Message-ID: <20260303024730.1489136-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
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


