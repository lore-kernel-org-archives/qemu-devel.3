Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E54CFD318
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNaS6-0004vf-Lq; Mon, 24 Nov 2025 12:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNaS4-0004uX-7r
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:34:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNaS2-00034m-Me
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:34:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so29931985e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 09:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764005649; x=1764610449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9X5I8fC0uuEs8vv1Ff54UYI01m/TtTkaY+Liy82Gbs=;
 b=G35HWCCsEgHspYmNoC8z35TDwKlqgdESu/P+zBvCllY7ozVcwrk+YynuUhYfH7DF/T
 CcJjq4JqcNkeHBNDVT9s8p5t4GysNcV3Kvypsm9g9MFB0iOs+bYdyOHRUei22uBlWREO
 y5K08kRkrRFXmvIxSo7ncmRLJkJGowHQKB9D08s/ktpbgxMX1SyWJ79wd8YR43xd+uuX
 VTCrUM0szvLoVtRP2ZKD+bEln8ZOSduESKPNxW+ck7k1Y8PmLPGVl9rsZHJ729NRZLUH
 7oI5mPHi5BUKH/RdBdrv4LGoBRMPAOWE75p4y0YX80kZXoHQzz1EVxH9TMf+HIALja8Q
 3rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764005649; x=1764610449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9X5I8fC0uuEs8vv1Ff54UYI01m/TtTkaY+Liy82Gbs=;
 b=PesAZD3OUZpxy4NW37xMM0XyOaH6DdJyldwm+GVVxJX7pd7x9JOO+0z6/ekaxmXRao
 bgMKYe+2aqbLVboAUwK+G/q3+ZU1p4EYx5d09rbN3lOcMhmmZ8lf++UDAsRXlYf4N41C
 Y8+7dbPzDUQJT1gN05C6IeIfwOInAiCwqrCRvn7wlIQFfpjWxpkM/DlzDd6tR+SBUb91
 9d2nlS3kOFNCggx2TG2R5zt7L+H8g+K87oJCTFiP120G9T8gvnJA/i0iFy3pGi5SHZFE
 rf5n5qZEzylwTwyyFw2WgcY5zA1Fs4w6FgLWeRik8nigHfqcfyuNMdA7WY61O9eB08n0
 lspw==
X-Gm-Message-State: AOJu0YxekrBzK1E/E7I2cW+9yh8c/lcvqacZjpR+tnp0+cTWY3t28i9i
 WDglzo1T0owAAZ+hVBOzYLEdT0x/9RL+WwgWMBvfHnydgkc5/a/YoOBtKvSBBKhEKQzyUjoFLRo
 RD5Tx
X-Gm-Gg: ASbGncv11yOgxf+wtBSfR2S5rKSfepAdItWQ0BD2ax6xYHagjWhj3CSJH1OVh5emQ2H
 QAYvxpsXZggLydouwgovEFO9Bg/kx8m/uCP4X/tBvTYEzDQaD2Ji5EUREApiJ9bRdRrbkcaY07n
 /aCMNGiCMZlBBl8isQ/iWUr2Ux7dlLJyHnIdKmLqavV72gvxAZXLGkPEy+66qxbsnIyvqQHUuL0
 PLLJ5axqdty96Df/N14kn9K8bp9wsiU1tzXuHenKLCpQe2oSz3nJavHCxVDnSTmxpiaHojPEYoP
 U2MaMsN+xixN2F1RT4SQtl2Rnaj+xIkiQDtfQh8NoOR0AEaSz4RllAulD/1CiDU2zo1xE2ypGWo
 QVf9Tv3WonfGrIzEKkDSTKrAT3kVpTk+ppK+XL/lQHAC6B2ord1Ot5CgNFC14T61ktrOHGzRdbd
 BJlw1xXSBf7I2YYNqw
X-Google-Smtp-Source: AGHT+IFHsOjVS/XZNj9BKNlgyeLZpKxovox9vO7yCppKPtznh1wW+E/z1jmQzOBgXyACWRtgIR7a4g==
X-Received: by 2002:a05:600c:529a:b0:477:8a2a:123e with SMTP id
 5b1f17b1804b1-477c1133932mr119455345e9.33.1764005649101; 
 Mon, 24 Nov 2025 09:34:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9deb126sm154030755e9.9.2025.11.24.09.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 09:34:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] replay: Improve assert in replay_char_read_all_load()
Date: Mon, 24 Nov 2025 17:34:07 +0000
Message-ID: <20251124173407.50124-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
2.43.0


