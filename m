Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9614AC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kj-0000t2-N7; Thu, 25 Jul 2024 19:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KT-0008TC-N1; Thu, 25 Jul 2024 19:57:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KS-0001GJ-21; Thu, 25 Jul 2024 19:57:01 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7163489149eso335856a12.1; 
 Thu, 25 Jul 2024 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951818; x=1722556618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhKX3eYSs372uGGCXm1+5NVZOkLJW+vApKQY8s/vIvI=;
 b=dsMRnY7diVCHi/c0a2ALVOJcuq5OmmwkKixNRUZ1n5K4HTvqwuuB8n6qe+eGEUqp3n
 6rICRCWSVX/yBn527y3bWMhAHRJ2JWGY7IZoHuZ188WbjBAM+HgWAFx/cfwYfGLOhHp9
 PmXi5KjO235lYuhVOQ/ckpdznSHdTLgHRQtMqTAQPgImTxxt86X1PcC3T+SSy5g/RR5A
 htkNAPFS61x3bUlqufIjAuAfuA4+9huNGiuf5YFffHre9Fnd+boo/Umo6RplWXhwikrU
 kYVGcaXth0ThhDcEXcWmK1tPl2LOlIU7b3mFmdWJEqR2ZxFdi1wRzfyQK53sxhorpzxZ
 QAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951818; x=1722556618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhKX3eYSs372uGGCXm1+5NVZOkLJW+vApKQY8s/vIvI=;
 b=Xj7oqPjZu5gKTQuMpvYedMpeV+wtKZuAU9dwV0Kwu0G0QoL3P5gU2TvuZq5awyaBkF
 sxGdIEGJ6EL6zkL6nOFVbHq569Dbv6IxoP5Ot4UBqNZenzB9BktASUdVSWljsHuPJ5dP
 2pFiWJQFtCDUCi02nlVkjHhQLPApRwn9FPMCom/06UiQXCuHAmb9YXtTfK+xieMfqFWp
 EDkeRqNHd30u6SLCTN+FEps0Z6FQXaQgk423GCkUm1tcm0imxr3jm7i5aHUddsNVAvSW
 sfOb/SnL4e2B/fquwmUYk6D6JfINJCgabypLPbE8buDawbh9GSl7mSmPEmBoC72H2dKw
 5CWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjhXnDq9TY2n5tGn4c3az4yUp/t/SjB4nw+rNDq+yi8NwEhKSCQ0/TWvIGQe1rbm8riJOW0kGeruxD6xk9avT2lz7i
X-Gm-Message-State: AOJu0Ywtrfb/d/7afNox8p+LWUbYYvat2sEnTcuEESDPBgZl8OKADJRs
 X51TGOBhju2DtEq6ujS2mVYUil98o17H/H8UOk1XCcyWW5/61wT2fLbhNg==
X-Google-Smtp-Source: AGHT+IHxXPLR8tL7Ba77i0i+grjD1YR6pOQYS1Y1qkPkd7Q1PLfOGvTWE6wG6Wu5yocknmuKbWiDGQ==
X-Received: by 2002:a05:6a20:841b:b0:1c3:acd1:5cdd with SMTP id
 adf61e73a8af0-1c47b43ae64mr3603640637.47.1721951818217; 
 Thu, 25 Jul 2024 16:56:58 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 43/96] pnv/xive2: Structure/define alignment changes
Date: Fri, 26 Jul 2024 09:53:16 +1000
Message-ID: <20240725235410.451624-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Michael Kowal <kowal@linux.vnet.ibm.com>

Made changes to some structure and define elements to ease review in
next patchset.

Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index af9ab68fc6..08b6da78fb 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -45,16 +45,16 @@ typedef struct XiveVstInfo {
 
 static const XiveVstInfo vst_infos[] = {
 
-    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),  16 },
-    [VST_ESB]  = { "ESB",  1,                  16 },
-    [VST_END]  = { "ENDT", sizeof(Xive2End),  16 },
+    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),     16 },
+    [VST_ESB]  = { "ESB",  1,                    16 },
+    [VST_END]  = { "ENDT", sizeof(Xive2End),     16 },
 
-    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),  16 },
-    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc), 16 },
-    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc), 16 },
+    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),     16 },
+    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc),    16 },
+    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc),    16 },
 
-    [VST_IC]  =  { "IC",   1 /* ? */         , 16 }, /* Topology # */
-    [VST_SYNC] = { "SYNC", 1 /* ? */         , 16 }, /* Topology # */
+    [VST_IC]  =  { "IC",   1, /* ? */            16 }, /* Topology # */
+    [VST_SYNC] = { "SYNC", 1, /* ? */            16 }, /* Topology # */
 
     /*
      * This table contains the backing store pages for the interrupt
@@ -1720,13 +1720,13 @@ static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
 /*
  * Sync MMIO page (write only)
  */
-#define PNV_XIVE2_SYNC_IPI      0x000
-#define PNV_XIVE2_SYNC_HW       0x080
-#define PNV_XIVE2_SYNC_NxC      0x100
-#define PNV_XIVE2_SYNC_INT      0x180
-#define PNV_XIVE2_SYNC_OS_ESC   0x200
-#define PNV_XIVE2_SYNC_POOL_ESC 0x280
-#define PNV_XIVE2_SYNC_HARD_ESC 0x300
+#define PNV_XIVE2_SYNC_IPI              0x000
+#define PNV_XIVE2_SYNC_HW               0x080
+#define PNV_XIVE2_SYNC_NxC              0x100
+#define PNV_XIVE2_SYNC_INT              0x180
+#define PNV_XIVE2_SYNC_OS_ESC           0x200
+#define PNV_XIVE2_SYNC_POOL_ESC         0x280
+#define PNV_XIVE2_SYNC_HARD_ESC         0x300
 
 static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
                                        unsigned size)
-- 
2.45.2


