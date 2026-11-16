Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C8606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GHKeeatF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NItMCceT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63u-0003eC-SS; Mon, 16 Nov 2026 18:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63l-0003Lq-P1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63i-0003Jt-7B
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:25 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGYI2247131
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 stTMICkjGCrvlPzC8VPavhc/6phS6IuN9IpRBWXZ+vM=; b=GHKeeatFIyWUW162
 K+4pDuJuIVvJWjY5ShCfI2c/fngUBF2FqC6CSNl5fYsPJunVJZzbvEjD4lRs1OZb
 TvdhZaPlVi4lQHC69LD9wNSEgpg+OgMi1pWL4Ri/AApSApJ4+2ftFjoUrnjiAP7q
 mBVdpZ18MiI/TLd4oXbjOjTfaLmdRWuMBSw1a0dbovGAq+Vm1IGizh8fyhjRBHQW
 ZaEisEQqbCdpYcyk4GYKJM5R48SHTXXquI27xDnxYxK44YL6xoU1a1A4ZUAOilxb
 FQ3PtiHOx3XatHzSuoW8RMiqjlqDqzLKwSkMKQ8ULjXnBBZ+ttr1pepGNM8jb1aj
 OcM8LA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyb0k5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:19 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99e09f506e8so382929241.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871459; x=1795476259; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=stTMICkjGCrvlPzC8VPavhc/6phS6IuN9IpRBWXZ+vM=;
 b=NItMCceTjUIAAi1rfJMMUI8K+TGos8gikr5uq9LPbr8bvd1fc43Rt81wgn7y06yv/O
 f3ORPJR6KL/Z5Z3Sgxk/omO8w4NFz5Oo1XjxUARDhtfcNmrYnirCWGl7RwDERSTNPepO
 yi1NKDCdeOc8O/AMj0sIzls0iJVtZza21UB+C7vvj8HojhgbcfrbcgnSj7ATyD7p2uWQ
 SYIfVY0wX9JH5G5/ukQMumS4ig4ei/i/Lh7nW4ujT/g58V80nwClH6ePUTpv5QDtzg7G
 8khDsJNl6f8YvL8cHyxkw9lFeE7iDYPejk3i4lQa9EiIFjglhxBAK01D49pukyxzpzfh
 IOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871459; x=1795476259;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=stTMICkjGCrvlPzC8VPavhc/6phS6IuN9IpRBWXZ+vM=;
 b=sDcHpV0uS7b3Vahd4oSbLAzWfLUM23kG1L4hDd84wVgo70j2cbTvL5Ekd6BbOdjiwV
 IvmMJEROep/X2wMwlIq/YT0mzTx62RpX5aYXa+Wc/0kedHLHxvhTDCxo7743UgJd8i6t
 YOXS8EMfkNNp4kmAsCW+d9d3QqAcLbdNXi/wNR1lkb8/paCLQUoMA1Fi2INrtBWzpy//
 vRlHYE9210DGMPBASGsYKH/vFfxgiun64T9UZEhxoP3lVRMeLkCTZs+MJ4RqGv69uKFe
 8CNvVeWt4UDuPwtGVs20m7pqFSSLkgSNY/5Zcdpfk8jtItctZ/iSzzFdn3+oCYf5L8Yy
 SXQQ==
X-Gm-Message-State: APuU4Z+827tT7qfQG1/B63IpwvGtCmpsLxu8LXnRJVWu2KFU8oQC7SPo
 +qBw+H5Kqin+A8p1IxXbcEcg5gzVc+cava2fLpMBs/TgBhQZ1zUX4t3bNyM6y1A44a41oNxe1Y6
 1M6U9jTzlnkyyh0HAYJgeLg86L1mBHgBH11i7nAuELbcR0GNN0QtAzWfPOtaMGtOHrA==
X-Gm-Gg: AYBFou1oLPbg+ptY+oLTknsKklf+AXyE/E8XYF7orOQDaodjXViM/82XcwZ9qlxOBeW
 eEiGWWgKCe9MKoaTU7deNEfxgCv3JGH3otU/lK+6+UcMyMdFnlD3p8hN9uNaAxYvdJtlLgJWHr8
 70Pgi4VJbZ8KChgwisaOce8+ne0lzdfH7HVIfPrVkGDD6MmfTAzRx8b35sd/UyD6p3MpOayzAX9
 laX3Q3fINJ6PvvcadXx7wGUv3/Wz79/reJav/GmDRSlLSxrBAAfkOzic3WqHcEmME0b90+AVlbC
 4wW0UHZ5hL6SMeeJQInVOGdMmeWyDEkzMBiIYTLggOo7zbGVr1P4ie+NtgSANaLOQ3gDWCefVhq
 wxUtquxWssnNmnaonwJ9n1ER8qlObX+dsQ+Dby7qCqL9XLiPldQaADa4ivrbFCRB2S7eJSFbvk6
 h7eNrEVzQ2vLwPQw==
X-Received: by 2002:a05:6102:4412:b0:7c3:68c9:d24b with SMTP id
 ada2fe7eead31-7d64d767b54mr3211356137.17.1794871458452; 
 Mon, 16 Nov 2026 15:24:18 -0800 (PST)
X-Received: by 2002:a05:6102:4412:b0:7c3:68c9:d24b with SMTP id
 ada2fe7eead31-7d64d767b54mr3211352137.17.1794871457965; 
 Mon, 16 Nov 2026 15:24:17 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm23882305e9.4.2026.11.16.15.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/22] tcg/riscv64: Fix logical vector immediate matching and
 emission
Date: Tue, 17 Nov 2026 00:23:18 +0100
Message-ID: <20261116232335.31593-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXwBQxCiEDCgdn
 anFQP6ZLzIVqL6OVGmUmMxGkDdbc/gOsCSL5QGTWCcWsycsi0wvCUnHQuDwLps0Cz8bQuFLyfPh
 By7FqWVqlIxv51BvDIAmFdY2PR4W8lQ=
X-Proofpoint-GUID: XDXzDVvJBA0KmV6fHyUZfwwom4voqJeS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX/vb+80PEZp8F
 z8fjI4E4J/fwAmxPUPTcTsaRsf8BRW6eclSf5IIz+kJmRfiZQI20KPGYSOKdTSqlYIIz4O1OBy3
 Gh1TzXghXnds44JImTOX0Cvx0CpqAbM6K0KT/+PIYlizS+szOHUQxbsMMK8MnSCqpaB0yvTwF90
 pAHhlNDyq6uNhhUaP+TNr9+teR/Zs7c2k5QXqEkgvQn9B9UjcABY+kRRTrbXXUgBvb/18ltL2KQ
 bZ32OloX1NSsYkRRXGK2WCTFc5AFE0m0kakLS374j+rHNmwbyPcQdloB9uBOrVAR4w74XbGIff5
 QguqeLFQPZUkhDAGUdOdN8wjXEeFdOYqfyJRpr/71QxC80qI65lIELr0Fi89XBvVV9X9t+2+7Q6
 tKtHiIhMluLWGYVO0fUiuoKE4051E8i1FpjnnJ32QH6oVKRRbgQzzGoOcHu6noT+713aXC7UZmi
 /LPqK/AZ25e8NRd/4+w==
X-Proofpoint-ORIG-GUID: XDXzDVvJBA0KmV6fHyUZfwwom4voqJeS
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb90a3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=hXZgYZo4AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=DVuiCnNqCGsytsSSeGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=37BJPeUnzxYkbV1yBC-1:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

and/or/xor_vec are bitwise, so the generic layer doesn't track a
meaningful VECE for them (it is always 0). The backend nevertheless
matched the constant as a byte element, and emitted the .vi form at
whatever SEW the previous op left behind:
"bic v4.8h, #0xf0" became "vand.vi ..., 15".

Add the 'N' constraint: find the smallest element size at which the
constant replicates; the constant matches if that element fits simm5.
The emitter then sets SEW to that size. A wider element can't fit
when the smallest doesn't: its upper half repeats the smaller
element, which would then be 0 or -1.

Cc: qemu-stable@nongnu.org
Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20261028143330.6518-6-philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target-con-set.h |  1 +
 tcg/riscv64/tcg-target-con-str.h |  1 +
 tcg/riscv64/tcg-target.c.inc     | 53 +++++++++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/tcg/riscv64/tcg-target-con-set.h b/tcg/riscv64/tcg-target-con-set.h
index 0fc26d3f98b4..9b4e219fac16 100644
--- a/tcg/riscv64/tcg-target-con-set.h
+++ b/tcg/riscv64/tcg-target-con-set.h
@@ -26,4 +26,5 @@ C_O1_I2(v, v, v)
 C_O1_I2(v, vK, v)
 C_O1_I2(v, v, vK)
 C_O1_I2(v, v, vL)
+C_O1_I2(v, v, vN)
 C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv64/tcg-target-con-str.h b/tcg/riscv64/tcg-target-con-str.h
index c04e15ddfa3c..d7e8b2ce4f2f 100644
--- a/tcg/riscv64/tcg-target-con-str.h
+++ b/tcg/riscv64/tcg-target-con-str.h
@@ -19,3 +19,4 @@ CONST('I', TCG_CT_CONST_S12)
 CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('M', TCG_CT_CONST_M12)
+CONST('N', TCG_CT_CONST_LOGICAL_VI)
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 902e600a1f51..4e1c68785d3b 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -116,6 +116,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_M12     0x200
 #define TCG_CT_CONST_S5      0x400
 #define TCG_CT_CONST_CMP_VI  0x800
+#define TCG_CT_CONST_LOGICAL_VI 0x1000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -385,6 +386,22 @@ static const struct {
     [TCG_COND_GEU] = { OPC_VMSGTU_VI,   1, 16, true  },
 };
 
+/*
+ * Return the element size at which VAL is a replicated simm5,
+ * or -1 if there is none.  Used for vector logical ops, whose
+ * VECE is not meaningful.
+ */
+static int vec_logical_immediate_vece(int64_t val)
+{
+    for (int e = MO_8; e <= MO_64; e++) {
+        if (val == dup_const(e, val)) {
+            int64_t x = sextract64(val, 0, 8 << e);
+            return x >= -0x10 && x <= 0x0f ? e : -1;
+        }
+    }
+    g_assert_not_reached();
+}
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
@@ -392,6 +409,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (ct & TCG_CT_CONST) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_LOGICAL_VI) &&
+        vec_logical_immediate_vece(val) >= 0) {
+        return true;
+    }
     if (type >= TCG_TYPE_V64) {
         /* Val is replicated by VECE; extract the highest element. */
         val >>= (-8 << vece) & 63;
@@ -2786,6 +2807,23 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static void tcg_out_opc_vv_vi_logical(TCGContext *s, TCGType type,
+                                      RISCVInsn o_vv, RISCVInsn o_vi,
+                                      TCGReg vd, TCGReg vs2,
+                                      TCGArg vi1, int c_vi1)
+{
+    if (c_vi1) {
+        int vece = vec_logical_immediate_vece(vi1);
+
+        tcg_debug_assert(vece >= 0);
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vi(s, o_vi, vd, vs2, vec_imm(vi1, vece));
+    } else {
+        set_vtype_len(s, type);
+        tcg_out_opc_vv(s, o_vv, vd, vs2, vi1);
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2824,16 +2862,16 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_and_vec:
-        set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi_logical(s, type, OPC_VAND_VV, OPC_VAND_VI,
+                                  a0, a1, a2, c2);
         break;
     case INDEX_op_or_vec:
-        set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi_logical(s, type, OPC_VOR_VV, OPC_VOR_VI,
+                                  a0, a1, a2, c2);
         break;
     case INDEX_op_xor_vec:
-        set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi_logical(s, type, OPC_VXOR_VV, OPC_VXOR_VI,
+                                  a0, a1, a2, c2);
         break;
     case INDEX_op_not_vec:
         set_vtype_len(s, type);
@@ -3025,10 +3063,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sari_vec:
     case INDEX_op_rotli_vec:
         return C_O1_I1(v, v);
-    case INDEX_op_add_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, vN);
+    case INDEX_op_add_vec:
     case INDEX_op_ssadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
-- 
2.55.0


