Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B95C531FC
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmr-00023a-IP; Fri, 24 Jul 2026 21:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTS-00072e-FT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:42 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTQ-0000sQ-Ro
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:42 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-9770e900464so722891241.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940160; x=1785544960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KEFI7uy+xvGQzuX9qXCJxcKIBc3o6R22/Dt7nV8b50A=;
 b=Mzv4OzdldbjZWEano/RtN4FPiLBYAu7N/kMNxaBnmZ6FMj5xuwND24b90V+OxO3OJE
 bzlWP0zAgO6gRWxqIg+tr8k+RmMolG/ipYyyZnBQ1X8Lw4LMcZda8kRszMPOAkiOAD3j
 U1xgYBSZqakDe30kiUoVtr/cGDHh+SRpcTMIf1UrsKr/1NHTEedKcf4o9s2cHH/pS0tk
 WP6ScKlstPZPoXe+KtKgWVySMiKOXpcIHK/STUZSJ9vjTQyLmBm8Ck6buVZt/RAptpS3
 cLkwFcdLDU20k61aOCOxd01tfHnaP27xWoIdKs7d9IN9qKd08XPb0XqcHspt3X8G6Zmt
 +Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940160; x=1785544960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KEFI7uy+xvGQzuX9qXCJxcKIBc3o6R22/Dt7nV8b50A=;
 b=Nhg6bVUqD5nnnxqe2BiEAvspuY9cb1f958QHVrInP9OjS1fgHKUA7wnrupKgkQ4cMW
 H1KaQhUjX/BllQ1odJZsJ83vBXMZLIkjg3gWfqkmPONAEY82rDD0fqfPwh9Uhd1eCkzt
 KsNMcapumIAWnEWOLSsEYKSbLx6u/BrbX6dz4pr8CrVKFL8CzZFxSsSN5cWNH6ggkvs9
 bOhyyInH6PnvHA/qI97J2AkyLl5rbGNhhQljnj0/mx+CxShuh2WYyAw1zwJfSt5qxLEn
 1oWGue0geyRRj4CURAU6IJl9B9PclSgs0WgcpZRSZGUlDzI/RT9xhNrYZwQuKQq6OAHF
 8g3g==
X-Gm-Message-State: AOJu0Yy74xQMVxA6mL0Auqcoe3LtJNeMeoDfw7EUmNZ+J3l9B4q0JDur
 wDbntvUYeCw5slmhrQ6RX/KpvqSLAva9o/VdKdwBvBBiSfAusWEn+WpC+EWDy3sM
X-Gm-Gg: AR+sD11KB8I5kS4k025+JNapHXWdlp8YKLViqsvqWsBsipQ75dIUxRBat2zmUz9t0Dh
 je+fxOai68/f59EFxkdcB9hdN+F4zVHrGJ2LyWO1wiprDG+eremtvgiwd+ZJ9ILUVVi0VnnOSrc
 edWQrxRMeFncpip+CguWoXgpBmWjNqkUap2eyHXhF7vV/0pjfxtI2YkXwC9R05wUmrkCji2xHaj
 6A8kWpKer05qkl9H4wSvIXR1SITsVcPSieqBsStohGwjzNi8PMrjUHYpv4Of1J0wsLdefd+FKe5
 TX3kfEwDedywwP2oJvEn3BJGNT8eRBhDGmN4mqzscptbq9sjVMJT1ByCP6s6PjkyOwM8hCZEkeo
 DyyVcACJQ24Ki/WDVn/Y6FzPVQZ8lrqG6jEr21on4bX/S6wQaJu1Hp3kmTLfkBlgI6isctIxNzk
 MVBIb9dXXQ19hJHq+tk0VEey0KUjkCvgZo
X-Received: by 2002:a05:6102:7b0:b0:734:54fa:971d with SMTP id
 ada2fe7eead31-74f9d69ead8mr1654729137.7.1784940159768; 
 Fri, 24 Jul 2026 17:42:39 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:39 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 17/19] hw/net/bcm2838_genet: fix TX ring activation check
Date: Fri, 24 Jul 2026 20:42:16 -0400
Message-ID: <20260725004219.66222-18-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

bcm2838_genet_tdma_ring_active() extracted the per-ring enable bit
from ring_cfg_reg using the GENET_DMA_CTRL register's EN field
definition (1 bit wide, at bit 0) instead of GENET_DMA_RING_CFG's
own EN field (17 bits wide, one bit per ring). Since a 1-bit
extraction at bit 0 only ever reflects ring 0's enable bit, every
other ring (1-15, and the default ring 16) was silently treated as
inactive regardless of whether the driver had actually enabled it.
TX traffic hashed onto those queues was dropped with no error,
eventually tripping the guest's qdisc watchdog ("NETDEV WATCHDOG:
transmit queue N timed out") and causing intermittent DHCP failure /
link-local address fallback.

bcm2838_genet_rdma_ring_active(), the RX equivalent, already used
the correct field, confirming this was a copy-paste error isolated
to the TX path.

Confirmed fixed across repeated boots: real DHCP lease every time,
0% ping loss, no more checksum or watchdog messages in dmesg.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 6f8f4e5b..43583aba 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -515,7 +515,7 @@ static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
     uint32_t ring_mask = 1 << ring_index;
     bool dma_en = FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, EN) != 0;
     bool ring_en =
-        (FIELD_EX32(ring_cfg_reg, GENET_DMA_CTRL, EN) & ring_mask) != 0;
+        (FIELD_EX32(ring_cfg_reg, GENET_DMA_RING_CFG, EN) & ring_mask) != 0;
     bool ring_buf_en =
         (FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, RING_BUF_EN) & ring_mask) != 0;
     bool active = dma_en && ring_en && ring_buf_en;
-- 
2.47.1


