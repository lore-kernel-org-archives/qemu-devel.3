Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74191C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 10:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCzk-000820-Pd; Sat, 03 Feb 2024 05:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzj-0007zv-EC
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:31 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzh-0006yU-W0
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:31 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-599fc25071bso1878308eaf.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706955088; x=1707559888;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AfpgwK35DgC+XhFjHewGG0QRhQm/ga7K83AuLImIbl4=;
 b=3Vre2czYRY1++SUMSxd0eNCBiGSeCDUvv2Qda0G77Blp0S0okRXtmzoi2njPzIo/lB
 1fLCuOqEGZkaxneu11h5m8hU8LR5KE0ha7Aqd2HhWpyDignJMWKce9s0On1051DFkJcI
 F/qf7Wl8c8gw/hOEFEvWje89L6AMx86mclchE9hH1/yEUnMY6CMbRGxUN/MIY0ZwlCSu
 circm+NIjtWRGthplJ4I6nMISM3wGQ1N0urc/E9TupemQMm9KF/GJ1NZyFR5P78VFQ79
 FTf8If6aWPfqH9cNhxyJV6GUgQ5DITunKy75Yd47d1xFJe9bV8oWQGmxf3Osl8GXW5UI
 powQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706955088; x=1707559888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfpgwK35DgC+XhFjHewGG0QRhQm/ga7K83AuLImIbl4=;
 b=nKIEVrE8N+2CgNQr5SBmMq3MrED657M8ASwlBEGcCWeeQwAT/CUl5Ym1VWoQGUT1bG
 KBeuflOTP6YZiWgMD3E7FwP/p4O/Hh5F1X4mhGpKe8Of7qHmwbIpaLqcfvRCXWm1aEtM
 TDL95uMnuD49353/TudhpzlYvDLxmVagDc9NEwIQxHgpzJ/rY4SiGcLbjIqeWvi3wCfE
 it5UWtJAeHOvPC6IWCYQHMKemPI+l706EWkD45AN0seU3WRakzA+Axwvv0FMUNXISpVY
 Yiklmse94Qg6V8qgQLDUp4Dng2cS68dFeziT7EFNGd4EA49LsyNFbqB8fNNkDUK16Vru
 m06Q==
X-Gm-Message-State: AOJu0YyQ6V5gwW1Uyty2joVSqOy9DKhIhcTfxNYjbymU3DX5QfCvMrg4
 XwXNFVb1SrCziWSdguN7gYy8vGYz/t6EyvO2KWrqSgHS+irmyqM1zvds/zPsvS0=
X-Google-Smtp-Source: AGHT+IFSTvqXPr/jKwo//v3vsQUSW8Kuw8m5sbdeFcujt80LLCQQKY93nOFqz+JEaMNp6H2LUnm1fw==
X-Received: by 2002:a05:6358:5905:b0:176:c47b:7ef5 with SMTP id
 g5-20020a056358590500b00176c47b7ef5mr12982725rwf.4.1706955088708; 
 Sat, 03 Feb 2024 02:11:28 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUhQsx5HwPyyzYbLf43+RduaXcHaEb+Ud7+X7CDugvD+ZEkgyUBe/ZLhmWjuAT1s84KKPNyBSC4dcZBrQxhDGSxggnKL8e0BVxOcO6QU3Vdftml/VeFeMVJdqU8KSiQBHBrsUuSFTrrre75zxT+Ep/XnhB7ztpBj47I+tlKRxi4UR66tzq9znWQChquhcesCr5qNKyBUEnT/wSFKSglyxiBtkHAHuLurIVu6ZkdPEn9A459vwYOrB1tiyk8fK18pGvCIN+7D76xEU7cUj/4fWHFEsuCEpjr6dfdehCxMcUXsYYJ/ycepzfzZDOXvt/mHEHA5muPHSFcHptJXA01rRDVcDxVMP5tOd27jFU3QEGiId8nh3RWmoQImuV/39tMIfZVPkZ/jB19KilCrxirA6wUcgMjT2myUkJTxVBB/0akc66l3HpkSKvaEa5/Q0kgLiP1TKdpIugv7/WwTY2q
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 y13-20020aa7854d000000b006dddd283526sm3052673pfn.53.2024.02.03.02.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 02:11:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 19:11:10 +0900
Subject: [PATCH v11 3/3] target/riscv: Validate misa_mxl_max only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-riscv-v11-3-a23f4848a628@daynix.com>
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
In-Reply-To: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

misa_mxl_max is now a class member and initialized only once for each
class. This also moves the initialization of gdb_core_xml_file which
will be referenced before realization in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 21 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 23 -----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c9d09d175510..12a69efe89c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1344,6 +1344,26 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
+static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
+{
+    CPUClass *cc = CPU_CLASS(mcc);
+
+    /* Validate that MISA_MXL is set properly. */
+    switch (mcc->misa_mxl_max) {
+#ifdef TARGET_RISCV64
+    case MXL_RV64:
+    case MXL_RV128:
+        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+        break;
+#endif
+    case MXL_RV32:
+        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int riscv_validate_misa_info_idx(uint32_t bit)
 {
     int idx;
@@ -2303,6 +2323,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
     mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 067f1493fea7..e5a60c2e8b60 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,27 +268,6 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-    CPUClass *cc = CPU_CLASS(mcc);
-
-    /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
-#ifdef TARGET_RISCV64
-    case MXL_RV64:
-    case MXL_RV128:
-        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
-        break;
-#endif
-    case MXL_RV32:
-        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
@@ -911,8 +890,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu);
-
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;

-- 
2.43.0


