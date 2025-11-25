Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BAD10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0uE-0002UI-QH; Tue, 25 Nov 2025 16:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0uC-0002IT-DQ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0uA-0005JY-TC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso2633008f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107337; x=1764712137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0nHuBXitg7641bu6kmkOgxo7UOR8YoWwGXOBRRXCaPw=;
 b=lbOpWFXhF9Pd2+3Zp9vKnF+60xUqed9wxsVIVM5WXYDZq/NGqNMRSP/E/BJsXgNx3v
 WQXkD5GAZSiXtqzOhPJnCv8wugf8gZhxgyAi3OZ8PQ3K5hXf5Gx3p5gEhkuAEytEuccl
 Cdycts93Ah31dypy4y3lFQ+kyGwk/IzpuNw4+lOqceMnP7pZ5N+6ZKgY5dX1ggz0932i
 9vAdiY+JrxjXBRi0olarJIT23CyPVYkDrhf2lrLhKaxLMA2AkVgk8bhPi9jU/irHYAii
 OjY8UXscRaSjO+V06N2yzOxDvDVg6w2aT4CI9PZdrTAdjzKjcs+AVg3nTKSbzuB+nxbU
 0H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107337; x=1764712137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0nHuBXitg7641bu6kmkOgxo7UOR8YoWwGXOBRRXCaPw=;
 b=i+NnLHXKtYDQQmEVCPrfUihdGgFumEyHFMIhOOFDPiS7faXzsn/S7OKKuuo+AYliup
 9kcZ8EgCpEd/oqIFl+Dr4+0IkQxz2kNrgBPYQcuQwnEOkMQVxSGMmuJgbYevsfKanatS
 V236xqPd48KGS4b+qpdSCTx9S+pS4bbvJ4J+AzeYlhkGBjqKm6fnQVB9Rbxy2XWGH8gw
 GM98ZoAOQHXv4pmEPlP1+TRB2ZL4BLqw/8/5U1amHisDmhrQJqYK6HeOTbUAa4qQfPUi
 bHKwRD1TLe2Q0NH62l0gO2Ezq1yODwgrdAT5MGp0CsvpHiLN6x7+oR1KOUVr6LkSzeJs
 yriA==
X-Gm-Message-State: AOJu0YwjsCUMme+PPAVH9ZVH+RmRFmrKjJMQqDKvEsEmmwWX4Gr7AsIi
 6TENqpUH5YE1HFGdxLz6rRRZSMkETKCRoWEEh0jbX+6CsFMVjk2gLhGbUMszbR0XeHVV0hbaBvt
 yjMjYr4sIKA==
X-Gm-Gg: ASbGncvxamjuQWzSIkSjUr68kDP9uekBUug+bskpVoBAp46srHhlm4hJACGqg8UnRrZ
 NKFGii9/mkFwHvVhBzbXVxl8sZdQTb2uiIkCgGhh98S+SkNimnquZDNy+3qh5CwsAooA9zqOot+
 3EOSgjly9yENvuODPv8tM8SEwVGvFxmtviLNUOjve9f/pH4IIQqpys9Z7KRz8CjFRa+f+lnIZf9
 Cptw1/miZS1mkwcL2PvHtm8P2OCXDlsa1mwgocLsm7Q1BThh5wFv99W/XKIa9J36BFi4St6hh3A
 dPGgrJFos6a/uAZN/RFyW509OTlc/ZpkcO8DSR+Irn4cc54xzVbkqXJCZ0nR6v7fZMMi0UuaBq/
 CSHecyivI0Oo6IyyBDQ7jV+SRbkhH2Jpw/puKGEtUs9zAd/v4aGglRm4Hx8l8aNi8W0xMa+3Aij
 OLyJkmiLElk/ViKRSZiN9Mb0SdtKLt+hYdZIPIPEYMNVv6bVkwJvMMw3cZAnaK
X-Google-Smtp-Source: AGHT+IGkFMSR/+r9pMiQOCMw8s+vpkVEMFGScr2R0o+iRFYr0z+dSv4KT0as3cRryENFKDhSxuELyg==
X-Received: by 2002:a05:6000:430b:b0:42c:b8fd:21b4 with SMTP id
 ffacd0b85a97d-42e0f35c36bmr4981529f8f.57.1764107336745; 
 Tue, 25 Nov 2025 13:48:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9061sm36737712f8f.41.2025.11.25.13.48.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] replay: Improve assert in replay_char_read_all_load()
Date: Tue, 25 Nov 2025 22:47:59 +0100
Message-ID: <20251125214802.1929-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In replay_char_read_all_load() we get a buffer and size from the
replay log.  We know the size has to fit an int because of how we
write the log.  However the way we assert this is wrong: we cast the
size_t from replay_get_array() to an int and then check that it is
non-negative.  This misses cases where an over-large size is
truncated into a positive value by the cast.

Replace the assertion with checking that the size is in-range
before doing the cast.

Coverity complained about the possible overflow: CID 1643440.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251124173407.50124-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 replay/replay-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay/replay-char.c b/replay/replay-char.c
index 81dc416e988..4e58dd154af 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -126,8 +126,8 @@ int replay_char_read_all_load(uint8_t *buf)
         int res;
         replay_get_array(buf, &size);
         replay_finish_event();
+        assert(size <= INT_MAX);
         res = (int)size;
-        assert(res >= 0);
         return res;
     } else if (replay_next_event_is(EVENT_CHAR_READ_ALL_ERROR)) {
         int res = replay_get_dword();
-- 
2.51.0


