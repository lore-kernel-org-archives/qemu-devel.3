Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F99310F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYHE-0005Hn-69; Wed, 08 Apr 2026 15:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYFz-0003Sj-Hs
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAES5-0005UO-Ui
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso4464165e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599156; x=1776203956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3pUSJinoIZysq/zNPRi7P/vyOGMFBYOtfasLV1MdM4=;
 b=k90MApkpenfZ7OpQkuzEdHq+ztrHLSY3p2e0ZAOtYzRxVzND+06FJjnqQcdAq6t/Be
 bqsdXVd0fM8fcU3ZfsE9Y9p0TgD7BjsWkci7ZCJWS66KaxNcFmO6DGp63+fe98zREiGR
 W91dPzvTicCvt9esELgz6vSk5LLuPJteQ9/mP0Q5TE+KSRhG7Wg51lDgv+EHUvZEW21G
 r+ewa1XYmLexsn0kLMYInem29o8sYzbzBiD6U/uUDzSY5kIRLCPSt6atYX4JvmenqiHN
 AYD/vv5IaP+BMkwznkR4kKZJhy5VsE7Ml8wXqcIhsi5RcF2ZIaVwMKqauij8+x9A3dck
 hsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599156; x=1776203956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3pUSJinoIZysq/zNPRi7P/vyOGMFBYOtfasLV1MdM4=;
 b=VeldnLzqsx3HYQxgEIk12BU013cChrxWNB37O1cTH1UE2bxcJtvkeGXhtMn8hidFt8
 +ml/HWXpJH2ylNtVxK2+WoNV/ciMoRsduDBPI3FfhYc4vESHvwmT4MTTHZE8kPisOQw2
 l/GbUPk853AgI3KONNXy1BklzFQe42ad4W97OTOcmhc5nYHISZAUXCkt8esJPchz2c3Y
 K5je7rvPx64EUPfCsh3WONaQKliNsifE/zWup0HzPNcNEOpiKiAc2WaTjIjiympfafsE
 806X/ZOv6rropJJ/XxE81sQmsnDRuIcL7chPC7c2xWxyHoRdHnqQdpG/uSYFF3waebkW
 cAoA==
X-Gm-Message-State: AOJu0YxY9dbeAttzgTmOEvVq0ZT0gE7ZMET37lDHYepaGVwMg5cFOFb/
 7Vo7bd2FFqvk7z2Rk3qFZBAw0Oi65uiWm29eqiyzrUh9w95K3SndHE9W7+sh5lE8cWeA+/VeBje
 1Jk7n7lM=
X-Gm-Gg: AeBDiesy1hX4Xk1XuItJ6+r42eoN9UUAbjcvzu4iu6JagCb1apNPoJ6pTrplLurv0SN
 MfUWC8wEoY0nLi5P3vM1AgotkRmPxAqpk72PLO+arOcUkdXof5HEc304+GeniX+sYtFR6o/dcyl
 rgFPpTytVZPDI6F/2T7GimLWifLMsqZAxUrldfKnCiSqUCKr1j9U78iyk13p1yqrLTmPG2aDMmb
 xoZDaOmBzx/ynelTPqn1wfEsbNXIhm5rU0llkY42vQaGsGoWUQHJjMGXJpvZfsTyoSQlh0CLaMC
 kAk0Ds1e2M5V5H3TD7FyPxINPb1q8rzOCTZ5Jkpq/Qzt74N2SUUtikopo0cO4mAbx7NGGWMjUNz
 w09DZqAAp2EMnXU9drGAlZIPBnt1t0vZNk8JgWe3EIS8WWkrxrB1wi47uBr3RWLkm0fz90qQeXb
 jOlcGQ/NCVvci6QgSBsElyYUsKmkvDHVceXuQIslVJWrSG2CtPXpqlYauUbCg6bAzbLBzTJwEQ
X-Received: by 2002:a05:600c:6291:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-4889946a48fmr231709705e9.6.1775599156124; 
 Tue, 07 Apr 2026 14:59:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488be75215dsm83668625e9.6.2026.04.07.14.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 2/6] cirrus-vga: Make frame buffer endianness little
 endian by default
Date: Tue,  7 Apr 2026 23:58:56 +0200
Message-ID: <20260407215900.63390-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
References: <20260407215900.63390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

QEMU VGA defaults to target endianness but real Cirrus VGA is little
endian so set it explicitly in cirrus_init_common() to fix it on big
endian machines.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260401205327.914905969EC@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/cirrus_vga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 629b34fc68d..48be3c8a932 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2930,6 +2930,8 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
     s->vga.cursor_invalidate = cirrus_cursor_invalidate;
     s->vga.cursor_draw_line = cirrus_cursor_draw_line;
 
+    s->vga.big_endian_fb = false;
+
     qemu_register_reset(cirrus_reset, s);
 }
 
-- 
2.53.0


