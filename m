Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC4AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0YL-0000BT-84; Mon, 03 Jun 2024 01:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE0YK-0000B9-C0
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:48:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sE0YI-0005OH-Sq
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:48:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso24071915ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717393693; x=1717998493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVZpJhKtEcd9YCJGkGQF9gaW6VhHFLErv6FyXahbmsc=;
 b=DtdQalAwp3XkTppTR1nIifPAc7lC7PDZiJeVE07pXmA+CGa0cMTIvfBQbgA9XXZu9C
 GqHXtXB8JgU5ShZLZCdVIRb2HdxdQb5VzZ9u/0VK1XK6BNgjqEVIhfSLfkXZq47lLBwM
 z63zjrwJ/dkr8yWEwKEcN9IPa6Lb2PPaer6zHcq1/axOHlDqy+HYd+WZN86qd8PFoM6y
 lUCv1bC8wkAmYIzQGzoppTbN1Ao7wIuLc2qqdz7Pjvb8srdCSdPyIqn1up3wC0KrgVia
 p8pyhokf9JyuMZEz+VjExw1KGDYb16TstlsQI+omQpIWTTDg9LSudc4UxUaRPBqAlHrJ
 E6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717393693; x=1717998493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVZpJhKtEcd9YCJGkGQF9gaW6VhHFLErv6FyXahbmsc=;
 b=aob6qz7VoTMUFC+dhkAYV7GXhHVQeXlB1fiZAU4ixPZUV/yJ2xZPqhZaJE3RTRuuYO
 ERk3UXwC/x+gz1zfwVFy7MnzB4PJ8M6Esn0MQuGoF3mqBC6FF994xNlpSpAGsdOFLyuF
 W6DNdb3EYmNy9dVKsQaohbAilSguJSoDHU5EjcWpycluQWW3Zc1EyrGptvM+7bSDNs52
 AWHjrTZ2NQnkD/5eksBzX+C21T6v0ydPl0atUUplpzFnvZV7MBa2Gj3Go/1B6kRIX7oF
 Fee/b1Ss7Ws2Wt4No9Db8u8IcdqNLa07Pe9UQae1wapOeLI2o2nOpXiE/E+2sKvak4fW
 hM2g==
X-Gm-Message-State: AOJu0YzD6VogInyun3bgjR//uR4Vs5RynIqBGDpK0NGLauj3Eza75ptu
 JY4rCSnDq6xXgv09JilC0pLNcNBKC5R7+AyxaFmDLhxA1p7Nu60wa2RELGm/e8wO61qT6Aw1ua2
 UlrWibZv3J99qQyZ8sV0KMMWOk7X/PyCLJSAam3GfLPeeYjYQxRlULfG2bU6ajkABZkTwpks/tC
 k+lp6VaGtSP3ZPYTM8IfpEQNr0mIDhVS3qhwU=
X-Google-Smtp-Source: AGHT+IF/NhAHUv5NOzJAxHVrM0NCdw27QFO4bXQgcjKCUBHyY61JMxxZUcQGLtEgnjIVyb5Iua3rDg==
X-Received: by 2002:a17:902:f908:b0:1f4:8faa:cd68 with SMTP id
 d9443c01a7336-1f63702346cmr69194085ad.29.1717393693229; 
 Sun, 02 Jun 2024 22:48:13 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63241e085sm55824135ad.299.2024.06.02.22.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 22:48:12 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 4/4] hw/net: Fix the transmission return size
Date: Mon,  3 Jun 2024 13:52:48 +0800
Message-Id: <20240603055248.3928469-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603055248.3928469-1-fea.wang@sifive.com>
References: <20240603055248.3928469-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fix the transmission return size because not all bytes could be
transmitted successfully. So, return a successful length instead of a
constant value.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 hw/net/xilinx_axienet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 7d1fd37b4a..05d41bd548 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -847,7 +847,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     axienet_eth_rx_notify(s);
 
     enet_update_irq(s);
-    return size;
+    return s->rxpos;
 }
 
 static size_t
-- 
2.34.1


