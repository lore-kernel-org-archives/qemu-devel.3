Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613B2C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDV5-0000oi-0G; Thu, 06 Jun 2024 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDV2-0000nr-Po
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:52 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDV1-0008Tt-Ao
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:52 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70255d5ddc7so847398b3a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681790; x=1718286590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6wLMki1LmAn7oxGxrUEW0kbk4sc1N/F5qCG2xNjuRg=;
 b=JakJ3R2fn4Jsp4VfCVEX21ltqrYpOpc2XLWMwyu0x9uNCdEub6EUK3SVb0qt0013MW
 CH384ABka7Yta9Ode4Plvt8fjh3UHHTJt9WlEMYf93J/zu5982p21UclMUyBfexnxn/U
 R+OjFw4yPf2u77Y/MMWzNLa8RWr/946JdTWhSyfkqC7pRL8v5AJGSwSHe+GvXPv21xfG
 u1urc0Q2noEglVuXYI14cx8+l0kBTGJTOfqMVIs6COMpYlXfdCiTg/9ff9rOLjBwU5g+
 5n4xsgnPwodpZv8wRKyQrzDBZZTMOmtTjZ3Hwz7gvtM7kUdjc8nZhEsk4clwhA77OkuV
 qb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681790; x=1718286590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6wLMki1LmAn7oxGxrUEW0kbk4sc1N/F5qCG2xNjuRg=;
 b=F+fM6dduuMkJvrxZ3+k9pXUsSpEKlPZ673Afk6uwp0nJTqh1sJKOnWx1ISFNRhMJND
 GCAgM7ZO5olyvDTsRdWEVhOXLnIZ13CzTvD0UZiNshd9x2PLm/HTkhFqy3YmtZEvomhs
 iXvU9j1GBkF04zvnocE/BubYgM9suMkCB6g66w4RZW/Kun8mxio1w2fz7DcPNMMijm+3
 7yEYv3A0nvdVSYzq41EXpROtyh5QnsGGVEp3fc+Q1g79z+bmBYUjBV5ruyoyx9wY/G4A
 nCXZk3Z1I4n4tO00tGSd9LFmXDrBzkLmB1m1c72CEfSP7W4vanq55NXITLhfq4sglcYW
 AzVg==
X-Gm-Message-State: AOJu0YxzT3Lto+S1uAgzHZDYpj6BfUapo9zohV/hDOJ8cpb0GYAWR2fT
 gGzwno+U/OgzA+ww08XxGM4jjJZ8nkoF0kWyObVJJc4jeSotqiL1nUHX12IK1t/bL0pJ0iIGHGa
 lcIuj+Wxa/j5smOLXgfRwIbOvicMmnyPZZgME+2J39Cj8ulQJulOfiGKJ0sBc/BaPsp0mpcHcgG
 qzqSjetvTdI6XWYv0Ekydbx8+mVz0Z0wMwQGI=
X-Google-Smtp-Source: AGHT+IHjmp64ORkua8NR/qN+Wy4JpmNP++CIZLQSFFwXZWRAAbrZ5Riz2KkLH3iHtXMMUSbZdepEVw==
X-Received: by 2002:a05:6a20:3955:b0:1af:8a3a:35d7 with SMTP id
 adf61e73a8af0-1b2b712dfabmr6446686637.39.1717681789270; 
 Thu, 06 Jun 2024 06:49:49 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1150919b3a.175.2024.06.06.06.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:49:48 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 3/6] target/riscv: Add 'P1P13' bit in SMSTATEEN0
Date: Thu,  6 Jun 2024 21:54:51 +0800
Message-Id: <20240606135454.119186-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606135454.119186-1-fea.wang@sifive.com>
References: <20240606135454.119186-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x433.google.com
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

Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
mstateen0 that controls access to the hedeleg.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a470fda9be..c895aa0334 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -315,6 +315,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
 #define SMSTATEEN0_AIA      (1ULL << 59)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ee33019b03..a19e1afa1f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2252,6 +2252,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2287,6 +2291,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
-- 
2.34.1


