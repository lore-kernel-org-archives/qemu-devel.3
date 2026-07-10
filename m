Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FC4C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ26-0006A4-NG; Fri, 10 Jul 2026 17:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1x-0005iK-UE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1w-0003bH-BO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3iTH1648553
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/szRSCuJqid
 inYv2UA1YJbL9LBT2meK92VwMyhfKZX0=; b=GGVOxq8Lh9/8Eu0qogG9xCy6pBZ
 jMjBWjVdvAWqmeSGFHQ/222rvUNdk7Kp73yHp5HrVIqz2vROPo4AwyQeei1lRTMj
 35W/7b28t0Wt++XVa+MBBSRuII8LesbL0qH4KvzV8pxde1yVASpJIFc991BLn9x3
 e1K4X/EysBDLySnl08Sd4QorB/KPZjXncK+icnFDh/GQLnck2AB+Y36WLxt+vv29
 QRprVw0lDbOpmwjsada+g2eOlSjy6S4o65pU5xOkuwHwmVK8H0syDhwris0rtcef
 qUgvti0MpnxLjbVew4xPdmuK5c/fm4OKapAl4CIvt+sGgaBzwiY/+joFeHA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhd41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so1981322a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719896; x=1784324696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/szRSCuJqidinYv2UA1YJbL9LBT2meK92VwMyhfKZX0=;
 b=Og0btva0o25TJIxL2gWMYBxDfLX+mXL+CceW8Zi1gxl545gtLb2Flhfjynysrlu5EB
 +o7pF3on9WFb0fj4A+/VD+UnR+pCKQb42CO+5OTgN/fI5Nd83ehsVcqaiiVtXrOBNXFD
 Hfi8uf2++Cbv1o2R2+pcuVa3EvNouxkTd8ZJ4B3Dx6cJ2vGwACDyR6YL3nIT77i9BiLD
 hhWlGMAEuw0P02uVFCfVoctDRy9pZ3Jy3wF/+Rzjx4YwAH1XcywhDdKk5RzxzAInbqex
 ek0A/rwS4bayVfDHrKdtHgmrOUQmKQDWr2j7tbNqlUrsjzt7xWthvxlPdmHItxg9+T9D
 5OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719896; x=1784324696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/szRSCuJqidinYv2UA1YJbL9LBT2meK92VwMyhfKZX0=;
 b=nRJ/YHCVERkCOSOqdTJESub8yoTMOaholdP6UeP6FplwhBGuginDOpWKRcp7xtOtXY
 zFnXPW0TOqz5lkpdjJmnD0BJdNeFc3YDZOYkg2ng2GdHIxEzHrEBeX4IzH2QTsf1jHJo
 tNvi4tuQqEjLPPUMl8T/fkikYay+Id3DGyN7HadFv7Kdy5yloysZP77HLWINEa8k81mh
 XrCC2xaayHDJf4Uer/5OyTNW7W5PgHMkdB/gSGr/jgX5LixgKZeYf6X27VxW7Omppn6F
 IbJnTPXnIjnKSKgzIhLSgzG23rMm3AB3EO4Ybf907wg0N9IbF1j5KzkKwtCIb7ptALHL
 cn5g==
X-Gm-Message-State: AOJu0YxTrfwU6Yj1Df1Bvq6HcnVpKDquhSOls2W9s+tZJhDbo+ObfafQ
 mXntCUdU7SYjFcBwOm5enUGl233KrC9UVvVIwR0JImb+OJzZ/brXssrBECWOE5S0QyYbIZlcLIs
 G1tNCjuRHOGOYi4Zjwxt8IwA8RnNqEJrTI7oE+KateWs6elKZQHNOhdndrwgJW1xq+Q==
X-Gm-Gg: AfdE7cmA85ETSslercr5WrKub2L/zjHcYbIo6J8bALOgesSD7VHbvdvnm1ifVtfdd7j
 LoCcvkcaEk65VIGZlGHSTPnMNVaU/GMgZK24R14raeafQ5Dsm03/BK2DBgOSSere5ZQEEqLlFSI
 fmFLZXVWn2mKiQaZxobaceN6zXMFesB3Ds4uNAtPWccj9oK8NRiZ+43VaBZjHqW9oLecvMWYHVz
 kGU2wqs73KuVay5y+anztETJUQBkd+tpuuJL24Ywco2S2GA5yjCWJWqv/U3TYaA8mKbi3RmGEsq
 MAabc4CJO/gGBSynI2lRFoHfhGiaXjRrsjIgpuNvBRbZI9TcXpoQDvHH1sdKDAhJlWv2kwb/9dZ
 CeANFvcJMQB1FbOGvso9EozD/4Vv+RemTAMJlKk3gKP7ep/m9HxuSVJydMuXORaljhYlMJmTPyN
 sYOq0HKg==
X-Received: by 2002:a05:6a21:7704:b0:3bf:bf50:4c96 with SMTP id
 adf61e73a8af0-3c110a4b264mr691871637.18.1783719895976; 
 Fri, 10 Jul 2026 14:44:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:7704:b0:3bf:bf50:4c96 with SMTP id
 adf61e73a8af0-3c110a4b264mr691840637.18.1783719895548; 
 Fri, 10 Jul 2026 14:44:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 37/98] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Fri, 10 Jul 2026 14:42:41 -0700
Message-ID: <20260710214343.2065491-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5167d8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=3zGdDJLpS8I3mbvQAZ4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: sZ88_DfLOR1LUw4Yde_HpYznn5x8y1F6
X-Proofpoint-GUID: sZ88_DfLOR1LUw4Yde_HpYznn5x8y1F6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX/4MhDuY9RbXJ
 5A7jLJM6jLgvgjPe4bLSh6g+714EoMw6M0X+NJ0URYzYMvQycxIez3rzs6u85zGleVhsI9H8k6u
 dSQC4lVaLrMf5Dm3jPByqkyDPwFDhsJoXkGpe1y2iHf/l11fIM7Joa7nkHwhp19pxu3o2d7uZnh
 GfpzZoUv4paiNuYlh0R0NttZKMuxLI/NUE62+Ogoutl8DFPI7Y2kf1zj3/mvz2lVSfyQSa1k8yF
 cc7NSZIN4XwTcqdzOaIJ4hEZhULqfKMVAcVmH/PS8ceWgSUFe2MANQHo5vTPpaHoki+HbqvqTih
 q78i0M/24bMb4kCKot9ngIgXVSxBIDNrxnsb+Nx9mBI4qLi23j1Cr2R7uo3QgpHVccWiLSVxVj9
 BJULDpHTI4qA7qyxTIYK261wSR2xeanhmTxpbF9j8NjPzY+bae7rBpi4/fWSGZLD7O0WY3CMnqL
 9o47Fc1tw30BXc2VnIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX8ytivdqD+jmx
 NfGVUqvYVTqPturRCTwOL1sbL3xt9PDjfLj3jnIhOtNRsp2exPtYujMLaZyde0C3QpXSgSc3iWp
 fhW6/XatVZeYjEpcvgO31YyDkYs3DqQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

fcvtzs d0,s31 requires fprcvt support in compiler, which is only
available from gcc-16. Since our debian-all-test-cross container has
gcc-aarch64-14, this test will never run in CI.

Replace the concerned instruction with raw opcode, obtained from:
$ echo "fcvtzs d0, s31" | llvm-mc-22 -triple=aarch64 -mattr=fprcvt --show-encoding
fcvtzs  d0, s31 // encoding: [0xe0,0x03,0x36,0x9e]

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/arm/fcvt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 7c0cc4367e7..8c81ba8a1bc 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -173,9 +173,11 @@ static void convert_single_to_integer(void)
         output = input;
 #else
 #ifdef FPRCVT
-        asm("fcvtzs d0, %s1\r\n"
+        asm("fmov s31, %s1\n\t"
+            /* "fcvtzs d0, s31\n\t" */
+            ".byte 0xe0,0x03,0x36,0x9e\n\t"
             "fmov %0, d0" :
-            "=r" (output) : "w" (input));
+            "=r" (output) : "w" (input) : "s31", "d0");
 #else
         asm("fcvtzs %0, %s1" : "=r" (output) : "w" (input));
 #endif
-- 
2.47.3


