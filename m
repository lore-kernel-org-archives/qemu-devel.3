Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDDD5AE5F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tqz-0006Cr-0k; Wed, 06 Nov 2024 23:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqx-0006CL-6R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:39 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqt-0004y3-8J
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:38 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ca388d242so5626455ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952632; x=1731557432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hHHOLYy9BpCbJ2LJQ8FMJDmoRyMrhml0DVZAtMtK1o=;
 b=NUmOu5xZxKggmnxNNAVZ84xsKirxJ46XSth4UtchNrcRun6M8kLuCC7LKzU0Lo+UMf
 SdvW3QAIZ++qbnfh6UKMu1qiFjvMpTY6vAy50Zk2XvTjTpAFDbxgY1SoMKst/pPv53gM
 Bls9EIq4CX028d37v8Nf8DKxeJ3RP7tzQSNzKm7rQ1KG4FYCN3tb50Z3Tn3HuvQi4ejJ
 YAPijew57d6BcMHdCIylJ6LSoGFMx9rRbJ4P4UemMAdSrGqi1c30ngwyF08c/9MlCZN+
 j6MtxB3wjVNTW1DFZtyq5VM4OzIwrs/vaVp1Ny0xF97NcJsQEnU21S54yrUSZeEPDEuh
 PQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952632; x=1731557432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hHHOLYy9BpCbJ2LJQ8FMJDmoRyMrhml0DVZAtMtK1o=;
 b=s970aKvVLAUSWncAiZf2t/k1sMGu0i40/ck/wH4pJBQyZNnofW+edf/3l0aS4h2nsp
 zaSt7elKgVLWNJCtkkHdYqZhtXaZXpiaYm9qXxsX9JooXOahn6lGLjYO/+MET2kzfHkQ
 7DoHgD/nQCEXqlNoU9jv10/Su2l4dbtS/GZTUQ0FwxraoykWkB+m/epvXUDKvYrUSeIS
 GeIZRwNthtlX1XGHlgOiy67ueeNJiq4uc7nb4+Rv87d0YejyBcpzoqFBBejwHv8FDtX/
 ViWS9UlnheCknNrlqd8GBDo/8QU0S3tHmcmNJz8XrZt/80OVIH5alJ+HDFb6AdDCGyc1
 G1Vg==
X-Gm-Message-State: AOJu0YyJOCHyE5yr/+Uohl1t2B8yxhAvXNkS70tRBnd8RA9yDcPfrXlH
 sp7w3zxtc2npaIi1/gXl9ta3wibnSSc/ILjc8jHGkUFqNxQIgzvQQ3Ksog==
X-Google-Smtp-Source: AGHT+IGt2MJkJ3c2IedVRvhIPptfLTTZOrKiaf6qmG/tV64EPNMGSQFZCki+Ry9pCY2nOgkPMaopLA==
X-Received: by 2002:a17:902:d2d0:b0:20f:c292:6662 with SMTP id
 d9443c01a7336-2111b00a439mr302068825ad.51.1730952632373; 
 Wed, 06 Nov 2024 20:10:32 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/12] hw/riscv/riscv-iommu: change 'depth' to int
Date: Thu,  7 Nov 2024 14:10:06 +1000
Message-ID: <20241107041016.40800-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity reports an unsigned overflow when doing:

    for (; depth-- > 0; ) {

When depth = 0 inside riscv_iommu_ctx_fetch().

Building it with a recent GCC the code doesn't actually break with depth
= 0, i.e. the comparison "0-- > 0" will exit the loop instead of
proceeding,  but 'depth' will retain the overflow value afterwards.

This behavior can be compiler dependent, so change 'depth' to int to
remove this potential ambiguity.

Resolves: Coverity CID 1564783
Fixes: 0c54acb8243 ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241104123839.533442-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 12f01a75f5..164a7160fd 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -863,7 +863,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     /* Device Context format: 0: extended (64 bytes) | 1: base (32 bytes) */
     const int dc_fmt = !s->enable_msi;
     const size_t dc_len = sizeof(dc) >> dc_fmt;
-    unsigned depth;
+    int depth;
     uint64_t de;
 
     switch (mode) {
-- 
2.47.0


