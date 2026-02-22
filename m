Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD42E68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIX7-0001aV-GJ; Sun, 22 Feb 2026 18:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIX4-0001Zf-I9
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:34 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIX3-0005vy-29
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso2606370f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801591; x=1772406391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZGF+7iPYu2bZFwWUIJET2h0atyQWQ2AKTZmx89IP/7Q=;
 b=F1ibXK34wqieoGPGPl373ywjLLuoNq8oCFhQSPMrn+xtLFt+eS2xeOv6VBbE/1jjtD
 lK1o+4yKsR3y4B67M5k+XJvjXqQAz+VzN37hGybCRM14igc2tJoC7GM/M0tDX1Kf14xq
 LHaQ02tdpHbTAqDNH0CWxqQp90TjnfeII4IAdVfvuTMrAceoxeuySKneiM2r6kWKtmYS
 1E7S/egUd8eq3gOEj6tQD4OH/IV5YqQ+inYhynI0Ifu0AIwVSqCg4xN994Ok4qbsRGTP
 /MehNF5pgiNRmKks5mGy3WQz802UgwQ2bViXM7q1YxlPWtSynaViOvm+75dxCIdW4+v5
 dgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801591; x=1772406391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZGF+7iPYu2bZFwWUIJET2h0atyQWQ2AKTZmx89IP/7Q=;
 b=JyMlD9ltWAfhlo0isd3SObwIxZ1tBkcJjwT4T37gPIJxyYmbXp+Q2apWw2AI3lTQl+
 zuQyo6NVuPsRE6zseoHpXlspa38w7hv1RB9PT69k/xMn4YY/KfS4XUWLBuAV6uNGDETI
 2c6JqElPpevffKivV+dlUxGpIwbKyBvxBztQtHkq4QPK0siSN1aDdHIvXTUx1btpBz5y
 K3hFDMzDPsm3MxRjMsdF3fEAewO+7O29Oj7s6+CIEmzf01BQkyft0/Y6Mb1uqc1tBlMz
 O37x3Me7Epm/FoBJaUT60wKzbq8udB9Ai9i+0SwqAXmhk0YCLwMsUWbps96v7lSvy3u+
 J/1Q==
X-Gm-Message-State: AOJu0YxMcjVyDvYnw5ZS7mXiJ5EJMz0adVVBu6MiekJDXTJM+U2DrZ5o
 cQw1EhWsbU5kZG+b75tEpGMsuJiHFFLX4sRMxtmNVgJJBQ9gl8rK6rcP856QhZ6zbJLMI3YApQE
 23pLKGwg=
X-Gm-Gg: AZuq6aImETMWy+BF2kB8JfKGTcgh87wTofAnHLxSu39e4r4S6pISNHimarDwOESuyY6
 GyrpDkb4OizxyngMKrkq9VuCCskaWU75pu48btbALsLllCrvWlW+R0W4tJj02OpdPK73kqtvqFO
 IURxdVrSjn0z/wafxW4+sM+E7bh3iVUKNaoXfaYmVFckd5xMDtapsAbLx824rzlG1OBlfBCtTz2
 b7v99YqbP6Aaaj9BhYVYUoiVuJCwGqQOKcaKkmb+YbLkKOABQ1Bt/uDNMATco4eLdgitoFLKjam
 Qhia/V87fQFbvLmUqfL48yF+awOUlodirSmKkZWFsCD10pPOMRWlRROO7UZuIsUdFZjJBoteQI+
 lsITqmpzIbCTIeTCksAAQC+BEu/p3UJRv3S5Ujxh2KRO+c5tag5nzlLenwFc5bIeouQ3OpakSzu
 9+EVq2H8i9xRD2aQX+r9VZdOdUO7Plw2CMZQvSfWcLch/34oY5wa/e245jgy4VsTN+8OZwRM+5
X-Received: by 2002:a05:6000:1ace:b0:437:7010:1cfd with SMTP id
 ffacd0b85a97d-4396fd9a3dfmr11725756f8f.4.1771801591295; 
 Sun, 22 Feb 2026 15:06:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00db8sm14540172f8f.12.2026.02.22.15.06.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] hw/display/macfb: Constify macfb_sense_table[] array
Date: Mon, 23 Feb 2026 00:05:45 +0100
Message-ID: <20260222230602.5756-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

macfb_sense_table[] is only read, never updated, so can be const.

Update the single call site, macfb_sense_read().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260216213121.47122-2-philmd@linaro.org>
---
 hw/display/macfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 388f8de5070..57ad8ad5587 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -82,7 +82,7 @@ typedef struct MacFbSense {
     uint8_t ext_sense;
 } MacFbSense;
 
-static MacFbSense macfb_sense_table[] = {
+static const MacFbSense macfb_sense_table[] = {
     { MACFB_DISPLAY_APPLE_21_COLOR, 0x0, 0 },
     { MACFB_DISPLAY_APPLE_PORTRAIT, 0x1, 0 },
     { MACFB_DISPLAY_APPLE_12_RGB, 0x2, 0 },
@@ -342,7 +342,7 @@ static void macfb_invalidate_display(void *opaque)
 
 static uint32_t macfb_sense_read(MacfbState *s)
 {
-    MacFbSense *macfb_sense;
+    const MacFbSense *macfb_sense;
     uint8_t sense;
 
     assert(s->type < ARRAY_SIZE(macfb_sense_table));
-- 
2.52.0


