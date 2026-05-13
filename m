Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0702BCD484C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN1zr-0005Tc-8U; Wed, 13 May 2026 01:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wN1zl-0005T7-Cs
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:18:57 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wN1zh-00059f-L7
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:18:57 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-366330b6751so4204860a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778649532; x=1779254332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tI5LwHtWHYv3uhZZRE9ksccs9RlwP0gP7r09Zkzt8cY=;
 b=JYL26usv8OuRsH2vJayz2Ie7M24K9nV2UBKr45e2WrV6SAbCj5BvPUesPvGhDwpix+
 Xe1rqPSoteghb+6LnbJXUt4RDLYmtQuTprxZEx9q2Ha21DnzWVVsTNVIAea/w3FwhdoM
 uQF51R7NMzNGtx78oKBrKubOvb4YSJFbSzFkjH/kJkd8mvSAfdPI99ruUHAYaDMy5Rw3
 Dp2rTb0YqpeTLnDFWylm0dTaQUMFjpN2VHJyxC1fIIaHPz1zLwTV9amp7Qdd3g/U8a/n
 wFRpOeiDdAa630JELpXCq7TEVQaE/KHKn9m3QTQiCMSQK1NFCA6CXU1cSWgY2M/Xf5SD
 t/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778649532; x=1779254332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tI5LwHtWHYv3uhZZRE9ksccs9RlwP0gP7r09Zkzt8cY=;
 b=Tg+9nm8R1FCSuUOfQD5soFKoUeBZ3CIQUjXNK6+BlP1MvK5l/YegCq8HgWhEMV3xPr
 kblmxfftEVE54ceIIKO73TkfIoAdk7RrTBrOhtGCxVT+qsn7lsu01mwKBJrTBRnFIzhv
 haISpWZSjEbpZFCeFPTONz8BetS509Mb4IKhDeEuSrRuAb2w5xR7CgDXTVD3FR2oj9lb
 tC2NKvNUIKRDk2mXRRB0Jury8+7HnjNq11SPpj0WgN99M0bYzsCXQ3iUPMjfYrEJDGUv
 XR6cP1FTctyOgDzXQgUWXAk9A3A9O49s2y65EO4m4q2zndUC5gm4C1L07KSjOddzHf6Y
 E4dQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AozZd8Rn8D62oNN19qNx+2OW7ERscn1keKQsOkK8xp7584Lx7GJzySv373pWjG1mKDCCI62AQ8gU7@nongnu.org
X-Gm-Message-State: AOJu0YwN61vuM9cCDmRwl9dOqXzwkxmtshrXKHZk4dIV9al9lVqW9J3F
 690xKMfHg43bd2iuUBFzdCH2ra5Gg8qt8y2MJKf1VeCpk23+kbmLFOOt
X-Gm-Gg: Acq92OFq4pNVYAhrvLZCf77fahDU1Knz8HQ0ioK4cMPD3lzQ9aSiKopI2afU/JqYcBE
 Mzr2uwen8zfvXAgDmCuSm+moc041HQ3hMmUZWU5J4Sajs9Q/thv3lIQWc9fATb4xNPiFTrJoyBN
 w170Ui+UMIOpYKZtL8FJMNaRB/CNd0tNGVo4WQI7Q20Vie+t5rh4ntOD/70cL0pXKi4V+AQXBrM
 H4Rk2snY38RmRP8nHy5EOsSD9wfYaqg8CCTQV2202J5FIP5OGoifujJ1HOZKV+8W04IHsbtmZPb
 a2KKeJeA9YKy+RDYV6jTudtZXT3v/YLkO0s0cXSSwSpJsWEwKAmpIkZiwpRn7M4vyi1wMAmDYNK
 EJGlxpdLs/vblo+yi95vqBCRqOFgu40jnrnyCJdqwQhx8J4anOr3/vJfuCocFfdPbJUvc/OwIe0
 d3S/ZQajGMQQaQYkjn6Jw1ABdpmKx39u7gVcyOgh40wktqiv3Bka8O
X-Received: by 2002:a17:90b:3c8c:b0:366:70e:77f4 with SMTP id
 98e67ed59e1d1-368f782b36cmr1394978a91.12.1778649532064; 
 Tue, 12 May 2026 22:18:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368ede2074esm1614069a91.1.2026.05.12.22.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 22:18:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] target/riscv: Update the local interrupt mask
Date: Wed, 13 May 2026 15:18:41 +1000
Message-ID: <20260513051841.1671987-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec describes bits 0-15 as standard fixed interrupts. The
AIA spec on the other hand describes bits 0-12 as standard fixed
interrupts. This conflict causes issues for us as we don't dynamically
determine if AIA is enabled when setting the *delegable_ints consts.

This means currently we incorrectly treat the LCOFIP bit as delegable,
even if AIA is disabled, which is incorrect (see the issues mentioned
below).

The AIA spec indicates that implementations can determine which bits of
13-63 in mvien are writable, so let's just make it bits 15-63 to match
the main spec.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3134
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3135
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3138
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3140
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1cd4a299c..db886aeed1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1777,13 +1777,13 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 #define VSTOPI_NUM_SRCS 5
 
 /*
- * All core local interrupts except the fixed ones 0:12. This macro is for
+ * All core local interrupts except the fixed ones 0:15. This macro is for
  * virtual interrupts logic so please don't change this to avoid messing up
  * the whole support, For reference see AIA spec: `5.3 Interrupt filtering and
  * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupts for
  * VS level`.
  */
-#define LOCAL_INTERRUPTS   (~0x1FFFULL)
+#define LOCAL_INTERRUPTS   (~0xFFFFULL)
 
 static const uint64_t delegable_ints =
     S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
-- 
2.53.0


