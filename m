Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2750CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAO1-0007q2-4D; Tue, 07 Jul 2026 14:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMQ-00065D-JH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMO-0006XV-WA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTBhF4194065
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZOCC+BVnpFcEU5n6NzIHbE/NkewddBue6uBFvx3CZXA=; b=Xlw8o1IWjJkCUlcu
 wdrJQvKPwVN9qR+3zY88LgukQ9jttAd8SoyBoBqtz9fjUJiizHWvh0d3S+01HcDd
 ZfXyq6H2JDLvUUfkAOzwgwCTcZB1Z0PHr9Tzj6Mp6Kbt3X4xU5knE4ZPuMC6gWkk
 vo5CJHPBNhtNZk289cO28CkeuMAoHJKaBUAZaBRrRT2j3xtFzQc/hnDKHTorWxEr
 2y2GsSjR5m15cjKluGBs3Xq5NQGGmfFkbVrnqeUo/S5srXHibcascbkCUlF8zm9n
 mJvXFbPWkpEpBGG7vYQHV0Z9OjmlC70W5GQbPx0DzYEGDbyQrORLXwglilCOiZkE
 Cvn/Hg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9ab0du-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso60837231cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448251; x=1784053051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZOCC+BVnpFcEU5n6NzIHbE/NkewddBue6uBFvx3CZXA=;
 b=bfuAtvefKOKsjKeJ7FmZ29PLzdPzPxV63knzZU3zMYEtjD5Fm0IpEu41rwZtUTqNiM
 P0Slmv4AkIQRxtUBYtWNubKNmx+8g51SP9H9pdgiqCxCXTlnIdMZ//uOvnRvGCUDQoFF
 d+kUMv4aCxrlq36GG6SiqdDCmi+vNyd9j2TIJOXSSeqZkCQvVzHUXDRjf4XBLVD6xe2E
 Ls8cgiTmgd/cBnxB6bPwlET6Yh1tqCHoISJyxdvXcBK2iBze5DYwoT2sjHyrnAk0ld8M
 36RkDDqCyVIYijX/ZUfaHf1wzHvZcsm2vqqJ25N5vOJzh8xcpvZG6cB8IlZJcfRzSRPC
 FLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448251; x=1784053051;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZOCC+BVnpFcEU5n6NzIHbE/NkewddBue6uBFvx3CZXA=;
 b=UgsY5pMPU+3TCrUZFnxUw3LhiPPD2EDaCVesEFslZOoldEwkJM5POwyHdUhQ06MG/o
 3dwVpoZsMipB1bDKY5YwtDTozBBhqYf186yxOmiLlIw2jNkBMMedaDZGqpqx6juQkR3D
 Wx5+CVkB58KR/8TJsBjgM+VvuJ9TIHMDWHUoh69EnmIf61dDiHlA3ntmJeTzAneJDAGP
 cyoQu7Xn2OCcOJ3E2sbN8fTWpiTw0Mou3w6yd7uxBk1kx2tfO/Zaugo14jrwKi9ppKT+
 vQOEmd3H5fypaVvCK9kct1nFJh0XmzuD6rg31LDtuUNUrHgtcoqa5VDLeLu7iguBRCE5
 9mLw==
X-Gm-Message-State: AOJu0YyaCo8MN4ICVUCHD/9ZDwrqzfOg+9pD0ydF79KjRRSVd2YDrFkT
 sb6pRV3g6VtzUikADlG09L7yCMDUxr6ZW8Ufjt671+0AtbaLf+D7EDrqwAAAa1zAWl0gzYthgBC
 2ZpQm0dGz7ZCD566uXaOCJaql1lIcqe0U99SH1EQqkeuBxFnqvL7Q/J4e7Syu3KSk3w==
X-Gm-Gg: AfdE7cnMknKKtdEhOaO1wwgefbHTjMhZ+tBfDpflLgZc2vVccddmbqpAIwhnkQRa1p2
 nS5FNAp2KZ6i/BeSEIUdnHCchAdVn0hF1gCcznOHiq25p6lhKZQqGftYy62htIeLlrp1JJxUhoq
 YVPTPI6TaVw2CsgyRxKWxCLmoVmSijtXh0yUK3Qn2s3zo9KYLW1xs4g+c7VzBy3KTZQU4gDKIc4
 HNNk+QUQlS6XICOmlAAU6zOuaytcKJUpmTXFNidR2uX1rP2fW/+3xWRupQhTygNMXMFJWvUkgoS
 sbKrV19iXJHB1riPRYrxi8W77wsQ2TVSaVmRCxeGZLU/cEat1z/gGJaJLndWjsNApsyJbaYgCGl
 mekEMVGyAKHMno36aBbpC6TpRyObCGzWKYSgZd0OaaKl2alGCG/gNiV04D5vveTIGaCvE
X-Received: by 2002:ac8:7f11:0:b0:51c:7b11:41af with SMTP id
 d75a77b69052e-51c7b114368mr38253951cf.75.1783448251236; 
 Tue, 07 Jul 2026 11:17:31 -0700 (PDT)
X-Received: by 2002:ac8:7f11:0:b0:51c:7b11:41af with SMTP id
 d75a77b69052e-51c7b114368mr38253551cf.75.1783448250704; 
 Tue, 07 Jul 2026 11:17:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm38677884f8f.1.2026.07.07.11.17.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/23] target/mips: decode Octeon ZUC and SNOW3G COP2 selectors
Date: Tue,  7 Jul 2026 20:15:22 +0200
Message-ID: <20260707181529.60191-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U2YtMsoywAQ3yTWjAVkRZVbt-vN-FKDv
X-Proofpoint-ORIG-GUID: U2YtMsoywAQ3yTWjAVkRZVbt-vN-FKDv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfXwhW9QLTqMTdc
 7ylT1X7CY8yeb1PbP36uDKr3t85GRmKqeBv/KQTB7HuCTd4f1sQSwjl+3driv5RmY2NkwrxXU/I
 NZ98pKUu9u0tVZ2iYUxM2Dt/TX7lA08=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4d42bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=yyVd_-7kbyztQqAuhIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX6RMPTjpFdwnX
 aCeMG6PlSixrf2GyQgvPciL2rqok+0475b6gxY8KPGqsi2KguX4a2rmU+H0G83tZR5pAsoCd8XM
 Qgj/M6yO5yVutnq3ovh55yndiyxj1lhLZLiNVNSRQbekd6u7q+LgP3TcJaMj8ktCHsRtM1TzTxJ
 Ler6YHe3gvf0QrVzKUJOCD79uRJpdu3k/zwFwhm+Z1BWFkIKDPGxo2RgQugEVohRLgN+B7gi/Wg
 AnepDIwZ0XbJRVRsMf6lvsFcFYlL4J6ZV5RXp+8kchidF4XxNHEWrke3KKzdk922BAWTbhkZr/u
 p6wE4iiZmfZPi34zPdR0/csJy8i/VCXdcuvwxzw/8Qijs7Q8vdbBZP3/zusJ0gypKryXP6ykhHm
 PHt7J+nP6MYIsewOGBB/gcEaFhy0HeBSkwZbOLz5gCWj23jxFUJHJMmRFKHnYQbhydJdKR32Nxr
 N9WvYoaxi8mORctZkwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add explicit decodetree entries and translator bindings for the Octeon
ZUC and SNOW3G COP2 operation selectors.  These stream-cipher selectors
operate on the shared HSH register window state, so dispatch them through
the per-operation helpers added with the corresponding engine support.

Keep stream-cipher decode separate because these selectors share the HSH
register window with unrelated engines.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-17-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/octeon.decode      | 4 ++++
 target/mips/tcg/octeon_translate.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index b1a63b743f2..2b27fa205ff 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -265,8 +265,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
+    CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
     CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
     CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_ZUC_START                     010010 00101 rt:5 0100 0000 0101 0101 &cp2
+    CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497e5a6cec..b4663b35a34 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -345,6 +345,10 @@ CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT15, sha3_dat[15]);
 CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT16, sha3_dat[16]);
 CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT17, sha3_dat[17]);
 CP2_MT_HELPER_ENV(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);
-- 
2.53.0


