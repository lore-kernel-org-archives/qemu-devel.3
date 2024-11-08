Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5EDD5E147
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KhE-0004h5-Uu; Fri, 08 Nov 2024 03:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhC-0004ga-AM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9KhA-0000y9-OY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cb47387ceso20242065ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731055818; x=1731660618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3zF2/6gcrH4Igw1oUoyFWon05IdXK20fHomVyO9faA=;
 b=ZHEx+79bW6qeRv2UK2Zr2AktPgFbqPrYjcTPf6WL63BxmcCG4+z3ntgPbJVlZpmIfp
 R/7jp6LwZEvnFs1gXAMuSICRqNBedSx8XQhkIlRZbsb+dz/BS5CEmJiOEKnBtStU/QqZ
 b9h1Cuo3wo+7aV+8lB8xHVRRM3k2bPAGwdT3+YlFr0UHeHctF2iXWAlBs6DQVPtT2vBE
 29SDeivZrIBCvGUvEknp3ELenT5TwyQqcYDS/unZwfoOqq/Zq25oR8FYanLYlDOiYb3P
 TPO2Y91c7GbxWPLfUB84S5iBm6MrW2lzf0FGst1gikX99JIaaz29ULWwxK1O3b3XMmXJ
 bHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731055818; x=1731660618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3zF2/6gcrH4Igw1oUoyFWon05IdXK20fHomVyO9faA=;
 b=NDK3fB7qvTTs32xdni0uV7o74hRmRqTM9MEvv0VcWGySU+pH4MLWB6enkt5BIgXt8K
 bz44n+bVp+fbaavQLo/MfdaKy8sHcnKaXfaTUzsBdHMtJqPPn94y17eiZAYJE+j1KPtx
 wRw9qJKc3PV+nsm2vhLIdrlqDnoOEeHEmj28mzcFxccrWsL52943aKQ9IKMrcNHMJIyH
 C8D6NdUL2Q0GJBmCuqgLuWZVZMCwzm1iEe+pyDiA4i5NvaWWxBb4J/NK8UNz+Ba4txvb
 3tUv5GrvppAzAkkgLXXmTjQge642XjAwbOeiNrMeDCeafhhaxgBjJHaOE4vbY5QMNKuZ
 l+Dg==
X-Gm-Message-State: AOJu0YzwBW4ue6PDcNSCDXf0GovjFUA5LGXIO2Sw0kwV4LY8rtRZFvXr
 j89NvJlFrPhaiai6V7+2FfnhX4QARg6/YOPeyfu+Y6QSRhYL2iCHnFEidT71sbQ9bZ1WhWag0Ax
 oM//2jVi2nbRwHnJzm+0/bK55y20gnPTX9HlofDv7cj9RFVS/vflApRPomshpFIpdnwY+7iTxaV
 uHtYHe8nad3/se3r2WtMwtVSgY1xQb6RWEjM4=
X-Google-Smtp-Source: AGHT+IEtuZ8Q3o90cjh5SCjh3IUtFmlydRCaqsaMMW4Eih7b0fEDJNmHM5NfpxpBR9T09eESF9s89g==
X-Received: by 2002:a17:90b:4f43:b0:2e2:e82d:48cf with SMTP id
 98e67ed59e1d1-2e9b1724271mr3086133a91.16.1731055818318; 
 Fri, 08 Nov 2024 00:50:18 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541da0sm5540135a91.13.2024.11.08.00.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 00:50:17 -0800 (PST)
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
Subject: [PATCH v2 2/5] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Fri,  8 Nov 2024 16:52:36 +0800
Message-Id: <20241108085239.2927152-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108085239.2927152-1-fea.wang@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Svukte extension add UKTE bit, bit[8] in senvcfg CSR. The bit will be
supported when the svukte extension is enabled.

When senvcfg[UKTE] bit is set, the memory access from U-mode should do
the svukte check only except HLV/HLVX/HSV H-mode instructions which
depend on hstatus[HUKTE].

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
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


