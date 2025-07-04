Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA39C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOE-0007NM-6N; Fri, 04 Jul 2025 07:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMw-0004dR-TG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMs-0004KY-Su
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:12 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-237e6963f63so6009795ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627649; x=1752232449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FDGTLzU29AMUyiC6maYWsyWx2QHHgsFZ6hlg6REl7I=;
 b=Ax8hl7VtEMFZw6DOS0n1bpL/nHamvOX2H2eBIbGLJqmxp1oJV7Yy+JJ4v/NkpThRHf
 2CXgr0l5/qwnSOA4iwuIojgTvijiWT4VUGU2/qLc9e0Jqg4PexLboaBA6vQbHOE+geR8
 Kz8H0fsVawbULNMQ2Pcc2WgCoSbcDb/U5snW0t+ffq9EsUDTWU9V8A7Kk43YKsXsL3KV
 8oZTbBnIjK//tL6V/YDzfaAZsn1Xm0s1/NpJdd1kjBUl/AdgDUhCCrTCvbnRoZRTRbzo
 QHX1WxsM2hF0wHGxZ6r6mvs+4dSDZbyn9ZU9MAJvJZzVdhQpF0RtUUYXif2oSi79u3sg
 uCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627649; x=1752232449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FDGTLzU29AMUyiC6maYWsyWx2QHHgsFZ6hlg6REl7I=;
 b=Ko8kf+pweMMCazQa24pFxvR7DO9nQCSUyju3McxdwOyu7KIuF5nHbX9XEoQ2F/Rpka
 Elh8zHKMOJGAGjLHBOPJVFEGpnKSOmf3Z/o+dbQ8B2v+WDN/CvFAW46F3JJs5PcMrGpi
 +esXLQaS4bfXtKWqTJMLcOVpXzV1B72+Yu8KROJzIGV+LjxeADVeZoHa8ihMnZ1s5MpG
 yMHQg3yWgbM9xO0pNMZddyMQPexpoEpRZ/N2bAsWOdTc4C140SWsD+u9vzSE/619DgmS
 3Hh9nFCVYGlzoxgy9jW24NZKBLMj6ECBCuIkPFQ4hElIp0q9m2U16Ci6q/7PKgjoKzX3
 6kxg==
X-Gm-Message-State: AOJu0YxelhxJ/kKzNss4fJxQnvqlF4n5HXnXjxDGmTY2En4vv0tc1aAc
 xmf1yBwCNwbSFV2BI58k8RTCfzzyLqMSgmIBeWADVyeoCchNBWbI8MX9mO8ICA==
X-Gm-Gg: ASbGnctK8WP3IsdQEwBiLhIoeJLUh+KI7uKvuF8LJnS5lpPYNoN8DjOdmKtZ2J5PGog
 Ibd3RdjboR5b32bmZYa5y0WeAnIwjfCvNhMt1AAKX9MqCSrNoA9nvYLcfFE3sMsDpjBI9VH3g9M
 SmheRYVqpbXqjGpZRebMCkjuJ0LFPJw+pfs2NaKJ/i5/HVs+Hc2kA4Pygp3C6UwIQbL9YgB05oa
 rDx1bmTajkjuu9gsHcboJuPzQgcapOIvLIJDPIBgQDXUJBiLEUz9UAOhl2P7lW7q7mgB54sYRGH
 3nJz/XR/rLWh+YT5+ewdmycOLlDB9loV1ozqlAgRDB3siW12oer02FJ5Fc9PJp+6CMh4Ad0zhz8
 +Wg1v0GXOZfK2vB26n68SBkCBO45KT4toYUeWKLEciW6kan7L6g7SveZ6PDflX6s+ODc=
X-Google-Smtp-Source: AGHT+IGn5B8RRHA20CnIdt22valKPd5RCshwdujQa7vPEHBxY64GCzoW9OguwpoF8hZ8ennsDboYZA==
X-Received: by 2002:a17:902:d2c5:b0:234:8c64:7885 with SMTP id
 d9443c01a7336-23c875dd89dmr28124745ad.53.1751627649192; 
 Fri, 04 Jul 2025 04:14:09 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Huang Borong <3543977024@qq.com>,
 Yu Hu <huyu@bosc.ac.cn>, Ran Wang <wangran@bosc.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/40] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
Date: Fri,  4 Jul 2025 21:12:00 +1000
Message-ID: <20250704111207.591994-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Huang Borong <3543977024@qq.com>

Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
high-performance RISC-V processor. More details can be found at:
https://github.com/OpenXiangShan/XiangShan

Note: The ISA extensions supported by the Xiangshan Kunminghu CPU are
categorized based on four RISC-V specifications: Volume I: Unprivileged
Architecture, Volume II: Privileged Architecture, AIA, and RVA23. The
extensions within each category are organized according to the chapter
order in the specifications.

Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
Signed-off-by: Borong Huang <3543977024@qq.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250425122212.364-1-wangran@bosc.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..75f4e43408 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
+#define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 758f254c15..e3f8ecef68 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3206,6 +3206,64 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVB | RVS | RVU | RVH | RVV,
+        .priv_spec = PRIV_VERSION_1_13_0,
+    /*
+     * The RISC-V Instruction Set Manual: Volume I
+     * Unprivileged Architecture
+     */
+    .cfg.ext_zicntr = true,
+    .cfg.ext_zihpm = true,
+    .cfg.ext_zihintntl = true,
+    .cfg.ext_zihintpause = true,
+    .cfg.ext_zimop = true,
+    .cfg.ext_zcmop = true,
+    .cfg.ext_zicond = true,
+    .cfg.ext_zawrs = true,
+    .cfg.ext_zacas = true,
+    .cfg.ext_zfh = true,
+    .cfg.ext_zfa = true,
+    .cfg.ext_zcb = true,
+    .cfg.ext_zbc = true,
+    .cfg.ext_zvfh = true,
+    .cfg.ext_zkn = true,
+    .cfg.ext_zks = true,
+    .cfg.ext_zkt = true,
+    .cfg.ext_zvbb = true,
+    .cfg.ext_zvkt = true,
+    /*
+     * The RISC-V Instruction Set Manual: Volume II
+     * Privileged Architecture
+     */
+    .cfg.ext_smstateen = true,
+    .cfg.ext_smcsrind = true,
+    .cfg.ext_sscsrind = true,
+    .cfg.ext_svnapot = true,
+    .cfg.ext_svpbmt = true,
+    .cfg.ext_svinval = true,
+    .cfg.ext_sstc = true,
+    .cfg.ext_sscofpmf = true,
+    .cfg.ext_ssdbltrp = true,
+    .cfg.ext_ssnpm = true,
+    .cfg.ext_smnpm = true,
+    .cfg.ext_smmpm = true,
+    .cfg.ext_sspm = true,
+    .cfg.ext_supm = true,
+    /* The RISC-V Advanced Interrupt Architecture */
+    .cfg.ext_smaia = true,
+    .cfg.ext_ssaia = true,
+    /* RVA23 Profiles */
+    .cfg.ext_zicbom = true,
+    .cfg.ext_zicbop = true,
+    .cfg.ext_zicboz = true,
+    .cfg.ext_svade = true,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.50.0


