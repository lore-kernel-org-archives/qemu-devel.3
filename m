Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CB606A33C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dJorhETD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ilnQVXde
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLms6-0000RF-PH; Tue, 27 Oct 2026 15:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLms0-0008Qb-9h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmry-0002YR-Bh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHVkx1917309
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2RLoKFsF5KTr7y+MMw+BrLv5fkcYSr8YBUTMTlQcnFY=; b=dJorhETDuW5ncED5
 vejDmjjOsgrhj5EG3aeiSz6D+M9LOa2ruIzoLlwWv4Dzg3niB2sXWyP//45S/OBN
 DbTCGOGgk3+RD8VZC0hUevAspwLmtddwiccGcxSImbfWgc+69AstXlnpqnV5z+aj
 gbGTJoyQZFXaZp+0qdNrc9beWh4RH/dEvZXdUhVHLaEkN7+W5zEInTd23WzQB9O7
 jHCFixiegfRpVSarYZLVeiDsPe9fIPMfLLVznhg6OZ9K0mSnjCmvF9QVGRzbB+Tn
 T+0BxOUQpKvM8+Zsr8brML/noszdB+JdhynoIA9DQFGj6ckdayJjPU4EjuX1qpuz
 lQ6xfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99vdb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so40449085a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129401; x=1793734201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2RLoKFsF5KTr7y+MMw+BrLv5fkcYSr8YBUTMTlQcnFY=;
 b=ilnQVXdeuo4lywhozAkOkB57PU4M7YKifqHrKtE03MHsHHJo8cB1U2f0SSVUP9vCSV
 l72vI0Z+9mYk1zcaj3WyBPib/4se7O7N0zx7vpoRD+71/qrWZXF3/3xLnC95xmiWLOrd
 FLMhBe0BQKQk4PaAhZ7ec+VD765wWk2ALwA45eI/fKgsr6H2r8gWCpQ9Q7X5oRJHgDZi
 8Aw1Og1gXzubLBAMVR7fL60Sx/CIk/SaArxePtH/MQ/eyz1uCaspKixsWjc/qusiHTAo
 tvG6ZweOIvIGSYcuHrBQgeYdzRieEz5JX2IUf5ASdU7QONN1YeZZGuWX3QtdcCDVYskJ
 aa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129401; x=1793734201;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2RLoKFsF5KTr7y+MMw+BrLv5fkcYSr8YBUTMTlQcnFY=;
 b=GvGGISz/4o+J+py5A7PdjllzpeDC3bjMmptoJ8pvcUeOdZe/8IfAghKjEuSmprf/ym
 K64fmHonddCjPiRb6fleYprAa80X96S5Ax13g9qUwX1BaacqudFtefAq8VkzelK0ILkn
 n87daA7K6xI+QebCiE01ZJUUiCLLoqUTvgYIjWe2y6gx9Lrh4xMo+lrLy8ezmUooMEIj
 opQjIorFpumdBIW7FqsRi8PeY1AFuXCGSMjFSI9i2HZ2aorHxAmzHudbBbkENDw3oIZM
 9ClnKwxNFLpmw0B7lN/3r5SsEtthu4RJOjayRk9QK4IeefijhFDlILZ1kpqnSjuzY3uO
 1Qlg==
X-Gm-Message-State: AFq9FYJ1jLTD9Y/4TTMNcd+lQK4Jufy6EXiJrWRm/t4R+eNKPwm/MPLs
 LDWyG+ntMQ8U1ZPuCi/r1Ac1BUyIGW4w5D8j2f0WRqdncwvxKvlUzbZd7tlzQLWR/JmKAqlgam8
 k6sr0cXwYE1H74aFtim9cDOypbuqa6kCN6KIGoknccs6fubNqDPIUS7rng+3jqRv2qg==
X-Gm-Gg: AYBFou2Wbf+7lThK1Upj2IbrNhBzPucxnFxn05+aroullujmMCjVfu5sVkzN0fFgqfl
 t+w1ek52a8p1iOzjQKZcGJk/EoWyVa7dj7EWK1jzA06cRPILJmbKQUFN5/q4fkMlGhT4eqrBoeK
 tAoaDaKI2b2jhidjZ6yMyrDfdzoUtcUGusLcIYTNorncc9Jn3Oa1Uj+Rm2/ljoi32BNvXVeqpjr
 FWgNvjmAIXpF0Booi8gbKfa3D/TW3pNM2ZBwmFbjtp47yux01HZHfRZqDrP0PJF6U/acogWJ/BA
 Xdlw1/VP8wcfpryeanTgX2BlyJCYnplKlVYJunu38XfyO4XewVznoNKa4DKzftVyJmcd9BHKIr4
 4+Vj8P0WOMyJ0J0zUyyK81YTvxsy67BGMvKVvjXUTfONJEaLTcjSbQ3p4
X-Received: by 2002:a05:620a:2690:b0:93f:2479:2b4 with SMTP id
 af79cd13be357-943f4b4189bmr587017685a.10.1793129400582; 
 Tue, 27 Oct 2026 12:30:00 -0700 (PDT)
X-Received: by 2002:a05:620a:2690:b0:93f:2479:2b4 with SMTP id
 af79cd13be357-943f4b4189bmr587012685a.10.1793129399993; 
 Tue, 27 Oct 2026 12:29:59 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm25042081f8f.38.2026.10.27.12.29.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/59] hw/misc/allwinner-h3-dramc: Avoid shift by negative
 amount
Date: Tue, 27 Oct 2026 20:23:36 +0100
Message-ID: <20261027192341.9197-56-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0fbb9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=fgD2yzb7X4CZDJEX5icA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Gk2qLQ5j39l_DPrbwBhfpopEMaca6yHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1IkbvMKQ5jO0
 1EejLlpxaGhLgO0bx+L3+ySaqyZHHHP0ZGU646q90jeZOQF3Fo0Vgy/CDVjQeRJ8O80SQWa1j8v
 ndZeUrV5O6wM6gC/yyTrix9MilezOeTEBJtxuaAa7GAfUA3NmDWnrBN/CdGGTr9fCb7O9BbNZJf
 b8z8Gisf/Tm7FzSe1fSQGSBNVx/3HPZX7tzYSrfjSgQQ0kgeFoEg9CabHe5egi5DsVA453oMX6k
 eaWg+l1ANVaw39FNjD1vL4MUYqRcJsguyU+4rKiKr6C2/qHYEgRRFFwyBl3fXkKxB0Z3pK6lKs4
 1HkirNpoECFUDHaR9iEpRnSKi9gt7lPEDEYAeG/o2bmxLGBlTUmq68oStL6dhc/VrDViYkHxX6X
 z5fZA6RZCiNRMXfjtj1+rp76FXDQ68oHNNHrttu95VEejfWozmaRFigzbEUI4kHhw8jc88LUXUC
 4EARkgwrdwZ+LNYSd0w==
X-Proofpoint-GUID: Gk2qLQ5j39l_DPrbwBhfpopEMaca6yHs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX8VmbEHzkAG2/
 Z45oxONhELfAbNfaTHOHzoQlHfbJClU1PRbCKT5oZEK6HjnA+CueG3JI0KPILBSfGjj9inZwoJf
 IqhgiIx9XXqJUN9+gxxjfKJwZ4IJuH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In allwinner_h3_dramc_map_rows(), we take a row_bits count from a
register, and calculate (1 << (row_bits - 3)).  If the guest programs
row_bits to less than 3 then this is undefined behaviour.

Treat overly small row_bits values as "doesn't match actual RAM
size".

Fixes: b71d0385e97e ("hw/arm/allwinner-h3: add SDRAM controller device")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4210
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-ID: <20261023153150.1710372-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/allwinner-h3-dramc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 10d929a3039b..2a4b33aa1826 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -78,7 +78,7 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
         }
     }
 
-    if (s->ram_size == (1 << (row_bits - 3))) {
+    if (row_bits >= 3 && s->ram_size == (1 << (row_bits - 3))) {
         /* When row bits is the expected value, remove the mirror */
         memory_region_set_enabled(&s->row_mirror_alias, false);
         trace_allwinner_h3_dramc_rowmirror_disable();
-- 
2.55.0


