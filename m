Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B87CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2D-0002DG-L2; Wed, 01 Jul 2026 06:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2B-00023e-V7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:12 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2A-0004mR-6a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:11 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-139f1dfc9faso745193c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901149; x=1783505949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kJLk5Ha+pejJGZeNgnvGuO8LBxn6qxRniUrTFHlUS+k=;
 b=ZPplF6RvDFwnVX5Cc9h8pcsv8sm98OyU6QGLZjcIbxj0mU4+5z1O0ThEML2Qq2ZzIk
 f9MLa9TMo2Y9FNLVfkwqTgMX9C5Eq6jRqyXqhpHiN8lgbY7yNAraLxZpAVA8Px5vm6rb
 SgDrJnrtJj4n+3kFrDUIfHsEYSLWhbajlupRcLiep6M4IaRGEf9WmbxZ7nikT5FcNHsw
 OGQwLwyY1TZBXrOEUlB+BcBSBYqEgY/IADjAdps+5aeTlusll31na4xS3IWawrCR15dd
 vPvoqG5a8j5/tbLiBJYeAc9J4jC5CeKglR84/zfLALTr0tW6++QR/+OYkHdngb93FzWo
 kJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901149; x=1783505949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kJLk5Ha+pejJGZeNgnvGuO8LBxn6qxRniUrTFHlUS+k=;
 b=j4sPKyMMtVwcqTfZqfl2WuS4U0a6UM/5D6V0H3ZBhJy+2Do1o7qSf3F5b4cfVSGT0G
 OoaEyKQxfOWJKKRMLvNw7B+SRqtPys//dZQNyW9qAWfz4EpCIrACB/F1ecuIRHhepOAF
 AADw5U/A16O2r5qiDoFHrufdE1TfgaiVEftKhfXR0DwU9EaJm7wA/fus/ekl5u1QU0Ul
 7E1sB1IldbUtqwxothC/jqsWVX5xtvr/QbgwYnx5mQr91DgECAXUogeSME3Nyr8OpBhe
 VRXrYSkNRG8rTqruugTyN0PmGATd1Vq1Sjbw6U73KZ3vkvKRz36/rTXgnFnsvb61mZec
 /Zvw==
X-Gm-Message-State: AOJu0YyydETNu9oiXCUhLGMRE4xB1ifKS0ZLqBnv0Ia92+5WnzYOfbd0
 tGrasOru1naMFJ/Lkpm2nRGvP2PardieXZIGJYSsrNVBNBskiEwvKzids/q0cQ==
X-Gm-Gg: AfdE7cnGLSI6aS4Ucq5A+u9ZpLU7ObxCoxsuhgKFWR3eYK7BA31aZoot/xGHDcZtzNs
 tZqh+eki/CYxkurvFwD+RMmjob6wR0vlRV2C/4phVZPUbyg2Si05m0Seej/R+t1q2mEm6iPoshw
 8nOSRntOojIWqor+sM54a735bv9oAEoZ61SwFMoOuopjgwwoBPhKfyI4nI+DQbXid1oTXXcCX3u
 2Asx47ZmpKAgcXFk+Cv8kto7kKt7rKmpxFyuHG9qimFiIomiyHRsYkKuWFLVcz4oSPSFaFckZzB
 53qEuNl1El2+wPHCI1knQyOoa6sdNCA2tASEtI1mNndV7xUhfe71TU4oryRCXj2GzsHZTTeniY+
 UQrtboP7Z87QZLu5nDE70AvdOVUr0dgknA8cS0Lwm2OmsZkmlXnwlGN+YLASuBGaqK3Knuq3MCL
 gJ8uACNGGqPSwwsZPTaepRGHYrUlBBNvk=
X-Received: by 2002:a05:7022:210:b0:13b:3132:6e94 with SMTP id
 a92af1059eb24-13b390eb92fmr218433c88.12.1782901148721; 
 Wed, 01 Jul 2026 03:19:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/39] hw/riscv/riscv-iommu: check DC.TC reserved bits
Date: Wed,  1 Jul 2026 20:17:33 +1000
Message-ID: <20260701101752.2522962-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1229.google.com
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

We are not checking for reserved TC bits being set during device context
validation.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3548
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260627194640.4130073-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 3 +++
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index a938fd3eb4..f9b6f35170 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -308,6 +308,9 @@ struct riscv_iommu_dc {
 #define RISCV_IOMMU_DC_IOHGATP_GSCID    GENMASK_ULL(59, 44)
 #define RISCV_IOMMU_DC_IOHGATP_MODE     RISCV_IOMMU_ATP_MODE_FIELD
 
+#define RISCV_IOMMU_DC_TC_RESERVED      (GENMASK_ULL(23, 12) \
+                                         | GENMASK_ULL(63, 32))
+
 enum riscv_iommu_dc_iohgatp_modes {
     RISCV_IOMMU_DC_IOHGATP_MODE_BARE = 0,
     RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 = 8,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..c2c470b5df 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -752,6 +752,10 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
     uint32_t fsc_mode, msi_mode;
     uint64_t gatp;
 
+    if (ctx->tc & RISCV_IOMMU_DC_TC_RESERVED) {
+        return false;
+    }
+
     if (!(s->cap & RISCV_IOMMU_CAP_ATS) &&
         (ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS ||
          ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI ||
-- 
2.54.0


