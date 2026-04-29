Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B49FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwqU-0000wu-0b; Wed, 29 Apr 2026 00:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqS-0000wc-5L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:20 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqP-00087Y-Vd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:19 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c76c60c7502so197317a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438096; x=1778042896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up6skKqJSQQNZDXlNUFBGctHSex7FpmhenPiP1DwEl0=;
 b=XGcsUc7yjmkpakthUY1UqVi8AJo9VC2sa4LwQ1s9gNG62kzkW6ZWFik4BGtCQgeZit
 tiKg75qv2eqZXZSMt/TsY36pY02j8FR1/DhePEJ+6IEtS33Gu12U2W7FZksgfBY2o7fv
 imSQDZmKBVCjIVQBGTuPLs9kvzWvRrYz6w+1NySl0oIshaiHoSIeZx4XCZ5+u4kbBD23
 xXlUxCQbKDIkqdmWIkV+u7glcN2hYjHSE6GLDIIZVFcFUWWOd5xQ1pzC/57jQGiE7eKU
 lYlNWJbGCLPOaTspOhMmWCt7NmNG1edMm6YVojr6ZWRKcmYEygZlp0c8tDxLkabGOBFN
 /nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438096; x=1778042896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=up6skKqJSQQNZDXlNUFBGctHSex7FpmhenPiP1DwEl0=;
 b=OvNMc5NifPv1kliLJyduHiuCXX1c6kIVxQ06OtMh+HjnhP3U+5xlSwlbKMNBRS95YE
 oX8QzAHrZVL8aSlGzzrtfWjecdmq2lxeD5zK0cG++XjM/RgG9oGn7KDNbX+XFpjuDSEi
 ZBPcssv3yQmSbJy3AjQP8PKI4LYB1vzlPdqJhyMPdFjyGikCLP/FMevKpjcF4JSmVYH3
 HCdj8CMLfFZjI8jk3rdndYPhDh43aj91LAWAeRJt+aWkGqeud/RX+aXSrSu7lh3VADY5
 3Gjz5ycKIsZRAJUhrkBqzsWTRg4oaA+IhV1o2MMYv7kZ+/KNVLbJ1IgEmKEH97iF273U
 +sBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JcHxhcSWD6EXU6AsuXyZeC9hJ8y+JVhcMHktjaTulichR4MmIFRo4hX/lZhXpgkOVfQBRR5dvg+Pu@nongnu.org
X-Gm-Message-State: AOJu0YyDYkPwL/3K7WA3RTtsorTtrqFotcl8reJN+Q4mFLgdBmP6ZOS0
 tchu2rEOTye9bvz+Qg2vaIt5ox2k7GTy64wkw6JWrpOoNZf7s/oesxtn
X-Gm-Gg: AeBDiesokmrLxOnfqVZzTo3Ciq1SxZ8gaAUzzFq1JBLi8cBj7TxRgbPk09b3HHx/4r3
 D2O/8iXWrRu0ga8m9dme6oO1OEQCscSZ2whwRXg7YISBTqZIHbgtqB2CnZp6WD2ROKPNXrvvNbd
 yxQ+UJlacblFV9T+mLnNJmEzY9413wPLk65koU5vnmXWjdARF654hWukR2rkcH2iPDW5S2p+B77
 eoI76YMcXs31ylrqtNyx/KIZdAWT91B6ZxsrJ4xCM75co4EXlB1fuMlBCgu/uUngfzv9th5qEUb
 5BLQBMB1xO/h6CgOOotcE61Bt13SSTcIOQ7vOldGTWNC7U6xG+npZ7MvV6DCVsfC5lW3q2s2Zq1
 s0NIYbQYECMkXHGATyXLvBlSslHrcI30mG2jf0pkRnT0B6LEoLVNNerjFpy6yXC5COEGD6Vn4sH
 kQcvajg/ul7RfFfIKooQquSVO17/nKeUEJMNWbIYwXWYXtdCWdl7rs
X-Received: by 2002:a17:903:2b0b:b0:2b9:6cde:c34b with SMTP id
 d9443c01a7336-2b988238921mr15113085ad.15.1777438096502; 
 Tue, 28 Apr 2026 21:48:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/51] hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
Date: Wed, 29 Apr 2026 14:47:02 +1000
Message-ID: <20260429044752.4176397-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

From: Jay Chang <jay.chang@sifive.com>

Replace the temporary custom extension bit (TC[32]) with the
standard EN_PRI bit defined in RISC-V IOMMU specification.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260325014856.58948-1-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c3c9ed6469..8476405d0e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1572,11 +1572,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
     iot_cache = g_hash_table_ref(s->iot_cache);
-    /*
-     * TC[32] is reserved for custom extensions, used here to temporarily
-     * enable automatic page-request generation for ATS queries.
-     */
-    enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
+    enable_pri = (iotlb->perm == IOMMU_NONE) &&
+                 (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
     /* Check for ATS request. */
-- 
2.53.0


