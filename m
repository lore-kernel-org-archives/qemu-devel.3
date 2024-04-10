Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB9ECD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU2W-00069U-6j; Wed, 10 Apr 2024 05:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2U-00068n-9Z
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:42 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2O-0005fJ-In
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:42 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a47385a4379so1386593066b.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740473; x=1713345273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+HfBaogaKesnx0L+UIHNSkZQ9BO28r47IsjVL4QJyA=;
 b=fziNY459L/G51xwhYEsRLnfI7vVFdMBeXLPpaBkzs9h+77XeC6PR4vztYGECqOuQA0
 kVJ4mrFCOQAvDLmjX0OWvt1b+bNmD9Gijw+2VmcyxO12BpkTGE3epGy2p+oThhX2kICE
 6OOfXaC2ZMSAquAhIqMj4H/YSo+YEF4+nu0afR902q2wwgukTkRF0bOcGCreTngK26jA
 Xq+KsEIi/jqEbFzO5paRKYGM/wiA4X1/X//3FQ8pLTbfbA0wHkOEZ5dIPiVDCzP6TLI6
 J0TsYVf36ZW4GnhOenzrTvb26sfctSgqO19hoPvc+3gfwfico9Jvo3KzofIJJ2sBKmvg
 mwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740473; x=1713345273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+HfBaogaKesnx0L+UIHNSkZQ9BO28r47IsjVL4QJyA=;
 b=qCy+aoKqpioyQOCzaZQDiXjXJ2ypWdPaYkVCGx1c3LYJMIQzH4tSGY8s4N+fUakrvh
 JPu7X45LCI2xCHuPPjHf+c3dwAGsQxu2dAVZIuitmds1fvRXENQFph6znK/+G8vpc2Zv
 Lg3FMZg9O0duZshm+VghMsoMcjI7Ls++gtaLFLnFHvYMxF7oS7m6c96xAXIKMWKChWHX
 mN1Lz83lEqeuujpeBCKFH/dV8BfO494aAEQub/UkzMYkA1ojreWRjIrTsuZ8lO0JPmmO
 88ucL43FN4iz8sCDEPcfbji2R47OSD0lPQ5KAtj1kn5vdtmHV+T+a/vtlVA9eE+Tp5+B
 I8jg==
X-Gm-Message-State: AOJu0YzDxSU8tsUEN9TVVNnd1syUKpEKUoMp0stSQpxbFedAc5H3KcN2
 qxDduE6gvPHSUX20c1vf4lvHeW0+GwPLdGWZ2Zj72hp8vhyNPzhOm94zwZWRXbn5E4EUCKv/Aow
 Y
X-Google-Smtp-Source: AGHT+IGoDMUXuKMrP/V8KdlIOOIUr52ADKubzuoInKXcw+xRBDNyFt26/8mDZavXBDNCamsIKesVCg==
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id
 v25-20020a170906489900b00a51b49e473emr1755593ejq.19.1712740473385; 
 Wed, 10 Apr 2024 02:14:33 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 jx24-20020a170907761800b00a46baba1a0asm6723080ejc.100.2024.04.10.02.14.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/16] hw/net/lan9118: Replace magic '2048' value by
 MIL_TXFIFO_SIZE definition
Date: Wed, 10 Apr 2024 11:13:11 +0200
Message-ID: <20240410091315.57241-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The magic 2048 is explained in the LAN9211 datasheet (DS00002414A)
in chapter 1.4, "10/100 Ethernet MAC":

  The MAC Interface Layer (MIL), within the MAC, contains a
  2K Byte transmit and a 128 Byte receive FIFO which is separate
  from the TX and RX FIFOs. [...]

Note, the use of the constant in lan9118_receive() reveals that
our implementation is using the same buffer for both tx and rx.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240409133801.23503-2-philmd@linaro.org>
---
 hw/net/lan9118.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 47ff25b441..8214569a2c 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -150,6 +150,12 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 
 #define GPT_TIMER_EN    0x20000000
 
+/*
+ * The MAC Interface Layer (MIL), within the MAC, contains a 2K Byte transmit
+ * and a 128 Byte receive FIFO which is separate from the TX and RX FIFOs.
+ */
+#define MIL_TXFIFO_SIZE         2048
+
 enum tx_state {
     TX_IDLE,
     TX_B,
@@ -166,7 +172,7 @@ typedef struct {
     int32_t pad;
     int32_t fifo_used;
     int32_t len;
-    uint8_t data[2048];
+    uint8_t data[MIL_TXFIFO_SIZE];
 } LAN9118Packet;
 
 static const VMStateDescription vmstate_lan9118_packet = {
@@ -182,7 +188,7 @@ static const VMStateDescription vmstate_lan9118_packet = {
         VMSTATE_INT32(pad, LAN9118Packet),
         VMSTATE_INT32(fifo_used, LAN9118Packet),
         VMSTATE_INT32(len, LAN9118Packet),
-        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, 2048),
+        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, MIL_TXFIFO_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -544,7 +550,7 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    if (size >= 2048 || size < 14) {
+    if (size >= MIL_TXFIFO_SIZE || size < 14) {
         return -1;
     }
 
-- 
2.41.0


