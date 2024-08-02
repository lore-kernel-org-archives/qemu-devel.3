Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766BDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkM-0007NO-D0; Fri, 02 Aug 2024 04:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkL-0007Jk-Fe
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkK-0006QZ-2S
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so2430572b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587682; x=1723192482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPxKuHfJ8Jlg3MccCfTTfm7YXqCA76DHADjCciQTBLI=;
 b=YCpJ31lvbf79kY6UXEtuLtLJfXGSMHVzQE025T04doXHf4BLeIvbMXcWA4rmJrDuxK
 wz0B7bL/Ar13vhIPHnt7nD3qPVvaz8gxBvBUY8uGMAdV2tnvMR5NZQyhfHa86QrtoKGo
 WVycRymExCfWZvUQhvZ9KSngrccPlsEkTByk908UpsVizaA3Wj38c1b2iy9G53esPDyK
 wjjGVhW2nBEx9J1yd/wB4APKP5Ta5HZUhv7YRS7Lsr7XCPdfdjieWzO4F+2qdJVSjE+a
 f9DBVbLTPcCe+gTWOT7ZTwVWmRcT0oJBNYiH5P/YpsElgz9AxKzxJISgxFduwIiKd9pa
 OdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587682; x=1723192482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPxKuHfJ8Jlg3MccCfTTfm7YXqCA76DHADjCciQTBLI=;
 b=RCQVZZCTuiyYDpGqSQKGEi74N+Ch/qYhohPQmiP3UnL7DJ3RK8YfbvmosOaZadcL6w
 Wbx4X9iwC+WohSGnMO2wqyRG9roUCEpsVgzn/cDG/fHbD5/JGdiAATvrIg3UpHfOkAsz
 bmWBp7YNQKi7bjGfpQivyDpELY/fM3gzbTtuMvNqpCpUV2j33ZapbCL+ujjiU4+yTrpP
 1YlL/8VTHg9+noFsY9GkH0lVlX0NQTOfsC/UvnYNuiFNhF2eeBbP5A4DHEOSS6kIYJK4
 n9BNK0s4xwsLUJfz0eKZQ1J2abv849M9e3TSYQca+C9pWA3kxt1e9mtooh1vr9Wge8VU
 4hsA==
X-Gm-Message-State: AOJu0YywWpLtcVBVZFmntKBU3fCBDdqUMD4+uMV90xKVrmSOgqKyWO2L
 VcaQfoJz4Awt0p6B/EW2Xf/qA4kUVnvg8U0VGMRVJ9RiavIwoFQuonO+iikl2pE=
X-Google-Smtp-Source: AGHT+IGkxm+nA1G2P9Io6wcZyFfCM1tOL2WIHZMrfGGuz6GFHO1WQfqq2Fb2fz7yOk7+1ABrl6W0YA==
X-Received: by 2002:a05:6a00:66da:b0:70e:cf57:93da with SMTP id
 d2e1a72fcca58-71065dd6a98mr7405251b3a.2.1722587682345; 
 Fri, 02 Aug 2024 01:34:42 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:42 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 03/18] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Fri,  2 Aug 2024 18:34:08 +1000
Message-Id: <20240802083423.142365-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x434.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Added functions for cloning CPU registers and resetting the CPU state
for RISC-V architecture.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index 5b436b2ac9..53db790517 100644
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
+    env->gpr[xA0] = 0; /* a0 */
+    env->gpr[5] = 0;   /* t0 */
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


