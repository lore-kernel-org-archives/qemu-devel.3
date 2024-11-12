Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62B3D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNG-00067N-TI; Tue, 12 Nov 2024 13:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMz-0005VW-FB
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:07 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMx-0001z4-Tf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso51243825e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435121; x=1732039921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohlThsqTDYJV0UUntSqhYfwl2qcDxuvkfJ3SWeMXrgc=;
 b=Jsep8KWXpTFO86G89uvfXeLygnFkwT6sGBjk/7zwky6uTn12iMidNt3iHS0D4zGvUe
 OOdrcdjX2TUCwNWNyZYHROmJiX1RW40iDEimL4IehIxNqSLozHuS/9kJduPGrboF/Rt5
 z1PQTr1Z6pyXP6vFyDbJWiR32EDrTlgc76m6gZ+lX+ApcuGPyg2gH4MSJ5y5IFLIh/cL
 kPyA/koFKi9WiC9sHcevLfzls5SJMxRxgsWlKNLX8W47hGwTnNCKco8B9c6STA5uePKj
 ZPwcA+FP30FOygWwLgO91qE2C2k/pu0kmRNNyGiJy/pxf8JCqXGLpru7C0vxw91s18oG
 p0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435121; x=1732039921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohlThsqTDYJV0UUntSqhYfwl2qcDxuvkfJ3SWeMXrgc=;
 b=j5Ydn3K7/ixAEcTMfO92Sp3kPa/rB7AMQWGNfX8jPKN8wI8wx68MKxN11k+WbvcMWL
 /ZyG6JxY7TfDnrUwd/euSamNOHpauyhPdSrei5n5mtl46tY+CrXlDAY87Jpno2IEyiFS
 AOyQo/vGavBIGcT09/u1FLJUWZg0/NPUCO3YXhsHf3kIf/Uy9zpC5vk+bHJlKab0Z+y7
 j1j984zfY+gcgCIPL3M+tISMtnoqIEe40bRnwBcxMiZBGEeeeQ1kfsRlbWQ8PibRafU8
 aBD8Nd+PdpIBDEVWqKKJqC3xMl4qSgRsggJ+jvUZW6apKwRF2aFpqviEgsYJCMw+KcZ0
 yP0Q==
X-Gm-Message-State: AOJu0YzswWnW3PH674CrQc1QP5pFbXQvnT0ABCiHcT6sPvmb72TEfihD
 O0S+F0nIB9t94Wa3Jt3msdAhYwF1DT+AVAlGmOcwIgcvJ7I1zbDLNxo4250ak8zNv0c6gaKFw0l
 P
X-Google-Smtp-Source: AGHT+IHewBgUl/r/rZkSWf1ZAQ5GjFXlyGBqB7iE1gEiy0AGXiFVKe4ZvvipFnchcE1fIifPbdQ1FQ==
X-Received: by 2002:a05:600c:4508:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-432b74fecacmr145637225e9.2.1731435121585; 
 Tue, 12 Nov 2024 10:12:01 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa7378e9sm262755635e9.37.2024.11.12.10.11.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:01 -0800 (PST)
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
Subject: [PATCH 12/20] hw/net/xilinx_ethlite: Access TX_GIE register for each
 port
Date: Tue, 12 Nov 2024 19:10:36 +0100
Message-ID: <20241112181044.92193-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port TX_GIE. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_GIE0] and s->regs[R_TX_GIE1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 605451a522..4cb4781e70 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -62,6 +62,8 @@
 typedef struct XlnxXpsEthLitePort
 {
     struct {
+        uint32_t tx_gie;
+
         uint32_t rx_ctrl;
     } reg;
 } XlnxXpsEthLitePort;
@@ -90,7 +92,7 @@ struct XlnxXpsEthLite
 static inline void eth_pulse_irq(XlnxXpsEthLite *s)
 {
     /* Only the first gie reg is active.  */
-    if (s->regs[R_TX_GIE0] & GIE_GIE) {
+    if (s->port[0].reg.tx_gie & GIE_GIE) {
         qemu_irq_pulse(s->irq);
     }
 }
@@ -126,6 +128,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
     switch (addr)
     {
         case R_TX_GIE0:
+            r = s->port[port_index].reg.tx_gie;
+            break;
+
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_CTRL1:
@@ -189,10 +194,13 @@ eth_write(void *opaque, hwaddr addr,
 
         case R_TX_LEN0:
         case R_TX_LEN1:
-        case R_TX_GIE0:
             s->regs[addr] = value;
             break;
 
+        case R_TX_GIE0:
+            s->port[port_index].reg.tx_gie = value;
+            break;
+
         default:
             s->regs[addr] = tswap32(value);
             break;
-- 
2.45.2


