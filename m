Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F036CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlN3-0005jm-10; Sun, 02 Nov 2025 22:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMw-0005hJ-85
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:35 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMr-00080y-Vj
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:32 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3EC86140010B;
 Sun,  2 Nov 2025 22:36:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Sun, 02 Nov 2025 22:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762140988; x=
 1762227388; bh=cMbXfgZRuT2nh3bxQp6pTWkQzuGProvthfWpUuX6w4o=; b=H
 xNTZc341Y7TSAAh3MlLT9TZEyEfA9FmeGvMOB+ud3WtZFB6t/+jGJ257R1HxPRGM
 Z+GtUcwz5tBk5ubr+vXEW3vztuB9qLDo2nUp+2N3N6M3RyXI60IpJvPjQaBrJ2ti
 IwdidGVqMqL8kjALzz3mS4QbttNUoKxAo3SwoNqNxxxfhMXtwsTG9pItMxPacMOJ
 nDwaWLxCwUZxUVUVAexPeL/WPBDCjGw7zYdoLdADZcbNCNIROe00N42Cfew6j8aX
 6xNwTUHZa+BTygNzNvdP8NksTjVaZboX2eD4oOUl2Xr30BPEWxkjGhQI/ED4CfyC
 Jbj3tMu7MtSQCedKtNH4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762140988; x=1762227388; bh=c
 MbXfgZRuT2nh3bxQp6pTWkQzuGProvthfWpUuX6w4o=; b=c1q+F8B4XlWt/DyGi
 ptR79PmqOWIUJbS+MlblgH0vmLtbgYVcuead3umdeijIvHR7AqcLc52ypFVa66Yb
 DD5AViKDIvyWBWgTT5jvbgVCxxionu5i2g1ZlWxS8OZW7rTdwTdE3bRQt7As2hVq
 x9hoJV/9JXOUBg/9w9d2LHYsM7Neukfi03kOIzWbO9qwXBPiHIf8ePZnuDV/zZlO
 B2c3WmZ89pt9zQI6LVJ4OVccAR1Sa9E4rOYxnRj7KDjsSBxmqx+p2MCWduW6mJz8
 GQiXVuNSUiL3m5aa26emZPaKyePYaFCmIlBbn8FDOGsJmAuoeeJT4I8nnFfhLt6N
 eyTBQ==
X-ME-Sender: <xms:PCMIaQzpPL29RnbpE6vlZfmP2-jQQxZNP0Iz3u5PYEnQvJVTm9bOWw>
 <xme:PCMIabv5MT397TQUSQ1jV6b3JvdU9NUarEJdwOeMaKi4HVPEInu_kt2gaSAj2MmK0
 1LyMnrucUfinCwFZoAlbrdL2PpneZd9vCGpy21NvvYvI1-1Dwr4UCVh>
X-ME-Received: <xmr:PCMIafteh4tTMgf8pK1aNF7ZChrlHiLZ9VkvYhz6U2kxdgwOVO02K-kTq2ip>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:PCMIaYN2JyqhRoatt8prEjorMc2S8NAyAB8BXIVV52DAht8FoxjPiA>
 <xmx:PCMIaV2jbKz538VW091Z1i0k36QinlbAdx9zjIY-ZrxI8G9UtDazXg>
 <xmx:PCMIacOdVE8HgGi18Pjc1w9u_wmk6RPa9tex_zTx2UzMkURzdtAUJQ>
 <xmx:PCMIad1nW8QSDYunLldfH0nRZjyfnnLh5NsJxLtKBpYEHqGc2aiN3w>
 <xmx:PCMIaR7hcmPL-QIc1k03sCGLoXymSIaFKmHNQwr7J5oVqRoQqnh78Lqp>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:27 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3e75ec8a;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 6/7] ati-vga: Add expand_colors() helper for monochrome
 color expansion
Date: Sun,  2 Nov 2025 22:36:07 -0500
Message-ID: <20251103033608.120908-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103033608.120908-1-chad@jablonski.xyz>
References: <20251103033608.120908-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Convert 1bpp monochrome images to 32bpp ARGB given a foreground and
background color. This also supports most significant and least
significant bit ordering.

This is useful for host data transfers of glyphs when drawing text in X.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 15cf29a061..181bf634f0 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -45,6 +45,28 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
 }
 
 #define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
+/* Convert 1bpp monochrome data to 32bpp ARGB using color expansion */
+static void expand_colors(uint8_t *color_dst, const uint8_t *mono_src,
+                          uint32_t width, uint32_t height,
+                          uint32_t fg_color, uint32_t bg_color,
+                          bool lsb_to_msb)
+{
+    uint32_t byte, color;
+    uint8_t *pixel;
+    int i, j, bit;
+    /* Rows are 32-bit aligned */
+    int bytes_per_row = ((width + 31) / 32) * 4;
+
+    for (i = 0; i < height; i++) {
+        for (j = 0; j < width; j++) {
+            byte = mono_src[i * bytes_per_row + (j / 8)];
+            bit = lsb_to_msb ? 7 - (j % 8) : j % 8;
+            color = (byte >> bit) & 0x1 ? fg_color : bg_color;
+            pixel = &color_dst[(i * width + j) * 4];
+            memcpy(pixel, &color, sizeof(color));
+        }
+    }
+}
 
 void ati_2d_blt(ATIVGAState *s)
 {
-- 
2.51.0


