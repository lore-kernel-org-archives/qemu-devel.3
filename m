Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347B8CD3432
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMoC-0004vS-8q; Tue, 03 Sep 2024 02:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoA-0004pF-GO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMo8-0002Ep-Rk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:30 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2057917c493so12149395ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725344067; x=1725948867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nfh143S9vnLrU32qZoavXZ9QOvGGiPS+biYpynrjdo=;
 b=AnlEHjeUszuv4xWsGBD9MVTC7CFKTK7Zf920qgeCEUr2/qoA1J4S1a5ILzodZUnwaX
 orHHCtoHi8VK2fISUPVqrHkjHmFLyhtGQCHp57XcegoJPc/PkY66/3dXh2ZT0X3kD1RK
 zhz1IAnGlfoqfQvlGZupe2KY49z9T1PuTmiNX8NwlRfDINFFVVAReHY1vYRCyXA0HemI
 CW3DJUz7RRiyyeTQaDW1b1RVHB8YaN1fGZhy2EI5SFeS9BpmgdqYKuELsMZWAspzSeTN
 oLI5ApRZeycGhu7KxyRx/tHVUuNBXWuQH0sk+63iZTYtLuesdbK492laMx+Z5QPzQ+/P
 iHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725344067; x=1725948867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nfh143S9vnLrU32qZoavXZ9QOvGGiPS+biYpynrjdo=;
 b=fwe78bJs1QmVge1wfhXCQsoSsxw19iqcomG7gRFQYwuBHjGCH4aSfg5iqvO9ruS24V
 dTANJ9gUw2w3PHzyTkx9FqDZy547npbeFemBee+T39D/nWWWzk6CTMvY9WwyrysdbUmR
 A9z8ESvhreP1lEKExTgF7uU13jJ3NMJPGgty4vLLIPHihZFxz++jtm1zilMKad6zP039
 pX2p1exd7keG9+GgbA7ARMFnVIlN3R0Ypy3FNDJY1GRbOc3MuW0B8x7V3D48bgLdlXPG
 Ku9U2EvR2QdX2xm4B3nZfKPvIzLL4Up+3k3p6GgPoGlTFiC8q4GxL+liE5mMC6glfV/7
 aQyw==
X-Gm-Message-State: AOJu0YzOj9CHUJpyK8vNqW3KrkWev6w0ggPgeTkRnMGp/KsWXrFgzWie
 m31/iYSBwzTNzXMIFJj2qOQpQ1ejZYZuroQf/NtNPyQGkZRJIMPXUU2LAIvoNh6WUY+jepPg7Uc
 F1mBzKGyDPoYZsvck6/pJJ1rqVicXA4fzbUcq6yC59wwrURrMIuu8RMGaas4QE8EgHXtQpzX1cX
 fLx4/CSJ3qIYiTxgZElEuvHfEuEcvZhu1I1jE=
X-Google-Smtp-Source: AGHT+IFLcdnT0UzJqAGKytX7UjtV4QgMIHxdRp9ElrguCXNQprAFEEE9fEAis1x8YulhWh4sSNBhUw==
X-Received: by 2002:a17:903:228f:b0:205:6a64:3144 with SMTP id
 d9443c01a7336-2056a6432e3mr99595125ad.27.1725344066530; 
 Mon, 02 Sep 2024 23:14:26 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20524c16145sm60467145ad.98.2024.09.02.23.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:14:26 -0700 (PDT)
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
Subject: [PATCH 2/5] target/riscv: Support senvcfg[UKTE] bit when svukte
 extension is enabled
Date: Tue,  3 Sep 2024 14:17:54 +0800
Message-Id: <20240903061757.1114957-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903061757.1114957-1-fea.wang@sifive.com>
References: <20240903061757.1114957-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 7e3f629356..54c3ae0a4e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -770,6 +770,7 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_UKTE                       BIT(8)
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_CBIE                       MENVCFG_CBIE
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..6ee6d1a9cd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2396,6 +2396,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         return ret;
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


