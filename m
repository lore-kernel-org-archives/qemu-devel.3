Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC88DE6C5F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJjw-0007vP-1S; Mon, 02 Dec 2024 22:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjp-0007tm-Nz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:14 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjo-0005Yd-6K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215348d1977so40017605ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733197090; x=1733801890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1n5F45dnj2huToG/m+cqtyxGgXbbcrTnolugdKwwrfo=;
 b=XSD2keI6kr47uOikLztvd8QL4HxqBfs4yFVTlKypgaPGHZABn+Of3s2JEyShmRN/RM
 3lNPYlDQBUtm5/iE14vYAUE5b5aoXx+oBaBdZtAfZKlU2JZTeqDif65/mc5VmI37OAt5
 33SOPG5EzaPmeWZc6kXOAj4C+XgQ97bMoL9T+A9lop/o76Pj2wOy4z968Q9ILp0pNhdP
 sLUdYngB/54B/wyi6PAjLi+uFDdo/1wHSJk3SqWqWsOPGvm9gDx//DAeNWH11GOHWeW1
 Gb4NAw0VBY0MNXP8tRzA6gUK/2TktTCsh9pTAwo03+20sDjCLP5+sqpOLPP1TVmcdD+V
 NVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197090; x=1733801890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1n5F45dnj2huToG/m+cqtyxGgXbbcrTnolugdKwwrfo=;
 b=ncI6ctpjkAFxD70MIOHLFoSJsrcyiS9F3eZ17ZiJFLKX/d5CEPgxG8kgiFSXoUKMZ7
 QAnzBMqHHFM2sTrh8OwaqGAt+CQkfzdFmjQgUvc+T8jbwAry7bZcS7WjF9WYC+M0TZCi
 3ksA7i7sAQOgHvI3NvQ2TBwfKRm29Yrxn9VxGg4YBznuLArA/ke7lSGpSX9Zymk6SZ43
 ZlIil7ctzVxmWo9d/S/3oK33+CJmWjM8S6gflAEmHySkX9grzpwMmH8qJMzd0LqZ4xDn
 hhqqiQwkAQvuVjkJy0sOsaTGOJ5WsXz2SE1twK63/z1bogYHdpJLyTIqptL474pIwIQk
 HXkA==
X-Gm-Message-State: AOJu0YzjyywJ36sLn6VtqeUIerRa2I4EhShPxMsyAjuMnVpE9J47es+k
 SD2z4VS66Zp7SUUup5b80H1kdFlkPyXYc+R78DRd6nlQAnPoTppRTHCpHOspmjunstJ7fWys0MT
 stPfy+w4rumVjkVQdDYDhg2dD8H5j0u7vZ4U1ZXbdvcYe8W/+p9+UgHne+9s38OQnaY0FCq+8LL
 jIXvpPSeCj46AXm3SNCzMnKeUfjQPx70g7VYTuJA==
X-Gm-Gg: ASbGnctHMyyPcx+oe6kTyRw67Kd6XVEFP71X8SwcnpVDL1Gz5gGMlUCD8DS/JwJUpcW
 pH3woB7XsoIexZwaPz/rTNjFjXJ/r2PKzqMLgtAH5OUJQR//zhjsYgl7qsrDmf/vuJV+pyXygWJ
 NBOQJiZWz0HcUKLuIQWX7DThKXe39lEb91j7OiNlGyOtO+Gdj3mMjw8Ijm8Se1Nw+ig/wUxG/74
 QvaA1prO/WpdBB4vgQmJ4wl0V2JTyeShcOvOA8WHRNJ0AtLCqVwofBNu2DCU/8I2HYrI3EYvKG1
 1dM4QW67
X-Google-Smtp-Source: AGHT+IEHtXViFXW4sYhOxB8QhRefysfVMSjU8kZGwY4fYluWkUledg/QrxI81ffPxr0nBGTmURXSDA==
X-Received: by 2002:a17:902:d2c1:b0:215:9d58:6f35 with SMTP id
 d9443c01a7336-215bcfc536amr16677675ad.1.1733197090194; 
 Mon, 02 Dec 2024 19:38:10 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566732e1fsm47111135ad.134.2024.12.02.19.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 19:38:09 -0800 (PST)
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
Subject: [PATCH v5 2/6] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Tue,  3 Dec 2024 11:49:28 +0800
Message-Id: <20241203034932.25185-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203034932.25185-1-fea.wang@sifive.com>
References: <20241203034932.25185-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x633.google.com
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


