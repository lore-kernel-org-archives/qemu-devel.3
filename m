Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB0606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTfn-0003wV-Ag; Thu, 26 Nov 2026 02:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfk-0003vC-0w
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfh-0003DB-Az
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:35 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxntAZ3Adr6iojAA--.6891S3;
 Thu, 26 Nov 2026 15:13:29 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxPs8V3AdruH03AA--.43941S4;
 Thu, 26 Nov 2026 15:13:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 10/18] target/loongarch: Add CSRFL_WIDTH64 flag for some
 CSR registers
Date: Thu, 26 Nov 2026 15:14:32 +0800
Message-ID: <20261126071440.3293877-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs8V3AdruH03AA--.43941S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw17CFyrXr43XFWUZFyfXwc_yoWxWF1rpF
 4UWrWDK3yrXrn3Xryjvayak3W5Wr4Fg3y3tw48Ary8JFy8Gr1Fgry5KayYgrZ3JryrXrWU
 ZF12vr18JFsrGrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UPPERCASE_75_100,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On LoongArch, some CSR registers are defined as 32-bit, while others
are defined with the same width as the word size. For a 32-bit CSR
register, the result is sign-extended and written to the destination
general-purpose register.

Add a CSRFL_WIDTH64 flag to mark CSR registers that are word-sized,
otherwise they are 32-bit.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/csr.c | 122 +++++++++++++++++++++--------------------
 target/loongarch/csr.h |   1 +
 2 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 207d00e78e..d93eefd1d7 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -21,7 +21,9 @@
     }
 
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
+#define CSR_OFF64(NAME)           CSR_OFF_FLAGS(NAME, CSRFL_WIDTH64)
 #define CSR_OFF_ARRAY(NAME, N)    CSR_OFF_ARRAY_FLAGS(NAME, N, CSRFL_BASIC)
+#define CSR_OFF_ARRAY64(NAME, N)  CSR_OFF_ARRAY_FLAGS(NAME, N, CSRFL_WIDTH64)
 
 static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -30,98 +32,98 @@ static CSRInfo csr_info[] = {
     CSR_OFF(MISC),
     CSR_OFF(ECFG),
     CSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
-    CSR_OFF(ERA),
-    CSR_OFF(BADV),
+    CSR_OFF64(ERA),
+    CSR_OFF64(BADV),
     CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
-    CSR_OFF(EENTRY),
+    CSR_OFF64(EENTRY),
     CSR_OFF(TLBIDX),
-    CSR_OFF(TLBEHI),
-    CSR_OFF(TLBELO0),
-    CSR_OFF(TLBELO1),
+    CSR_OFF64(TLBEHI),
+    CSR_OFF64(TLBELO0),
+    CSR_OFF64(TLBELO1),
     CSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
-    CSR_OFF(PGDL),
-    CSR_OFF(PGDH),
-    CSR_OFF_FLAGS(PGD, CSRFL_READONLY),
+    CSR_OFF64(PGDL),
+    CSR_OFF64(PGDH),
+    CSR_OFF_FLAGS(PGD, CSRFL_READONLY | CSRFL_WIDTH64),
     CSR_OFF(PWCL),
     CSR_OFF(PWCH),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
     CSR_OFF_FLAGS(CPUID, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
-    CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
+    CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY | CSRFL_WIDTH64),
     CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
-    CSR_OFF_ARRAY(SAVE, 0),
-    CSR_OFF_ARRAY(SAVE, 1),
-    CSR_OFF_ARRAY(SAVE, 2),
-    CSR_OFF_ARRAY(SAVE, 3),
-    CSR_OFF_ARRAY(SAVE, 4),
-    CSR_OFF_ARRAY(SAVE, 5),
-    CSR_OFF_ARRAY(SAVE, 6),
-    CSR_OFF_ARRAY(SAVE, 7),
-    CSR_OFF_ARRAY(SAVE, 8),
-    CSR_OFF_ARRAY(SAVE, 9),
-    CSR_OFF_ARRAY(SAVE, 10),
-    CSR_OFF_ARRAY(SAVE, 11),
-    CSR_OFF_ARRAY(SAVE, 12),
-    CSR_OFF_ARRAY(SAVE, 13),
-    CSR_OFF_ARRAY(SAVE, 14),
-    CSR_OFF_ARRAY(SAVE, 15),
+    CSR_OFF_ARRAY64(SAVE, 0),
+    CSR_OFF_ARRAY64(SAVE, 1),
+    CSR_OFF_ARRAY64(SAVE, 2),
+    CSR_OFF_ARRAY64(SAVE, 3),
+    CSR_OFF_ARRAY64(SAVE, 4),
+    CSR_OFF_ARRAY64(SAVE, 5),
+    CSR_OFF_ARRAY64(SAVE, 6),
+    CSR_OFF_ARRAY64(SAVE, 7),
+    CSR_OFF_ARRAY64(SAVE, 8),
+    CSR_OFF_ARRAY64(SAVE, 9),
+    CSR_OFF_ARRAY64(SAVE, 10),
+    CSR_OFF_ARRAY64(SAVE, 11),
+    CSR_OFF_ARRAY64(SAVE, 12),
+    CSR_OFF_ARRAY64(SAVE, 13),
+    CSR_OFF_ARRAY64(SAVE, 14),
+    CSR_OFF_ARRAY64(SAVE, 15),
     CSR_OFF(TID),
-    CSR_OFF_FLAGS(TCFG, CSRFL_IO),
-    CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
-    CSR_OFF(CNTC),
+    CSR_OFF_FLAGS(TCFG, CSRFL_IO | CSRFL_WIDTH64),
+    CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO | CSRFL_WIDTH64),
+    CSR_OFF64(CNTC),
     CSR_OFF_FLAGS(TICLR, CSRFL_IO),
     CSR_OFF(LLBCTL),
     CSR_OFF(IMPCTL1),
     CSR_OFF(IMPCTL2),
-    CSR_OFF(TLBRENTRY),
-    CSR_OFF(TLBRBADV),
-    CSR_OFF(TLBRERA),
-    CSR_OFF(TLBRSAVE),
-    CSR_OFF(TLBRELO0),
-    CSR_OFF(TLBRELO1),
-    CSR_OFF(TLBREHI),
+    CSR_OFF64(TLBRENTRY),
+    CSR_OFF64(TLBRBADV),
+    CSR_OFF64(TLBRERA),
+    CSR_OFF64(TLBRSAVE),
+    CSR_OFF64(TLBRELO0),
+    CSR_OFF64(TLBRELO1),
+    CSR_OFF64(TLBREHI),
     CSR_OFF(TLBRPRMD),
-    CSR_OFF_ARRAY(DMW, 0),
-    CSR_OFF_ARRAY(DMW, 1),
-    CSR_OFF_ARRAY(DMW, 2),
-    CSR_OFF_ARRAY(DMW, 3),
+    CSR_OFF_ARRAY64(DMW, 0),
+    CSR_OFF_ARRAY64(DMW, 1),
+    CSR_OFF_ARRAY64(DMW, 2),
+    CSR_OFF_ARRAY64(DMW, 3),
     CSR_OFF_ARRAY(PERFCTRL, 0),
-    CSR_OFF_ARRAY(PERFCNTR, 0),
+    CSR_OFF_ARRAY64(PERFCNTR, 0),
     CSR_OFF_ARRAY(PERFCTRL, 1),
-    CSR_OFF_ARRAY(PERFCNTR, 1),
+    CSR_OFF_ARRAY64(PERFCNTR, 1),
     CSR_OFF_ARRAY(PERFCTRL, 2),
-    CSR_OFF_ARRAY(PERFCNTR, 2),
+    CSR_OFF_ARRAY64(PERFCNTR, 2),
     CSR_OFF_ARRAY(PERFCTRL, 3),
-    CSR_OFF_ARRAY(PERFCNTR, 3),
+    CSR_OFF_ARRAY64(PERFCNTR, 3),
     CSR_OFF_ARRAY(PERFCTRL, 4),
-    CSR_OFF_ARRAY(PERFCNTR, 4),
+    CSR_OFF_ARRAY64(PERFCNTR, 4),
     CSR_OFF_ARRAY(PERFCTRL, 5),
-    CSR_OFF_ARRAY(PERFCNTR, 5),
+    CSR_OFF_ARRAY64(PERFCNTR, 5),
     CSR_OFF_ARRAY(PERFCTRL, 6),
-    CSR_OFF_ARRAY(PERFCNTR, 6),
+    CSR_OFF_ARRAY64(PERFCNTR, 6),
     CSR_OFF_ARRAY(PERFCTRL, 7),
-    CSR_OFF_ARRAY(PERFCNTR, 7),
+    CSR_OFF_ARRAY64(PERFCNTR, 7),
     CSR_OFF_ARRAY(PERFCTRL, 8),
-    CSR_OFF_ARRAY(PERFCNTR, 8),
+    CSR_OFF_ARRAY64(PERFCNTR, 8),
     CSR_OFF_ARRAY(PERFCTRL, 9),
-    CSR_OFF_ARRAY(PERFCNTR, 9),
+    CSR_OFF_ARRAY64(PERFCNTR, 9),
     CSR_OFF_ARRAY(PERFCTRL, 10),
-    CSR_OFF_ARRAY(PERFCNTR, 10),
+    CSR_OFF_ARRAY64(PERFCNTR, 10),
     CSR_OFF_ARRAY(PERFCTRL, 11),
-    CSR_OFF_ARRAY(PERFCNTR, 11),
+    CSR_OFF_ARRAY64(PERFCNTR, 11),
     CSR_OFF_ARRAY(PERFCTRL, 12),
-    CSR_OFF_ARRAY(PERFCNTR, 12),
+    CSR_OFF_ARRAY64(PERFCNTR, 12),
     CSR_OFF_ARRAY(PERFCTRL, 13),
-    CSR_OFF_ARRAY(PERFCNTR, 13),
+    CSR_OFF_ARRAY64(PERFCNTR, 13),
     CSR_OFF_ARRAY(PERFCTRL, 14),
-    CSR_OFF_ARRAY(PERFCNTR, 14),
+    CSR_OFF_ARRAY64(PERFCNTR, 14),
     CSR_OFF_ARRAY(PERFCTRL, 15),
-    CSR_OFF_ARRAY(PERFCNTR, 15),
-    CSR_OFF_ARRAY_FLAGS(MSGIS, 0, CSRFL_READONLY),
-    CSR_OFF_ARRAY_FLAGS(MSGIS, 1, CSRFL_READONLY),
-    CSR_OFF_ARRAY_FLAGS(MSGIS, 2, CSRFL_READONLY),
-    CSR_OFF_ARRAY_FLAGS(MSGIS, 3, CSRFL_READONLY),
+    CSR_OFF_ARRAY64(PERFCNTR, 15),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 0, CSRFL_READONLY | CSRFL_WIDTH64),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 1, CSRFL_READONLY | CSRFL_WIDTH64),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 2, CSRFL_READONLY | CSRFL_WIDTH64),
+    CSR_OFF_ARRAY_FLAGS(MSGIS, 3, CSRFL_READONLY | CSRFL_WIDTH64),
     CSR_OFF_FLAGS(MSGIR, CSRFL_READONLY),
 };
 
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index c2b6b882bc..87790aa84c 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -20,6 +20,7 @@ enum {
     CSRFL_IO       = (1 << 2),
     CSRFL_UNUSED   = (1 << 3),
     CSRFL_BASIC    = (1 << 4),
+    CSRFL_WIDTH64  = (1 << 5),
 };
 
 typedef struct {
-- 
2.54.0


