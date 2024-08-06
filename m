Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7891C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK0U-0003Hh-Uq; Tue, 06 Aug 2024 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0S-00037O-9M; Tue, 06 Aug 2024 09:13:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0Q-0003VM-Hw; Tue, 06 Aug 2024 09:13:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc65329979so4977545ad.0; 
 Tue, 06 Aug 2024 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950016; x=1723554816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnebB2MqX6EetROF6uhcR3JDthmIaqX5oq8YhYJ9rA4=;
 b=VUhGPm2B59ELmnRYSjEMJ3gmgfWhOYcZ3rWizkXnmf89ltc8E5N7EkD2bcsjbtkslZ
 pTykFnZuPry1qI6tQDWc9r3eXiS/JATpdg/v5GkzX/tTs6ZsHCUt9A/HYxRmqr0AYVQV
 gnrsIh5J/elq2blxpraLk2BZwsYEWmyr5Xs2xMRGiKV3HtiZAIIIoJkL7TCIk1hoNMLS
 hOOC5jO7iXiUqNGcHsztLjmsNvgbFqdix/vaUJeuVnzji1zKYdFqn5mR37UJZUq0WgrI
 odqm8bxX26rs/ESk//+AtfLRSzQnV/ZJSTkWHGtdyIEj1vb28zM50Ws/oyI4hixz86js
 6kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950016; x=1723554816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnebB2MqX6EetROF6uhcR3JDthmIaqX5oq8YhYJ9rA4=;
 b=od/vdHg66ngfBsy23MhEtIRfSI9dj3Bn5af0q1n5TC60dMl2mVZ9EzCkPRyZvPmyWG
 9ToOhsu3SztyhxuNidW1tDic8k2e5iyld760VtpznGhulmkSW6lZB2uzkstKwqECYck4
 U5ke+Fx68H5xeI5zHClj+Wa0hLMIZcq6Po/IVtLbyDHMx2fiPrIwidM/69p5yPqYKjHL
 3WT1fzdtmgY3NSV3lpkX6lBKxgP3oEMOco3Qq4uUwMvDhnkdE74Tmxwk0A7/SkMVSCTU
 gwfHOHog46+ZKpGjFSctXk0E5S9nNEYRrpu214+ozfnWn0o2qKzjIu2LSFugUtSVZ1/3
 Shtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFw2nYB+0HDFHNuSd1FrM97KXqqVgsBbhmmvS2XvnbBG2cPeK5zera6EkVVJCq6rqLOh2D2KmMfapWg5RT0ABga+NMKis=
X-Gm-Message-State: AOJu0YzagGRKfXwdUr7bDnBlzQZlhioGZ2t/uzE36PYnKebVq0AYg9Qg
 Z74jpASLvFuaX9A3aXvXBlu38JY/J8mradqloeMsQ6CsnplA2fR19dZOM00d
X-Google-Smtp-Source: AGHT+IHc+zac+YHMwx3ht7IXL+rjtWbA7Ny23MxRqjxjqH5H3NM6TWrgEM2VI0DEvnY3dAE5h3WzuQ==
X-Received: by 2002:a17:902:f54b:b0:1fb:6151:f62f with SMTP id
 d9443c01a7336-1ff572957c5mr188262655ad.28.1722950016200; 
 Tue, 06 Aug 2024 06:13:36 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/7] ppc/pnv: Fix LPC POWER8 register sanity check
Date: Tue,  6 Aug 2024 23:13:12 +1000
Message-ID: <20240806131318.275109-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

POWER8 does not have the ISA IRQ -> SERIRQ routing system of later
CPUs, instead all ISA IRQs are sent to the CPU via a single PSI
interrupt. There is a sanity check in the POWER8 case to ensure the
routing bits have not been set, because that would indicate a
programming error.

Those bits were incorrectly specified because of ppc bit numbering
fun. Coverity detected this as an always-zero expression.

Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558829 (partially)
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 80b79dfbbc..8c203d2059 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -427,8 +427,8 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
     int irq;
 
     if (!lpc->psi_has_serirq) {
-        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
-            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
+        if ((lpc->opb_irq_route0 & PPC_BITMASK32(8, 13)) ||
+            (lpc->opb_irq_route1 & PPC_BITMASK32(4, 31))) {
             qemu_log_mask(LOG_GUEST_ERROR,
                 "OPB: setting serirq routing on POWER8 system, ignoring.\n");
         }
-- 
2.45.2


