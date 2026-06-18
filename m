Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A6CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBuJ-0004cV-BL; Thu, 18 Jun 2026 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuH-0004c7-MI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuF-0000tx-Sy
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:41 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs0fo1030370
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7l7FYzI46s6RU3OR/MsObUKNXlWa6v5TcmIIElGjxpk=; b=eod/zON+f2FkU0bw
 RGI7/O+WQVER0nsrnatm1GAqcX1TALn7ynWujJO4fD1uaAFcVlVVjkyPSs6RbAo6
 5Gjbu0UPv4AzP2mbmRQzbGJ464mgeTkS5lCXFnCIbq0cWMPs0N/9eWgyoM/YKW3D
 K6lNQh1az1qMOmZSyKruBTcD3GxlPcbugmxelumMnx5CfOOWf8G6lZWd4AczBZAB
 Qi5iTVAp0gw/kHvTom5sC/acNdhne3RTyQTYlrA1yNkriTySlYeS36T12Y5u82rg
 AYrHapJK/AItKz7w79twgKhGVxPFKj62Wln4n3F+7cHUEMZ/3Rip2t4rTQyRIAao
 WigyVQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3cqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:38 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9646997241cso215939241.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785897; x=1782390697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7l7FYzI46s6RU3OR/MsObUKNXlWa6v5TcmIIElGjxpk=;
 b=PowQUa7OoQV9h9FaAHHQIz/2HJ4bVThxw+Ac6BG+e7oGHnGB2cDBLHTH0o1vwEAgFe
 /nAZvIqjhFA54q/eOTpk1PHTFVz5dzbg5+KhmZnxWUcbvXaQrlaSWU2txobYQ3DvRoYd
 68NPWjswf9zvYggjNag45BWj7NtFHQ8Xia/h6lODktJv/iQ7viFhkmWdA/7inggkGA/w
 ZvnT8nNMSLhDkk/jxAPHrrd2CqXLrdql0LINn8jBtQWffvovYENJDWn6XBZbDYfhI3y0
 cji203pAEVOciGUzbcI0YplXmhK+xFlxcJaFNDlCdBwDL9QXAbqvAqNPFMm5dEsXbNi2
 qYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785897; x=1782390697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7l7FYzI46s6RU3OR/MsObUKNXlWa6v5TcmIIElGjxpk=;
 b=oANwWmEnu2F9BmOax7+7bdOfNEanTVhIthGzjuTRZ0TujlOEPCXBNMer3J5fvOQKfZ
 U01Pj8zMZCUCxa7NZWpF7ZrtzYgg3qFTA3ZIPWXmynfECHYS21S8mlzM9ap/sCJLTsgT
 G/97WCSCKEHResmgydqgJt80P7RqYNbx+msX8RPvTw/A28xOEeMA6IniQ8HFzzX8zFHl
 BBmeppbn8nmBpaJaXKohH0L38earKyU+xFRSF5zb5RC6EMWP709XwJ4raQ5XHzcUrRQX
 IROYMjbE4Xt8GGWOHiObCUGXgWtF5ShP54mlkU1aZ8Pw17YGsEzqXNh5HqyCZBO1QRkr
 ytrQ==
X-Gm-Message-State: AOJu0YxCB02Hrh0b5QMXm/lZdMllgW0l5Dq+KLgCqE88/UlCOuQkP3vO
 f1qoBk5cV/68VAJZeMrIVwY3HcRQspsZ+RIgcOUrss7fmUsxSci9sumlWnukJIH4fQybttfV/3W
 GEAgAWifM3vTfnTuP8kquNe5bbs4wGCY3n/xYhgFugW8NggELQ4g3WFHXjppMnJycjA==
X-Gm-Gg: AfdE7cnIMuIN6zW1KypTLsrXP4p5jsfcJu1+Nm/zak3rU9B1BJDxSUDLDYkt5A/VlbW
 QsGJaIiO4hG6Mp1OADWDKL5BmfY84yhvsuJsLxTe/dAaZABt2g0FbOpRN/sFU/yIfpdao6LMqv9
 aGuZhOKILAtNaqF+Ylvfv4fj6j0onR5r/sjF69RZn2jjJ0mbuUQnnQMwJv3DM7Y+iewqR9FxRSZ
 FHTJcyB9hoZBB8B8i1oUabG4d2DTsXXPwM3ziw956IXP6DxAitzMuxec5Ik2JfSafMMlc9WR63q
 mccQbtd1hJZR422tWy1wFl6ANN3NtIAxJKeMqlwyeJ9kIXRd8KgB2IXA2uXslUCjIXYDKZXeIh0
 phg8gdHe1yzv11CJbXBoOH0X6NT4cckxfWWq+xdS5uCgBmbDDLdDTxivBFU+HI6eOOGjG
X-Received: by 2002:a05:6102:f09:b0:6ef:f691:7044 with SMTP id
 ada2fe7eead31-729274da8aemr676452137.1.1781785897350; 
 Thu, 18 Jun 2026 05:31:37 -0700 (PDT)
X-Received: by 2002:a05:6102:f09:b0:6ef:f691:7044 with SMTP id
 ada2fe7eead31-729274da8aemr676383137.1.1781785896804; 
 Thu, 18 Jun 2026 05:31:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a45b30sm245441585e9.2.2026.06.18.05.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/48] accel/hvf: fix double hv_vcpu_destroy() causing teardown
 error on ARM
Date: Thu, 18 Jun 2026 14:28:03 +0200
Message-ID: <20260618122825.90331-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXz48yaDcQhURz
 DzLOy7VxJSBOK/mGJ+xZpn6kjpwLGiSkfv+5IO/zVfXB+RAlkzcFCtHmlA0zGuUo3WjFmAtelEX
 imKVKZ4LxRG+6U3TfwWxGEKZIbD++L8I+iTuIhBWXNPg3Tvhshce1LfTn9TI+VrkgxeqU0M5g9E
 Ll3qh8AlWzVg8gI4eYcFBermH3+t3dtjTh0ij82JUOiKJbtkYuI35vW+30h4OOfcPx4KdFTnFyI
 +lmiFQOA/KPg2XT1TZ/Sq8ofLkWxlsTqNZoEKZGq4EcVyWWVLJ959XvFAgc2VgfdNjdbqEfKlR4
 mFyUTB63FAMK7fNu/SSRAHi8o/4eszZo4kSXDHc0riqwFh7qCldVdu11fHsJjrVQbcsEQlqSER9
 L8t/HOL35mH5UiYMHwSP/oXv3LIdXoErm+XFVUv9wYvhTT0wcJqi0yIb8hAnoxmXl1PJAq3QMsE
 ZLTf2P/gEfxWEuv2Wvg==
X-Proofpoint-ORIG-GUID: dbB-Uwo6uewz9O-NeXLsiAUoKRoxE1J_
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33e52a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=0vMvDItshvRoZSfmwLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dbB-Uwo6uewz9O-NeXLsiAUoKRoxE1J_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+V+mXcIxunnZ
 YWz71S7+ZgXrKJzVud1IRMQKljIMyQ1xHKfUH2Hq5DkfjFLjiJyC3BagFP05JHCjmCYxTezkFG/
 XleH8K65JKNW/uXylIsDlryNcV7usCQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

The following callstack causes hv_vcpu_destroy() to be called twice,
producing HV_BAD_ARGUMENT on the already-destroyed handler:

hvf_vcpu_destroy
 |
 |_ hv_vcpu_destroy
 |
 |_ hvf_arch_vcpu_destroy
     |
     |_ hv_vcpu_destroy

The first hv_vcpu_destroy call covers both x86 and arm. Let's remove the
second one, as it is redundant.

This reverts commit feee55d36a1c5d494ee73812d279b439bb05137c.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a5b30b9ef0d..8b902c68829 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1301,15 +1301,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
-    hv_return_t ret;
-
     if (!hvf_irqchip_in_kernel()) {
         timer_free(cpu->accel->wfi_timer);
         cpu->accel->wfi_timer = NULL;
     }
-
-    ret = hv_vcpu_destroy(cpu->accel->fd);
-    assert_hvf_ok(ret);
 }
 
 static bool hvf_arm_el2_supported(void)
-- 
2.53.0


