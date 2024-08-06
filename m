Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A3C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK0Q-0002ys-6H; Tue, 06 Aug 2024 09:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0O-0002qr-4v; Tue, 06 Aug 2024 09:13:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0M-0003UO-4T; Tue, 06 Aug 2024 09:13:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so435476b3a.2; 
 Tue, 06 Aug 2024 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950012; x=1723554812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PqO+DYgcTMKO0xB3vRM0Tk2cvFGgi0Ib7F149Q/avM=;
 b=MdItoTWo+dFsTRmFh982apISat2VHEmy7di8hkF96GNZKAldtqErLhzl3iwfHWZ2jJ
 Z/dHZh8wzkEAwYE9LaD/jHY9v80gKTfGgABGTnpaMT0/gzDoH455fDBsdfGT3cLsUx7F
 /pZOsEW1c0go35XFojlyrXdJ2InvuvqO13yHFvJm9IBR+WW+eL1lhySoFilRO+Zhz/tG
 p0qqo/T0VnvYcP7DGhvJpczwldU9AdpfF+fQnAcHenmcDEBomQSflcebHMpEuUpA1Pfy
 G7capfrSULaJC+9Qo2txg66Jii8bq+WUoQMTpS31zu7kRZJ6DTkdoJsipq1JwjVFbG2P
 XqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950012; x=1723554812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PqO+DYgcTMKO0xB3vRM0Tk2cvFGgi0Ib7F149Q/avM=;
 b=bbc7NRQU52cElRJBzUKRIK8J2XNaMwqD1DyKjweWLlcbeHuqRe9MQ6tgAXVclWvb6s
 nYFjG8Few5eTV3wuH62kL+IdHjv4SY55CIYvmtsTfsjeW4Hu9kZeKSDKmRjLMrlBtFxk
 rIDpH0XqsBKoV0FAQUDxaa+EPHgtMT3pZKuPTTvLyhAgp6CGOsgxjS1GiT+wEfJc5OV3
 J06s3ZR8RF6yTabMzkCTOXYvVVFxX0RtDGhmqcMVAoCzaFNgF8fJom9Cm5yBvvlrgXCh
 HB+TGNuFHstnQJuzG0JqViw294aCVPB4ShET2OF7p4m+2FVg9Rg4U5YydfjV/tjdItYi
 7VDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW85hD+EmQZe+dbIXmYD6qVZ58bM9m5qw3b/AqClrMIr3VienfRxOBQnzHP7aWwEqbSJ2kaupqmkjv5IXUb+pWNyd7+Nxk=
X-Gm-Message-State: AOJu0Yzgme2zyNE+pI3hivMAMMChIHlg4mm/5LNNFBagMJIEAHh5eVaz
 e+ykT9mkidumSOGH5bkmrEwjJY3/+AQZK3QN1rTPv2n82vGvvH3nspnOwdiA
X-Google-Smtp-Source: AGHT+IFsQW/iPHB3uw4u00GlHe8SeLFDoGaKDsVCT9IyjeLOoS4tpkCEIbQC4k4KZb7fzVak9tDFzw==
X-Received: by 2002:a17:902:e749:b0:1fb:cffb:cfc1 with SMTP id
 d9443c01a7336-1ff5727c5bbmr165610895ad.4.1722950011794; 
 Tue, 06 Aug 2024 06:13:31 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/7] ppc/pnv: Fix LPC serirq routing calculation
Date: Tue,  6 Aug 2024 23:13:11 +1000
Message-ID: <20240806131318.275109-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

The serirq routing table is split over two registers, the calculation
for the high irqs in the second register did not subtract the irq
offset. This was spotted by Coverity as a shift-by-negative. Fix this
and change the open-coded shifting and masking to use extract32()
function so it's less error-prone.

This went unnoticed because irqs >= 14 are not used in a standard
QEMU/OPAL boot, changing the first QEMU serial-isa irq to 14 to test
does demonstrate serial irqs aren't received, and that this change
fixes that.

Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558829 (partially)
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h |  1 +
 hw/ppc/pnv_lpc.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 321ed2da75..bd32a1a5f8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -40,6 +40,7 @@
 
 #define PPC_BIT_NR(bit)         (63 - (bit))
 #define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32_NR(bit)       (31 - (bit))
 #define PPC_BIT32(bit)          (0x80000000 >> (bit))
 #define PPC_BIT8(bit)           (0x80 >> (bit))
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f8aad955b5..80b79dfbbc 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -435,13 +435,19 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
         return;
     }
 
+    /*
+     * Each of the ISA irqs is routed to one of the 4 SERIRQ irqs with 2
+     * bits, split across 2 OPB registers.
+     */
     for (irq = 0; irq <= 13; irq++) {
-        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
+        int serirq = extract32(lpc->opb_irq_route1,
+                                    PPC_BIT32_NR(5 + irq * 2), 2);
         lpc->irq_to_serirq_route[irq] = serirq;
     }
 
     for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
-        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
+        int serirq = extract32(lpc->opb_irq_route0,
+                               PPC_BIT32_NR(9 + (irq - 14) * 2), 2);
         lpc->irq_to_serirq_route[irq] = serirq;
     }
 }
-- 
2.45.2


