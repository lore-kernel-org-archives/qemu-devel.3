Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27913C5472D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 17:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shue5-0007CN-7U; Sat, 24 Aug 2024 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shue3-00076q-Ra
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 13:33:47 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shue1-0002IF-Sd
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 13:33:47 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70941cb73e9so2058002a34.2
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724520824; x=1725125624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LZhaJMQ6PkwdKPVl/65Ojkpw76G0zD1CDyA0x7yQobg=;
 b=REQL++YpecTQffeED/jnP5WNBGSkb6gvygCQe5kz/x37rEoIDod+ww1hUxlNi6gXZ/
 qxpdzG1mz1q482tpgimyTssel6AaKdYAZ5sBz811R9v/Ib+T/3FpgsiSQTDAHqkpaYTU
 RZX/74Y7n929QdZcUzE8AvATQ9sRHBUEwBIyKH9SVj2qY5vCW3n9svg8Xa2Q2De/lBo8
 VzzokQMDddDiywwQfNnimQ6yOYvmyGgg1kMqY7ywPqo5egnaVipj2Qf72SfxgaNpkOcJ
 BiKClONidEIQISWa0dvYFpL8m4urqJe57EmvZHoej348G7vKtiFxjbuNn+7utkJ4iK/7
 KtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724520824; x=1725125624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZhaJMQ6PkwdKPVl/65Ojkpw76G0zD1CDyA0x7yQobg=;
 b=dvZWowDPQ+yJpCImZ+gM+eQOIEFvxsaxqcZMZwCMGCktttVq8oiEo+VxtLvAeeVSIQ
 qeHdeeL0QVZPodLirJsS61gA49rPeWg7JlAMeEwnuRHNAxl3xjuZYwAdZYcN+4SZ7M90
 750q9xG0IjUeTmnAA/qgvnWhpNmUs94aphb1V+ApuFI9z8Mggyt8VllnomEORM8vC47r
 qPq+EleUYcSESLGiZhKdoP+jslks2ohM1gYAJwUjJgSJTvzioOtBSxkAdm7IMcmwHtLH
 w/vHbUEMkO45I8ACp0xtmhOg1BHSKf19Z7ktIfJs9AsQ1csMuj5cy50MffpTpnDEj3iI
 Cj2Q==
X-Gm-Message-State: AOJu0Yw8ACfODfJJxjtBidkDPOhUNfYDYGlCrFRwF+rMp3pCY/3lVlo7
 Z9hvEi7xQquQ7f1VgJJei/AjHPEIBToUK5EtgmswkhE2v22if2G9IaqO53oUOp3dvYWEPdos3lZ
 h
X-Google-Smtp-Source: AGHT+IEZNZgy9Fp0Q3mSH+xfS87GBXUxYkFXMONBV654VuaVa6Q7qXcwdCIgt2CNLRBozifHkslOgw==
X-Received: by 2002:a05:6808:211f:b0:3da:a48b:d1ec with SMTP id
 5614622812f47-3de2a89b188mr7278549b6e.29.1724520824195; 
 Sat, 24 Aug 2024 10:33:44 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.133.97.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143433ac53sm4724904b3a.212.2024.08.24.10.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2024 10:33:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] target/riscv/tcg/tcg-cpu.c: consider MISA bit choice in
 implied rule
Date: Sat, 24 Aug 2024 14:33:38 -0300
Message-ID: <20240824173338.316666-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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

Gitlab issue [1] reports a misleading error when trying to run a 'rv64'
cpu with 'zfinx' and without 'f':

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false
qemu-system-riscv64: Zfinx cannot be supported together with F extension

The user explicitly disabled F and the error message mentions a conflict
with Zfinx and F.

The problem isn't the error reporting, but the logic used when applying
the implied ZFA rule that enables RVF unconditionally, without honoring
user choice (i.e. keep F disabled).

Change cpu_enable_implied_rule() to check if the user deliberately
disabled a MISA bit. In this case we shouldn't either re-enable the bit
nor apply any implied rules related to it.

After this change the error message now shows:

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false
qemu-system-riscv64: Zfa extension requires F extension

Disabling 'zfa':

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false,zfa=false
qemu-system-riscv64: D extension requires F extension

And finally after disabling 'd':

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false,zfa=false,d=false
(OpenSBI boots ...)

[1] https://gitlab.com/qemu-project/qemu/-/issues/2486

Cc: Frank Chang <frank.chang@sifive.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2486
Fixes: 047da861f9 ("target/riscv: Introduce extension implied rule helpers")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753..dea8ab7a43 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -778,11 +778,18 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
     if (!enabled) {
         /* Enable the implied MISAs. */
         if (rule->implied_misa_exts) {
-            riscv_cpu_set_misa_ext(env,
-                                   env->misa_ext | rule->implied_misa_exts);
-
             for (i = 0; misa_bits[i] != 0; i++) {
                 if (rule->implied_misa_exts & misa_bits[i]) {
+                    /*
+                     * If the user disabled the misa_bit do not re-enable it
+                     * and do not apply any implied rules related to it.
+                     */
+                    if (cpu_misa_ext_is_user_set(misa_bits[i]) &&
+                        !(env->misa_ext & misa_bits[i])) {
+                        continue;
+                    }
+
+                    riscv_cpu_set_misa_ext(env, env->misa_ext | misa_bits[i]);
                     ir = g_hash_table_lookup(misa_ext_implied_rules,
                                              GUINT_TO_POINTER(misa_bits[i]));
 
-- 
2.45.2


