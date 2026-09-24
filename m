Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC08C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lJV-0001mi-Gn; Thu, 24 Sep 2026 11:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJR-0001lr-0g
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJO-0000Df-4O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OF8jGb2032256
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dQILwiHqWZbRwJUdacbj8UhPl0PEK7itNZ24Grwywxo=; b=k7G65o9747OqAMxw
 /oqKfG1J7ZIm/5FTVsrUP4eXdBziooKpWA0sREgsdsP045KKAeDr7dp6FrixmIop
 XQ9o+vKfD2SPsjo0ptp0zmUbs1ZNWDgcniYXCJ0L7O7n5RIM6/W7EJ+ggP9PjsHS
 Q6L5HcXToTwUHnV3/WDBAAYnmpktGRBu7vFEgKAYrrlVo2u/NIAiCDM/SkzOP6Qs
 WT5iseYwuNJEV35p68UB1Wl+Zz+h6pe7Ie7vhCvMoG8sLWdwT9fOAFxQ6K9tGsWJ
 G+dM1XLQhWwpkO9Z5vAax1axxHGKwaWtKl+sidyssvQWCcGvUeL6sEmBOE6yMWUQ
 /bcSRA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e03jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:28 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e9e1dd7fbso1708299241.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263468; x=1790868268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQILwiHqWZbRwJUdacbj8UhPl0PEK7itNZ24Grwywxo=;
 b=AA2NZpawpFb5bs53EndtGAYT71PFVlon/dmkaFkMH48pnJ023DhwUcZCKpoQbWPs8r
 AF0xVjE9+11p49oNK87eiAKxyA0SL6q7enl7hBU+Xp1xCoSnAbWSqbhldHQsyB8Aqq1K
 5m0rUvpcDZKN4rKj5MuUIPpv+0KOeA5Qv6pDwvWMOYssJk7jSQbzSK86liKvRL45UmmK
 GWfKeICUIsEwL1euDpGp3OyvUg5n0f5f11q+oyqBj23RJLJzwv8+hQpkjUr643nIR1pb
 cvbYL06QN4v8Jw/iGpJRe1EOfGemP8PoIhiQ5zyNZFynRShOpbo2fOrMwGFalXEJb14g
 /m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263468; x=1790868268;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQILwiHqWZbRwJUdacbj8UhPl0PEK7itNZ24Grwywxo=;
 b=RyaN+UT0OFP6qryfRRSmea7J4SWByfNEKJC3ge0uUf6KStDmueP7ny0KTFewAz5zbC
 WwgMVJPXvVzyJx6gUNJSEphqKJc42CQSQOuYniT7JEwNOWyh6VKLqlmUEMBZMxhssliM
 jqgRsgO2DM+EQlZSlNuD0sYFY5NEnJxJXC1s7f4r9HrkmV6xmLfupL1BsEWdjKdNPLe/
 JxYi1K4iNz8TRtJ40E4ZJpCf8HjHDUm1epH2Jc3B7zE661LNZaSsVoRBAYDFIHrfEECx
 z7kIKpCXLhe/7gaCp4IY7ZFenduL6v9/UFUx6oFPGMWQqsc7ySeOG/fF2LIIZxMCQCrD
 ARWg==
X-Gm-Message-State: AFuF++nrYXUT5Cycu+KduovcUG1qYOwP4WJ6+v/chuD6MjgW7NIBUvwR
 saubBEDYo/qcZxM+OUFD1xFTJXuAL7WVbf/86yvT9JC3cwjjLH2dasc1Drg9vQYyXDbP+iqB7rE
 LaHdJcuBEP2T0gMC1fxJ6t3QHj4EDzgN6WEJEYf3VIWZt2vVSuP4NAjYg7T0+9AoEaA==
X-Gm-Gg: AYBFou1LXzbq9HAqD2BWwJDOQx2Vex4nLu4kDD/BTeZ5mx7B8+rWz0EgtybVPlXSGv1
 5hN87xU5oNckNqJ5SwI1pE63tc5P578X9eYS+4KFKzRK+iPqJrq/9xYZOkuAz1HtAipXhfnesT0
 UyME4uv8bLUlnQVPVsDmyoeQh9+z4u2kQuOKMiBV8rKLyCDIqnXRyGHmiomqpIZ//k/yCg1t36K
 IyZ3m4uSUW5AXFtgVTVh0Z/nBKwnnaMZ35ObIofm1/xVOz4eiK0l89q48rzHAotf7x1Cem9Yb3v
 EcD2VfH9UNq7NafuNbuldwk1xeCkLlNtzf9eP2DVYhwKn/ezS0Agbjhg70WwFbltAaOY+et218C
 mb4zZkYvHzJ4atYqNlQsTc3wLndgaEjkV2pjB0ZRd
X-Received: by 2002:a05:6102:3ec5:b0:7a7:198a:c2bd with SMTP id
 ada2fe7eead31-7af1e2f54d4mr1588193137.37.1790263467793; 
 Thu, 24 Sep 2026 08:24:27 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec5:b0:7a7:198a:c2bd with SMTP id
 ada2fe7eead31-7af1e2f54d4mr1588175137.37.1790263467052; 
 Thu, 24 Sep 2026 08:24:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c4054fsm119172245e9.3.2026.09.24.08.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:24:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] target/mips: Fix zero in gen_mxu_d8sum
Date: Thu, 24 Sep 2026 17:23:36 +0200
Message-ID: <20260924152353.36209-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX3w2q56GaNn0p
 AsKcIoqUAA8O/m0SOGag+jthEccMUIVTdQ14x2IOSmhT8fXtdcVW57ZR/679TS+4ulUPsEJ3zwQ
 Yr2ar6ZVvWddoc0Yi6I0eNVevfoXArYAnh9boI1zEuqinn7k9qnlMFSA1fhfCJVIvc2vW2KVq2Z
 njPebErIz0nMFPSyqd6CpN1JBNJm+n1LYxe7gKTJmfMauwY0LUd4Ra6yqS813v3Qh/5PB477e1D
 TrEGgzsn3OSoBJeDqsX3i+WaR2MfPYkev6Er5/InNUjXc554DH8I/mdSdIRE4ecbs1BOm8V+Slu
 yqxKarOZka7lIqynEdgadO9aF2l2Yb87z+QFEePNeMtPof2Yz5RH4ha1Ofy4Q1buLqq7LQk0Kjk
 txXJ4VFjshFGOGAllEYDtbc5vfr3cwK0FjP+4I0IeL9SINxIl/3FCc/LDswBaIKCrSaTNHtao2l
 BeJ45BZhV62GsNBX2rA==
X-Proofpoint-GUID: ornAAjSi6I2FSS-R8no88e9bp_CS3xhy
X-Proofpoint-ORIG-GUID: ornAAjSi6I2FSS-R8no88e9bp_CS3xhy
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab540ac cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UbgK6sZ85PiArCHPYcEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX6SDwsLmP2iJd
 hlUse6duxEOmMYmT3TkfPsqBDy+NkoCq3Ilou9Z+/HV50THoYhkHqXKHq5Ty/1K34atuZnxxxGJ
 dQvbWeXBXBVqqg5xM0QniLCPnXwbltI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

This is obviously an attempt to set temps to 0,
but accidentally passed NULL to a regular move.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914230901.1781309-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 7961b073144..9559b8aada3 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -3109,7 +3109,7 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
             tcg_gen_add_i32(t4, t4, t2);
             tcg_gen_add_i32(t4, t4, t3);
         } else {
-            tcg_gen_mov_i32(t4, 0);
+            tcg_gen_movi_i32(t4, 0);
         }
         if (XRc != 0) {
             tcg_gen_extract_i32(t0, mxu_gpr[XRc - 1],  0, 8);
@@ -3120,7 +3120,7 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
             tcg_gen_add_i32(t5, t5, t2);
             tcg_gen_add_i32(t5, t5, t3);
         } else {
-            tcg_gen_mov_i32(t5, 0);
+            tcg_gen_movi_i32(t5, 0);
         }
 
         if (sumc) {
-- 
2.53.0


