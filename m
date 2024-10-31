Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C67E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MG1-0007Ig-Tz; Wed, 30 Oct 2024 23:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFz-0007IP-SG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFy-0003uh-HC
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb47387ceso5260195ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346837; x=1730951637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muvNKmT1P++0ktM2BHqIeOncicaOsvuhV5HRETcfW/E=;
 b=hWRKQHg0WRRz3+yECJ1r7PC6rh4YLzFc0CgvZJ9KJZxqLx0ISUFyKAoxVbIZ8yXtmV
 rh1BKGp4265/YlFd7PGf+1atvNkXc3ITzFOXzFYLNQU8aOOsLvtieV31+HHpNyTppnrD
 Nd93VRcJB4vxmXjTWCT6rHOfBEvDBdmqcAPzhgbOGNIOow26mdvx4GjkPo6AFEwO0E74
 jn7LpmohH6B306NitudhYB6QDljsYQaqFu9Lx/JBPWMy1V7tKapKxLd51zl7Y3fFytzg
 5iEMLCokmJFuWFzEmUeRpsjUsQqbSF9eSoCJbIKrkyAFGpxKrEkQ++uJ/rwoOKbpTDq7
 87rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346837; x=1730951637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muvNKmT1P++0ktM2BHqIeOncicaOsvuhV5HRETcfW/E=;
 b=WE0zLZTtJ9gLLAxYqQYFZteramzKrxtrWbhJ7U20Kd8WfiZyzJj47GyyTkjO1rc7ME
 WJPwyGEk3JUAc2xMaDekhuYOFphZdyKwuRMt2vgrABpYAi2tNnNM5IGAVqFD+2LHbaKj
 gHyPUWZBK+c1zg80sPNSHPwtPD9pqtJb/ETGnx+ir7YtznpyYVqVaGVflyFz4LTZpNmv
 nyzMUuOimf2BJrJ8oEo7Zf49wgwQznWTO28yJJPy0gtvmmfCVjEziBRYOtn6Z2Mvt9+/
 cHvpRmpPPTW243AFS+HoZxW7VvwRbSE9P+eo6e4fv+MeOCTQuJkfzS2TitwWxj9JDSiX
 0qHA==
X-Gm-Message-State: AOJu0Yx4O2/DCe5olnvJH9UkISpubX0wd1eKgbkLiaqui3hG6ttVphaL
 V5AnlItzRSEGza9zzGbC8nr0b8vNoVB1KVUokSPgdPVlbIiX2wJBCZlUt0eX
X-Google-Smtp-Source: AGHT+IHxNHIbE47JhobfFzqFwTglEGstqpYgraT7H9XKwIH/J5UtWaPcVXkE9HlkvfwehVJCMRQgHg==
X-Received: by 2002:a17:903:440d:b0:20c:ab29:8133 with SMTP id
 d9443c01a7336-210c68ebe70mr204953155ad.27.1730346836716; 
 Wed, 30 Oct 2024 20:53:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sergey Makarov <s.makarov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/50] hw/intc: Make zeroth priority register read-only
Date: Thu, 31 Oct 2024 13:52:38 +1000
Message-ID: <20241031035319.731906-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sergey Makarov <s.makarov@syntacore.com>

According to PLIC specification chapter 4, zeroth
priority register is reserved. Discard writes to
this register.

Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240918140229.124329-2-s.makarov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/sifive_plic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 7f43e96310..8de3a654bc 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -189,8 +189,13 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
 
     if (addr_between(addr, plic->priority_base, plic->num_sources << 2)) {
         uint32_t irq = (addr - plic->priority_base) >> 2;
-
-        if (((plic->num_priorities + 1) & plic->num_priorities) == 0) {
+        if (irq == 0) {
+            /* IRQ 0 source prioority is reserved */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Invalid source priority write 0x%"
+                          HWADDR_PRIx "\n", __func__, addr);
+            return;
+        } else if (((plic->num_priorities + 1) & plic->num_priorities) == 0) {
             /*
              * if "num_priorities + 1" is power-of-2, make each register bit of
              * interrupt priority WARL (Write-Any-Read-Legal). Just filter
-- 
2.47.0


