Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44F2EED626
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 18:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbNEf-0001lV-AO; Thu, 01 Jan 2026 13:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vbND3-0001Hs-OP
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 13:15:46 -0500
Received: from 6.mo575.mail-out.ovh.net ([46.105.63.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vbNCx-0006dF-Du
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 13:15:38 -0500
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.254.243])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4dhw3W2FpLz5yBR
 for <qemu-devel@nongnu.org>; Thu,  1 Jan 2026 18:15:19 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-kbmwb (unknown [10.110.164.150])
 by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 91034C02AA;
 Thu,  1 Jan 2026 18:15:18 +0000 (UTC)
Received: from petrot.fr ([37.59.142.99])
 by ghost-submission-7d8d68f679-kbmwb with ESMTPSA
 id QUyEM6q5Vmlo/w0A7Yva2g:T3
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>);
 Thu, 01 Jan 2026 18:15:18 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003dc648778-0f14-41a5-b5ce-7fe59701666d,
 8D8ADDDE20E1118D614694FD1C3138A4D0B19743) smtp.auth=frederic@petrot.fr
X-OVh-ClientIp: 79.90.201.35
To: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 2/2] riscv/tcg/tcg-cpu.c: Remove mttcg check for x-rv128
Date: Thu,  1 Jan 2026 19:14:42 +0100
Message-ID: <20260101181442.2489496-3-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13382164820977194261
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFwRW+I6HwiRyjSKPUoX4IZMIMscF7HRe/KUM5jw/ZXUDYmbWjU8ydFbfEaad0S+eQG/bRnDS0ZcqL1+QPJWuXhW7z0bIvFQIMxJ7zSIWpE5c0yVb7PmHbkDVnw/N4aCBvoqUbFrLVqhVhJnH/Mp3DSrFtIiNZfzoa/DQvXdCVBrIkn31verKbI+Jhk/9Ajuog7RvKUG9Zmid7MJPqCkFY2W2TswkhkezCGBiRtDgfuuq3pmWzS8N4IhoZiq1BeS/yp8qH77PlhwT6ZSx+2LW5AZzJhehKGuQbCvOfY0J/3yjqbArA9SJX6Kf0dubFDuiH/7BvXWa06BteJ/7wQPUR9YIPdET9GexplmMI7GQH5hCgrOIFBbyShU1RhNfVSnrfkqLLDmeL/8D+RWBH3H1zbRQmJF2BcAdsuZfO4X/+qSEWYNg7gtZevxKmBi6knJ+k43EVnEh2rLliKYL71x3UJ0jUIyZCQ6Xe7IZwrbSA2bGxTG358wcLdyAy+OHE80ZKst1QRAw2h+IVG0+k5pZ/a45GYZr53ClEhh382bh1oqwCdPHexPAtL8ty/c/G1GCEVXS4iEpNmJ/EjjcKK+eNLH0e6ClV5tSQ3vAV5ZsC0TLpc10Rw/1+zWBaxGb7IwS5zdXbuirvPIpOucXCzbkckoWCHCO/8H+wI12QeYe5adQ
Received-SPF: softfail client-ip=46.105.63.100;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=6.mo575.mail-out.ovh.net
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Reply-to:  =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
From: frederic.petrot--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We had to check that mttcg was not used when executing QEMU with
-cpu x-rv128 as a single 128-bit access was done as two distinct 64-bit
accesses.
Now that we use the 128-bit ld/st that access the data atomically,
this check is no longer necessary.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/tcg/tcg-cpu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 440626ddfa..15d39f9912 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1305,16 +1305,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-
-    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
-        /* Missing 128-bit aligned atomics */
-        error_setg(errp,
-                   "128-bit RISC-V currently does not work with Multi "
-                   "Threaded TCG. Please use: -accel tcg,thread=single");
-        return false;
-    }
-
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.43.0


