Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5D6C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyb-0002KM-Kf; Tue, 01 Sep 2026 16:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyY-0002Ie-P7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyX-0003VJ-9h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgMjj3228308
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+fFw5NSa5Jr
 y1A3ONE01He2NOx9PK8QCb8F7sLo12sY=; b=N0TOCsXhzJWs1m7qgTPpOxKBOR+
 JUJ+8ImcPqT/18OIUPUPeHn1d0Vy/cJ4E6SGJPQ5k8JkTXIcI4+v6r+EJCb9ggyd
 XIPbuon6PXoUj8JhNLDWUa6TwHZNNi9mDaYs+34oOKhL+M+F/yKQS4TfMMQrqjUL
 FR6gUXtv9r71cEvCWPayiIX6imgwK/OSBwZQ+F+Jt3IrX9ZZdizfveQDNDpWq3Hu
 Rm0FF+UVTZPeJ6RDi0SzQLYNqKdF1zSUrHd5TddjGwHSrEgb+YPjCtnE8LqoA1sk
 0i48ilEF+lQA0+BVo8p6dURId1bwA2stSnYTpwBES20VJDb9oWeVU2sY3Cw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdvmm2su7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso279579a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294055; x=1788898855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fFw5NSa5Jry1A3ONE01He2NOx9PK8QCb8F7sLo12sY=;
 b=Raa5yklJISoczhDpDMM01qPxC8/q6SiTSKHKq5g/GfwzHj5+nM8lEsf4W58l+hIPPM
 ac+o2abkmrFaYpOkwQ+omjEYBKF2/v+SBH09Ln6F2kh/2ZTJ2cvoNk2mqTBWLTOppveq
 RDrRX7ciK1ltAF1OpuZjnf46tgO/LUTAc1pb26Y+Lt7xkcp2WMalZeZ1hGRvHrw4V1HY
 g3WxfsIvfxz+r0NSUxkxn4nJg7/9aLKkBe4SUO3J4cDhtRDQ5NNtmO7LEg7V7xNjF16m
 ZK91VJBo0uDIJtkvcueqZgkLmU1pYb44ZM3sG6Xlsvo9gp1vIuib+Us5cBaXPO1I2jNv
 ajrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294055; x=1788898855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+fFw5NSa5Jry1A3ONE01He2NOx9PK8QCb8F7sLo12sY=;
 b=K2U4R2W8MVy74Pfsvf/qcbFe3sfpcsV/2nRh88zCVSc3NWcvtK1kSLanUfAqu83UZ3
 Vt6Hl8gRBpQcgyuimpY4Hhy2TU0zt4Ow4uQ77F4dP6PqGBnFxeJwJLxeXnBtooPmvWcT
 wBRE38g8+r7DtOUQiPQPpKMH1QWdb4Gd0m9ZgdXoTgdkSTP+v5YxqBlZyOoA2xE2hipj
 BQf07GOaqe1FmW0e8qsSVIZ3rrdleTtQDZjogjisq7Gplfs/G7qZMMhyDeWW+C4Z5Mit
 EMM8wbyaYAuzG/KiQUvqp2VJFMNH4e8Blt6xvZXQM52Nyv9AILPtDaY6PFMUB8UAqySQ
 5+Yw==
X-Gm-Message-State: AFuF++n4rjtIwpcjj+CMPIOpf7sMGNYLljpYfjXq62NGoslau6vuEwR+
 RgtSFPpmSUu6jZPtOeu4O9ZPPrOpTbsEmVdCgonJcr7EB/BWFzo+A3L7mEJHbzQDcej3Q31sZP0
 GC4If9ZB1sdxmrfeLIqUhJHqI0yswTNNf8uy+VaDZoC+v6powvY3UA5DxrwvKBsku+Q==
X-Gm-Gg: AYBFou2u5/WQRbPHNyDFBAIGY8Ca8DiV+SqrlGdup1AQrvoNK6nobxJ0GE92aikr6rn
 vvVK5yx25qRAZb3ng0KIztTVV0HjQJBwmHQVS0tOjpyymNhybZLCCph7FfXpK5TCcd30+7tY5vv
 2EfIwWgH0src8nbgf8xFRRCjwHcCDas6ZN0Ox3baWrlSKzengzE04iW40uSZzyqS13NvembE0ki
 rzBzQ/SgNYpxoki40I8thHQXgWSjTiwwq3BHzs2XfXPFYf6uBwdrEbWkak8kwJDx77oB2ylw9js
 vTzTKF6LVCrW8vqbw5QSzWnuUbTW4usmq4gHamAVFLtgl7KWCyek92AhTc7oFqEs6bUQK+oPWJo
 gnZpWDSOZuTwB+BkPssH1FdB45fX4RmZHGLxp1y15qNHqkQVHNApCJHStMSA=
X-Received: by 2002:a17:90a:2ca4:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-398a2a3b659mr25797448a91.19.1788294055092; 
 Tue, 01 Sep 2026 13:20:55 -0700 (PDT)
X-Received: by 2002:a17:90a:2ca4:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-398a2a3b659mr25797411a91.19.1788294054627; 
 Tue, 01 Sep 2026 13:20:54 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/14] target-info: rename target-info-stub.c in
 target-info-def.c
Date: Tue,  1 Sep 2026 20:20:35 +0000
Message-ID: <20260901202043.26532-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pyg_Yty8sSTvFbUbvqWApXEe70hOnEsg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX2c/XXZRmUGN2
 F3LaHDNaYutI2WhERHWcxjEHbfK66oumCxpyLlEoUlQneiWIJTbW703Ow/3Q5avoKTdPDuBuJ3J
 Zk1UbQ9XNYyqSGi3HDqBGLdr07c9t8Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX82p63k7yNGXD
 2SsuxxeGkx/sPL0LKDudTMR+v71Hm5y5oac/8hFgiLLUbh0LZo9DvuPZ6AvOXD3CECIdbGZbtS4
 LlIlRzgdloNeDyRGBeVXLwSatJGZL+cunJZRlQa7MrTA/8by6L+F/4h3NNDkp3bBNHLV7bokjAu
 9y/b64FqUtULGjbOKwtAfodfKyyjGiVxjJdmYWGcseI/X+YrN4QS9JtHiHF4OJ8yDARQ1d401hR
 22uGaIsK86ybglGikJW4lRVOiB9okowf4cBmoLJbj9UFj5XAev+G8U/5cUgsMyOFjgNUXi+xXgs
 3KvsNFkKWE1391A9GYKDtNJiriFQ38cXUMbMrwQxKO764w42t/iczg9RfN1Ce4Gq2ahpGCT49id
 aSRN8Pf+GgeSrOHcsWfYYmbC/l53YPquI69s705JNAnzx9AEMQ9RY3xJe8qXJ2GJ3c88wjmUopp
 fDieO7NIBgQWxXeCodA==
X-Proofpoint-GUID: Pyg_Yty8sSTvFbUbvqWApXEe70hOnEsg
X-Authority-Analysis: v=2.4 cv=GfwnWwXL c=1 sm=1 tr=0 ts=6a9733a8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-IadAdOB_zlydFfnqDsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010178
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

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/meson.build b/meson.build
index 93d495f09a0..5da6c15551e 100644
--- a/meson.build
+++ b/meson.build
@@ -4322,7 +4322,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.43.0


