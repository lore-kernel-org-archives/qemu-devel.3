Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAC1CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlzc-0003Wi-F9; Fri, 06 Sep 2024 23:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzJ-0002yI-5N
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzH-0004qv-4P
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7179069d029so1966815b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679185; x=1726283985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb2IXxxnHK/KXo5R/L/8Ek9ID/ZcfvZRBf6/jcc1+Bk=;
 b=ITauzYvibaIMCFfzeUjT1FNRQxoHWBOEZayjkDje2BbeZPIGBTt+J3bVvdzad8QG3/
 1a93RjFoq5E1Ttn5FewUmCQRopZoM9byZ6ih2NiLrC79ts1qJ7SDCs917+/p0PZFpq2x
 BL3ym8kZ61c5Ub5jo9sx8NoZ7moeFTBqeTv6MB/cONiZzLLSFFuheRG0UzVzLfehD1YT
 TllKgeR2B/e5wJ0z5/h6eoY0uw7EKqo+1YXLbZPU6opFZ/f2Q5zRZwY1xT5zzVeR6Xuk
 cTMgCsHEFM1k2J8dzXqts9vjor5D8+w7RnJFSZUL91tKBcw6lh8TB8vh5NFSMznADzBH
 +ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679185; x=1726283985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eb2IXxxnHK/KXo5R/L/8Ek9ID/ZcfvZRBf6/jcc1+Bk=;
 b=KzBOhkQYPnE1WKllMWHfTGlm2S7BE/sNJjxWJhyW7wFvrIWbD+WMkya16OUHddkVoA
 qXGDzrQjSj4quL68y7aNfk3UaVmwDDOsU3SyIUQZ6CX2UPTUbfDIVAYvr2uyxXYXlQ6W
 7c903LnjTra0VMyvuZC35byWjy3ha2o9rRgpQQ8Rw5YBODZUTM2uB76rTUsdiGc6BAuc
 uUQI9fR6ZUpm55eLmSy5iPEJwT26Fi0vQheurg35YgPQsRLCr4i6TR4oeovuXkbpnHPM
 oBtJyAqofg1yk9wYzrQcI9tjqJ2ZjYMdSfK38DfCQs5AYpLnWS6pRU9gfy2DxZuCDw70
 X/rA==
X-Gm-Message-State: AOJu0YxMKRiwWIufdoUQTVAeLMna/9wZ8OzuRzlDkKIUMb2tB3OYqPIA
 HoKUkuSs6kDmJrv39lrRITtXR5Yk7pyVKjSxzTo/czGJTVjVQQzW9FUIfA==
X-Google-Smtp-Source: AGHT+IHr6RAaEInDP6TWv3ArrXbxGFFqihr8ctTDhvQhJP+cKIVJlaSmksLkVF9mRlJaytrGxVGNXA==
X-Received: by 2002:a05:6a20:6528:b0:1cf:215f:1038 with SMTP id
 adf61e73a8af0-1cf215f1adamr3478240637.7.1725679185332; 
 Fri, 06 Sep 2024 20:19:45 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:45 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 03/17] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Sat,  7 Sep 2024 13:19:13 +1000
Message-Id: <20240907031927.1908-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x433.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added functions for cloning CPU registers and resetting the CPU state
for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index ea2a8d1ace..57abfbd556 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -130,4 +130,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
     }
 }
 
+static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gpr[xSP] = newsp;
+    }
+
+    env->gpr[xA0] = 0;
+    env->gpr[xT0] = 0;
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


