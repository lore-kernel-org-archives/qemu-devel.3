Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B059C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQG-0008GE-Kb; Tue, 18 Aug 2026 15:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQE-0008F0-O2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQC-0006kl-Br
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIoqX1971957
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IETrIEpK4iP
 6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=; b=UVr9+x/64F4NML0+m5Y6x43JM5R
 TQa1Ue/teAfbW0dvop3NtRu4tKJo+iPXHKqb5vx4/TWntDAps1gGByumRJ4fo9bv
 JDTKOEltYxZlJWlcqCdh8za7NiXw3gwuim8EsPjHn5jltQlzBA2FxVpJ8Uc4w5el
 RCf938dpobEY6kzRER6FWm2k45LRw/IODdfe1BlZSAdCuLuWAbOBNqzf+oTJsHfd
 LE7l4dTlHz+Jh5d66gfZTYxIYir15BW8BwS2wag45sFLQ0edaY3xI1IT4LF5OSok
 IcCNw8CIi6SU3RbyRYVbwr8B0YP682O2AotDMLPtbcfLvnTksc5ad2cisVw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1se5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso1713485ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081054; x=1787685854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IETrIEpK4iP6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=;
 b=cDZwExWJwYJBPXSP/i54ANMCgd+UwQin1ZnfOhVzyqQVZ/+oUOxXRUZ7diJ/KcYdcM
 gISy3UCSZ5pvbjXL+MJsw4/ebEz6u32wWVFKncpIzNA5CGX0aoRA3/yem2smEGLVLqQi
 k2yZIl8+ACjApgd9fbGUsx+Lm3y6742JFI+hxkqzpm1Ma+9Wv3RkqmUQeGL2ogJgeAJv
 MKkY3jXOaBFhKwbbZQnJNLitH/flnqGWKqRQrfYb17OCsQDndDMiKkbStvyeF/lpb8Y1
 plMOKXyqWf3fHx2//wLi9Wxm9Es1fU5Er/eJdmUa04YvjZxA4nQNvA+OfZtoh8wFGela
 zO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081054; x=1787685854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IETrIEpK4iP6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=;
 b=U/HEobiJsiI6z1x+nTnkga+A0OYHPi3C7U07YM3UFX+4vKDNdVFqMFfXxiWv610qFx
 mkS0M9FZ9Hc0Z5VLQ1Zt38vUXOzcGXgI0bWiEQy6Tb4iyIazNLFWJ4uBQBC/d5i9FaY7
 4FicD/khd9R2fpRWCJSrAGZKICM4E1h0hjSDjyrWv5GeHdT8+c1mOaOcAP5+KMA0LKsj
 3ZxZs0OMTwo2YCCVk18sTOB2IBlgZvg3ErfzRrad2jh0pxzvHubwDsojJyUfbYptozUx
 NZ8gwVxbITw+Ei5WVyF2f4qtalMg4ZQ7129ExRLLRSqaObC5WKVCvMgVO+C9gl/mY0Yj
 nElw==
X-Gm-Message-State: AOJu0YzPqTJEbo6HTf4TDvjnyLEpVj54TukBRhQNQR9HfnY8Is9PudHh
 RmL/ZJoI383CVTzUShn6w1eO39U7tuRCpwPnS/AaU7U95Jy/BaVSxXXQW/vfQqG1oEErjyvEX22
 yFXoMQlXZwMQiFqaX6aN5NqiPqMbjHfvVNa0jrta2HDmNhSIafHFnQncLQx6zqn4Fgw==
X-Gm-Gg: AR+sD10jZSO9DScHqyzBS9InlLV9EuDm6ed8++6pEVUkBdKoakbi3o3ScwEF9rssT4S
 d8PiRhhV/u59DzfiACHHzcspPnvUU4JcRp7zGqFdnIeJBQMVJ1LCL/mEvzohRUNa04dhiaGrWFM
 i6fd50As03OzhEWm6lc7MR6OqDmsKFcw18dkXhDVuh8fcRwzWIzILuJnrZHlOL46I/E4zHeVuH0
 KMHHhY6XU6p+PFriXuVSWMu5alhhfwhGUUqUvx4QgymnvE4h4w3X+2b3lhRAC5Xd2QIFV7vRG35
 oMdANnQ9FDUuVm36C96zNjGi/j1pk9Xv9kI006spcmIh6lqSGN6WoTPLldXNT0VgpYspLIKwbjb
 vNPgHv+pQxoyuyVe3Qu5+TUqkakuUjybbu3frkJBU3Mtbl+n11iPRm1ME0ZA=
X-Received: by 2002:a05:6a20:b7aa:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3ccfe675dbfmr485552637.0.1787081053403; 
 Tue, 18 Aug 2026 12:24:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:b7aa:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3ccfe675dbfmr485459637.0.1787081052955; 
 Tue, 18 Aug 2026 12:24:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 039/104] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Tue, 18 Aug 2026 19:22:03 +0000
Message-ID: <20260818192309.22169-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2huoRLEBAz6+
 +odpm9brMkht2OxwUuaOLqwj+8sIBvpY8AGwfGGijOw1zVojmIDOTVd6XuGK+RyEbFLrm78nYCo
 V1fenBVe2P8/teGfs+U6QtMhQ/9xvw4=
X-Proofpoint-GUID: f9WlOmYmE294ueSfzww7LJ-k6nEKvHmJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/vQVHnVXjO0N
 Enu6ZPPsslifo5DcdUpFFUFqbg0bp5JVxdWX2UGIHawzQAR2V+bE3umZG4/rOQiXTgKUU1G0CaZ
 vgWSHIAfcLa/KlAbXfZEAJm++dEgEPnIyBlrRRZb1wi+ZistOJTbYDW9EjTTcuD/O8ATc52lr9t
 +hlVKw18rZtZ9oQ9uJdP35Lbg+WaCsWI+ZvJimRciSLVvB94E7mUihCorwYI8oiSf/ig0eRQuR0
 PP6QBgfyPrXIxM0CjvUsmrxzZ6bIcwt/mdf5q7WtzojPmMKj6yapT2252VtEd6aWksgXL42I77G
 DmWFau9kiZVlmUU+p3YDQUv1hL1UPQ/TQatR2LfIp+/hVnqH2eIttxWBwSKrTf7dilxsu11+tdY
 AwdWUI2rTLSZYqjVukGcRxA73yZvvFGW2PAUP2MWQUpjj4Huuc3NoLrSiO5+z1PlOwXFbGzGRCG
 cPhpvbkHYWsjyhQ56gw==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b15e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=3zGdDJLpS8I3mbvQAZ4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: f9WlOmYmE294ueSfzww7LJ-k6nEKvHmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


