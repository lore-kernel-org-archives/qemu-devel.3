Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BBC4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 10:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCzb-0007yQ-RC; Sat, 03 Feb 2024 05:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzZ-0007y8-9W
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:21 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzX-0006x3-OI
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d76671e5a4so22994395ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 02:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706955078; x=1707559878;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EVFEkyD2AS6ap5J+rUntbo0ffQ6dqe1CEg6+zFuyHws=;
 b=1wgGPpPJbJgfCrg3ZPphNzRitmOkPbz3rit09jIuYgaBBYCJnVzS7CFLc4P+FJrzzP
 RwwvPlpJ/zRAeY2qSAUH07cCjciqa0tQ6NjNAevp09cVki/k7yu+TsbvllZ7XoGz2i97
 ItFc4cTOzUv2NPS2RB7rtx3z1SWcq5v4PqD4Yjid5BB0TvWQjW8bb/NgLf3UOrtiIeun
 zFNTIDWRJ285HNvamQb4cC5smOCz9QNXFR/Vk/FKYnDAJSone9qdYvrr+eUWHaVKNoP0
 7aIJGDWS1GBCUOa3CxHgVbm7gIVQ325vj4pcmCpo/c4RqFtIHPq8ijMFmb+9cC8lJrcx
 t9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706955078; x=1707559878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVFEkyD2AS6ap5J+rUntbo0ffQ6dqe1CEg6+zFuyHws=;
 b=CF1nxUR8huPKf9/kmYzdZMWQzJyDKFkqLL/HWYSO7Uu2PEWtpbPNoKtNpA6x0Ahql6
 rmuhLtjHiZiuNfQJEt4BL2uDIJDyviXbNZaYp8x5Rrei2d82GK+NEWneUTQRb92DwFFO
 Ym/usFJIT5BUnQVF+9s5eNAbBPgSMzCV94b7lPeJOVCOWkpPB3PtTfHQuS+zltcyyTbV
 SzOfe01GnVqaBDLIViWsQk616IAlzXEhASe4Yr6EP0CBDMNqaxHDnHKszjDYrFZhkcNo
 DTEq/yXl6/sV6waTwVvu6H1ulvYBXRNBLdcV6vGva6PrY6GeT3rqIcRjfGR5z47XBrrg
 GaIw==
X-Gm-Message-State: AOJu0Yx1jM5G9Mk71q7taPBTfXBt1Abu8I2tgcVpto1HX49y1TyDP5X2
 k6+hbs3Q6GlbSLNxBhFH/3uYPX1LGHjN6MCHC0gNfJivLpy+1XMyb2/edTmW3qU=
X-Google-Smtp-Source: AGHT+IGCWT626+VoT1tOAowWGJ014WWWcTGCsTOXPZyZAuu+8xhPQ6fWvcRHz6/NPc4YSpQHKzft0w==
X-Received: by 2002:a17:902:7ed6:b0:1d8:f016:cfaf with SMTP id
 p22-20020a1709027ed600b001d8f016cfafmr9017138plb.47.1706955078458; 
 Sat, 03 Feb 2024 02:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVzENxv70mH8N3klnj30nfK9W6gQT4X2HdV3CxrWY5aDfTkY9637cQRkfwZT0pHtpqBQI6xGAQg1OvndYpp4sNV54s5BMvUNizal3U9ViMH+YYwm3X99dWxiQiGTWnthJQ1Ci1LKukx8Un74s/N6mE1Z7lfJz3u0wPpgPpD6L6YQynLox6iDuEJKPuKGM+bBODfqRQ0aZMrC7GUfVx9+lr0jiB7XmL0o2WNxcEZLKlNtqt5F7wLUQErxJScCaFEK2uUKmauJTM+d459EXGn9W3xJ3qrerSFbNHaPrZOvHmdp1XCatnuVcW/ZTbYiOJPOUbvZOoYURwwP99jzf5ey6bVCUm6mGXJD6Vg77jTUncM/L9CvjN7ULl+ZNF98UqMnmC7Jf8Ek1MU+yb/QPqIPUgKaCv1QV3glwyxiCql1614UuTzVbSO+v4t1eKj40h64aQTBclQaa1/P6stj6fR
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 ja5-20020a170902efc500b001d937c0f5d9sm2949071plb.191.2024.02.03.02.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 02:11:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 19:11:08 +0900
Subject: [PATCH v11 1/3] target/riscv: Remove misa_mxl validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-riscv-v11-1-a23f4848a628@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
index da437975b429..94dca7e446eb 100644
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
 
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
@@ -908,7 +903,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    Error *local_err = NULL;
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -917,14 +911,11 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
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


