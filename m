Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE89C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZgY-0006oa-10; Tue, 28 Jul 2026 00:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfn-0005XC-GW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfl-0001ep-Vs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46SG41821166
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/szRSCuJqid
 inYv2UA1YJbL9LBT2meK92VwMyhfKZX0=; b=FfJb5LarHxUk78v1tHFmlir/kC2
 r+0wIPdu0dwgsrMreYMDebypZ9ibRcukF5OXlvnTu1C+gRXczq5qqMKhhhsSXEju
 iiNeHwYkvakoackChqrLJIvEqs3H79Wqw5hDWXn5M90UQo7dDQ5FctCdi9nJM9Xo
 KVDNRx5sGcRbDjKFOZcipEQN4POeCmAfZCxa2ML0dJqeCRfzpXLnyNNKJN6tN2v2
 /75uLjHGub2OOCoGEF3MOlndQEFC5w4LSakNpqAAP0kOMXlILavJwrGnYydErBcM
 wg5homARFhz3MIdDU0ezz4SFScGsSaoI8HDVnqNqzbpW3ok7pup3iHLKWRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y03gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cce870a060so65944105ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213838; x=1785818638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/szRSCuJqidinYv2UA1YJbL9LBT2meK92VwMyhfKZX0=;
 b=jOatQ+HK6DGChC5kjNTF1+NRk+vc58qBdnlIxMS118TA2tz/8Y2lBSUtysR5GkwES7
 ao4cbHnINVWyUZs+xN4tFhdWTWxbhlUl59q/2+T75Xi9b/WiIR189rVADMmTvscPhhmx
 vs03ZBBllHnvpsgQu53z83zG1z0RXVWYeuKFbfsIni27y9cSafQkcZXm0WMKuif4OtGK
 VHi0JvU/6eNagghvWpSWa3p306e4WmFQmQhIRr755wAVsYqLzXuFv5AfoiAyobR+47dU
 Hc/K5IEJkmuKRQi2Emxs2lUPKI1+YwxmWloCbA1QLVeq1Gg2Y6kkRnQ7oHFWH7herUOq
 rzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213838; x=1785818638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/szRSCuJqidinYv2UA1YJbL9LBT2meK92VwMyhfKZX0=;
 b=RTvKu3Csa45jKFfeMRA2QodHwBgE2ldY7YCLfOpNhzHWfHGv1x/3MnBRDrXMSE6Qt2
 VKVSpueaRj2c/uAI2j8VGGIvNzUSiM1gXERGPoSXiAhSwbek7UZUp4AmdEKwm3xj/760
 KxQayI7caFkBVAvABdstbfvAI2J6DuaJfaLNO4IGNWfj/nVyhSoReUkWHyzjVYIaMJRR
 19XMOZ3tsoF+Oux4iWOEiVb5152HjUPesiULa38PtvEQ+1qMTlWF0Kdl/lVDOgcmFtft
 Vlv1oP2XDzd91N9Qfr/fXseLPJh29b7totcGDAfB8COnixP25RClOLDg3t/5xZdUsxxP
 PJcQ==
X-Gm-Message-State: AOJu0Yyb2LS3QeySEzM2TFsSeHEh0OnVHhYDW7wCUAbqRBGmDAWhynQH
 Fq7BfejR4y/bpF6phDIp8kFbt2mBZOb+HdHm/Kc+z/kNIToHcWmda8pSt8K5e3ZXo8nMMugLiKj
 ve0L73aWy/AoWW1wtG+AqvqPISY0oh27Rduotw8Y4+D8INCiJZRXsZnBQpawWQsPFMw==
X-Gm-Gg: AR+sD12tiZh84yKlDPBr5LCy5zvoU373ujBWpOFGqJ/PTAuImRJeBmZG82sxUxyS8al
 8YApyjVhfXycpwIrh18fN4KSmUQVQC8Xm6LFebYEusvvX3NnanziQOlwKg2NlIQG9PGlgo7HLeh
 pCEV/ye8Hplsh7V+/clEl7zlrHUyHp6oP170rCRRONVJIG7Ff2LyId85Pn7sTsmNVacxeGL6iS6
 vGYGNs3dJDbbKd/2pb1szCT7U1KWiOduhwK60RSeNuTO4t7krxXH33+IA8vZHg6TOlx16mgYgTg
 h6eKNJN4hr7jcbm9s8RmfJ8/yuzzWkxK0opidUr4g+tpfnYIUeyzZ5NiumuET/QJ9a/861Yi0A/
 WuYmmeBqOa3ctwVVUbYs1cHmOOgIquT47Gy/RMEUC50tkOgzP2GeSmVoiH/vSyJdhTbSckvs=
X-Received: by 2002:a05:6a20:7291:b0:3ba:e5e2:73bf with SMTP id
 adf61e73a8af0-3c8ba60ee3fmr1020292637.43.1785213837984; 
 Mon, 27 Jul 2026 21:43:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:7291:b0:3ba:e5e2:73bf with SMTP id
 adf61e73a8af0-3c8ba60ee3fmr1020262637.43.1785213837517; 
 Mon, 27 Jul 2026 21:43:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 038/103] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Mon, 27 Jul 2026 21:41:42 -0700
Message-ID: <20260728044248.137626-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68338e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=3zGdDJLpS8I3mbvQAZ4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXymsKXWElfUU0
 2iLLQW3gn6nDI28dRNtN5s4TazVkO0D5XZZ9aMpx0isu1c2CQLfwAainpFk6WjJcVA3fprABDj2
 3N9EskDUwppmzNpbUwlS+1y0aZcUxdc=
X-Proofpoint-ORIG-GUID: DesvCBaDWjeObyghGv5H5YJUoiVwPjrs
X-Proofpoint-GUID: DesvCBaDWjeObyghGv5H5YJUoiVwPjrs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX1Mwkz8etKev4
 H/JiN6NP/ulI3mi8WpHjyJT9wXTaqTD5nHmWrjM9HGskCyxXAEi2WJA28Yq9/GMjLY7kpBgDp5l
 jm8T8LPnpuFzN5rMZkIuZp/HqaK0qAnieZWa4nSVIst+MK+GW2XSwQhFUNIAfOO5EeKavMAW3vE
 uTjeLLvrEZ8vCiPsSUPbGOn7hW8R21RhpzItSvn2GW5rggnIUrJTohLH6kR3rbtet8vMfefz/Kf
 +mB11oDor36qzR93yM8mAk5CLIuTIwlUh2G8OBKUgms0VwBtQZiExf+EcSD1Ob6fnSmyum+Jkxc
 L4+ljndgR7Tu0wDHEUAmCn3lwLTHPyLPbHCuXYddk4mU+B5WADnjEWa51ETUTd+Zt4D98lszotD
 c+qe4aif+i4OPeNHZuqO0w3Td93LF9PzdZ2Q2CTnvz4rVbs2PyO8N4uNbXIqFuAWmK9JL9Q+XrX
 bEoV94sD6EwhMOCDExg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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


