Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF62606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D5Hyhf3A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=imFNHAZt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63U-0002wA-88; Mon, 16 Nov 2026 18:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63S-0002uB-Pt
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63Q-0003I0-Vn
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:06 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLHQr72246553
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1xBUXHNusdYQTI9cp4cRO4p84pr3FssdBWxFvwqpHRs=; b=D5Hyhf3AxAWYgF+g
 cniZgoAfSuZx70pgcw3u7x3BDKNNQfQQzyBU+0AVuIX+C5ELByBmZyflSci9Hjec
 rfRr8uME9iH7Mu5kQeNLRHtfPFMOTmcqn2kgF+ctVSRWPEgUw3VVczY97DIa26bh
 wOToqL1Uu3Xh6Ua4AhsCtOUHoJgidDPt12Y4Vez2VwQscdFWa68gZTZlkd9XjOLW
 /jcabyjvzFYdVEqd+TuXfp0Vdwg8L34XQU6ajQEtooqv6mXPcISD7PjAaF5w7Dx+
 hKAHeBPRlL3G4vIuZ8HWWEa9YUqlr3JQQCPNDmDpAlHT3RpKIZ80pt7nlxuIBwyq
 VSPESA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m08d2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94961ed97d6so69780285a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871442; x=1795476242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xBUXHNusdYQTI9cp4cRO4p84pr3FssdBWxFvwqpHRs=;
 b=imFNHAZtaug2Ec0zV4JXshnKjEkrBw9wKd1jP/ZOY0J3APv0+5t5E5i1zwW1p7etYz
 NA/jdm3v5QDrgJysHXT9M0nAe6+ui4ruVpCKqCKf07roErqTCE38YwN1DoFXz0CYcrfs
 aOcEUZhAsCGEbIoFTl6DM1rrvPJHuRXsQPsB+9vIhcvsZL/QaTHse4c0bJ3eAv2aWIg9
 aKBqmPYb7Ia/IgTMYFF4p1nJTsaPSsXlyBy03JukcIN9wWK3D0Vc+vPvfMQZ4CK3LYe9
 vJ7DXNe0IwH9/AqjHztJ20Mr2h/O0PbaIFkbmW1RqGEACmcl+Vu2EXy9y13rRFUfk9f9
 b7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871442; x=1795476242;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xBUXHNusdYQTI9cp4cRO4p84pr3FssdBWxFvwqpHRs=;
 b=dnKXb2Zab2TWCX5uER+JR4taitFK8R6O1SxjEIuvDJIDz5cu31Ads7ccNXJHlGcoao
 jmJLx9VcI743zh8HTd3uLLH+EcccbSOYShqXIClroeUaIC+ntw6gjr5+8ECRV6FTcjXP
 pbxuZRwNlrWnPv7rzygkGUKD4QoCHPSRKEFs1phTqvtKmI0i3H3Q48ZorY2PGRghI+Y2
 785/lUg8v1hEOHa0/mj4PKieAbRzbrMtT7iFp567TtiGzJIkRPRIjB0Dq1/LAKKTUjh6
 RnkI5bX2XMWe7N4yZqWKrql2eG1j9PXI8iXCk/HxVDQamsCgUs0BBbkjKAoV3y9pGFRr
 JDMg==
X-Gm-Message-State: APuU4Z+zUeKANxUJcaxscY8WYPUv+/or9H04x22zv2Q7TcXZ3KPDapBB
 vyPC5/BM/QrCsP+dUUr/2PnkvOeEa+845n6o1AJtGT090IhvUZi+NydeVWgVxxEd9afBvxYoPS8
 c/2Q/hlUxr+FFaYdnEKaicA2JW7dIk7BdF+fZiI1V19eoEp/Idl9RQ7Fijv30wcYbXg==
X-Gm-Gg: AYBFou29frxOQmofvgfXJe4lEjW3YrTP02XnfFlhbBTQ6fGvxdzrIpU+tNf5/HTCo60
 Gl2zjFUNdx7hyZnF2wSTfaLgQyv8xkjSiXCoTp5SM7qwYg8lljtY1bEtD6iw3CV+74Brj5rfyIJ
 HVjsF8Si7PJ3EnJra8PvXw9QcOrMF8lExFb17LSTekGddjBrnfSkB8HHF48u7y8FVKkcVqOtuqQ
 D+ZI7FnT4YubJl2N3WnD+190CfUmp6hBNeZdlScApEQ/sfTw5HQXlPp+2swDwISXY0Uf8nuo9LC
 r30TuKeb6i0ueplWiK8gEjoOHXSGBQ0jr8sIj6M7524Tsf2XDd52YyYxG1hOB3N8a2edLGa6kPs
 mkRle32rjbz9qZnFyO9WM6xon6bEsQUIIg1l+P7X4+m28CJHH4CPKD0DZSm4pT2DN03V/gCHzmt
 CEwnvP39zqd+UH0g==
X-Received: by 2002:a05:620a:1727:b0:949:6e10:b8dc with SMTP id
 af79cd13be357-9498b8749bcmr205453985a.13.1794871442161; 
 Mon, 16 Nov 2026 15:24:02 -0800 (PST)
X-Received: by 2002:a05:620a:1727:b0:949:6e10:b8dc with SMTP id
 af79cd13be357-9498b8749bcmr205451685a.13.1794871441680; 
 Mon, 16 Nov 2026 15:24:01 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608cf46dsm26427362f8f.43.2026.11.16.15.23.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/22] tcg/riscv64: Extract elements for vector arithmetic
 immediates
Date: Tue, 17 Nov 2026 00:23:16 +0100
Message-ID: <20261116232335.31593-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX3WBWFE9fUeF6
 XIEfcvZIhqzc3cheNP2LxtTTukZEOhMzBxJ5IjdwruCDSCyaivVznsmUisZkqK7MpcV8Bi4eUDQ
 dhq+9p7QdjRCZmdvb6GhCVCzgbgRs88=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX0HLG7cr2ZvE8
 zJoO79lKGdM7LVBHLRbRbj0E+F81JoOD1RfzGMJvv+sqt/f+WaMphl3QcKYIaeO0thiTK8Mf/TU
 p5C/jxWBczmCaqU/2GTrWXP+0f3dHFkle8158CUa2ClRg1KhXSq13Fd0dc0SvxhyGFPvpdKtKI7
 99Vm/zmvG9iOEYNryTL3YVlNj/7DpJmL3mEAvab1CAUEF4P2PSd58MDvLY/ZCm/I+/R++1GzBsL
 AEQZGVZSKWzQKRYI/Dccr/Cui77wiIe2zyW+YHQU2/8vPGrMxr6sVvJtAONcc667m68OBUwrF1G
 v17NG8LuTcUUeqywfrUSxrwE/EOM2qPhkPFqCiRu6/MiwtNTUl4zSGInZpyDrIkHbuIS3DfBl+D
 PIhDy0++75ZvNtEjOJhw+FrdsrG1LdBLveO4JMvl0/c/GcxYOI1eHtS5uszJRtM84qk49F5LcnW
 mctN1eDmZ63fRZX2Pqg==
X-Proofpoint-GUID: o97u7kN4ZlzEWIm-w3qbpmQQETrlBt0m
X-Proofpoint-ORIG-GUID: o97u7kN4ZlzEWIm-w3qbpmQQETrlBt0m
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afb9093 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=D18SiYA2RP15glVIWlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160093
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

The .vi emitters pass the whole replicated constant (e.g.
0x0505050505050505) instead of one element. The encoding is still
correct, because encode_vi() keeps the low 5 bits, but it trips the
range assert added in 006352d69f14 on common vectorized guest code
in debug builds. Extract the VECE element with vec_imm(), so the
assert keeps checking that the emitter agrees with the constraint
matcher.

Add vec_imm() to extract the VECE element, and use it.

Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261028143330.6518-4-philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 002b3b4b780d..55685db44f3a 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -736,6 +736,12 @@ static void tcg_out_opc_vi_u(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi_u(opc, vd, imm, vs2, true));
 }
 
+/* Constants are replicated by VECE; extract one element for .vi forms. */
+static int64_t vec_imm(TCGArg arg, unsigned vece)
+{
+    return sextract64(arg, 0, 8 << vece);
+}
+
 static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
                               TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
 {
@@ -2805,12 +2811,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_add_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_sub_vec:
         set_vtype_len_sew(s, type, vece);
         if (const_args[1]) {
-            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
+            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, vec_imm(a1, vece));
         } else {
             tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
         }
@@ -2841,19 +2848,23 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_ssadd_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_sssub_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_usadd_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_ussub_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_smax_vec:
         set_vtype_len_sew(s, type, vece);
-- 
2.55.0


