Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C3ECF6BF7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOW1-0002Zp-T6; Wed, 07 Jan 2026 03:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1vdOVn-0002Vn-0l; Wed, 07 Jan 2026 03:03:26 -0500
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1vdOVh-0006Ec-DY; Wed, 07 Jan 2026 03:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1767772967; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=UIgERDaJQ1hPrLH/W9m4577Uq9aFxMm1vW76SCESwB4=;
 b=od0bIQBYCGZf6iGMKlvfFwgWxRvwBeRWHDGQYSe3AkhOAlxZpY5KoTOaTBF32OdCYuwMaZncenBV+G5bvG77HxJjOjFvaXtIUwwBlYHfJG8jjP1Z/9tx0vxdd0qHubJDYBYzpI/pJQdK3ZgYTStTHTg1HnpUa6JrWpaZ/dh+cwE=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0WwY-yyG_1767772656 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 07 Jan 2026 15:57:37 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 07 Jan 2026 15:57:12 +0800
Subject: [PATCH] target/riscv: Drop stray '+' in pmp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-stray-v1-1-6658efecbb0b@linux.alibaba.com>
X-B4-Tracking: v=1; b=H4sIANcRXmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNT3eKSosRK3RQTCzNzy7SURJNEAyWg2oKi1LTMCrA50bG1tQAkuSd
 7VwAAAA==
X-Change-ID: 20251225-stray-d48679fda4a0
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767772657; l=1426;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=lmQokMJ1ik9Lorhz0JAwJUDu/v+Agcvb4qIXEhYhLEQ=;
 b=Ei88EtjPgfVJBwTAdaQQbutE4nJtoXXKMaJ9sm3qv1v1F8qYoF1Ub5SssWTaQ7K67KSdfaHmF
 5OCcOp0NrCoDc0nW/1CegVtgzZWpmTg9FCbfCzbJnJtP6//bIUMKwW/
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Remove an unintended leading '+' left in target/riscv/csr.c (pmp()).

Fixes: cd633bea8b0
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
This patch fixes a stray '+' character that was accidentally introduced
in the PMP (Physical Memory Protection) CSR handling code in target/riscv/csr.c.

The issue was introduced in commit cd633bea8b0 as part of the PMP region
count configurable feature and causes a syntax error that prevents
compilation.

Fixes: cd633bea8b0
Link: https://lists.nongnu.org/archive/html/qemu-riscv/2025-06/msg00089.html
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3dc412c6f0e6db89120b935b4c0ea6cf..8c1312ab129f4fe6a21d4dff67b3a7d9ca175415 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -743,7 +743,7 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->pmp) {
         int max_pmpcfg = (env->priv_ver >= PRIV_VERSION_1_12_0) ?
-+                              CSR_PMPCFG15 : CSR_PMPCFG3;
+                               CSR_PMPCFG15 : CSR_PMPCFG3;
 
         if (csrno <= max_pmpcfg) {
             uint32_t reg_index = csrno - CSR_PMPCFG0;

---
base-commit: 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0
change-id: 20251225-stray-d48679fda4a0

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


