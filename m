Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C85CC4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZVp-0002eD-Hf; Wed, 22 Jul 2026 12:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVm-0002Xo-AH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVk-0001uc-2b
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFYDx11044081
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SvsO42z+fMRhgnR2H/WYmxk0aZPrJF+vcCqMZiY66to=; b=QhNm4FOAnzDpkrUs
 k0rc06Wof5z6W2rZ6GxsDws+Ga4WUBW+0swG/NXdoMrBxKR60mLkN2NBrc4E8UgI
 4UW1x8FUmq8TBPfEoy6jXRxBQ8+dmnbeC/z/UgC5ASvAJdSiIrTA3qVQCIMoRHEJ
 LIBYi52oGNAS8BShg3tGkPzTAduvfWe5K68+ro70kkmZvXylePg4cpq0Sft4KO+A
 BgHZwo23W8w7aNPUpCIdWIwzyXNGwKJPHFrIAHmeV6XJX4pv44MfRN1843L6wk11
 ftUC/u0bWSiBUCjANuINPTVf6zvXeVnpcUnykc5zpXYshvevp4ouVNJxkfLn1JMT
 1DVJtw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4u3rx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso47434581cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736525; x=1785341325; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SvsO42z+fMRhgnR2H/WYmxk0aZPrJF+vcCqMZiY66to=;
 b=QKKIZmKCTxVwHKdDhnL6pzWe1U110VdOuOxujxNpBwf7YX3nECDw1WVAZ9gZeNU5Bq
 ENg8/vAaaMUbZrKVsmbEm8S3QJh+Qq+pFB02921cNo30XxEMqdarPpaYr4BgHfj8l+FV
 LbAFgFJEutm+z4CUziNaF83PNIZwD18JVcFRubMwNcFb+fhZzos93zo0HsfAO2mnVoF/
 7PsfSntrdhQMQsjZAWV7hBmpcD7KsZAC2nLgHojb5dWS0mbJnkMWOe/FYitoramrOQpi
 B8Fq0vKv4caTD4MousIQ60KJhoi7+LaROEb8HzEcq9mraSvm9oiLqgXksAvMjcjIWshr
 k6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736525; x=1785341325;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvsO42z+fMRhgnR2H/WYmxk0aZPrJF+vcCqMZiY66to=;
 b=WQMsQ0ZtI1Dy2sqewDWpg4d4JDTIWaIWa85lYMeCve/RSFkmIw1VGtvraR4wfMm9XF
 f9qYPFfXn/OjXqZzmNW8qvRFky10en6+mlaSrw1NskXUC67AWmvELXcrWitGdzmzmYqL
 J1JvLFkrohPorZD8J1Qax76y0oF1snBYzBV+XEq9gv7rS6Nmb75vC920fHHYvHxX5Id/
 P50wdeNSeXhMlEFiALLkqW9xHJeTSBcQCGGdaXDFDTNHK6/ULPg/3ge+15NQUoKPjDON
 8N+4YO6qqtiTctW8hX0lwq7DMtmhsBfnsAcFvYACLu4KisEGgFhhTMkuxbyFOKNVap3K
 1xPA==
X-Gm-Message-State: AOJu0Yyb60U82vr/6uDcu6Zs3c2UJ7LbRF1Sn+389IppbFdSUIgW7Dq2
 EPRox5RqLiq7d7wyNF5bUn3FuQtLeMg/IPzm4t9zh0fhk73oQS9M8ipwhw4XMySUcMHEiDWGNJ8
 AX+6dS+BIdFTqeSECfcdJ5isSKvszyGE4LWDye/0Ai+shcgeQLGh7BsVV6LMjZrZe7A==
X-Gm-Gg: AR+sD10bAk/O6kv06TsmEbhXJnqKlkEoB0Gd4vb0grwSAjI6R8UTUDMf/FPfkkFuX+N
 Blw2HTvpIrLoK3bw7nvkDwJdeO8i55d7aeFzusZgAGzI7NeUsE+/f31RgzGP4XntYbY60GVvGoE
 PZQsAQuSdN/9L9/JaTN1jSvI/PSxtVZeiJTYf/A3qzTtS2QnBH26hg6PjghZ0l57vE/p2IZdoD6
 USeSZVGQlFDoE4lfjoeA/g8YpZq22DE0ofqKZZaX51zjnKM5TDmjdjl2+IDAIj+76b8wRcoa2F+
 4C4GLHHZtEJNHP1X7oI4lbwTlJZLNeGCQ1R0/hWH4kiO1b4O1Rr98eum/f6CbeK8p25o06ahyuI
 gziGyzBqn6R742z7yOsKvVhTqUFBCtLfR3xitQsD4cFJROzLokrYqCqM=
X-Received: by 2002:a05:622a:124b:b0:51c:168d:3ae0 with SMTP id
 d75a77b69052e-5213c007103mr213145901cf.1.1784736524741; 
 Wed, 22 Jul 2026 09:08:44 -0700 (PDT)
X-Received: by 2002:a05:622a:124b:b0:51c:168d:3ae0 with SMTP id
 d75a77b69052e-5213c007103mr213145411cf.1.1784736524296; 
 Wed, 22 Jul 2026 09:08:44 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653731b2sm159078625e9.4.2026.07.22.09.08.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:08:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 3/7] target/microblaze: Use TRANS() macro for typeA
 load/store opcodes
Date: Wed, 22 Jul 2026 18:08:03 +0200
Message-ID: <20260722160807.24031-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7deEJz30sGP5NUAMndLpvKGOosJyHFxh
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60eb3a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=y_U8KOlz_unyMUuETsgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfXyY1lJQtm7zGk
 njtt2lt0WIJ0Scq7CrPGcQF3eSw0Q5jbn4DKUhN6W88ToLk/x/tYSON5+t4hY2PN+sqcWySsbd+
 3y3t8L13NCfvHPTVCzuEGZJ1FBozJ97eck0sGNhf3dffCVRF4Be+PXW+0/nn5ob/MjhKani4Z47
 htppLYqNylU3Mdx7Osl1BxKl5I6wZdhEJ/HkwVyre7jTUMBcU65tU7+l8kINFcuJoXjFQIWYc57
 CP00scjHe6iB/nIjubacNlDZhBFPe6rkhMpemKjn4F9XcVGehJpleXWHbb0jrZAWPT7mS91mQtD
 NLdNxsHRvKtwvv8BkyJZCbHWlC2iUMoxS8Sna6h/JsJ6FYP5x4JogBeIUyWtpekUUjoXU0e5+A7
 ZMYPXQC91ozk1XrxliioX6uXc/ZrV9Db8FomacFQt94UjEB/LJDJD1p3g5X+4/1TGwphBFl0fRi
 NLv4n7cH8g/5Msl1Epw==
X-Proofpoint-ORIG-GUID: 7deEJz30sGP5NUAMndLpvKGOosJyHFxh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX1XtYPnksWFky
 ESFw5aCtMYIETuuFE5H0OPHtnEp/9YOVcvnFwQYiA26AITdyCTQ0nc26r++LCmh9iiTxd//6s96
 rcLrAaJXSD/YRuWZZ1CHufU63tkP6+A=
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

While being a no-op since the TRANS() macro expands to the
same code, this is less code so less maintenance.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 96 +++++++++--------------------------
 1 file changed, 24 insertions(+), 72 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a2a7ee8b9e0..3f2de375d97 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -746,28 +746,28 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
     return true;
 }
 
+static bool trans_ld_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
+{
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
+}
+
 static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, mop, dc->mem_index);
 }
 
+TRANS(lbu,  trans_ld_typea, MO_UB)
+TRANS(lbur, trans_ld_typea, MO_UB ^ MO_BSWAP)
 TRANS(lbui, trans_ld_typeb, MO_UB)
+TRANS(lhu,  trans_ld_typea, MO_UW)
+TRANS(lhur, trans_ld_typea, MO_UW ^ MO_BSWAP)
 TRANS(lhui, trans_ld_typeb, MO_UW)
+TRANS(lw,   trans_ld_typea, MO_UL)
+TRANS(lwr,  trans_ld_typea, MO_UL ^ MO_BSWAP)
 TRANS(lwi,  trans_ld_typeb, MO_UL)
 
-static bool trans_lbu(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
-}
-
-static bool trans_lbur(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
-}
-
 static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -782,18 +782,6 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_lhu(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
-}
-
-static bool trans_lhur(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
-}
-
 static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -810,18 +798,6 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_lw(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
-}
-
-static bool trans_lwr(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
-}
-
 static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -893,28 +869,28 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
     return true;
 }
 
+static bool trans_st_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
+{
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
+}
+
 static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, mop, dc->mem_index);
 }
 
+TRANS(sb,   trans_st_typea, MO_UB)
+TRANS(sbr,  trans_st_typea, MO_UB ^ MO_BSWAP)
 TRANS(sbi,  trans_st_typeb, MO_UB)
+TRANS(sh,   trans_st_typea, MO_UW)
+TRANS(shr,  trans_st_typea, MO_UW ^ MO_BSWAP)
 TRANS(shi,  trans_st_typeb, MO_UW)
+TRANS(sw,   trans_st_typea, MO_UL)
+TRANS(swr,  trans_st_typea, MO_UL ^ MO_BSWAP)
 TRANS(swi,  trans_st_typeb, MO_UL)
 
-static bool trans_sb(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
-}
-
-static bool trans_sbr(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
-}
-
 static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -929,18 +905,6 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_sh(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
-}
-
-static bool trans_shr(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
-}
-
 static bool trans_shea(DisasContext *dc, arg_typea *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -957,18 +921,6 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_sw(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
-}
-
-static bool trans_swr(DisasContext *dc, arg_typea *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
-}
-
 static bool trans_swea(DisasContext *dc, arg_typea *arg)
 {
     if (trap_userspace(dc, true)) {
-- 
2.53.0


