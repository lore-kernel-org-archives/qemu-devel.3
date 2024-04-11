Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2858CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruruM-0002lt-VX; Thu, 11 Apr 2024 06:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruL-0002kv-A1
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:43:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruI-0004BG-T3
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:43:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-343f1957ffcso449401f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832229; x=1713437029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3g1QSRg86bxVtcxnKKn01h0Ac3fWVT80PO+fMEEjTc=;
 b=ujZpLNuGHK2mgdbNq1+2c8R/e0NYK1eJuktMVqdvKiJhiB4WtUPEa8yu1DKTX9KJu6
 iH3B8pl8mwtJE3vId/+Xvaz9Eyy53LyIZLniC92hpKueuIJ9gXidZVC+yYgSSS6SzpfR
 HHPINm0UkW+MKIFrPbo+M0FriOEdFfbvIDWpoSAPMiqq8/iOUcrsV8i+tYCvQNX+/8sC
 DQu4PnehSbTywx1gtfTnnqFRQ2T2teeXLgdQ0+1b5C048d8GuPevS1kigPRLqteMFuQB
 +ob8Y0yH/Q8fvaWpcAEKS+ZpHNraGxM6Ns7yTXb5LoNRzsPBIM6W1zEwKo/zQwqNlVA9
 9izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832229; x=1713437029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3g1QSRg86bxVtcxnKKn01h0Ac3fWVT80PO+fMEEjTc=;
 b=lnqLnH+DVk+XUbVSpQq82dR3GpK1VSEiPefytIDHou9A3d+GRwBah3XR2YcahcshD/
 06plHmXgqDiTQeuvzXVCWhUHY7f/LA9TOgceO5KqdYkIs3QmJK0f71w0cpllzOp0hZWG
 XbJEou2fql09EkOIrxJGcOkdKNgPqWnUBN4LD2vET+ZwmiPoLGaWkeMfXclMpxGp4A17
 9d1Xk//MiDWql/eK7Zue/49rAqxBwZfTWRVo/oIqH1vKoFnH0VOgkE6rmMRYcNLjjTma
 ono1yGd9ISfqnrl7C91TcukeHWrLhDJugbcc5L/WOv06PaihUrRVIfQ++RmMQZGWL6IR
 rkfw==
X-Gm-Message-State: AOJu0YywRDbbczg9elMXAWq4Y7PrR9elTfuMxnmg/q46JDf4458/SlPr
 +YX4Lkz5CfihNPfOHTqB9nV/4FAp0VJ1F4h+2B/MMdj3d2GaROfHOoMBpsiEllXClkBFvvnN6Q3
 n4kE=
X-Google-Smtp-Source: AGHT+IFE1VighhGsxizlW1KVNqq6FJI4NrlkdeqVvnU3HOZQW/MzQeccuj1xC3nxBApNspbdHZsN6A==
X-Received: by 2002:a5d:456d:0:b0:346:65dd:5580 with SMTP id
 a13-20020a5d456d000000b0034665dd5580mr1693002wrc.3.1712832229124; 
 Thu, 11 Apr 2024 03:43:49 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a5d6245000000b0034334af2957sm1469250wrv.37.2024.04.11.03.43.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:43:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/9] disas/m68k: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:43:32 +0200
Message-ID: <20240411104340.6617-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411104340.6617-1-philmd@linaro.org>
References: <20240411104340.6617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/m68k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 1f16e295ab..800b4145ac 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1000,7 +1000,7 @@ print_indexed (int basereg,
 
   /* Generate the text for the index register.
      Where this will be output is not yet determined.  */
-  sprintf (buf, "%s:%c%s",
+  snprintf(buf, sizeof(buf), "%s:%c%s",
 	   reg_names[(word >> 12) & 0xf],
 	   (word & 0x800) ? 'l' : 'w',
 	   scales[(word >> 9) & 3]);
-- 
2.41.0


