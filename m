Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8705EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOy2-0002ed-Gq; Tue, 23 Jul 2024 19:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxo-00024n-5f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxd-0007qu-U2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cb566d528aso3858724a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777424; x=1722382224;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QmaN8kFgJMv1sx+5f9CLn6Vn3miNSyaJkILJElq5Mo0=;
 b=CxCpIiiAGsulUAV1hvwIgnDUxszWNkXD7VA6gsVbdLBaUDYt2NgensEA/0V7HpBwi1
 0Wn+OretYNTXn2XHLDgHfzqyM6HJtXu9BiPUUO38VaQql+st9xIErH6xkKHhE7OGvRuO
 KaDu3MGf5kcHiaocULRlzEMkYgGfU2x3rBO2pZR1f23TNlqDZ9QiQgO+WrgX5qRgWtqs
 RLrcEkrGKU+H2Q6I8UI+iqvvm0eXsQ1DHi3zu5zKEZSuqc1aMfNjNsNRVwhAeq299813
 4+LRRIW2+vxXYzJ228HFs8wYZVXGgLbp1HmL1TQj4mpZgoYvV9M5DDIFT0wVpctYU3yp
 3CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777424; x=1722382224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmaN8kFgJMv1sx+5f9CLn6Vn3miNSyaJkILJElq5Mo0=;
 b=WbI3EfJ0DFgLvi7D5hBtCMLIrl3foxpyjwxxicHjq5vP7aCg1JDpbSN/q6m3leNi8x
 R/1eXaMTOwJJLUMussFFlm5Axpm4oMTyWBJ/ChopSnPFl5YVWIUEomEGB+k/6TLoWm/G
 7ml4hM9bztzJYdTsA+/k0v4OGV7ItH6zlOrvlA+uyFuF00AQMwgSONfp13unChrRIAt8
 VQgro12vIYFdEVSrtuhAlw1OZ8hL/flQUaw3oG7/rnkcAGNhrCC8uhhqtfzoegSVBTBM
 fgh+NAoWRloi+2i1dITB42tr7Rmy4bwc2T5Rzh9A5LQeYSbCw/l3b7d4h/6oD7wZ4Zye
 ck5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbKjMMc8dDS2IZD8iqSxFfnuDZIEaFAVdIz8ucnlGhzVAqs6kodTa3+d06/tlJLJeiy5W+8vbWoNIOuiNRcbcGHMlGJeI=
X-Gm-Message-State: AOJu0Yx3S7rqUuV6Hxd8WU59MApcW8MKTd+PrQ9oA5FIG/XIE02xyqL6
 27W7/oWFBtj8TfOhikMFBeubUlztGtHRHQyAUGA2jQqWCCt2DB8PwalPAj1Scng=
X-Google-Smtp-Source: AGHT+IH/izxjqUyzzk6c4iK0HboPOdJIfcGvrcdbaoBpHTc/U+VcDkr1UC3pRjTRnW+P/HsaTwNO1Q==
X-Received: by 2002:a17:90a:2c01:b0:2cd:49c6:e2d7 with SMTP id
 98e67ed59e1d1-2cdae337b80mr1318316a91.19.1721777423925; 
 Tue, 23 Jul 2024 16:30:23 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:23 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:02 -0700
Subject: [PATCH v2 05/13] target/riscv: Add counter delegation definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-5-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions for counter delegation, including the new
scountinhibit register and the mstateen.CD bit.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.h      | 1 +
 target/riscv/cpu_bits.h | 8 +++++++-
 target/riscv/machine.c  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb666..af25550a4a54 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -368,6 +368,7 @@ struct CPUArchState {
     uint32_t scounteren;
     uint32_t mcounteren;
 
+    uint32_t scountinhibit;
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2a8b53a6622e..d20468412dca 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -207,6 +207,9 @@
 #define CSR_SSTATEEN2       0x10E
 #define CSR_SSTATEEN3       0x10F
 
+/* Supervisor Counter Delegation */
+#define CSR_SCOUNTINHIBIT   0x120
+
 /* Supervisor Trap Handling */
 #define CSR_SSCRATCH        0x140
 #define CSR_SEPC            0x141
@@ -778,6 +781,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -869,7 +873,9 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
 #define ISELECT_MASK_AIA                   0x1ff
 
-/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
+#define ISELECT_CD_FIRST                   0x40
+#define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 492c2c6d9d79..1a2a68407852 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -398,6 +398,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),

-- 
2.34.1


