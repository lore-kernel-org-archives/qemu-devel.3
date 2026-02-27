Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B29A103FF85
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eW-0003D3-T0; Fri, 27 Feb 2026 15:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e3-0001f3-6Y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:07 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0007Qn-SO
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4CC24140021F;
 Fri, 27 Feb 2026 15:41:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 27 Feb 2026 15:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224862; x=
 1772311262; bh=bg1pEv+jWssKiS2j9WPghce6rJN8doMUtH8ssfpl4sg=; b=k
 KACyQJXK+v1v4/n3dHau5hUsr6ZwnkfHQrHoxLumbnlEwCBw6DPUvkSHHxuU6+lO
 9Z8tF4Qhy78rwneEW5BtiVk0UvRa4/Y9xy1Aop8y9QWEmZNyV0DOWdDlRixP6z2r
 DRnrqMqn/5fLK5ejL3bb9/ACc3maEAiVib8giLOuPWaMfL+ttyk2Z4CIZQL318Sf
 /IdXeO1x7J9bNb9phQGyLiTxzUBicZxFYOIeJLvU+NcuyhE6C3wwsCn3A0e+1Ygv
 cE6LU2oKgPIl/AjtRPpSfNosYm33Osn6hllPV2sMBuzkMlL3SZvCfpMs4ZHBdNyh
 eeJ0dToBLt4Qu2odUipRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224862; x=1772311262; bh=b
 g1pEv+jWssKiS2j9WPghce6rJN8doMUtH8ssfpl4sg=; b=vBvY9R6mUjouYgjOH
 lpZsB/hYPIB9ilfNWn64uvJ7h3Bjqp0siuCnLjOwJkGIgKTJqtQ83ZapjZsUzMLF
 ysiEDrQMVBkhVcgNO3s4/541c7TZLnhEW4YorDShEEr+OFpUXxRK5091BBJ8LuHF
 Irz1Mvine0vbDsiNjEz7ZJ3WLKZaunXwplqgmX05T4BptryonAb3hqcvFgYVT2Jl
 Ti1tN9G9ZVIJCWKguJFGqdoDilb+nmA4UWmxuFBxPYCEjnhqaVaJWjMWFKRBc8ya
 /k7cNjjs5hY1QKJ3Ss8uoJNTO1UCykQg9FeFunNwc4AWAr4bwVTy2cqz9C6tgJlG
 BOerA==
X-ME-Sender: <xms:XgGiaXXxTo0wwMmmfPXxm-rmhu0Dp_VAoSLqrg27cH2l_qNgMfV85A>
 <xme:XgGiaWfTlEACox1d_hOlKmOWSl43_lSiOyiEnXWtqvTIxx0iCS18Dr87mOoA7jnFH
 u_sBAgaEtmQnqoOVV4x3axxFsyyytPZlOu945qeiP0cnTa87JJOaLM>
X-ME-Received: <xmr:XgGiabsfUw1hNvUQuEnHzQ69UlXS0tC0T04sNLEWFLPvCy5hHwNvWIz79zwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:XgGiad-u60rFtL6eWJrzNdGr-5yVr1qAf2amsERGb0PApt0TDqVUAA>
 <xmx:XgGiae2LH3Iwx2hQGs6RD188dwT432rGopCABoxeut8IIuVeABkOfg>
 <xmx:XgGiaaDbnXdjXVKO30VLshcTvrDErUEfyUdRR-Hyeo0cg7Ha_vTRCQ>
 <xmx:XgGiaSeLQU_pZBHtn4vkXLT9t-oXVzssvzZxv-7KwF2GqzXbNLZw-Q>
 <xmx:XgGiae6k_5hT0TSmKP-123IXUCbAf9NsETFmWB9LNaYpJw2bC5K7fEgS>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:01 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 18a79bad;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 18/18] ati-vga: Implement HOST_DATA flush to VRAM
Date: Fri, 27 Feb 2026 15:39:44 -0500
Message-ID: <20260227203944.746471-19-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
text rendering in X. Supports all datatypes (monochrome frgd/bkgd,
monochrome frgd, and color), however monochrome frgd support is
partial and does not properly handle transparency/leave-alone.

The flush is broken up into two steps. First, if necessary, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
clips and performs the blit.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |   5 +-
 hw/display/ati_2d.c   | 126 ++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h  |   2 +
 hw/display/ati_regs.h |   4 ++
 4 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 3757b8426e..4468c345b1 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1038,7 +1038,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->host_data.acc[s->host_data.next] = data;
         if (s->host_data.next % ATI_HOST_DATA_FLUSH_WORDS ==
                 ATI_HOST_DATA_FLUSH_WORDS - 1) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            ati_flush_host_data(s);
         }
         s->host_data.next = (s->host_data.next + 1) %
                 ARRAY_SIZE(s->host_data.acc);
@@ -1048,8 +1048,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             break;
         }
         s->host_data.acc[s->host_data.next] = data;
-        qemu_log_mask(LOG_UNIMP,
-                      "HOST_DATA finish flush not yet implemented\n");
+        ati_finish_host_data(s);
         break;
     default:
         break;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 2b3a239da3..8de9d0f414 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -290,6 +290,19 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+
+    /* Finish any active HOST_DATA blits before starting a new blit */
+    ati_finish_host_data(s);
+
+    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
+        /* Begin a HOST_DATA blit */
+        s->host_data.active = true;
+        s->host_data.next = 0;
+        s->host_data.col = 0;
+        s->host_data.row = 0;
+        return;
+    }
     setup_2d_blt_ctx(s, &ctx);
     if (ctx.rop3 == ROP3_SRCCOPY && (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff ||
         ctx.src_bits >= ctx.vram_end || ctx.src_bits + ctx.src.x +
@@ -300,3 +313,116 @@ void ati_2d_blt(ATIVGAState *s)
     ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
+
+bool ati_flush_host_data(ATIVGAState *s)
+{
+    ATI2DCtx ctx, chunk;
+    uint32_t fg = s->regs.dp_src_frgd_clr;
+    uint32_t bg = s->regs.dp_src_bkgd_clr;
+    unsigned bypp, pix_count, row, col, base, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_FLUSH_BITS * sizeof(uint32_t)];
+    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+    uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
+
+    if (!s->host_data.active) {
+        return false;
+    }
+    if (src_source != DP_SRC_HOST) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: unsupported src_source %x\n", src_source);
+        return false;
+    }
+    if (src_datatype != SRC_MONO_FRGD_BKGD && src_datatype != SRC_MONO_FRGD &&
+        src_datatype != SRC_COLOR) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: undefined src_datatype %x\n",
+                      src_datatype);
+        return false;
+    }
+
+    setup_2d_blt_ctx(s, &ctx);
+
+    if (!ctx.left_to_right || !ctx.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: unsupported blit direction %c%c\n",
+                      ctx.left_to_right ? '>' : '<',
+                      ctx.top_to_bottom ? 'v' : '^');
+        return false;
+    }
+
+    bypp = ctx.bpp / 8;
+    base = (s->host_data.next / ATI_HOST_DATA_FLUSH_WORDS) *
+        ATI_HOST_DATA_FLUSH_WORDS;
+    DPRINTF("expand @ base: %d\n", base);
+
+    if (src_datatype == SRC_COLOR) {
+        pix_count = ATI_HOST_DATA_FLUSH_BITS / ctx.bpp;
+        memcpy(pix_buf, &s->host_data.acc[base],
+               ATI_HOST_DATA_FLUSH_WORDS * sizeof(uint32_t));
+    } else {
+        pix_count = ATI_HOST_DATA_FLUSH_BITS;
+        /* Expand monochrome bits to color pixels */
+        idx = 0;
+        for (int word = base; word < base + ATI_HOST_DATA_FLUSH_WORDS; word++) {
+            for (int byte = 0; byte < 4; byte++) {
+                uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
+                for (int i = 0; i < 8; i++) {
+                    bool is_fg = byte_val & BIT(byte_pix_order ? i : 7 - i);
+                    uint32_t color = is_fg ? fg : bg;
+                    stn_he_p(&pix_buf[idx * bypp], bypp, color);
+                    idx += 1;
+                }
+            }
+        }
+    }
+
+    /* Copy and then modify blit ctx for use in a chunked blit */
+    chunk = ctx;
+    chunk.src_bits = pix_buf;
+    chunk.src.y = 0;
+    chunk.src_stride = ATI_HOST_DATA_FLUSH_BITS * bypp;
+
+    /* Blit one scanline chunk at a time */
+    row = s->host_data.row;
+    col = s->host_data.col;
+    idx = 0;
+    DPRINTF("blt %dpx @ row: %d, col: %d\n", pix_count, row, col);
+    while (idx < pix_count && row < ctx.dst.height) {
+        unsigned pix_in_scanline = MIN(pix_count - idx,
+                                       ctx.dst.width - col);
+        chunk.src.x = idx;
+        /* Build a rect for this scanline chunk */
+        chunk.dst.x = ctx.dst.x + col;
+        chunk.dst.y = ctx.dst.y + row;
+        chunk.dst.width = pix_in_scanline;
+        chunk.dst.height = 1;
+        DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
+                pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
+        ati_2d_do_blt(&chunk, s->use_pixman);
+        ati_set_dirty(&s->vga, &chunk);
+        idx += pix_in_scanline;
+        col += pix_in_scanline;
+        if (col >= ctx.dst.width) {
+            col = 0;
+            row += 1;
+        }
+    }
+
+    /* Track state of the overall blit for use by the next flush */
+    s->host_data.row = row;
+    s->host_data.col = col;
+    if (s->host_data.row >= ctx.dst.height) {
+        s->host_data.active = false;
+    }
+
+    return s->host_data.active;
+}
+
+void ati_finish_host_data(ATIVGAState *s)
+{
+    while (ati_flush_host_data(s)) {
+        s->host_data.next = (s->host_data.next + ATI_HOST_DATA_FLUSH_WORDS) %
+            ARRAY_SIZE(s->host_data.acc);
+    }
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index b285b6eba5..9e77bf8ebd 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -128,5 +128,7 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+bool ati_flush_host_data(ATIVGAState *s);
+void ati_finish_host_data(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 48f15e9b1d..b813fa119e 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,7 +397,11 @@
 #define DST_32BPP                               0x00000006
 #define DP_DST_DATATYPE                         0x0000000f
 #define DP_BRUSH_DATATYPE                       0x00000f00
+#define SRC_MONO_FRGD_BKGD                      0x00000000
+#define SRC_MONO_FRGD                           0x00010000
+#define SRC_COLOR                               0x00030000
 #define DP_SRC_DATATYPE                         0x00030000
+#define DP_BYTE_PIX_ORDER                       0x40000000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
-- 
2.52.0


