Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2331CE7A8C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJphN-0005re-Vz; Fri, 14 Nov 2025 04:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpgj-0004MI-PX
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:01:50 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpgh-0007G9-7v
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:01:49 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7aace33b75bso1656582b3a.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763110905; x=1763715705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/fRO/sMpvxBW5liC2r3DKNfWyHa1X3NXHWrEWWToCI=;
 b=HYDqcIYG8l0bdfnt0xRKvMfkAU0xTxIY0VGB0zaXl+BkVDmMV03Q8tnYU3lEMuMk1+
 hUN5h34YUDQbWqEX5Q4qHnAKwJqkKTyZcCTLyr3NlXxsC1GIUYd32CTWdUxbm/KeMjKn
 4T1M8DOGXUSXwQPGEJaMmAoloibKLD+GeZV4ms5QOzMO8AhSuADWNVcY0kqNYqxDmpKR
 K/289tkiSNoccrjo5wXN0xl3bGvtFchCv6mQkbMlGim5qoX6DLZSo8lUaYwdazz4CkzH
 2bO+gj/yfn+/tmuGFs7QOck0mqrVDrWX7m63Ck1tFX1XbNaFd+aSyZOodvVtCCGSDv6c
 mYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763110905; x=1763715705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E/fRO/sMpvxBW5liC2r3DKNfWyHa1X3NXHWrEWWToCI=;
 b=rNcsKpo7laW3gN5W3JTELNsjvuA0aGSmSfryM+3KF5wMKztsX2wDiLS85wt8g8k1I5
 Y0LZZ/IA2DeB5msXM9oPWyuTAX3LC03GDn8s+RzjiXjOGOZtc7jul40Z363iCpYueZw5
 ITRXLm3gRia+8+RU6FMS6C+aY+cRjW/1aKrv62aHSZCJSbUOLqsvQ68FUVz1THNvrf+k
 p5KcKj5Gb/wTtS+BdWtqYF9f/x1goP2g20/u8K1to7qv03PzSB17XH+l2uBsf0KuR2Vm
 T7nC+QX9Rgar2xg9PL+cjfw/224PFRNXbZMnQxglg6gVnN2YtcrHVjgTRT6k8llTGFTl
 F84g==
X-Gm-Message-State: AOJu0Yw9B0n3GEJ586jHC0c/cEtztHk7VOK3nlUw3DyUyieYm4BK8Qmi
 rCnlUklUGN7V3lc6ecHGjX4wQFjKoAn12t4PiwTFsYSrsJ4Hvh71YbTe5ZAmnkxxQAV4sjohCBa
 RFWIbIdd8pv/Pxx5y4WrjMP4eS5JAYvDY42XpcrD2kH963ZtZzWLRQwZFXXyVPG7Adtdl6kdbGn
 fdSPtjUi13QYZhvCSkeCAgVCRXazkyf9Wm/K8utBO1bR8=
X-Gm-Gg: ASbGncvAcbkd6DkFAVNA4hX14aZnM9ZJLJQ2aQ5f2XQctSLMA6p733vyUKr6hQG7EiB
 ypG/AKNXA/5VRye0MrTyKMd85ve5pbAkgHDeNoyKHO6OVlnZEZnFtMa3ENzJPOHvSTIFys8lfbZ
 1NsE/iZgcQ4R9U+HTR/WlcBvsU7O8d66iYH4vXNJkmU9lhDed5JqvOop1Vjjo+DHiwQQbDahSay
 QDaYTT+UZo8nTNCxHukATr0nMqRhD0ZkRHTbjgbOOgwqJCPy2JCsODVnqLe5Y5DgQtOt/3p37HM
 hcDkgvYcR/zjD5jywqJ8ePI439VR7+Y+ptkx5ssfENfY9AIs+/M3L23fTj72aD7u/YkOS1pE/n2
 awO1BICJ919uyITQ35S5FcVhNIY0YUFB+6mRjbHyNAC++fM3t8D6bUX+XJ/fNhY8uxDlgP8miL7
 GxqtSJ7i5u+EbUQtHTxaKUcXNEtynmPirAPT+C0Q==
X-Google-Smtp-Source: AGHT+IFdLjF9PQ/ri41efq6F51vgsaSRsZt1RmR0JugtuZ7cHaYYsxrzQTIRF52p8Nh2Lm1hYDHbaA==
X-Received: by 2002:a05:7022:4590:b0:119:e569:f60d with SMTP id
 a92af1059eb24-11b40f9bcd8mr824634c88.6.1763110905073; 
 Fri, 14 Nov 2025 01:01:45 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088625sm8049254c88.8.2025.11.14.01.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:01:44 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/2] target/riscv: Update MISA.X for non-standard extensions
Date: Fri, 14 Nov 2025 17:01:33 +0800
Message-ID: <20251114090134.1125646-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114090134.1125646-1-frank.chang@sifive.com>
References: <20251114090134.1125646-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.X is set if there are any non-standard extensions.
We should set MISA.X when any of the vendor extensions is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8899bf7667a..2e0c92fe593 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVH RV('H')
 #define RVG RV('G')
 #define RVB RV('B')
+#define RVX RV('X')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index da09a2417cc..0d730f4d774 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1180,6 +1180,20 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
     }
 }
 
+/* MISA.X is set when any of the non-standard extensions is enabled. */
+static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
+
+    for (int i = 0; arr[i].name != NULL; i++) {
+        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
+            riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
+            break;
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1188,6 +1202,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
     riscv_cpu_update_misa_c(cpu);
+    riscv_cpu_update_misa_x(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0


