Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35482C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXQk-0007u1-OU; Sat, 29 Mar 2025 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQi-0007sl-Bc
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQg-0004Dx-9B
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227b650504fso67154825ad.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259496; x=1743864296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDy/waYHc2WMJ63eIScaA3Qlr2ckg0rO6MTqODUDDkU=;
 b=RW4NN7UBzlMOUitdYaxFZFpE8y4bLL0P22GBsdM1rjxJIQA14tBRfjdL9AZfMk0wZY
 CYdgi7KNfdN6r4J2CMS690HIQ5oT+MJm3D2uSidPGThyQPUaWWcAksfBXi0dL2RyqpP/
 878wuukeDXOrUfwF72YPHtlPPbffl8vIBycQWJ2vJO1avFZUZT38q2RSeEsyO8mgf0bj
 2y9YsSDRu857/ZJjX04hgcl/Ld9iPEMHK5BcUy0dUeHXdzfoFwRpMOO4WyfkIBMCa1sw
 5UNabhsl64BG6K+Of4TUUHIRRxYRvkNCkVzj/3sIiQBwKQelumAxWE3WqwIrkMInUmFH
 GHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259496; x=1743864296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDy/waYHc2WMJ63eIScaA3Qlr2ckg0rO6MTqODUDDkU=;
 b=uYmYb/pRcOFN4aKyPmDkWx/Rrv8en2eVoo4yvNXiPt8EzUx87grQPILtPOZBkXl8Gv
 XGI7Cl9FRoX/Vw9xr8V9chAOFZhmmZmvl+g8QjoRkqkU/+OXA7fZjtz+O1V3iAXvCI3e
 2kwUFIrUPv66iHa/i2WKMMjp7TWDoj6W4qixmBG65Ln69O2g2kG7qW2XqeQBos8qIdVw
 ebJuLmF/BErDEGswU6IICfdzEtujHQXFPnyUUI7dO79AnmRVpJ1Vldzg48X3iGj6218U
 Nf+H/EW8GCX5cGLPW/Pg7Ebpyi/pHLPG2D2xwAe3hq80hOMik6pRNRdZsZOFzNfpS2lr
 FV8w==
X-Gm-Message-State: AOJu0YyxbsqU1HKANri3iS0G7tRycMLGGQxkJcLwdGyAynkadlMomLXK
 N13xdMtfHEdmUjHPmfVLaUpIUz9rLMr6AI6Itlsd1dk8iRLZSHtRhjQAMCR5B6e5k3koTakvmbu
 ozrdk4UflRdjFVbRk4B0o/HWFdPwEiACkF+Elb19CIMC8M5Ew+hzwpr18eK6oUx/DhlGjJ8Y3I/
 +DpjjrXPiktSiMDMl74DfGdR8nxvh7PQS2VQyO6Q==
X-Gm-Gg: ASbGncuUzFsbgJuPHW+bl3C0scI1ySQrG9UQ11RASUwt97gGgYIxm2LITMLgBem0npF
 3JW7FWR90Rz4F7ca51K6T7KXSwI0a25h0Ivb91nzAKFbLU1+Fnqlwv+K5yF6NxelNp5bCPzG0kF
 UuUTxTVRf3inkpg57Y3sKfg/1xg8MiSAn4v0Ue5W0CNyEORPy9eGOtzK0T+49xvzLltZYey6rsX
 bhCAMUZsHSqv8u5arxUbyRFuRryf+j6SNhXJc+42lTSbthxVTu2/maNditiVa+zvbV/LiC3N3JW
 cXviSmeomFSibWZHhUGpyYlPghxy8ylKvAVNn5yaMJuuesD192tQlsMjp4wK12aLr+6SUfu4or1
 cPuLGz40RdO8n9Q==
X-Google-Smtp-Source: AGHT+IH8AGx1KdBpp9voT/jagfzcUlMBvZwqK19LQi7VTLIGcf5HEdnNHddf0PkH1ynihlEPMoD/0Q==
X-Received: by 2002:a17:902:e94d:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-2292f9557a6mr46671665ad.13.1743259496439; 
 Sat, 29 Mar 2025 07:44:56 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:44:56 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 01/12] target/riscv: rvv: Source vector registers cannot
 overlap mask register
Date: Sat, 29 Mar 2025 22:44:35 +0800
Message-ID: <20250329144446.2619306-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Anton Blanchard <antonb@tenstorrent.com>

Add the relevant ISA paragraphs explaining why source (and destination)
registers cannot overlap the mask register.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 ++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d323..20b1cb127b4 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -100,10 +100,33 @@ static bool require_scale_rvfmin(DisasContext *s)
     }
 }
 
-/* Destination vector register group cannot overlap source mask register. */
-static bool require_vm(int vm, int vd)
+/*
+ * Source and destination vector register groups cannot overlap source mask
+ * register:
+ *
+ * A vector register cannot be used to provide source operands with more than
+ * one EEW for a single instruction. A mask register source is considered to
+ * have EEW=1 for this constraint. An encoding that would result in the same
+ * vector register being read with two or more different EEWs, including when
+ * the vector register appears at different positions within two or more vector
+ * register groups, is reserved.
+ * (Section 5.2)
+ *
+ * A destination vector register group can overlap a source vector
+ * register group only if one of the following holds:
+ *  1. The destination EEW equals the source EEW.
+ *  2. The destination EEW is smaller than the source EEW and the overlap
+ *     is in the lowest-numbered part of the source register group.
+ *  3. The destination EEW is greater than the source EEW, the source EMUL
+ *     is at least 1, and the overlap is in the highest-numbered part of
+ *     the destination register group.
+ * For the purpose of determining register group overlap constraints, mask
+ * elements have EEW=1.
+ * (Section 5.2)
+ */
+static bool require_vm(int vm, int v)
 {
-    return (vm != 0 || vd != 0);
+    return (vm != 0 || v != 0);
 }
 
 static bool require_nf(int vd, int nf, int lmul)
-- 
2.43.0


