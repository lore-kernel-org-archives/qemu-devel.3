Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDACFF9D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdho-0000s6-Fg; Tue, 14 Apr 2026 09:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhm-0000rS-UX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhl-00080k-C6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so3327998f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776172883; x=1776777683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RTP8G/3syFvWMTvC3Oy537xBcJoeDL0PeXldlkypUIc=;
 b=J85Qq5X29zkEt1ZE1zj9GJQlt7eexi+4l0GXiEk8yc1aMMBcx9Qnw62+LLXlp2QfKw
 LhO6HVe3u/8mW2SoGw91mshmCBatY90XnwJ55kregXaNwMEk9/WpD26BPZVpqtJ0ziUX
 iP/Z9dfFZgJueIkXcO9ia9nPqKcqyRwJ4qHEnUS4UcvQittIjSFmGjfXo7zcIA/mwb7t
 H5guz3DN3n2am/TJE7maT0+03C6aVbcmikp1Yx4jCyPatO/EV/bYyaZyhFxMsBXROdIF
 PsYRtR8a/CHaiSXSv+2d4VAlo5w3/oUxTk1t0tIrG/ychSOMwxe+asm96yZUQqlM9bLs
 weTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172883; x=1776777683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RTP8G/3syFvWMTvC3Oy537xBcJoeDL0PeXldlkypUIc=;
 b=ZccWG1VM+kDw+bKd5oCM8Ec8DRnWHstu2FkUT2EcfqLCzJNLfg0eCuEcPwAichdxLR
 yXjyW7Bfh4niN3kAR6uO9QgFZ/afCwgqI6v2WbmD9HYjTbqk81Yj9NN8jFs+eXqpUuqG
 9uroiDlKupoDZMlS2Oy8sRqZcaBDP6IRCAmYIRBEnEQ/SOrE+OB9etmJMD/RQ6DH+Wz2
 e3g6T4i94UKNCMtBGRVg+9tmZ6M3ivzfUpITnn8Pf/Y2MC4lvssAE2PkdeSyRFBv9sPu
 vz9OSXx6LwUGEYe6rP5zdbGH5OJcwyIAhC+LDvwGMU4k429y4G4ySt+F9Fdy53S5jEAd
 ZBPQ==
X-Gm-Message-State: AOJu0YwCgOFMPkAYKxdua1V/JwBenWHkfp+kLdXmcoaGRBML10jaYzop
 zBO5f9TOlxY1HTnTvikUmjbNp7Qnb201Tu9OjrPEeplnUdZAkPVpe8XmoEisZvzX7IYos5Iszkh
 +01NUAA8=
X-Gm-Gg: AeBDietnEfjRvyAcaH7hdMLNE10kUEdYAlyesyHWLzhxUAZCGs4ccsqSKIjHMgBkRlx
 HF9LyfSn8Pp8JdmMb14+4BKzszPEQd38LwX5rRXKCT3aQUFu3/o5ZH2Fn2R3eDs76d2BY7aQfRh
 kFkRxCZQLaCGZiAhTe/qZrEG9sD3lZlyLqCqD05REklDbqq7HfF7XjbyjruovlLHgv9lSiUpz3q
 0bgeHqP4scAbTmxeC1X/qUKfLF/6YXq/zO98wfOfa5c0naHvqU44ZgaPNKSzHipVlb8anobkEI3
 JQyiA1DbH2oOJXp4RmmUcGRgdvMotqLjQQ2FXu12vXfqzrGkwloTSYus3lAltnklmYwjZJpANma
 0CsOQ/wNiCSY05ZEXu/zjn9+KCPRzDxYHJ/Km++6Mj3YQH+aU8N6du0mv0AcJlYxodfITM9Hczv
 XR4vdoLX1x40lFd6t1iWKWH9gq3ceTzdq+1Lr04F/owqSwFSruyR/g8p6mibUjYmYHmthKF62f
X-Received: by 2002:a05:6000:612:b0:43e:a81d:c475 with SMTP id
 ffacd0b85a97d-43ea81dc4d7mr2249966f8f.6.1776172883117; 
 Tue, 14 Apr 2026 06:21:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7b543057sm14033448f8f.6.2026.04.14.06.21.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 06:21:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] ati-vga: fix unsigned integer overflow in cursor bounds
 checks
Date: Tue, 14 Apr 2026 15:20:59 +0200
Message-ID: <20260414132100.53861-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414132100.53861-1-philmd@linaro.org>
References: <20260414132100.53861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Junjie Cao <junjie.cao@intel.com>

The cursor bounds checks compare (srcoff + N) against vram_size, but
both sides are uint32_t so the addition can wrap past UINT32_MAX when
srcoff underflows from the cur_hv_offs subtraction, causing the check
to be bypassed.

Rewrite the checks as (srcoff > vram_size - N) to avoid the
overflow-prone addition, matching the style already used in
ati_mm_read() and ati_mm_write().

Cc: qemu-stable@nongnu.org
Fixes: 2f1fbe6ee9b5 ("ati-vga: Make sure hardware cursor data is within vram")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <20260414141458.1076014-1-junjie.cao@intel.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 88a5bbbf07a..0489995d00b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -149,7 +149,7 @@ static void ati_cursor_define(ATIVGAState *s)
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
-    if (srcoff + 64 * 16 > s->vga.vram_size) {
+    if (srcoff > s->vga.vram_size - 64 * 16) {
         return;
     }
     for (int i = 0; i < 64; i++, srcoff += 16) {
@@ -206,7 +206,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     }
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
-    if (srcoff + 16 > s->vga.vram_size) {
+    if (srcoff > s->vga.vram_size - 16) {
         return;
     }
     dp = &dp[vga->hw_cursor_x];
-- 
2.53.0


