Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968FBC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOM-00070i-37; Thu, 27 Aug 2026 18:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOK-0006vA-GU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOI-0006Dp-EW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMFCX1803870
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IETrIEpK4iP
 6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=; b=ABpWOuJmR1g0k4lD88OyAbzKvBP
 0dZQ50EIL6VxwMdBimD2CW1S2CD5dii9XXVE0x5lO5YTtYrwEG9DWhfu0HsdCfNg
 Bz9dMC6ZdcT/KOA9VIhm0xEXlvsps3IN1FxKGvvtNy2KP4/PdNhTT50C0Jx7MNwf
 peA8ffEYKftAc58i2t6KadxMw+A/JQnBRTAXSaShhAZyHI3LPbfPzuUtsPui1I2A
 hc9KiLGcb7nJL6qDVu8psv0m71h1Nu6WIuann3xprS5sugOnLuvLakQa2ArgPvKE
 bfCsihuS+Zay4ViKRTqZu/0F5uYMCcZ9tAaxu7xDblL50iYsde5YjF6Tifw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgv6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-854f274dd69so763064b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868958; x=1788473758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IETrIEpK4iP6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=;
 b=CYygtq2Tj+KX9YW+6hoz/SOGRFF+2j9S+9CuKKVETsARbJRaj6mw3cZ4tccdr2BPeZ
 mXurErE5uY/uf1Czvo1muUIqqpSahGtUNP4TudAaZYP84J89XpiJZWdc4p7BUrzyT8nv
 nxdTrtmkfHusIPnmXyVQSkFORB7xOdNRNbPuF1+Xuo1mvxe2pIUbQlFfZH1bx/8TQ/YE
 UAAHOrzAxhq4ftK4ZDvAq8J7QnDZM2Snmr0CBMrIVAixf159oXGkKDppKgyFN6DgVIgL
 5VZ783+y+gcbDMbIZFLtLVhq/5PTrbWLcnQcRdq3GJPIQAwAVqLobKtWQG3s1dtx0ndz
 Cjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868958; x=1788473758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IETrIEpK4iP6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=;
 b=WIiITOli2KQPpd+QOMp40gyHgCjhEU/0oZ2iz0cAB0ilsQw3d7UIm3N1V6ZQCV062y
 htOACGUSY25UJJviApD1+rtxBN+v8zNKjH0A5jwh4CxWzAi4yKe8EpOPUxWYkfpqkz8t
 JAWh5Zz5hX97sILbIJwB0iJJyhZyeAHw9jpyy52Lfa7KOwvwEThj7pAYgXJJVS3mCV4K
 DhIt6BEVaaZzcLrQ43oPFOX21W+pt4u9189l30bhMYoR1fA7N4uGEAeQJHSnV0SAg2JH
 MruNcpaJcEsi/qcmk6A+B8zhuDSihAkSu2DGkfYtsYuy3aknjzLymsVoPbNf7A+QBLLD
 tvcQ==
X-Gm-Message-State: AFuF++nXzyz0j4LSaN03114BHx2EWEVz/oRVqnACez6l32YC37q1eTwf
 7LJE6tcuT0n4L2RYCkqeqvvux3ZE6t463hjPw+H/vlmshzFA+yeP7Z0BfZykIgrl2KzuujcuTPt
 qFiEzY7sa3DzyYqRZtOnkDnb3XN1o55Ai4wMnqr2I5RxIBF8rTeHBRpZ7NZ6ouEVPPQ==
X-Gm-Gg: AR+sD10X7bkG2rE91bRpI+bFgyLpAMlP9O2VolRIoevpv1ASXlbIKUz5xLFLblkmTLE
 gdP7UQHYrcBZQNgO8QKWg7WteHdV9SzQE9Oqab/4Np2OgyWjPszclWDDAYapwji8TC04R59tNFE
 xhvyCybRj/+RFHg9PfILAu6qaFjclZWJeuwWkJyRIoBvyPtVEXsTAVyCe9J3++KJVi33UTjECsJ
 R1ByodPgvOQKSsCqatVPXtduqTO5r6ndBpaYTrL5g0DIwrNXld8AJAad4vYIoHgBbCxNf8JZA4A
 RvJh9IMQl5Y+4u6pOo1E+F7f2iY2kZsZBPR25F/cth2GN4Q5jrAghHL0YvoExY7guyg26d2N9k6
 ggldo2zYIUyGqLM8bjMY+zTS7Bi0ywPEyr4fN5jnJuZa/V9v1IXnGvDzw180=
X-Received: by 2002:aa7:88d1:0:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-856281ab3d6mr4507415b3a.7.1787868958408; 
 Thu, 27 Aug 2026 15:15:58 -0700 (PDT)
X-Received: by 2002:aa7:88d1:0:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-856281ab3d6mr4507353b3a.7.1787868958005; 
 Thu, 27 Aug 2026 15:15:58 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:57 -0700 (PDT)
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
Subject: [PATCH v8 039/105] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Thu, 27 Aug 2026 22:14:00 +0000
Message-ID: <20260827221506.91574-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b71f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=3zGdDJLpS8I3mbvQAZ4A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: F4mFuv3cPtxRaN1SvpdJPqBhFJTbDX2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXya83psUFpdfn
 pZXPgn9J+7UGh20T2fV3Ulk/noIy9lbnIgkN18pdYhdjx9RhQbOaBfXB3OPEB9Ecq/sGStppjMT
 s6xlUsELUR2030qSDcDu+IlkKTVIdhFYSz+ug8vmMFOciB3Yvz6F+mDb6WbF25gCVJNkvjVTAGk
 aDBjwuAH7a1FzaSyn2U7/HLPHxiGKHv0I+iLrVxKfwS5gcPpb3lmXVDrzru7DaR0tZtlZr6JFkp
 3xurugTyYThxTTMb7oQU7Zjr64cks8fZYoAf3LkHUL+YHaTPJA5yagZO83Bv7ZGZsytjk02ZX25
 XVYtDeQ+UBf9ywjxuUhUZNJAkIFEkCGETq05j9mxB2xOba+qXwcMnh7+NHQlvLKVICMJpeG5RI1
 CDm+s100Xbtz0riHBMltylbatyUgcsmBKMidJJagHkoXDirMidm7X3ccshVVSQYK1I7b8/WIQ73
 XKUVXYLHsk6CktxfKgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxT+v4SU9BM+N
 04lXwEcEn0XtPgHGjZpKp51ia35RW2aksCEJ4Y2bSUZAcZPzClN7NQPtW2XfypBtRnfm1WHOZ11
 HFok1gfY4O7UJsi27f7HAr+8K3SM7Jw=
X-Proofpoint-ORIG-GUID: F4mFuv3cPtxRaN1SvpdJPqBhFJTbDX2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

fcvtzs d0,s31 requires fprcvt support in compiler, which is only
available from gcc-16. Since our debian-all-test-cross container has
gcc-aarch64-14, this test will never run in CI.

Replace the concerned instruction with raw opcode, obtained from:
$ echo "fcvtzs d0, s31" | llvm-mc-22 -triple=aarch64 -mattr=fprcvt --show-encoding
fcvtzs  d0, s31 // encoding: [0xe0,0x03,0x36,0x9e]

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


