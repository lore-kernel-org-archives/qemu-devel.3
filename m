Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6638FC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOgQ-0002n8-Eu; Fri, 09 Feb 2024 06:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOca-00063C-Sn
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:45 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcX-0000nq-OG
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:39 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2046b2cd2d3so550932fac.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476436; x=1708081236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r24z5buSugH8UbNLWH1nCYiUAcpokg6oyoAXp3aIMbM=;
 b=GCSu3H1LGrr2l04RDsy/LY0fyipkFud3gwfdGp8Sui3BcTgVPKhzyIoDgE3nuRAVRY
 bSlwrD2sxd5n+1PJxi3X2uDpnTyzL8AWhhfSCwG8Gtb+RKYPVubPRVw8EjkF22vGAO06
 ukvzGdHw9NzWc9FIUPCbs7u8PDDVn40VGeoH+TeBp9ZFmk7SdAOdWJP6t1TuhX/mk4+x
 r8nvn/6z0LhywqJ0tSXIfMCVyZ8/gr0GvXNtkOBDuqiu1Rz5N6YaOx6xLdL4yNJe7nMB
 1rtm/VnDnpWhUIvPukRnnUvUYMtn6QBmzQ5YNmGEUX8V9oPfiRacFSuhLzqnEKdLU8e/
 PJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476436; x=1708081236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r24z5buSugH8UbNLWH1nCYiUAcpokg6oyoAXp3aIMbM=;
 b=xQHY8CHozbAg0+u8LoxcHgPxyvViYw8CdNcMq+tZoPrXeu7S0/DQBgOHx7bPex7o2+
 V/yMtfnjXrrpzHxxKULzql/hvjnmlwO9CHSkYAhtFfID1QsnSBfnXXeZ0quAmw2rS6PU
 g3OVJyBY4msgvVICoxKOmmZpxKYD7K1lpzz0PwMsG7CRHA/LQXnmUyxPtaUlTyuvn8H3
 znipVw+WUBL4e9aL4GHKp8s4kScTZx2uQvhNsBHPaNRtTdxLTWmIGXK2O6OjrK9ev1rM
 4Vw5JhzKkDvZKGWo+xaQ7KPrehAvHLchSX+BtOfN/E5OgBJ3/YMPrWGS6rJohnmIXlOq
 XfZA==
X-Gm-Message-State: AOJu0YyG9DpZ72YOlMY4ic/WKZckuhOW5fz1NCHChR0R6ITubQwfjHZY
 tuS1PLZUiylWkRfu9vfjjAH5akobNReqxsTEMp2m5eAHqKF4OXY9RA1I2r64stpyfg==
X-Google-Smtp-Source: AGHT+IFKbi87bI6n5FzZ/6Np8odCIfPLkZpunTrS/+p3oafGLAU0oo0v8vHBfmt5mrb5W/3RVbfrSg==
X-Received: by 2002:a05:6871:688:b0:219:a97a:c9ad with SMTP id
 l8-20020a056871068800b00219a97ac9admr1488945oao.36.1707476436133; 
 Fri, 09 Feb 2024 03:00:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUhfL9HtAnMbrDd8+ZpBn3FLybvd54K64BsFY2kntwR4YFshG+VTI8sckJ3ugEHmdkHrYV8WVxX/nl/AXXXeRLuqryA+fULgmg6bcNxO7qACsjkw/T4RTEhx7e2yRvFe+EqOg==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/61] target/riscv: Validate misa_mxl_max only once
Date: Fri,  9 Feb 2024 20:57:52 +1000
Message-ID: <20240209105813.3590056-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

misa_mxl_max is now a class member and initialized only once for each
class. This also moves the initialization of gdb_core_xml_file which
will be referenced before realization in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240203-riscv-v11-3-a23f4848a628@daynix.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 21 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 23 -----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0e6762badd..be3ec5a25d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1349,6 +1349,26 @@ static const MISAExtInfo misa_ext_info_arr[] = {
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
@@ -2309,6 +2329,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
     mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d7639d8670..dd5228c288 100644
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


