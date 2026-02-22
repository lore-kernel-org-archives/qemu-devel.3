Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145FDE6817A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIXW-0001m3-0A; Sun, 22 Feb 2026 18:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXU-0001lq-V2
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXT-0005wl-CR
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4833115090dso35643235e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801617; x=1772406417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zPaG6XUhSOgMW4ojj4JskNGIynnfggKUOmhosKoKH0c=;
 b=CxWe4hVOKii+keB2XItc9tdmgzBdeFAKLLxN3uBR4By6e3xw4afgD68yIgbKwMNtow
 iEn0mv2RLreaiikx4hNIdyse4RI3PPVXtvrQlH9qbAq8XZd+p22BX9mnK08RkwIZxNiQ
 ypzo3tZ2JNruDAbnW1985Ju9e+ICLTC6436gKhNWKEOmXl+4QSB7v+b3JjPs0o33Hl46
 +dwVTNhetIj9IcthPswvteZDnUXmXTEbuICJvKGDIIV08YmyB3uYXjPvoUoJ2pdYX05s
 3PqP3W8idrpAmVR2xVsIPh3WKkwaNH6RSDIFiFxgL1jIcZO/1lZWg19B1Z7lA/ofk95N
 +zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801617; x=1772406417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zPaG6XUhSOgMW4ojj4JskNGIynnfggKUOmhosKoKH0c=;
 b=fnjqKY7KbxNVc/zOosPCw7K0rx52H7iy0GI0eD3R2rJykrVA9RFDLbQjPkChTSli8/
 CbHoIp4ivSC3Rv1nvnFLULLeff7OKYi+0xRVq9679UXWMoPzOpf5s1mrFBFH4F+7ACir
 tV8EF7k/WGJM3M3WIt0CJ8vDxHJSTkZvY2PtYYHxI1Apn4C+IkosYDEuUPGECWxUVBvt
 wTp5zLllt2Y1cDcfg5DiJjQKAyru89y38akSHCpYfJyW1niWSE5PwvQ4UDV4IcAqpC4s
 8WDVlRyYprYuwyFrYlxkn30n9Pr8bDGS7Vq1s9ryV2ul2s62HovkEYMzlof4AQuYaXOt
 KTBQ==
X-Gm-Message-State: AOJu0YxMX/oEsd/j0ZRgOp0yoDDgu0rompF8iCvJiDp+njxhzMW9AeLA
 NwVXi0ONiUjWPKVPqwdgYKdGOvg+gFMEihilczXUcq7COBfXYrVHbb3pppRdwsfjn3ZMx9tPq/E
 C7nqub0I=
X-Gm-Gg: AZuq6aLa49AaRlPTAc25PN0PqLMCODVy8TEaQiq3Kb9CZm4XT40vLhWn9Jjkuk9SNIf
 qGwwXzKQrFP6iRyoVGk0waKEsyFifTlrEz6Z+LsKjVylbUnHYdx6cVeoCg6q1PaerS9MXY37+FB
 EHiwMPazkIt3v3UivKMHAqa29GJqSRh4FCNaAtr5mUWiUI6reu2h4Q2syotzSnJzRlnpRko6NlC
 UQd5Ij/8Uo4JIoZ8Ex//l+I957j2IvfBkWNWXcgZo3Y6nzVSAwcyiyz9mTxJ+kDUTfEsdKVkInG
 SdAOsa0bDFTfQPhgyZkuS9RZxlR4HKw4zWyMkPj8fQJ01IBItan5S8N6V4pqI/mpIwPTuMghg5M
 h6nnXxWTv61xaIbJSg/d3kwxNigC/+aO2IzUwgFjb6pl729oNCkD6/YbR1Pkx/02BwKGJ8JQSGV
 1u17H/APCJ1Vni5QtFd+b27jRbQAp+PqH3x217uzH9wkiXKfNvjc64lx1FA5oC4ErVwKswHcVU
X-Received: by 2002:a05:600c:1d0a:b0:483:9139:4c29 with SMTP id
 5b1f17b1804b1-483a95b58e6mr120138825e9.2.1771801617074; 
 Sun, 22 Feb 2026 15:06:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42eb7ccsm72295595e9.14.2026.02.22.15.06.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] hw/m68k: Set graphic display dimensions generically
Date: Mon, 23 Feb 2026 00:05:49 +0100
Message-ID: <20260222230602.5756-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

If a dimension is not set, have the machine init code
(q800_machine_init) set the default value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-6-philmd@linaro.org>
---
 hw/m68k/q800.c          | 6 +++---
 system/globals-target.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ba32da2fa45..ded531394e6 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -560,9 +560,9 @@ static void q800_machine_init(MachineState *machine)
                             TYPE_NUBUS_MACFB);
     dev = DEVICE(&m->macfb);
     qdev_prop_set_uint32(dev, "slot", 9);
-    qdev_prop_set_uint32(dev, "width", graphic_width);
-    qdev_prop_set_uint32(dev, "height", graphic_height);
-    qdev_prop_set_uint8(dev, "depth", graphic_depth);
+    qdev_prop_set_uint32(dev, "width", graphic_width ?: 800);
+    qdev_prop_set_uint32(dev, "height", graphic_height ?: 600);
+    qdev_prop_set_uint8(dev, "depth", graphic_depth ?: 8);
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
diff --git a/system/globals-target.c b/system/globals-target.c
index 989720591e7..e3f7d846ac0 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -14,9 +14,9 @@ int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
 #elif defined(TARGET_M68K)
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 8;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 #else
 int graphic_width = 800;
 int graphic_height = 600;
-- 
2.52.0


