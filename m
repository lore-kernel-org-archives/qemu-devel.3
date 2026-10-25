Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C60606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1WI-0001Br-6z; Sun, 25 Oct 2026 12:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WD-0001Ad-57; Sun, 25 Oct 2026 12:56:25 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WA-0004c2-Rv; Sun, 25 Oct 2026 12:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=u7jkhVLvKl3MaqD2ZjOJldHYiiER+PHwFLp83P0JAU8=; b=cRe2a0nApxYl6ijOWFDebAUVLB
 f5NLFAhdJm9Fp3z8Qk9v43WW1I06nYv7fCUgKvJGqGUWhroKDB2VpYiPVLsuw+mw0mI6795ZVV7vV
 Or5rVV0fmm9oKYO8o1YF1mZZZQ039V+VJDgtEbFnPmEvdAbcg+FN9G4+0y7eK7cfRm0LSdK9x+XzB
 d0QXo18PzZlnBItcl5LbJRr9/J0qPFjy00i/kEUssNPLgsN5U4i1bdJNVi72UBFHsb/sIZwwOZUT3
 jzTQTZ8+sQlhQwkMe/gnzyM3ekqP2AGrkXtWVLfcyKmJNtufM+ZC0ruKOsfsb4LMRX49qJETWYG0z
 khuhC9fQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kN-02; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-0k; Sun, 25 Oct 2026 17:56:06 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:17 +0100
Subject: [PATCH v2 01/31] target/rx: add RXv2/RXv3 CPU models
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-1-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=4676;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=KdRxrHcEE79GpMsT5kVGShiEWhqjMDXCSTA3lZbClzs=;
 b=HxWbq0FHjfLIDSoWnlMwgDVXjWpcE6fmJ9jbzPVUG/Q7h6hNthmZJ3YUP8jxkrRaohp+guP4e
 pMw64j3SL7QBGa6zix/hWEjsMQukxkSi4dBT9hjTzbVSAHI5k3fVop+
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add RX65N (RXv2) and RX72M (RXv3) CPU models, and record the ISA
revision each model implements in RXCPUClass so the translator can
gate instructions introduced in later revisions.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/cpu-qom.h   |  2 ++
 target/rx/cpu.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 target/rx/cpu.h       | 20 ++++++++++++++++++++
 target/rx/translate.c |  2 ++
 4 files changed, 65 insertions(+)

diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index ac2e5785ef..a0b5f35015 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -24,6 +24,8 @@
 #define TYPE_RX_CPU "rx-cpu"
 
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
+#define TYPE_RX65N_CPU RX_CPU_TYPE_NAME("rx65n")
+#define TYPE_RX72M_CPU RX_CPU_TYPE_NAME("rx72m")
 
 OBJECT_DECLARE_CPU_TYPE(RXCPU, RXCPUClass, RX_CPU)
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c35a98f7ce..df0530c7bd 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -256,6 +256,32 @@ static void rx_cpu_class_init(ObjectClass *klass, const void *data)
 
     cc->gdb_core_xml_file = "rx-core.xml";
     cc->tcg_ops = &rx_tcg_ops;
+
+    /*
+     * Base of the hierarchy: the abstract type is never instantiated, so
+     * this only provides a conservative default for models that forget to
+     * declare their revision.
+     */
+    rcc->isa_version = RX_ISA_V1;
+}
+
+static void rx62n_cpu_class_init(ObjectClass *klass, const void *data)
+{
+    RX_CPU_CLASS(klass)->isa_version = RX_ISA_V1;
+}
+
+static void rx65n_cpu_class_init(ObjectClass *klass, const void *data)
+{
+    RX_CPU_CLASS(klass)->isa_version = RX_ISA_V2;
+}
+
+static void rx72m_cpu_class_init(ObjectClass *klass, const void *data)
+{
+    RXCPUClass *rcc = RX_CPU_CLASS(klass);
+
+    rcc->isa_version = RX_ISA_V3;
+    /* RX72M provides 16 save register banks, selected by bank numbers 0-15. */
+    rcc->num_save_banks = 16;
 }
 
 static const TypeInfo rx_cpu_info = {
@@ -272,12 +298,27 @@ static const TypeInfo rx_cpu_info = {
 static const TypeInfo rx62n_rx_cpu_info = {
     .name = TYPE_RX62N_CPU,
     .parent = TYPE_RX_CPU,
+    .class_init = rx62n_cpu_class_init,
+};
+
+static const TypeInfo rx65n_rx_cpu_info = {
+    .name = TYPE_RX65N_CPU,
+    .parent = TYPE_RX_CPU,
+    .class_init = rx65n_cpu_class_init,
+};
+
+static const TypeInfo rx72m_rx_cpu_info = {
+    .name = TYPE_RX72M_CPU,
+    .parent = TYPE_RX_CPU,
+    .class_init = rx72m_cpu_class_init,
 };
 
 static void rx_cpu_register_types(void)
 {
     type_register_static(&rx_cpu_info);
     type_register_static(&rx62n_rx_cpu_info);
+    type_register_static(&rx65n_rx_cpu_info);
+    type_register_static(&rx72m_rx_cpu_info);
 }
 
 type_init(rx_cpu_register_types)
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 0c749fc58d..1f81619ffa 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -84,6 +84,17 @@ enum {
 
 #define RX_EXCP_COUNT   (RX_EXCP_TRAP_BASE + RX_EXCP_TRAP_COUNT)
 
+/*
+ * Instruction set architecture revision implemented by a CPU model.
+ * Later revisions are supersets of earlier ones, so instruction gating is a
+ * simple >= comparison.
+ */
+typedef enum RXISAVersion {
+    RX_ISA_V1 = 1,
+    RX_ISA_V2 = 2,
+    RX_ISA_V3 = 3,
+} RXISAVersion;
+
 typedef struct CPUArchState {
     /* CPU registers */
     uint32_t regs[NUM_REGS];    /* general registers */
@@ -142,6 +153,15 @@ struct RXCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+
+    /* Instruction set revision this model implements. */
+    RXISAVersion isa_version;
+
+    /*
+     * Number of save register banks reachable by SAVE/RSTR, or 0 on models
+     * without the register bank save function.
+     */
+    uint32_t num_save_banks;
 };
 
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
diff --git a/target/rx/translate.c b/target/rx/translate.c
index a350f6b4d2..91b033c3c2 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -37,6 +37,7 @@ typedef struct DisasContext {
     CPURXState *env;
     uint32_t pc;
     uint32_t tb_flags;
+    RXISAVersion isa_version;
 } DisasContext;
 
 typedef struct DisasCompare {
@@ -2206,6 +2207,7 @@ static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     ctx->env = cpu_env(cs);
     ctx->tb_flags = ctx->base.tb->flags;
+    ctx->isa_version = RX_CPU_GET_CLASS(cs)->isa_version;
 }
 
 static void rx_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)

-- 
2.53.0


