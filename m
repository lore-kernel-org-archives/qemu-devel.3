Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B124606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL265-00039X-44; Sun, 25 Oct 2026 13:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24z-00028T-R8; Sun, 25 Oct 2026 13:32:24 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24w-0007NF-7k; Sun, 25 Oct 2026 13:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2E+rxwzCduPzj7RvM3IYiFPHjwY95ZIOvpI5cO6Hmlc=; b=sH8aVunCCkS9UGO28u+U0RWZ1J
 rrKTJCGqSaAPpI1PAjlHSjZSJ25NKLjKa9FIUd+eUpXppBM+LS5Kgl5L4u7v+wxftfDPs/Nw+JSh3
 om/cM1a+TqTdWoOIMYiB/9blJ7t0dSZWY+vDOkFe3wZBmQSl4jOOw7Hw2OGkQulmM0igLJ2sMCtiY
 aa3OD7rPJPUY9/43+yZr/1xNOSoD2fFCByccHFWqyyAdodWarGBvbzQB+4nQW3C/9tvL09ag4FjrS
 E07dfrQ9BviL8ObePUxI1KDaAUnnSBGIMWLhAN5xiRjimE6F3LuLocuXkXl96NJ7X8UDeFfwjlZsC
 8uAtrjmw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gV-0009BS-08; Sun, 25 Oct 2026 18:07:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-0G; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:29 +0100
Subject: [PATCH v2 13/31] target/rx: add RXv3 DMOV immediate forms
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-13-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=3769;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=PIY+yOxwXLZgDOHlntpYhG9VoAdjOA4cL++gRmyDKT0=;
 b=qHfzvt+sa3+k57UcuBGxjatV/z2fqa37zQSRR4Bq5xNcyv1X3SAkfDn9zcSGlWaI5wZm/NnqP
 zv7YI0F5K8aBKluq730Wulfoar58ag2sZa3drfbS7tzGqXRYEDBRLxR
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

Add DMOV.L #imm32,DRLd / DMOV.L #imm32,DRHd / DMOV.D #imm32,DRHd.
They reuse the MOV.<bwl> #imm,dsp8[rd] opcode with rd=0 and sz=3,
an encoding MOV never produces, so they are matched ahead of it in
the decode tree.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 24 ++++++++++++++++++++++++
 target/rx/insns.decode | 11 ++++++++++-
 target/rx/translate.c  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 062d8c2d6b..fba5d2ea57 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1386,6 +1386,30 @@ static bool trans_MVFDR(DisasContext *ctx, arg_MVFDR *a)
     return true;
 }
 
+static bool trans_DMOVL_irl(DisasContext *ctx, arg_DMOVL_irl *a)
+{
+    uint32_t imm = li(ctx, 0);
+
+    prt("dmov.l\t#0x%08x, drl%d", imm, a->drd);
+    return true;
+}
+
+static bool trans_DMOVL_irh(DisasContext *ctx, arg_DMOVL_irh *a)
+{
+    uint32_t imm = li(ctx, 0);
+
+    prt("dmov.l\t#0x%08x, drh%d", imm, a->drd);
+    return true;
+}
+
+static bool trans_DMOVD_irh(DisasContext *ctx, arg_DMOVD_irh *a)
+{
+    uint32_t imm = li(ctx, 0);
+
+    prt("dmov.d\t#0x%08x, drh%d", imm, a->drd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index b3406f1cbf..d60d97b682 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -41,6 +41,7 @@
 &drhr		drd rs
 &rdcr		rd dcrs
 &dcrr		dcrd rs
+&dmovi		drd imm
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -368,7 +369,15 @@ MOV_ir		1111 1011 rd:4 .. 10			imm=%b2_li_2
 # MOV.<bwl> #imm, [rd]
 MOV_im		1111 1000 rd:4 .. sz:2			dsp=0 imm=%b2_li_2
 # MOV.<bwl> #imm, dsp8[rd]
-MOV_im		1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10
+# The RXv3 DMOV immediate forms reuse this opcode with rd=0 and li/sz=0011,
+# an encoding MOV.<bwl> never produces (sz=3 is not a valid transfer size),
+# so they have to be matched ahead of it.
+{
+  DMOVL_irl	1111 1001 0000 0011 drd:4 0000		&dmovi imm=0
+  DMOVL_irh	1111 1001 0000 0011 drd:4 0010		&dmovi imm=0
+  DMOVD_irh	1111 1001 0000 0011 drd:4 0011		&dmovi imm=0
+  MOV_im	1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10
+}
 # MOV.<bwl> #imm, dsp16[rd]
 MOV_im		1111 1010 rd:4 .. sz:2 .... .... .... .... \
 		imm=%b4_li_18 dsp=%b4_dsp_16
diff --git a/target/rx/translate.c b/target/rx/translate.c
index ad59fe2861..9c26f5608e 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2361,6 +2361,36 @@ static bool trans_MVFDR(DisasContext *ctx, arg_MVFDR *a)
     return true;
 }
 
+/* dmov.l #imm32, DRLd */
+static bool trans_DMOVL_irl(DisasContext *ctx, arg_DMOVL_irl *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drl_write(a->drd, tcg_constant_i32(li(ctx, 0)));
+    return true;
+}
+
+/* dmov.l #imm32, DRHd */
+static bool trans_DMOVL_irh(DisasContext *ctx, arg_DMOVL_irh *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drh_write(a->drd, tcg_constant_i32(li(ctx, 0)));
+    return true;
+}
+
+/* dmov.d #imm32, DRHd -- set the high half, clear the low half */
+static bool trans_DMOVD_irh(DisasContext *ctx, arg_DMOVD_irh *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_movi_i64(cpu_dregs[a->drd], (uint64_t)li(ctx, 0) << 32);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


