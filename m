Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E7DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvaH-0006cX-AB; Mon, 22 Jul 2024 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvaE-0006RF-ED
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVva4-0007iF-RD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:08:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so33679895e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664486; x=1722269286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dS9AnThSzSBrSy+tonVpTP7pqJETnOM97XqDCYC+F+8=;
 b=d+aJKlWVVfxjDQ5KwyJPd2PqXzzi9o68EsqdlYlFnYcC/vR9M6V11ZWj0XEBODaWYB
 Wyy3dZW2C4k2Dc9grwxBQqIlu2w4glu5oBn1YwwyuLxM+e6zQQ9UmEbUFq8XakAwXQd6
 LWWG018vaeFuuWJk/deOfkv/rz4eJp+ddJu99yG4PT386bq9W9hYSzfSK1aDIhlXMF06
 dLyLgIjk8IZqA6/Nsq6/wtlP/kYF3AVz337DpARbXhxih4lItk+DGEqNCt9r3ourLFSr
 gmM4YfZ3yHIKlJWsTt+k72Zqu+2LIm3VXbfGK5bOyuRQHGlrj8msbPmChAkTB6cBeEFK
 +byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664486; x=1722269286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dS9AnThSzSBrSy+tonVpTP7pqJETnOM97XqDCYC+F+8=;
 b=VztEMmNgUpI0hJqBhorOt9jZhSi8TnhFncTfDdCpW8L2TGdhreP7gY1N6e1XaiR3e0
 I+Zaxx0uGnbbILZ43oh9md3Ld9W+PNuf6WIaPkiaXDkqwUKqnrp0deudF6BAVwHVvzoc
 kOj0sFRWLzLQlU29XbZ0fwhPRfwPps2KJc9rPEApfc4YF3xiVL9D+ODLj9WxKlVEU7jD
 s++kCd5YN2hcNd4oQWiWRbv3S6DSiuWlf18HWwfdJSvlvTYUDlhfUpxNlCaLEuHtl4Zw
 YgP2P/LyTUCF69pM282h6qYKUYGqQtzrCsESSGECdCkCHwD4BG6dnh58i0/+1qUTRrk3
 QkMA==
X-Gm-Message-State: AOJu0YzEfNG2c8r8rkXBAllwR1kR7l3YDJgNfA3rgJ867buIBxUChtWW
 pUK2TI+MHYn0IDdsFsKzsyVfHSKTLol+QLTKFb9MFDcMz4WOdUCrYED4Hg81CHE0GaEOxz8PLlq
 T
X-Google-Smtp-Source: AGHT+IF//xZooh6F8wrQlhQGx3PPEaFSRd5iEOX4H6OK6eNunLO3B/Y4GiT1cQNAmy+3XU07ENp6ww==
X-Received: by 2002:a05:600c:45d3:b0:425:649b:60e8 with SMTP id
 5b1f17b1804b1-427df7b6d07mr45973825e9.18.1721664485987; 
 Mon, 22 Jul 2024 09:08:05 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e2a1sm159685935e9.31.2024.07.22.09.08.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:08:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] util/fifo8: Use fifo8_reset() in fifo8_create()
Date: Mon, 22 Jul 2024 18:07:41 +0200
Message-ID: <20240722160745.67904-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Avoid open-coding fifo8_reset() in fifo8_create().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 4e01b532d9..2925fe5611 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -16,12 +16,17 @@
 #include "migration/vmstate.h"
 #include "qemu/fifo8.h"
 
+void fifo8_reset(Fifo8 *fifo)
+{
+    fifo->num = 0;
+    fifo->head = 0;
+}
+
 void fifo8_create(Fifo8 *fifo, uint32_t capacity)
 {
     fifo->data = g_new(uint8_t, capacity);
     fifo->capacity = capacity;
-    fifo->head = 0;
-    fifo->num = 0;
+    fifo8_reset(fifo);
 }
 
 void fifo8_destroy(Fifo8 *fifo)
@@ -97,12 +102,6 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_buf(fifo, max, numptr, true);
 }
 
-void fifo8_reset(Fifo8 *fifo)
-{
-    fifo->num = 0;
-    fifo->head = 0;
-}
-
 bool fifo8_is_empty(Fifo8 *fifo)
 {
     return (fifo->num == 0);
-- 
2.41.0


