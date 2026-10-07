Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D69CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENw6-0003Jt-7z; Wed, 07 Oct 2026 05:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAP-0004Ms-2r; Wed, 07 Oct 2026 04:38:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAN-0006YZ-Iy; Wed, 07 Oct 2026 04:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ODZYs0CKmBfvSwkKqkAWWVRvX7trmNcIsX9bhJq269o=; b=SMn+ls8R3bq1Aa2
 +ybBUAlyl/Lk26LIuuCj0LxxEFjBFhRHHNaslAWtHkoyGY+HvOBts+n1cLs8I3t+juW6XQljB8SiT
 D/8SCxm5PeZ4IXBe9MpoBFqMwds11jiM++ciy1Ah7GSsirkt2zr0hb5JxP5ztcTR8l7oL8uWiaonD
 As=;
Date: Wed, 07 Oct 2026 10:43:20 +0200
Subject: [PATCH v2 14/18] target/riscv: Compile pmp.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=1840;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=IWK5oqCYxk+0/V5SJ06uaGRRZer/zDkVjL9V8CYZvLg=;
 b=G/EEb+jVCYwDkE/0wAfMeDLEQCG/fCEVEmzrxgS9TkR/weOcvGdiCYOQN1i/wRd9QrcORJ4ks
 x2ROOdW/I+vAq5mk6BCDEszaiuHCoiryntmhSmSIlqGJNM5lbloXOFc
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/pmp.c       | 5 +++--
 target/riscv/tcg/meson.build | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 99345d63dc..2d7194de10 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -638,19 +638,20 @@ uint64_t pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
     if (addr_index < pmp_regions) {
         val = env->pmp_state.pmp[addr_index].addr_reg;
         int g = pmp_get_granularity_g(env);
+        const unsigned long_bits = target_long_bits();
         switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
         case PMP_AMATCH_OFF:
             /* fallthrough */
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
-            if (g >= 1 && g < TARGET_LONG_BITS) {
+            if (g >= 1 && g < long_bits) {
                 uint64_t granule = 1ULL << g;
                 val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
             /* Bit [g-2:0] read all one */
-            if (g >= 2 && g < TARGET_LONG_BITS) {
+            if (g >= 2 && g < long_bits) {
                 val = deposit64(val, 0, g - 1, -1ULL);
             }
             break;
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 69dadfd662..0aaba9cf34 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -17,7 +17,6 @@ riscv_ss.add(files(
 
 riscv_system_ss.add(files(
   'debug.c',
-  'pmp.c',
 ))
 
 
@@ -35,4 +34,5 @@ riscv_common_system_ss.add(files(
   'pmu.c',
   'tcg-cpu.c',
   'th_csr.c',
+  'pmp.c',
 ))

-- 
2.52.0


