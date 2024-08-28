Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44691C5479A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMZ-0002Gl-4a; Wed, 28 Aug 2024 05:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMQ-0001wv-Q7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:07 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMN-0001o9-5u
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:05 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5dcd8403656so3324196eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838781; x=1725443581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T71bAWZ5le2Naj8DZ0ljjvL8S+u/egKAPUIr3/tluJ8=;
 b=NZTs+2EUVNqwBJ1RC8t1MOPCEz3GYbOeqQQvc4UKtHWLksPZjHgh6m9A6Dz8btDyYX
 lhT3joER4YcN8tS3niwM3Lj433QpOjrkZBVpOCB67cXBvCncy5B6P4LzVhf6z5aBjwSI
 9HDOYiQl7TGd+0c22BDknHZYjkzsWIrOEFtQ3reK4LNntirpjkejM7Fmoi3QKljsV989
 wDAoT9A8p67VX5/GOKO0u85i2CCCI4rMAEESlIYMIfd6AOQxRIWHw44kCtnWqWhBwISM
 UZKR0xXX8EvUrbYf8cRTmiwKvI74hHP1Pr/+Gf22dgBsJ8Q7n6UKjQECn1XcZLeylSwN
 XvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838781; x=1725443581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T71bAWZ5le2Naj8DZ0ljjvL8S+u/egKAPUIr3/tluJ8=;
 b=C/lIhaJZAo5ww+jZ8P2/PML+ILKk63wCKfaau+6stJrAZTU34gD8T8bSBIuIZ+Nvx4
 CH/UyxdAxRyhC4IOKXsT1r/2z6GUy5Bro/gFJlpi/kiUeG8wh5LDGBlpBtOGtaOQmDyx
 be6DvF967YbVzV7yJsarUbCwDVqtYlLVG1O++9kTC7tR5pfLnw8cNeOBdEJzDWK360Tt
 hs/L2Yvx976YOwMdj/RDfUHPUJmp9mcb9FXxp+RjBi3BoUdoK73jp92e3CcTx3XDS/aO
 j71Cr08ZHKMLbYhN+Q4cE0lY/zSEOZPP7AmlqNVCxTrvDePg3V4gsZIfB/3jLdTL/Jke
 rZTw==
X-Gm-Message-State: AOJu0Yya+7g2jvJH9ha+NJpJc4zGB71GbMU+FHoUyky00mxHfmd2roaL
 wvMyrCSqu5IvvFiKdyOBO7oNpQsQOH529WFGdW0CqFAIHVosHf6aROvDwWef
X-Google-Smtp-Source: AGHT+IH4OD8zAfPcwO53guP+mNee6d6qN8ggHvB5WTMqp92jh4ZTGGGSlERXbhhlQrsS0DBfHwEUzQ==
X-Received: by 2002:a05:6358:109:b0:1ac:f2a5:e79e with SMTP id
 e5c5f4694b2df-1b5c215c92bmr1934193155d.16.1724838781428; 
 Wed, 28 Aug 2024 02:53:01 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:01 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 03/17] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Wed, 28 Aug 2024 19:52:29 +1000
Message-Id: <20240828095243.90491-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc34.google.com
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
index ba589909e2..b1575aab20 100644
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


