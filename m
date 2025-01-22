Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CB5C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4W-0001G4-UL; Wed, 22 Jan 2025 04:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4I-00019J-TC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4H-0003Bq-7J
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso26408545e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538235; x=1738143035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8ArVsKGybNKtSkR5dolq6Oiydwa+G4DFnUDdzS7HsU=;
 b=JDaTQ5gB7zu127QoD7xTJ6JHG036EPsyOX36sdO29l6qgiIm1oKGAggNVAL9XihkAM
 ttQVoBbxKwbFPom/mqLeeWoz8MwnPTEGeuU3qHyXCg8HWSA6oezs4eGmYiwedFOSh3+y
 9dKJCzoSrxQc3KUyaY64cblPg77FlBRIM96Zy/tBdNuourCWX/jyY1vBDcr3EYwZ6QMg
 DS0eJuLrGhwXPZ7vqw3nQXRfxHiy4HlztMGJGC02vlOX5hPSrvB2UkLOeD5PsX4j2UmY
 4ap3yBZEtnHAvEupfjIHShVbwU3ELrEK/qb3AYW+yGRaI7HJh9STee+Ykpf+Y2Aha4Au
 8AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538235; x=1738143035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8ArVsKGybNKtSkR5dolq6Oiydwa+G4DFnUDdzS7HsU=;
 b=WypClf5rmqZbfcpZ+f09N9YVBvWZLIzzJ3+mwV0v/S6tPHgtPvArYy8ZtYGd4GNRRC
 T9Zi4RwiXiio3OwKrlSVOuFfmxdFjIaZ6Zt8YDUTRT3lwDQ6TIgllS94Q5GI9JjfHUCe
 GI9tk74H70k8rdKTkoHMzd2TsE7Al83wod2Yq8jF/plI8arUTdkwN0DFqRASs0J0/2bJ
 NLF2zffZQBTjrNx+OxgQFJkplMRo95ao1995mjogotsZSDCcg8SOrn+UhnDXGh4ip3Zl
 LM/P2kPFcS21FG2+RGxgiMbWY1j57HvWgav8TBIqUMoV2LV1PCKAotH4OpOF7MilHCxn
 voxA==
X-Gm-Message-State: AOJu0YzYnkweU+pXzHAZ/kny8VxEM3P13jW+rncCBmwkfPF9SxyVibcO
 /xHJG8gq9e8r8pzAkj8yBsIt+kcK1ouVG2xSXUUjDd8ORonIFIaQ6FeHoTxUzi0jlpZyipfNVee
 IITk=
X-Gm-Gg: ASbGncs+vT07hrWptJhpC7wo4ZBng5PWumAHOkflG7wtWfXbOVB+1BujlVA8z4r3C4w
 RkMw7nmLdHDKVP6yx5c06FoE3bOVb8hVAN6ZKX6i3W6eqmmgaAgnlPZ35m67fQ0X76VWOoSwsFQ
 h1vtFib83YRGc2cy1WBbalBx+5676iT3LKSoQBfNjpJa5WsXcGO/JQpdd2WIiRA06TtfXsLqxpK
 KXBCwBHNpmGiQFxop6VXKGinop5KIedKJ2bdv4qnwiLeyN/4tGurhD0Ri+4MUTgHo+RjZXM4Iuv
 EEz76uiiHRsr7uINyvUVG5okiaIegcv9FK94RvVZ5IKm
X-Google-Smtp-Source: AGHT+IHks2jHi8AyiUO0a8BgVEjQWxhPXHsTRUiMOuiSFnHUZ3kH69HzTsmHxw9Sivrz+GFXR/bERQ==
X-Received: by 2002:a05:600c:b8a:b0:434:a386:6ae with SMTP id
 5b1f17b1804b1-438913cae53mr199214635e9.7.1737538235272; 
 Wed, 22 Jan 2025 01:30:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31b718fsm17282655e9.28.2025.01.22.01.30.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/10] hw/core/generic-loader: Do not open-code cpu_set_pc()
Date: Wed, 22 Jan 2025 10:30:19 +0100
Message-ID: <20250122093028.52416-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Directly call cpu_set_pc() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/generic-loader.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index fb354693aff..1b9ab600c9c 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -48,11 +48,8 @@ static void generic_loader_reset(void *opaque)
     GenericLoaderState *s = GENERIC_LOADER(opaque);
 
     if (s->set_pc) {
-        CPUClass *cc = CPU_GET_CLASS(s->cpu);
         cpu_reset(s->cpu);
-        if (cc) {
-            cc->set_pc(s->cpu, s->addr);
-        }
+        cpu_set_pc(s->cpu, s->addr);
     }
 
     if (s->data_len) {
-- 
2.47.1


