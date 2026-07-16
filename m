Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD9C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLKU-0003UM-VF; Thu, 16 Jul 2026 08:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKT-0003SQ-Cb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKR-0007A6-O6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBitaS2730880
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dPPGQjovsqg
 pjPBK0Rf/v7XTwgXHKuSKILoSOOXro+A=; b=B3FaverrMXDEmjbHk4MOUkPT6Mu
 xHzigXtJbVQjyAkkPUVeCnVjEKtAScY9wXb5aO6aMOMjb2VrPV6W8BI26TWhYita
 GacelI2oC7sR+kHsKTCJoUEmoqNqgUPqtq2c6brWeH8+D9uGfanh8Fn3MQ71IOtS
 Bml6Rs+rSpk4hYp3T/meuoEyUM67Arz32XqnV0DawChKGuM+BRfwP0eaj6jUaUHU
 segOB8WMCbl5c5nUa7STABE/5FDj1KPLEwg9VIUMpruBXsb7Umrhz7NKtZSk7P0q
 FIwiqZggbsCDU4bTmrRZgpRju5Q7wEUew+dHQ6kjzy3MMC98+mS7khMlkgA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4wadve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so87360976d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205387; x=1784810187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dPPGQjovsqgpjPBK0Rf/v7XTwgXHKuSKILoSOOXro+A=;
 b=YHya3NQQhs+97LPQwcltMABOAoTv8Gat9hAZitmMjAyYUydwRfGUY6u/1beI4NRi51
 bdcMge/t9Sc8EYUbH/3WvEP2ENGaLe9wKtwRiauL0xMQivWxE8XgI410yON7upLZwkP0
 o1zhS2h20GTCvvJpQNcBfekYHw0HdDGYhERRrNMkSuprAgyTTv5ANsCZs8slo5y0aa71
 OkeuAiaz9QF9036lFuC/yAQVkYqecNDvJSZ/I7oOJAKK8ayfUgJ8hbK2e+QBZy0Jm3NS
 SL5W/AvsRS5XOdRz2KnCXBYXyVY/hTdRnlJ3LVfUuzDYAFmjyzMockSYOEuNVY4dS9pL
 ZALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205387; x=1784810187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dPPGQjovsqgpjPBK0Rf/v7XTwgXHKuSKILoSOOXro+A=;
 b=KKlFjdmhS1PeTF/Z10Srt0JYQvQRReFzakaxTly5rPuCkuHvjT3SEAxFIyZY8R5ZsR
 2bYeZ9KnziNwfXlkkdDvWjqDfSV73bd0jcUVvu2a8AwT7XT4TZzyhTWUTf3cdwgCBTnW
 2WcmN/zbwk9SqCEcBI/UTJteRjZttP8flY8kRVyvd9y+YnO6n7lp9awxifysVb5ZLNDo
 iN5JjxAXOOk7KfHQYJAq3VwCZlFcZJYgwCIIi8jUvurG1anE9sJ56CCC1rw0UkhoULq0
 ZLTwa87JxID9g1iAxmagshK7w3SiwbM+p4AZqLFjXJ6hSBQgeKEyui75mnWyTrH/e/9o
 lLvg==
X-Gm-Message-State: AOJu0YzKVOzVF9HbyaErTqlc88w++ZjcoNYH3pH+doFWwz4jZE4ikb22
 87XEKw6vFIVrGKg8pXeil3pmx2wwTRP2q0fRUozPZzLRLZRMdsG4Qk4t+JvsyHpQWGpp0dlXTvX
 D20g02KWoZepg7E4uSLWLOkY1e5hsb1wmIqOE/+2IF7Qn1rA/huJ4lwMVxICo5l55dQ==
X-Gm-Gg: AfdE7cm7o1NIrrg4+2keA4rhxjTLvp6In4VK7bWS2g1uVmzG2dQnzv6crjujRVDX8U3
 wS+C5XnOhVx4Tf8yVuIbArUVhYD+cbHnsB9tKIOVJwFWfN7wCYIUQuRQuXw1dLSB/xUsDMO9azJ
 xJdBO2xZ0i99Q5+GR0CkL0W8vG8QkTCkUnF44wRyoKvbrNWaM1P3eqhJOTwDgVrLphLgcgBjsjY
 MQyEiB/1/fOmixVHYdU346ow4zgcoE/HRGDs6AsVL8UTKYtvVp2EXLIVSMRpKxDAjm6HwnpCZqP
 P9REZowYaefylmhOQihD6YIPN/rMEEP5UAKU7vuHiTZjHSIF8oTp34fXuDYa3by1Pd0BzTactwO
 CxjiUuBasWQM5l0YzX2EZBoH1i/tKe876sOM=
X-Received: by 2002:ad4:5fcf:0:b0:8f0:12e8:f453 with SMTP id
 6a1803df08f44-9074c814f62mr112472196d6.33.1784205387353; 
 Thu, 16 Jul 2026 05:36:27 -0700 (PDT)
X-Received: by 2002:ad4:5fcf:0:b0:8f0:12e8:f453 with SMTP id
 6a1803df08f44-9074c814f62mr112471746d6.33.1784205386876; 
 Thu, 16 Jul 2026 05:36:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:26 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 17/17] target/riscv/debug: Fix minor comment typos
Date: Thu, 16 Jul 2026 09:35:34 -0300
Message-ID: <20260716123535.3709148-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a58d04c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=oPyd9XVBMgBqf3_3PDkA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: jrnYinhynDV_6VdRi6opUCv3O68KYd1W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX0vn3G2++rw+w
 BIopLYfR1WXLK0UMqq93g3DKpxY7nquo5xgL6Q5euZHoX/8d6tsCB2sLVyTWkw624HXX8tJXUAT
 ljndvtIeKedAZxMxG+GrZoHz3cIx2Zw=
X-Proofpoint-ORIG-GUID: jrnYinhynDV_6VdRi6opUCv3O68KYd1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXw01fFgvcVOde
 GXteW0SQXUORr7XsOHeh47N/xqLZ79A4YTgA3R5Jx7HwNAPQ6q9GrFhY1nmJCHFGwiNsF7NDRN7
 76YdHZmt5v825FBc2UGhfIdYTAvKd92lPUNfVOMJ6kGt0dGnWHA+T91WrzMOu00jNQCuRSkee+L
 tiY1XsPDeKPRc3kD1De6dlu6KtY9SC1pgBE1/rhEL1VqF88HP36tJ8fXtwYXaqozkCLJYtqA8zN
 sfvd/P5U/Rc7fHwnwiUO8dC4zPDyLMR4VhpeI3Kv9zA3Rxn+0GJTrtihs/YSBWIj1c4BVq/NOCy
 N9+pwwLM8JF/U8r+bmobmBzgZIbnCKz/pT+cxlO5vp/5K0poBBuKZYWlqiz7seLVG+M1a7NSKQF
 1d0X9S5PfmqbboVzzrULgpffKs4qzyX8oi+vuVG1lYtW+0qbCZg1r5L3MKOTNOgTePucfzwEg91
 UoJk+OyKgblT1qBUVOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Fixes: a42bd00166 ("target/riscv: debug: Determine the trigger type from tdata1.type")
Fixes: d1c111411e ("target/riscv: debug: Create common trigger actions function")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 50e5a85caf..27c2e0da25 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -122,7 +122,7 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         break;
     case TRIGGER_TYPE_NO_EXIST:
     case TRIGGER_TYPE_UNAVAIL:
-        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\n",
                       trigger_type);
         break;
     default:
@@ -944,7 +944,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
-        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\n",
                       trigger_type);
         break;
     default:
-- 
2.43.0


