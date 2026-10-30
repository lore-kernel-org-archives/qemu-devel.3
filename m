Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EF606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=plroUGiH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HnCYTKoD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqjx-0002dD-AF; Fri, 30 Oct 2026 13:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqju-0002Wu-Qi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:50:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqjt-0007Sm-0N
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:50:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERL8K2968145
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Go5raBOf1KRQvFCZLOc5L5/jvKlytDeUWKABk1LcGx0=; b=plroUGiHPcTJ/Z7a
 X+E7RWdd8u0W8Jmz8wXaIBmKTfLuqdVp6+rVr3+NY6Ph2ot0AgD3zJyXAULJiq22
 Pjw3VBc68soMu01Q6LwopDxitRxEnCha+rSjH88a4UrUvUICbz+lC8+AYv0zGez5
 nO/cX8HuPPuBUVhKGo39WGVGI76VnQbmV11OjTwUP/TurjQBNqnl3hoY24HN8HKU
 Oawug/OUBZOa7zyYdcsskS9kodHzuxKGTNe+75P9LiU3bo2M2EA/57Wb2abE23hw
 nKu+sFErZAfLVgqZvAQAw/+sCs23clhkYjFveKvh3eLRgbxQ4ZMaZcj2P+Pi3vj+
 tEfkww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmb2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:50:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so120305485a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382603; x=1793987403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Go5raBOf1KRQvFCZLOc5L5/jvKlytDeUWKABk1LcGx0=;
 b=HnCYTKoDJPsmzgy0TBrLzRkA5iBw+EhNWWxRp2w4RbU79w8E0c4Cv04tnXjqVAC/j9
 OJnvXIwL75EnU4rQD3PKi8mgTKR3agKFsehyayK8ifCPMYGfCeoWxkbLYtG/X5XwMThi
 SpMwo3CpjSmgGlzM0eG3CksZogOdzCQbnwIKbT9ZuX6SqVWfTuXM1O/Pxgj1ryzWakys
 OK0AO76d4zuh4Ts5MXpy0dc8xMBwVaPIm1ajGSQQOrG9UsFDadP3GuSIVDvXRrFwHybr
 PJe94vHtC1Sj3T2mRUyiQemsDFBAh1OFDl4ku7rmgP9timBAWG5+CaTbU1lOBwHHGoT4
 FpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382603; x=1793987403;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Go5raBOf1KRQvFCZLOc5L5/jvKlytDeUWKABk1LcGx0=;
 b=hSjFJ+P0p40ywQywpAuDhocZLtzRfga0gq88bmiRMinNEj6mO2BXv7gFvuJ6L6532d
 nTzWYa37O+FjM5RBih9RyFodvdrYU4co877kYe2bDrqZ/o29hp5nwFXGp4Tx8J+HMCFn
 t8LIz8nGxlC3lwriCZY1akn9WyfrrG5Ja5MKhdHT9M1krTfPm9U38q0sZL3Svy/XBk4e
 xbTpML/ezYGtOc/h/GxSFdsqAIht0zdmE3QP+NjJA4wrZywGIISf7LmvYHY2Ro2eLogm
 yc1d9kHGpbzlqN/9/fN45ESdQ2e6hnzfMcj9ZNPvXzq1BunO0h0PfYKVwDwteZcH0cI9
 +dwA==
X-Gm-Message-State: AFq9FYIOZHdKbjdAK0MXdWWTnOzhRS+f5w+1erSUb0EqaQFMThRpkUXA
 1sJlIVUmVsAD9DHqUWt8/DzLjivbFkz53+9TTmfM1yqLPKKqmfigGijR0geeJrzq7Afm346ZGpH
 YFFN5Z81ETMiCMX35EZzey3zZzzYGUabD5gTiexDoESlYQg2BZZUoXzwyJpZXw0BwIzYT
X-Gm-Gg: AYBFou2SiUzOkvK72MsYc7LcbR56O7jN4jNXxQbb6uEXMnKJ2+Y8Gt+weKlXnskVMbH
 DT93RxCdmC7R2uH01KtERev3Nis9UnQQBjx8j0NyP+zTwFMJqJbLeISVcejq1xltUgY1Ese5etY
 klsXoAVAfZuOnYYiDIyp1QtlWt1IfC/Fptayk1P837PpoQbN/MtiaOvYvCfBEwk/f+vtc7Seb8u
 gBeNHIj2SzTkzNDtFTov0OXYjHoPkWepZS8wEjgBEu9RlQWXgJNbC1rHjw7DjfMle3DSjEqFFPs
 NPTeO18FKRRx+4cZzXPXkED5Jl1UpJTSWq68wYcIjt7M54bADx3y65YCNA7aGpWXHiwSoZRhc4B
 3ca99RBfMQfwOoueKPWVCJFvfWaJD2NEpjTaoV1ilgus7Yfoe8PPEGIbawE2LQUrg3KTd3+R13s
 z6bUtjS+3PGi3PHyBQfLX7QEnV3cZDOQ==
X-Received: by 2002:a05:620a:1a04:b0:944:3c5:ffd8 with SMTP id
 af79cd13be357-944216ee039mr545517385a.35.1793382602399; 
 Fri, 30 Oct 2026 10:50:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1a04:b0:944:3c5:ffd8 with SMTP id
 af79cd13be357-944216ee039mr545512185a.35.1793382601825; 
 Fri, 30 Oct 2026 10:50:01 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa820492cesm164273775e9.13.2026.10.30.10.49.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 4/4] tests/tcg/mips64: Test the Octeon POP instruction
Date: Fri, 30 Oct 2026 18:48:55 +0100
Message-ID: <20261030174856.98759-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030174856.98759-1-philmd@oss.qualcomm.com>
References: <20261030174856.98759-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXxUrVpeqOa09y
 TwRBxN1y3H06XEOWMTvH02VSWKiqnPFynZ1G3+WB7O1PAn60Va0hTA/rBM+cO6ImqjheUg6u7lD
 IJEbiD7sqGEvWGNPyZiIEEy6HCcZzUr0dUUFNnaK9866I7KGZJNoXQRV78d3sguec5xboKQxgpD
 WDdm96I9ei8O0mkDbq35uUG27IystQdKRxvfTjuxOFavaIatyomLERLJS8lE9d7dbUTL++Z1j6I
 GQ7aI750EB65aEfEq1e0qKDJKVJzT5TkHMp0pk+cPCe/OrgXIdnwOvyQy3FEMVwQzesG/KSDx2r
 9JP1yUskvXndTf8PkkYlvM8vLdhilHNdCVOt1GV4J5A8xycVybpxbrDgcvJqZwtnGm4GZtG3ZFO
 ZtNyOznGk0FNTic9PXHlSVg4vtxsbt7Jywe0mnQu1fWkGawXi7+Q/cyEdxtzaArmDG/szx0DySV
 vYtozMHl1hrSPqo3ZHQ==
X-Proofpoint-GUID: FyDwFc-QWfOBgI30nWnYYhZPF73ZUnKi
X-Proofpoint-ORIG-GUID: FyDwFc-QWfOBgI30nWnYYhZPF73ZUnKi
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4d8cb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX9T6o3q4FzRgc
 y9nLQyOO7Q4a8Y11eKRvzWui6zsQSi2/8LoY7H2m0oUv3mKEAegyURGDeYkb7Qd3bSkkCTwTvlG
 t/VlifTclEXO54n7tadDgUtv34hxPJE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Check that POP counts the bits of the low 32 bits only, unlike DPOP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/octeon-insns.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
index 208002c711a2..ea8ad4baee4d 100644
--- a/tests/tcg/mips64/octeon-insns.c
+++ b/tests/tcg/mips64/octeon-insns.c
@@ -39,6 +39,21 @@ static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_pop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502c\n\t" /* pop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
 static uint64_t octeon_dpop(uint64_t rs)
 {
     uint64_t rd;
@@ -388,6 +403,9 @@ int main(void)
     TAP_START();
     TAP_CHECK(octeon_baddu(0x123, 0x0f0) == 0x13);
     TAP_CHECK(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    TAP_CHECK(octeon_pop(0) == 0);
+    TAP_CHECK(octeon_pop(0xf0f0f0f0) == 16);
+    TAP_CHECK(octeon_pop(0xffffffff00000001ULL) == 1); /* low 32 bits only */
     TAP_CHECK(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
     TAP_CHECK(octeon_seq(0xabc, 0xabc) == 1);
     TAP_CHECK(octeon_seq(0xabc, 0xdef) == 0);
-- 
2.55.0


