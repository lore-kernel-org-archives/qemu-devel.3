Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D65C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZVR-0002JT-7z; Wed, 22 Jul 2026 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVL-0002I8-1l
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVJ-0001sa-6E
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFXo5M931297
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /cEruVVgq7yuWUf9tj0PBEIzuh3IDcYS759ScHo1ykQ=; b=lUShOLkwc0JYNxci
 dbjK3vRc40DqDBvTzLe7lVXtDgwaVQ50GWbn+agqAgTipmTg8W+6KH6SPTb+78fv
 LdycY2EbPIqEeOO7zpznkQUN9MalRqoZoVR4NBwbnHxBlCJSF5G2uUMXIzlh+KQR
 YE340Z8Zt8KNRYsT9EZTeYA4v1m+rUw9erlK0B67bgFJCNG3yyT8iwJ1gFL2EZDo
 Nhhb/njHUvNNZfFqoHrWATjZM1H15Vam5dEgJiD8bQpV+MgbOJt4Gsi+xZ72CKp9
 bMaMhDlWTTPFRomE9SnddcDkbOrLpvyh5dNXTmJ+bh7wdbTg+RafAFk2sm96gH57
 3/+h/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fju229s5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso149822531cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736516; x=1785341316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/cEruVVgq7yuWUf9tj0PBEIzuh3IDcYS759ScHo1ykQ=;
 b=ZHCzHSSwx63Of9Dg0byYG6lpEKsxG7vrpcTPHHTC/vsP5UIY/+dYi33N5wGvyDck4Q
 X9PUmeJzR4P6CztAoDSRwkrhujnU8kyOUtqX/PjodNn44DFH/ChgDkn+wlsVz4ZpQsmc
 rspYPw3osaLeiR3GQZ1blOIR0tsYyUG2ZZoagDjxgidssxO9K7AYiJkIHQNbYMUTc6mz
 OJw+ATmvk1COqysXYiG2lAQrCFsJSO1PaJXaNrAbAqEB3xjjewy7I0RxtGFzCulJIdUb
 mnxfVLP4CG6/cPzChULKXTJ9Q6nADM9pFOzoEM1YADgaDif+e0Rrd5VTUWkhBMThnw3G
 AzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736516; x=1785341316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/cEruVVgq7yuWUf9tj0PBEIzuh3IDcYS759ScHo1ykQ=;
 b=XxxURDp8mNjtvjVfCNcMROG1YxJeRHu95MIfUKweQdGSPyIxZoTjO34XSuWfX7MDmZ
 lRQ0IyaDFgOjRkdzA3y39h4hFslV7KlvqV4np6v5BOrlMc9Dh7Gt5w3O+BVqqWSUlNAw
 YDTIWdYufBYPHW2OstJ3Ahxof208V48op+xZxyjRXbyZJGMe21dpZFNEhKoW0fM5RCOZ
 pLUsOuJCe5hF+mvlIH3Sy5nZk06Tjdel4cSeljAGqjqnYKqUsl3c3fIkQcBwQtEpEZRK
 9Sx7FkTiMxlWka4KRTyj9K7pHpnNVtoyYywrYRU2wcozW7rm1UowHNB3r8LwDttHSkOr
 Df3A==
X-Gm-Message-State: AOJu0YyImLXLiltb7V1hLKiHYt4Ble7d24OvP92RTenSI0XhRaO1JjCg
 Ixb0/Y2woKJl8fuLTDbBepJjAUigUb+tXAlfRSULCjiVjT3IKwvmfjX4HHl4y2Ydh1fDEU4XjR8
 o55xTRkdwUfsb614gvJ9CZQhXX0bVPsb2whJKKuydmnuHZNx65n87/oc+TT9OOn1wfg==
X-Gm-Gg: AR+sD12uuRrjBKa66XwKAhSd/BBXs7YBQ7jFRY3HMncm1KfgPQGjykW/Hlcz5CBD4Dw
 yQeTDgkjYmtmcNFPpaV5GCV+JSBEkOIsMNlG30wnVvRZnwjfUh47PG/cK5eSLbN/VslEyScbsNp
 tIDULSpjXhA6LbCf+iinbr15KzI1l4Y/N8nUhcZlPE+Ga0CtkDPc+t6L7VKUcjTLiZPoLgi9rMe
 x7unjaJzmRlNU4qxclaLdpwMJa6QkucYJOYwzY+gPeN5v31pNXfn6Pn2lo85Yybq2UrObPm4KsP
 pLQo3aYjiOb+TGZai5TpHi4deWyHEJHXzoqVxDQawO5pIKXWDryd7LgkNzMjSSyMwPvm77B7bBL
 MtwB5E4PySKtc56GO8zjayZHXnD4htqIZVUHduxVpTyVrkChFhFy2gTo=
X-Received: by 2002:a05:622a:5cd:b0:51c:1291:911c with SMTP id
 d75a77b69052e-5213d2b728dmr222076611cf.14.1784736516277; 
 Wed, 22 Jul 2026 09:08:36 -0700 (PDT)
X-Received: by 2002:a05:622a:5cd:b0:51c:1291:911c with SMTP id
 d75a77b69052e-5213d2b728dmr222074131cf.14.1784736513216; 
 Wed, 22 Jul 2026 09:08:33 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm7251067f8f.37.2026.07.22.09.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:08:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 2/7] target/microblaze: Use TRANS() macro for typeB
 load/store opcodes
Date: Wed, 22 Jul 2026 18:08:02 +0200
Message-ID: <20260722160807.24031-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4Bi7mTe c=1 sm=1 tr=0 ts=6a60eb1e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=iLq48__BculcxcqvwmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: FF4zWAqv6l7zxQA1xKW9rL3YKxUtOd7P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfXwhozFXJxVKfo
 zyhNmYuGOxbT7nq7wcDDwqQTbairtYdsbQGivbY7/m+x1SqZQOq6z5YYvN0PCQncFbiSfUh3hUr
 UtE5nPbc89ahBYOKAw4WTlNtHb2Wld4=
X-Proofpoint-ORIG-GUID: FF4zWAqv6l7zxQA1xKW9rL3YKxUtOd7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX4vnZyi+G5Ske
 0CECSrgLTvqQYbuHUeeFaFiZwesmJSpyguh8oaVJTegrLZDdkojyYdJCMIWe3bbwpSbjMF+gkut
 LmmZHCEUBXUUMU+uP0Jq21vxvU/59kcenHu1H5JwwyXYoOK7DKIolUlTcVg18nwitDwmqpXhgHZ
 mG4ltZbri5i+LKSxZ0WbUO51Y/gwP9naFJ0ow0RCvrX5Oq3LkyF3plFjR5IUsG9w5vZhkAhsNk0
 tIMsPxZVq6lLV9DROYB91+JlYzKVhjQA09E+0+2e9vLu+/IXQCkyEVZ+5LG0E6eP4QqwsoTudN2
 EFn6KnnTgJ4MfZePEvKiTub18ZBxhxmcApWbkxkxM9Qd63jga8SyYEWTYmx7+hFxf/A4QKHf9Rq
 eXWKTiBVMIwVDLmzHlBIeHyPkJxUfdoDMlH35d5fx3etnygSBMY1B/6nbx0yeJE1d0C7UVg0BHk
 VFJDPBlJpzz9TcXeDIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
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
 target/microblaze/translate.c | 64 +++++++++++++++--------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 623980d0af5..a2a7ee8b9e0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -253,6 +253,14 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     return true;
 }
 
+/*
+ * Helpers for implementing sets of trans_* functions.
+ * Defer the implementation of NAME to FUNC, with optional extra arguments.
+ */
+#define TRANS(NAME, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
+    { return FUNC(ctx, a, __VA_ARGS__); }
+
 #define DO_TYPEA(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
     { return do_typea(dc, a, SE, FN); }
@@ -738,6 +746,16 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
     return true;
 }
 
+static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
+{
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
+}
+
+TRANS(lbui, trans_ld_typeb, MO_UB)
+TRANS(lhui, trans_ld_typeb, MO_UW)
+TRANS(lwi,  trans_ld_typeb, MO_UL)
+
 static bool trans_lbu(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -764,12 +782,6 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
-}
-
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -798,12 +810,6 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
-}
-
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -832,12 +838,6 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
-}
-
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -893,6 +893,16 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
     return true;
 }
 
+static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
+{
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
+}
+
+TRANS(sbi,  trans_st_typeb, MO_UB)
+TRANS(shi,  trans_st_typeb, MO_UW)
+TRANS(swi,  trans_st_typeb, MO_UL)
+
 static bool trans_sb(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -919,12 +929,6 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
-}
-
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -953,12 +957,6 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_shi(DisasContext *dc, arg_typeb *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
-}
-
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
@@ -987,12 +985,6 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 #endif
 }
 
-static bool trans_swi(DisasContext *dc, arg_typeb *arg)
-{
-    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
-}
-
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-- 
2.53.0


