Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D2BC61DD5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSN-00075P-ON; Thu, 27 Aug 2026 18:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSE-0006Ab-Ba
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSC-0007PM-7B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2763848558
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1kSVgPwgYYVQPuSCI92G+2x6kuFijBou3Qzs5paMs/U=; b=bGSKsI2L8HE1F2d0
 Ia4WscJAyGhx6gV87lSC9b82Klkqb5MRnwr6llcqYU9TuDYLdh7ZYUIVblFO5api
 qeNk5SBx40wGNpmReanhBIZtg2OCefUDn/OhsAV1saJhnLV7qJeYECxmB1CfiXkI
 YdxzMVRobR3DRSyLfBpWjzOBJMbEX5j8yu0oH+dFWxo2Q7a66n3l8OTiVtlibVRY
 7Vmucc0vkb5Ow+X3ZRRA2j8NXFvfCuSswhAJsu6JXbcwhq8NT8a4dL/Mth9kui7t
 Dac2yvxBkMmMfamuEsd57KSXGOTf9XpadJUNdFYOnBUFKHVXNkxARQzieKEJ06M+
 Pn4vog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0ubm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso555658a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869200; x=1788474000; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1kSVgPwgYYVQPuSCI92G+2x6kuFijBou3Qzs5paMs/U=;
 b=g0o9ZVC+/kVrDl9G54f96uTL0V4qcQi5wuE+qFohJGIEbsKvvUfBbmPFsEp0hjMmLo
 KpKxrDGemZ8pdqn799YG/f++NLS2E56rHTcosjiqAE0ARr9xlGWUgNIo//930iaAowFM
 1FvEmpOyysED0Qu/9ZBLoAGWUAXIQmeAR11uZuz+ishWIj8C37r2y7DAJKMRbAK8Nj5c
 TSE1l3HITlC6SVkX7sku3FEOnQB+U77hHR2rbK/51FuOMNw6sP3bFWXAUL0uChrno5/H
 yIKTpaUXD6vp4nCqeMHVgx4LrYhfjj7ZW09p2WqFDD1/M0o411kjU+YjFPtANFOlm/C4
 xeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869200; x=1788474000;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1kSVgPwgYYVQPuSCI92G+2x6kuFijBou3Qzs5paMs/U=;
 b=rUbEKJaBSyStqxc0BkvM1hbHQHGvpiewzgk3qZFURjlck0lHzqiwkeWK36G9pJqwi1
 TVdlHHVAsEhztcnAp22uXSGAcIwcT7C+OpjwSuVhqMtHf6Jv74T++NOzvHfEGjpya88L
 blOn/pMgPs9eFx7kiJvDVLBEfCDbsSxIcCbUYxIL/oX4Iwy89PpXWoqiC+dcXY0xliXh
 GOYpZr70G3Ppg37VUsiw9zH0q+pOiDB2TJwEA1fM7fZdDKW/CAhKgPNzubjsF//BZSni
 eN0z333ZjCozlflMGz/kC71Yd4s0FDgnmK5bhkNXuY136zZvm1QnRe2ZqtiX5ti3ccGh
 V4ew==
X-Gm-Message-State: AFuF++kHo/i/im4ECw4nPr/hXITlORsYZzcKyAX0VZFU74Vzrk/v362T
 nVWb/yS7CcCkSW1GhKAfQJLOy1Q7YLx6JB78jfh0HkQkPMAZFkAh9CjNb94hbLvLXfDn8J4xSsa
 lukBqzOJymeF5dwIAPJTWj1+fxo+QL62J9zpTKpK1ige8Nx+smOW9Feliczzz5T8jvQ==
X-Gm-Gg: AR+sD114hg27DJ7y258p62PPZEGi46zO8wn77dq/fUNBdHDedQ+IGT6QyzPKD5rk95o
 p4Av7+Fu5MC20Dzrj/S3hbmRfIXuiEuHPrzj5QfYJgg9TVVYw7bind2WMjwFoFl2oM3gheaAFiz
 5WZiiHK07/QwFVBKpzuxdRaRiAONA7Q4BJ/bGyMlR7+/tF9R4mCU3DSowNkYwNEpa6bXDpFxSAC
 fR9DFKkCazotLbO+shxz6y/4k3I/9fGTJJ1oSJYVOYtnNpXY0lc10M4BztLPL7XuC4gSIeYFTfF
 0vxfTWgaNnZwTTIYP1I7ZiHideD3sAvVs9CN0ldK1LKq1TK2R+M6fqMpGgogaPSKytSmpE8X6pN
 HZ3jTL9tpLblS6x/McROSmkMnuvhI+RpSPJY4URBPfMfiJCDP6pYuHzVjZk0=
X-Received: by 2002:a17:90b:17c9:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-396d0fa13aemr3921217a91.14.1787869199827; 
 Thu, 27 Aug 2026 15:19:59 -0700 (PDT)
X-Received: by 2002:a17:90b:17c9:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-396d0fa13aemr3921133a91.14.1787869199448; 
 Thu, 27 Aug 2026 15:19:59 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 070/105] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Thu, 27 Aug 2026 22:14:31 +0000
Message-ID: <20260827221506.91574-71-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX67tGJWe/y5hy
 up6tPGNKH3pw2GAQmwQIQgpAEZH3SjU7R39K91ORQ0N5bXu6jX66TL5YBH91VkAH0OAgU2XInam
 a2pg80ZnBbQGiXfxSLXZLX1+yxzAWfSk00d3ifKSQajc3yRhWW8ALLXjLmsGZ22euDVKJ1olFfg
 4jKlNEA6EnwgERztk/lII+Q3GRXKXSneHLOS0WV9TthUQPvbMXH2XxkL8uizErefcJpxIxc/0yZ
 d/rGMsJdqKOXK7/FV9KSpQjsi06VQpArTLWiJD37Vs7bgDnb6UV0f0EQeQ392p6br902QUZvBGE
 mhliZ7QlWCYRn+cmOgcsk8ZWivsfTG5Dvnalsn9zvcyIBJsIqO3z03ePFiOXprXbrsVH78p1kyc
 gPZmR75LqDc7x6K735g6B1hr7Db1wTqrQAO2xZHNM5gZUikhGjWElQ/8UHpqUSKsFU9MuaBvYxT
 o+wM9Ep6+J+8sc6Y2YQ==
X-Proofpoint-ORIG-GUID: zKjvHWU_gS_muHOycOCNq7Y49b7lYjNu
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b810 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=Fbn9wURAhCV4_gqr_ywA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX1gCX9q/6qi6e
 tpNfp5FLz1S+StzRg5dnpt7QnQTZweEV7IHbTIRTrw5XBqWyBNF8WpFDuy5T6mDYzpPkK+le+oR
 MhoOz7MVL44QsuFHmdHC27xjcyPgs/M=
X-Proofpoint-GUID: zKjvHWU_gS_muHOycOCNq7Y49b7lYjNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_muli.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.43.0


