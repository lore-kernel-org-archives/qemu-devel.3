Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D515C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOad-0008HB-Dt; Fri, 09 Feb 2024 05:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOac-0008H3-Sh
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:38 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOab-0000BF-A9
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:38 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-599f5e71d85so462957eaf.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476316; x=1708081116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGFNqUWHagsaOWtdN93//bJdHobk+bd1c/qcwnIUmSs=;
 b=mKC68Ga2vajVLKOtcSy8+rrJDnEG7KKjGWyq+NgnPSX6M1fdMeIDk3QEtirV8+trn2
 DQm1mHBYqK71rCqO8hgUMRQrUnhCa3qXqxkuujRAR0urcsfLEUY+8Blzwx9cdus2aN6y
 xMrtoqq3LOlTB5BVNBzWzEfng74wSrNfnFiyk+9JmPjebPppB73T99DjZemz6k+kgRkE
 g8YwvVvk0b2RWJgPuNtOm4p03GDHxykrdXObLG49llwyaztjdLzZV2LlLNGOsyLn/Y89
 l7H9pdIlylBFC1l3KW+eEuYovsMkrCftGr5N8nbkHD/yT8TmbHVaooKSnv9T0yz6qFrV
 h7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476316; x=1708081116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGFNqUWHagsaOWtdN93//bJdHobk+bd1c/qcwnIUmSs=;
 b=dqopj5fi6tfk9RuXq472zVQkfyeEqfrxh3T8TuM76cFcYPtyaZromNKwSniXwSVOSG
 EIi62bZLToBJCJCwHZ1R533Qvk+NL4HWTscgaHKX9NSZTr4pCFfEsv/WjvJoPcFOQfcn
 FpOIQJu7lw71E0Jr4l0EzY1wH9vHziyaFls4BKA8QelNXp2ZK8U9JXcwBN0KDo+cuY6n
 HYY4f/pnLoUhfNol6PjCjWwjlHo14ydAjl37B09eJe+dFMBA3iRlOCAGTTQGiHtD5VZS
 QCw6UzTd+hMvlOqsE28A+4UG1QwJDz/wi7aoOsqR4kT7p27ySm3m+r76I7Xbit8htVdk
 cO/A==
X-Gm-Message-State: AOJu0Ywq/j1NPZvT4h+D3jqjc5X2JkBULOKRuyQOE2O8ksta2jz34UIY
 cyYuQ4b1LA0F7Mte3+kzM7IzDLg6NVk9BjtufctZDrTs+MIW3E77R+cB1G8bjtmBWA==
X-Google-Smtp-Source: AGHT+IEx3CrnsUs/r83EpPRbS+YrvDVSE21eNPz6TrJYTVj/4/wRns90mDx7vXaEnJymDZfeggcNfA==
X-Received: by 2002:a05:6358:726:b0:176:9e87:412c with SMTP id
 e38-20020a056358072600b001769e87412cmr1220330rwj.7.1707476315772; 
 Fri, 09 Feb 2024 02:58:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV3TpPPNBXQFD9C0Gtx+cd1Uymdn/74NqSwTgQreb2c31EdCPqCZ5YAhgtOCQHw8KXObBbOeVWs9AwpPOIWTN8s6WT3Pqo6+fO49cveOX7O+K6zNenMYBlQa63jA7q7UqwgldEARqrKfVzoS8MbiQTq7x9RabL5n7iwJI0l7EM3Owqa5G7XF7W1fegNNyOZTOSrNZp1
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/61] target/riscv: Add step to validate 'B' extension
Date: Fri,  9 Feb 2024 20:57:15 +1000
Message-ID: <20240209105813.3590056-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2a.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

If the B extension is enabled warn if the user has disabled any of the
required extensions that are part of the 'B' extension. Conversely
enable the extensions that make up the 'B' extension if it is enabled.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240111161644.33630-3-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index baecfa7672..bf8e72a0e8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -442,6 +442,35 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_validate_b(RISCVCPU *cpu)
+{
+    const char *warn_msg = "RVB mandates disabled extension %s";
+
+    if (!cpu->cfg.ext_zba) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
+            cpu->cfg.ext_zba = true;
+        } else {
+            warn_report(warn_msg, "zba");
+        }
+    }
+
+    if (!cpu->cfg.ext_zbb) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
+            cpu->cfg.ext_zbb = true;
+        } else {
+            warn_report(warn_msg, "zbb");
+        }
+    }
+
+    if (!cpu->cfg.ext_zbs) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
+            cpu->cfg.ext_zbs = true;
+        } else {
+            warn_report(warn_msg, "zbs");
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -455,6 +484,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         riscv_cpu_validate_g(cpu);
     }
 
+    if (riscv_has_ext(env, RVB)) {
+        riscv_cpu_validate_b(cpu);
+    }
+
     if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
         error_setg(errp,
                    "I and E extensions are incompatible");
-- 
2.43.0


