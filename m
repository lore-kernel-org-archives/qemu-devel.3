Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE7606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL22v-0008GI-QO; Sun, 25 Oct 2026 13:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22k-0008D6-1j; Sun, 25 Oct 2026 13:30:04 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22h-00070Z-VX; Sun, 25 Oct 2026 13:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eoSGlRI6QnxEjFBlNl7mQ5JMdFgVNNFKt4Fx6vMGRTE=; b=ceJ7CUsgjCgic/BY4U0BqMXngo
 cNKEDW+L0NIBThq/or4UxYdopMGeDCcop1kdNBIPktW4w+1Q3s4jfYHNG1CTtEu7HUkxO4KLuexHf
 04iwP1QFbWK6BRwibcGkDyOrbCGXQTmpoBeO4vNuE3tquZIyFhz+U5kGsXK2uiydA3MJlPvFg+WU/
 V0BEQdlVqaWvl7/x+i4eTkK9okfRrdWxWMzNPGkZ2nCmTzZD+pM9FcgQEUmjR23D6vRhKHgNfu6Kb
 K8liTq89k2mW8/jBLk8eZKD0lQspluS9B/e+M/2Y+VPRUZ4cenYclIc3sFSdqnasz5O2MvMXF+Xl5
 piEcePcw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gQ-000985-1O; Sun, 25 Oct 2026 18:06:58 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-0U; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:30 +0100
Subject: [PATCH v2 14/31] target/rx: add RXv3 DMOV.D memory forms
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-14-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5430;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=+eL1uk9DE6Tu7ZrsMwQLngcFL/6W69z5Bv/25M9tB2Q=;
 b=w5hgKHIzwR26ZZ9awhVUC+iCmSXm/1/xz+P6coKNoL2lJxECbtluYLXuxcd0tP5x7ZHVe5rLS
 PMedx2xzBPRDt38sBsabFDZ1FRR3KKGKZ4MaT6NF6CLrdAhTjE4O6Xm
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

Add DMOV.D DRs,dsp[Rd] and DMOV.D dsp[Rs],DRd. The DR operand sits in
a trailing post-byte that follows the displacement, so it is read
during translation rather than by decodetree. Per the RXv3 manual the
.D displacement is scaled by 4, not by the 8-byte transfer size.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/insns.decode |  8 +++++++
 target/rx/translate.c  | 50 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index fba5d2ea57..e9e504fc9b 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1410,6 +1410,65 @@ static bool trans_DMOVD_irh(DisasContext *ctx, arg_DMOVD_irh *a)
     return true;
 }
 
+/* Fetch n more instruction bytes into the dump buffer and return them. */
+static uint32_t disas_fetch(DisasContext *ctx, int n)
+{
+    uint32_t addr = ctx->addr;
+    uintptr_t len = ctx->len;
+    uint32_t val = 0;
+    int i;
+
+    g_assert(len + n <= ARRAY_SIZE(ctx->bytes));
+    ctx->addr += n;
+    ctx->len += n;
+    ctx->dis->read_memory_func(addr, ctx->bytes + len, n, ctx->dis);
+    for (i = n - 1; i >= 0; i--) {
+        val = (val << 8) | ctx->bytes[len + i];
+    }
+    return val;
+}
+
+/*
+ * DMOV.D displacements are scaled by 4 (see the note in translate.c), which
+ * rx_index_addr() cannot express, so decode them here.
+ */
+static void dmov_index_addr(DisasContext *ctx, char out[12], int ld)
+{
+    if (ld == 0) {
+        out[0] = '\0';
+        return;
+    }
+    snprintf(out, 12, "%u", disas_fetch(ctx, ld) << 2);
+}
+
+/* The DR operand of the DMOV.D memory forms sits in a trailing post-byte. */
+static int dmov_postbyte(DisasContext *ctx)
+{
+    return disas_fetch(ctx, 1) >> 4;
+}
+
+static bool trans_DMOV_mst(DisasContext *ctx, arg_DMOV_mst *a)
+{
+    char dsp[12];
+    int dr;
+
+    dmov_index_addr(ctx, dsp, a->ld);
+    dr = dmov_postbyte(ctx);
+    prt("dmov.d\tdr%d, %s[r%d]", dr, dsp, a->rd);
+    return true;
+}
+
+static bool trans_DMOV_mld(DisasContext *ctx, arg_DMOV_mld *a)
+{
+    char dsp[12];
+    int dr;
+
+    dmov_index_addr(ctx, dsp, a->ld);
+    dr = dmov_postbyte(ctx);
+    prt("dmov.d\t%s[r%d], dr%d", dsp, a->rs, dr);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index d60d97b682..e2a3c5601a 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -42,6 +42,8 @@
 &rdcr		rd dcrs
 &dcrr		dcrd rs
 &dmovi		drd imm
+&dmovst		rd ld
+&dmovld		rs ld
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -705,3 +707,9 @@ DMOV_drhr	1111 1101 0111 0101 1000 rd:4 drs:4 0010	&rdrh
 MVFDC		1111 1101 0111 0101 1000 rd:4 dcrs:4 0100	&rdcr
 MVTDC		1111 1101 0111 0111 1000 rs:4 dcrd:4 0100	&dcrr
 MVFDR		0111 0101 1001 0000 0001 1011
+
+# DMOV.D DRs, dsp[Rd] / DMOV.D dsp[Rs], DRd.
+# The DR register is supplied by a trailing post-byte that follows the
+# displacement, so it is read during translation rather than by decodetree.
+DMOV_mst	1111 1100 0111 10 ld:2 rd:4 1000		&dmovst
+DMOV_mld	1111 1100 1100 10 ld:2 rs:4 1000		&dmovld
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9c26f5608e..f16fc8fb6c 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2391,6 +2391,56 @@ static bool trans_DMOVD_irh(DisasContext *ctx, arg_DMOVD_irh *a)
     return true;
 }
 
+/*
+ * The DMOV.D memory forms name their DR operand in a post-byte that follows
+ * the displacement, so it can only be read once rx_index_addr() has consumed
+ * the displacement bytes.
+ *
+ * Per the RXv3 ISA manual the .D displacement is scaled by 4, not by the
+ * 8-byte transfer size: dsp:8 reaches 1020 (255 * 4) and dsp:16 reaches
+ * 262140 (65535 * 4). Note that binutils gas disagrees, scaling by 8 and
+ * requiring 8-byte alignment; the manual is taken as authoritative here.
+ */
+#define DMOV_DSP_SHIFT 2
+static int dmov_postbyte_dr(DisasContext *ctx)
+{
+    uint8_t b = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next);
+    ctx->base.pc_next += 1;
+    return b >> 4;
+}
+
+/* dmov.d DRs, dsp[rd] */
+static bool trans_DMOV_mst(DisasContext *ctx, arg_DMOV_mst *a)
+{
+    TCGv_i32 mem, addr;
+    int drs;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    mem = tcg_temp_new_i32();
+    addr = rx_index_addr(ctx, mem, a->ld, DMOV_DSP_SHIFT, a->rd);
+    drs = dmov_postbyte_dr(ctx);
+    tcg_gen_qemu_st_i64(cpu_dregs[drs], addr, 0, MO_LEUQ);
+    return true;
+}
+
+/* dmov.d dsp[rs], DRd */
+static bool trans_DMOV_mld(DisasContext *ctx, arg_DMOV_mld *a)
+{
+    TCGv_i32 mem, addr;
+    int drd;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    mem = tcg_temp_new_i32();
+    addr = rx_index_addr(ctx, mem, a->ld, DMOV_DSP_SHIFT, a->rs);
+    drd = dmov_postbyte_dr(ctx);
+    tcg_gen_qemu_ld_i64(cpu_dregs[drd], addr, 0, MO_LEUQ);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


