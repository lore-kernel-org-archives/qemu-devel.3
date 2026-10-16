Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47E3CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGh-0002rz-TI; Fri, 16 Oct 2026 19:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGf-0002rW-P5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGc-0001RN-NV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFW0a4085814
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=blRMGvTOcfB
 T+89QQAnDx2pij/y/JnY0geKSp8umcQ8=; b=Q44oHzPYfDNwwOJ87pVhwyeYroR
 +LbHHe+diuatilJngF6QdBpco51bUjM2iDbqxSOiOY2cGcdn5SaMXCs+sgAvYMNU
 hLBmWwdK3v4AL9GYcOMcZYXqAreP5DAHNy3T6ma4A0fuXzRkdoyZd2S0nTdUrxs9
 fc/09NLCF8Da25tc4YMXEz1tINsCAUT2xKHI+rjw7ecMN6NcuvQVz5WvDb/NCEOg
 P/k4+M/HTdFw3mfAPsbU2rBIjTtYQT8rI7ReNGNtJJJRtIOT8fRZjq18afNNRRUV
 mWxaWpXQ+4j2kjMhRGBuV4/75vyn90jPKJCoG+fYXPjb9cRfYp0Ex20yR6w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq22qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso672536a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792192993; x=1792797793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blRMGvTOcfBT+89QQAnDx2pij/y/JnY0geKSp8umcQ8=;
 b=Yb7G6FEiW9FiPVM91eGb97LuTOqrGRDTiLq6E0Ct/AdoQpi4oPQEsU3fwtoJLdskqa
 62EgClGjhg5ObXDQ8cxMnVAFaKq013tIEWOmJqqtEahguFacy1IFuX1VEFyczWUggSCk
 ZMSs/B/jUpRg/uPaub/vXVlNRbp2y6Mw2KmBPfladLO+PjRwcI9B4L49sQBvIKh3gY/L
 KJvc2riSA3NNMkkl3+40F5xWIHeWlRSx67YbWovWKfNXkUC1hS7q513hKpOBsqknmXNj
 ddvOupYtP9UEbcH+8Herqv9kJF2pQ9SEJyWNsqHAcDxqGKZlO5Qg6ZO2/Wwtj4ifPCd9
 59Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192993; x=1792797793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=blRMGvTOcfBT+89QQAnDx2pij/y/JnY0geKSp8umcQ8=;
 b=npVMhrNbMkD8tEX63xYH6ArywQNCE2Zg4k4L7WnJlwm2aYMaERg9x/ntt3Sm7p/31M
 acjSMiaoamjU8PdiDeq71ZV1AXFFAMEInQD+8/gVshDx1R/6OflpQyQ8XMkRs3Km49U0
 KSENqAEJm/r1kCX2b+V5mHrCPxfgMsohazFK8TnahQA802EPCfLQM0DhQCdgcoy4CAxb
 P7AES8x94wHlv6NsVodl4Yzw1X8TaGSXUmyAYwaItyaJKu1xUVGzJBSrzHnte+1arS4+
 j/XdNegh+4FTHqJdO7TzeI8KQ6VGoCiaWtBz9LN5mdUTSlI4hRZOLAYCs1DjoakfHQ3/
 TGiQ==
X-Gm-Message-State: AFq9FYItfL33OUJA59MONbe26M6GNeRiffUoO+VP0SP9R0MB5afi1LWk
 pz29uD0tfhhIWcEYfpw8nnzU5sBhbmKfQnpB8EUH1JZ69486/gxXHBQYvaCPUQiRedN6e7HRUeZ
 +ZRHfp0wWIopBl0i9e1RcC4A9hCXDeerjd2j5DsKCXyXJ5b1tnuEUhyyvTRUHlL3nEw==
X-Gm-Gg: AYBFou1nBadjYANe/9uhtk279csB4xQ4LQizLDCpXHoKMzh0vWNPW9tUoDwhVKC8ImV
 j2tTeEVjoH5IRm4oph6G7hoBgldjc35XZSAmeJQwz00pcBSXaDD0g5bqQu2+j1Y3Xg4ct6+JEt1
 vBd05/IEgCjG9EdglKjWMc8CUEFTv6b5F62wGmvbaIFcKqoy83dGJ7MfSylK4Qp9ks1S5wa0d86
 YqiwsgCqiVEqP5oqfufQ9BisCdPi8Rc1LB2EMtMhvvil/uPv97k9qVA9VPVbFPUu0cMQvcZEI3F
 wzRZ4ZvNDCkXc4upmZeDzdr2Nyq6krRnARKq6su6mDNRGUmVqneZzsiz2p8jw3aToIdDIewWum1
 oXgeWAuVz1JtmZlk/iFDtCfVp/TdLgRlY8HSSeMKCvtV8bIf/PC0fhpyAmQy2As0=
X-Received: by 2002:a17:90b:2644:b0:3ac:80de:44f0 with SMTP id
 98e67ed59e1d1-3acee277611mr1179849a91.4.1792192992825; 
 Fri, 16 Oct 2026 16:23:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2644:b0:3ac:80de:44f0 with SMTP id
 98e67ed59e1d1-3acee277611mr1179834a91.4.1792192992278; 
 Fri, 16 Oct 2026 16:23:12 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 2/9] hw/riscv/virt: make machine available for riscv
 targets only
Date: Fri, 16 Oct 2026 16:22:57 -0700
Message-ID: <20261016232304.1215119-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX646dzDHdsizd
 pimEzzvPlQw0fx3+pn5tbmO3Q7r37CsgHyzdRyvoR8W+/YxCN82Yx11y5lezuXWWcWZgtsk2ZPE
 6mYM/He92GB7wNX4sGZH6SBU+Ohz5ZI=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad2b1e1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=DBNBiUfQWWGXfxp0DDwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX35UnDdZxPsXT
 Ywyyb64TDhono7InEyZwYOFFrO9/pOTKAcmrTitU89DUzh5IZ95GqHf5nchNZhEx5y0I6t8cmfN
 sghBAaW7YxV23zrOGP6MaFP15pU1y8Mm5cc2XGMFiOe5dEuWzEzXR2PEk0JhvbzJOBMYsnXYcsi
 Osl6xbywaf7lTla2Q6v3BlTwfhk8g3A5LmsEDeapP3mYm+wRjrvvpJwZPbOTPfhg6LV9CTC13BS
 rcOYrBYWHyH6j3gO+cXmHwnSqeLlXrWILV4vLGYOUlnpQ4br4kWU5k6rD0Ot4+z0NCyv30BPLmz
 j/AqGipFtSjSGSftPi6RAaB1Qn6sD7IoowUPjcpUR9YfsHecuChUwKhHWn33AVx34iVF+UVIuj6
 o2ezj1WV7XYPPNQAxQhaIjzdnQAcgNeUt2faaFmQEfyVSFD96gxkfdKjPq6z5dK8vp5KTuxIT6Y
 bfuW3Zf48Xos1M9dvgw==
X-Proofpoint-GUID: 0_0sF9B3HmAyIhKT7df7wzoSNUrc7iYT
X-Proofpoint-ORIG-GUID: 0_0sF9B3HmAyIhKT7df7wzoSNUrc7iYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f6..894cdd97976 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -1203,6 +1204,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
+    .is_available = target_base_riscv,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
-- 
2.47.3


