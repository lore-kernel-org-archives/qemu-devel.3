Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C3606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K3GJcdk9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dGfoaivj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQHb-0003uj-HN; Mon, 09 Nov 2026 09:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQQHS-0003th-Ac
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:23:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQQHQ-00031w-Ja
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:23:30 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEop71322908
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 14:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0uZkNlY3+CvCbrkF8qlIO1
 aHfzcLxisDG6OtVJT2ZnQ=; b=K3GJcdk9Z0secSCH40XgDRoJgbvzKVbLLOwBMQ
 WaMGB4ia8KY0yHsI3NWMCkbGCNe56DecTTK1BpzgJQSnX7feh85kdRtWQmwMlp0u
 0TgZv/VhE6P+coWmByfmGaoEDK5CxFHgz8KU+Co++Elw++o7fEE0VsihHmIMS1OL
 Wfphi2jX4O/zjAhDsThlOpQazIPK3eW4ri0NuoffBT6Ac5RU0EtgGAPkt+rprPoT
 JQANw785yTuDm7/MUib6VWrUZ+1BNfIkDztfG+Cz9dhWRaCHwGfaQu2TFLDcPaMM
 BxJbKWQOR4YhmLkF5qhUxSpWaozB1N93Lkh5sbILz91mPj1A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qrdxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:23:24 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d2df72e621so157404137.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234203; x=1794839003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0uZkNlY3+CvCbrkF8qlIO1aHfzcLxisDG6OtVJT2ZnQ=;
 b=dGfoaivjk2XVK+gKFqMRZVAn1qo1xLiO38COR/JXWJZjRiqUl+viPxkx8frVpxgVYz
 dhx1my4IhtMFdqZF+s5+RtUfUR3Qb5UaxlwbJlPvNboedMcqt19X1U9nDUTGr5VNtHmd
 4k3w+p6H1vMwZ/yK86pOZhf70rMyUjV/Tz8porQjF6MoZYvxIn8nmoa6pHLRAARu8zxc
 jpLnt5yJyVJJXWOmu1hdLKi9/F8RRPUfArpjfTjjus+DuWaYDveSS+yX+8TE2B7E4T8Y
 mrunH/Ewp+Rk27rkNfSGMrmvXmC0rF+HSn1g3XoiQPTrTLeZw+Od+HjDwyv3l6ESRg3x
 k7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234203; x=1794839003;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0uZkNlY3+CvCbrkF8qlIO1aHfzcLxisDG6OtVJT2ZnQ=;
 b=XZz91N2C32et9nawE5THjClCuqdPxu6lG/aooCV5j7FWE5t6MuoZEB0PZGS3ODrw5S
 4p3I50he/OZpfbsoamRBXza/bcMSOlf2od5Rw8gA33wfwOCAlrw1Pw5lcFPKUKEDV+X+
 nTlnrZJE38REvTNC2XzN8pnKyl3rm+6C3hi+PaeTgxkMkgGYODsQfVaeFdpuwQBCYNXb
 JURpis1PpWwy9n4otvr2AePwOB0I7R+4oSfYuuVp8K6Y2byiHso9SuJ0HCoSH8/IjjHe
 atQw1DplMwlAAw1lmsydbC8RjDRS0XKTtZ5nQ1AaOaKQXzDbYxa5l+p97XIiYeFFD4Rv
 Vrlg==
X-Gm-Message-State: APuU4Z9GUzunT3MATf9+aoBy6tv/VHimVI7QmAxgHLZwr3NG+tldXl1X
 gQMKfnI5UKjPi7smVAWnj6y+R92MOawgw06iGrrbvzLawo04B5MBBut5/XjlbG/IDvALW9K+Y30
 KGPKayJmVZZf/salCc5GzZN6OfvS5Y18Vodq7TrKVLpItkILYVLvO1j87pD96smNW8A==
X-Gm-Gg: AYBFou28NjfFb1N8/5A9LV3wEcmX5yiN3+L3irbNeWPgGRsYA3Bgz6WrCkDFpofuMtN
 zgsBEfacZWkP/7wLORT7jO307G3vRP0bJ5/zqP3uXXswuDmmytY1Nq+9S7XW1RSL72GH8XdeNvO
 vZLSG2aqwIxp0nCH4noDWvlKM9BPeOtLGhjG52/c1+AUBm7HwefPrB9TPrwmycJqe6F0wOzcQnY
 lI9Cst6HerTfP5seANgJFj48fnhVz4VqL0y0iZhO1iRitncdofyo9CM85vMc56RIRHLDYBKtkuj
 uyP3bOs3JYvmWS4+ggXhm0oNx7kcjl+FLoByl4I9GLuUGZMNZ1RbeWm3/AOnvbqRcb1lajr9SJg
 UE8a4KcGGpV8Rj4Y+nlR7lA9TehYgARcdFV9p0h9LYNBnPlj5FHch6+IDS0+9hSzAZyFc3/zrPy
 VSzZmqsE1wkCwLGQ==
X-Received: by 2002:a05:6102:c0e:b0:7d2:8cb8:dbea with SMTP id
 ada2fe7eead31-7d2db1b9ab6mr851139137.36.1794234203375; 
 Mon, 09 Nov 2026 06:23:23 -0800 (PST)
X-Received: by 2002:a05:6102:c0e:b0:7d2:8cb8:dbea with SMTP id
 ada2fe7eead31-7d2db1b9ab6mr851127137.36.1794234202755; 
 Mon, 09 Nov 2026 06:23:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597090444sm10883383f8f.31.2026.11.09.06.23.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 06:23:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Ashish Anand <ashish.a6@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/arm: Kick the other vCPUs on SEV under TCG round-robin
Date: Mon,  9 Nov 2026 15:23:19 +0100
Message-ID: <20261109142319.73878-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX++gVMVcGRLKH
 2ndPgmKjCAaCjYoF76vcuN65VF1k9/fy+zMp/gjDMHNG9/PS9w2GLmDSkn7xMq5LjrxvxjLGRig
 s3WwVDsPUXETP1ePbWsEiakkeh93UczZATxuXvOtU4Acls3avEQTMNeF1FmWu/K7uw9sirSwPfu
 ksauMECAyEM0/GZTKNeBYlme40bG7S2IhxUYAq41Gq/dVbRHagh0AcSX3FjQ7tj1D/moqU7GIeQ
 QauaPoVunFPe4v99OSvPg785N2FAvsHNYo2yYDQoXHIQ+7xUhkkHEwR3fPFEJcIDfmabVcg9JQD
 tUuUzc09LYPpvasY5gwS8UCX60iWlYfPbwlhRBsEVRtfPdLnf1AA8e3C0cKiYi+17gcDUtzPWpu
 WaU34nWDfgWpEBehfMJNB2qtLEavoh1x1191NFV7tvJ+sB4+F3g4CIIWX03lTr1bfBfZ5cgC8Tn
 HLVa/KeBIl1Ha64TcTg==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1d75c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=J0BsVto9XRD7R-49C68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: UFbQ4_tdWGt6L-_lndap41x5GNaZlbip
X-Proofpoint-ORIG-GUID: UFbQ4_tdWGt6L-_lndap41x5GNaZlbip
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX40/etxq9zkRK
 WObRJkmiiIukbMqfwYrYAu/6kxhiuyHFltRfAX5Ps0oZa7boSZ58e0JCSI8CT0QTSnH0Gd3cJud
 bYLK53SirudxQCJSvI7z7ZjgjrsGigo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In round-robin (single-thread) TCG, all vCPUs share one
host thread, so qemu_cpu_is_self() is true for every vCPU.

The SEV helper used it to skip the kick of the issuing vCPU,
and so skipped it for every other vCPU too: a vCPU sleeping
in WFE is only woken when the RR kick timer fires.

Compare against the issuing vCPU instead.

Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/tcg/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 6a673e5ae6e8..173dd0e5151a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -470,11 +470,11 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs = env_cpu(env);
+    CPUState *self = env_cpu(env), *cs;
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         target_cpu->env.event_register = true;
-        if (!qemu_cpu_is_self(cs)) {
+        if (cs != self) {
             qemu_cpu_kick(cs);
         }
     }
-- 
2.55.0


