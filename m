Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03149D6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3GH-0006d4-ET; Thu, 22 Jan 2026 17:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vj3GD-0006bX-9J
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:34:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vj3GA-00011u-H3
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:34:41 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60MKrSTY3704258
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 22:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1Oe6h/MI1MfdMrW6XWpXkv8W8wRJeHYNtSG
 CMHy2y4s=; b=ADSCFzJvLonsQLu/aKBDQhuAo6qhRcqDFl7a/XmXjL1mw6/3ZhK
 ktCCr8vIgzbWHoAX1c0prxd1zPh07f1T/B9BoqvR+JyiNhYW38uzd6depVcGXzsL
 ckB3ptrKj/RUoWzuv+APCJqsLcwa8H863fcjHYflLuGY3zW5Nnr/bJx3tX8AuXRa
 gwv5DYIVYeGoJcFYWsmZKTY4RVvn7MrJbW04fWnn8Yyug9rBMON4jrEkayqxr6CB
 9dQpDUc41U0QT69Ei1rIaH9I1KIWFnQDcI6eCmMSTHU/yi508Qs3tsJEymYWbkcK
 GhHwNBt9EMeYuAv4/xrPLeF5WmvCQKa/txg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buuayr6fx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 22:34:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b6b9c1249fso2816562eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769121267; x=1769726067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Oe6h/MI1MfdMrW6XWpXkv8W8wRJeHYNtSGCMHy2y4s=;
 b=asQxOgaJ+rWgtS6gDbKBHaCnkdCcQIIC+xNlPiQhU/J2XyF+b9oMO/BOc4ZyrpxVCE
 EE933I+7dNM4Luy37Conqi4rWF6FKOQHmNhx8JwJseJk1SgmVAM2djJPtcTsLujaV+SP
 cNwV0trC5gh8m5fmp0US+sQoV9Mo+JoJVtLJiwe/81cx189uiSfXje7EntpEvs9bV9WW
 H+k+9g/DGTeuKqsEI5cjxqmnBTVDiVeUDH2vvSj8usTLXp9vdKj9KAHpsb4/p1Qp0VtW
 5Beg0VB/OcRyZACGVINU/qxrkghLGYVG0HcP4x/mMbGqAXe6uzTT5pMoPqKj9FSSwg6g
 C7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769121267; x=1769726067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Oe6h/MI1MfdMrW6XWpXkv8W8wRJeHYNtSGCMHy2y4s=;
 b=PBDOV27Y/sKYWZHx3gRnbGxOM+BgJZysXyZ39Jo2TxMPnNLgZANIjCYl3u/qZtJjO+
 R72fWRwh/+a/1DdxUyackE1jz+1HPg/iDYPxUuTOs3cBXfhIlkKFg7aTfT+HUG7pREN3
 4y6nzcHtqARGd9EJmNRwhf0NVU/GxlZrRajz6majvIkf+TwM7kNxXhpmsMU+jljTaPYK
 DQF5wcvwkXz0frgMD2wD3DrMoEVevEWJgYVLIER6TjGGmKkIB2Z3alZ3ak9QIwbPp+6b
 KuPY90Nj6nvgC+1R7RXQ/fOkgdBnY0pJYeVUTNOKL92bi0P9jEJuF67vLlfL9qvEdyOY
 RODA==
X-Gm-Message-State: AOJu0YxNdeawibjFHjUIZ2lZ/g+aRA3QFStjIhIU6K8O7opZQBzM7a+x
 rDtzbrQmdIg1SmzTfdnJQ1gqetHZsRe68IEAJnElj8HLVmk0bM8WpT7Ax0YOIADCCubL4r1olD6
 KfyVB+mQz6WdQy13ZRLbmvzobtYOdflzVOyNiREjcKnhu30qQJwEzQh220/3DU7dFow==
X-Gm-Gg: AZuq6aJ7QYRDf19sJ/3ah6kHvFhegMYiRg8/6aeIJAJNwezATqq5TSXM/ExnR5W3HOd
 YLuuG45v10Ga9bl2IvJuPh1vTbwfyT/e2wBa2t4qdf1oIwJcjZPKRk7xmlfpoVCKSBAHIILqH35
 mtz5lHTYtIUVMb/XIwPHH5WiLs6JIQSLV0UzGx6djNOYKjoXnMivnPE+2m4jxh8NcIS3tGP5J9N
 JA848uuzzXpOsgV859RuS9RqCIdNGywqeol/nebodmCgBZXpCRWlMfd3Jm/J832BJm9eBTT64gE
 62ZfUpcsOWykGZbzUILD+UDSQfJ58ztnte9xOj7+jWGCQ9EFYtdolcMwOnLTdni2oMTHBbffYk+
 ajvUcrLUg1L8D7Zq+NUhrUaQ6b5W+di2k8mDkksc0AjZnX5JnwfvZCYU7xDONbm8=
X-Received: by 2002:a05:7300:a146:b0:2b7:3424:d42b with SMTP id
 5a478bee46e88-2b739baee89mr475398eec.37.1769121266267; 
 Thu, 22 Jan 2026 14:34:26 -0800 (PST)
X-Received: by 2002:a05:7300:a146:b0:2b7:3424:d42b with SMTP id
 5a478bee46e88-2b739baee89mr475383eec.37.1769121265585; 
 Thu, 22 Jan 2026 14:34:25 -0800 (PST)
Received: from hu-mliebel-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73aa2a3c0sm875790eec.31.2026.01.22.14.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 14:34:25 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: Change DisasContext packet type
Date: Thu, 22 Jan 2026 14:34:23 -0800
Message-Id: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GP4F0+NK c=1 sm=1 tr=0 ts=6972a5f3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hoDqhJza17kQ37FjCbkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: hC7SjGjN6kIXW2wHIMNZiaUAW0E-ap_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE3MSBTYWx0ZWRfX9mE9qf7dpbmH
 P4tiHMjJgsAK81UiTU+nniuR8bVg2iTm2mN+0vqXYd/4F6fA8ZeA4MdIkq0uI/n5owlTCEaDmqm
 YDaX5eMV/2QvQydgOorGyjcNSh2UYBahdJM1oC3du07A/qRy/TufvY/47s6N0iLyW646I/tdhWS
 DLVLUuYKhlkLJoFbyFMtL67wur34KNStSDMi31RWaDfOwXjTka83+//w/i+ZgAVWiqUONRPZcuT
 /1nMe534Hyon/qX+sqlJCEpLcxLsCDa3pL5vd74RUXLy9vrf3FU5aSB8wvNAIcXCwj153DDY6Xg
 9ZcIWONleFtD5zjOo2W7FxHC28U6kzwuTGnRbjfugCd0LuoWaQGpxIgJcW+dV2BzywTF0ZLhojO
 gVzjfUBCA0/wcGDBVoevm86g8FiDSz1qlArrCWjZj7iMId+v0wkghz8rN+1DllcRyVVYJuG3YLW
 LU8QAKFTHIfVSsUreZg==
X-Proofpoint-GUID: hC7SjGjN6kIXW2wHIMNZiaUAW0E-ap_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_05,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The pkt variable inside DisasContext is of type Packet * and gets
assigned to a local variable in decode_and_translate_packet. Right now
there seems to be no problem with it but future changes to e.g.
hexagon_tr_transalte_packet are potentially dangerous if pkt is accessed
after the local variable goes out of scope.

Since packets are being translated one at a time, the type of pkt can be
changed to just Packet to avoid risk of having a dangling pointer.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h        |   2 +-
 target/hexagon/macros.h         |   6 +-
 target/hexagon/translate.h      |   2 +-
 target/hexagon/decode.c         |   8 +--
 target/hexagon/genptr.c         |  14 ++--
 target/hexagon/translate.c      | 111 ++++++++++++++------------------
 target/hexagon/gen_tcg_funcs.py |   2 +-
 target/hexagon/hex_common.py    |   4 +-
 8 files changed, 65 insertions(+), 84 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 7b96dab918..54562e3ef3 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1363,7 +1363,7 @@
 #define fGEN_TCG_J2_trap0(SHORTCODE) \
     do { \
         uiV = uiV; \
-        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt->pc); \
+        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt.pc); \
         TCGv excp = tcg_constant_tl(HEX_EVENT_TRAP0); \
         gen_helper_raise_exception(tcg_env, excp); \
     } while (0)
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 6c2862a232..eebfe1e5ed 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -83,7 +83,7 @@
  */
 #define CHECK_NOSHUF(VA, SIZE) \
     do { \
-        if (insn->slot == 0 && ctx->pkt->pkt_has_scalar_store_s1) { \
+        if (insn->slot == 0 && ctx->pkt.pkt_has_scalar_store_s1) { \
             probe_noshuf_load(VA, SIZE, ctx->mem_idx); \
             process_store(ctx, 1); \
         } \
@@ -94,11 +94,11 @@
         TCGLabel *noshuf_label = gen_new_label(); \
         tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, noshuf_label); \
         GET_EA; \
-        if (insn->slot == 0 && ctx->pkt->pkt_has_scalar_store_s1) { \
+        if (insn->slot == 0 && ctx->pkt.pkt_has_scalar_store_s1) { \
             probe_noshuf_load(EA, SIZE, ctx->mem_idx); \
         } \
         gen_set_label(noshuf_label); \
-        if (insn->slot == 0 && ctx->pkt->pkt_has_scalar_store_s1) { \
+        if (insn->slot == 0 && ctx->pkt.pkt_has_scalar_store_s1) { \
             process_store(ctx, 1); \
         } \
     } while (0)
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index a0102b6cbd..ffbfc3ac0e 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -28,7 +28,7 @@
 
 typedef struct DisasContext {
     DisasContextBase base;
-    Packet *pkt;
+    Packet pkt;
     Insn *insn;
     uint32_t next_PC;
     uint32_t mem_idx;
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index b5ece60450..c2516d927d 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -748,14 +748,12 @@ int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
                         GString *buf)
 {
     DisasContext ctx;
-    Packet pkt;
 
     memset(&ctx, 0, sizeof(DisasContext));
-    ctx.pkt = &pkt;
 
-    if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
-        snprint_a_pkt_disas(buf, &pkt, words, pc);
-        return pkt.encod_pkt_size_in_bytes;
+    if (decode_packet(&ctx, nwords, words, &ctx.pkt, true) > 0) {
+        snprint_a_pkt_disas(buf, &ctx.pkt, words, pc);
+        return ctx.pkt.encod_pkt_size_in_bytes;
     } else {
         g_string_assign(buf, "<invalid>");
         return 0;
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 36968549d5..160edfe756 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -382,7 +382,7 @@ static inline void gen_store_conditional8(DisasContext *ctx,
 static TCGv gen_slotval(DisasContext *ctx)
 {
     int slotval =
-        (ctx->pkt->pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1);
+        (ctx->pkt.pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1);
     return tcg_constant_tl(slotval);
 }
 #endif
@@ -458,7 +458,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
         tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
     }
 
-    if (ctx->pkt->pkt_has_multi_cof) {
+    if (ctx->pkt.pkt_has_multi_cof) {
         /* If there are multiple branches in a packet, ignore the second one */
         tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
                            ctx->branch_taken, tcg_constant_tl(0),
@@ -476,8 +476,8 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
 static void gen_write_new_pc_pcrel(DisasContext *ctx, int pc_off,
                                    TCGCond cond, TCGv pred)
 {
-    target_ulong dest = ctx->pkt->pc + pc_off;
-    if (ctx->pkt->pkt_has_multi_cof) {
+    target_ulong dest = ctx->pkt.pc + pc_off;
+    if (ctx->pkt.pkt_has_multi_cof) {
         gen_write_new_pc_addr(ctx, tcg_constant_tl(dest), cond, pred);
     } else {
         /* Defer this jump to the end of the TB */
@@ -528,7 +528,7 @@ static inline void gen_loop0r(DisasContext *ctx, TCGv RsV, int riV)
     fIMMEXT(riV);
     fPCALIGN(riV);
     tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
-    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV);
+    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt.pc + riV);
     gen_set_usr_fieldi(ctx, USR_LPCFG, 0);
 }
 
@@ -542,7 +542,7 @@ static inline void gen_loop1r(DisasContext *ctx, TCGv RsV, int riV)
     fIMMEXT(riV);
     fPCALIGN(riV);
     tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);
-    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt->pc + riV);
+    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt.pc + riV);
 }
 
 static void gen_loop1i(DisasContext *ctx, int count, int riV)
@@ -555,7 +555,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N, TCGv RsV, int riV)
     fIMMEXT(riV);
     fPCALIGN(riV);
     tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
-    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV);
+    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt.pc + riV);
     gen_set_usr_fieldi(ctx, USR_LPCFG, N);
     gen_pred_write(ctx, 3, tcg_constant_tl(0));
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index e88e19cc1a..b06ed154f3 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -156,8 +156,6 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
 
 static void gen_end_tb(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
-
     gen_exec_counters(ctx);
 
     if (ctx->branch_cond != TCG_COND_NEVER) {
@@ -171,7 +169,7 @@ static void gen_end_tb(DisasContext *ctx)
             gen_goto_tb(ctx, 0, ctx->branch_dest, true);
         }
     } else if (ctx->is_tight_loop &&
-               pkt->insn[pkt->num_insns - 1].opcode == J2_endloop0) {
+               ctx->pkt.insn[ctx->pkt.num_insns - 1].opcode == J2_endloop0) {
         /*
          * When we're in a tight loop, we defer the endloop0 processing
          * to take advantage of direct block chaining
@@ -252,11 +250,9 @@ static bool need_slot_cancelled(Packet *pkt)
 
 static bool need_next_PC(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
-
     /* Check for conditional control flow or HW loop end */
-    for (int i = 0; i < pkt->num_insns; i++) {
-        uint16_t opcode = pkt->insn[i].opcode;
+    for (int i = 0; i < ctx->pkt.num_insns; i++) {
+        uint16_t opcode = ctx->pkt.insn[i].opcode;
         if (GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode, A_COF)) {
             return true;
         }
@@ -339,8 +335,6 @@ static bool pkt_raises_exception(Packet *pkt)
 
 static bool need_commit(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
-
     /*
      * If the short-circuit property is set to false, we'll always do the commit
      */
@@ -348,7 +342,7 @@ static bool need_commit(DisasContext *ctx)
         return true;
     }
 
-    if (pkt_raises_exception(pkt)) {
+    if (pkt_raises_exception(&ctx->pkt)) {
         return true;
     }
 
@@ -395,11 +389,10 @@ static void mark_implicit_writes(DisasContext *ctx)
 
 static void analyze_packet(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
     ctx->read_after_write = false;
     ctx->has_hvx_overlap = false;
-    for (int i = 0; i < pkt->num_insns; i++) {
-        Insn *insn = &pkt->insn[i];
+    for (int i = 0; i < ctx->pkt.num_insns; i++) {
+        Insn *insn = &ctx->pkt.insn[i];
         ctx->insn = insn;
         if (opcode_analyze[insn->opcode]) {
             opcode_analyze[insn->opcode](ctx);
@@ -411,8 +404,7 @@ static void analyze_packet(DisasContext *ctx)
 
 static void gen_start_packet(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
-    target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
+    target_ulong next_PC = ctx->base.pc_next + ctx->pkt.encod_pkt_size_in_bytes;
     int i;
 
     /* Clear out the disassembly context */
@@ -454,13 +446,13 @@ static void gen_start_packet(DisasContext *ctx)
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
 
     /* Initialize the runtime state for packet semantics */
-    if (need_slot_cancelled(pkt)) {
+    if (need_slot_cancelled(&ctx->pkt)) {
         tcg_gen_movi_tl(hex_slot_cancelled, 0);
     }
     ctx->branch_taken = NULL;
-    if (pkt->pkt_has_cof) {
+    if (ctx->pkt.pkt_has_cof) {
         ctx->branch_taken = tcg_temp_new();
-        if (pkt->pkt_has_multi_cof) {
+        if (ctx->pkt.pkt_has_multi_cof) {
             tcg_gen_movi_tl(ctx->branch_taken, 0);
         }
         if (need_next_PC(ctx)) {
@@ -489,7 +481,7 @@ static void gen_start_packet(DisasContext *ctx)
      * Preload the predicated pred registers into ctx->new_pred_value[pred_num]
      * Only endloop instructions conditionally write to pred registers
      */
-    if (ctx->need_commit && pkt->pkt_has_endloop) {
+    if (ctx->need_commit && ctx->pkt.pkt_has_endloop) {
         for (i = 0; i < ctx->preg_log_idx; i++) {
             int pred_num = ctx->preg_log[i];
             ctx->new_pred_value[pred_num] = tcg_temp_new();
@@ -528,13 +520,11 @@ static void gen_start_packet(DisasContext *ctx)
 
 bool is_gather_store_insn(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
-    Insn *insn = ctx->insn;
-    if (GET_ATTRIB(insn->opcode, A_CVI_NEW) &&
-        insn->new_value_producer_slot == 1) {
+    if (GET_ATTRIB(ctx->insn->opcode, A_CVI_NEW) &&
+        ctx->insn->new_value_producer_slot == 1) {
         /* Look for gather instruction */
-        for (int i = 0; i < pkt->num_insns; i++) {
-            Insn *in = &pkt->insn[i];
+        for (int i = 0; i < ctx->pkt.num_insns; i++) {
+            Insn *in = &ctx->pkt.insn[i];
             if (GET_ATTRIB(in->opcode, A_CVI_GATHER) && in->slot == 1) {
                 return true;
             }
@@ -637,7 +627,7 @@ static bool slot_is_predicated(Packet *pkt, int slot_num)
 
 void process_store(DisasContext *ctx, int slot_num)
 {
-    bool is_predicated = slot_is_predicated(ctx->pkt, slot_num);
+    bool is_predicated = slot_is_predicated(&ctx->pkt, slot_num);
     TCGLabel *label_end = NULL;
 
     /*
@@ -714,13 +704,12 @@ static void process_store_log(DisasContext *ctx)
      *  slot 1 and then slot 0.  This will be important when
      *  the memory accesses overlap.
      */
-    Packet *pkt = ctx->pkt;
-    if (pkt->pkt_has_scalar_store_s1) {
-        g_assert(!pkt->pkt_has_dczeroa);
+    if (ctx->pkt.pkt_has_scalar_store_s1) {
+        g_assert(!ctx->pkt.pkt_has_dczeroa);
         process_store(ctx, 1);
     }
-    if (pkt->pkt_has_scalar_store_s0) {
-        g_assert(!pkt->pkt_has_dczeroa);
+    if (ctx->pkt.pkt_has_scalar_store_s0) {
+        g_assert(!ctx->pkt.pkt_has_dczeroa);
         process_store(ctx, 0);
     }
 }
@@ -728,7 +717,7 @@ static void process_store_log(DisasContext *ctx)
 /* Zero out a 32-bit cache line */
 static void process_dczeroa(DisasContext *ctx)
 {
-    if (ctx->pkt->pkt_has_dczeroa) {
+    if (ctx->pkt.pkt_has_dczeroa) {
         /* Store 32 bytes of zero starting at (addr & ~0x1f) */
         TCGv addr = tcg_temp_new();
         TCGv_i64 zero = tcg_constant_i64(0);
@@ -762,7 +751,7 @@ static void gen_commit_hvx(DisasContext *ctx)
 
     /* Early exit if not needed */
     if (!ctx->need_commit) {
-        g_assert(!pkt_has_hvx_store(ctx->pkt));
+        g_assert(!pkt_has_hvx_store(&ctx->pkt));
         return;
     }
 
@@ -796,25 +785,23 @@ static void gen_commit_hvx(DisasContext *ctx)
         tcg_gen_gvec_mov(MO_64, dstoff, srcoff, size, size);
     }
 
-    if (pkt_has_hvx_store(ctx->pkt)) {
+    if (pkt_has_hvx_store(&ctx->pkt)) {
         gen_helper_commit_hvx_stores(tcg_env);
     }
 }
 
 static void update_exec_counters(DisasContext *ctx)
 {
-    Packet *pkt = ctx->pkt;
-    int num_insns = pkt->num_insns;
     int num_real_insns = 0;
     int num_hvx_insns = 0;
 
-    for (int i = 0; i < num_insns; i++) {
-        if (!pkt->insn[i].is_endloop &&
-            !pkt->insn[i].part1 &&
-            !GET_ATTRIB(pkt->insn[i].opcode, A_IT_NOP)) {
+    for (int i = 0; i < ctx->pkt.num_insns; i++) {
+        if (!ctx->pkt.insn[i].is_endloop &&
+            !ctx->pkt.insn[i].part1 &&
+            !GET_ATTRIB(ctx->pkt.insn[i].opcode, A_IT_NOP)) {
             num_real_insns++;
         }
-        if (GET_ATTRIB(pkt->insn[i].opcode, A_CVI)) {
+        if (GET_ATTRIB(ctx->pkt.insn[i].opcode, A_CVI)) {
             num_hvx_insns++;
         }
     }
@@ -843,12 +830,11 @@ static void gen_commit_packet(DisasContext *ctx)
      * store.  Therefore, we call process_store_log before anything else
      * involved in committing the packet.
      */
-    Packet *pkt = ctx->pkt;
-    bool has_store_s0 = pkt->pkt_has_scalar_store_s0;
+    bool has_store_s0 = ctx->pkt.pkt_has_scalar_store_s0;
     bool has_store_s1 =
-        (pkt->pkt_has_scalar_store_s1 && !ctx->s1_store_processed);
-    bool has_hvx_store = pkt_has_hvx_store(pkt);
-    if (pkt->pkt_has_dczeroa) {
+        (ctx->pkt.pkt_has_scalar_store_s1 && !ctx->s1_store_processed);
+    bool has_hvx_store = pkt_has_hvx_store(&ctx->pkt);
+    if (ctx->pkt.pkt_has_dczeroa) {
         /*
          * The dczeroa will be the store in slot 0, check that we don't have
          * a store in slot 1 or an HVX store.
@@ -875,12 +861,11 @@ static void gen_commit_packet(DisasContext *ctx)
                     FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
                                HAS_HVX_STORES, 1);
             }
-            if (has_store_s0 && slot_is_predicated(pkt, 0)) {
-                mask =
-                    FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
-                               S0_IS_PRED, 1);
+            if (has_store_s0 && slot_is_predicated(&ctx->pkt, 0)) {
+                mask = FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES, S0_IS_PRED,
+                                  1);
             }
-            if (has_store_s1 && slot_is_predicated(pkt, 1)) {
+            if (has_store_s1 && slot_is_predicated(&ctx->pkt, 1)) {
                 mask =
                     FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
                                S1_IS_PRED, 1);
@@ -898,7 +883,7 @@ static void gen_commit_packet(DisasContext *ctx)
         int args = 0;
         args =
             FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX, ctx->mem_idx);
-        if (slot_is_predicated(pkt, 0)) {
+        if (slot_is_predicated(&ctx->pkt, 0)) {
             args =
                 FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED, 1);
         }
@@ -910,18 +895,18 @@ static void gen_commit_packet(DisasContext *ctx)
 
     gen_reg_writes(ctx);
     gen_pred_writes(ctx);
-    if (pkt->pkt_has_hvx) {
+    if (ctx->pkt.pkt_has_hvx) {
         gen_commit_hvx(ctx);
     }
     update_exec_counters(ctx);
 
-    if (pkt->vhist_insn != NULL) {
+    if (ctx->pkt.vhist_insn != NULL) {
         ctx->pre_commit = false;
-        ctx->insn = pkt->vhist_insn;
-        pkt->vhist_insn->generate(ctx);
+        ctx->insn = ctx->pkt.vhist_insn;
+        ctx->pkt.vhist_insn->generate(ctx);
     }
 
-    if (pkt->pkt_has_cof) {
+    if (ctx->pkt.pkt_has_cof) {
         gen_end_tb(ctx);
     }
 }
@@ -930,7 +915,6 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
 {
     uint32_t words[PACKET_WORDS_MAX];
     int nwords;
-    Packet pkt;
     int i;
 
     nwords = read_packet_words(env, ctx, words);
@@ -939,16 +923,15 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         return;
     }
 
-    ctx->pkt = &pkt;
-    if (decode_packet(ctx, nwords, words, &pkt, false) > 0) {
-        pkt.pc = ctx->base.pc_next;
+    if (decode_packet(ctx, nwords, words, &ctx->pkt, false) > 0) {
+        ctx->pkt.pc = ctx->base.pc_next;
         gen_start_packet(ctx);
-        for (i = 0; i < pkt.num_insns; i++) {
-            ctx->insn = &pkt.insn[i];
+        for (i = 0; i < ctx->pkt.num_insns; i++) {
+            ctx->insn = &ctx->pkt.insn[i];
             gen_insn(ctx);
         }
         gen_commit_packet(ctx);
-        ctx->base.pc_next += pkt.encod_pkt_size_in_bytes;
+        ctx->base.pc_next += ctx->pkt.encod_pkt_size_in_bytes;
     } else {
         gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
     }
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 87b7f10d7f..e7f90a0da1 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -72,7 +72,7 @@ def gen_tcg_func(f, tag, regs, imms):
         for immlett, bits, immshift in imms:
             declared.append(hex_common.imm_name(immlett))
 
-        arguments = ", ".join(["ctx", "ctx->insn", "ctx->pkt"] + declared)
+        arguments = ", ".join(["ctx", "ctx->insn", "&ctx->pkt"] + declared)
         f.write(f"    emit_{tag}({arguments});\n")
 
     elif hex_common.skip_qemu_helper(tag):
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index c0e9f26aeb..e37d5a514f 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1144,7 +1144,7 @@ def helper_args(tag, regs, imms):
     if need_pkt_has_multi_cof(tag):
         args.append(HelperArg(
             "i32",
-            "tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)",
+            "tcg_constant_tl(ctx->pkt.pkt_has_multi_cof)",
             "uint32_t pkt_has_multi_cof"
         ))
     if need_pkt_need_commit(tag):
@@ -1156,7 +1156,7 @@ def helper_args(tag, regs, imms):
     if need_PC(tag):
         args.append(HelperArg(
             "i32",
-            "tcg_constant_tl(ctx->pkt->pc)",
+            "tcg_constant_tl(ctx->pkt.pc)",
             "target_ulong PC"
         ))
     if need_next_PC(tag):
-- 
2.34.1


