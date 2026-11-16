Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4A606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FAZZkAKF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N/a+VVnB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63K-0002Oa-5E; Mon, 16 Nov 2026 18:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63C-0002Ic-Cj
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63A-0003GE-JS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:50 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfAt01573238
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PPwdMTMX5z9zELb7O8OjU/VMHv4xcNqQ32oY9dOFZWw=; b=FAZZkAKFdIYDemOg
 sAH6B9A4v2pGB87eImX97vj+2hdT48eExH+zJPgLWRGk0B3smN3f4IKuB5IEH5Zp
 VbOkU7Fjd92jsY3HIyeKscnYuR/vZ6nyzLT8a5Go0EUC+aP/u4YvYOSrMKskN+vy
 n2FnPjPJynFNTsyaksHM6sAmmgpWry0aNx0oCaG30vWoMW8hIXQQv+MG+kKHgPjJ
 uutcI5wYXMzreDUWQv2Lyqt4o+BH9Ar42RjWn/CPCRAM3hBrHBFKqb4HiV9ksIGH
 ywdr1NEK4FtSW5XIWNY5kcTA1ynyebI3/EFH8/KJahJ3a/pdCuoU9WVlyoypoN8d
 gI4sXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgk01t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495af07676so572480085a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871426; x=1795476226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPwdMTMX5z9zELb7O8OjU/VMHv4xcNqQ32oY9dOFZWw=;
 b=N/a+VVnBZMugBJx5cxbm2LkVHpfPJCZ2JWZDHTVftTvbE/92XaSQINN4BstnpSmTBq
 Dnpg/CLFzAjDoyVNhYDbn+Kffh5BmIW4dca/JN0I+AF13kHVq7G1V2tDQRAczFevYCyb
 fNEdYjN/96dU7K7pFrF0Jq91pRmi5d6keDOzgpEOJuvDSAecp4GyDuDtAIGvN6HmByzx
 Vyl+YFk7Q2dhw9isItG81imRk26oS1BOmlCBz+lYFU+0ixmQ+Wz2AGcR0K8lAehUJJVs
 IJ2E49vxijWwni2f6TT0lYaYCmDBaIr7xoevBYngzRFV7iCiHpvv+oIiUOWS/8bMsZic
 UbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871426; x=1795476226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PPwdMTMX5z9zELb7O8OjU/VMHv4xcNqQ32oY9dOFZWw=;
 b=rZwmCEskm7PhvQiGXsdna1GQ+r4nPDBKViNQkaKc58qE4rthWFFLHb/M3qLfLPH1DO
 PNtC1Fl2vFMjLZWuSI35ugn/LI0GVc7gcHAsU0RuvjpS4ud0HpurcQsDSEn4BDBS/OfT
 kl2ZVUhEwq0hpd3jFmdaR7P0L/Ga4R1DIRzfHNroB0IZcC3vbetNtTO2XAmeRd8xTsEU
 WYeIA7S1SecXV2wNwpjv53X0obUhfcxSan9SKRPcEhovuP+41zgZhXFO1xVQsDcEdeOr
 IpRFtLdTCc8sIOau3gtwB4Khiz+hFhmeUVG0EHHYvDVxeJQma7dRog2GPiOFNDgM7QXC
 g8AQ==
X-Gm-Message-State: APuU4Z+qKzegzHcxU4Sk6nx/Qf6SGJzo5IhKOIhqZQn23KdSLiJvX54n
 OchNy6zI3aLEAGY64vp+6eBti5ByWQgs4jBZzX/MW5qTp7v08JxshrbW0+tsfdGlK2iVOF78bKT
 HoHVdTePWDBpyg2KM0jU97CK0mbgt9+40LraD814hiZVBj2tOWb61bhLGK/qeJ0fhMg==
X-Gm-Gg: AYBFou3tyLh/CMQhG/RTFTJWCDjgy5zC5RUf4D3cADac70rQ5E0+sk5QsqdOijeurXB
 3AWANxAMBigGxycU8FlqR96nEh5NY71p72/FmymmxCakkKy6fqZ+dcVB5+YpKVIfmq/zsM7/jut
 iFLYISpmbk7rQdfCUa+5vDU+PVjFyGhRjHgTUX4ydSHOf3+M61KznehfI7blPLASYkc1k26kg7z
 tLyD05A5Ilbh5QmTnAic6P71RAWEIic+x9kKq+D3VGhSHJJrOCJwCJrALI3gf5sa4sTZ6HXAsGq
 nMiDRWB/Tx5WtuyxotaUuhgc11Q4i87QtG4z1wxOrQinguVNYARfO//2xe2yOjjeVlTQk82vvNp
 h0hED8GFtjXIxzAHV6pop5TGgf0pI8JBvf315e/FDruInDtZIfNvcwfqOxZAnOPO882CyxmOYxM
 q0yUzd+UYYuud6sg==
X-Received: by 2002:a05:620a:2994:b0:949:7069:3fab with SMTP id
 af79cd13be357-9497069441emr1153795385a.83.1794871426095; 
 Mon, 16 Nov 2026 15:23:46 -0800 (PST)
X-Received: by 2002:a05:620a:2994:b0:949:7069:3fab with SMTP id
 af79cd13be357-9497069441emr1153791785a.83.1794871425587; 
 Mon, 16 Nov 2026 15:23:45 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm24587632f8f.9.2026.11.16.15.23.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:23:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/22] tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
Date: Tue, 17 Nov 2026 00:23:14 +0100
Message-ID: <20261116232335.31593-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX0CKGtc7+Hd44
 ibzoiEZ26rMAfDxPNveKCH9IQ57gn+C2aNVIRUP+7p1A0NS59c99fVMyhLluQsOA+RF6UbQew4A
 ey3tbd94eqqNwxKpGq/Q2iOVdMRo1fg=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb9083 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=hXZgYZo4AAAA:8 a=Cvy6jmBRAY_LntWzTOEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22 a=37BJPeUnzxYkbV1yBC-1:22
X-Proofpoint-ORIG-GUID: kGy8nZk75w1pkASL0WXigUsicACWVxM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX216AWdHM/RY0
 8KXBnnlhuxVEpSwUKd3ioSDB28TCxKrntwUltwCVxcGrIoG99wI+jVA93SUD/zK6K8txMAZMemN
 oOuCMdEbiO+N08fQhdKJU8udf6OLXhq2hC8m/+lKQumw+Rlg22bxl1IZgj8p8hKRDOEMMXtHlrN
 Zdd0Odlk90KMXOSYuMDLA51vDiLMIPpqK0uKZ016nXT4o/Xfa3C7s+7gVynJuG2w27wHN5cE8j2
 ACM2HINI4n+FAsNRWfMJm4y6sPMd5/nR8/TGHrzzzzHxlh/B7vP5DRQKtJpKJ8OLJATvv0fWIWH
 KKzES/U5IMnLapSa7vheTDTXw5+gfiSMjDjRtz1HOpqyqSgWbWrHMz56XFt+Pm5359RJnfRz72J
 BZJTUhw4fu02X4j5BiCZUp/8WugmxRtup0coOA6N2DH7IUhs56vm9bGx1d9X4r5nuVOLkWldJaQ
 RPV05UJYnlkxFbjBhSQ==
X-Proofpoint-GUID: kGy8nZk75w1pkASL0WXigUsicACWVxM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

Move the OPIVI field layout into encode_vi_raw(), keeping the
simm5 check in encode_vi(). The next commit adds a uimm5 variant
for the vector shift instructions. No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20261028143330.6518-2-philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 6da52929a49b..319d5523fe7d 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -535,12 +535,18 @@ static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 
 /* Type-OPIVI */
 
+static tcg_insn_unit encode_vi_raw(RISCVInsn opc, TCGReg rd, unsigned imm5,
+                                   TCGReg vs2, bool vm)
+{
+    return opc | (rd & 0x1f) << 7 | (imm5 & 0x1f) << 15 |
+           (vs2 & 0x1f) << 20 | (vm << 25);
+}
+
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
                                TCGReg vs2, bool vm)
 {
     tcg_debug_assert(imm == sextract32(imm, 0, 5));
-    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
-           (vs2 & 0x1f) << 20 | (vm << 25);
+    return encode_vi_raw(opc, rd, imm, vs2, vm);
 }
 
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
-- 
2.55.0


