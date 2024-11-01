Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A65E6F06D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6uFU-0004J4-1a; Fri, 01 Nov 2024 12:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uFI-0004H4-K4
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:11:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uFG-0008Gn-VH
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:11:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d5aedd177so1382544f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730477489; x=1731082289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgJweKIXis8k6s24MiQrusXcKHlFW60RT7XqGnm9h0Y=;
 b=M6zH/cU2JARQ2SeLyFgPteAT/rnMNbq1pIUSskmoGoVCAf41DuTALMy+OMC1fPDuR4
 vmqCqeEoT/Ezs1KCqkNdlIv2vvrfoNAgd7vxCmaPxdbwiDZiOf/esCSvrnlWGP4YFPGB
 5A7hwcIWY0N9yuBw7A/+meMWN/REuuxT+lY7PyZxX9Jg3GOtAL1W74a+sty71Gbadm2n
 5L3byWd3cyveOx9JYqlOVQg6d5my1SKhBijud0h4xp5Y5Lhla8ncz0YYz9HozMgVCf+B
 3woJlScz6IJrnVQWsrXi6w39mk1ZbJGguTP+/MiNeUULDc8g7Xrp0ofpe0iOWB8QLdSt
 iLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730477489; x=1731082289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgJweKIXis8k6s24MiQrusXcKHlFW60RT7XqGnm9h0Y=;
 b=MbjXQtN1JJDw8d8KXngNWWbUAPyCcunrVRzD4JLI89SDlqp24CPQAtstE5Z+wbd1sB
 nbmuD/rZsde89HZ5fBLk356KazPEZq4SrSb9j8p08HUHm95QZLSptPX18LdVnKlLTlg2
 mtk5UzyaNfZm3mih7KkUmmi6y4biHtm+1G33N0Y2/dH1PwT71vKCIDcQG3nUGQcO/sb8
 N7lDZu9t9J3cUOXcYOKCiAQutQ2QNQwGGQjYvMkbfL9QF9GHHYKypT7PWag5VgFvx1bU
 j9XmYR+UXOPqpojA3oRqIsmm5wdPT9mk7kY/7atEaX8XD6hPLXwHvXQ4tsUgMOLEL4U8
 ymGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3p9Six9G6UOud8YxwFiUAz7ptB/2Y3fyIECZ8qV9KrL3pto235i/tbRCXKAGqbckk2ekMxlxmlv1/@nongnu.org
X-Gm-Message-State: AOJu0YytTs4lpYSFuyUg0tfAiar0vhTkE2lIjk5vjbgPyAyHVNrLDBKT
 Gr7r8Jzw0JYQN/SwYMk7f9ZBVsHI/eBKfJnwSkvDE9sN8R7Ly4C0duyAOJs9Zv9zzTPGI7Cif7D
 F
X-Google-Smtp-Source: AGHT+IEwR9cEfTA8EnxaKkfOGWkuTFR8IWjI69woz7WU1qepY8PmPq39BO4gAg/m6Tnjz25EyK1n1Q==
X-Received: by 2002:a05:6000:4711:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-381bea0ee17mr5565634f8f.48.1730477489261; 
 Fri, 01 Nov 2024 09:11:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7f80sm5658313f8f.20.2024.11.01.09.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:11:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 2/2] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
Date: Fri,  1 Nov 2024 16:11:25 +0000
Message-Id: <20241101161125.1901394-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101161125.1901394-1-peter.maydell@linaro.org>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

When calculating the index into the GIC's GPIO array for per-CPU
interrupts, we have to start with the number of SPIs.  The code
currently hard-codes this to 'NUM_IRQS = 256'.  However the number of
SPIs is set separately and implicitly by the value of
AST2700_MAX_IRQ, which is the number of SPIs plus 32 (since it is
what we set the GIC num-irq property to).

Define AST2700_MAX_IRQ as the total number of SPIs; this brings
AST2700 into line with AST2600, which defines AST2600_MAX_IRQ as the
number of SPIs not including the 32 internal interrupts.  We can then
use AST2700_MAX_IRQ instead of the hardcoded 256.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 5638a7a5781..7b246440952 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -66,7 +66,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
 };
 
-#define AST2700_MAX_IRQ 288
+#define AST2700_MAX_IRQ 256
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
 static const int aspeed_soc_ast2700_irqmap[] = {
@@ -403,7 +403,7 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
     gicdev = DEVICE(&a->gic);
     qdev_prop_set_uint32(gicdev, "revision", 3);
     qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
-    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ);
+    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ + GIC_INTERNAL);
 
     redist_region_count = qlist_new();
     qlist_append_int(redist_region_count, sc->num_cpus);
@@ -417,8 +417,7 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < sc->num_cpus; i++) {
         DeviceState *cpudev = DEVICE(&a->cpu[i]);
-        int NUM_IRQS = 256;
-        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
+        int intidbase = AST2700_MAX_IRQ + i * GIC_INTERNAL;
 
         const int timer_irq[] = {
             [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
-- 
2.34.1


