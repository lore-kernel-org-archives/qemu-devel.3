Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E46CD98E4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 17:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wazMI-0005LM-Iv; Sat, 20 Jun 2026 13:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wazMH-0005LD-Mc
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 13:19:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wazMF-0003SV-Br
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 13:19:53 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697564cb3f0so1995055a12.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781975989; x=1782580789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yz1lyzAp3fEIr0XZVsXsjafx7CnJK8+BCF69ozcnZOs=;
 b=GbPtev8sCXAQyi0fNZqePTaO9QhgN9VkvAMXNal/U2eY6oOVtEU3jkeuFLvEJa2DOn
 cjViX2oKkFd5dl0gKYLB5llGp3rYwd5TP63JLx4bTYBJMZdQDLtI4DbLTfEvAgVX1y1Y
 1tjO/3KDOjK3A03s2rek3odn0hd6BwQQi1GadzcsL9IOT88yOKYjT96EvSe5Tw6NWzt4
 GAdQDyhYNm7RlMuYb4i7ALdzBugcV4yazi8Ow80TkOOawjNHgnZOXujIUTLR+AS2Ht2X
 i0aI+1OV4tJVll6c49yf703yFH3nZEfvHsEwLL9rtTloqkiSxYzG87MPjvprn+TLF9g0
 zTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781975989; x=1782580789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yz1lyzAp3fEIr0XZVsXsjafx7CnJK8+BCF69ozcnZOs=;
 b=MPOo/OgAugHJRnhJ0py3aiC36eWgtHoVWAAfcTCdELHJgQkiK1U07w53LIngiapma1
 erGuNv2WEcADlh5rLOgVUbuiS4QAcBIZ4/gxFtlPcEPf4OrhqacV/GPWP/qnxYfwg6gG
 XPetu7yr87SfTSX9VRBI1agyTg+Rcqy6JVJEbD94k+y1XWXIfV+gAq/RFvL3AwMHkjOf
 4dlIVEaknRXLHVt8X8ZQIUhzSt32urI4jEhTFxctwNp7+i8gv70vu5hZL01HR+X0u9KN
 HpSxYHmOcVZQjDB5qm6YDGjq6lMXk1IC2WFGKAelGBnlCBg/UH13WTM+6CParSrAc7To
 PqOQ==
X-Gm-Message-State: AOJu0YxtDYIOrpvFCCO2mfYzIzVrCtTCn2mAh5RxGTTOJNW4/PnMaprK
 FJZuqw2dnRfe6BF/LYkelnBBMY2OCPFeMqy/uBddxhpAVO/5C8zIbXPBJEOxuw==
X-Gm-Gg: AfdE7clcBtvfrSWEDsPkyXn/D469h4BZpUNRwK5/Ji6zZUAQgRxhCQ6+l0oN/yaH444
 D248eCd/I4GNipghKZE6bJ818EYCpOPA/5n0QPgGmyc+spyC9HapAxhLxMEdcfmqnEvdZbfxX+M
 472f+33uqjWh3yFDY/TXkcfXeoqCHErmygfU8MpGZQb65QvUxJ0rLNS5rUZ8wctow6DxVH/IAyU
 K+AfFnYsXRDupRxSP8jaGlqNayhjmj3aW2kWqr6Xayz+mzyLac9ftbfs55oiQXbImL2sf/UUEK8
 AJnLIpysn5nd8/1otTqbtHTxLPg0Ha9Yw31t1eo4pkesgufQe9mxI0vQg9cSfqzuAqWlEfCoyYC
 DU5ZmD6Oq5ulmisF1izRcBMgct12bzmttNcy5AVvmlJmcvvlOoX03psA2+RpQx56jzF1lklkq9X
 BlVNszx/PtreShv2yF
X-Received: by 2002:a05:6402:3548:b0:68f:c63f:1ed4 with SMTP id
 4fb4d7f45d1cf-696e52075camr4194556a12.27.1781975988671; 
 Sat, 20 Jun 2026 10:19:48 -0700 (PDT)
Received: from machine.. ([37.113.214.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977be31c73sm949835a12.17.2026.06.20.10.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 10:19:47 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH] hw/dma/soc_dma: Replace if-else chain with array lookup
Date: Sat, 20 Jun 2026 20:13:18 +0300
Message-ID: <20260620171318.24189-1-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=randomjack94dev@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Refactor transfer_fn assignment in soc_dma_ch_update()
via array lookup as suggested by the TODO comment.

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
---
 hw/dma/soc_dma.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index d5c52b804f..a5b1ef9f61 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -163,6 +163,16 @@ static inline enum soc_dma_port_type soc_dma_ch_update_type(
 
 void soc_dma_ch_update(struct soc_dma_ch_s *ch)
 {
+    static const soc_dma_transfer_t transfer_fn[2][2] = {
+        [soc_dma_port_mem] = {
+            [soc_dma_port_mem] = transfer_mem2mem,
+            [soc_dma_port_fifo] = transfer_mem2fifo,
+        },
+        [soc_dma_port_fifo] = {
+            [soc_dma_port_mem] = transfer_fifo2mem,
+            [soc_dma_port_fifo] = transfer_fifo2fifo,
+        },
+    };
     enum soc_dma_port_type src, dst;
 
     src = soc_dma_ch_update_type(ch, 0);
@@ -171,21 +181,16 @@ void soc_dma_ch_update(struct soc_dma_ch_s *ch)
         ch->transfer_fn = ch->dma->transfer_fn;
         return;
     }
-    dst = soc_dma_ch_update_type(ch, 1);
 
-    /* TODO: use src and dst as array indices.  */
-    if (src == soc_dma_port_mem && dst == soc_dma_port_mem)
-        ch->transfer_fn = transfer_mem2mem;
-    else if (src == soc_dma_port_mem && dst == soc_dma_port_fifo)
-        ch->transfer_fn = transfer_mem2fifo;
-    else if (src == soc_dma_port_fifo && dst == soc_dma_port_mem)
-        ch->transfer_fn = transfer_fifo2mem;
-    else if (src == soc_dma_port_fifo && dst == soc_dma_port_fifo)
-        ch->transfer_fn = transfer_fifo2fifo;
-    else
+    dst = soc_dma_ch_update_type(ch, 1);
+    if (dst == soc_dma_port_other) {
+        ch->update = 0;
         ch->transfer_fn = ch->dma->transfer_fn;
+        return;
+    }
 
-    ch->update = (dst != soc_dma_port_other);
+    ch->update = 1;
+    ch->transfer_fn = transfer_fn[src][dst];
 }
 
 static void soc_dma_ch_freq_update(struct dma_s *s)
-- 
2.43.0


