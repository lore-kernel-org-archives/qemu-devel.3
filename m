Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721CED11182
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 16:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7dax-0005jl-7Q; Sun, 03 Nov 2024 11:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7dat-0005j9-KG; Sun, 03 Nov 2024 11:36:53 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7dar-0002zz-Vy; Sun, 03 Nov 2024 11:36:51 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so2598138a12.1; 
 Sun, 03 Nov 2024 08:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730651808; x=1731256608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/pq+cpC0aPZEsD6BLyH7HxMMBRvDsnLjWpqZlfREaM=;
 b=YNJfgH9omoNlaBuuyBobVRvf2qb74wCdFzuiztqw+xB2J5yDQyQF43gnPP6nuiAktc
 tWUEU257tmibngtgkF9stOwOEV5jb7ih+KLB2RZzBK9avwaoF4IcJLzW5tkV5scOUWCn
 SjO+wxvQ7gMFBPoD/nsP+rL6IHO8+twPSOAbOPCcw5bra8Dt6a+1Llct6fJPchrK2un2
 wfn9Ud2iKwQSeJpM+QDOuPhf9sVLn9lwulfwnWJj5EouZjmzFKBYECXHLVZbnT4vclmX
 oYa89DlBs6ahWuznl6I2dX9IOpgj3b6mSAo91UuStKpcnKuPd/ivJ9r+25mylbrpyXZc
 siIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730651808; x=1731256608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/pq+cpC0aPZEsD6BLyH7HxMMBRvDsnLjWpqZlfREaM=;
 b=NVwTVDIPXL5ITsZvWHQqO+by71BXPeJlj4N/vxBT3RiOiyEJodOk8FyAeWFCD5VDBG
 iS5IHe1kll413UMrODt80T2OST2OMb7YVmBInN2DIAD88Nisl6fBw/efBfyVxL+S9ZdZ
 0zBkHOzE9+FSNJkvN8R6XshFqVM7Tepdkwo6c58kGWH1FdLT6mS+GQI8RWiBkjEX0tuA
 SokhZKkim+I/w9E91T69MMFgEOolQX2D/jL1kqLJqjmYvh7lwuGGCGnYhgsaRrpSc7UG
 sukYozRLm5Q1tZPACpso1SvqfsBsVQEOlFsirlygInohHxwxVVoIhXZv9Z4g9aELxeRw
 VVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBdjI6JdBYhZP3z03u3NcS/JPNCM4PEnS8QLdjIK2TXz5Vgpd8lTm6Fav4T7pjQNePbDWd88Q6+lfU@nongnu.org
X-Gm-Message-State: AOJu0YzQWM5aNagxcwZPPXGdUGBikX2RLNzCF7i2aX9WOlmM+e05TO1c
 RSMK3g1Mnn4FgBqkuyWBXxn2PQiUgoWsDF7WIepBooWGG3wTU2Y4+OysPg==
X-Google-Smtp-Source: AGHT+IHEdyTIyvyihTGIXhrPM1HID+YBtLr1m4KOufqCK6NZu2i1Pm6l+wIowVmX869NUXq8BOjjEg==
X-Received: by 2002:a17:90b:1804:b0:2e2:e597:6cdc with SMTP id
 98e67ed59e1d1-2e93c1750bamr17783082a91.22.1730651807630; 
 Sun, 03 Nov 2024 08:36:47 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93dac03a8sm6741422a91.30.2024.11.03.08.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 08:36:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] ppc/xive: Fix ESB length overflow on 32-bit hosts
Date: Mon,  4 Nov 2024 02:36:35 +1000
Message-ID: <20241103163635.676443-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

The length of this region can be > 32-bits, which overflows size_t on
32-bit hosts. Change to uint64_t.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This turned up in CI running new xive tests (which is good, they
caught a bug), so I'll add it ahead of that in the PR. Sorry it's
taken me so long to get to.

Thanks,
Nick

 hw/intc/spapr_xive_kvm.c | 4 ++--
 hw/intc/xive.c           | 2 +-
 include/hw/ppc/xive.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5789062379..7a86197fc9 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -720,7 +720,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc = &xive->source;
-    size_t esb_len = xive_source_esb_len(xsrc);
+    uint64_t esb_len = xive_source_esb_len(xsrc);
     size_t tima_len = 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
@@ -824,7 +824,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc;
-    size_t esb_len;
+    uint64_t esb_len;
 
     assert(xive->fd != -1);
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index efcb63e8aa..245e4d181a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1359,7 +1359,7 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc = XIVE_SOURCE(dev);
-    size_t esb_len = xive_source_esb_len(xsrc);
+    uint64_t esb_len = xive_source_esb_len(xsrc);
 
     assert(xsrc->xive);
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 31242f0406..ebee982528 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -218,7 +218,7 @@ static inline bool xive_source_esb_has_2page(XiveSource *xsrc)
         xsrc->esb_shift == XIVE_ESB_4K_2PAGE;
 }
 
-static inline size_t xive_source_esb_len(XiveSource *xsrc)
+static inline uint64_t xive_source_esb_len(XiveSource *xsrc)
 {
     return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
 }
-- 
2.45.2


