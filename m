Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7884C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylJi-0008Tq-NM; Tue, 25 Aug 2026 03:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylJa-0007zY-7D; Tue, 25 Aug 2026 03:11:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylJX-0006og-IL; Tue, 25 Aug 2026 03:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=awdajId5hB7rThniwEiObjE2TjP04hMzNFDJj8F3Q1o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LY/Xq5BNTPsnj4zDzteoYxZP3zK/ck9VZGVTzgl4TpAW9QDkf4KkjooT5oxBGOPM2
 FsYWaxFvPUUcpX/Z5XiGmgJdem9Sac6EBllHQLdUM6Q1A4MwLM+53bzgRnSagAxqNd
 riizw5yrlZidokk+Ex7MIRdk6JuOctBsHYjZfNaNJH9cw4MMpNWXmbXRdsHe0k29+/
 H2JlLjx6U8LWflE+VfTqvkCJUls5315dYaC0ijt3JiKjKVJKDQ4wlF0wqo5u9FfM3n
 u/8rSqpXV2EuqNq6/cXnp5YzN9I7hQkWpEg8dnts5AedF47+fNJpEP3IjxJezDNEza
 Pb/U9UqsRu52w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D135E1CE23E;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9585F415FB9;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE79D3245C; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Anton Johansson <anjo@rev.ng>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 89/91] target/riscv: Restore register dump zero
 padding
Date: Tue, 25 Aug 2026 10:06:01 +0300
Message-ID: <20260825070619.174584-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joel Stanley <joel@jms.id.au>

The register values lost their leading zeroes when the underlying type
was changed, resulting in mismatched padding and harder to read output.

Print with a runtime field width based on MXL, so values are 16 hex
digits on rv64 and 8 on rv32, matching the csr and fp dump. This avoids
adding target_ulong back into the dump.

Fixes: c4e6bc63853c ("target/riscv: Fix size of gpr and gprh")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260813032421.54438-1-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 409c7d8682ae91c5e275d744d55a2ac19789534a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 45b7610aa4f..b04beee5cba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -650,6 +650,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
+    int width = rv32 ? 8 : 16;
+    uint64_t mask = rv32 ? UINT32_MAX : UINT64_MAX;
     int i, j;
     uint8_t *p;
 
@@ -664,7 +667,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
     }
 #endif
-    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
+    qemu_fprintf(f, " %-13s %0*" PRIx64 "\n", "pc", width, env->pc & mask);
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
@@ -691,8 +694,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, " %-8s %" PRIx64,
-                     riscv_int_regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %-8s %0*" PRIx64,
+                     riscv_int_regnames[i], width, env->gpr[i] & mask);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
-- 
2.47.3


