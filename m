Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BF3FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwsT-0005QH-Ea; Wed, 29 Apr 2026 00:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsR-0005Iv-O7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsQ-0000S7-52
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b7d3ecc10dso39181295ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438221; x=1778043021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYb5INL1c8NoLrhbLHuNkrNTieGO07Z8dugd5Q2koJ8=;
 b=Bb22FATZmjtNvoMmg4FCklcvhHPHCE8FETUO/m3bMd7DtvjvvvqPH8n+DB1kyiUCOh
 z3MV0QQcu3wO6ZVfa5iUq2nN7pU/QiwyA+lHs69YSgJBHU+VpLe9DSoVqmkus/1ZHAsb
 RBssK5YqkruE7ILIm54MQnolGM84mie1OglHcpUbHgxTkwoY7+O9v8hwupwKqhma1DjV
 1xDFvd1Rjxu8UCx0RqDFkHluIjbwodhTp5TatkPPiuchyP70wJ5kfJ4e4GXkp9+Rp+pu
 JJnyOHQmm4N18O4KYbQImMPJKUiknsFgc9Ecnw3zachmf/x026d4fdjb5gEgtYe4dIra
 8W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438221; x=1778043021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hYb5INL1c8NoLrhbLHuNkrNTieGO07Z8dugd5Q2koJ8=;
 b=K6XWndME58jaOFdxLQFfuxuN58N9XaEzGl6EsOaP1qZX2p2c2ve48Lgs98v1YDjMzF
 vUkp8V5q1in9clmeJuhIg2jeSOa1VnZgvmFDuSsxOFGyGylxHDen52C1JYXG/FliNtk/
 f9lGv8rt4vQRILjjWqOMoRpMszs0qvsK5hTQu00HwghFf6cOWnOAb9welQEH0Hbv/H8r
 lbKsMMeK9j21kIIIlhqHFw4bokxRZhLzpejQFqzYplBsbH2xXuk4b0IM7uoCLcyzutcR
 5+yrYlK9zqIP9btPPh/bqPjhIew2Sf8DyjbSc+Tc46aZ+8RsGD17V/CGueL2WCW5cHCl
 TM0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wcWb4ucOTnFZq7hpSBzzIrQVU4NY+hO/Exr8CFK0yU/ImZ6a+sFX5v+W1XGvz20l03YA/rsGq0nCr@nongnu.org
X-Gm-Message-State: AOJu0Yzy+ED01KFP1XE7IOcz/1dYxBOk2lfuxd8yEr1UvKH0eBs7SgjP
 PCql0Wlkv6DmpaKZVLBo89I66+jHC3cw0zue8RCVznvJRZB69xLVTdDn
X-Gm-Gg: AeBDievd67u79bvtu/rTznGZcdmoyEZVrGES1xEX12fyncAelCuMdZ4gB5uYenRI2IG
 LbLMk4ggvbCHJfNCVlVSBSoSk/LctOwbwmcHGQEMkcF6Yo7Jdlt/TOw1EEj4EvWzhk1vz8h5Brv
 AT22g+BK8lX6uljG6SSbGK60SVPkmeQxtf1K9Ic5gGrkMF5zUy4vcxy4E0CYm1OXn1IlDC+XILf
 188V3w61bu7Ugfo+/QTtNF1hE52XwXFZKryjHfwjg4ZAz7j5ZumKMa9HI6pnlbVCMhheipCcrhc
 AL8xApP+nxYRb6PsHKIbi9RAVJcfGkYjW89gh8wtj2Qrquka57uTdDNCUKOhbh9BoWihMIRZk3F
 WZieRVUisZebvzk2QvnUtbPjWssHn4+KqktNsHPbQBhsojTZlxqIrvmeo5/BQy6Uuaq1sJD8/uW
 0VujcD/LRYq1ODIjHLR5jn+VofXZadT3T45OFxvJPMS0DQ+GCZWsOe
X-Received: by 2002:a17:903:450c:b0:2b2:cfdf:10f2 with SMTP id
 d9443c01a7336-2b97c4aa599mr44698325ad.20.1777438220821; 
 Tue, 28 Apr 2026 21:50:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Bruno Sa <bruno.vilaca.sa@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/51] target/riscv: preserve RV32 henvcfgh on henvcfg writes
Date: Wed, 29 Apr 2026 14:47:27 +1000
Message-ID: <20260429044752.4176397-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Bruno Sa <bruno.vilaca.sa@gmail.com>

On RV32, STCE/ADUE/PBMTE/DTE are implemented in henvcfgh. A write to
henvcfg should therefore only update the low 32 bits of env->henvcfg.

The current write_henvcfg() path overwrites env->henvcfg with the
low-half value and clears any bits previously written via henvcfgh.

Preserve the upper 32 bits on RV32 henvcfg writes and keep the existing
RV64 behaviour unchanged.

Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260409155344.2849233-2-bruno.vilaca.sa@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a75281539b..cfd076b368 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3353,7 +3353,15 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
-    env->henvcfg = val & mask;
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        /*
+         * RV32 stores STCE/ADUE/PBMTE/DTE in henvcfgh, so a low-half henvcfg
+         * write must not clobber the upper 32 bits.
+         */
+        env->henvcfg = (env->henvcfg & ~0xFFFFFFFFULL) | (val & mask);
+    } else {
+        env->henvcfg = val & mask;
+    }
     if ((env->henvcfg & HENVCFG_DTE) == 0) {
         env->vsstatus &= ~MSTATUS_SDT;
     }
-- 
2.53.0


