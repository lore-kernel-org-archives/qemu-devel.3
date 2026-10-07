Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C0ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwU-00045T-T8; Wed, 07 Oct 2026 05:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAN-0004BZ-IZ; Wed, 07 Oct 2026 04:38:23 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAL-0006Y4-UN; Wed, 07 Oct 2026 04:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=4+HdR4WrzU5YXVMzxOKNC182txQYdH17P+SAjAFj/gE=; b=IYCvPeAkGasXqUA
 kwrRZyq4eaRAHwroK4bRI802HxXwAUZfgEPkAj7HoNklBjEDpHvaa4/X+BEvv405J9gVSusEdkuBG
 PeKG6GFdNFyxBXoKWDYKJat8eJQz4yLokZUyJsElLD3Sj92+lU6lGh7hzprkXF7cA7zZ8TGaDlAkv
 Go=;
Date: Wed, 07 Oct 2026 10:43:18 +0200
Subject: [PATCH v2 12/18] target/riscv: Compile tcg-cpu.c once for system-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-12-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=2625;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=UtqYIrqBHsTw+J9UsN1S7re1+QqHnWX2oAHps/xEJX8=;
 b=x+jFhrKoFkHEGRddj52oA34jTDa7C+CR15NHde2dpXYkMTraXnciWlSTOs25dGi2Zkhf90JPs
 0LTkWt/czN7BOIXmzOfIARHnfU/h9aVfjNPveflOVAzIZy1TfgGiAC2
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remaining target_ulongs are replaced by their corresponding type in
CPUArchState.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/tcg-cpu.c   | 8 ++++----
 target/riscv/tcg/meson.build | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b68160af83..91b2e128ea 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -229,7 +229,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
-    target_ulong pc;
+    uint64_t pc;
 
     if (tb_cflags(tb) & CF_PCREL) {
         pc = (env->pc & TARGET_PAGE_MASK) | data[0];
@@ -1336,7 +1336,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 }
 
 typedef struct RISCVCPUMisaExtConfig {
-    target_ulong misa_bit;
+    uint32_t misa_bit;
     bool enabled;
 } RISCVCPUMisaExtConfig;
 
@@ -1344,7 +1344,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
-    target_ulong misa_bit = misa_ext_cfg->misa_bit;
+    uint32_t misa_bit = misa_ext_cfg->misa_bit;
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
     bool vendor_cpu = riscv_cpu_is_vendor(obj);
@@ -1386,7 +1386,7 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
-    target_ulong misa_bit = misa_ext_cfg->misa_bit;
+    uint32_t misa_bit = misa_ext_cfg->misa_bit;
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
     bool value;
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index cc50f3764c..69dadfd662 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -9,7 +9,6 @@ riscv_ss.add(files(
   'm128_helper.c',
   'op_helper.c',
   'translate.c',
-  'tcg-cpu.c',
   'vcrypto_helper.c',
   'vector_helper.c',
   'vector_internals.c',
@@ -25,6 +24,7 @@ riscv_system_ss.add(files(
 riscv_user_ss.add(files(
   'cpu_helper.c',
   'csr.c',
+  'tcg-cpu.c',
 ))
 
 
@@ -33,5 +33,6 @@ riscv_common_system_ss.add(files(
   'csr.c',
   'mips_csr.c',
   'pmu.c',
+  'tcg-cpu.c',
   'th_csr.c',
 ))

-- 
2.52.0


