Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A3FC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79ZK-0003SO-47; Wed, 15 May 2024 04:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79ZI-0003GG-5v
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79ZF-0006YK-Vb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:55 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so50043205ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715760052; x=1716364852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldPciugSQGSMOBR5lY12EK6xTqHmCiheKzOXbbN7QuY=;
 b=R0yf//N8UrWVu38yePImrYbtPRFKk4kEDG82XTJ1ofL47cegF7mWctfCDvmjLKnQdC
 O0Oe+EKRftaerQChO/ZlSLb3NUdmF2ns6RS1pdy5HpnmnCEbrnlhwujOlRXQvzxKhoPR
 Le2PITcvo0VuvOQ3Oe4Cl567hNTLgq1RW03h3oJG7dsHS/ZzRJiwt+MPEo8pqwNiy/0q
 u5fMIBCVAH5wLEIl9si1dEb9U/cPjnz/ADkS9c23v8kOd27CLTKev45Mkf0+hVoDsYSV
 HpovPF2+Bl+7ev2eve2/H0uZ74So+p5fyd37HywSTJa+/gmTW8wCUKAcHOvvZlyKveg1
 Mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715760052; x=1716364852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldPciugSQGSMOBR5lY12EK6xTqHmCiheKzOXbbN7QuY=;
 b=vtqbN6ewfyzw+S09dUQsbmWRzF4PPm286NgDGIGH2ahP+2Re2BQJPXrsyxuiFdlgVW
 HUDTvxeGDOCYle9RJAHPLdyKb/ws+N3D2t6wCEvA46n43G2U6G2zR3PS9d12/7OXTOnx
 F+yJCYw/5vw1kyNm3+ypvziIJ6CDD0HQpy8N6EmQp2k3qJTfppmxph3cvKxuNk/R6g0l
 8wckW+MzcsY3rICls85qUpmfu1eaRoRg+vzp9HfW6FopEyRDdE82U0/MT1FCPNhWj6j9
 AA5KYPFHp8JFdlBghGgxo5nLDyNlz8fPxyZapsXv7FjCv4ZVtuiMsAQ0Ru/MJMEyqoZQ
 549A==
X-Gm-Message-State: AOJu0YzGqjDNYIJ8t0oqxjtixB586CD0TvNgxxLdB9Gg/QYVwVfeNUsQ
 t0LJ1Tkr4x2I5dpXFXAHV+vBSBR1mHj4znzDY6b+UqWvv1mmGBbddRJSeeZATJzqDJ11IcnPRZY
 pBSkYItnoLSd9/p8Itg506ffEbjOvznVzix27yKlAQHHJ30P8bJJFzTAVKGW4+SV4l5mCZ8LhUn
 Z+8kgPyKMaj5M2quraN49i1/yvAxjMnbhruek=
X-Google-Smtp-Source: AGHT+IEOETcKfrrU1uEm0beUNbuBaQbb8htmFHEguldiAwieAU/FQ7BtokJxkdENNtndQ7ZDKFs0Kw==
X-Received: by 2002:a17:902:e943:b0:1ea:fb65:a0c9 with SMTP id
 d9443c01a7336-1ef43d170d2mr166415395ad.20.1715760052127; 
 Wed, 15 May 2024 01:00:52 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d1642sm111418795ad.31.2024.05.15.01.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 01:00:51 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RESEND PATCH v2 4/5] target/riscv: Add MEDELEGH,
 HEDELEGH csrs for RV32
Date: Wed, 15 May 2024 16:06:01 +0800
Message-Id: <20240515080605.2675399-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515080605.2675399-1-fea.wang@sifive.com>
References: <20240515080605.2675399-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62c.google.com
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

Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
and HEDELEGH for exception codes 32-47 for reserving and exception codes
48-63 for custom use. Add the CSR number though the implementation is
just reading zero and writing ignore. Besides, for accessing HEDELEGH, it
should be controlled by mstateen0 'P1P13' bit.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 28bd3fb0b4..f888025c59 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -156,6 +156,8 @@
 
 /* 32-bit only */
 #define CSR_MSTATUSH        0x310
+#define CSR_MEDELEGH        0x312
+#define CSR_HEDELEGH        0x612
 
 /* Machine Trap Handling */
 #define CSR_MSCRATCH        0x340
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index bdbc8de0e2..c5ff40eed8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3225,6 +3225,33 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
+                                   target_ulong *val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now read zero */
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
+                                    target_ulong val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now write ignore */
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
@@ -4672,6 +4699,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
+    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
+    [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
 
     /* Machine Trap Handling */
     [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,
-- 
2.34.1


