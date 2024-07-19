Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2D3C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs5b-0005p8-P9; Fri, 19 Jul 2024 14:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5D-0004oL-Pd
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs59-0003vh-QJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso14848395e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412707; x=1722017507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grsGKEIQC5JMZTvNvSN/qnaW61vNteYTEI5sYVegySE=;
 b=rSZEVosbJZE0iEj3ZcpATu6RmNENH2lcc3RRV1yZ026+vxKQdVsTffeAjTqDmwrq/c
 m+NLZz7Nc+i7ChbtiMBWfa7fRvygtn8oKm5R6EpggYoAgbYr/r/MQx7/zSh6sTb3VODm
 4y9R8HL7sssqOjuWnHwCtcgH4+IBQgT4o9ZRiBcqLqVuvIJV2wckjJma/IOsBRgwbYod
 /ImD1KzefSI8vAQMJUJtSY3LfBQ2hCEfsKve0qQG3tKOjtckXhBfEd8a2O6/b2pjvajs
 bXWRYhum7j5CRlk2dhZcPojt5a5nOJLhM8plJMhtWpLxu/khacWuiXqyNr5+09ZW5+j3
 P6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412707; x=1722017507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grsGKEIQC5JMZTvNvSN/qnaW61vNteYTEI5sYVegySE=;
 b=jSzJONYc5jYgXNuk/ZimapJ15cOoby8y4TY08iuVeSd2PjnkLgcTf2nIeseHGF1Tn+
 SqYBBGddHB0vBlwGy9VZ40b2TuzyHeKMzdvTMKPU+BlGIAMNzJ41uWzqmAtiXW21qtzh
 Wqh7ib6bb5zTNzciLPunLc/AGWLC5WJQMKqvenLzlQpUgPS8nndWRKh6yDzq9GdyKsFy
 Qyk41sfPt5uJ5qJmt0vzRAjN7HyVRj8QTPqUQ/hIwZMQ1NW57AEUPY+C2GXnMljoYqDx
 dvQwkV05VDTpUVv9aUwYydWXKTti/e9ExDi+iIzOXNy7WwE3Vqom9nvovII742dpEyHQ
 j/Ew==
X-Gm-Message-State: AOJu0YxmqindwNsj7QuGBLBEnapP/poIttex/S1AFzrqCWK6QwLZ2p6W
 b11nVLdmuQnsNcGKot3WIANZGpzQ+Hde8dYd86GUE1kCOzQ+d02I+XgXlR3lBO7fM2+fmB6O4zF
 R
X-Google-Smtp-Source: AGHT+IEAoXaf0/G2fVClsxjzD1Mv14qrcJ+tc6r5Tl38cqGiH3clJ3oMaSvWDUTbYP/j+Dred5O2Pg==
X-Received: by 2002:a05:600c:3d9a:b0:426:6ed2:6130 with SMTP id
 5b1f17b1804b1-427c2cb6a6bmr54800415e9.14.1721412707456; 
 Fri, 19 Jul 2024 11:11:47 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6906a96sm34009935e9.22.2024.07.19.11.11.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 10/16] hw/char/pl011: Check if receiver is enabled
Date: Fri, 19 Jul 2024 20:10:35 +0200
Message-ID: <20240719181041.49545-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Do not receive characters when UART or receiver are disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c76283dccf..0ce91c13d3 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
 #define CR_UARTEN   (1 << 0)
@@ -481,9 +482,11 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    int r = 0;
 
-    r = s->read_count < pl011_get_fifo_depth(s);
+    if ((s->cr & CR_UARTEN) && (s->cr & CR_RXE)) {
+        r = s->read_count < pl011_get_fifo_depth(s);
+    }
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.41.0


