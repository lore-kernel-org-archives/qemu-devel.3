Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F34F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXw-0006Yw-R6; Mon, 23 Mar 2026 12:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXu-0006MD-Hn
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXs-0000fc-Rq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so36222135e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284867; x=1774889667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/uzgH3k77zd6nj+IXlEhl2Zd+evbOJRWjYSM2OJVbc=;
 b=Mbn0LHw9oQAtR9nLrz6p9IL+hLRk6qbuyQsvnmxCBc7ZkVqAvW/nQhmAtpPKlvOhkP
 DWknD1TJTVGRFdCHR9Nn3JWn5qv+lUpYnak8VwFcX5Xmf8M07RP6wHKLDjLGQgArCVGY
 Xo/vrnHI3/BXkkfB3/zCXfkHAgQqVr49z2dtrn/B3niqrko8Y0HU8p3+gAVTe1E82yZa
 aajclNCNWGXAWERJDlf3zXxGJZPNn+6mr9M5ygBHcmKox1G4nZGeRtUH8EDncajDeRAk
 nC3fmRATrLYjtx2ZeyZPaeTOxVgltSkSg/Fs0T2mlHD/jcvzJl5ncvF2hcohrhXEXVqF
 LQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284867; x=1774889667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k/uzgH3k77zd6nj+IXlEhl2Zd+evbOJRWjYSM2OJVbc=;
 b=d40Rmgvh80zllQu4W24QJeVDL1AXd5bACEDuJ0HIJkyRbSnUJbhlz4UHQK7RGICyrH
 jkI911f9pai1FhhghkzDBduRXySNbG3Jyxf1gJRxNxhUqZdIyPWs4f72q6i3lclBRhd0
 znAqnCvXRHQMxg5pw994D8rkdSJh6o4B9KthCnqoH2C0hmobNmFDcg2vK67Lf79Y99Wg
 wrdtex5yX1UR2A4j3fu5jFYljyfZeIgrJA16kiBQKUwqh0GrejWVtVQzaNqWFhd8Hjf2
 lz7Pnm+S1mvVJ1ci0hqpyWzqhva76MiEaIcipqtVtRDPGoCoFmoSfZvxCJZeBtglcojj
 MrSg==
X-Gm-Message-State: AOJu0Yy0g30uhj4yPMOPZ0GdVeFnW0P5tk3OyBV6blCpHbVSTl1dQTT/
 TkgtH7MTIqlvKZx52ul3nsJFT854U3a+M9giFrmhzyhwSzKNjptoTmrvW86mUp0q/G/nr43Pyyj
 NnBckza0=
X-Gm-Gg: ATEYQzyj/oeTs6cU1YcwnxDEw0AAfD0pPjl5JP9GBkBfZKW8qQJ1Ye3eXAvqJ3XE2Dl
 bw4OAHl8hFDx2m0kF8VCwA4ib0rHW30oawTLpo+1Jp0OOGS317EzXvOrEWjqJX9d8WiX7LY41iq
 qqRCS9Sn88dUkYEKYDgjS+ax4Mxbh86e4gwmO0F8xxdf4DP97Z0SM6Qw0XcUZpIc9cD+9bbxvrV
 WqIWLYNygSuymA4VkP409anOEC0SIpiB3nKRqVk3YA2d79iYjTjH+240uuRCEWQ+GA9ria1bknG
 UnIkmixRiiGze/oEI5zbiP0XiyWQdan1hQkFy/kkupMBCEoJMbSgs6BEnDV+gnnCsnGzjBXt6Zm
 bqmMgurBprRQB1vBdGhsLa2V/sVFAHHY6FnV/0VDs9cX0aDN3/tKv0fplBCEubPE5ELiedNYS9w
 HZIsJm0WBexo+d6YiQOB/rdlLYbaJ34uVlXuu/XLvgSiEtQqWvdx3Ls5h92smbk3/eZhHZsQ1/s
 8NdV8D5TRE=
X-Received: by 2002:a05:6000:220d:b0:439:bf2f:123e with SMTP id
 ffacd0b85a97d-43b6423db90mr20833227f8f.11.1774284866990; 
 Mon, 23 Mar 2026 09:54:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c35sm31482609f8f.22.2026.03.23.09.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/27] ati-vga: Do not add crtc offset to src and dst data
 address
Date: Mon, 23 Mar 2026 17:52:10 +0100
Message-ID: <20260323165218.96607-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Drivers seem to program these registers with values that already
include the crtc offset so this is not needed. This fixes blit outside
of vram errors with non-0 crtc offset.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <7d96c67f864845893d4903b988a4da7c7b010f66.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 0cbbdc33f47..cf2d4a08e29 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -110,7 +110,6 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->dst_stride = s->regs.dst_pitch;
     ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
         ctx->dst_stride *= ctx->bpp;
     }
 
@@ -121,7 +120,6 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->src_stride = s->regs.src_pitch;
     ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
         ctx->src_stride *= ctx->bpp;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-- 
2.53.0


