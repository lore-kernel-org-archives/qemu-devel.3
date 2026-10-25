Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FE606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1WM-0001D1-50; Sun, 25 Oct 2026 12:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WD-0001Al-ON; Sun, 25 Oct 2026 12:56:26 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WB-0004by-0Y; Sun, 25 Oct 2026 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6Z9Bagb8bFZQqhjkspHnJBhoenWUbvLsr/ghICpTcJo=; b=jW1DawwGlt6vdZ6ilUaHft835l
 1Q0KsNFS1kfSd6eL1gTfmPxDbFv3fLZWsZhm8YIZtv0/bf5694RekfVRed1N1fw9MdtY7isTTnxIK
 vO2APfJzDj0a/qgedYeastG/oLWgSyB3EppsBjiYdme3JaZffV3ujR44AK15vcnY10lXXYZghpQke
 0yLXDemnBUp9dG8v+6xU9/dDR4oflBO/C5Ckv0yz1um1Ub0lhxpXLFm7pEtarGMO1NOriWZng7h0r
 UZeZeyBzwUWe3w030h6jFBSqdzkv57oCf4W8xon0Sait7iMu+esDlXPYx2xBjbaUSWLh1ATsViL7q
 +iUp9jLg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kP-0J; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-12; Sun, 25 Oct 2026 17:56:06 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:18 +0100
Subject: [PATCH v2 02/31] target/rx: add EXTB exception vector base
 register
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-2-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=4032;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=SftWqin0niFNu5gzeIKV/q83ZnlSO/Qhrskoulpfv58=;
 b=w0Eu+f/kljNN+n4Cf5M8USm8WbkX/b3ifN+sT7xtgfUutfAclVvHXjY3QyKdJWdofNVr1XzxM
 1j8WQj38D5xCOJbVTiiHw4QehxMUcxwwjjHndlIdyYKuayukMv7yf3C
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RXv2 adds the EXTB control register (control register 13), the base
address of the exception vector table. On RXv1 this base is fixed at
0xffffff80; initialise EXTB to that value on reset and take the vector
table base from it when delivering a CPU exception.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/cpu.c       |  1 +
 target/rx/cpu.h       |  1 +
 target/rx/helper.c    |  2 +-
 target/rx/translate.c | 11 +++++++++--
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index df0530c7bd..73796c3f3b 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -103,6 +103,7 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
+    env->extb = 0xffffff80;
     env->fpsw = 0;
     set_flush_to_zero(1, &env->fp_status);
     set_flush_inputs_to_zero(1, &env->fp_status);
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 1f81619ffa..8741d759b9 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -112,6 +112,7 @@ typedef struct CPUArchState {
     uint32_t usp;               /* vector base register */
     uint32_t pc;                /* program counter */
     uint32_t intb;              /* interrupt vector */
+    uint32_t extb;              /* exception vector table base */
     uint32_t fintv;
     uint32_t fpsw;
     uint64_t acc;
diff --git a/target/rx/helper.c b/target/rx/helper.c
index f170a14721..cb06f31a2f 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -120,7 +120,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
         if (vec >= RX_EXCP_TRAP_BASE) {
             env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         } else {
-            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, env->extb + vec * 4);
         }
 
         if (vec == RX_EXCP_NMI) {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 91b033c3c2..b398af9531 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -50,7 +50,7 @@ const char *rx_crname(uint8_t cr)
 {
     static const char *cr_names[] = {
         "psw", "pc", "usp", "fpsw", "", "", "", "",
-        "bpsw", "bpc", "isp", "fintv", "intb", "", "", ""
+        "bpsw", "bpc", "isp", "fintv", "intb", "extb", "", ""
     };
     if (cr >= ARRAY_SIZE(cr_names)) {
         return "illegal";
@@ -68,7 +68,7 @@ static TCGv_i32 cpu_regs[16];
 static TCGv_i32 cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
 static TCGv_i32 cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
 static TCGv_i32 cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
-static TCGv_i32 cpu_fintv, cpu_intb, cpu_pc;
+static TCGv_i32 cpu_fintv, cpu_intb, cpu_extb, cpu_pc;
 static TCGv_i64 cpu_acc;
 
 #define cpu_sp cpu_regs[0]
@@ -361,6 +361,9 @@ static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
     case 12:    /* INTB */
         tcg_gen_mov_i32(ret, cpu_intb);
         break;
+    case 13:    /* EXTB */
+        tcg_gen_mov_i32(ret, cpu_extb);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Unimplement control register %d", cr);
         /* Unimplement registers return 0 */
@@ -415,6 +418,9 @@ static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
     case 12:    /* INTB */
         tcg_gen_mov_i32(cpu_intb, val);
         break;
+    case 13:    /* EXTB */
+        tcg_gen_mov_i32(cpu_extb, val);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Unimplement control register %d", cr);
@@ -2308,6 +2314,7 @@ void rx_translate_init(void)
     ALLOC_REGISTER(isp, "ISP");
     ALLOC_REGISTER(fintv, "FINTV");
     ALLOC_REGISTER(intb, "INTB");
+    ALLOC_REGISTER(extb, "EXTB");
     cpu_acc = tcg_global_mem_new_i64(tcg_env,
                                      offsetof(CPURXState, acc), "ACC");
 }

-- 
2.53.0


