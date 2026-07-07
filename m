Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4937C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMq-0006k6-Jg; Tue, 07 Jul 2026 14:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMM-0005xR-61
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMI-0006Vz-WA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667GxaZo187964
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wDPADTpwN+4bv75/s9vZUAKbnfqR7GHOmTTI3hQ84ZU=; b=FBA24MPWK1KZ6sEA
 BOWZuRXcAz/X1+yDy7xLoFzy9nHdLIw9LS6hPx0sNOUeaBctqAYYE2yWE/IuQuOw
 h85iWLfIEyZOJW1ZPu2Kj9JL9ji3YjfdfQtIKjv8M6kRL3ca2Nq3AN+Iqx/Ozb3c
 cydvtUpMQwi2KQSuEwmLEVrh8y3YkubiaR0im41MQJJtk8XY3LYkKtYr64/C1mdh
 igMvLLItWiYHoC6ZblixeWonPquhs94S4uLqypTS8V7G1wrcPZaR260vUiZbZ+/2
 iNmXb1jR8lky1OZkplh0CBJPJIBo8RHHZOKVQXso4HOf63NizjfyyJVd1dzE2AjH
 p5v7kQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd0cfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so49358081cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448245; x=1784053045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wDPADTpwN+4bv75/s9vZUAKbnfqR7GHOmTTI3hQ84ZU=;
 b=IlSmmYUHr/58rDu3hf9wW0KouKn0fOanoMzfzsaldTm5F3OLkofZY6n6KazJzxdS8R
 LMuttVILFpsEFa8hZzpKM+L67re/xVknL2XJ1iIt/yJlDk9x2mkJBV0nVEiYyoUBKayU
 YtZj3XLwOErxzLrjAzyfh6cUDHfbvMs4M45uvbusZqxkyrJgos2LmyMKPXhHOMq2q38t
 WjUOML+4Bmr3J9GTYEN+GH2w4zPmp/d7Bwz5QSFcOkGRuniAqw+HVTg0w5Zy6RQqZOFM
 3XLq2WBSaFYwothBVeKE4E4kRjqAmxr6Vg3bjfmodXj+Zyc8P2+Nh4wO9uYwiz1fGCgI
 +uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448245; x=1784053045;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wDPADTpwN+4bv75/s9vZUAKbnfqR7GHOmTTI3hQ84ZU=;
 b=DdJuUxtozP5eI3fGXQwpi/LB1T/d3T4yn3xYrfqX1r0IMSdCQFd4s36zXvNr47FD4m
 s2wbn0ZSGrHc/Qmfuee1c6iNxi1GPWRfAVl+hXcDKKkMnFzZ6q4CVj3DOGu0OmuscSRh
 kCIfvZRMXt3Ao5ZqNECT82qZ381W0F8hWNuGDbV4eFBxfVNytoUPlNopc1S2RazPg0yE
 a12vGCS5vMw3OvATlvcAl9tu3YxBLXCNXzgJpAHD35n8qKn3DBQ0c6pSMieIXH68UHfH
 5PjkQsBalintRwLBt6mgHY+5djXifBx1MfNDjVRJPtwcjmFTNDCAULREelxjsUSl3xhW
 a6/g==
X-Gm-Message-State: AOJu0YzrcHTbQi5esOivobkgekf4tQS2SBdz7XqVrgG8sYgUAGl76kp+
 UBDsznyjPjkd9msBPhk9+BQcltrVTdF/uoFgnGgZ98cYXvK6OJZ83pO66t+PBCTU+BhXs1lZVnM
 zhl2Y7rP1YfiXHD4g6QbeFUAYZ0LwumqFPdmxthZykjhL3am/VlQXBoiXVCdmZAkmZw==
X-Gm-Gg: AfdE7cnjIwQWUjECt8jsiHbs550UN5WJR1lCFZhOxGt0KCLbqSZrBSFhiDJf3/DpG7r
 FWfC5fetGz9HHsVO8dxP1ikVtAmunbcKXoc1aUNlmKTxMoVlLYvKbUkbFBazIx4AhzbwXeWSUDK
 fbOz9MRpdy2MpjQRnpSlubKyAhL5sBou8BNioOTPESklo/5jZh4+0QHJ/0rFU1DU6bkmnSAKNVQ
 cex9gMF6tQkAr72cH2i7kbT8+JmYFtkjmc6AGtuntjrzXrA/+cX/7CRN3ew1sFMomKmA4LpNVWO
 +gJlpkwVWv+Tm0L3ThEMATgwaDPtxwUsV3l1eSq0QTPA1LfZ4Wk0VtHTF3l9QNAK1V1QOQiU+dL
 Ie8NKgU04DOB2NELnGmOD0mNHLg6pV14fjWIiEQREP83t0lC0B88aGiJOmEBBJu0eQ+fQ
X-Received: by 2002:ac8:584a:0:b0:51c:1b22:b855 with SMTP id
 d75a77b69052e-51c748731admr68758841cf.62.1783448244662; 
 Tue, 07 Jul 2026 11:17:24 -0700 (PDT)
X-Received: by 2002:ac8:584a:0:b0:51c:1b22:b855 with SMTP id
 d75a77b69052e-51c748731admr68758221cf.62.1783448243780; 
 Tue, 07 Jul 2026 11:17:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm34689935f8f.33.2026.07.07.11.17.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/23] target/mips: decode Octeon HSH and SHA3 COP2 selectors
Date: Tue,  7 Jul 2026 20:15:21 +0200
Message-ID: <20260707181529.60191-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX1cpoajL5fSLk
 nQKnIBoeb9m4h0Gb2kKC+Z7YYgZwhaNyRnxXq5sxVQzRAFaCSbKNnOBuqrUfCNGuxeyxDUeaUNi
 9hv/4RvFwFLciwZdLsdbiQCPFHChZF6cmTOdMTu7/y5CFVMKPCXzjp1dcPbnKaYa9n99QtxyDIi
 LfK+jnAxLwANyL3gGHWF9EQbeMrlFFmH3Ev7PVGWOEQqDCx51zTuGQnBr3lNYI2+AtQUFp8wc/2
 MCYwjqqjaAtxQ6p1Z7XiVOEIKzWchEtWlSVpYv7WX4PbLeSgL06g0/IUu6XEbwPAHC0gTJ84D21
 DdKD7x/Fi6MHjrmwFmpJw8YPnHd6H1C0iATyjojTBJqTPhht1udGiJH2vxRoVFqzawU9hE3wYNg
 g8B7WMhmOa7dXfyFz6bA16gqsM1EgRW2uPBjSdq7zfQd9Ij7b3p1brT3MPnMab6oLPv6ODPCUke
 hO+T4AAaG3sgUz0QWnw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4d42b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nzZw3bgjB8hCpGrHF1wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Wc0XJLc6jchPWPjtw6qVdsMha4QSR2s6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4ULXF6whfWOj
 ZvM0EUdNDmalfpqH1jOqVbCTSMPslmFTLIqoDzElpQhoFD6Lf9RBD1nLcM8ApgRFfVuorZFVXlz
 fiwz+UvkRAUNcsFNqI332deHwHghK18=
X-Proofpoint-GUID: Wc0XJLc6jchPWPjtw6qVdsMha4QSR2s6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070179
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
HSH shared-window selectors and SHA3 operation selectors. Simple SHA3 DAT
register moves and XORDAT selectors use direct TCG transfers, while HSH
operation selectors and SHA3 STARTOP remain helper-backed for their
visible side effects.

Keep HSH/SHA3 decode separate from direct register transfers because the
shared hash-window aliases and side-effecting operations need their own
selector coverage.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-16-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/octeon.decode      |  77 ++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 102 +++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 70e02d0b0e9..b1a63b743f2 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -113,6 +113,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_HSH_DAT4                      010010 00001 rt:5 0000 0000 0100 0100 &cp2
     CVM_MF_HSH_DAT5                      010010 00001 rt:5 0000 0000 0100 0101 &cp2
     CVM_MF_HSH_DAT6                      010010 00001 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MF_SHA3_DAT24                    010010 00001 rt:5 0000 0000 0101 0000 &cp2
     CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
     CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
     CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
@@ -137,6 +138,30 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
     CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
     CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
+    CVM_MF_HSH_DATW0                     010010 00001 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MF_HSH_DATW1                     010010 00001 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MF_HSH_DATW2                     010010 00001 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MF_HSH_DATW3                     010010 00001 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MF_HSH_DATW4                     010010 00001 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MF_HSH_DATW5                     010010 00001 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MF_HSH_DATW6                     010010 00001 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MF_HSH_DATW7                     010010 00001 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MF_HSH_DATW8                     010010 00001 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MF_HSH_DATW9                     010010 00001 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MF_HSH_DATW10                    010010 00001 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MF_HSH_DATW11                    010010 00001 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MF_HSH_DATW12                    010010 00001 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MF_HSH_DATW13                    010010 00001 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MF_HSH_DATW14                    010010 00001 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MF_HSH_DATW15                    010010 00001 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MF_HSH_IVW0                      010010 00001 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MF_HSH_IVW1                      010010 00001 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MF_HSH_IVW2                      010010 00001 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MF_HSH_IVW3                      010010 00001 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MF_HSH_IVW4                      010010 00001 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MF_HSH_IVW5                      010010 00001 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MF_HSH_IVW6                      010010 00001 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MF_HSH_IVW7                      010010 00001 rt:5 0000 0010 0101 0111 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -153,6 +178,10 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
     CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_SHA3_DAT24                    010010 00101 rt:5 0000 0000 0101 0000 &cp2
+    CVM_MT_SHA3_DAT15                    010010 00101 rt:5 0000 0000 0101 0001 &cp2
+    # Cavium SDK code uses 0x0057 as a STARTSHA1 compatibility alias.
+    CVM_MT_HSH_STARTSHA1_COMPAT          010010 00101 rt:5 0000 0000 0101 0111 &cp2
     CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
     CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
     CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
@@ -182,19 +211,67 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_BYTE_REFLECT              010010 00101 rt:5 0000 0010 0001 0100 &cp2
     CVM_MT_CRC_HALF_REFLECT              010010 00101 rt:5 0000 0010 0001 0101 &cp2
     CVM_MT_CRC_WORD_REFLECT              010010 00101 rt:5 0000 0010 0001 0110 &cp2
+    CVM_MT_HSH_DATW0                     010010 00101 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MT_HSH_DATW1                     010010 00101 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MT_HSH_DATW2                     010010 00101 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MT_HSH_DATW3                     010010 00101 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MT_HSH_DATW4                     010010 00101 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MT_HSH_DATW5                     010010 00101 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MT_HSH_DATW6                     010010 00101 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MT_HSH_DATW7                     010010 00101 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MT_HSH_DATW8                     010010 00101 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MT_HSH_DATW9                     010010 00101 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MT_HSH_DATW10                    010010 00101 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MT_HSH_DATW11                    010010 00101 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MT_HSH_DATW12                    010010 00101 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MT_HSH_DATW13                    010010 00101 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MT_HSH_DATW14                    010010 00101 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MT_HSH_DATW15                    010010 00101 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MT_HSH_IVW0                      010010 00101 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MT_HSH_IVW1                      010010 00101 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MT_HSH_IVW2                      010010 00101 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MT_HSH_IVW3                      010010 00101 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MT_HSH_IVW4                      010010 00101 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MT_HSH_IVW5                      010010 00101 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MT_HSH_IVW6                      010010 00101 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MT_HSH_IVW7                      010010 00101 rt:5 0000 0010 0101 0111 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_SHA3_XORDAT0                  010010 00101 rt:5 0000 0010 1100 0000 &cp2
+    CVM_MT_SHA3_XORDAT1                  010010 00101 rt:5 0000 0010 1100 0001 &cp2
+    CVM_MT_SHA3_XORDAT2                  010010 00101 rt:5 0000 0010 1100 0010 &cp2
+    CVM_MT_SHA3_XORDAT3                  010010 00101 rt:5 0000 0010 1100 0011 &cp2
+    CVM_MT_SHA3_XORDAT4                  010010 00101 rt:5 0000 0010 1100 0100 &cp2
+    CVM_MT_SHA3_XORDAT5                  010010 00101 rt:5 0000 0010 1100 0101 &cp2
+    CVM_MT_SHA3_XORDAT6                  010010 00101 rt:5 0000 0010 1100 0110 &cp2
+    CVM_MT_SHA3_XORDAT7                  010010 00101 rt:5 0000 0010 1100 0111 &cp2
+    CVM_MT_SHA3_XORDAT8                  010010 00101 rt:5 0000 0010 1100 1000 &cp2
+    CVM_MT_SHA3_XORDAT9                  010010 00101 rt:5 0000 0010 1100 1001 &cp2
+    CVM_MT_SHA3_XORDAT10                 010010 00101 rt:5 0000 0010 1100 1010 &cp2
+    CVM_MT_SHA3_XORDAT11                 010010 00101 rt:5 0000 0010 1100 1011 &cp2
+    CVM_MT_SHA3_XORDAT12                 010010 00101 rt:5 0000 0010 1100 1100 &cp2
+    CVM_MT_SHA3_XORDAT13                 010010 00101 rt:5 0000 0010 1100 1101 &cp2
+    CVM_MT_SHA3_XORDAT14                 010010 00101 rt:5 0000 0010 1100 1110 &cp2
+    CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
+    CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
+    CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
+    CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
     CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
   CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ce4cfcb3f30..5497e5a6cec 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -47,6 +47,11 @@
 #define CP2_MT_HELPER(NAME, SUFFIX) \
     TRANS(NAME, trans_octeon_cp2_mt_helper, \
           gen_helper_octeon_cp2_mt_ ## SUFFIX)
+#define CP2_MT_HELPER_ENV(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mt_helper_env, \
+          gen_helper_octeon_cp2_mt_ ## SUFFIX)
+#define CP2_MT_XOR_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_xor_i64, OCTEON_CRYPTO_OFFSET(FIELD))
 
 #define OCTEON_LO32_OFFSET (HOST_BIG_ENDIAN ? 4 : 0)
 
@@ -165,6 +170,19 @@ static bool trans_octeon_cp2_mt_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_xor_i64(DisasContext *ctx, arg_cp2 *a,
+                                        int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_ld_i64(old, tcg_env, offset);
+    tcg_gen_xor_i64(old, old, value);
+    tcg_gen_st_i64(old, tcg_env, offset);
+    return true;
+}
+
 static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
                                        void (*gen_helper)(TCGv_env, TCGv_i64))
 {
@@ -175,6 +193,13 @@ static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_helper_env(DisasContext *ctx, arg_cp2 *a,
+                                           void (*gen_helper)(TCGv_env))
+{
+    gen_helper(tcg_env);
+    return true;
+}
+
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
@@ -212,10 +237,35 @@ CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_I64(CVM_MF_SHA3_DAT24, sha3_dat24);
 CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
 CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
 CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
 CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+CP2_MF_I64(CVM_MF_HSH_DATW0, hsh_dat[0]);
+CP2_MF_I64(CVM_MF_HSH_DATW1, hsh_dat[1]);
+CP2_MF_I64(CVM_MF_HSH_DATW2, hsh_dat[2]);
+CP2_MF_I64(CVM_MF_HSH_DATW3, hsh_dat[3]);
+CP2_MF_I64(CVM_MF_HSH_DATW4, hsh_dat[4]);
+CP2_MF_I64(CVM_MF_HSH_DATW5, hsh_dat[5]);
+CP2_MF_I64(CVM_MF_HSH_DATW6, hsh_dat[6]);
+CP2_MF_I64(CVM_MF_HSH_DATW7, hsh_dat[7]);
+CP2_MF_I64(CVM_MF_HSH_DATW8, hsh_dat[8]);
+CP2_MF_I64(CVM_MF_HSH_DATW9, hsh_dat[9]);
+CP2_MF_I64(CVM_MF_HSH_DATW10, hsh_dat[10]);
+CP2_MF_I64(CVM_MF_HSH_DATW11, hsh_dat[11]);
+CP2_MF_I64(CVM_MF_HSH_DATW12, hsh_dat[12]);
+CP2_MF_I64(CVM_MF_HSH_DATW13, hsh_dat[13]);
+CP2_MF_I64(CVM_MF_HSH_DATW14, hsh_dat[14]);
+CP2_MF_I64(CVM_MF_HSH_DATW15, hsh_dat[15]);
+CP2_MF_I64(CVM_MF_HSH_IVW0, hsh_iv[0]);
+CP2_MF_I64(CVM_MF_HSH_IVW1, hsh_iv[1]);
+CP2_MF_I64(CVM_MF_HSH_IVW2, hsh_iv[2]);
+CP2_MF_I64(CVM_MF_HSH_IVW3, hsh_iv[3]);
+CP2_MF_I64(CVM_MF_HSH_IVW4, hsh_iv[4]);
+CP2_MF_I64(CVM_MF_HSH_IVW5, hsh_iv[5]);
+CP2_MF_I64(CVM_MF_HSH_IVW6, hsh_iv[6]);
+CP2_MF_I64(CVM_MF_HSH_IVW7, hsh_iv[7]);
 
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT0, hsh_dat, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT1, hsh_dat, 1);
@@ -254,11 +304,13 @@ CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
 CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
 CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_XOR_I64(CVM_MT_GFM_XOR0, gfm_resinp[0]);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
 CP2_MT_HELPER(CVM_MT_CRC_POLYNOMIAL_REFLECT, crc_write_polynomial_reflect);
+
 CP2_MT_HELPER(CVM_MT_CRC_IV_REFLECT, crc_write_iv_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_BYTE, crc_write_byte);
 CP2_MT_HELPER(CVM_MT_CRC_HALF, crc_write_half);
@@ -272,6 +324,56 @@ CP2_MT_HELPER(CVM_MT_CRC_DWORD_REFLECT, crc_write_dword_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_VAR_REFLECT, crc_write_var_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+CP2_MT_I64(CVM_MT_SHA3_DAT24, sha3_dat24);
+CP2_MT_I64(CVM_MT_SHA3_DAT15, hsh_dat[15]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT0, sha3_dat[0]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT1, sha3_dat[1]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT2, sha3_dat[2]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT3, sha3_dat[3]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT4, sha3_dat[4]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT5, sha3_dat[5]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT6, sha3_dat[6]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT7, sha3_dat[7]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT8, sha3_dat[8]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT9, sha3_dat[9]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT10, sha3_dat[10]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT11, sha3_dat[11]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT12, sha3_dat[12]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT13, sha3_dat[13]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT14, sha3_dat[14]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT15, sha3_dat[15]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT16, sha3_dat[16]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT17, sha3_dat[17]);
+CP2_MT_HELPER_ENV(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
+CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
+CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);
+CP2_MT_I64(CVM_MT_HSH_DATW2, hsh_dat[2]);
+CP2_MT_I64(CVM_MT_HSH_DATW3, hsh_dat[3]);
+CP2_MT_I64(CVM_MT_HSH_DATW4, hsh_dat[4]);
+CP2_MT_I64(CVM_MT_HSH_DATW5, hsh_dat[5]);
+CP2_MT_I64(CVM_MT_HSH_DATW6, hsh_dat[6]);
+CP2_MT_I64(CVM_MT_HSH_DATW7, hsh_dat[7]);
+CP2_MT_I64(CVM_MT_HSH_DATW8, hsh_dat[8]);
+CP2_MT_I64(CVM_MT_HSH_DATW9, hsh_dat[9]);
+CP2_MT_I64(CVM_MT_HSH_DATW10, hsh_dat[10]);
+CP2_MT_I64(CVM_MT_HSH_DATW11, hsh_dat[11]);
+CP2_MT_I64(CVM_MT_HSH_DATW12, hsh_dat[12]);
+CP2_MT_I64(CVM_MT_HSH_DATW13, hsh_dat[13]);
+CP2_MT_I64(CVM_MT_HSH_DATW14, hsh_dat[14]);
+CP2_MT_I64(CVM_MT_HSH_DATW15, hsh_dat[15]);
+CP2_MT_I64(CVM_MT_HSH_IVW0, hsh_iv[0]);
+CP2_MT_I64(CVM_MT_HSH_IVW1, hsh_iv[1]);
+CP2_MT_I64(CVM_MT_HSH_IVW2, hsh_iv[2]);
+CP2_MT_I64(CVM_MT_HSH_IVW3, hsh_iv[3]);
+CP2_MT_I64(CVM_MT_HSH_IVW4, hsh_iv[4]);
+CP2_MT_I64(CVM_MT_HSH_IVW5, hsh_iv[5]);
+CP2_MT_I64(CVM_MT_HSH_IVW6, hsh_iv[6]);
+CP2_MT_I64(CVM_MT_HSH_IVW7, hsh_iv[7]);
+CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
-- 
2.53.0


