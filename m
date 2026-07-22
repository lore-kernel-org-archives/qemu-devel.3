Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1456C44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZWa-00045M-0E; Wed, 22 Jul 2026 12:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZWS-0003mP-MY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:10:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZWO-0002C2-5w
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:10:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFXsuu1146342
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jr2RO4QJmoSJSGktLdN5YArmlNFQ5swgA/DHl2YNf+o=; b=d748H7J1HDhRVx76
 thasx/bOzrDVeMNoUQ2iAzKDT3x5EiJRgf1Yifx5RFpyUmG3T3sF+hLzYPEaoUjw
 Z42lEWfroo1bW90HWRKSjLwWjXgteUiRx15IvuGExkysntCeP/MB6uP/9SNtxntn
 dUCaQ4zYJvNO/Ue74axeVBZS/B+UeJgqZKukcHNcB5mq4dOW3BK7UMXgXTReuR4W
 /KVTdUy7rA1I2orvlEoOlPGAcCDB+3u443iq4Hltlg7mxZqBH+ChPUQFlFzYeE+/
 NaNoQmJERVIqFrx5zaaahXkWnxGbCoxIVuTmaH7FJLTUPK52BFINgnhjNJ2eW2iN
 pcvwYw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn33wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:10:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso225357276d6.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736563; x=1785341363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jr2RO4QJmoSJSGktLdN5YArmlNFQ5swgA/DHl2YNf+o=;
 b=f6W7M6KQ2+pUzFY+QNcoU7M30RLczwKu5Qz9reCCDiOOxctMU+FUxqTBo43Q5jcjPw
 0IvFW9dutAOHpCnH/2Q7MD5sWAfFBiI//67ek54sDKkGuYQW6jXvhabWiREbqB/eYqV+
 7m6Ah56vo7VtRw32wBkFMBsIg/n0TzmQJubq2q2my2jhnqjaTlo2Dq8NdkwU1lQhcoKs
 5+UVzhHxdFfNoecUaHS5jBo2iKuIZnQmgoCZY5l9n6BGkJU9UIJanWOtTW3wVo+R2szS
 g7BSsFZ42Oo56PGrXyzdmsYkECjFsPG44H9r9oaoCJ5TanZVgwZcj+jsSf8VrQvQ6ZYG
 UACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736563; x=1785341363;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jr2RO4QJmoSJSGktLdN5YArmlNFQ5swgA/DHl2YNf+o=;
 b=dl9qMQG+BdLOWU22AQzrJBN7ssejBEW/ZoSDrAoghLpLWm7Guw34w2cXvDn/py+vfO
 UTbiMlqMNFE1b6zMewXNIo/g3GA73gKe9pQnZt1ohqroVUKi+3CbYnwIHsrOHxnHalDK
 lU8thl8OMKWP9pfRsY5lxYmRoKfXzeoiuJRsZhrwL9FaztXw2w48+qGF4jfo2RDRJRjH
 q4mochoPHsL2ST8dxPOLRxsc7yf23oqFMJwP/MPIn/Iys6iFqLhjdcej49VqEz63YuAt
 u8fMs2QZKKVrEuysCKXkycEa8rMRRlP5RS52puiGWBpC7S+kH6uSwEdbHjzshX7nygEV
 5LYQ==
X-Gm-Message-State: AOJu0YwyB4q3XnpaZ/Ecu+SuZjoWrbZpH792OiKY4qcKu++onjCF0fHM
 hiRmAHzNpOsYf6LAZSw9JtwY8dmJhYiHj1jLlEVqx4Un0ClXYKpwtjZ0Al5FWtfvXuptVP+cant
 7Lsi8ioXNGpfAISM+QhY8zxvUXJxlSD+kaTGP8pAxL5YJhHE+qBymWBPv5xX1JhhKGw==
X-Gm-Gg: AR+sD13VrFBGfaT45LdQ/H1VvPKkL6QuKX/kpnDfDp7ctVOalwzRn+Gcwq3WtHBrqv8
 thq81VitKdRSQ+31jVfQQB0yfpX+7wPQbu3MT0uEngUueY8ZoN2i1oLyszYRTlTe3yvvzxbcfxs
 hckpHAo7LeQlHKQ/LgPgrC0fXOyR9S8EUgRK3wtWgbsQl+IkLkSyIazj/5Jhdtsg4vl/PrAPakH
 pDjGGv6EYS4Fe0tSUrl3QjKreM8lPL3S2bmohLFVAR25dk4IZquElai/hUDMW6sNCmMxeHOAHo1
 un3N8VEQGynm1+n4djdSmvyk57nLa7VdtZwRMbt1kQM8q6M3VQkFJhUZTA5QfKn/ACwEz78hi9T
 3wYAU+7726uuF32NyI/1o8v9vGvBHN1MmFnemNVGanv0tTpM3QAK/IOM=
X-Received: by 2002:a05:622a:2613:b0:51c:1132:c800 with SMTP id
 d75a77b69052e-5213c5f1b5cmr224781841cf.19.1784736563060; 
 Wed, 22 Jul 2026 09:09:23 -0700 (PDT)
X-Received: by 2002:a05:622a:2613:b0:51c:1132:c800 with SMTP id
 d75a77b69052e-5213c5f1b5cmr224771641cf.19.1784736553769; 
 Wed, 22 Jul 2026 09:09:13 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a63fb10sm81994505e9.13.2026.07.22.09.09.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:09:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 6/7] target/microblaze: Factor reverse_ldst_addr() helper
 out
Date: Wed, 22 Jul 2026 18:08:06 +0200
Message-ID: <20260722160807.24031-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a60eb61 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WwSEdY8ObH1Q66UJNWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: PGjLg8hitBgiVmRRm_0FAelSm6_U8VsI
X-Proofpoint-ORIG-GUID: PGjLg8hitBgiVmRRm_0FAelSm6_U8VsI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX8qihD+MSLHQr
 PFKuChvv95yNWUBVR+fy4Qpxhs6SfL/8wYgGlaL8WURsdbL1bVtfIiQgKqsGkPkzdN0mQcV70TR
 1CoFdzmosV71FyrHs5+arT1WqroORyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX0EtD1EFGLSKp
 7lAEImYLPax630/jdWB/Cbz2eQCBzuQAYdehIqL0LmjeBO0JpV41u4sJulLTdCWGbHNro8OdhbY
 TjDt9LfSmApiQ+uDlpIwE6SAxVUIGpbF15eYejaFqzP3ukOb1fCeLt9wjbnbDlFgjp3uCprEZll
 0AMdbgQLtpbzUDGZgCs5xYUMBmPjvD3IsO099JGQWrl7pE72kpYUTEuYjUbarf2YNXbFU3wuMY1
 2yByR/VzXyALaHBH9pfL7s/QUeoqpwocWtsKDQm2ZgJSflzAdKZxzAy6t3HjOM9ryATSO7g/bPh
 4bTk+zmmbusLYdJYUKiuI0CYp8O8OMDnRc2367zfptsLwXLo5IsaZuQMaba0TDZDdG/Q8Y1Pm2x
 kv4IFkS6LOat1aP88uAVpChiDeIPqlq8KAEYZy6fPFBq3PbCp34IONhBKtZ6oZm+Kayd8/cuhGv
 l+FHKf0Mvepa9jEcXlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Instead of burying the address reversion in the load/store
opcode helpers, hoist that to compute_ldst_addr_type*(). Pass
the necessary information with a MemOp argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 64 +++++++++++++++++------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 581f4b48c92..8c530ed1191 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -607,7 +607,24 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
 DO_TYPEA(xor, false, tcg_gen_xor_i32)
 DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
-static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
+static TCGv_i32 reverse_ldst_addr(TCGv_i32 addr, MemOp mop)
+{
+    MemOp mo_size = mop & MO_SIZE;
+
+    /*
+     * When doing reverse accesses we need to byteswap the data
+     * lanes on the way back into the CPU core.
+     */
+
+    if (mo_size < MO_32) {
+        tcg_gen_xori_i32(addr, addr, 3 - mo_size);
+    }
+
+    return addr;
+}
+
+static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb,
+                                        MemOp mop)
 {
     TCGv_i32 ret;
 
@@ -622,6 +639,7 @@ static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
     } else {
         ret = tcg_constant_i32(0);
     }
+    ret = reverse_ldst_addr(ret, mop);
 
     if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
         gen_helper_stackprot(tcg_env, ret);
@@ -629,7 +647,8 @@ static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
     return ret;
 }
 
-static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
+static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm,
+                                        MemOp mop)
 {
     TCGv_i32 ret;
 
@@ -642,6 +661,7 @@ static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
     } else {
         ret = tcg_constant_i32(imm);
     }
+    ret = reverse_ldst_addr(ret, mop);
 
     if (ra == 1 && dc->cfg->stackprot) {
         gen_helper_stackprot(tcg_env, ret);
@@ -714,24 +734,14 @@ static inline MemOp mo_endian(DisasContext *dc)
 static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                     int mem_index)
 {
-    MemOp size = mop & MO_SIZE;
-
-    /*
-     * When doing reverse accesses we need to byteswap the data
-     * lanes on the way back into the CPU core.
-     */
-    if (mop & MO_BSWAP) {
-        if (size < MO_32) {
-            tcg_gen_xori_i32(addr, addr, 3 - size);
-        }
-    }
-
     /*
      * For system mode, enforce alignment if the cpu configuration
      * requires it.  For user-mode, the Linux kernel will have fixed up
      * any unaligned access, so emulate that by *not* setting MO_ALIGN.
      */
 #ifndef CONFIG_USER_ONLY
+    MemOp size = mop & MO_SIZE;
+
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cfg->unaligned_exceptions) {
@@ -746,13 +756,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 
 static bool trans_ld_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
 {
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
     return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
 static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
 {
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm, mop);
     return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
@@ -815,7 +825,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 {
     const MemOp mop = mo_endian(dc) | MO_UL;
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
 
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_i32(addr, addr, ~3);
@@ -835,24 +845,14 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                      int mem_index)
 {
-    MemOp size = mop & MO_SIZE;
-
-    /*
-     * When doing reverse accesses we need to byteswap the data
-     * lanes on the way back into the CPU core.
-     */
-    if (mop & MO_BSWAP) {
-        if (size < MO_32) {
-            tcg_gen_xori_i32(addr, addr, 3 - size);
-        }
-    }
-
     /*
      * For system mode, enforce alignment if the cpu configuration
      * requires it.  For user-mode, the Linux kernel will have fixed up
      * any unaligned access, so emulate that by *not* setting MO_ALIGN.
      */
 #ifndef CONFIG_USER_ONLY
+    MemOp size = mop & MO_SIZE;
+
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cfg->unaligned_exceptions) {
@@ -867,13 +867,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 
 static bool trans_st_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
 {
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
     return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
 static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
 {
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm, mop);
     return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
@@ -936,7 +936,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
 {
     const MemOp mop = mo_endian(dc) | MO_UL;
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
     TCGLabel *swx_done = gen_new_label();
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
-- 
2.53.0


