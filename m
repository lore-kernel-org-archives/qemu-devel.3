Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC4C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY1z-0007Mf-It; Fri, 23 Feb 2024 11:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXin-0005bL-5r; Fri, 23 Feb 2024 10:44:21 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXil-0006Jo-MU; Fri, 23 Feb 2024 10:44:20 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso795744a12.2; 
 Fri, 23 Feb 2024 07:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703057; x=1709307857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8ZPb3xPbgkM4M/2MGFfCLB8pnr23xttugE2MsKokaE=;
 b=TBozMG1hDv8/gQY0lwm5Q8ZuInZfKqzhWpYZhdQqHRiaVZS6RL6KRHnPMJ1t7SmjFg
 5UMP1TiRBPCUpyjdTS3Yex0hUrHlY2Jhf8moK5ZylM6G6CkVzbYXVfvDLprObr8AcxLE
 8ycEsQHine+sbKr2Z/0O5aC/509/xJGWgYhV4mPlcHcsl44+y+jhijkfKWIRDekc6Um7
 y+64UIQVDl3DyFNewfXezz6/fn5ZKrBuDMobjyu3pszmZ5LWv7Gt/ykR6n2bViO+BIeE
 2Uvuw9oRDz6DpNglxd4h6CLSauB95Axz4I9PeYbFkONKe/OfCwAKCOSHSjeY+EKtCh7O
 5x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703057; x=1709307857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8ZPb3xPbgkM4M/2MGFfCLB8pnr23xttugE2MsKokaE=;
 b=isbDYqT/o8lPOH/MO55C21Smf3bBVSqDKm4Wf403iQlFJh4R81wzpW+YRXsxlVAI3B
 i6ZUvubq+zuD417COx1x1Hg7H3JAmKv/QHPl0YBiFxVs+aHqTICNZb0JOVd0XLb4grU6
 FMCFkTsrM1MT86bXqostJoomv2qgKqxRhnBKCUiDd+zfVlfyHeiWXCO6wDW5x6DQEGrv
 ja6VVTDMGslFa0um+dyu5E7b3p/Y3KWUwL8zBUCp6y6MQlE5ba0ET1IhO8EQcuNDNc1J
 NZN2Ec6r5skWfyI/MusNy7jxMCGfLFmVRbJdrNInJabrCqTGDvSfqk69YNiJnp+SpgQf
 Z/6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcIDEscRc5ntmB9z5E7aIHhbODxtu4s1eb0hngUlmfpaT3cI4I1kngSY5lbtgBbTnJ7f5K8EDYTRE7Ln4jwDbpzACO
X-Gm-Message-State: AOJu0YxKXg3X6Q0EE6RkzSc+x8uLAEqY+7aJawWXJwM0KtnUpJC/9MNA
 KwNQBbwLhPZ6hOpOlZxdb7a9ToHdCXOjb+tWuVVpy4djNcpB5tcHRqkcAw7q
X-Google-Smtp-Source: AGHT+IE8r3VKx8NJwqiOUt78vFXosUqUNZDZEL3uUSene0I4CTZKT+t1JRGzGOvnM+4u3CsyKLAO7A==
X-Received: by 2002:a05:6a20:c90a:b0:1a0:ccf2:8f44 with SMTP id
 gx10-20020a056a20c90a00b001a0ccf28f44mr301686pzb.21.1708703056690; 
 Fri, 23 Feb 2024 07:44:16 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Kowshik Jois <kowsjois@linux.ibm.com>
Subject: [PULL 16/47] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ
 range for CPU IPIs.
Date: Sat, 24 Feb 2024 01:41:35 +1000
Message-ID: <20240223154211.1001692-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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
Tested-by: Kowshik Jois <kowsjois@linux.ibm.com>
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


