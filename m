Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCADCEACC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK051-0000zS-EW; Fri, 14 Nov 2025 15:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02s-0007Dh-B7
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02q-00050j-6x
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477632d45c9so18301205e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150718; x=1763755518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhaKZtIHcKQyEzCs44RThvX4QVJ1Sgd9Tp4DxoQS0nM=;
 b=QpVMznyz4/5ADSa9rH3ROIHR0v5G52s+uC2Fit/j8VAAJdVNPPNC5H+ilIx0hEujFn
 BnU5NN6UBDvdiLYQZ1EGT5NuwC4fVIuvrHFwMxeUdauUlt4Y71l2YP36sNn1efT5K1T3
 qCCjFTJ2zMnO4hMHn2NLI6poxQUAZFp8SPGfiWmof0ehTX7eMQ5lj0i262qkRR4R/4ci
 b31+uttRGvZChs4AyABWHsbGhVHW9oIXs6xr3WblpS4Gib6Mw5HRFu7HtjJO6KKWFxsd
 SPc6zAD5crC9h2aoA1i3trMzNYqV0KwX1mfkiZoWG+q/EVlRw42yn1pr9rZVJGkdYX5A
 8BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150718; x=1763755518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZhaKZtIHcKQyEzCs44RThvX4QVJ1Sgd9Tp4DxoQS0nM=;
 b=q6D+YgOQNhMjnUb1CPQX9JLnM8RuUgbE1PnL9ib5O8JgSL8G4aVIB7ne+OeUyrDFBH
 MafxGo0q83y9IDwQf8V1ZfSJnOFM80l8L/6wGUA6mzAFuOm9NXZF63SBI2JUd/Lfrili
 kNjTHvBO+0OyMiPpPJtuw+YWMpWbHfgboYYm/FeiFO5BrdZTnZM7Y0SLdl4M51uFbAvR
 bzTh+z7jJ/YtsD+FPIeRejePauRftclq9zInbwPR6Jnx/tSbrmXUwCFczM+n9KLPBC60
 JHqePbAKI9U4eoao2/xPRqVtUAppF/roifSlItL3/FaVnKJrZBmg04j+NfxI3P1mTXWJ
 U9LQ==
X-Gm-Message-State: AOJu0YzLZLsgMguGixD4n6GtfXyBmFJrnBG0DLrEWKwecvRHd855HaUT
 gk2ueMBHpnWjzz1CacV+D5cXD4IurqChnsbcxlgsd2tCSk+SI5/PfpC2DYnLnRX5jvyZ6wbHHU0
 tQJuM5nRRcg==
X-Gm-Gg: ASbGncu3EgkOMzdpqaBVkLGg+MAM2XNn5XLftLhqxVb4xb0L+rJ6Uc06SQ+vW7/XWiW
 XzVrgDBobjxmVZjG7J6wh+PfCHsMU2ATZqdk1gl5lBRwYfj7vGqWG7GB+zB4OIIJlBKd6hoBvmg
 WA7vR1N3ntoeYKsrOvb41cByOmPfHvCcFZaAayx6roVy7IyWNeDwURQFL+atUZpDu2PeacrZxuc
 cMNkZtLoDsS10+hjJ90Qdi/eKhJBageFPB9aYzt1dX4WrSp1zZpymgcfQTqh1kMpH8J3BjX2jgs
 wQbhK5eq5Q+TTjYIvsMWYvXznNvJAK71xIvwPw5Sqp9UUqt4NDJ5mkPIFLpqgv+87Hddblvfnvq
 lIKl5sMb23V6Es7PxuuRuTOegm7ENvhfBq5RILNP3lXjjRaI3kIv3KghZfaJnLVO6ZjAmYFgEzv
 mHmT8xYcZBnYxUXzaGxrDhyHzNO+V5HuV5a+X3vTknNZ/p5lh3vw==
X-Google-Smtp-Source: AGHT+IGxOPmZaiU2QIqOX8vP2waXUQsTuY9lyWNssyfSaOv12O7A6NZdYYkp5MiCp7Ro8Cax4ElNMQ==
X-Received: by 2002:a05:600c:8b21:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4778fe883e3mr50226165e9.30.1763150718467; 
 Fri, 14 Nov 2025 12:05:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477969b3c12sm7706355e9.13.2025.11.14.12.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:05:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 07/19] accel/hvf: Move hvf_log_sync to hvf_log_clear
Date: Fri, 14 Nov 2025 21:04:09 +0100
Message-ID: <20251114200422.4280-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Right idea, wrong hook.  log_sync is called before using
dirty bit data (which for hvf is already up-to-date),
whereas log_clear is called before cleaning the range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 601e63c7f9a..f203a6251f0 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -224,12 +224,13 @@ static void hvf_log_stop(MemoryListener *listener,
     }
 }
 
-static void hvf_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
+static void hvf_log_clear(MemoryListener *listener,
+                          MemoryRegionSection *section)
 {
     /*
-     * sync of dirty pages is handled elsewhere; just make sure we keep
-     * tracking the region.
+     * The dirty page bits within section are being cleared.
+     * Some number of those pages may have been dirtied and
+     * the write permission enabled.  Reset the range read-only.
      */
     hvf_protect_clean_range(section->offset_within_address_space,
                             int128_get64(section->size));
@@ -254,7 +255,7 @@ static MemoryListener hvf_memory_listener = {
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
     .log_stop = hvf_log_stop,
-    .log_sync = hvf_log_sync,
+    .log_clear = hvf_log_clear,
 };
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
-- 
2.51.0


