Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9DC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 08:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU0WC-0004V9-3u; Sun, 28 Jan 2024 03:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU0W8-0004U2-KP
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 03:27:52 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU0W6-0007Bv-Mg
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 03:27:52 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-595d24ad466so1337852eaf.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 00:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706430469; x=1707035269;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GbHsFPTqeVEF6MXxcuYOrP3CMgZR2bO4xbc3tDD6CnQ=;
 b=3Y6CtntcA0yFrHNQnT2LA/Fzjjt20bNi4YveUeAWHkDTwqmyM2xXPGDuaFs4/XOM57
 m7POFwd9Ro2uhoFj0J1gAVIk0Qa+SK00Qtaz2xOwI5P8Rl+12LQh+T9zk/TCJy+LzMvG
 97DkcB8Ixvg3IYacQ2dS+J1MLi9C8BUIsmnwNd3iK2EsErnuBrZUu9GzqnGqOzvKIUAh
 5gAdA6dsun0Cr64Z2fGKwPGsmPBYrf1ASdbNL5BipiVlNYHLZgsadWdcoo0Yuvi/gtnB
 xOHm0IVK+/cGmLzTWi+5hnFn9EBp/+GbmWLMQ8uTwKwJb+MEAqqV3Gq4aBUTQyhvc59C
 a3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706430469; x=1707035269;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbHsFPTqeVEF6MXxcuYOrP3CMgZR2bO4xbc3tDD6CnQ=;
 b=Ea/+FtIUFfKiO3t4MZwBypD6iL8c45fhuY0y3WmFe6BYmL2Y5tx+fBPq0yLjIMGt+h
 MtrKB8TRihuHTLBrJyPgun6Jfa4gMn4GLU1B0BoD/gWB22FfVy7jHwq0OwS6gB7OuR8j
 tIBjTB+7/AkYIfZG3PCHQpv306+LyVvdr3zFH9HdGPYz/ijEXaQPdaO1L0tD/mFi+qp1
 d9ITAmVVO69cNISFDeV5+2W78WDsZdS09F9OuaX2TT6QsdAzdGHoCKMAtSdgjYBzKoak
 +cJgNrQWPG5wnMBEh2Euyi+0oPu+0U0b5eAWwPZGeISxLq4I7FsF4DxYIMNzuuPrnOmf
 XtLA==
X-Gm-Message-State: AOJu0Yxb9paSHxHRQLgXmY0TSXL79F1RCMCyzIQcLbegoPlTwFuR++22
 x1+od1nT53GCwcwD1ddRfO4M9p/0cvx2EcOxZl+UAOq7UkJfSZHGSCFoS6QPp0Y=
X-Google-Smtp-Source: AGHT+IEfmEKZ2dtXCEvBt0zHlBdn0Xzoval3PyAYgAhrJPMsgazE03lMFcaQ7Pwvcvx/9gIzD6BTsg==
X-Received: by 2002:a05:6358:7e0e:b0:176:d451:97d8 with SMTP id
 o14-20020a0563587e0e00b00176d45197d8mr3379005rwm.51.1706430469399; 
 Sun, 28 Jan 2024 00:27:49 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 e7-20020aa79807000000b006da96503d9fsm3789106pfl.109.2024.01.28.00.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 00:27:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Jan 2024 17:27:39 +0900
Subject: [PATCH v10 1/3] target/riscv: Remove misa_mxl validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-riscv-v10-1-fdbe593976e9@daynix.com>
References: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
In-Reply-To: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2e.google.com
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

It is initialized with a simple assignment and there is little room for
error. In fact, the validation is even more complex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 14133ff66568..b85b0d036a61 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,7 +268,7 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
@@ -288,11 +288,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     default:
         g_assert_not_reached();
     }
-
-    if (env->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
 }
 
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
@@ -932,7 +927,6 @@ static bool riscv_cpu_is_vendor(Object *cpu_obj)
 static bool tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    Error *local_err = NULL;
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -941,14 +935,11 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
 
     CPU(cs)->tcg_cflags |= CF_PCREL;
 

-- 
2.43.0


