Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20906C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplH-0006IY-Mi; Fri, 28 Aug 2026 02:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplG-0006Fa-4F
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplE-0000ue-00
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22WRn2941664
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vmbFi2FtwFYQipr7p
 a0CPlFTwUI16OAIoQBLZc/wJwI=; b=BpMWkroqWF6TjsNijuZueicWwoHaBKS3m
 w/zNIp7X/TRbmM9zAgEPMuICjMlDUAYTEUvkyxq0k6DGczwYIG7jhx8CdIVSASVy
 vpTejs6fJOLj4GywJvBA2c0pYTlEc6PSZfL+25eb6wRG23v92xbaO0BEGfOMUTj/
 j3tbIBwshGHH0JGPmOSbP1wW6bMmWmkW3hS4us8/mdCTVrWzEkzdBy+nsE71qZRZ
 Nb2m+nMvcDwvaAhBnzYhi/CaxROoDW1SFHJy7Tywnl36g9CVB0vkrWFejSKOKtR9
 4wHdYY38gefJYLYU5J+zirKsRMtvd7eVioPrumJcI7jR6WUUAJdJQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eraawg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uHQw019161
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kcm85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68Dbe47317460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BE7D2004E;
 Fri, 28 Aug 2026 06:08:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2039420043;
 Fri, 28 Aug 2026 06:08:11 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:10 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 18/41] target/ppc: Convert b{a, l, la} to decode tree
Date: Fri, 28 Aug 2026 11:36:53 +0530
Message-ID: <20260828060716.91672-19-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dy3obSkPSLh1Q8yXD-vbBjcx9yW_yiml
X-Proofpoint-ORIG-GUID: Dy3obSkPSLh1Q8yXD-vbBjcx9yW_yiml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/uQjyrM9qw+a
 ORj7y6HCuuO8diaxprpaEQssfiIN6RuSRI8AETAxma1DBKABmYuznqgnQCG+jJujZ3DlFUJ/83D
 7MrrsCOV9nictQf4PWY2Q0G0t5HGzN3IsmVi2VrxOQBlX4RlWGOw/1ibeZyWC2Ndg0t9y58v1U3
 q9E9NXBrwANtPfF3/OBV5ayEBqW8pIx1R88jxzVEL2e7MoZ0/2GZyReZ5rwKmkwp7xVSjkeVgVP
 gHrF6BUeO1L+ynkKPlBCUV6VLpJC9HmBRMV/LLY46cXJ6ex0sMIrqwoiddUPxAFamZ+a8/s1e3I
 20E6QGPndPGG/DAwGn51ruqHLOkuLRPNyyzzSh70Qkz/Eit9WwfPkdLZSW+cV9P9t1SBJHT1zPf
 rNywMHbwg9bp968Zh7icg9yDJFJ/EQLVRjynFJ4HecbEAJ1bX0JpgX6USavSBIWpbR5X/xgGCrn
 /ujL9Wg8tQIFdOxBjdw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a9125d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8uLd_aw9J8tj_XdJNvAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX5MeV/eKxFCSH
 ZFCRTSdWHXZeWq1DSndqVxkkD1QkJu7M3WY7jBs6dQmGIFa+h+aqfay7RnmReFr6dj6F5bbALO9
 ygvYHfq1abgrhtce3gJiF4glXKX5Oeo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Convert b, ba, bl and bla to decode tree specification. The functionality
was tested by comparing the qemu -D log -d op,in_asm output as well as
single stepping gdb to confirm LR was correctly populated only when LK
is set.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-15-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/internal.h                  |  7 -------
 target/ppc/insn32.decode               |  7 +++++++
 target/ppc/translate.c                 | 24 ------------------------
 target/ppc/translate/branch-impl.c.inc | 24 ++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a3bb12afd9..a20a0f9f7e 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -197,13 +197,6 @@ EXTRACT_HELPER(L, 16, 2);
 EXTRACT_HELPER(WC, 21, 2);
 EXTRACT_HELPER(PL, 16, 2);
 
-/***                            Jump target decoding                       ***/
-/* Immediate address */
-static inline target_ulong LI(uint32_t opcode)
-{
-    return (opcode >> 0) & 0x03FFFFFC;
-}
-
 static inline uint32_t BD(uint32_t opcode)
 {
     return (opcode >> 0) & 0xFFFC;
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 6fb7754566..0c58899429 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1486,6 +1486,13 @@ MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
 MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
 CLRBHRB         011111 ----- ----- ----- 0110101110 -
 
+# Branch Instructions
+%li             2:24 !function=times_4
+&I_b            li aa:bool lk:bool
+@I_b            ...... ........................ aa:1 lk:1 &I_b li=%li
+
+B               010010 ........................ . .  @I_b
+
 ## Misc POWER instructions
 
 ATTN            000000 00000 00000 00000 0100000000 0
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 84589716b3..3c6e2da8ce 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3089,29 +3089,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_lr, nip);
 }
 
-/* b ba bl bla */
-static void gen_b(DisasContext *ctx)
-{
-    target_ulong li, target;
-
-    /* sign extend LI */
-    li = LI(ctx->opcode);
-    li = (li ^ 0x02000000) - 0x02000000;
-    if (likely(AA(ctx->opcode) == 0)) {
-        target = ctx->cia + li;
-    } else {
-        target = li;
-    }
-    if (LK(ctx->opcode)) {
-        gen_setlr(ctx, ctx->base.pc_next);
-        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
-    } else {
-        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
-    }
-    gen_goto_tb(ctx, 0, target);
-    ctx->base.is_jmp = DISAS_NORETURN;
-}
-
 #define BCOND_IM  0
 #define BCOND_LR  1
 #define BCOND_CTR 2
@@ -5353,7 +5330,6 @@ GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(b, 0x12, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index 9ade0c659a..745f71afd1 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -31,3 +31,27 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
     return true;
 }
 #endif
+
+static bool trans_B(DisasContext *ctx, arg_I_b *a)
+{
+    target_ulong target, li;
+
+    /* sign extend LI */
+    li = (a->li ^ 0x02000000) - 0x02000000;
+
+    if (likely(a->aa == 0)) {
+        target = ctx->cia + li;
+    } else {
+        target = li;
+    }
+    if (a->lk) {
+        gen_setlr(ctx, ctx->base.pc_next);
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
+    } else {
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
+    }
+    gen_goto_tb(ctx, 0, target);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    return true;
+}
-- 
2.52.0


