Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEE1C3DA7E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDzW-0000zZ-45; Fri, 26 Jul 2024 01:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzU-0000x1-19
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:44 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzS-0006XH-BI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:43 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7037a208ff5so410119a34.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721973580; x=1722578380; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDXUV1ROupA6i8xkgh2rjOo8lmNHwSBtTD7KktWSLk0=;
 b=ObPDuLDz8C6pd71QZDQ/OcbcrpKOC4r2nDAPgDdJjcWGKzSr6Su/bPMosTZd2JJk7l
 MxDwWv9wQiL4yVqdH3gFMRdL8Y8bAFZZlgLiyz448Dpp9DPw1Vc5imR1Z66/iGwq7ZPG
 iiS687z3CVv36pNs6TOnjXL0tpxq8HIwJJskLQonzQyIJ1rHSifqasoypZDRJH8tqKOj
 msSj2Iy88NjiIwH5DLvHm0FZcfCaiuxJ2JOGH4vLZkyeRnYYqlnycr1QVVtWKfQUxd39
 JKqNWxDsi48yi8SMhwH+touUm1w9LVC/tlwjBDjxzu4ert3xLDtwEtQS4VlUPwJTLDjJ
 7jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973580; x=1722578380;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDXUV1ROupA6i8xkgh2rjOo8lmNHwSBtTD7KktWSLk0=;
 b=fRl3WcZ/TS8jj4QOnLDRccb7qDAARxMTsv37LQoYwIWe0XMBQMkpIU7TL+Lpjf9xSd
 uYfRl0V8JhXL0xdVQ0nTzhQKwXbfKkoiAPdBTlSkhjPrV/FEL9NMbSKvYlzktVIbv2E/
 9mbK8oKE0nbJ6JgahquavMCn3JlEQZWj7vnSCXJskgGHPQrS5wZnMmjlRI5bUWAZybrN
 gB/sKBWmqyOXZe+wlFs4zzDGAUyDzqgA5Zxsudx6P3SqwU8M2PweqtD2K6/J7azOh4Id
 dcqchYORp4IsEg/e7/nwjsWvLwDfJOEYMVpwEMKE7O7P6Aa1TKP4wwYS9H1tJdqcoqBY
 pjkw==
X-Gm-Message-State: AOJu0Yz1wZypMwGEeD9l1/ap6A1BWx7CBGyrLP53eDRMbnYFX4Qs74sA
 uU0a1X04lQ9P1XAMrMV9uHT+vd0dVLOtwujyHOENYdxHi7FGBR7rceHF26x2UdxSZ43bEMyQD6q
 dnj+y3hofQFww3/W2CkqTsxoNoKKrBaJuc2lspq7MDnEVVNnT0tJWfjl8ntUvYLoQ5sWga9Cq2l
 nJmidyrF9kQE1d7T4DomM4+OltD8h4ioDHgw==
X-Google-Smtp-Source: AGHT+IGH5YGGFVoLu4xSKrjrB2FUq6xcGoR8ESV+allZWsZja79leyx+DV3L8Rded1q24fpjC2wTZQ==
X-Received: by 2002:a05:6830:6318:b0:703:654f:9e9c with SMTP id
 46e09a7af769-7093210ed03mr5834622a34.3.1721973580434; 
 Thu, 25 Jul 2024 22:59:40 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1a4bsm2002128b3a.5.2024.07.25.22.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:59:39 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq), Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/4] Several fixes of AXI-ethernet/DMA
Date: Fri, 26 Jul 2024 13:59:29 +0800
Message-Id: <20240726055933.817-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=jim.shu@sifive.com; helo=mail-ot1-x330.google.com
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

Fix txlen value in the descriptor status field, DMA error handling,
and ethernet/DMA reset flow.

*** BLURB HERE ***

Jim Shu (4):
  hw/dma: xilinx_axidma: Correct the txlen value in the descriptor
  hw/dma: xilinx_axidma: Send DMA error IRQ if any memory access is
    failed
  hw/dma: xilinx_axidma: Reset qemu_irq when DMA/Stream is reset
  hw/net: xilinx_axienet: Fix DMA RX IRQ if ethernet disable RX

 hw/dma/trace-events     |  1 +
 hw/dma/xilinx_axidma.c  | 97 +++++++++++++++++++++++++++--------------
 hw/net/xilinx_axienet.c | 71 ++++++++++++++++++------------
 3 files changed, 107 insertions(+), 62 deletions(-)

-- 
2.17.1


