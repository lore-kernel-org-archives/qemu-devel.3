Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FFC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3k-0001po-1P; Mon, 19 Feb 2024 03:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3a-0001IO-FC; Mon, 19 Feb 2024 03:31:27 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3Y-0002Kq-1M; Mon, 19 Feb 2024 03:31:21 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d91397bd22so33603645ad.0; 
 Mon, 19 Feb 2024 00:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331478; x=1708936278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpvdZvblkLn3xhVOqbL60pez5dBNmSPBOMujYWaJTgo=;
 b=M3gwcKEDQiuUQLIhL1i2FkFek3nJKmBYV2sPxf06+XoTJeVuJXvlLdYXkwtSXxD4cI
 HdY3p+3LNExuQ38LU2Bg494GyyMtxz22j5IYvn+PeiB/COu6MRaN7px5w+PY/v11lI0k
 tsnfLdP1WR138LVVBAoG8wHckJHI/OWM7HHzL+KqInsZlVCdca6zxqx3U/xSACfZZZU9
 bPo+mU0jw+qxWT3K82K8rG+q/z1QSoOCD1IO5vxui7ym9JSFfq7gxHtI5Y6MB+Uf/Lr0
 VStxnuWTTl7PGNNnNyKLL7HOHNJvpzJUuLsKhb+Ga6cFWQTOS0Uyae/Tga4SgvpCs+2S
 GtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331478; x=1708936278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpvdZvblkLn3xhVOqbL60pez5dBNmSPBOMujYWaJTgo=;
 b=bnabySWxDnO55KvMgFvbv07u8S9tvZI4qRpvVIBhH8Wkc0IQkx+YICEBy/QfiDluBL
 FtUhwJ22JZkKjtasylGf0T6rWJpi1oqNcF2briBbO2Ah5mKb7gtg70vVWEs/4qar/Kiv
 6B6BfClrAKzBiAIyWLlfGk0grItA/Mx1/Vkxh6MvP0psXgv2jxxpdhRTbO4QGKSYb6Lb
 HMpvXvWcJ+tNKYNZSkghJ7sv7d9CPrQTJK32Ni35e/xJ0eG/PPODVkYbotxcuSOzBgjV
 UWMSCR/+NBjOhZzpyBusWeYeQ1BbyqnKZ3D/8s/DnaiyZ/zTmO1zdRYucO/EDEUxyHSv
 1JGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFBxVxkwocd0PftMdN4+N5+Dxv1hn3KOor7VCDY82hKucZ6oa4pF5Y96mUehD9+rhqOj+PgkgWlKnr6ELO+p/HGbZ7
X-Gm-Message-State: AOJu0YynX+qwkSosITpwMMccoS95czeBWDi3xcugKyf3sehp4hwe/z21
 WuHEmICZtmi9M0DztdxS2qEzbjKQN3qMJameegOJKH9cte2dMJAZDstQOHjh
X-Google-Smtp-Source: AGHT+IEphfDWJ7tt7xzKvu6d95KuoBl8DnGKZGdDWK8aOOqWar8EDZFfkQXMBUMzRVwtgj4iox1IEA==
X-Received: by 2002:a17:903:32c9:b0:1dc:147:18b4 with SMTP id
 i9-20020a17090332c900b001dc014718b4mr850157plr.35.1708331478146; 
 Mon, 19 Feb 2024 00:31:18 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 17/49] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ
 range for CPU IPIs.
Date: Mon, 19 Feb 2024 18:29:06 +1000
Message-ID: <20240219082938.238302-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
the range of CPU IPIs during initialization of nr-irqs property.
It is more appropriate to have its own define which can be further
reused as appropriate for correct interpretation.

Suggested-by: Cedric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_irq.c         |  6 ++++--
 include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a0d1e1298e..97b2fc42ab 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -23,6 +23,8 @@
 
 #include "trace.h"
 
+QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
+
 static const TypeInfo spapr_intc_info = {
     .name = TYPE_SPAPR_INTC,
     .parent = TYPE_INTERFACE,
@@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
+        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
+                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..4fd2d5853d 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -14,9 +14,21 @@
 #include "qom/object.h"
 
 /*
- * IRQ range offsets per device type
+ * The XIVE IRQ backend uses the same layout as the XICS backend but
+ * covers the full range of the IRQ number space. The IRQ numbers for
+ * the CPU IPIs are allocated at the bottom of this space, below 4K,
+ * to preserve compatibility with XICS which does not use that range.
+ */
+
+/*
+ * CPU IPI range (XIVE only)
  */
 #define SPAPR_IRQ_IPI        0x0
+#define SPAPR_IRQ_NR_IPIS    0x1000
+
+/*
+ * IRQ range offsets per device type
+ */
 
 #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
 #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
-- 
2.42.0


