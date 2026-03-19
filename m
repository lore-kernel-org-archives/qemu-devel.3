Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E271091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mka-0000ki-7I; Thu, 19 Mar 2026 19:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkX-0000jr-Bo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkU-0007ct-Uj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so328055ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962753; x=1774567553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnpq0ftMx8G84qoaXkcolzp3tfJeZoMWYUC6e4g/8hM=;
 b=eNZa8EFwRdPW/ZuSsvyxqEuvgfNKYQVnRoe03Zfw1T4lHOPSAbsioKvcNkJ61dRg2B
 5kTiGZXv1UzF5sPEhjyCH+LPNXyz6ZltlFyurfxLNQqC4og/Hz/1WkVV5xsqij151M77
 RYfhYqi3YG0s3+Ih+OQ5909dEeGzziZETp36wEhaG98cBd3nRxp/sUUUubJXK2e1dPB0
 3yJg6vXcx9p0BpT8dy7xUdYxjBWWSnZKaPs8WLe01EE5pppEEjq8GyTx2f4MiNaskCH3
 Y6iP9F88mnOeKlhVVBHTrI8dtm+IBXIje1A2d3g2rzOV3sxD83mKsbLCB0gxtBy5iHTu
 U8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962753; x=1774567553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dnpq0ftMx8G84qoaXkcolzp3tfJeZoMWYUC6e4g/8hM=;
 b=Lu/UVpvYA/trmRmEC1Ee8ml1tlAHUh8OLrPOGahcTfQHhskswxIVquR/HXEbEdkN61
 F1L2pIxrDcbT+o7+KOTV1GE4Xl7Eei84fqj9F/jGmeR7D+WpjO1pR/Y4GHgBWq2qxkFu
 i2li87x4+hQrT2GYXZd8tLD9e+HRebi8TGhVq+LvS5tkiFfjMSmB2lIppy6EK0QTlSdM
 asjCQg/W4kFn65dHlwQgeq4rQk3DljRPmUANNe6nm5mX7LUJlF3W/hTdRibr6snMk+gw
 MxB8533Yxa941t+KO+qUfJobdMWRP+qO6q3Y7AsnoIsXvSDeerMPSnTztv7kIsi5ZOh+
 TlyQ==
X-Gm-Message-State: AOJu0Yz2vLcj7Os6qS4EYwSBndz32qN+6m3uTYY5UyFrSsLWuelIJ9Gd
 CiYPHXror6SzOKrVUiuJtkVJrZrFCjgqJZd0+bp4NSukhxJzDP0rezSCSoS2/Q==
X-Gm-Gg: ATEYQzw+TDOHU1gUhchrN3QN8nrHyHXHa8pySIxBCIh+nsoMpXPI/Qq+W+sGawkw6U+
 BHFsmVm52xSf02DG0WotSsynwd6gxAtS/oL+srXeJqwESDs3n245/2xPX3Mzm1V8lfFfdrw0pXh
 bEKoUD08thhM3pyQud3Uf8qic0SX2g7G4cbNHA5tuB89A8ItX7xSUHpE0UItbw9f36yM33a2iJy
 Uq7e8Mkzk47q/YE28XqzSh0RUIIYtzn/lDsRjE3LTNnTcAbPnxOe0NF/leYXY3O8JD9EExDlvEH
 m1q1DcW+VY3WnIqqRRMG2VO13g6xRXqgkP20SQalDsRUb7cP0n1vWd+ieX2Ieq2HUe7qsq88dIk
 6sWo5FnmDRd96DMY3a2IxGPPyRbuexHGa/vtbaBFxDp574a1R0TSosvtjbuz9WpbW/YgYmNy/eC
 db+qfHW/GSZEURSMyLaH9I4gRW+DH1cq9b2S3pF84DdQ==
X-Received: by 2002:a17:902:f790:b0:2ae:6259:5aff with SMTP id
 d9443c01a7336-2b0826ffc3bmr8420105ad.6.1773962753006; 
 Thu, 19 Mar 2026 16:25:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/17] hw/dma: sifive_pdma: Set done bit upon completion
Date: Fri, 20 Mar 2026 09:25:10 +1000
Message-ID: <20260319232522.1867400-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jay Chang <jay.chang@sifive.com>

Ensure that the 'done' bit is set upon transfer completion, even if
an error occurs, since all transfers are considered completed regardless
of success or failure.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260304030816.33209-1-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/dma/sifive_pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 6d06ec0375..7b22e51492 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -153,6 +153,7 @@ done:
 error:
     s->chan[ch].state = DMA_CHAN_STATE_ERROR;
     s->chan[ch].control |= CONTROL_ERR;
+    s->chan[ch].control |= CONTROL_DONE;
 }
 
 static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
-- 
2.53.0


