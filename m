Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D461FD41D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmwi-0007ca-St; Tue, 12 Nov 2024 04:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwW-0007X2-AD
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:12 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwT-0007kF-JX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:11 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so4088682a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731402727; x=1732007527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0c34hxrwlKiDfAhthRfad0+IjKl7JigOsGotvoYbcI0=;
 b=SXvc4HLnGczTRaDZjUlvM/3BqA9e32hPKGbk+7sBJJMa1CuCKsst423QhQUEzqY/Bf
 wdFdYpvCqZI4ygs4QNYle9iITYIpR/IYDx+je+mBQW134JlSIPMBV/kYA3bfHVnG+6HW
 njvlKPK/uru5kwFSP1DUFqj1MI17KtuepNjiqr63La6LLM54e+Qjvk47zWJtTBbBg4eh
 NKZKZ4msdcJqX54ioI6HD3E6ySwwM1JYJKAfVi1+ZVaOeNz499ABLzaZQJG3K7/BvSKZ
 xk0Cm6ewnkWzT5VA/f2tq/RE91dExeM2drhbvzJ42Hml7fnAkXC5D24Hf5I1Rup4wYn+
 c4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731402727; x=1732007527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0c34hxrwlKiDfAhthRfad0+IjKl7JigOsGotvoYbcI0=;
 b=MuzqabORkuk2xCW1aOn8qBgLEqNQx8RqXOxnCBBrDGWt0cR7swvtkFcmsiPS4JnYsD
 ewAEIPnV9imsXV1UtcrOsOcPgIBgggWeD7lXJCoQwTeTKoWdtxHjKAbj3fOrxyG//lB3
 tdCAFL45jZEl1ZHEcrN5gdoqfH7v1CLU+JWwRw5Sul7iNb5fWbUXRxbpfUoWva1Sy0qp
 waJJNPY+E0UEpVMPt88Kxj/+vuY8RnAEBhCGLKrAZwC88f/aAEBRKL7uEMeYaxMiuVYG
 p1lUxGomhhkzxyZx8iPvr9W5LqIDQuR8pd6RWjE52Hfe+dKh5+TqnBa9eRIMyG/xL4KM
 8A9w==
X-Gm-Message-State: AOJu0YxsJLJdOOu0i/yWJ6tS3IPOTwU9G9OPoV9QWidTHGbfO7UYM/I9
 Q421ZVt4rGNqa1/DGaAR1bEk+tatonMCsfL2oAersDaIcS9GnIZ/iovEvBzXcIdUZHsZ0ulSN4n
 ejCveXLoViJ7FdJG1EEpq6QuUv6XROqM7YVIfCBwCNVRcBMYd8VqPFNqek0KHHNkayeufrfF+Un
 hbtHaEcRFBbR7UzR0ObabWZCVhWishmfNGYXE=
X-Google-Smtp-Source: AGHT+IEYW3KgrEsOWfQXzP2K/rvNfxQfm8dV2eTEteoVeB1kLHOPkpOz0g/jtVAcJ4+L4WGSTk+/sA==
X-Received: by 2002:a17:90b:4b91:b0:2e2:b46f:d92c with SMTP id
 98e67ed59e1d1-2e9b172023bmr19677440a91.14.1731402727448; 
 Tue, 12 Nov 2024 01:12:07 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a4f6c96sm13495347a91.2.2024.11.12.01.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 01:12:06 -0800 (PST)
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
Subject: [PATCH v3 2/5] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Tue, 12 Nov 2024 17:14:20 +0800
Message-Id: <20241112091423.2529583-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091423.2529583-1-fea.wang@sifive.com>
References: <20241112091423.2529583-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x534.google.com
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


