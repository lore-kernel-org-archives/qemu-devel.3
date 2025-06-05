Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2561C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNANv-0002Kx-0q; Thu, 05 Jun 2025 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taotang2025@gmail.com>)
 id 1uN0Jh-00089x-62; Wed, 04 Jun 2025 22:26:53 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <taotang2025@gmail.com>)
 id 1uN0Jf-0008MP-N6; Wed, 04 Jun 2025 22:26:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-235ea292956so4950065ad.1; 
 Wed, 04 Jun 2025 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749090409; x=1749695209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K75aSCyzs9q5zyzmveX5d6CIqDix0KE2if+KVjMGA+I=;
 b=TBUG62KgYIZAUk08SXzF3Y9ycrEZ+2mvnxRzv4Y3Si2L4M0RCCpD8XzzWSjHxZ0qRd
 fvya5iGFx4Fm85VJP3InDNA5lq1BRi5awN527L2BC/y4w6W30rh9CssQPybAyHJxVx7U
 y9Pz2k81AJlw8m8POsnzPIY1xWAy1/wDtkpsAMYzE2rw0eJgph8crtsqGVLOqoojNvWA
 pacNd10oSSEHm7ZVbKLpv4J0MAtKYEJuzH9gEPq5SnYU4f9M3IMROzSUXdRiuh4qxGBO
 AYrvVcOPvrDSUaaRVx/4XM3g9KV/YCP2eQ9vUyRVk1LURc3cgR53t7+uagj45JLXBIvL
 7jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749090409; x=1749695209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K75aSCyzs9q5zyzmveX5d6CIqDix0KE2if+KVjMGA+I=;
 b=scIDbeNbQdAtQP2Kcd7O/INIOCkW9wL7/mqmSh+VFrJc0oN1mba5x+FvLeq/QqJKCa
 gMOXBYklK8YBHO00lZxGdBW48wx9Wdxb//2THjlD/hWinaB8s606DwFYI5L4aVBIah8g
 1zO3ZHNb8KGfgPO0z//JsuPp3SoaXWd1R+m85YpzrQrGrIfvVZGegyhewdmjN8vmmlfh
 bBkTSijt6OzO/hFsoFmYDtNrLeuRrId3KNP0yARmRYvvrdAZnESp2/pyxPm3NBGodoZO
 7VfCPAeMTzbtSCNB2l/tRppHPeYSV7FiPuX1qg/Y6fcR/EmkTzNPXy1m6fFtrSdGhO9g
 S7gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjDGtK7q8CNbOnz76IvIruULp3Trpqjzql7oAdxD6usac/o984rgD7P6sn1RDC2E87eqVi49QpbQ==@nongnu.org
X-Gm-Message-State: AOJu0YwII+hrcO5RK3rsrrqVbnvYRTESqffoix1pxX+tvrlRUI+3kSz0
 SNM9xCSLzu3k2CZG0xjUu1U7i7WVtqGZhehodfg9aH+M/t0iKYKpl/oDK3svuc/prpc1Bg==
X-Gm-Gg: ASbGncsLIilEHkpQJCEl3X3J9FuJok+w0YNfstoWidQ1f9Fdsa+hJy/yy2v3s5PkTCq
 MX/ISvMQv17YUmB4+xQSF5JgyBF9/K0qpBpTFtp6J9P4JEpsX9G00KqzT8K2JKXUE92flDQLhWu
 ZE2xD9KblIFv7hPnDxLCm/HnwtJVYIZHFEoQV9YiOWcYs6urIIwPMLtahqXiQxCJT1nlT1RQmF2
 Fz/FW8V91Yd8hHUDnE/J722LDZWyjr7dvjm9gCtqBGE5q94VYqZGeiyp//eeSFnddD3KyZPNEmG
 D6TB4Q3BEob8JJJ/xxt6lUkQGBOFt6ysOG9+jBFRmQcI0+lljH4z2L2gr/A=
X-Google-Smtp-Source: AGHT+IH8OPNSpwxBrUdUqJj2+994aSNoyODfmzm1dEquwe0Z7OMJgpOejAjOM0KUOjB9KYRyfdTXYQ==
X-Received: by 2002:a17:902:c94d:b0:234:9cdd:ffd5 with SMTP id
 d9443c01a7336-235e11e5c3amr65613585ad.25.1749090409026; 
 Wed, 04 Jun 2025 19:26:49 -0700 (PDT)
Received: from huawei.. ([218.76.62.144]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd3506sm110296125ad.156.2025.06.04.19.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 19:26:48 -0700 (PDT)
From: taotang2025@gmail.com
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Tao Tang <taotang2025@gmail.com>
Subject: [PATCH] hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0
 register
Date: Thu,  5 Jun 2025 10:26:40 +0800
Message-Id: <20250605022640.598308-1-taotang2025@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=taotang2025@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Jun 2025 09:11:51 -0400
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

From: Tao Tang <taotang2025@gmail.com>

The current definition of the SMMU_CR0_RESERVED mask is incorrect.
It mistakenly treats bit 10 (DPT_WALK_EN) as a reserved bit while
treating bit 9 (RES0) as an implemented bit.

According to the SMMU architecture specification, the layout for CR0 is:
| 31:11| RES0           |
| 10   | DPT_WALK_EN    |
| 9    | RES0           |
| 8:6  | VMW            |
| 5    | RES0           |
| 4    | ATSCHK         |
| 3    | CMDQEN         |
| 2    | EVENTQEN       |
| 1    | PRIQEN         |
| 0    | SMMUEN         |

Signed-off-by: Tao Tang <taotang2025@gmail.com>
---
 hw/arm/smmuv3-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347..42ac77e654 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -120,7 +120,7 @@ REG32(CR0,                 0x20)
     FIELD(CR0, EVENTQEN,      2, 1)
     FIELD(CR0, CMDQEN,        3, 1)
 
-#define SMMU_CR0_RESERVED 0xFFFFFC20
+#define SMMU_CR0_RESERVED 0xFFFFFA20
 
 REG32(CR0ACK,              0x24)
 REG32(CR1,                 0x28)
-- 
2.34.1


