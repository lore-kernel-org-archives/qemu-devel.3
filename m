Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AE4E68949
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFv-0007Hn-Q5; Wed, 30 Oct 2024 23:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFu-0007HI-15
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFs-0003u6-Jl
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c7edf2872so12555165ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346831; x=1730951631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoOUpbadKCnmPOJWCrARYtALSWKgna2VartF8KROWEg=;
 b=TL///P2fDwCJIeLZO/iaid757SpChXneA4y8qWlXk7Ab9l5d3ujU+A9+ZrmP8wsJIZ
 VdAoX1+NZdWu+/3mNa9yujcVlKTTFcI7eEzGbBGX5pyh//ZX3CrkqvSloPKdbJvR7283
 0VfFiTgUQPPeQqtBI8NrYtQNFbXKGVRPDWbFCahJV2zyNe8ShxSHC1FWsM7pj547yyUP
 r96f6VsUOf7RA+OEOI1NGKVoKwQ3wdoirb4/DyYXn6JvqKpZ/pY7a0dzCdfzT0kqcXZy
 ACVBA+Y7l74E7MmLTiR12fZqfoG2GjmKsONV1mp5dC67PgC6G9oGqCaeqn6khpCARngS
 aa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346831; x=1730951631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoOUpbadKCnmPOJWCrARYtALSWKgna2VartF8KROWEg=;
 b=rKllWXjq3zflLzPsEhyRCxk29G1HMkvPi+PpPf0tJa77lMJALKZRFIJtgj+asMJeBu
 Wn8z4s83kOUkQYZEBcV2DNomuFzMm5LbY/XIW+WhLl94dlU2NE1wLFdqcoXQRu0R+l/b
 LdKPtrk5eqbw09Zc2G5jiZaowwrgiD4p5fbokXAg4chzMCMjGl//ls04+NRAaDTMa4J/
 IH02UReJYrI5zOMPWppu+BnLIbN3YmIEqeViY+Q+SIIb4cEZBWGwv5dIJBbqyONUe5np
 oJ0/SAh49STAwGLHS1Vqbbmv13bi+QgzSnStr72rEI1TQFxJ0Bk9C60KX/G9KcF1r9/3
 8Y9Q==
X-Gm-Message-State: AOJu0YzD1TvVSQbQk0zeAQ9DuKYUxzcefIrgopFYrJFAegLdRzXybWdM
 p1wjRGw4fK3AEd9nlZpdDt8OEl9JFElrE6+5s1vO43F5/qhV63HoUCHt23xb
X-Google-Smtp-Source: AGHT+IEC5EpqeuGUHnxpB/ZzkjSrLIz1ZUffszO5U59jpsUmBFpFEgbZ7jyQzifKWn6mI/oly0HJww==
X-Received: by 2002:a17:902:d483:b0:205:8b84:d5e8 with SMTP id
 d9443c01a7336-211057336d4mr15955375ad.18.1730346830976; 
 Wed, 30 Oct 2024 20:53:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/50] target/riscv: Add max32 CPU for RV64 QEMU
Date: Thu, 31 Oct 2024 13:52:36 +1000
Message-ID: <20241031035319.731906-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

We may need 32-bit max for RV64 QEMU. Thus we add these two CPUs
for RV64 QEMU.

The reason we don't expose them to RV32 QEMU is that we already have
max cpu with the same configuration. Another reason is that we want
to follow the RISC-V custom where addw instruction doesn't exist in
RV32 CPU.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240919055048.562-8-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4464c0fd7a..62115375cd 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -30,6 +30,7 @@
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
 
 #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
+#define TYPE_RISCV_CPU_MAX32            RISCV_CPU_TYPE_NAME("max32")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 44288013cc..0c8e017f71 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -449,11 +449,9 @@ static void riscv_max_cpu_init(Object *obj)
 
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
-#ifdef TARGET_RISCV32
-    set_satp_mode_max_supported(cpu, VM_1_10_SV32);
-#else
-    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
-#endif
+    set_satp_mode_max_supported(RISCV_CPU(obj),
+        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
+        VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 }
 
@@ -2959,6 +2957,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
 #endif
 
+#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
+#endif
+
 #if defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
-- 
2.47.0


