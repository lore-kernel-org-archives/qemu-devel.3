Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C877C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Jb-0006n3-4E; Sat, 09 Mar 2024 14:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2JV-0006T4-9m
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:57 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2JS-00034W-4L
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:56 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d269b2ff48so48618121fa.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012292; x=1710617092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOxMDvWG7fYCMvOESgkL1lEMXJ1JQ08vQMhMIpxGM9I=;
 b=J38xq4PGGwtuqZGaJYM1qDPUggGtv+n5tzGS4pYERNsyVkqA7CDjhVHDXk31MW16bc
 hhHWlc90iduw8WwVaHM32aJEIMcPLDc6O9Rf80Uu/llk9p4QamSL8FWHc17uyQ3P28Ej
 OMNYvEfRbWivCBJ9bu8OEdfIZ5uG3vYlTsAaxqUw5LD2QS/nlcvRDDlzTJv4e3fsyY+5
 KhVEBGQgZddbuwf2iD8L3jPXwPYgtB7sKt72wM/5lqcZhTvMmWBWVWe7nnc7ZDciE/cf
 JMi6fPQ8nMpSBq+SyEZQF6kgDd7w5KWK2pPp60Bd3Pg/Eeg/YyaD38bu0ax94ZqrfFd/
 ZKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012292; x=1710617092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOxMDvWG7fYCMvOESgkL1lEMXJ1JQ08vQMhMIpxGM9I=;
 b=AnQH+jBjzRnaVfg9W5NU/8OP9wyR9iJQkBhHalxYRKiSCYqWVHzQ9xNJIDZhW/Asa+
 1m13kTr7zUlDjNh3n8ZeiTB100A/5AlmrZK/5q9yhnI/gX8wyjJn/vA/NzxQUzJ17K+F
 DlJrD/hwJqkst2vS91kNbjBUEd+Imw8HTuYN14zwQXAbw/6Jcs33DkJS04SdAxnhD2FK
 ROWj9mgOUTgKnHA1rI+EyfIVZZYWDybI1UmwvT3o/JNmzUfMXe7jvvY2x4rCQBY7H4ZF
 ctE08OtPPEpkVxL2o8Rc9WZZNfWM/GG8P0Yl0/5up3o30ZLKXVGzfWE2z9gMiur+z473
 J4Ag==
X-Gm-Message-State: AOJu0YxOo33x5k9ef4I3bEH5awjw0Z6AO3YCmUyuixfbpeevwjfIggR7
 hKWH65Rzw6G2/nOylfaItFqBLw16q5QnX9w3DR/zcAOpO3xur2kXmR89YzgIpM6kLvVL+PvEeoG
 Z
X-Google-Smtp-Source: AGHT+IEnx0UAhxsWu3vMT5zFaVAqvYzcPHl1DIzHmPysNIU33oUo3sm7kvUgkXVueeIazkYyYxJspA==
X-Received: by 2002:a2e:9b8e:0:b0:2d3:fa6b:9104 with SMTP id
 z14-20020a2e9b8e000000b002d3fa6b9104mr1393478lji.20.1710012292045; 
 Sat, 09 Mar 2024 11:24:52 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 n10-20020aa7d04a000000b0056826248468sm1156009edo.89.2024.03.09.11.24.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/43] mac_newworld: change timebase frequency from 100MHz to
 25MHz for mac99 machine
Date: Sat,  9 Mar 2024 20:21:53 +0100
Message-ID: <20240309192213.23420-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

MacOS X uses multiple techniques for calibrating timers depending upon the detected
hardware. One of these calibration routines compares the change in the timebase
against the KeyLargo timer and uses this to recalculate the clock frequency,
timebase frequency and bus frequency if the calibration exceeds certain limits.
This recalibration occurs despite the correct values being passed via the device
tree, and is likely due to buggy firmware on some hardware.

The timebase frequency of 100MHz was set way back in 2005 by commit fa296b0fb4
("PIC fix - changed back TB frequency to 100 MHz") and with this value on a
mac99,via=pmu machine the OSX 10.2 timer calibration incorrectly calculates the
bus frequency as 400MHz instead of 100MHz. The most noticeable side-effect is
the UI appears sluggish and not very responsive for normal use.

Change the timebase frequency from 100MHz to 25MHz which matches that of a real
G4 AGP machine (the closest match to QEMU's mac99 machine) and allows OSX 10.2
to correctly detect all of the clock frequency, timebase frequency and bus
frequency.

Tested on various MacOS images from OS 9.2 through to OSX 10.4, along with Linux
and NetBSD and I was unable to find any regressions from this change.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240304073548.2098806-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mac_newworld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3e796d2f6d..ff9e490c4e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -77,7 +77,7 @@
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
-#define TBFREQ (100UL * 1000UL * 1000UL)
+#define TBFREQ (25UL * 1000UL * 1000UL)
 #define CLOCKFREQ (900UL * 1000UL * 1000UL)
 #define BUSFREQ (100UL * 1000UL * 1000UL)
 
-- 
2.41.0


