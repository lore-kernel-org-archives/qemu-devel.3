Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FC8CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTG-0000FN-Qx; Wed, 10 Apr 2024 12:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaSy-00009Z-Ae
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaSv-0002ZB-FZ
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:27 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso6967510a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765183; x=1713369983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/lq6iuLQ5c9JQCAm384BpFlIIX3V3zTqW1RLNIFCYE=;
 b=nRw3OsPAUNL+/YJc7hP6f+fuumc/B/CWcjQDX7kioAS1m09OS1nXXoIcRsWuN0qBP3
 or+5OypbJuLERnN39H4AQTxdpEfve42Fho4T0/4f0QqHo67Gr0aswbK9N3zt+Ho4RA1i
 QVdKLqnznMLb+hI3Z+5xf5M3gxpm0HwNKl/PrUGC0s8rcMrkfoMz3qy3utUWHY5JuJaZ
 NR+b9/6/Lk010HUalMK0UXRMjJMRqclW6Zi6O26TSNkp8A1Ar/dwh60YUbcMEba/uHFY
 C1EWa74WTmCQAFuVs6y/CG8J0SEbzo28fKRrXFcSlrYzDVZVFMtlbxVW+ACe5hiXNG1o
 9OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765183; x=1713369983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/lq6iuLQ5c9JQCAm384BpFlIIX3V3zTqW1RLNIFCYE=;
 b=G0U26tJxohBZyIPxXRMPs7eDSjuZRg08fA48Gcni5KNAMFssr63vocojQwxDjE8uwp
 ZhvKpuoVuJWBiTlrm8C+oPljYqCIoIincqyUvkld3Nq/Wg8Wn7aSe/37eGZdDFJx7pdW
 1jXgnjqoZPBkaHqyKXVIj0C0q+LM58/eDBR9sdfFv4uzHcibqh6Y2BSRY6kXnkpLvv85
 mLdpiDlAdbHKcI65xu69jBIs+4Dd4CWVyDD2LIL9H2u5QokG8BLdg0o/ZN5FtJhLevIJ
 QTzhNhfx1GLl58buQ0C9F8L8t0QYncfzoe9ONjVf7Ir1qcfFBKpsOFBXUCl5isO0OClX
 N/ew==
X-Gm-Message-State: AOJu0YxTDlPXvoDbKfZbX+gTQiQFHmYfHwMeeQtvfFyfWY6RTgDbskhh
 QcugNHObEdaQzhP2MXzF0nJdwAowJemooB2d4q6gvorINj6N9NSJ4R9KIn4Y8rHqTyS5j3uOEbv
 +
X-Google-Smtp-Source: AGHT+IFSOLt1mnF2vxGX5IXqOGz9Z9UBnUkrHnHDlvbIo+gP9fdCiVhEFdHRUmrGqxyU8zngYpZzjw==
X-Received: by 2002:a17:906:45a:b0:a47:34b2:ca4b with SMTP id
 e26-20020a170906045a00b00a4734b2ca4bmr2296275eja.50.1712765182972; 
 Wed, 10 Apr 2024 09:06:22 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 c27-20020a170906d19b00b00a51a00142bdsm7106150ejz.212.2024.04.10.09.06.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 01/12] ui/console-vc: Replace sprintf() by g_strdup_printf()
Date: Wed, 10 Apr 2024 18:06:02 +0200
Message-ID: <20240410160614.90627-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Replace sprintf() by g_strdup_printf() in order to avoid:

  [702/1310] Compiling C object libcommon.fa.p/ui_console-vc.c.o
  ui/console-vc.c:824:21: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
                    sprintf(response, "\033[%d;%dR",
                    ^
  1 warning generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/console-vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 899fa11c94..b455db436d 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -648,7 +648,7 @@ static void vc_putchar(VCChardev *vc, int ch)
     QemuTextConsole *s = vc->console;
     int i;
     int x, y;
-    char response[40];
+    g_autofree char *response = NULL;
 
     switch(vc->state) {
     case TTY_STATE_NORM:
@@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 6:
                     /* report cursor position */
-                    sprintf(response, "\033[%d;%dR",
+                    response = g_strdup_printf("\033[%d;%dR",
                            (s->y_base + s->y) % s->total_height + 1,
                             s->x + 1);
                     vc_respond_str(vc, response);
-- 
2.41.0


