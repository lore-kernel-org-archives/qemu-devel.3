Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004E7E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFs-0007Gl-OV; Wed, 30 Oct 2024 23:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFq-0007GM-UO
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFp-0003tn-D4
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e6cec7227so392290b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346828; x=1730951628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gb/JqbpikR1+WgRi3jNu9TsaWD1IY/ZLQT0qI8W7o0=;
 b=L2ZgpL3woHwW8dlMeAPrMReld+H42xLJuj6cC1CkOf3h0iWtcomy61T8B/+SXQmskI
 OenjoVPX7dWXtRfBI1I031eDGcM+r7peRZOr5C4NFMo6pPSqKwTLs3xny6fd4/B7Ul0M
 qa1e7K+qt3y6CH5DiwDpTZkFjP6PDyLTuDD3c+aaXHo6RDHEHvk73+QjR8tw5GFp2qm2
 0jLcHeRwED9ujHiY6JwRbSOncuPpKTOmaEHvwagKzWgkJpElf6Rq+maKxBg9ayMq8xg3
 cZdSVZXhxdpKG7FcD8S5nBLAxjO5dU/EvrqztdGGJKIlCbqVjt2X+Jkj8c6ZHHCgGO52
 ykIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346828; x=1730951628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gb/JqbpikR1+WgRi3jNu9TsaWD1IY/ZLQT0qI8W7o0=;
 b=PQHI9LJUZL+qxhhGeE25iK1bhllKVYVZ+F7Rjk/ObEfzJG3EQSs9f8WdtkuBMh+1hY
 PkmuNOuTG29ooX6Bk1a0XG9yYaASU/av9RIVQ7ukSgDKihTvcFzGw7ZG02wLC6b7pkbO
 3v41b4QUrOcFFzZlw72Ek5uWIzluXcaxu2VSCzeNOF8hJt+gs0nCovYtBmLz9wiqXUdl
 1RlR2PXE8nhpMYDwPQzgjq5zXfNFiK+nUc0OdQItwVi2gsaYHd67IbIllBql2G4NNpGT
 yR3xT70wvmlltCGhBPM97qiNPCPJWk1f0vBwex8iDQMDCFDYNXUosyM3KuDWwcgaqeBw
 fyng==
X-Gm-Message-State: AOJu0YyvlPD49FQQl8SjQPfSOmvfgCR8A6HBgT1QD33Tb+2OQTnsbTOY
 TzSZdJpv/up4ERQ7puBNpvAfZN2gs3EbkExX+ovsgsV3WJcAGWDa47qIwSFd
X-Google-Smtp-Source: AGHT+IEDwffmxmbV+5n0eNTfrTUcP454s4c8X5VXUjVCsTXy2DrDEPxvu8nvDddYuIPiXgI4oQRv+Q==
X-Received: by 2002:a05:6a21:3a82:b0:1d9:8275:cd70 with SMTP id
 adf61e73a8af0-1d9a84d0918mr21152521637.40.1730346827845; 
 Wed, 30 Oct 2024 20:53:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/50] target/riscv: Enable RV32 CPU support in RV64 QEMU
Date: Thu, 31 Oct 2024 13:52:35 +1000
Message-ID: <20241031035319.731906-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Add gdb XML files and adjust CPU initialization to allow running RV32 CPUs
in RV64 QEMU.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240919055048.562-7-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/riscv64-softmmu.mak |  2 +-
 target/riscv/cpu.c                  | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 917980e63e..6c5de72e03 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 658bdb4ae1..44288013cc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -615,7 +615,10 @@ static void rv64e_bare_cpu_init(Object *obj)
     riscv_cpu_set_misa_ext(env, RVE);
 }
 
-#else /* !TARGET_RISCV64 */
+#endif /* !TARGET_RISCV64 */
+
+#if defined(TARGET_RISCV32) || \
+    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
 
 static void rv32_base_cpu_init(Object *obj)
 {
@@ -2941,6 +2944,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
+#elif defined(TARGET_RISCV64)
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+#endif
+
+#if defined(TARGET_RISCV32) || \
+    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
@@ -2948,8 +2957,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
-#elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+#endif
+
+#if defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
-- 
2.47.0


