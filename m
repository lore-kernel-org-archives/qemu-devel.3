Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909CBC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 00:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u71US-0001eR-27; Mon, 21 Apr 2025 20:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3heIGaAcKCqwWaYXaPUSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--komlodi.bounces.google.com>)
 id 1u71UQ-0001dz-UI
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 20:27:54 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3heIGaAcKCqwWaYXaPUSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--komlodi.bounces.google.com>)
 id 1u71UP-0003Ll-Dm
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 20:27:54 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b115fb801bcso1392772a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745281669; x=1745886469; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y1HRcHba6vPIZ8wnLJIBIEwxueY0n8SHHkbks1hX/oI=;
 b=KbFhf3hJ+RkiKRTmJ9U2EkzhsW4qEylNBtSWTR2lNULryuFsoIcgy6gb8PXf3sGsgS
 yFfdEsyi7sWFNTOgqjZw9oKRVe2B3l/0Ab0FZoqMGCXUP7xw8HjcpZG3W8624zDw7vPd
 B74tkoox/gPrNspUgjcjhVS8YdRolTd8Q0LzTUljbxzMqcUFAUQivsFUTa0wpK8Pa+DH
 dmOaPnZ8vwCzQ+r1VEr89C0g7LPqH8ZzC0y3Mn1IFQxrUKWNrUn8p98mtMnKelywu3mT
 viJ8kUK8EfR0+IbgNwUR2fy9Cl73+gYz+X30mYs9ui2mQmg81FdyBxChC3NR/CGua+UF
 TJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745281669; x=1745886469;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1HRcHba6vPIZ8wnLJIBIEwxueY0n8SHHkbks1hX/oI=;
 b=BNKgSqgyE83P3bcPZB6JYmud2AXnwwmfnAwhOy6LKUdVln3ZnTRRTCyHqcbc0MkCFc
 UXFLvQfXur2YgzIk7EUUzZ2CbQgIbueRhMr2hLPMQDxxXW1zMQLXFftiZT2r/W8FAROn
 XIIxuP/UHFB0WAstqLv+6ZsZEv00DNfLni2TYKkoANM+tAEKZbgKaoWQlvPU2kyajrtq
 4Nwy7GT/on3CFkirn8MCFNeslpPDVGFh7j+FIvVhRXJlZdY2sWTonBGqRJcpgG6j29yo
 JzK4/IgU+t9WM3Z8F8YtVQmPCc1o6MfPzXg0QyDRxjFkE00dINwKcTZTaLQNaIjtXJTl
 bPcw==
X-Gm-Message-State: AOJu0Yyu+3XwyQh/Ns7vj74eh1ozEfHVlPLi8ojJM94TjWHQyJoglrXn
 jwM0TRSnxQIfNPw4l5RoVRwEJ2mgr8ub48iCcSD8TW8Kc+FwKHc+tmJo+d09z5StsfrHzw6hI6W
 VGORtTQfe3znKl1H7ZwKBXwWpA4MITrvFkiTX8fYc5CD38pYeLG9L3H3RrTA4QzLw/kIY3+ysIM
 2pwonFrwwL/MkOwKYfrEy/1dbX7PQsNzznOqCM
X-Google-Smtp-Source: AGHT+IEIHsjq0Q0E0MC63ZiO53lOGyw1PzpYMLoQcHQfZNErwXOm+ycsyNqWTP5E27xuGg6Pspj7gYoBDN9C
X-Received: from pfnd9.prod.google.com ([2002:aa7:8149:0:b0:730:7c03:35e1])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1645:b0:1f5:769a:a4b2
 with SMTP id adf61e73a8af0-203cbc28d1dmr20886588637.17.1745281669401; Mon, 21
 Apr 2025 17:27:49 -0700 (PDT)
Date: Tue, 22 Apr 2025 00:27:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422002747.2593465-1-komlodi@google.com>
Subject: [PATCH] hw/ssi/aspeed_smc: Allow 64-bit wide flash accesses
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, alistair@alistair23.me, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, joel@jms.id.au, andrew@codeconstruct.com.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3heIGaAcKCqwWaYXaPUSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

cde3247651dc998da5dc1005148302a90d72f21f fixed atomicity for LDRD, which
ends up making accesses 64-bits wide. However, the AST2600 bootloader
can sometimes compile with LDRD instructions, which causes the acceses
to fail when accessing the memory-mapped SPI flash.

To fix this, increase the MMIO region valid access size to allow for
64-bit accesses.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/ssi/aspeed_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index faef1a8e5b..a1160187a4 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -359,7 +359,7 @@ static const MemoryRegionOps aspeed_smc_flash_default_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-        .max_access_size = 4,
+        .max_access_size = 8,
     },
 };
 
@@ -670,7 +670,7 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-        .max_access_size = 4,
+        .max_access_size = 8,
     },
 };
 
-- 
2.49.0.805.g082f7c87e0-goog


