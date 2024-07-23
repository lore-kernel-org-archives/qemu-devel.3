Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJn-0005QQ-JK; Tue, 23 Jul 2024 16:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJl-00058g-EB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJj-0004Vb-4U
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so40096685e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767261; x=1722372061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+mMJVnZoHb8TN0OKgay2wr/RPzQblLQjBQP+26HLiA=;
 b=EGyVCORbD5+5m3pLGsrfX0NJkFSawwF99QsB1ohI4ksFqs2n0/4hlMLjASng0Jm1GW
 OQM7Sz9lnWc4w3f5cqduLVIQfn9oFqAXTUxhyuFCBEFWlDSypHRb1jXN13e/TbamOLpy
 JG8VoSdk8xl7XxhL/rop+OneIFlnpDDqkkdXuKV+qkaiX2tdjC9LI+c2xObz6Q3YUkka
 aWmMCtUiFd9ULd/NvxSELpguR5Qa+Ht/lcrRyTMPTf6NgHg/ozwzTjoTpODX0hrRFzuu
 Z3+ubmXJMhEZ8/uiRAPc7SV9Hl553cz9j7glaRBVeoxQxWvzYt2+oYvoJquryssNYUt9
 uwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767261; x=1722372061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+mMJVnZoHb8TN0OKgay2wr/RPzQblLQjBQP+26HLiA=;
 b=LcBYWGbf/GS3fU2eQgXA6KT2kr926ixgsfN9sy82Yo6OZMXW3jEOB16rAHBtPo984G
 /tIqwYX0yARmq3EXDdfEzeoLX8vsr372KYb2D2COVStcA+UuLUctTOeharZCdu0kmBUB
 FJoufWBKPCbRFaoOuICBoYUiHdXafjX9Vdc8U0JSAv1U8HWuVZ1JVf4Px9G60IjpAYpr
 fIHUT8hLM2kuhfD9oOGa6VDU/+dOmUKghbVR1tardrbqWn+xq63Fbaw1WQ5ZfJ16flvs
 Y8+edQ66JScFCXCmXHaXuNFPonqlzMD608OlSbs9ma3SWWOzHSt3ILLI3HkWmCIlVpU5
 HvzQ==
X-Gm-Message-State: AOJu0YwyKDdPNvfcceSBPC31L0lBan4Vp10Yts/fg4yhit2RsrkVTGde
 xZe2ahT6bPdGzvinMxDXP84dvHeA5XIjNs47NtE6hPxrCIAxjEenHYLOC4nPpYKFKwOMQUTeWz8
 3c+w=
X-Google-Smtp-Source: AGHT+IEY7krJaQ0Pp+xSIpUsbMkpjUsopIY0G86nEQ7kjJKNGa3xvVh4Ch+UZdD4xDBsBt3kI1i7OA==
X-Received: by 2002:a05:600c:314d:b0:426:55a3:71af with SMTP id
 5b1f17b1804b1-427f95b714fmr15955e9.33.1721767261042; 
 Tue, 23 Jul 2024 13:41:01 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9397204sm541795e9.21.2024.07.23.13.41.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 22/28] util/fifo8: Use fifo8_reset() in fifo8_create()
Date: Tue, 23 Jul 2024 22:38:49 +0200
Message-ID: <20240723203855.65033-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
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

Avoid open-coding fifo8_reset() in fifo8_create().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240722160745.67904-4-philmd@linaro.org>
---
 util/fifo8.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 4e01b532d9d..2925fe56119 100644
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


