Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EDEC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqJF-0000rd-Vy; Thu, 14 Mar 2024 15:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkqJD-0000px-QO
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:00:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkqJB-00019e-JQ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:00:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dee6672526so899255ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710442804; x=1711047604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PajR9BB9cA2kOKGEwVsLPH9xajp/vsDO+ObB++Rdsw4=;
 b=cHgANEOeAAkPi8mZPkL0h4sTn6s+s3eAbWk8RWZFgoYbBwIVGEEOgat2uu1PZzeKgi
 NthfV/uty8gsKNBZieE3xl1ukG5BsNiaWQiqe/QAHDXIA8NkYlHa4ncJgdPKQU8Ycum+
 JcStJIYv6T3uoH1DrB8F1rMny5YAkTYfEdLnSiDpt5oFDBQHTahKjDM31jmdQ4ZGbnu/
 pswAqPaA5WQ5wUUsFoOM/+yHF+KCHww2TogxxArvwRqEh9Lfd2K1Ool0MFbwxWQdE5le
 SifXbiynAMDYGnfA1WLrbSGdMpChSG/RzIsfVIualmv592rGSUVAEDHTdjiSonp/oCvc
 005g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710442804; x=1711047604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PajR9BB9cA2kOKGEwVsLPH9xajp/vsDO+ObB++Rdsw4=;
 b=A5BYHq+Ohw3Sec7ZdZ0/XbpBHVDEF5NxAqjPpy8NszseCgX+22Mhulpz9QwzmAI2x9
 uBPYp19joDsCqu8fjzQTZTleqH3CKsQkleIPTtky9nAviK+vutuWJ2Ssdqu+5TU6N8UU
 EkuoPvjkd9cN8HbHtHmfGftKoAfosDFxTuWoyGMFmF0MoBrPTmBxBRmqbXu/3MtxBx/6
 31uYmBmoHnLFCXILPeJplEHzS6Q3vVwJGa8VHw3+od2jVGXuf1XdDXDDmPacT0bV0MK8
 xa9u1oUMXXabltd7AAW38mbxh9Bhde0s4giPQhF8RHbEejsvUIesFCPk9uwa9o3ngfdz
 gGkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVU20jiR91HYpVuIM8pTn31Jr4FKhhiIJSsw9KIO2X7q8Qdx0MCtImnQhY6m8wV8R+1uW1kX9G0wrRl8C2F2tsaT3HV2w=
X-Gm-Message-State: AOJu0YyxEgAN1t2c/X0wG3hEF8bt7mpuKsHzb4pb/GpU9rdD1vR0KS/m
 qzXx+7F89Ox6HfJmwhoCiY+1iiqfEEs6S2p3SfiZ7WX35ORJDuiw98JcWFHfOOvgB0dtPS3OzPT
 E3Lw=
X-Google-Smtp-Source: AGHT+IHltb83xf0srFhj8tUZuAZvtOZIHrv3pDrhQ9xY/neEh03nwnVoz5lGAX7bf8QjQgmFotD0Pw==
X-Received: by 2002:a17:902:c404:b0:1dd:7c4c:c6b6 with SMTP id
 k4-20020a170902c40400b001dd7c4cc6b6mr2969568plk.5.1710442803895; 
 Thu, 14 Mar 2024 12:00:03 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170902784800b001dd1096e365sm2105732pln.281.2024.03.14.12.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 12:00:03 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v7 1/4] target/riscv: Check for valid itimer pointer before
 free
Date: Fri, 15 Mar 2024 00:29:54 +0530
Message-Id: <20240314185957.36940-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314185957.36940-1-hchauhan@ventanamicro.com>
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Check if each element of array of pointers for itimer contains a non-null
pointer before freeing.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..5f14b39b06 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -938,7 +938,10 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
         env->tdata3[i] = 0;
         env->cpu_breakpoint[i] = NULL;
         env->cpu_watchpoint[i] = NULL;
-        timer_del(env->itrigger_timer[i]);
+        if (env->itrigger_timer[i]) {
+            timer_del(env->itrigger_timer[i]);
+            env->itrigger_timer[i] = NULL;
+        }
     }
 
     env->mcontext = 0;
-- 
2.34.1


