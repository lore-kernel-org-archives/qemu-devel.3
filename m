Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2330E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFj-0008B5-BM; Thu, 19 Dec 2024 20:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFf-0007mY-LG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:27 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFe-0004ae-2D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:27 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-725ecc42d43so1184239b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659784; x=1735264584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFA5ekI+kAcNMU4k/jpblMJI0Pebf31uGHT3NoHxS7k=;
 b=HNPjXsX2Z6HGkx28O124jJF5WaRUx4T4zI16hqTg3x6lkoP5FqywljE2RXixuWizno
 7uUfgSNbseB+sCLEgk2kGsZkcm5rybX+64dNchKie3A1IgO9T2KIDR1YD78fut6X+tq7
 QCVoEYMASBqmClKRyLHLvtx7nBAWFpxJEYU2qrF1D//creaYcLs6jWsgFJFBe9OJIUyC
 TIpWmu8aPbqqHRxEMVoPX7L8PWEsUl5AT5ic/X0LFgKX/l+Lz2w/LpH7JESi4osMS2hW
 rccvQ2/AhNUJ2VK9Bzt4c58A1Ai88Vrti4pgZmk1WK8me21F2Dy0+BusHTr767VJBWDW
 CIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659784; x=1735264584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFA5ekI+kAcNMU4k/jpblMJI0Pebf31uGHT3NoHxS7k=;
 b=xTM7cZ2M20i/hLdrI+cvPgoGjD/62s2/XeD1noaVcakfAuG+TQMenl4U3rmFOeVorv
 zmhgYUiy7USvuXURQX4ehF5NM9g6aEin6a3oqjJBs2q817lySOctzaRp9tyxu2HIHCj6
 +9Pgtz6NNzjP8Im8CGCvgbx7dcgp4eIGT2JMY2+IbwyYtrMWatxUQ4FiGDuj3wSJAvG1
 mRXNNpCz6cbfgfa1NTAVWyDOmVBV9v22GLhyI9yuOub2zHew3QnNkBKmjJr0vfE/gL2Q
 EZfCG6QFhKofYSTgcNKK6YW8bE7WsIoD/1eEBxTxOTtMEaA4cRrXacTYBx3OuWpLluvU
 Ft1w==
X-Gm-Message-State: AOJu0YxC2ftJvV4E5IQAqLp4wzIi3DNo899BPX8Xh44zslikMjY4JcgN
 1/BTOrd8sy6TsZADN3S6kIovw2Xpr9gQWbDUS3D1rbTH9x5SUWqASNQ/cpIA
X-Gm-Gg: ASbGncu2VsT37tj1BHfKj4thjreUzq9+T9fd8ibpXNHY1s/BLA8z8IdglNqq+Mw15fn
 ZKil87aUuX7zlE0TWyOKiyHG/ld3RHGBEgpLrfQFX8vLwX5wXxGetNl/ngYZgBGlQVcm4Q7cFIb
 JEH63ajZvwhWfuqrUxGHFdLZeCijsyleWANGpsxW6wbunjqlVAdXe9IXy0td8kVylYWTe166xeR
 dbOmTxxdCW4dasKNbBpOApoJfbUkfUFNvMMyjhQAQ5U3YlyYu/OAyptM0j8sjWR9wEhos3cjhmh
 mxnxBdf/oaDd/91rqNKk3BSbTAtB5bYlnHVbANiGv6sVQ3ruoZ0/Gm0kTOlppMg=
X-Google-Smtp-Source: AGHT+IHigLvr+VqAysW9/BxER8/Retd94p1JgOV3jZKDiErBmJFMBCb8BAg/O5AbzxyqGZ1/TV0/eQ==
X-Received: by 2002:a05:6a21:99a8:b0:1e0:d796:b079 with SMTP id
 adf61e73a8af0-1e5e0459b32mr1899809637.17.1734659784609; 
 Thu, 19 Dec 2024 17:56:24 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 30/39] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Fri, 20 Dec 2024 11:54:30 +1000
Message-ID: <20241220015441.317236-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

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
Message-ID: <20241203034932.25185-3-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.47.1


