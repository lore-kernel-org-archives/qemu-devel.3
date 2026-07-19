Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7200CC4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBC-0007kL-RA; Sun, 19 Jul 2026 12:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB9-0007i3-Fd
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB7-0002PI-Ga
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id C06481D00085;
 Sun, 19 Jul 2026 12:15:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 19 Jul 2026 12:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477744; x=
 1784564144; bh=SMfM5tOPVVJjB6fA5OJrqvCV54hWKQWqeNa0ZvBSgq0=; b=j
 8k6kA3jsh4BrLfobc9QLXPkfQJYbc3XfrT8zJJYaVWmuRbDBOMneQshVeO1QjSJZ
 yiGRqNewBqCv2ttzo1hDsKZMVeC/1LnWLNSCkuA9TlsoBBikey+1Fa5DXyxGA5Zs
 aAxoIbPBzPilCPIEAyzVqRV4taLfQH/i0rvsw4IQoDghpGUdpVQYX4YXlnvTscJM
 68o64/vJ/7FIjazxrBFqaade/uJpQLvKgY+eXepVTq0l76q2qLPRmmUQQf3z2vNR
 ITfqfIhAIpHG8qvcIStbPq3s7vihCCCzesck85MXNuLzvoKjMxCqXi3X6DFtu7gH
 MUQD0oBCMYD7vJ/k0uHTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477744; x=1784564144; bh=S
 MfM5tOPVVJjB6fA5OJrqvCV54hWKQWqeNa0ZvBSgq0=; b=p98CsUxti//9JpwNs
 /V4pObda5aOJjGo2zs+BZjBxMqPg/uuTekZWkTspZqxzM0zFqFScMW6q+83lQnK0
 ABmiZ+MKYFRkkeDaui+4dfmtMjKjRsq7KD2g9myzTSmz0ROU5MXTtJdwU8U11+xp
 DEVKjxDuveU6Rh4rpBIntqusUG3VbqE42SvtuWYL+rZUnC14soExOT0qtDiSP++R
 +8+kItFDigQmiW9J2Fc2O5DVb7BPUHxPlsP5TsnAeeA3qTLt3jENhJvjRBbHFOvS
 B1hbsb9YOqypKf5izjyoV70dd4dzdxqf1qgdmPmg9yBhsW8zKDa4pBxzFhCeYlsO
 IwG+A==
X-ME-Sender: <xms:MPhcasXsuyZjmrOcFc7ygPXiluPLL9RiwxIywTXdpv9TpvpIe-aE6A>
 <xme:MPhcaoDFKiLd8QfggR3bEFeoPcHd3m4J4qMzZSWCbqJ6NwXQkf99hFPqyg8tA-JgA
 p7waItDOh3_ctSXRBXp43MDzgsbdIZLLkPuMf6eIr-iWVMwtKVC3Vg>
X-ME-Received: <xmr:MPhcatwfJUAAulpKa96ejXkdntxkpV7XzJusohaWKEeXf8NzMOXeXgkXw6w>
X-ME-Proxy-Cause: dmFkZTF2M8/td2x4uX0quVUht6oTuzlOtlV8s/xAIpba0AK3yD3yx/edKpxJCFjEj6RVFW
 tZylprZe+5ZeJQcZMYpgGdlyYr4p2Wtx0Pp9uwz7oCUjsZcueHidxeZqaoOMQW+WpAqS8o
 36DmnFTRazz4ZZYy3JE1PDUxJVJ6kQybtpH5PX9NmR/So+sfpFNwXUOFOf+enlYoThGfBq
 /4lv/qCY4C+TNW42jFI8nDAtYiw5rFjgpjUCC0EAiSX1/r68t1adlaGfPCZ9kDzHhyIsa/
 zjm0Fxwf9RtbwH8g1DU4zTrN01nzO9FlVCZHr0GOq/w+LWaLMT81m5uJTc0ahE79g4sRDp
 MrujM+TRxleVO6L17NotoAvZ7Cxru+b/zWS2K0A5CC9Z9T4Y7dzdF43Q9WlA2NwRBg7w8f
 oMmZYHt++huXN9EUqtAbvTFFTJFIiNj4UeJsG7UrXgvdR6YakF/xSP9T0uY2P2ZnxSl2k4
 FAu4Je3mF3a8w1+Yeyeo6dseRsAMpAe3xsHQO+mFLJFbMBvnwlbFW3mDRZpWvTYSOVrmOZ
 XJGUG/4en84g73sEvcmeiz+7t9v82NP8d6jcufWeMzcbdsACPNWX2g7gAA9gbEfbn2sd80
 qainyZtYH3kcjHo9PCwz4DtVLiJywxT9IeXMW7BgukNgVB4CSv2mwOEd5sOQ
X-ME-Proxy: <xmx:MPhcalC8CLrhDRsft8h-jXCAaGlctYpdON2Or62fyIRLPoXIniCHHQ>
 <xmx:MPhcaqaJCXMYGkDAdDaBq_xIhuSM2L5Xh9_j4lSV0YVzfsoaYdQapQ>
 <xmx:MPhcathAVHCN8uuZ1ud8XsbMHjet4g_jV18j8ah0YzH7K7dpVbOvDA>
 <xmx:MPhcas61FAsouRIXllb8Z_Y4o0XQK9pfblVVCPJAx8ByW3_Of8rsTg>
 <xmx:MPhcavE_eobogWkakd1z849TFQ9a1p8M4Kuba6ZJDO8GZnHHiZjn29Sa>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:44 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 04b61daf;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 5/9] ati-vga: Route r100 src and dst offsets through memory
 controller
Date: Sun, 19 Jul 2026 12:15:32 -0400
Message-ID: <20260719161536.774061-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
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

The r100 stores a full GPU address in the dst, src, and default
offset registers. For this reason the addresses need to be routed via
the memory controller to obtain offsets. This differs from the r128
which directly stores framebuffer offsets.

Blits outside of VRAM are still not supported. The existing bounds
checks catch this in most cases. A small edge case exists where an
offset register could be set to a low memory address outside of the
VRAM mapping and end up treated as a VRAM offset. This has not been
observed in real drivers but should be handled when implementing
blits outside of VRAM.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index f51ecb747a..e1cbf9efa9 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -135,10 +135,13 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
         ctx->dst_stride = s->regs.dst_pitch * ctx->bpp;
         ctx->dst_offset = s->regs.dst_offset;
     } else {
+        ATIMemRoute res = ati_mc_route(s, s->regs.dp_gui_master_cntl &
+                                       GMC_DST_PITCH_OFFSET_CNTL
+                                       ? s->regs.dst_offset
+                                       : s->regs.default_offset);
         ctx->dst_stride = s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL
                           ? s->regs.dst_pitch : s->regs.default_pitch;
-        ctx->dst_offset = s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL
-                          ? s->regs.dst_offset : s->regs.default_offset;
+        ctx->dst_offset = res.addr;
     }
     ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
 
@@ -150,11 +153,13 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
         ctx->src_stride = s->regs.src_pitch * ctx->bpp;
         ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
     } else {
+        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
+                       ? s->regs.src_offset
+                       : s->regs.default_offset;
+        ATIMemRoute res = ati_mc_route(s, src);
         ctx->src_stride = s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
                           ? s->regs.src_pitch : s->regs.default_pitch;
-        ctx->src_bits = s->vga.vram_ptr +
-                        (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
-                        ? s->regs.src_offset : s->regs.default_offset);
+        ctx->src_bits = s->vga.vram_ptr + res.addr;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
-- 
2.54.0


