Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161D606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XlX6VTtR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JMe9R2a2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwb-0002SE-Ez; Tue, 24 Nov 2026 18:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwD-0001W4-3Q
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwB-0007hn-EC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:36 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMai2d2558056
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xw2CwxplvmTFNVL2KImeBPFNt1qGSv9xBFMLdEntCDI=; b=XlX6VTtRpI+1cMiy
 gUiWl8RUt4XhOPcbnpISxVThf5evnAxhzkpWL3PpEuxBaVMe2aTS28XswS+iyCvF
 z3ESiPswD9q0BkiF2QaIHOC/popkmW6xYtkX18uhibJ6Hy10CoPIqH4tnSVzHm0q
 JIUrLBgWqITU3VqZ3UBRJomcvrkdbPUeTIsPxM0cupCXDaCH0UVJDt0Lj4ycl4Cl
 0MW8q9Cwndjvg6o+0xFAO33l2IeaG6yfrp6600286mdS4t9Qqb6syflSmz9Z4Oh1
 7HeaQ6JSOknGLxPuQoWdf1DG9b7bTdaV92ZQPEvmkTNcwPWE826q+MOw5RDe4zki
 bItAMQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnghr29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so893580285a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562913; x=1796167713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xw2CwxplvmTFNVL2KImeBPFNt1qGSv9xBFMLdEntCDI=;
 b=JMe9R2a2PSz3n4RUf9T0YeQH5+JxUMyxwO2gbh7or/3n6z54ec79OhXs65+HlO6UpP
 ZFohB1yDtYsTBtzXR2+3zmqkfM5NpK7pZ4KbLQBcZUVU2dniIzSaKdQQoj5b1C4z0vz7
 7SQpbLqFsaeMpjAw4OFFroWteme+94ob7VcI5AJnGPVZighHKkt8J9nHs3MzCGmcO5+N
 h2zPSftKZ1X/jUn5okbHgEzs8RlwZv8qtdW1qGJMMPvTT64hi6Kjy0JLtLSlipoaLgNk
 IyhUssmyN544M4hhZ7j/7RXQ0nW6I1eQsalpi79cEmaQ8sTjDsrNk9N8kQqxRn3j20HW
 scTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562913; x=1796167713;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xw2CwxplvmTFNVL2KImeBPFNt1qGSv9xBFMLdEntCDI=;
 b=jY/VQhr4wLaORuTXhO7oU3KJPHrEQfE/k0Qmh9wUJMHLYKhm8Rg5z6xdQgy37EhHPN
 QB8dRfUv8cNxtlbzqp0g82TpgEVNNNcLJFJpLQDDtsCsbrhUDNnEo77eG0qckotIKXhQ
 +n/5jBsDgmk9Jf+ePZk4DglNbyAhFHt1UW4FkTX6MO/OgFrczbWtYM4FfqJHyFjnMdEb
 kfRQvYupbpbkIfT10LxYiGYAz1PMnqgRCtHXfvosXm5fJ/6juvm8L13Y9POPYFZWJU/U
 M+mcThml44k4q8pwBW/5sXYl+4W3JxwlZqH0KiEp0MRamasR7Ec6Z/3quBDnIxbdGLeT
 onSw==
X-Gm-Message-State: APuU4Z+KbZA5FTg8NJlPfdtNk9FZ0el2yOhCoHDYw7v3Ay1HenNM3edZ
 qaoANWIc78V1wyYylqWJAe+YyO/h+l1bY3ZLgTnqwRrrixtfBjPFNIhOyDFM32dYDF4wEAN77n+
 sfUTMrrN70PT1AkHLwDucuzRrvhiw3xljSr53hdXCeUSoankjttLbPDVMSEm4h7PNRTr7
X-Gm-Gg: AZFdTZeEl2Y5G/xntk7ViWqhMW4L0VH/xn5mbxfb0rH5Ro4OAxIdXNdrh3lOYaIcDSK
 9Kfj8FpGYCyJ5LUhjiB8aXKrIz4ugu+5dFFRZ5xufMcqaYCHhgpsfjFTdJcCqBO1PqNxsJSJTou
 NlPofeYAGGynqyehsBWLac9CisfCSxr0yneuTsZQ0Zx7kCtO+lUbZe1hIt+mK/N5aO2mnh+qhfZ
 NkFjprrlkX5xmllyAbyj7laGPzDRZo9816zgLIHErMT2UjYkoY0OqIC9cxm6E0xizk1G1gTz3FZ
 M/1iunV1c1HAaMbgSgi8R9IQO2fK+oYcY3EEHH9kHtj+R8681WA1jJ6CPX0PMnkyPzrwWkRqG/I
 P18GRo+ZvHIrcFsqUl7zYqtg9aLoRzIdxMgfZDxGeLnL4JWJd/+QiCRehLZXRGfjeQOA4cqCh7+
 274YZ5ucz4Nn9GGw==
X-Received: by 2002:a05:620a:46a9:b0:949:730b:53e9 with SMTP id
 af79cd13be357-949ba98d292mr2828454185a.31.1795562912888; 
 Tue, 24 Nov 2026 15:28:32 -0800 (PST)
X-Received: by 2002:a05:620a:46a9:b0:949:730b:53e9 with SMTP id
 af79cd13be357-949ba98d292mr2828451185a.31.1795562912309; 
 Tue, 24 Nov 2026 15:28:32 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm30431874f8f.49.2026.11.24.15.28.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] target/mips: Enforce alignment and 64-bit CPU for the
 DSP LX loads
Date: Wed, 25 Nov 2026 00:27:13 +0100
Message-ID: <20261124232722.90234-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX7dweHmnwHfCJ
 vmdF+BP7DMA7S2u58ca8QLlYwMzo5Err0odUaXVQHO6+7ItJLRD8BkS3tp+aKCz6cq4NJ9yh/VS
 lEJFcLgpbcdcKCIDnigGyaeUL/pq8C0=
X-Proofpoint-ORIG-GUID: 4yR6DUw0zoABma39vBots9g7mBZwKR-5
X-Proofpoint-GUID: 4yR6DUw0zoABma39vBots9g7mBZwKR-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX4CWzmdCPxyhC
 beUPF4zyyH0gk0fNm803ihaurPLn/MO3USCEffIWaoK+YljQDNXlNZyQPEB3KSpzcJa04s58U+D
 rK1xk7KoWOVT26Zg2MYYpzpb4R0bYyxYd0UWhYex1rV7fnC9Mf17YropIn4SjcW/v2gQsFi2XSQ
 gWPMZZ2sgyBLyQhxJWLSFLpwG4TIYVg8Hq/KPe6pr2JQxtkd69nfz3GyNhXULs3gvkP/5U1fDNF
 q2SSm2QJ2PRokRBRW7OkxOeSM9APiDjHWjdcAnaLbs4ohj7w9TtRkGEF7r5MIms5DRTrujwTY1s
 n8x05EZq0usqGiNR2RqeZm8F5LgEl0gyaI53ULkbRgpwNeReRuUDg6ghtdHXzOW4sU8TS3QMEa4
 amWixLP3hGxjALViZ3A3pO5MxMFQXWXXVi83RBYw46E61pC/qNn9Xk7uzw2uOqqexOSfDoCBFZH
 0hmv7ymnRdjZtq19WOQ==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b061da1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=kI7ue_SDoHa-woyrWu0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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

The DSP LHX, LWX and LDX loads require a naturally aligned address
and raise Address Error otherwise (MD00374 r3.01 p.130-131, MD00375
r3.02 p.145). Use the default memop alignment mask for them (strict,
except under linux-user FIXADE); LBUX is a byte access.
The Octeon LX forms share gen_lx() and are unchanged.

LDX belongs to the MIPS64 DSP module only, but was decoded on any DSP
CPU in a 64-bit build, including 32-bit ones such as the 24KE or 74K.
Call check_mips_64() after the DSP Disabled check to raise Reserved
Instruction there.

Fixes: 9b1a1d68d041 ("target-mips: Add ASE DSP load instructions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-6-philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c434da714b0c..55dd69353eee 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13649,17 +13649,18 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         switch (op2) {
 #if defined(TARGET_MIPS64)
         case OPC_LDX:
-            gen_lx(ctx, rd, rs, rt, MO_UQ);
+            check_mips_64(ctx);
+            gen_lx(ctx, rd, rs, rt, MO_UQ | ctx->default_tcg_memop_mask);
             break;
 #endif
         case OPC_LBUX:
             gen_lx(ctx, rd, rs, rt, MO_UB);
             break;
         case OPC_LHX:
-            gen_lx(ctx, rd, rs, rt, MO_SW);
+            gen_lx(ctx, rd, rs, rt, MO_SW | ctx->default_tcg_memop_mask);
             break;
         case OPC_LWX:
-            gen_lx(ctx, rd, rs, rt, MO_SL);
+            gen_lx(ctx, rd, rs, rt, MO_SL | ctx->default_tcg_memop_mask);
             break;
         default:            /* Invalid */
             MIPS_INVAL("MASK LX");
-- 
2.55.0


