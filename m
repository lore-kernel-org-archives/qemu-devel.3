Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CDC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLK7-0002pA-O8; Thu, 16 Jul 2026 08:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLK5-0002ov-Mb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLK4-00076Q-4p
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiaA42475287
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oWst/VlSzeH
 r78zJf/0h46yr/Sd81639ox7uwOej8hA=; b=kTYHKCzh1W2v5iFacA02CUouU7m
 r9AWEDB4mZJbh+iDmZC9tKH1Fk4FljbAVVVJfJ1cZq8mQ/FeiEG+zjei4TwqqJXB
 PIB6lf2X+3LxG0tXEc7xBMc/5ddP4WGuxfJbOPaKr5g3S5dKSL08BLFd7HYEpGsj
 R7fWjQeCa7gkWit3/hky2rAQdgxxwv+kK92+W6bNSg4fJ6H4kFJvaayI+k3mdMOs
 5pSwUvo1QNewb19J7iw52DEknh6FGincPt/JWhKeX4i9lB5LzO4XAezLnAgWDZR0
 jxB/AWIJlbJiIIIVu/P1yZ9OOLVragL5s+F3wmgV2lNfQOP/wBs6GzivaRA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7scet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso136531956d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205364; x=1784810164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oWst/VlSzeHr78zJf/0h46yr/Sd81639ox7uwOej8hA=;
 b=Icw+8VxntFcBDjgQ2xaYHUy18LPzXjTjWgYr2LYPdxiyDcLqpX6/prb+geFeSNXPJ/
 +Qegq2KYYGAYKVAnPevtSTrePWXvVtb1WSQZF8V6llqhLcKJRR1nAY+J/eaqUorffes+
 UGo7xdxbeKzSnH6elNjEgUjBBobn1gwO+WU2DJGzM5gyNUkafAmfHu+SWlDp8vtXr7HD
 ekzgYcLw3SCvrDJ6tHhS1Si3lvLh7/5n+pDzrxpNzndsm0TplDqi27t0f+GN4udohAKS
 Xl6vmWRJN381mBBLC4agcSgNgxxfn+a/WsrKeEsjCStMMm+qp0U0/tvMB/VoPeoBTx0A
 p2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205364; x=1784810164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oWst/VlSzeHr78zJf/0h46yr/Sd81639ox7uwOej8hA=;
 b=CLPLT0GvpiLp627PbM3wB1LOhbVc2WGIFgyw/BoI4Ln/R+4UzcZDVPqDBQaZxVsFDw
 UJyrkLWuqyr8L1b48p72lMv5VZ3nLlNVX2CuC7h1kZDDUx7vtr6wbYQktbIBf9CTyr5G
 rw+CF+GVktfQOIypBq0vMAFf8HHrBzbQn0dReyihdJp4QOopYBSxyEscqjjcwv10X0Yr
 KnNGod7WfUcX0njb3NiIBBo2Ayt3NHbEp54QCOtNFUEl6D1HwZDIxs1gFBewCgVcq/uf
 nQG+Mznu875Ux8x89tWldOe0UF+V2VhZEiLbkzcn5LmmTHNeUkWch4mNC7d1OAdajf1H
 tIUQ==
X-Gm-Message-State: AOJu0YyVyqEpiX5p4S7TpBOUzy+fh+RXguWm9TLXmXABOKi53iyoa8a5
 dMeCrFcL9nxY+GxHyd95ejChQJ4cZ4NFMLo4OARlaqwtIxEevAM+TZaAIppkh9Kb3Yvajv+g6MN
 W1/+sOMWwzHXcnTvF3DdshJZE7MBVElB5npKR7ycLDUYjW+1FWTdlQf+V3jeyjXWp+g==
X-Gm-Gg: AfdE7clc/ScnLHAwshELZ8thDATm4Y5Aa7KKG8zoOeoJ7MOoPY5lpHihp6IB2MQwTOM
 vK2FZaFRvwwc/oySQpBPkSUHjmksM9CsrM53Ob8mTfrTB1FwOQSpO0EpL2+4OWYUiL2QMi5kd49
 0IKu1x69G4jp+T48lCt3RkASlXgwurx0HZoLgsB7EkECjgAdI9oxpt1GaHy3M05dgZNY9nKD/BF
 PKfuM3SjWu3gaQY8g3d6wVoYC94IngHnriKpy6js0JnBOxz+4BC9OTzCdJ7Ccty2p9SKTFmomjF
 VSrVul8vGp8j21ZXXP360o1eXc+mUyHwMqzA3ftW36NEsglA4rWV3egCYx/TUoMkbVsuSxN7wmz
 guUWEOio/+StPtveJMo4ZEXp9nRIcQWtAoVs=
X-Received: by 2002:a05:6214:3d88:b0:8f3:9d85:405b with SMTP id
 6a1803df08f44-90758ceb518mr84580956d6.16.1784205363716; 
 Thu, 16 Jul 2026 05:36:03 -0700 (PDT)
X-Received: by 2002:a05:6214:3d88:b0:8f3:9d85:405b with SMTP id
 6a1803df08f44-90758ceb518mr84580406d6.16.1784205363212; 
 Thu, 16 Jul 2026 05:36:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:02 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 08/17] target/riscv/debug: Implement icount trigger
 textra matching
Date: Thu, 16 Jul 2026 09:35:25 -0300
Message-ID: <20260716123535.3709148-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX8Tn2lWPRtw33
 3LZV9SqUXHDDl7bFTHqMsoCchpLDWYBijWKEHJuNvGwjDHY/4xO1P+DQtcCsE4mZJHjnGPn6sQd
 8FzA0odZqFbwHCFcgrJeTWdesyabjZ4=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58d034 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=8BcSXCmn-LG7ayDxeBYA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX3swrVOE2pIQX
 B+gks+7KmyDsKyW6HDNmpWWaxn9h2ITOsx0yvANrrc2aGICpR1tJQ6yRsd+WuTQyLeehLVYDfpl
 yXjxqJkoWptuni6Rxc1RNxMpZQCnyjm7jsj2uxXYX//KDx9KnijoT0i7J84X8ba3UExwLQ7V/UB
 KSUpkdQHl3R6iM6LwBmGv9hFIuEKU6FZHjLPxXAG0WrBTrjx1N37jqyIHf/mWO0xh3M19pdepwC
 2bJSGBqtOc5ocduH+CFRDChsinwcxV1DuyzV7KnaMO3QEqtbkKPXwNJ5PlcIIsqN38ePpqtRyDL
 bRse4LG9fvU2LUMOgQUhRol6IBCYNakzUvJtY+LRKeR2IOPdc7z12xOa0ZwX7HeFHhHBgO3yrqn
 P5/3+HpLAiLasYEEkVXXdqVHO+qrR1tHFaF4IWpVK0Oy7MexOvAaqXBUnnF5M5c7TKJse+DLIiH
 5JSy2OEKFcYgzBY9oaA==
X-Proofpoint-ORIG-GUID: QlfPq5futiTrPDtMYx6CVaFaf8Y1TSsx
X-Proofpoint-GUID: QlfPq5futiTrPDtMYx6CVaFaf8Y1TSsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

icount triggers are subject to textra checks, per spec.

Fixes: 2c9d747121 ("target/riscv: Add itrigger support when icount is not enabled")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3edbb591ca..74f1739697 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -677,11 +677,12 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
+
     for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (!check_itrigger_priv(env, i)) {
+        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
             continue;
         }
         count = itrigger_get_count(env, i);
-- 
2.43.0


