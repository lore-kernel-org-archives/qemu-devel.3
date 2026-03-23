Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41F4F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYc-00005E-Da; Mon, 23 Mar 2026 12:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYa-0008Gz-5l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYY-0000ul-Dp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so2673555e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284908; x=1774889708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oWfi2HgfSpvuVSftWY5ON3lii/NBjM3WqJGU05mMtcQ=;
 b=gp5wlNISPT0aY8CnhNJoYxN9ra3tktQYUcbExU6trAjzv1Es2b65mvLY42xUdieeiu
 RFroGKZk4bE2acjQ/7IlcKahcBRSEHdAvdawqhZ+aYgu9iMDvzzoGyx7JozKQK3clV4e
 DJBNhqK4/5XdNCRhnJ4n/pL8TiWIkygR2S2j38xbWfpUH2ftCYYV4ToWEk9SJazSMpRO
 uj5ZXhBbAqwMWG7fMBTuDVh1+QyKxgxN3Uewe8m7UKPTiwYYdJJ+RA5w44mGktQlfT19
 H5oBjHTj9E0ffCzb27zImkzzGtzQLF0/HVz5Sc9MUF0qR95eE0y3LWaWYRpXj2CSHveQ
 8B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284908; x=1774889708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oWfi2HgfSpvuVSftWY5ON3lii/NBjM3WqJGU05mMtcQ=;
 b=a6gD/JU/rO2UgxYeiw41Wf3NFZbKsXLJC+MNJK8LwPW6C/JnFVTHzfJTKb24bDhohF
 ufIOlVZPSr6m9Ps3f7ct9x4RYGYD8QaRn9wHYxg00/SvK694YYRmxpPSJJGmpqlaSJI0
 1Q7SlHdUNMYFsPCFz5SWVaC9LN4XQdFMnI+GG6MFySDR3Y7v/ycpjE5IQ1/XcofbHbwq
 8b64bbXIH5Y6+As8IkUUxbR5OSo7AwRAVKFlV6Gh2DO4nSN6kBtztOCfCjyYx8w4s/qG
 89foqS9iqtdkjPut0IVDc+gU7unNQkpW2Zu/WNfYTUtUbYel9+/joaVFeHzxT7Fbt10m
 NGGw==
X-Gm-Message-State: AOJu0YxqEVRZ5G3i+XRWlOUNYD7/DR4HLXEdJ6+wL+vt2o/2Slw2Wyl5
 IMmzMm/KzWRaolmCDi+U63+w39sqtNvGiTflX/Q7h8MUipKKmZIYbuuMn6zd1GjV8tUzP6+Pn/2
 YTdV8LMU=
X-Gm-Gg: ATEYQzzpUajq3e89j5fujbWfQnQrAn4BYv1cuX3PpiwdAo/fUOFj2rOVvnOG5Nb5IPz
 KOYk7Z3KDmF8XBSk+MOpK+rE1E56kaz1kFLAKm9w2Ans4Q+OG5ndiMB6JE5jEn8lMlkWsW57jHN
 Bk9/atwzx+NN+Q2ii4TKU1nVPIRisLR7h9ozLJSPVoLKDKV5CIzq2PZdaxIq3UZCDF+VSxmptPE
 KSoCE8COi9Kj3Te4lkmDJarzZCeHIejYU/jiw98TmPOQc7yagnjwknatxdds4EhYd6J7/PAkhJl
 lkCVX76yvK+ZKOpcDjYS68MW0VCvuppHueG/kMNOCS/60IfiWxZLfK9J2mJhF3uKngVGTdJgSv+
 E1PoaFeAbGG+XoN/fUhPfgbCTQ/v/QQAQH+a5JGtz8ZPzTSm0+Aqo7MibHf8dqnY/+53zHgQbOd
 Uh8PhW/eQeSxT1j1aOKnawGyaDNs8rPz5LYXaVcVhG6gNzgLgkHC+ZF9aHG5MneSY2Tiulcvlc/
 RIzWcFreqY=
X-Received: by 2002:a05:600c:5250:b0:485:3c66:e21d with SMTP id
 5b1f17b1804b1-486fedab2damr199964335e9.2.1774284908353; 
 Mon, 23 Mar 2026 09:55:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe85e4b4sm86076745e9.3.2026.03.23.09.55.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/27] hw/net/ftgmac100: Improve DMA error handling
Date: Mon, 23 Mar 2026 17:52:16 +0100
Message-ID: <20260323165218.96607-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Currently, DMA memory operation errors in the ftgmac100 model are not
all tested and this can lead to a guest-triggerable denial of service
as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.

To fix this, check the return value of ftgmac100_write_bd() in the TX
path and exit the TX loop on error to prevent further processing. In
the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
flag as appropriate.

The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
Nevertheless, since it is supported by the Linux driver and it should
be safe to use in the QEMU implementation across all SoCs.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260322215732.387383-3-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/ftgmac100.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d29f7dcd171..2f05bba11d0 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -624,7 +624,10 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
         bd.des0 &= ~FTGMAC100_TXDES0_TXDMA_OWN;
 
         /* Write back the modified descriptor.  */
-        ftgmac100_write_bd(&bd, addr);
+        if (ftgmac100_write_bd(&bd, addr)) {
+            s->isr |= FTGMAC100_INT_AHB_ERR;
+            break;
+        }
         /* Advance to the next descriptor.  */
         if (bd.des0 & s->txdes0_edotr) {
             addr = tx_ring;
@@ -1134,7 +1137,10 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
             bd.des0 |= flags | FTGMAC100_RXDES0_LRS;
             s->isr |= FTGMAC100_INT_RPKT_BUF;
         }
-        ftgmac100_write_bd(&bd, addr);
+        if (ftgmac100_write_bd(&bd, addr)) {
+            s->isr |= FTGMAC100_INT_AHB_ERR;
+            break;
+        }
         if (bd.des0 & s->rxdes0_edorr) {
             addr = s->rx_ring;
         } else {
-- 
2.53.0


