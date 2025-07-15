Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F712C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1t-0002zU-6r; Tue, 15 Jul 2025 02:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1Y-0002to-1O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1W-0007NX-5a
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so2779182f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560416; x=1753165216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7S4k+1sCMPbW4jtmuj8Za9v8Er4TEjQFuXvwHmkJEF8=;
 b=RSX3zvOeBJKdL7G2vc6sOSq7Z9d5pjUmj3b0NvC+jjTAgzYREus5J5EhXvwGXcc5c6
 UGQsTqK7sN1UTbH6n2U9huKhzsg+ycxn2tWTjda+kTrI3Le50OOrCDB4XsmRY3CrAHU/
 K5HiEYO6WqJrb4jCjBnia4qf9HO0pSlnbhqcffc+tASIqcWy5EXHIRcTvBhBTn0ejVJS
 m36qhSToY5iR8NbOnqQeYHJIVC24+f+Z6U2QYGDxzpcFaG8hP/faxHdgkRM+3sqxTuaC
 ktygxzbych88RbwYyb8znpawdwFHOpJ6gNkFh7tm69a1IQ4qs9UH+EDOreGJuwPaZjGs
 xmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560416; x=1753165216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7S4k+1sCMPbW4jtmuj8Za9v8Er4TEjQFuXvwHmkJEF8=;
 b=m+kCriuCthCZHVhumcqpxcx9tI7gi+qBlR9pTEoeWJDJEujFklGSWIHXCoBDr+YZx6
 6Zu63ZlS2WgRwBBT5zAOF3gpDXTEF0Q7y05nc3QwGnmV2V3cyzF5cBUvpH26ijqGMtKs
 IfU/5axrgq6aQCt68otpxA9NjW6ck46R01Qb89fxIY26iOqVyFqe1W2tLSTzP2Hl7H9q
 g3Stc9YFJ1D2tb6SPFgZKZDfCzrlqYDokMBX5w2HIh1JE8/uG4QK/uLb4dsnh/LDYD2O
 oB7DDU1Tgn2jXMbBCJ+VStj8VtOFONFRHCVxbekf/4tKTiDsEJDyj+XNu33IFQJVOF68
 t5SQ==
X-Gm-Message-State: AOJu0YxjY5vMvLQpaqRLvogW/Y8axvgTg/ipmhngcaAOAxEioRFm21Rw
 x66Ost3EdSz01247594CM1CJUemhI4E1IDcuZiwoT6KvQdaik3LRa+pE1oZxZ/3F2jMZF7oR7xZ
 ZB70/
X-Gm-Gg: ASbGncsxAF3qrmpjVDLDfQth5oi8Wi8amJdrUmKlopLPZJR3P9ViH3nX7Of62qrrjlJ
 J+bCx4IwdBDb+ejEFWcBMaW3bwMwxlSLCDLTaYO93yo8x9sRp4PegVbkRP/5b4PGLOXh6JQHukq
 ZV9Y3jgwmJFkM0bWtkgw6ELi2Vd86UpZ8UIZ+H/pfMG6W8zO/x43NgvHjQ61WhPg3qgySGFerqE
 4MWF/v9EpsDgMUaWzQcjXUuOD6QxjiowT0YQ5LhdBSaprWAuxypIk8Yqk7v39R/FD7wlUGfPiCl
 EWZZnHjS18zBZKbR1g70o02xJsHW0+6foMtSt3GHrYh2phVHmc8EfhajKL++dBtuscIWJWBXuxz
 Lf6iUqjEJnofmAjNk6KlSRN4ZukLO4SxUW08nrLLnbLo5x9lwbl4tpnlcANlUqQovDiWPUqna4M
 +hnXbynH4=
X-Google-Smtp-Source: AGHT+IE13DRpDAZHNWNLqC33BuyPYsxffkUHmNlJ7fn3LlYk/Wav1o1g7jLoeHvFsMgbUYv/e6Gmuw==
X-Received: by 2002:a05:6000:144a:b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3b60953f5b3mr1848784f8f.23.1752560415969; 
 Mon, 14 Jul 2025 23:20:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9268sm14141612f8f.41.2025.07.14.23.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 11/17] esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL,
 CMD_SELATN and CMD_TI commands
Date: Tue, 15 Jul 2025 08:19:11 +0200
Message-ID: <20250715061918.44971-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Clarify the logic in esp_transfer_data() to ensure that the deferred interrupt code
can only be triggered for CMD_SEL, CMD_SELATN and CMD_TI commands. This should already
be the case, but make it explicit to ensure the logic isn't triggered unexpectedly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f24991fd16d..9181c8810fb 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1012,6 +1012,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
              s->rregs[ESP_RSEQ] = SEQ_CD;
+             esp_raise_irq(s);
              break;
 
         case CMD_SELATNS | CMD_DMA:
@@ -1022,6 +1023,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS;
              s->rregs[ESP_RSEQ] = SEQ_MO;
+             esp_raise_irq(s);
              break;
 
         case CMD_TI | CMD_DMA:
@@ -1032,10 +1034,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
             s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
             break;
         }
-
-        esp_raise_irq(s);
     }
 
     /*
-- 
2.49.0


