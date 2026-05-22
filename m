Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2EBCD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMo-0001Ue-5V; Thu, 21 May 2026 20:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMm-0001Tt-5Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMj-0003EF-WC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba4a1a0325so42788685ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408228; x=1780013028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxON0lSx6F4PleYxS1bR2jjXsUx8lGfM6B97HHIgUWA=;
 b=B5KojxNP6iEf8Mm2Hj9Ii7hmW1dzezY2omUirNJYyNVCyy/dCiaaWXoSgqasLlQqe2
 1GbDGZ50HIC4bamaRd3gVg3rLQW8wI8aUvdnsPjYkZvPwpi8jWpy+g72E1ZGk6iWJHgv
 QyCH+49YeF5CN4TZl4tIfmfJfIfgV9wCE08W+t5cqM9r6IQR51Ddfm9p/oFm4OH9FnME
 gupn3pZpMf8lWu9ticbCfSlWQoOOE0Oc59tofKyQbtmcL3qHCIb9WWNhZwm/WHgwFc7e
 /nFhF+eC6XBFRSM7mdaMZwf+3LdCfX2OFwRMtpGnOQLVrKpX1nxT7Pjwn2iqgXGU/uPU
 bKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408228; x=1780013028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cxON0lSx6F4PleYxS1bR2jjXsUx8lGfM6B97HHIgUWA=;
 b=rtHzj40HVvzk2bHSXVvSlq4bVr6uIb37bVb887vrP+wq7lF9aqBFsYez7QR5J/Cd0b
 n+7NWbo+8YYfMmJ09igDGhg3mL8rBNJGlgFZhL2cpeTOe4zoLOvXPJ6GO55KiObrlYDM
 ZRaJ+/8eDpn3BZbE5iW0gYZzb3sX4F+FGxKLMyG5pdssLdgtCDAG3yGDCna9TaqLa3Tl
 mU8KQh5tJAXQwtBfTKCwyFWvV3qPowckPUzf6H+w1XpMbkxBgHC+WrtHcSw78i4Qxk+B
 4Eh1BxK4oMbfxck0+iCCDDCeI0u8o44W1qOu3hvly7FVV4Ly4OBmiySI7ro6i0+iXzIO
 lwAQ==
X-Gm-Message-State: AOJu0Yw9L4iZ7bgowuyTTut83bOUGeIQx5T+tt2sDfiZ4SsnALb2UdlM
 Jm9eaKF9tqiGCarCV4AHwpG+O5b573AjH22et6hAZY/g/2pWYEcvPmZ6NMvr1jqF
X-Gm-Gg: Acq92OFCYzmca5eu+ySfYiiFhTIJS+bC4+CFDNBVQhI7bO9FOEDtS8Caq/FDcR/EmxZ
 L9fuLON9vdBUpDBqZWBzHBQH2i/T1Gtdxw/zGcxDBvUadd8ryPi+SqJ6y7wxfIuGExSe7oAqUx7
 u9UwLG0eGjgr2zliyRFyFYWdlbh1QLbZkPKCntM2sHM7/4vJTlffs7EITnY51xF0hb89/KYc8BE
 mhfzMmcAcuyfpHBbS+w4SvtigFHnhzTq92pn3wkZAKwGHWd2HZGH7v2qkaeh4+oyf+kh3aD1Y0d
 6ZHb6+xMZqnTiS+niy79UTC8E4QiE2I7JRHqc5HG06zG2QMpc971342lg9Yj0EHxp3Sh4dBwFRE
 qXQ70wO25xACL5z+h23qpAtUbk8gjErLpkmdwBcgdwaDpT5PozmQ3W/UYhxF7B1+PpDW4kh3LOe
 JEzOfU41Maxe6cpcMjbRXeCTNgwoDe7uaky17+1MY+zA==
X-Received: by 2002:a17:903:2f03:b0:2bd:eeb6:ff28 with SMTP id
 d9443c01a7336-2beb0672a53mr12348765ad.12.1779408228331; 
 Thu, 21 May 2026 17:03:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/48] target/riscv: Update MISA.X for non-standard extensions
Date: Fri, 22 May 2026 10:02:40 +1000
Message-ID: <20260522000324.23255-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260424050509.3935180-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fae839cade..45f895c1fd 100644
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
index 216c5f9f76..a358d91ca5 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1201,6 +1201,20 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
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
@@ -1209,6 +1223,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
     riscv_cpu_update_misa_c(cpu);
+    riscv_cpu_update_misa_x(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.53.0


