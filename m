Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CC4F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iY7-00071q-Pr; Mon, 23 Mar 2026 12:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iY1-0006s5-2e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXz-0000gh-Kl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso2725045f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284874; x=1774889674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ggi0z8zst48aH62Pax6Yp4IE+XZiFinN9t9NdCYPpE=;
 b=yx/qMHtnqPRzuo9/f2uw7vzVKIQ7oAQPWzH4TdDsEuIYkT+qPZyzUQCmK04NkMo56A
 vuPwY00k3KeO4PeOVAc/8Z13f3fwit4MIGu1qtg3EavwfaKjwHPXCnfBdQ/1z2oMQ+Xu
 oo5EIQau4yh1qjEt8XVuXafNtjYCrAUD5ueXkq7/FRMXVC24nm1gRT1B0JabDvdFtb+d
 Szz8MfHIuq1xV8uoBshWXINHUO861ysS+M20LnyTKhaM1iZy806ifr46d2b1ak9J8Pre
 V3uRzWhmdzTHLFEMVNfE8LcpMZtw0z58hfTd4vBCORYO/zyeQXp9a+cJnldCDCFFrOgD
 I6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284874; x=1774889674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6ggi0z8zst48aH62Pax6Yp4IE+XZiFinN9t9NdCYPpE=;
 b=nCP7WgxH4VVN6d5AwR8Tbj6zl2pfmy8qldQJwSRQELnxf43T91L06RaJ8cW5skfRy/
 BmyBkzyv10pVgXujK/8mowlMr6xh3wv5119UMdCfr3SNLo+YwW6lgcoCVcg6Dni2votV
 Hvhj1UE1/W+BXjjJ5QJNTk41WhacQ+gDTTa8ZOL0xc4BGlLyGHw1ccVuEsnPiaUQW28/
 UrhXf+Al4igEgfUmfkIRe6uc3A9I1qw66hPkf1btbSc8t5cf3N4ZyhhcV18dkDlkWQlv
 zpeIvuvwMGd5ROLTwI9iNLqhreFU+ADvHTEGkkGWZOwv8/oFS/z+hTud6NCWEKbaARCU
 Tl6g==
X-Gm-Message-State: AOJu0YxqsnZH5OTIxT+a52QxkJHSrD65diVFSsIYR1kW4hVQPES4nCTK
 hYIkuM3ntvEP2wSAG7vClUGN7bGY2Zv6KbbZFLcy28ODg8w2zxJPkKPznuMH1yTJM9h0VR4KKCv
 8hEASVNw=
X-Gm-Gg: ATEYQzxI6H8pykhWeJl5CCtRzgm/8XZMbGUsK7vvFFw1hA2OhCyFBnQ8Jd1NaIVLwjq
 NCWFLVfis53HmTFYnGAkMU2OTwJ4LlOou6IlOV8XYxZrLO4oPfz6E4QLPnMQeSfPefK+FqPVUFw
 Ker7q9u4abREH6o4+HXM6U6hQNf8ersLqENa65QCNnYCYT4XZnBwiAe3NAHFsTprNrI8tdeqb4A
 beWOC/pmV4PBCYky1TR3jxcHAjNlhlAsF7frD//EQjSR2ifzmOhOfVfEdYMtLkNNyolu0SkgFgB
 WS2yQqQbYRYKw6+mo+O7k485VGszRYN4uPEDONyJ6YG/4RQPQvx00jPe1WnZGJoln8fe5xqLlWm
 AwUrRidUJSeJ5yyqgXku4fxKKD1yz4tfytsUMop4jIbIVQJLZc5prrHFE17pm5p8WJ8nI3Wanlh
 ftvKFIUBZ0eXVSaF7/WZupGtDLh5crtsJaG70oBmzXQmyBa7sxF2P18y2rd0RgIJzZguvIYd89
X-Received: by 2002:a5d:5d89:0:b0:43b:436d:77f6 with SMTP id
 ffacd0b85a97d-43b64270860mr20447359f8f.37.1774284873785; 
 Mon, 23 Mar 2026 09:54:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0b0csm29389363f8f.15.2026.03.23.09.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/27] ati-vga: Avoid warnings about sign extension
Date: Mon, 23 Mar 2026 17:52:11 +0100
Message-ID: <20260323165218.96607-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Coverity reports several possible sign extension errors (latest is CID
1645615). These cannot happen because the values are limited when
writing the registers and only 32 bits of the return value matter but
change type of the variable storing the return value to uint32_t to
avoid these warnings. Also change DEFAULT_SC_BOTTOM_RIGHT register
read to match what other similar registers do for consistency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <9a3263a06bc72aa5a56bafe0a11ad189d5f60528.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 1a6a5ad4fd6..a070f7af296 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -265,7 +265,7 @@ static void ati_vga_vblank_irq(void *opaque)
     ati_vga_update_irq(s);
 }
 
-static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
+static inline uint32_t ati_reg_read_offs(uint32_t reg, int offs,
                                          unsigned int size)
 {
     if (offs == 0 && size == 4) {
@@ -278,7 +278,7 @@ static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
 static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
 {
     ATIVGAState *s = opaque;
-    uint64_t val = 0;
+    uint32_t val = 0;
 
     switch (addr) {
     case MM_INDEX:
@@ -513,8 +513,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = (s->regs.default_sc_bottom << 16) |
-              s->regs.default_sc_right;
+        val = s->regs.default_sc_right;
+        val |= s->regs.default_sc_bottom << 16;
         break;
     case SC_TOP:
         val = s->regs.sc_top;
-- 
2.53.0


