Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66EFCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurTn-00052h-1o; Thu, 11 Apr 2024 06:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTV-0004xS-Up
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTO-0007SS-3s
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41650ee55ffso30708675e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830559; x=1713435359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yioT4noxDvhbuL7egM0nA5pMTUC57Trd6rEmG3sDLks=;
 b=RXlA8NqfCIRGixF6bIle6C3AdW0BdiJshvhBe5wRA2l3C552fBE9NNQL/nKckc1gAK
 zunU+pnppiCl1TCioE9iP3M5U/kgM4FEky0qnrFsOM3lWKNJMfoz6fffkpCzK9H7nCnk
 OuUpM3rbjfkjxsOACd8jYbIzhMBPaF/Mm8IixiKqjZxu3F6hECQ771mWzFvyKWfqa+2D
 wy8s+by1GIC/FkvQO2/1fZ78QvYRIMoBhBS+SkP0BuFuzHtwYgTyWweoQrwFNoYa8w5D
 TNXurcnEGIgrHTtexlgWmVx/A1Lf8Y7+RaaPCCq8BVa8CEyXMwrEbUMplz1d4QAt1L46
 paFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830559; x=1713435359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yioT4noxDvhbuL7egM0nA5pMTUC57Trd6rEmG3sDLks=;
 b=o9eSYhudTVUO1gOaSACeq7YFsWa6Dg/VbPpPK7u0Hd0y/V4mghuA+ltSgbFIGlRGrh
 weab9g3rs5pBbnpa00Gg5SSlE+/4jwld1CCeKnwNOswHKFc5lxvqV/Sl8FD0DswWEMnB
 SabpzkFYjq/XflOpvOKQSpFRmsH74jw772S+fjhEHW2FHa/9U8yA9THj3yR9jZjdXbTR
 c5Oui/IuJ6wV5buh8Hxa85uM4B7UaWHn2rtC5giVs0Tvgu4pGxOB+o7BDOoMD3BdWT6c
 EEjwXGDXyck4qnG5t6WXbqJ8C9ebNvKXuLUlwqX89JZHpJEfVOM7orJXxVev8fC4KmxS
 OAKg==
X-Gm-Message-State: AOJu0YznFsjwYcvB16z+VhEUrYCarvD//Dsl08sK/CAMA7l0Z+wHYJZg
 VHSy8rjPH+Op6ARpIkww1/7L78P9yLuclmoWKSf+yIQNJMkUvc6/knItonsSzRlUsj4U36QrbR4
 u8RI=
X-Google-Smtp-Source: AGHT+IFO1DlwI9OOKAT/T9rhe0sIkMxzudWXL8Nc6fqKGekHmZROyHvmBy6Snrq2nv/QudP7jR06tQ==
X-Received: by 2002:a05:600c:1d8b:b0:417:e090:4772 with SMTP id
 p11-20020a05600c1d8b00b00417e0904772mr654387wms.34.1712830558952; 
 Thu, 11 Apr 2024 03:15:58 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c19ce00b004162bac1393sm1848952wmq.43.2024.04.11.03.15.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:15:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 01/13] ui/console-vc: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:15:37 +0200
Message-ID: <20240411101550.99392-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Replace sprintf() by snprintf() in order to avoid:

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
 ui/console-vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 899fa11c94..847d5fb174 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 6:
                     /* report cursor position */
-                    sprintf(response, "\033[%d;%dR",
+                    snprintf(response, sizeof(response), "\033[%d;%dR",
                            (s->y_base + s->y) % s->total_height + 1,
                             s->x + 1);
                     vc_respond_str(vc, response);
-- 
2.41.0


