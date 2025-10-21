Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512DDCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCG6-0002GX-PJ; Tue, 21 Oct 2025 09:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCG4-0002GJ-2m
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCG2-0002Xr-3o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-426fc536b5dso3099852f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761052712; x=1761657512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoKouDHRM63ur8bgDiAr/baaSlSpEgMJ6p1OQu1/W50=;
 b=nBrRKvSk8kalJRqmHD8bwmfRuqNDhxEodkMgOkx3yB/tUIUfyP/qPPfE/iMoYALXbo
 HyIRc3LSG7+PnNfnG4BgPdnyK0ERjEAjfJyWB1/VoHHoAdO0FgfhrNia+XbRYM3jBUxF
 15MWTZnacbqK0b7YU8OZOke6fYCLCzabbMpok3KKIT9UJTRaE3/laarrRLpWdOPgZl4r
 eg20VmmvUMZYI+nv2F1lvRHcILvzm8qrPONv1GhqRsBxoXlVhXDwjdJU7EHi+4pO6Yar
 kTGmOel+PcdamL3u2GvSWgWy0/0TQl7hPu9Dg00w8JnX5VMqqP+qCTU8LthMKNswmGb8
 EtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761052712; x=1761657512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoKouDHRM63ur8bgDiAr/baaSlSpEgMJ6p1OQu1/W50=;
 b=WP3jWnlzJSH9zFMU8Srhf5Mm1KBEy1+6WxOzaXb+/GwQWGwlOLf5RyrlzGvIEQijMw
 ht/f3tkxXvIh2dQdnaRC/5eMZurC8pnbrgZSkDLEiPtFgJPwiB6i10URdQlwON8CllCe
 3YwQwK7dScwbefq7ojMrNLrWJPfhRheDKSMxuf/pj4w2ctD1GQe8RguVtPVGGj8xTBqI
 XXh8sK85zHVgdEEX5RjUzFDvtRZEjX1RIjIyns8JsihRIvBiS47KUx1MFIU5wcY6VyeM
 4yhWRIBTm+LHtAupgkfIA9Nc03Bo70km8rm42qVVXBUPsmueoVf3DSjLNtMH149Muqkp
 5Yvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIj0s+s9u2f8tZxvSVCv7RiXebE+dulv1xh6bmg0sRSRhcYwip14pARmU/NGHP2SJcMAwIS5XsP40M@nongnu.org
X-Gm-Message-State: AOJu0YyD8jDA7C77eRCn7RScfJnXbmLsbrlZkytX0R72ZIt6PRVve6k0
 yUxchwHqzbr8cveZqLFXo4KyBI8KYZvVsMG8BCjbnwy+Ptxfw0BlYWKBLienaWj4vR0=
X-Gm-Gg: ASbGnctoi50B1Y/qDOrVxpFmlH0pzxl+U6pH1yQrSh0pI22b+9VmqbJ1vOPPUeQfluo
 pbz030LZBGeFtBQ3cesQQ8qHoMAaUZM8l2rc8v3XTVHz5IR0FGnkZU7lULHpDD/cEip79jC3b0S
 Iz90FhaFfcXuGRzowY4Q+aPHdPh3Cr7SXGdEDARP6z3oCpXh2Oc3JpW9dSOa5tWmDoeW9mVV4p5
 iRD6im1PyYk08E1RXsXxRF5Yq0/w70W2HD1zjMPAP3QcamFye4v9aFVlPpNqWvIoEhgrUuWfhKc
 Br6N400rMFImgM+OzRZJw2wYvvJgqgRfYQhH+8tOY7hjqiDDG8bYLP8o2KeIm37tEiF97u3JWEE
 t/1Aw6bBRWIQTdTMeroPIKoZIDr/hsG/eR4L97/lxeup5AE/LibJlB+ESO1YJe6nI1AYSc5VLc8
 Xt1NCEk6agh/BNKRmw4hX3gsPQMzgIQmzlwIUgti7EK8Ysv/ZCHQ==
X-Google-Smtp-Source: AGHT+IHHUkiq/drGct6Hys9nEIgCTKXHqdZpC96vX11imtoQQ+eM4Z1KkqZY1aVH/uIyonDQJXR0Jg==
X-Received: by 2002:a05:6000:26ca:b0:428:3c66:a013 with SMTP id
 ffacd0b85a97d-4283c66a3f8mr7877888f8f.55.1761052711702; 
 Tue, 21 Oct 2025 06:18:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c65sm20280934f8f.15.2025.10.21.06.18.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 06:18:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] docs: Update mentions of removed '-soundhw' command line
 option
Date: Tue, 21 Oct 2025 15:18:22 +0200
Message-ID: <20251021131825.99390-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021131825.99390-1-philmd@linaro.org>
References: <20251021131825.99390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The `-soundhw` CLI was removed in commit 039a68373c4 ("introduce
-audio as a replacement for -soundhw"). Remove outdated comments
and update the document mentioning the old usage.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/qdev-device-use.txt | 4 ++--
 system/qdev-monitor.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 043ae461140..fb420da2a9e 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -311,9 +311,9 @@ constraints.
 
 Host and guest part of audio devices have always been separate.
 
-The old way to define guest audio devices is -soundhw C1,...
+The old way to define guest audio devices was -soundhw C1,...
 
-The new way is to define each guest audio device separately with
+The current way is to define each guest audio device separately with
 -device.
 
 Map from -soundhw sound card name to -device:
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 4b732f579ad..5c95926aadd 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -73,9 +73,9 @@ typedef struct QDevAlias
 
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
-    { "AC97", "ac97" }, /* -soundhw name */
+    { "AC97", "ac97" },
     { "e1000", "e1000-82540em" },
-    { "ES1370", "es1370" }, /* -soundhw name */
+    { "ES1370", "es1370" },
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
     { "virtio-9p-device", "virtio-9p", QEMU_ARCH_VIRTIO_MMIO },
-- 
2.51.0


