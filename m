Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6FFC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZVp-0002cy-0w; Wed, 22 Jul 2026 12:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVk-0002XG-9u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVh-0001uR-7p
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFYGfZ1044156
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yBU5BYbBYTZhZhoNqe8YB1loEJ4LBumSlubCfMjtGMo=; b=lDJsQeHrWgqSLvt8
 p/2Sj3ZBPeNGp8bOl6Pc4vqUWUZN3gMYz3pC1txpxm2s5NgLQDS0h/rzgZkmnebU
 vretved2Wdb83AjJxbBCFF9sSISvmqxUYaDH2FVfI8yAMGktmffuehVck3qWYrgz
 2szpPwPKYd1GQnxcVMd1SGIwjZB2jlc4cLyKq3Gb6fbkmKYZk/nAA9TnK9EQsNFo
 QV3pB3Ohq0bNQFjZlB5o4gdlwebG2QUHNBpDpTiAaWO7k6dVFcF04HAffFauCcVR
 TQhM4jkiChQP4D3tAoIVypT4CsOfrWTSg2dc9z2DtqPWl8CZgIr9dduur/YhZmyR
 O4Qd8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4u3nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so14718851cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736506; x=1785341306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yBU5BYbBYTZhZhoNqe8YB1loEJ4LBumSlubCfMjtGMo=;
 b=d1Ijdt1qSaeu2zuE8fielgI0BK1WCxJdqiV8BQlWHWmN6CzyvDCyv8gZ19PiI/wHwz
 tweZ2Kky9GQ4VVejERfJ7zjBBx760Mcd/5kqYoJitAzmpJAToBhsu6QvFtkQzso/dY7+
 A04L8MvhtMSurVk4BRfqDNigsVbcU4k/CRk8T9NcZ4Lqc26MBUSvnYCjozqmf2si5lpn
 Irbq0LTpF9KfPaBOGpQEJo0fT4Kv32W7ts1UJQbzWMlN2IyWVX7xgYwwTR+0lCOEUW1Y
 jS3NItI2JxVey35Tnd+1J+uEYSOncRo6j0DdUcsDz0IfwF4BQ8NHU7Og/S18zpG+ONJD
 hjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736506; x=1785341306;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yBU5BYbBYTZhZhoNqe8YB1loEJ4LBumSlubCfMjtGMo=;
 b=dRntNeYJRoKpgVzFqgG7OO2HPqVVIzC2AmEl9NKSQINNVG41bVJ3BaFqg2P1G5m6tO
 F8eUJDzKhoI6d0fQS+uYrMm2A3AU2uJcYPggHGosIyZ2jIPnhC4PlWWusx8cYtHIDEnn
 Xdo+c4XD2f4rYOBJAb16GWLSnQefPOHA6cRZTWQO9ewoD4fqy77dZQ8uvZw+FU9cV8CG
 yhqKyPlvKQwjePHbPswZ6HXN9Ap12XJaDx9fkkoxoP0izww8qz4WtBgDTfjQBAbnk79s
 BEISjSP51ZQSsIVzikoUw0YynFIvUfFyVSHiNvm1MLgCQqac1m7jAlD83++FrJtPk802
 oBPw==
X-Gm-Message-State: AOJu0Yxb/vHQqT7mV8BUrtIfADsIVU49OxiOJTpC8y6TcL75JuxP8I+T
 APXYXhuCDrOfbJrMC1Sv1xyZv+5gRGYSKKReOxMtN5bH0vo71beEvzKFaSwx2QIjXUE3X4Ihnbl
 AIEvGYI5U3wBSbGcDcnxjqiARd1k+Fzqm8iyeVien5tGmrsTwh0113FeowpzBWsySgw==
X-Gm-Gg: AR+sD10vEeazo8OpY8fFMl+7xCghhWS347EwLXr5/meILnHy8xGM7Q2m9ElekO5VdcC
 byIrvdnySh6e21r6OOGsGIJO58wxsj0NGUsC6yoTklBmVGBeaiBpRwsQkhdhw526QplCVnLgIPZ
 xu4cIHMy3qg0wSrpK2nfzcn2Vo0k2yXM+HKcznq8XqzHYZrSUpfPce1Z6vtNPoOJDQsBl+7rTYy
 VQPDZTLsj5gwHbi2eX0IPsB6qkSFPBFhi7cDhmGXHH8K9Xqr7vW5WbJv6rwuCE7WF+RzrYgCDB2
 H6ksMX4ZSlhb6PUBNL1oJcGjmFWmvNjv/1c/Mmi9vpiNA7G31C1rMajtKzsgYWzLnSSenLOECtK
 3WmKY/bkDswnqW3/8nDonxIA4Pkl7eXQZLNruLFpbkjnA+FCF0BCgTqg=
X-Received: by 2002:a05:622a:1f99:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-527a8178ae0mr49880231cf.21.1784736505486; 
 Wed, 22 Jul 2026 09:08:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1f99:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-527a8178ae0mr49879241cf.21.1784736504690; 
 Wed, 22 Jul 2026 09:08:24 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm5772150f8f.21.2026.07.22.09.08.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:08:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/7] target/microblaze: Set MO_BSWAP in do_load/do_store
 callers
Date: Wed, 22 Jul 2026 18:08:01 +0200
Message-ID: <20260722160807.24031-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4V6q4s0FuuUFzk2z6572Drxojsap5kuM
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60eb37 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AKhSjZXal8q_C4yPzCIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX9QovVlPSlINs
 70k0X9Vyy/0CIo2R+a/dL0oReBCxIVGuJKQgQ26pFwk4nSMpVBWUhA8KUIwZ/k4vcO5dqD41940
 uHQ8JwRiXg8r52fJnFBxcmGLaRkkUXz4wLfLljwYCpefZ7wLX+KLmyMAvBJNYunAAzbcOBjQJwB
 QTDnIh2KBLESxTkRZ98pe9CiCp1zQ2xoU7807GPKoeqHW4NuYVruaWVrGqxQ5hkuYv13bD1kP9E
 fYD1sgSZmL4IconpsKuN0PNmrMDevWqx8OmzLPEsy6C5MwAkRl4C0nuVecMDBEbeiPqiaVi0nlU
 vTwaYvu6R2rx5TBmmdqmX1XiI9NkzJf6Dshy7ZiwNvWXB9pMHLXV7vgENNQnLzuBlNfqcl6vHGH
 5KDRe9fwk0QmavxTQlh/zXfhycdoEJdeLD8dPdojvMXsa7J0q6+yGyKdGEnW15YAxdZuYJ5eubG
 /lkIiaXP62DEjnubC+A==
X-Proofpoint-ORIG-GUID: 4V6q4s0FuuUFzk2z6572Drxojsap5kuM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX5lu9jCGpILtE
 ECD+gNBnGeKDXkbl4xObMRue7Nc6UZW2UJD25UQ2/fWmx/N1JMjbWfa0VsBcehg3g7oVtm3q1pK
 LsHY6Sg4zS0w5L+e10BX/lZG4KhrWas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Instead of setting the MO_BSWAP bit in the do_load/do_store
helpers depending on a @rev boolean argument, set it on the
callers in the MemOp argument. The repeated caller pattern
will allow further simplifications in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 62 +++++++++++++++--------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..623980d0af5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -704,22 +704,17 @@ static inline MemOp mo_endian(DisasContext *dc)
 }
 
 static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
-                    int mem_index, bool rev)
+                    int mem_index)
 {
     MemOp size = mop & MO_SIZE;
 
     mop |= mo_endian(dc);
 
     /*
-     * When doing reverse accesses we need to do two things.
-     *
-     * 1. Reverse the address wrt endianness.
-     * 2. Byteswap the data lanes on the way back into the CPU core.
+     * When doing reverse accesses we need to byteswap the data
+     * lanes on the way back into the CPU core.
      */
-    if (rev) {
-        if (size > MO_8) {
-            mop ^= MO_BSWAP;
-        }
+    if (mop & MO_BSWAP) {
         if (size < MO_32) {
             tcg_gen_xori_i32(addr, addr, 3 - size);
         }
@@ -746,13 +741,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 static bool trans_lbu(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
 }
 
 static bool trans_lbur(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
 }
 
 static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
@@ -772,19 +767,19 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
 }
 
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
 }
 
 static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
@@ -806,19 +801,19 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
 }
 
 static bool trans_lwea(DisasContext *dc, arg_typea *arg)
@@ -840,7 +835,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
@@ -864,22 +859,17 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 }
 
 static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
-                     int mem_index, bool rev)
+                     int mem_index)
 {
     MemOp size = mop & MO_SIZE;
 
     mop |= mo_endian(dc);
 
     /*
-     * When doing reverse accesses we need to do two things.
-     *
-     * 1. Reverse the address wrt endianness.
-     * 2. Byteswap the data lanes on the way back into the CPU core.
+     * When doing reverse accesses we need to byteswap the data
+     * lanes on the way back into the CPU core.
      */
-    if (rev) {
-        if (size > MO_8) {
-            mop ^= MO_BSWAP;
-        }
+    if (mop & MO_BSWAP) {
         if (size < MO_32) {
             tcg_gen_xori_i32(addr, addr, 3 - size);
         }
@@ -906,13 +896,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 static bool trans_sb(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
 }
 
 static bool trans_sbr(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
 }
 
 static bool trans_sbea(DisasContext *dc, arg_typea *arg)
@@ -932,19 +922,19 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
 }
 
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
 }
 
 static bool trans_shea(DisasContext *dc, arg_typea *arg)
@@ -966,19 +956,19 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
 }
 
 static bool trans_swea(DisasContext *dc, arg_typea *arg)
@@ -1000,7 +990,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
-- 
2.53.0


