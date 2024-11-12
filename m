Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B1DD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMZ-0005A6-Uf; Tue, 12 Nov 2024 13:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMV-00054k-JY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:36 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMU-0001vs-2t
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:35 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f72c913aso10479629e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435092; x=1732039892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0A+XO8SEDEpUXfiyI42zPsZnM8n4BbkRd6mjrTW2c4=;
 b=xqNcY8GRY/9EYPcLNhmwzaEMNRPkvyvvAMy8c37per7ygQ5pI4MURCKpYq9qJh82y/
 YJ7KI+jKybXshCZEYtem4m72u1RTakX0+QAMsGsLxfAkl1MeKtLcoktghFUA2Ufmp5WD
 fo+/l7dFxU8D5Vv9FUSTO2vM9jkT9TlJbHYSwC1+/LrtviSE5Npgq2KjNvm4do0QvRXO
 UzSqIlAKX6qsKRKpqznkpVyHVtmaiL5hCDyL9EUxAgdwy/hvUk1wKMVP8jBOha5mj74+
 bt2GmDJwIBloKfj+Yel69xlBnZvZvf28G+xmsbg7g1hfxoAGPwo2v33AjKNDczrzljZN
 8P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435092; x=1732039892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0A+XO8SEDEpUXfiyI42zPsZnM8n4BbkRd6mjrTW2c4=;
 b=PqeUOhQs03nIheivq51Q3DncnWR0ehUcQ4BzapVtYU3O/bp31o38APSEW2eWW1vCGv
 3HyPUZ3Gmz530ZYAVDAASZ2wjF8j0w1T7SZChYqejfwIw9qkpbgYhNM1NbQB4EpvOfkH
 aczGINr6s8mP853IIFXFi4IPm9unbWACPq693r4XwpnW/9fIk3w6CR39jbH9eBYyiXDe
 eUjHgnyV1ae9BSMzxkk8JTTzeSxk31UDAF0agUp533WT+I5jgpohZ7NC5L2VdhdoRyvM
 R37ZFgSs2CcVrDrIsM3Vpx7Rr1VUFZFpQk6tZRmdBzXf8qe6A0FdJR1urRujIyzXAP9h
 Q1Dg==
X-Gm-Message-State: AOJu0YzxErotCV8lVEeRntOCtz3lbB3OUlSUIvP86DsQ/9Us8tBKqGAp
 NTuJTeoKwOl7080mQNjkTmPcTBpfwAqbetLyGy7OMw+ZIvy4CVdlkwQcDWM97krUotcHJzOpBrj
 E
X-Google-Smtp-Source: AGHT+IF4OGjp6CPOl3a+BdJGRmmk9fZLhrw5YXzty/ZCkxt4492P0CDola6BsjWuyyIC27Aqmx7qfQ==
X-Received: by 2002:a05:6512:4024:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53d862c6b7bmr9259602e87.13.1731435091801; 
 Tue, 12 Nov 2024 10:11:31 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa7397e4sm252183635e9.40.2024.11.12.10.11.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:31 -0800 (PST)
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
Subject: [PATCH 07/20] hw/net/xilinx_ethlite: Rename rxbuf -> port_index
Date: Tue, 12 Nov 2024 19:10:31 +0100
Message-ID: <20241112181044.92193-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

'rxbuf' is the index of the port used. Rename it as 'port_index'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 76b1e7d826..20919b4f54 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -72,8 +72,7 @@ struct XlnxXpsEthLite
 
     uint32_t c_tx_pingpong;
     uint32_t c_rx_pingpong;
-    unsigned int txbuf;
-    unsigned int rxbuf;
+    unsigned int port_index;
 
     UnimplementedDeviceState mdio;
     uint32_t regs[R_MAX];
@@ -183,7 +182,7 @@ static const MemoryRegionOps eth_ops = {
 static bool eth_can_rx(NetClientState *nc)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->rxbuf * (0x800 / 4);
+    unsigned int rxbase = s->port_index * (0x800 / 4);
 
     return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
 }
@@ -191,7 +190,7 @@ static bool eth_can_rx(NetClientState *nc)
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->rxbuf * (0x800 / 4);
+    unsigned int rxbase = s->port_index * (0x800 / 4);
 
     /* DA filter.  */
     if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
@@ -214,7 +213,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* If c_rx_pingpong was set flip buffers.  */
-    s->rxbuf ^= s->c_rx_pingpong;
+    s->port_index ^= s->c_rx_pingpong;
     return size;
 }
 
@@ -222,7 +221,7 @@ static void xilinx_ethlite_reset(DeviceState *dev)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
-    s->rxbuf = 0;
+    s->port_index = 0;
 }
 
 static NetClientInfo net_xilinx_ethlite_info = {
-- 
2.45.2


