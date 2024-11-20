Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EFDD6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfQI-0002RO-Gp; Wed, 20 Nov 2024 02:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQG-0002Q7-Nc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:48 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQF-0006Q0-7e
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:48 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21210eaa803so34117545ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088802; x=1732693602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1n5F45dnj2huToG/m+cqtyxGgXbbcrTnolugdKwwrfo=;
 b=AO6V9i9RbnswE42OcdcqNbHxiVuTxCGZmTIq+6ojXptEnoR5i3jB7+Pt2zvT8u24pA
 DpqE1Q0xHpbo1AGxo1K+NuaJGLhdYAMZ+3sXTiLM05Svcqrpt8muWZUnKE/52uddjBdB
 iFw+2cWIKdtG9vLXjLOM2MS8zvwmaEZt0sPwOI+y+AgoEABaFjfZyYWQD0F43KgAkYXl
 MLBPS3A0SGKYA1nYJE28JTBzL1wBqldAzaRtHnMtMRSGbilfI631b1X3y5o3g95h1CtC
 7gSE65g7+31dy8WVD87MKCcjf9jzbyXrp/uTjcOF1Pp6PiuUXxJeO5x8K8KWgkOgZ6vs
 DrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088802; x=1732693602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1n5F45dnj2huToG/m+cqtyxGgXbbcrTnolugdKwwrfo=;
 b=Wcq30tqvLbD9gBH0wLpRxufGWt+9l3duTI74XGpSGy6rDK8ANAsi/pjXw5HSb2B+oA
 OBYnABsWHcxd1q+Jr0so5UpKkXEoZx9XepdJ5OnrKLSc/nRwQHgHcSR/PnEwPEdQRbD6
 eznuAcsu2GdTIFR4ZfYjyNYfSjIfeCjSIeqRCo0aXcOcW6RCwA3ucw4pXKLK9pJdQ/4s
 IREpjeyBlLETOCkXx9colf3Egh0FKMSa+VKuf43rMxF+3/ZomSLo7WOp5V5s2SjCU2og
 RVIC+yYza2D0T9C3CiZqzlECKBqKXjvBv7Nq+uzvNdSQSFqyA9z8bTheH2jzz3NxBCli
 uppQ==
X-Gm-Message-State: AOJu0YxXlhGvN/9+FK57M+tj8ebxiDNb5F6V09KNBbXTE5uHTj/VjYHB
 qKDrnoMl1jhdQa4jN0RIKuxIgjSNQhJ1xURPcGyNU0Nj7rgqNtnpM7gPbYNXKA6/xPKVkxSj0QL
 MPUPWe6f5psEXnt5egqstC39oJ5+1hRfxxCtJkSXMJPXOwdQM0qIBw36scVa2l8IeEXpprYk2u4
 2JqHWJ0hblMRn2n9Fe7QdvBHmZMFpZ6Eic2Ek=
X-Google-Smtp-Source: AGHT+IF2hBtdNi2m2sZNIY3d4txVg4S42FuD+JBouPgnunijA8ENaf1HWjN94gQ6qWq76kRqhBmrSQ==
X-Received: by 2002:a17:902:e550:b0:20c:9ec9:9a77 with SMTP id
 d9443c01a7336-2126a4750abmr19304045ad.37.1732088802112; 
 Tue, 19 Nov 2024 23:46:42 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51fe0sm86206255ad.233.2024.11.19.23.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:46:41 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v4 2/6] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Wed, 20 Nov 2024 15:48:50 +0800
Message-Id: <20241120074854.1767780-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120074854.1767780-1-fea.wang@sifive.com>
References: <20241120074854.1767780-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62f.google.com
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

Svukte extension add UKTE bit, bit[8] in senvcfg CSR. The bit will be
supported when the svukte extension is enabled.

When senvcfg[UKTE] bit is set, the memory access from U-mode should do
the svukte check only except HLV/HLVX/HSV H-mode instructions which
depend on hstatus[HUKTE].

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 385a2c67c2..4b9f899217 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -785,6 +785,7 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_UKTE                       BIT(8)
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9846770820..1936a6f32a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2453,6 +2453,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_SSE;
     }
 
+    if (env_archcpu(env)->cfg.ext_svukte) {
+        mask |= SENVCFG_UKTE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
-- 
2.34.1


