Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A02CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLA7-0004ke-8k; Tue, 04 Nov 2025 12:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9k-0004SY-UZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:23 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9i-0005nN-R0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:20 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7260fc0f1aso77256966b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278556; x=1762883356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YZXK3nuZcQjjiZcCbE6oyS0LQ3n6CWuMvy46laiUPyo=;
 b=UfymBDVcloVjtyAiYtWWRKTGqIhibr80CReN6LZOGz3Wf154O9GMhw/lxQnm6ykW4A
 h+WPLZUTiH9KGiFWY7fjE3ec7ZH+xlVUSi4NivsoQNc6ZPWM8Pe9HEG6Ue9hPxn4eMz2
 S7OkgNgWePPP5sREnFixbEk3VdC2hykV9hAED35q1eA9DBI1A53GvyKCWxcViQFopF77
 ma1FZ+We+nX4DNHdBTQhRxkuian+Yq5KGWFCmqsr8lG2lvcLkaCcXNJHRPjrzIh9oEF8
 LIjTiWq7orGN4WdJ+CHr8lPLMayI/8XBvasCNVg87ejlbrbMiyX6lPwRfY6FaRlL6yhS
 YT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278556; x=1762883356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZXK3nuZcQjjiZcCbE6oyS0LQ3n6CWuMvy46laiUPyo=;
 b=VzAUmuOhXvqLtWQSOv/P7XFLltNb2i6KsuhLaFd0V9OC4gVQ8ALIFfeRcI4t8eoBLp
 4b0yZBUKbN/vO2q44UkSaDHmObHcGaIxgSNwUKv7IsG03oR7YSGaTe0tQNW4iNqaX6tj
 uTvS6VQtVf8WRq0TMWM/eUM7mwrDIXidCOnC+K7vIZmpk43hAQbT/UnZQ1M0ctsgIjsH
 kkKsYHRaUxbBcJCNRq8k4vJTaWoOiSdMM+WTkYFEpuWh+ptxysiyf4JRYE7jzAaE6AB4
 UgDnwCL0Qbx13fW+J6n3kbZ9AyZk8xytUlq+WLrSe/jHtuLwYuF6utagLLaflePvVsqX
 QrSA==
X-Gm-Message-State: AOJu0YwTz8yLcESg5GT8lZVF7H5HFGbahYK6YmZiM7+9fnrKZQPiElig
 MJxWny0mspkTK/L06OxHJjeNlpWQTl5QIYlY+d1qSYzZKxGRTvRfbsA04XN2mna2Wo30GjWD5Sv
 XXOY1LKDs9Q==
X-Gm-Gg: ASbGncsBsIfUu9uPo6CH1xO+Z7eycILnDbSEsIahkOUZLCMUuKQtAuuML5M688ycknE
 R6J9pru8Tak2DSgaKNA+Jc23UbQ8ou9maI451AGGM1IZCZu6XWuBHV5fVcSHRLo4MdnRbL1gcJF
 ySf/YnZzhBOgsdhe0KCcGO3IljQAWsCmfRklGOfdnJH+Zn0Qd3fQUQEBM1Q1klLBMR68/BBh4+L
 c6yk5Cse0qZJ5Nvbjq5duCmbHqMDxvykqY22aJlH4PHd3qsnwVKRf7DL3HLZTD6PQBYU2B5uppo
 X848gSfW7UamjV1fewtzsc3CkzJAdFmn9pIrXFNAdicjHRBxRV2aTG5PFKld6TOw7GlPtyRJWDJ
 fVysjIM11h7eEHxsLh68kkGyocMpkqoIo4tAY0J0fH0nEcWwS83YSmkOsarahbLKnMWjmfEtzLh
 KH3sADF9PbWjOQidzGgjnCcw==
X-Google-Smtp-Source: AGHT+IEVHUOtj1exTgF49Kvo62x1aJ34EaIij1wyQiCavWzV/W89NL2o9Z6aU+pLFk5g6N2s2x7+sA==
X-Received: by 2002:a17:907:3d9f:b0:b72:5a54:1712 with SMTP id
 a640c23a62f3a-b725a541c76mr197893366b.55.1762278555532; 
 Tue, 04 Nov 2025 09:49:15 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa023adsm260603266b.51.2025.11.04.09.49.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:49:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] hw/audio: Remove dead code from ac97_realize
Date: Tue,  4 Nov 2025 18:48:23 +0100
Message-ID: <20251104174823.92412-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

Remove unnecessary PCI configuration register initialization that was
marked with TODO comments indicating it's redundant:
- PCI_COMMAND register is already 0x00 by default, no need to override
- PCI_BASE_ADDRESS_0 registers are automatically set by pci_register_bar()

This aligns the code with the pattern used by other PCI audio devices
in QEMU (via-ac97, intel-hda, es1370) and removes 15 lines of dead code.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20251102231903.65409-1-osama.abdelkader@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/ac97.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index be7a39377f9..60daa62ea33 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1279,30 +1279,11 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    /* TODO: no need to override */
-    c[PCI_COMMAND] = 0x00;      /* pcicmd pci command rw, ro */
-    c[PCI_COMMAND + 1] = 0x00;
-
-    /* TODO: */
     c[PCI_STATUS] = PCI_STATUS_FAST_BACK;      /* pcists pci status rwc, ro */
     c[PCI_STATUS + 1] = PCI_STATUS_DEVSEL_MEDIUM >> 8;
 
     c[PCI_CLASS_PROG] = 0x00;      /* pi programming interface ro */
 
-    /* TODO set when bar is registered. no need to override. */
-    /* nabmar native audio mixer base address rw */
-    c[PCI_BASE_ADDRESS_0] = PCI_BASE_ADDRESS_SPACE_IO;
-    c[PCI_BASE_ADDRESS_0 + 1] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 2] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 3] = 0x00;
-
-    /* TODO set when bar is registered. no need to override. */
-      /* nabmbar native audio bus mastering base address rw */
-    c[PCI_BASE_ADDRESS_0 + 4] = PCI_BASE_ADDRESS_SPACE_IO;
-    c[PCI_BASE_ADDRESS_0 + 5] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 6] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 7] = 0x00;
-
     c[PCI_INTERRUPT_LINE] = 0x00;      /* intr_ln interrupt line rw */
     c[PCI_INTERRUPT_PIN] = 0x01;      /* intr_pn interrupt pin ro */
 
-- 
2.51.0


