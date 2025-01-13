Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC8C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 08:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFmd-0002zh-J6; Mon, 13 Jan 2025 03:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tXFly-0002OK-BY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:26:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tXFlu-0002Sn-Ef
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:26:10 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxDeMXzoRnY2tiAA--.720S3;
 Mon, 13 Jan 2025 16:25:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx78cVzoRngBAgAA--.63355S4;
 Mon, 13 Jan 2025 16:25:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/loongarch: Remove static CSR function setting
Date: Mon, 13 Jan 2025 16:25:54 +0800
Message-Id: <20250113082557.2926009-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250113082557.2926009-1-maobibo@loongson.cn>
References: <20250113082557.2926009-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx78cVzoRngBAgAA--.63355S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Since CSR function setting is done dynamically in TCG mode, remove
static CSR function setting here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index a864a45550..2dfba3af76 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -82,7 +82,7 @@ static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
     CSR_OFF_FLAGS(MISC, CSRFL_READONLY),
     CSR_OFF(ECFG),
-    CSR_OFF_FUNCS(ESTAT, CSRFL_EXITTB, NULL, gen_helper_csrwr_estat),
+    CSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
     CSR_OFF(ERA),
     CSR_OFF(BADV),
     CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
@@ -91,15 +91,15 @@ static CSRInfo csr_info[] = {
     CSR_OFF(TLBEHI),
     CSR_OFF(TLBELO0),
     CSR_OFF(TLBELO1),
-    CSR_OFF_FUNCS(ASID, CSRFL_EXITTB, NULL, gen_helper_csrwr_asid),
+    CSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
     CSR_OFF(PGDL),
     CSR_OFF(PGDH),
-    CSR_OFF_FUNCS(PGD, CSRFL_READONLY, gen_helper_csrrd_pgd, NULL),
-    CSR_OFF_FUNCS(PWCL, 0, NULL, gen_helper_csrwr_pwcl),
+    CSR_OFF_FLAGS(PGD, CSRFL_READONLY),
+    CSR_OFF(PWCL),
     CSR_OFF(PWCH),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
-    CSR_OFF_FUNCS(CPUID, CSRFL_READONLY, gen_helper_csrrd_cpuid, NULL),
+    CSR_OFF_FLAGS(CPUID, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
@@ -120,10 +120,10 @@ static CSRInfo csr_info[] = {
     CSR_OFF_ARRAY(SAVE, 14),
     CSR_OFF_ARRAY(SAVE, 15),
     CSR_OFF(TID),
-    CSR_OFF_FUNCS(TCFG, CSRFL_IO, NULL, gen_helper_csrwr_tcfg),
-    CSR_OFF_FUNCS(TVAL, CSRFL_READONLY | CSRFL_IO, gen_helper_csrrd_tval, NULL),
+    CSR_OFF_FLAGS(TCFG, CSRFL_IO),
+    CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
     CSR_OFF(CNTC),
-    CSR_OFF_FUNCS(TICLR, CSRFL_IO, NULL, gen_helper_csrwr_ticlr),
+    CSR_OFF_FLAGS(TICLR, CSRFL_IO),
     CSR_OFF(LLBCTL),
     CSR_OFF(IMPCTL1),
     CSR_OFF(IMPCTL2),
-- 
2.39.3


