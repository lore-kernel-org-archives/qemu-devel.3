Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0269606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL24d-0001eJ-K9; Sun, 25 Oct 2026 13:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL247-0000zW-QR; Sun, 25 Oct 2026 13:31:32 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL244-0007Jt-Kn; Sun, 25 Oct 2026 13:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5lAUCxqfG8sM6pOnbDX8sosTn48tzyKLtxywQ8LbM24=; b=qpersZEHRvUV9jM1xJzaiUMuHi
 CiL/qfcCM5FKOv5Rfp1Xlw6n435igvmrIRVyQ8CRouqu8O2pTN2K9gtz+Jd0+4O+qe49WyDZgp96W
 2z8IFOsI0xaUAN+Fh2/rm2DVb8YL757VmgNqjEdkMXkGf1SuPTPry1ZcqjzOz89oTbmZjJc/lIAzK
 0OrukJ6ypqXXOPRZEQMfwbkhB4rd9C/FCu1G+xmCMh+JgT80VTpQRpXY0NjmqUuvZHchoxydwpMoq
 2iDXPLUyco/QILEXVFETOAXtNnb/XGg1JTVYxYK8xaw1rpTl296Bl9oWeyb4eaHeHGWVsBxF9Msuw
 tqTHvAeA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1fa-0008yR-1K; Sun, 25 Oct 2026 18:06:06 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-2p; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:26 +0100
Subject: [PATCH v2 10/31] target/rx: add DPUSHM and DPOPM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-10-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5451;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=Wr9yanjeQH4HzJhPTxohXUfqcGg2ndZ7wmxp4QcEUFk=;
 b=yNN1oCQLIg3maC97yJlXSkVkFfvA+LDJpaF+oxgfYDbJn1sgKIw7N6C3NzDDTiZd5+AvLehrx
 XL1zpd6Go7MD3U6vs0g2QXLtI19dOvzpoTQ868QKqGJSdObaDV6k/F5
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

DPUSHM/DPOPM push and pop a range of DR registers onto the stack;
the .L forms do the same for the DPFPU control registers. The encoded
rnum field holds (last - first), so the range covers rnum + 1
registers; pushes run from the highest register down so the lowest
ends up at the lowest address.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 29 +++++++++++++++++++
 target/rx/insns.decode |  9 ++++++
 target/rx/translate.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 85de0a0f09..5a0d7180b5 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1309,6 +1309,35 @@ static bool trans_FTOD(DisasContext *ctx, arg_FTOD *a)
     return true;
 }
 
+static bool trans_DPUSHM(DisasContext *ctx, arg_DPUSHM *a)
+{
+    prt("dpushm.d\tdr%d-dr%d", a->drd, a->drd + a->rnum);
+    return true;
+}
+
+static bool trans_DPOPM(DisasContext *ctx, arg_DPOPM *a)
+{
+    prt("dpopm.d\tdr%d-dr%d", a->drd, a->drd + a->rnum);
+    return true;
+}
+
+/* RXv3 disassembly: remaining DPFPU, bit field and register bank ops */
+static const char dcrname[][6] = { "dpsw", "dcmr", "decnt", "depc" };
+
+static bool trans_DPUSHM_l(DisasContext *ctx, arg_DPUSHM_l *a)
+{
+    prt("dpushm.l\t%s-%s", dcrname[a->dcrd & 3],
+        dcrname[(a->dcrd + a->rnum) & 3]);
+    return true;
+}
+
+static bool trans_DPOPM_l(DisasContext *ctx, arg_DPOPM_l *a)
+{
+    prt("dpopm.l\t%s-%s", dcrname[a->dcrd & 3],
+        dcrname[(a->dcrd + a->rnum) & 3]);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 58f8aa6dfd..48325d7ebd 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -34,6 +34,8 @@
 &drrr		drd drs1 drs2
 &dcmpd		drs1 drs2 cd
 &idr		rs drd
+&dppm		drd rnum
+&dcppm		dcrd rnum
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -665,3 +667,10 @@ DTOF		0111 0110 1001 0000 drs:4 1101 drd:4 1100	&drr
 ITOD		1111 1101 0111 0111 1000 rs:4 drd:4 1001	&idr
 FTOD		1111 1101 0111 0111 1000 rs:4 drd:4 1010	&idr
 UTOD		1111 1101 0111 0111 1000 rs:4 drd:4 1101	&idr
+
+# DPUSHM.D/DPOPM.D: push/pop range of DR registers (3-byte: 0x75 prefix)
+DPUSHM		0111 0101 1011 0000 drd:4 rnum:4		&dppm
+DPOPM		0111 0101 1011 1000 drd:4 rnum:4		&dppm
+# DPUSHM.L/DPOPM.L: same, for the DPFPU control registers
+DPUSHM_l	0111 0101 1010 0000 dcrd:4 rnum:4		&dcppm
+DPOPM_l		0111 0101 1010 1000 dcrd:4 rnum:4		&dcppm
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 0bef8f36f8..33e41ccab3 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2175,6 +2175,81 @@ static bool trans_FTOD(DisasContext *ctx, arg_FTOD *a)
     return true;
 }
 
+/*
+ * dpushm.d DRn-DRm / dpopm.d DRn-DRm.
+ * The encoded rnum field holds (last - first), so the range covers
+ * rnum + 1 registers. Pushes run from the highest register down so that
+ * the lowest-numbered register ends up at the lowest address.
+ */
+static bool trans_DPUSHM(DisasContext *ctx, arg_DPUSHM *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->drd + a->rnum; i >= a->drd; i--) {
+        TCGv_i32 hi = tcg_temp_new_i32();
+        TCGv_i32 lo = tcg_temp_new_i32();
+        tcg_gen_extr_i64_i32(lo, hi, cpu_dregs[i & (NUM_DREGS - 1)]);
+        tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_st(ctx, MO_32, hi, cpu_sp);
+        tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_st(ctx, MO_32, lo, cpu_sp);
+    }
+    return true;
+}
+
+static bool trans_DPOPM(DisasContext *ctx, arg_DPOPM *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->drd; i <= a->drd + a->rnum; i++) {
+        TCGv_i64 dr = tcg_temp_new_i64();
+        TCGv_i32 hi = tcg_temp_new_i32();
+        TCGv_i32 lo = tcg_temp_new_i32();
+        rx_gen_ld(ctx, MO_32, lo, cpu_sp);
+        tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_ld(ctx, MO_32, hi, cpu_sp);
+        tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+        tcg_gen_concat_i32_i64(dr, lo, hi);
+        tcg_gen_mov_i64(cpu_dregs[i & (NUM_DREGS - 1)], dr);
+    }
+    return true;
+}
+
+/* dpushm.l DCRn-DCRm / dpopm.l DCRn-DCRm (DPFPU control registers) */
+static bool trans_DPUSHM_l(DisasContext *ctx, arg_DPUSHM_l *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->dcrd + a->rnum; i >= a->dcrd; i--) {
+        tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_st(ctx, MO_32, cpu_dcregs[i & (NUM_DCREGS - 1)], cpu_sp);
+    }
+    return true;
+}
+
+static bool trans_DPOPM_l(DisasContext *ctx, arg_DPOPM_l *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->dcrd; i <= a->dcrd + a->rnum; i++) {
+        rx_gen_ld(ctx, MO_32, cpu_dcregs[i & (NUM_DCREGS - 1)], cpu_sp);
+        tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+    }
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


