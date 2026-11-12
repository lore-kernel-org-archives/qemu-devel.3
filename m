Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C8606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aNppQp43;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FARruheO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTjV-0000as-MT; Thu, 12 Nov 2026 07:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTj3-00086B-Cr
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTj0-0002WM-Fn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:20 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC8uhpb4149288
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V1v4b/976D2
 ImNBHl+96m2amRGObR4ZYuZXr8rKD0lM=; b=aNppQp43FDUYFXHYZDYDpJwSAvM
 2N/CtpzuOkT3t5a8SoKH9IwWNVGdQT32mYn1IPKBEMkk/YFvCdjutrUR6hiRR9Vr
 e7DsQQ8tChTBOmUBYiXr6GJJVg2Jv1qkd2/OIAJBOEWs5k6gn4FqMIivFdkY+Ncp
 DIDpv8a50G4X7OkKKxyn764Cd11ik6qpTBqDpCyce0gPrIhXVS+PKCjBcr8EuTOD
 2dxTI5FKLdmxsI1iuP98zQ7L/aJWjnnaKeyJtVynSQ/ZCuxDIqRl38U6uz/3JRpn
 SoJZqw8/ExXGphYmAFeKpeiUgIMANOaR/PjYU8HUTzTV2GtTO4iqo4oM0sw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc63bj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-542fc619afaso55976691cf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794485777; x=1795090577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V1v4b/976D2ImNBHl+96m2amRGObR4ZYuZXr8rKD0lM=;
 b=FARruheOcwjfDPlxuOMwNtwrZOgXu6CFCifQzBGyruv/Yz+KHYLCa8u/RZ5KPHPMfT
 vcrrnuuRcs8Hw675HuuKa3IADAoOnNF6IVjRGwJ7RDulc6ptYnFwMj5Z1S6BJy+70U9S
 ZcjJG0rq219IQlKlRePzQU7Bh7CZ5qs0nEhyMUaOAYN0v8Oer/uhSzH/F8OoKYLWB+lv
 nkmDgtTCMOgajdLkreMRonTkBndZmCj1sERhXAiIvDhzfMnWnp3wpWT4T+HEwSBRwkU/
 5FNnrNgM8opBm1iMd4zjvjgWY/4CEBz9/y9A37yGOunYmXjLw9SyihcDQwI86yYq/BBu
 m+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485777; x=1795090577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V1v4b/976D2ImNBHl+96m2amRGObR4ZYuZXr8rKD0lM=;
 b=kEbelyqBgR/vLWxwX+uaMJGxiAeA43fivkat78qu/417SjVLfkzf9hrE6zBqwQfhBZ
 nVQjbfDQiOJ+PLC5ciGBHkKGwxbtIyJa2kHRoMQRsgoKV1fMMYq+mI5IplkU6F09GzXE
 9K7qeKnckazoFaPKcUrWg3Tpzh4x+EgsB7GopS0pB1tNm5KG0UDSrYV1fP/CNja6eCFh
 TbL28VfpkKfhVxT67aKU4o1Yzj7v7VQXMzeCuYeW1rVHLFNEjhQ2ZarUhBOMuuz/1Wgc
 4PhCAWacvTLHV62vkJbNRp2ViS13TPiQfj7KLoKEyw6gl+tfdYMPbcGOQqaKfHYwu91j
 jyqw==
X-Gm-Message-State: APuU4Z/T1Ck40bc397LmQQhR99deyoHmjeg6HZfpnEc91H0MNFHG5wtt
 2yHJpuMPcFnzDnRQSAjw6XSpVawF3mLeOOkKkRWmgKNsguHF1pk/N19o8WwCukDzWOPz9G4VX0l
 ugIAOiGqXhBAi85WoVZoua5PV7MHRtZvRJ85gZ4Um/iFZFvoSRSbNs+BxcB8emL9r6A==
X-Gm-Gg: AYBFou3K8bAuYLTz8hXYSd6aSegtHN327mi9NVuMxoaKs5Ytu4LcKZ6LOVx2cboJs6F
 dj1YmQgcD/vB2Sj+sbLFQTsCZ2v9XLgcOm9O7TzBSwG3nhYQ+ardILPOXduLmMmjqXGjwNgWVYs
 MR256AvBs28eHNmDin4raf7VaBg2FjMVvMkCUp/trQL/WI5VUpY9JfUBPX7Q6UGyJzh1CjD6jX5
 c5SCfThK7WHKymF6xnCTT/bxZAS5YZbih+bcm5CSRTQY/IF5O7Ftqn48i1uGOMLv+rTo8XeX1BT
 cVCuugFGu/egrhDFolNFzShZmNVGUO9iIMLZAB8vdWw8wjZ3nsTGicvjhf8lmUPrFIuDyjC7Afl
 NgSx86yH9tC99HXpwtzF/j1b/gCndnnH7oLJ7+Tig61P7yBKIT4W3Bqsm9KMCTOoAEl5mwBkW9z
 KMrIQ3vfW21VEG071whfqOi11gy5j+aAsys4wpdvQSPTX2
X-Received: by 2002:a05:622a:a13:b0:533:8bf0:e6 with SMTP id
 d75a77b69052e-556c06e354amr83624901cf.35.1794485776457; 
 Thu, 12 Nov 2026 04:16:16 -0800 (PST)
X-Received: by 2002:a05:622a:a13:b0:533:8bf0:e6 with SMTP id
 d75a77b69052e-556c06e354amr83624471cf.35.1794485775904; 
 Thu, 12 Nov 2026 04:16:15 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af6096asm73538651cf.5.2026.11.12.04.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:16:14 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 5/5] MAINTAINERS: add contact for the RISC-V server-ref
 machine
Date: Thu, 12 Nov 2026 09:15:53 -0300
Message-ID: <20261112121553.485439-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
References: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ELprgLhjPDb18A1HOMh2W5FJGX8KMJpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX7ME1Hf733ryO
 SG3+Y2TA7/ecA6lZF8a1w/lwlLNlBvcqSSMBVT+IkSEXSL7ONarsITTolEhzj6JNtytQqpn1uAp
 7M3JCv+bd/7iucXT1hhbwNacJZc54sTzHwBjXE2BchMDiJ9WdU+VP9zCAtrwjEzgoOy+qfaHGVI
 LfPhMIOb/tmWjTWSqzKoZ6webInJbb35BGZ1qcvvtIiV5prgzgqQLFGLUKXIkUUOGoOgohL8u5e
 Vd0SwYyJFAl/2MPwnW5Az+E3EnqGtgKnyA93nmFv5rIUW+xOHZwA54nzpx0SJbrv5BEQLxUVHZI
 NGM+KkRV09DVx65PFxlkBJDWrZHYj+2AknTokWhKANVDcLpQj4SXi4dWd0pj9YBvZWRpTOoH1ow
 Ku8yn0TJJ1LH7JN8px5AZSrlR2uRDbNxhDhHsS7MhOOvoQq7sEjlFeg5gBXCZEbCivw3grx0iDT
 C9RttQA74dOySebn+HA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX9VUxlKVFLoE9
 Oa+Vm4qVvFf4gSZhdeFo7x+0YO1EUs7NdIwxWXPeoDFsghwmt237yxSQs5ObxYBMDhlee11ASYZ
 0h5w4bm2Nx0zH6jIWju73dUEcLJic/o=
X-Proofpoint-GUID: ELprgLhjPDb18A1HOMh2W5FJGX8KMJpH
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af5ae11 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FRSEYCzRAAAA:8 a=JF9118EUAAAA:8 a=69wJf7TsAAAA:8 a=MOatoMk4zhW8oBTF--8A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=xVlTc564ipvMDusKsbsT:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Make it clearer that this is a board that is actively maintained.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9b..9a3f8eb8a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1913,6 +1913,14 @@ F: include/hw/riscv/cv1800b.h
 F: tests/functional/riscv64/test_milkv_duo.py
 F: tests/qtest/milkv-duo-test.c
 
+RISC-V Server Reference Platform (riscv-server-ref) machines
+M: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: docs/system/riscv/riscv-server-ref.rst
+F: hw/riscv/server_platform_ref.c
+F: tests/functional/riscv64/test_server_ref.py
+
 RX Machines
 -----------
 rx-gdbsim
-- 
2.43.0


