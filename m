Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0EAC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2tN-0001KJ-7a; Thu, 20 Feb 2025 04:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2tC-00018w-Hc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:30:40 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2t9-0003nq-Ik
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:30:38 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220d39a5627so10011875ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043834; x=1740648634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNUu0QLM1jJD6vp7svI4zxOCu3a+5YIL+dQ3Ih3Jc18=;
 b=ccJG7RB/NrTPd4A8fwkC2nq6Of9c6sb9+p/yQVWN96xxDew2qKj+P+uVtGMnVq8TYH
 Rxjs1mNByDoR8ze1hOedHRN8Hoe1t1pmLeafIPHWjMYiO+fVN6IPiqFNV22UGuiJ2I/2
 v2Iw27Cr9iQQJK4w2U3V5JmQ+QdXLvykSd9leyP8S8a9FtJoZhVl8qKm1QQnTPMBYCLr
 19rhS2v3B85+F0Pz18FfgvSiFOoCMFHeBuRUlRBRzPoo/6bmGpF2KV/DhWRRHpmpXTrK
 BTushJ+NIfwABfK35YQMZF/g0FG5DsOovewhJytWeVR2q7nZptjJ+rLr40izusOxoGCM
 HJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043834; x=1740648634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNUu0QLM1jJD6vp7svI4zxOCu3a+5YIL+dQ3Ih3Jc18=;
 b=CL0fAvBbzebOpmFUT8Mi8lBOI7mP00gbbiJLc9/yqEKxS49DJxMgca7Zh11AN3U6gb
 KcuqRbJ+UkjyxdhsoZeAEWz4gPmW38bha1ViPeu1PzfIte7cEqwKuxuJLFyyQiaVZ4Ei
 t7AqlXpgHN+S2/89RL70tXQO2tEYGFV0KqOhNp5bcE2tMvAaW9I/gTuUlZQr8EaZM37B
 DcMZlLwLzHdlPK7A7W9W++52yV/W5cRFgYSbg3Kgghj65urwvZl05T5CUuG9Ypp15gZY
 p+zafHeQRqR/tzapvg+yinw+0o9I1wxOgf21/VTeO1XZZaR7REoRgliVJ7HHVsa22nF0
 IGtQ==
X-Gm-Message-State: AOJu0YyBmpmAikHXPMaudwLvkgGTdDvpceBCQmzffFMeRwWnCLJuluf8
 iIFnU7qvN++ZgGkzD9IqRGhIAdiNYr+RPNmuvNnKkScIYVeFVreiteKXx3XOEziAv8oqpujH7lY
 fIxM=
X-Gm-Gg: ASbGncvWFUEzv0Af5aqxq+UsnwYx2qm6TBSrm8tH7qTI3a44cTFUqK9R03gntF6SwNG
 iQSRbTHCC85RwlOjK0e+opGomke3GVgeIi93Xd1NO5CqOObyeSbLcfVY9DVnIclE1NA14hTh6bV
 bntmnKmKqx3tz1peIK39UZOGEJD95wk9tjN7DHPysgokVNzP4/Qilr9V7t8b07c/a9vkUCZUb3w
 V6VUECt4rSj4BialE9YffxeaP4rUdMM2nqL5hqErIlxPUcAHdZe43pmh0UuN/ZDdJYpUwteZdWY
 gZWxETCTo5xEnrj8xZ0iULMkWSK2GrR0ScQKK7lIgq8jSdHqX9jmcs58W3pKUClESg==
X-Google-Smtp-Source: AGHT+IHtCdGVpk6l604E32RACxb+nA/F1wtoRn4fYgBQOiATMnUaayVbCelxsQJslZPg5LYVQHWVoQ==
X-Received: by 2002:a05:6a00:21cc:b0:730:4c55:4fdf with SMTP id
 d2e1a72fcca58-7341725faf9mr2898714b3a.7.1740043833647; 
 Thu, 20 Feb 2025 01:30:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273c8a4sm13283568b3a.85.2025.02.20.01.30.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:30:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 5/9] hw/char/bcm2835_aux: Really use RX FIFO depth
Date: Thu, 20 Feb 2025 10:28:58 +0100
Message-ID: <20250220092903.3726-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

While we model a 8-elements RX FIFO since the BCM2835 AUX model
was introduced in commit 97398d900ca ("bcm2835_aux: add emulation
of BCM2835 AUX block") we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
---
 hw/char/bcm2835_aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 73ad5934067..c6e7eccf7dd 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -221,7 +221,7 @@ static int bcm2835_aux_can_receive(void *opaque)
 {
     BCM2835AuxState *s = opaque;
 
-    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
+    return BCM2835_AUX_RX_FIFO_LEN - s->read_count;
 }
 
 static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
@@ -243,7 +243,9 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
 
 static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
 {
-    bcm2835_aux_put_fifo(opaque, *buf);
+    for (int i = 0; i < size; i++) {
+        bcm2835_aux_put_fifo(opaque, buf[i]);
+    }
 }
 
 static const MemoryRegionOps bcm2835_aux_ops = {
-- 
2.47.1


