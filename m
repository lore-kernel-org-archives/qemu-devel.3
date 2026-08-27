Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D253FC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziGL-00085D-EP; Thu, 27 Aug 2026 18:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziGI-0007sz-Tv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziGH-0003eI-3N
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLxmX1358884
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IETrIEpK4iP
 6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=; b=K7lDU35YSK7y40AWOf2cDzTEFbW
 llFVrzcorRj7rh5HWOd/8U409bK/ZxrcHlqGw0vqzD6tBcmEGUaAxZQxzKQR1a+k
 Xb/T19cIXXdWzCYYTmu7BnXloNpQ5jVR+g2ScHCM0r672h391jXXZjYajCQquUNy
 dOnpanqjh43RG/Ui68GpHdzxgEnXOyh115xVXdL+9cQGjs+lB8GAYf1t3EteYUJI
 8pi7npuTtwlm6rgBGm48f17KSAPcBJGD7ptc+X8dlhgDvm3oi+JvXZciAf1EvVii
 eTtmJ/yHJTD4zJtrQWjb8qn7QePZITznCJZUBRiDq9fN5IoX7yvry5Iu1tg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva8ux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e024d2129so667316b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868461; x=1788473261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IETrIEpK4iP6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=;
 b=ZA5C30KCvU6hLObQ9UqTtcJShDnQg67rDqO6FejGQybfs5CpSLA/STHZowkBPs4ZZv
 RNu7Jl3dD1ImWENYxQNlto/IvDP3uBRX5xF9jkNyydXlyORoTGffhSZrgc/cI2o5iwoZ
 FtbDPeFidiFUOJwZdosBwBqpJ4iR+kH7e+54Z7TPjRwf+VE1tO//NXYYgoduM1/HYdea
 6/q81uomU28Pc8zSgDPZGYSxL3JsWYpM0WGtuxn5EoFt85V2rqeu938TZnyrm4o8GmfB
 YsN9N4zbtBkBWxp9DkfZcH1LtaZmkTC2ZjXlaPEcTgyvKXnb7UDvZocD1GQb6zVn9wQl
 t1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868461; x=1788473261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IETrIEpK4iP6xUqjpPO8iyaMLOb21gNL++Q/aeN939I=;
 b=fyYrdO7OOw00Cani+ttNmdVWX4kUS/1DgRQtkn6GbSYu0B946vqHSME7cx+LUhFQPZ
 RTbpO0Sou+PsYwCfLhOAnYFYs+igf4Xzec1fUk60430ktfHgS0Yp0r5K3i1qs8oVdNYs
 DoxLvhBzMxs9mDt84rhcFbsoFa/NKzIZggwE8n3sEy0AjqwJnjXr6vdMFgJP7C8hpiF7
 cBqTZ2gAN3//NeG3X8tAPt9J/tm5FLO489wnoqtUhXUnVvBKnq92lHqWOYlGUwRq/Eor
 ZXUxtzkOLuhgEhEV7RzlgamT7F9NW1z8nNZ0k8ixXCu3i2WszIPiX/oUlA+bkL2j3tyg
 VNdw==
X-Gm-Message-State: AFuF++nLCZ9gMpUqVqqUeN140eALikeUOFVFudKEshE5mRaOnouzqSRP
 W0z2goPrHQR7k8KNDsRJAeqtNMEH8G0uxChrjZYet4DDoHgoUItd4T1WUTQKnAO3X4bBbEbUVpe
 xZRRvAuS/1Eo7FcegcdOtDaUplwND8pm2MEQ1iApHCPOgQ4pBX4iAg02f2oe+ZEEdCw==
X-Gm-Gg: AR+sD12WavOCNZR/JjJKEvqH3hs8TQPrnwYuyKq3pfrw7XXl80D6rH3cRjk4RVELw5s
 7xr8NnynN5oGqo0iDB1SKQLqLC5VITx3VZqdOHKiyCYdxr+FyeeplJBBaKcR9pSiVxKT02LMayd
 p1IiFa5+/ZYmhCdrWvPoRnkMCB86w4P3Z9NyEdGI2RHPIBoZv6TqGoTliqbwynATpPaubgk7O2Z
 u3yG0CNcfjCqYlNoM/CY9YwOvZJ5aSFFRH/cvuM9PEIswiniHvU5skfGF3WTY0kpJzrHzNQGX1B
 dyg3SSGPoksWkN6INRPeDRya6Ux6DQF84plbHm28t+NXBTCOIj1gUKsZcHubS5l60BP19CdARy+
 0/p7tvQlnatdaU8hS1F4qt45l1qGumpSkTl7Z0JyaJiWO1d9+kE8kWvUl9yo=
X-Received: by 2002:a05:6a00:ab0a:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-85629f09863mr4744479b3a.10.1787868461001; 
 Thu, 27 Aug 2026 15:07:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:ab0a:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-85629f09863mr4744397b3a.10.1787868460636; 
 Thu, 27 Aug 2026 15:07:40 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 039/105] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Thu, 27 Aug 2026 22:05:33 +0000
Message-ID: <20260827220641.84885-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FpwlWJBwOc1gAzK2ZU7dd6e2Qzmo89MJ
X-Proofpoint-GUID: FpwlWJBwOc1gAzK2ZU7dd6e2Qzmo89MJ
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b52d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=3zGdDJLpS8I3mbvQAZ4A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzfunL11cbJXn
 8BMzsU7kSrkiKH4w3PUfttZcgNr/03DJtWFp5yrpTx0UeB8R9PHE9k6THEP9V5//yeZ0KBNYerN
 9sedBhvYlxvioV69sNWf8wvCSi1lcuSv//PvI91sM20am7IvtST9tuTDSXEHAsptXKa49WwDDvp
 esYGEcRRNicoyDNocbtAyKmh6XqjiA4GlC2Xd0T0fRPpyY3slaMhfH+MMFzrkbW8/waJdyeT44G
 ny7fcCcs7Btqt99ACN6xEOGuZmmTwmK/bqRABPEq5QJEFy2SNS+C09kDj/vn2O/vYqS33GOlUw9
 BuPGAeASdXNpQtsJ53YQXsrY3XqAnDYLdM9qQe+VyuuUU4wigSsKKh+Nd03axGIk6SAUzL23jv6
 DlZvGpbJJ7CKwQIEKdpg4p/SzXs55QYywhlyZm/GLBIBCBkwL6kHpj2ne5Z1om1v9CWI/hHGSLF
 3ar8Aq8ymmY6NR9h2OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+PwUxSx+uYLP
 0BFnef62GQOtXYkHwHrgKASlXjUs8u8Kb4PCktVPliNM2gJxePLTMHNRDDbv+B5hslHMF4/W/hM
 MCMzlExjdf/suguFWNtjhc9HJ5MuLfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
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


