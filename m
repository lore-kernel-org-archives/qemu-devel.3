Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95687D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvND-0005uu-Ui; Tue, 12 Nov 2024 13:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMm-0005Iq-U1
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMl-0001y5-Jj
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so75421105e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435110; x=1732039910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gI2r50YagKyW5wjp5nKAHhdiWka7DOBUV8IxoWF7VBw=;
 b=Q5FxZrwrzHcyZsvR2yYfhrNXbeVXyvPScvRu6n9M18XyWEcosFy+Q6REs1W4+0VglH
 Lu/qS1luLeN9BRD7xm7jaqkf+PDF1jrTU3cwN5vq5Nk5xU+S3hzww1rBJMT5uJ1M+sGl
 LMyoL0sT8ibwyapp9tg8lRy4aGJvwN5dgU0rL5ToAYLsWnUY/p8KV+RMqwwSHcjDMef7
 IWk3/1ED/BaSCTyBbYOyYkODyXEMrEo8ukqaXkK4t/m/mjLSPlGWVKoWxnJzirqRNzQi
 ceOknAOr6UOWReD1y8fF8k5xFHufvIQaIxc7jzjJ/5wRUay+fel2twTDhXbrtFb58G02
 YL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435110; x=1732039910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gI2r50YagKyW5wjp5nKAHhdiWka7DOBUV8IxoWF7VBw=;
 b=GHmsQmhD5J2tgGYPuR4vjaxab+8NsXZhHX8oxgXanLgTN+k3diu1A0JIiWcK1xh8ct
 fcZIcs+ika0LD4T1lfPD/yV+x1F7KHKfOxsQGTfkKGHKdP+XT1y2ye1WOgPyabc3XISF
 /1qwifA3fbc3g9JpLlAnC2bnGdJH/KhAxSpDMznuJkPywZlJvCDbqJmCDGVFtvEyoSiA
 Hyw0fFQ2lbNnkXFGWkL3INAStW4/74ZeD6YORUpL2k8P39BNaY3+ycXv8+x5o/c0S2GC
 kTJB8FY8qNXJomGWu+8ncRKMXOVdXgUQZPcwCnnxfc8ExzyGmb2GQ6L7GHJxCZDaUedv
 FN7g==
X-Gm-Message-State: AOJu0YxLfPwGNz35Bwb6PnNlvVIrUhtB5Ztf2KWLfEBSWaH8u0d10v9i
 gUTEAZV2dqNIFX+ivt4ajFZl0li0xLEN1Asp79gQhDpO3ZcaLz2Rf43rClG1+VWnxQIkn2qE/IW
 u
X-Google-Smtp-Source: AGHT+IE2DEwwyKjYwPpSKfqMMUyKv2JpripMiiiLbqBcnHO0uOc/QmnUwfSLHMA/F+LMcwCvaB7I3w==
X-Received: by 2002:a05:600c:5494:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-432bbf6ba6emr171715275e9.26.1731435109702; 
 Tue, 12 Nov 2024 10:11:49 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda0517csm15935048f8f.96.2024.11.12.10.11.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/20] hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
Date: Tue, 12 Nov 2024 19:10:34 +0100
Message-ID: <20241112181044.92193-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

rxbuf_ptr() points to the beginning of a (RAM) RX buffer
within the device state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index d4882f43f7..fdbf25fd91 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -99,6 +99,13 @@ static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_TX_BUF0];
 }
 
+static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
+{
+    unsigned int rxbase = port_index * (0x800 / 4);
+
+    return &s->regs[rxbase + R_RX_BUF0];
+}
+
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -220,7 +227,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
-    memcpy(&s->regs[rxbase + R_RX_BUF0], buf, size);
+    memcpy(rxbuf_ptr(s, port_index), buf, size);
 
     s->regs[rxbase + R_RX_CTRL0] |= CTRL_S;
     if (s->regs[R_RX_CTRL0] & CTRL_I) {
-- 
2.45.2


