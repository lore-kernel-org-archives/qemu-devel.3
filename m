Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101C2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qp-0002Q3-Ll; Thu, 09 Jul 2026 22:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qb-0001m9-0I
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QY-00006n-OL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-848643382fcso377224b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652240; x=1784257040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vTsW/euw9azt9Ltxs73ADlNZEjj8SMzzWhESBjZaExc=;
 b=gOkJleOHs6Amt8Pse2kqkf1ObTrY0/PkhJI2bvRxJtv/5JMOqpZV4XNPd39l8Owt3G
 dbk5e1/YMFlLsS8PKBqXXRHzX0HX+c/Po0/n2U90wARO0y/1g+uDpXhkLspfkDhUsdXN
 LCwKOVXgRwaokzOhPBGAniLhRAH/riigH1KIpZGYEQ+rEnWFHTbK0f0tx59tellVylI+
 R2nul4pPvTEoQM4+85Pmhjmf5iXHxf0gOxMOZKoEvoodEH4cQVOuPYsmDDg3sQZ2bFB9
 w4GNYJqX44LpKyosGOopJp+vpH2T9M9mgzwFkvrPSI0kfTbg7tHU11FAqdwFZjNhrAz2
 9Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652240; x=1784257040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vTsW/euw9azt9Ltxs73ADlNZEjj8SMzzWhESBjZaExc=;
 b=kxZ2eDMrTsrGCBGozKh8wlBeqo/YOpuZkPrkDWPRNIVjo/CtN2UNYoQXApNMOjFgvs
 fZJ8cqfSF8/pxKw80vXqzDPTwZ+GCytjJ1yAeL331xkOS1TxoZzT0ghmL1Af0qU9rUre
 wtzHOP6O2jvb0t56Uh/IamUbrQKlPInaAlXZjTfdm2D0wRr1Gr8oWqeUsfB9JanmRBLv
 x1RZGSQ9DGbmQRFpPx7i01ddQl+3V+cz76pfR9dzWJfcUebIJZYp1pA3PLfudNe7SLZT
 pwXCaqrI5c31IehGOHp2w8JOCSzhbe3EbWZt4TizFZgVlpsTXtgRumz0o1q23LCBj8Y3
 acKA==
X-Gm-Message-State: AOJu0YyQUJ1nPcLwOV2IA7T0J0VTh2pnKPoOSZTg6TmP7J2LGt52deCB
 /Hnf8YzdoClktpLkiQ/5qRD/q4wz/g2Ov+N/x0bmOoxB/yzA0h3CWQiE5JzgHQ==
X-Gm-Gg: AfdE7clmoQexvZSglXuFH/4iEgqZ73KCGUDUGawJjdiR8DvF2dm8nmYFfmnQdtqZKgS
 WzTXIJZFzk4cX5wPi0pEPpj7/S6KIQ9EwZY7FkLQkGjybWhcray35jrpaJmMljEZMHCHLROpUQe
 ASfy1xVz6nX0o8X9YAw6bcDBO6U83qR3DGKnHi0bHm57xuyE2YYbfiIaxctlFJM0neammnslpC1
 +ebdGZHx4Beswn3QLRb9YUYNoAR+M/PYW1CbAkEWmtKU/v0j6U0/Gm2nNA1pp7pHEkqIiIYlWbr
 IRf9U4dUz8uZiKxKNqQRcMmL6zm/P9MmfCWB8J3TznR8uUZnUHJVDPq2jAIHUC04i1tf8RmfsGS
 nvrZTSzrIzByr/awOBTRJXS+uP60B93MIgQGEJmNFUwDpUF57aCWa7ObmPgPHQoxQCGwVUy9Bmr
 VJ6fSO7GUa2wm30mVOkiN/VJlkrVgrFIw=
X-Received: by 2002:a05:6a00:148f:b0:847:99b4:d011 with SMTP id
 d2e1a72fcca58-84843410d7amr9558085b3a.39.1783652240374; 
 Thu, 09 Jul 2026 19:57:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/40] hw/riscv/riscv-iommu.c: update ioval2 when faulting in
 spa_fetch()
Date: Fri, 10 Jul 2026 12:55:17 +1000
Message-ID: <20260710025525.1704417-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_iommu_translate(), the only caller of riscv_iommu_spa_fetch(),
will use riscv_iommu_report_fault() for all faults it detects.  And it
will use iotlb->translated_addr as 'iotval2' every time.

At this moment we're updating iotlb->translated_addr only after a
translation step is completed, meaning any fault that occur before that
will have a zeroed iotlb->translated_addr, and as a result iotval2 will
also be zero later on.

Keep iotlb->translated_addr updated with the latest translated addr we
have.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3559
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index d3710aa3a2..bdc409adc9 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -574,6 +574,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     } while (1);
 
+    /*
+     * riscv_iommu_translate() will receive a fault and then call
+     * riscv_iommu_report_fault() using iotlb->translated_addr
+     * as iotval2.  Update translated_addr it with the latest
+     * translated addr we have.
+     */
+    iotlb->translated_addr = addr;
+
     return (iotlb->perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
-- 
2.54.0


