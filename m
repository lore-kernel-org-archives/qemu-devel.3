Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C65E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKLU-0001DF-Un; Sun, 21 Dec 2025 09:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLS-0001Bn-Nf
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:38 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLR-0001Ii-AO
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:38 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7fbbb84f034so2390663b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327016; x=1766931816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dG0Amvc2GaV3WxbJOBLx9QPvcppOVvNkAdmdXpA0Nyk=;
 b=WDLwNhsOYIBO6frA4q+/itGRwkirhN3aADw2WyeGWXHUzOZIYy0sOpWluDbWDXdOlJ
 C/NoyeC3ROSrGuGStWj6Yqp216YPp57uYsqs1hOfoPohILEPNSBxWkcUd2GyJdAxnZ9p
 aQb4WKPo4KhtXu01YMHacpwwuuBEe0MG1s2v0uC+/H6D3PL0QO2UlLD2e7DMzhSkYg3C
 81NpHRBqZVrEYc3E/UbR4ngC6k0F2OlGrN531ov7rI3q4meUmeQZN5gAOzjtoehyZUIw
 glFjelzxD21dk4ekEfnvBojPMSbAgrO9/B2kvro5mmRhD6XN3uJREwO/iQHWj7bP/LpN
 7Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327016; x=1766931816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dG0Amvc2GaV3WxbJOBLx9QPvcppOVvNkAdmdXpA0Nyk=;
 b=Km6neG6f8Bcbsoq70i7VSD1MESS8QWDXL5diryu/z4EJ2chEoq3abuBnBjbS6JW7GF
 FRrlf+7tNmC4HXHL1dMIDC1zn0FZaIns4ojB8/YbRH4zm6OnXywR/2+kk2D7GgeuyG1f
 pkSoSGLLfpQoMty1YkVIb4kvkwTy1Ud7H9+a8OcRnDD+UUotykdNrv4wgQARSagsM1tU
 /KB/L+AGfrSARZ4JNOnzLxKtja3CBEEB9sZtwIjntBkgIik4BriC0xZ81gU0aYCQplez
 VZK3BxfKnCsOzy85xT5qBOB8qVxCWrTw28QwEdLnKuDZtMvtsyMu92a6me9Kh4blHA8k
 mmwg==
X-Gm-Message-State: AOJu0YzYdsbIqii2nRRteJhsUAr1yTbdnw9tMiV1f7TAXvhBejX8/063
 XZRd0sMrVz3+b9FjKcwgpu0AtAG6Ily3heOVlyK7orcFwHSuFh1cW+EaXZFOTrsh4hQ=
X-Gm-Gg: AY/fxX7iR8Jo6waF8/MS2fvnewC81FS56wP7Z4RtIG/e9b4wuoAEMwaw6nJSTSXcBHh
 la7CkgTlyYoN1uSr7jBtOAnlbDjodUVpSS5HU4JqZtjI7xHIpbqpN9OiOmWc/oau2miqkHNI2rK
 tSxR68U+g/44s8GE2RBWAI2RAQJn65+zpdYqKoRZVqV9WbbmuhJqUxmUkfor5kCWVdUQ6d4uqs/
 idLkPfVuhNpHYdWWUcWo+/HRPgwPvov0+SsOB4Kf8LDZ3pCJwQEzHZ1VfUI+TfwNWRGysU1BktF
 BOERUdFrCxyaLUOITq9r+3NkJzN8vn/O73QAIx+YHidW5SvGio3mZo2np91dVRxtUiT9SkuIx/x
 FxH94WkRh2Y3ruJuNO7P+PhuFihTPRJh32IpePkDV1+kj60afNJzHmTCel+tgyZK1FaeqVJ6E4H
 bsk+5a3p15vU7NhEGLGns=
X-Google-Smtp-Source: AGHT+IED4Ncpo7Kw2eNcQW3k+JW8ba6mTgULtCIVBkBnXn1AioMPUgQYq2c5P8SHeUgzNaQV9rzDYQ==
X-Received: by 2002:a05:6a00:90a2:b0:7e8:4471:8ce with SMTP id
 d2e1a72fcca58-7ff6687188amr7091817b3a.47.1766327015728; 
 Sun, 21 Dec 2025 06:23:35 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:34 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 04/10] scsi:ncr710: Fix DMA State machine and flow control
Date: Sun, 21 Dec 2025 19:53:11 +0530
Message-ID: <20251221142317.266293-5-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Set waiting state and return after scsi_req_continue() to prevent
re entrancy when DMA transfer completes.

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 0b7734a129..e17d1f3fb8 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -718,7 +718,9 @@ static void ncr710_do_dma(NCR710State *s, int out)
     if (s->current->dma_len == 0) {
         s->current->dma_buf = NULL;
         s->current->pending = 0;
+        s->waiting = NCR710_WAIT_DMA;
         scsi_req_continue(s->current->req);
+        return;
     } else {
         s->current->dma_buf += count;
         s->waiting = NCR710_WAIT_NONE;
-- 
2.49.0


