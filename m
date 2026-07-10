Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6ECC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cP-00038I-Rb; Fri, 10 Jul 2026 02:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cL-0002xS-65
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cI-0004pP-32
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mhCF3847273
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/szRSCuJqid
 inYv2UA1YJbL9LBT2meK92VwMyhfKZX0=; b=NkvnA631QivAEhU98epmH1m94R9
 yz9jrTKivcYFMnx6y+w+yzYvfmVKkmBvgEqEKiz0Z9BHbgyJ/jh+yf/So0LX845X
 GvXL1eUGGRYRTLE+6rc9B6JLGLnJL/j4KM88o0hVxzSiX/fgHVkMnDAqOHxTaF5s
 chMc6o1JfNHJyezSGGSWbJpSMq/eeEMHHgHQF1y84fusmfsXa8BV/rVvuJI3MMBs
 Z98PsMHrwCjLO8Tieo/bzx30YHqr/8Ze9VQzoDeq7T3PEFA06WjMzI8e96h5jCLT
 YdfeobAExFZyah7KV/mtbgr74l4zSlWGJyQfHqTBR9Ctm3r6it8MVk9ONgA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1pq0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so1271088a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664490; x=1784269290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/szRSCuJqidinYv2UA1YJbL9LBT2meK92VwMyhfKZX0=;
 b=JQU/RfE9SD27dBj3S4YcyqOGhTtkZeZTndZPa1/PomTHdUPFwXwOTwh1WEecv+ulZt
 PdGRsT8zqI8iwIrojuIm8dPBB6b/wMD5q87bMdvqRyXHop618rNEYEy+R0VOy0uOnOdF
 WhEE4c2u5P2GWQjT6oiBLIgGlO1la0TzjIHzlVe81guoEdn2taTvMDzu/3hsqYBx08T7
 OOIggGWjU2wcHmaCqCYLgCLLE2m2MsC/g6gGhOUCMaGPE/NClNTVEFZijL9Xs2JfNhy6
 UEn1Mi8EUZLq/L90QeOHdvggQsb2zdAGg5gfqa3d4usaZ9yfc1K4cKHjHe8VkYzwXy2a
 uKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664490; x=1784269290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/szRSCuJqidinYv2UA1YJbL9LBT2meK92VwMyhfKZX0=;
 b=aVgE9hQIzQUoO6mNJMLrVZzWsAA/Z2QRdzjmUzOM1OmJ1H9ZY2Sx/n7iThROwqerHS
 MYacknXuwIpDBO92YzVgpmbeoNzbvr3dn/43q11yd8uU98//jG3KAWDrCaKBWdi1Xlj+
 Y5zcYe1goHWMEWyT0ddcp/vN5bYJB5g+V7sZ/YnoKRIDW+ovdoiFiiUCH4lWztezIOOl
 LorCSLmBPMrN4wacehLZ2sDq0z+OhISp2zRI4pu5ulbzxvx4XXUzTsxvVO7N2CMn3YcD
 4jHHTgc5JxnKnl1Kf2af4I7dpV818nCexr0ZMotyLnetLyIdnKT6pGx+SthhMA+PFVpf
 AQTA==
X-Gm-Message-State: AOJu0YyZXLD85hbCmvCwWN4PQDXU4StGsgaimCDbBA501/sqpX0GtE/C
 51RefuY17HuRFdqjtM49EgwdhL+YYsZygug9+44jsoe5mv/bSYU69HdHpC3ZbqB8mUwqf3Bomha
 iaJB2YBXnCkPm/PjpgEAZskhPgvVsE6drhc+65e1aOcny7JGKIC0nxxKT/KBqlxtCdA==
X-Gm-Gg: AfdE7cl9gSHPEkjl7ifhogFW0ZdcQXDpRUMOcUbye9YJIGphZKv0vkF4C5hG2+kTUyV
 KCx9pxvCMwH2WzvMWwXbaUtr3U4jPqHJElFYca/ozGAwG4zNkqYooyX9dupi91aPvzm9xKSDzYh
 1uE5AUZuUE6QJi9Pbnl62L4HFxiuTHQLiroOr3eKwyNAEn9e8Xk1ZTfitVSE83aM1bAYFD09gdm
 ZO/HyYwRmVSHZDLZGS1iGVVMU9kvPhjHjC+DULu63h0Mz3sj1mSReEqicPkiScZTsvdKvZOkFFy
 vaTxPdW3VwvGpLjKEn5k3Op+/g9KKE2RWLdK7epYkbpMUHD99gfEU5H3uT70qbSTHqIJPevJho8
 aGFmOYn+PSmWD9SMT4enILBiwg1hBRCmOSTT8Ha4y3s/aTAY9Jid9x7IwswccY15mEYcAQ+UPIj
 c/e2qnxw==
X-Received: by 2002:a05:6a21:6b01:b0:3bf:edfb:62f0 with SMTP id
 adf61e73a8af0-3c0bcf28099mr12388392637.55.1783664490088; 
 Thu, 09 Jul 2026 23:21:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b01:b0:3bf:edfb:62f0 with SMTP id
 adf61e73a8af0-3c0bcf28099mr12388365637.55.1783664489645; 
 Thu, 09 Jul 2026 23:21:29 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 36/97] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Thu,  9 Jul 2026 23:19:14 -0700
Message-ID: <20260710062016.1818125-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S5H6Ve1V9hGlFHekx8DKCWrWoDNfP37I
X-Proofpoint-ORIG-GUID: S5H6Ve1V9hGlFHekx8DKCWrWoDNfP37I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX5saTlyduvRWK
 8WS7iMfOewTq2D036WjzgeoaxoBtxvymeOjF+L1znOZqhZGY4A/BGg/pDdDRoZJSX5Scz/iMJDA
 YDRpyAIrvcTutj51OltOcqpqoQPCr1FE3l4aYs7brzNN3LL1ToKsTJs8SEng09HnqqZ6iWaXKQ1
 E5u+StI2sBJmjk/l4liZy3G4x5yw09obn1Ea8BQSArY9Stq4wZIcxOsBwAOHTx9IWu9yLM186bu
 zQ1rSyysOQQxAkvLSqdOGVgXZjwPFAsp9HUnbhp+vpRXdGXLxDvh0nU7t6FHyDaZxR1hB8JoN5/
 hJ+1rUiFwi6eHaJT1xwPch3xmAfEm+UeGyF79MY0N1WY2YIrtYA9uZmjFEsOOE4xKYyo6oUp9mM
 HCGOq+sfOZPJK4jof+jTq8H1Pdgt+H1EaKDk9rM6VzLOiXmNQxIkhDi42T6NbVogVBNh3fd7tlR
 ciUQ8INZVa1gpCT9G9g==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a508f6a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3zGdDJLpS8I3mbvQAZ4A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxqofUxHISxKA
 ExieZd4Oi7OdrAIbsvNjODt3m/s12My4N9vHunfEjtb7nQGVfmpl6ZoXCPtYZc92dQXE86tOe+Z
 REyBsZhp9/yDOA6FOZlBnkvMFDumnqo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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


