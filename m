Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9305C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7t6-0006Gy-S2; Mon, 18 Mar 2024 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sX-00062v-Ij
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:57:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sW-0000kS-7Q
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:57:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so3817435b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748670; x=1711353470;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bqiVcWk+QPelPVCWArv8qjPW16I407GHPXqES+lc6zE=;
 b=u//WHzeKc6oGSu2/8I3ToM9iXnSR1OTiLhNsuq6zo9Nw2DfRR6duUUZiJCtOQ66lsf
 +7EIdW/EDGFlzunZGFoC86m94RZpAZgVTaH1NQk6Nq/UwdGfwRwprLJBZE+ZNr4ynxK6
 BceEjVYgH0+cLjAPKhE7eZ+HxFZlKSJSdtRPl0dCbPePKJbT1Y2gYvtIOpygCHhxNA5x
 buMis4Wa5BpBPfL99y0y3kCdNTQ2m765w29V9SSenvy3NdSVzX3QfHNspAh6Tn+e5HqP
 6VGO9+l0Ugr7IaGUSj2HSBzkehrlOvxbvWDS86ST0fpODSH/Ev7VuAzfKQEITISvGJTH
 Aw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748670; x=1711353470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqiVcWk+QPelPVCWArv8qjPW16I407GHPXqES+lc6zE=;
 b=FbnBxPmEaAUaLK2J0SQSzzQKCr5KuPIKuMsycceq6gX84JK0CLtf+SNz4igUKHi1XJ
 uuldZSWW8wJWIsYgixXN9IbJnCOOh1/qqyQ8zsnOGZaHQ3ffPrYQXefVV4EC+scvZ4Jn
 v94xaExBJy1ysroRjvVq9lSRG8y7JpOB3xve4VKJ9fTC8qcwhPG6hPsQEsVR9YDzQ4D2
 8rxx9KCazDXk7KUcxC86cGENjQXaRS/7hCoboiL+3hvOniOS4BowxWe0jT3Sk8rJ6fLw
 mRU8lC4Thx4VU6bl2xu184veqZ5G7PXfQeygw44C4yUvdiOumfxNgbEVbnASxQyexAg2
 I8OA==
X-Gm-Message-State: AOJu0YzvOwA2dXwfSARJEbYvi4Jo4KkUprerU8aRi7JchcqClAqv41/o
 jdaxaWA5P19o5DTbIj5K/KuyPqYYZnMaqinAK5DYUybGFXpRxHE6JvlalM4/ASo=
X-Google-Smtp-Source: AGHT+IFx4IOT08QmWZ798sWG1j7X/yo8oscEfc0l1dGvHIJ+plR7oN3ri1yHNyYjGFzikAyQjPCbwQ==
X-Received: by 2002:aa7:9805:0:b0:6e6:f1f0:c55d with SMTP id
 e5-20020aa79805000000b006e6f1f0c55dmr11919650pfl.4.1710748670476; 
 Mon, 18 Mar 2024 00:57:50 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 m24-20020a63f618000000b005e43cb66a7asm6652825pgh.87.2024.03.18.00.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:57:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:57:42 +0900
Subject: [PATCH 1/4] ui/vc: Do not inherit the size of active console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-console-v1-1-f4efbfa71253@daynix.com>
References: <20240318-console-v1-0-f4efbfa71253@daynix.com>
In-Reply-To: <20240318-console-v1-0-f4efbfa71253@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A chardev-vc used to inherit the size of a graphic console when its
size not explicitly specified, but it often did not make sense. If a
chardev-vc is instantiated during the startup, the active graphic
console has no content at the time, so it will have the size of graphic
console placeholder, which contains no useful information. It's better
to have the standard size of text console instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/console-vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 9c13cc2981b0..f22c8e23c2ed 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -990,8 +990,8 @@ static void vc_chr_open(Chardev *chr,
     trace_console_txt_new(width, height);
     if (width == 0 || height == 0) {
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
-        width = qemu_console_get_width(NULL, 80 * FONT_WIDTH);
-        height = qemu_console_get_height(NULL, 24 * FONT_HEIGHT);
+        width = 80 * FONT_WIDTH;
+        height = 24 * FONT_HEIGHT;
     } else {
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
     }

-- 
2.44.0


