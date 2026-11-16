Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEF606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j5YGOvAW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W8JP+0pG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63P-0002lv-Tn; Mon, 16 Nov 2026 18:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63L-0002Ts-9X
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63J-0003HJ-Dw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:58 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfHO03505007
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ii1n6Ue80FfE5h/oV4uBv7iqrNvFk0cgcJDVyiTQ5ec=; b=j5YGOvAWmsoi3/EL
 EEZshRt8vFH1XukdzhoVfWrfgYzPf4CIaAYxzBILISXRMozIjUxnun4HeVyxaHIn
 zSV9wUa3QoWQcQk2QNeZWQz7RkirFJ4wQ1I+HJU20iZ7hGVNUe5z0waRHXeONnw8
 cpEy2kuB4+za96ajEQY4qXhA9PnKJKKjs+V/SXlTzfC1S15hbDUU+zA/kX8Pmj4d
 N6s5b1a2/6sIsRxnNTkrPnE/ffx9kJYJJC6pF0jkOBdfECvPUGcHSLCktla+xwX6
 BLAwIyetmntp/Wl12tDvLDvmS6JUwzZdk5YtWe0qEPMUSWmUBX1y9CTTVpcjXcz9
 Mx6sDA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038ma3td-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960131befso483383785a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871434; x=1795476234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ii1n6Ue80FfE5h/oV4uBv7iqrNvFk0cgcJDVyiTQ5ec=;
 b=W8JP+0pGToIltfYZI38oBBss0VBZrI/RLYjIt5tQo7HMWx8Rrq9ulP9V+mil2mOREK
 qQEudNmYE78OfwA3YD+rFCGUNUKet+JC3qiNNdEef406tapJ2WxezuCEIB15y/hy4Arr
 umF29DPL4s6CGCAUlYrUxpcNtTqpE5JOM///SIEY6AuWixeXeBh1Rw94z5ua63iNeRHg
 s+4oOLq1oFsIGffZywwznLYoqSBaB6aZA9fdCCYAM6guzhNZJihBYDCa68ka48hdnAw/
 rfMBOGR4M6bhKBOpxGdSeSikUHJepUKcSsjEHZO0X9X+EpdXAwtYfjGX+09/31NyDhYa
 Qumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871434; x=1795476234;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ii1n6Ue80FfE5h/oV4uBv7iqrNvFk0cgcJDVyiTQ5ec=;
 b=fb3AmmC1NBTt7N16FjSlpyLDJPLACGTMxMlLZKywh4o246Bhi4box9ihBd6rqzDUfG
 1OCkykxCwovDWh0Hy5pEpNxrAOkmqjv07LCm6ERT0QISAgcF7yUTy0U4D0chJuR4FqbT
 LuQl1CV1OjICgJE3bcLj3T0OvxFytjonyPd7fPf/RPpLY5SRGIJUaU8mG3+8lRhTPbXK
 JSfEDCVqqnQYlUbQva/mktK9g2lD9d7slayPyCrW5Wp+QzQl2lNg/bqBv4DQuKA4uaDd
 NlhvHOtHKLGOiAk7kYU7QpgTvBC+jd38RiSC1c4TOTaGaL3ougJrJv/3pu63R35VTHxV
 gJaA==
X-Gm-Message-State: APuU4Z/LAdhevkubACLBWZs1tiUZNn1EvQLBL/qXMnisvpDmfrAZ3Oil
 Mbpbykr309IMXwPhEKqWikOX75ab1ia6cMmraSq/jhSmOHiPeNzv2Q00wBli5pyzC+pZzukSW5B
 K82kmCBmiNzbhGRzgHY1BZcZH4EZxvftT605DH6SZSLuxjcl2taA9KqdoF7ZDJSUXig==
X-Gm-Gg: AYBFou2nIkrjm/fdHVbrmNKioqUPKX6gX4+wvkEjDRaI9sTQ8WaqqGJFFN+KfgEMlgH
 M3dCBGSL/RNHbfgSOjtmRYcQAgNYsyQpN7fme8ADa/vrRLYQfngonTZl2/fQh2nq5x73+KqjIyd
 /r0cbs34WHW9kycsfIrdvaq4f3h0NpnC2zpIfwr+7zAOcsTppJC8MKkRVSbvgjXRhelGVpsnid4
 rxVer/zkBBkNufDBiIQBxmTh6YI9YY7+dZBCDb1/xsYN8Yls8GmRzI2xOPMO8uy2Gj3A1tlm2jR
 bm8O99UJ6TCkjIsjKvcjTC6mbFvUVnbxA3sBOhUjnVR0MS+OnI0UjICb0SNDxOnF015pZLHN63m
 GW0qD1YZVEIU/pMjvbpGOfN0F1PB3hfOg7ja3ID8ckWyyL5RdIbIy23j9JZt1hyNA8sk1EyUt9O
 Scf4VazOn/nngV+w==
X-Received: by 2002:a05:620a:3196:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-9494bc9b233mr2027943885a.70.1794871434206; 
 Mon, 16 Nov 2026 15:23:54 -0800 (PST)
X-Received: by 2002:a05:620a:3196:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-9494bc9b233mr2027940585a.70.1794871433750; 
 Mon, 16 Nov 2026 15:23:53 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a2ea918d24sm3209329f8f.54.2026.11.16.15.23.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:23:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/22] tcg/riscv64: Use a uimm5 encoder for vector shift
 immediates
Date: Tue, 17 Nov 2026 00:23:15 +0100
Message-ID: <20261116232335.31593-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXzD9MPPGb0PQl
 vgE8emT0xp62NKq99/0Gdzd3kC6vzJaXKJuFwUULUwwtYvrEEjBP2xGi4ggzHUjePagNdTgGcuG
 VkzvkN5osXrojk3bv2S80lRy99s5FbukfLe6o5RFv8vhf87ugmWlylkZH4HpTDA/Pbe0Wj4hP/u
 ubhhdvsd0wAB0tzsJCXx150Kjwxt9vD3yENS3TTvHgx/1j90CPqhyaZMFz79SRaaov+dV420VjN
 gE0oGNOFImoUgArxM9QuMOu81P07JOk+mLn2WNBebvq46Kek8WgaoE6Ay7sLtpbNN71d19sAc4J
 mP4ydQ9dDs0yjRZkPngf97ODu29Zr7XdtdsRPaIIZUdUH/2dhyRM0M07KFYqXb3iUYlYMVbNoe7
 WqWn7U6QQS4CjNDz2gDTzGBJ/vfKxt1QzIL1JOLVnZihWuQ8issKva/VkGzM8aIOjNEB8b/hywd
 Gtq/ckppneqbrqVZDgw==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb908b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=hXZgYZo4AAAA:8 a=vwcle1UgPbd9zKqFLQ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22 a=37BJPeUnzxYkbV1yBC-1:22
X-Proofpoint-ORIG-GUID: 8PArY922UMyEkoWCpTg1GBRQhj3ZYbKg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX0vdTyJ34lFFU
 jUiGPp2/8lVO29z+YXfj12BefMd7rIxAV4xMa+33oa8iL46AJAvLOFeIr1U5cXhKLVERuY+1PJd
 5YEg1Da3qxwQaMnwU43A1OsEHGfv4AE=
X-Proofpoint-GUID: 8PArY922UMyEkoWCpTg1GBRQhj3ZYbKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
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

RVV shift .vi forms take an unsigned 5-bit immediate, but
encode_vi() checks for simm5, so shift counts 16..31 trip
the debug assertion (and are undefined behaviour in release
builds).

Add encode_vi_u() and use it in tcg_out_vshifti().

Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20261028143330.6518-3-philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 319d5523fe7d..002b3b4b780d 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -542,6 +542,7 @@ static tcg_insn_unit encode_vi_raw(RISCVInsn opc, TCGReg rd, unsigned imm5,
            (vs2 & 0x1f) << 20 | (vm << 25);
 }
 
+/* OPIVI with a signed immediate (simm5). */
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
                                TCGReg vs2, bool vm)
 {
@@ -549,6 +550,14 @@ static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
     return encode_vi_raw(opc, rd, imm, vs2, vm);
 }
 
+/* OPIVI with an unsigned immediate (uimm5) */
+static tcg_insn_unit encode_vi_u(RISCVInsn opc, TCGReg rd, unsigned imm,
+                                 TCGReg vs2, bool vm)
+{
+    tcg_debug_assert(imm == extract32(imm, 0, 5));
+    return encode_vi_raw(opc, rd, imm, vs2, vm);
+}
+
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
 static tcg_insn_unit encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
@@ -721,6 +730,12 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
 
+static void tcg_out_opc_vi_u(TCGContext *s, RISCVInsn opc,
+                             TCGReg vd, TCGReg vs2, unsigned imm)
+{
+    tcg_out32(s, encode_vi_u(opc, vd, imm, vs2, true));
+}
+
 static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
                               TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
 {
@@ -1579,7 +1594,7 @@ static void tcg_out_vshifti(TCGContext *s, RISCVInsn opc_vi, RISCVInsn opc_vx,
                              TCGReg dst, TCGReg src, unsigned imm)
 {
     if (imm < 32) {
-        tcg_out_opc_vi(s, opc_vi, dst, src, imm);
+        tcg_out_opc_vi_u(s, opc_vi, dst, src, imm);
     } else {
         tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP0, imm);
         tcg_out_opc_vx(s, opc_vx, dst, src, TCG_REG_TMP0);
-- 
2.55.0


