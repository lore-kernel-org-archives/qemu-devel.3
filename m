Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDD5CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBta-00038x-K1; Thu, 18 Jun 2026 08:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtZ-00038Y-Ic
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtX-0000cB-Vx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArfpB3763670
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eJM2CZYWBUadH5T6cRMc/LxptkPrHYD4Q8ouoHguk+Q=; b=C1xmn/eEfjXoV5Oq
 Fqnw7ttooJJNTbIxKQzW1sOP6/B8oCVMZaS6y+usK49FJtn/lVh++ynhDeKx7zFK
 +rZLUD8X7m801aDjX4biJxt3REy9O8lWtEOuU/pTkyw8uBFrXsBV+XoS/NJ1tNre
 x+i5Z28PrdTWqopxoIM2o1bLE+WEy+XOaK3nYTXqudS93PqTE0Vxgr8ckKzpYOUW
 ISs9w56HkOrzDfxcOJPp4nGoFUKEbYqAJf7xFO9hnfP0JMNvXgg/iKeUBKznOuFF
 L+WRPqkaozEv/Zx206kgGn/iWOFj6qRMFumhRke3Mbt+AInIBWhPk/OFJcwBbnVV
 esFuTg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk3aw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-728f9ecd022so741269137.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785853; x=1782390653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJM2CZYWBUadH5T6cRMc/LxptkPrHYD4Q8ouoHguk+Q=;
 b=cbbGTxf8tdexugYg6XiSTORDv2Rc4gqcgYOUlpZxWA3346aIguYwUa/NLgpnYPPm1h
 GS/9AiUuPwBcJxY/3inOcytvpGnxENF/l3FRPDc7KVvltPUDYNKDJSRUgKEEKv73nGPv
 kkmTK3HPo7+VWc9Iyhb8IlgQ8tVuZjfqMjxJsmCTrnI7DmydTGnYhmtX40KmF3oYBKss
 V8K94CSnxleQc6+PCxGjkIpZX4+8BDHjydGeR2fUz06I8seUMQTIwXQlIR355c6/Rex7
 JRybec4BUhvXP0IiVwPRZrEm9sP79jnHyGidcvtCmx70j3ej5ozpnFf97RxiJkYgQ7ZW
 GIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785853; x=1782390653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eJM2CZYWBUadH5T6cRMc/LxptkPrHYD4Q8ouoHguk+Q=;
 b=LhCIorLprcfAtXkxAUTES+EoeGZWeUPzvsBtRk0TTTPsBJ61pBTtxfPJ+5w7iNaKBx
 1gBUn+J2cy1cL3b+0e5B4uh0PHpLNIB/f1mAhK2/YCOSTch7oE1wxXE7sxh82851FD0m
 Bn9gJNB6U045Hxn72lGB1Zcb4a+VdmVR9VS4uIytFpBE4Jv9Yaw18QfPUap6lq0scEV2
 SmlEMq1/Wzy8qyiT1Ls/o36yHUWGDt8nfWX4P4zph7IN4l7LzrgksEDAFkoRGd9ujBC9
 hYlODznS2fMhvdvOk/KsTW7mm4cCwo3xxnroEm8kmubKJ1uhzQ69pVZxvBU5LOa5ZmB3
 oEgA==
X-Gm-Message-State: AOJu0Yy5LL5Uh13GVG9CJ01kPANVFF7MmR+W1HHUVFr/fM1urBxjWRwx
 N2kXtYM2qL0cMPUoGmTUa6f2KKZYgblEI83m8nyP8Av6etAxiKiWCZVPfFzZ4kyGHXJNgjBXPMs
 wiLjooVOu93LuYyxayyPEl5fdX24RJxoJnjz+3Bub0AYqlB4AWCqsY9LnwyN2JyF3ZQ==
X-Gm-Gg: AfdE7ckBk8yg+hdyekpt1hL/pfW6Y1NbDZNbkQz92UmyqPrzbYqLI4eb12OOQnGzcaE
 jcPFLtHvEhUQKtM1vt/t519WgphrsNKdluLT/gX89aCTzolRPXMNcUrbk2uhhBUJis93GvUz538
 TDzB8RPdkMkFcIzqLl9TevYsziweyxBrDaavQexi/itZSty1YoJ3uHWnzUaEcN4W0zKBvB26hF3
 wVFv0GvhUYFEv1EtlFrhAPpO577pctuOuF4DyWCA9Cq6zji5AoeHff1N57Vd/4a/WS7AdVVRoN3
 9qKmez1pJjA/QUOHv/RlWUgOIfzJj1uSJ1ZLDXc3nmMyjsI5FO/7EIvOia2lhapjr/9J/6WV0fv
 LSMo+SIgUOpLPkL/TMca+E43FG2ZsyvTz34uyY8Xgp6/XA9d0Wp0bdKVccsmr5hUPbDF+
X-Received: by 2002:a05:6102:5120:b0:631:28c1:154e with SMTP id
 ada2fe7eead31-727c69420fdmr2114585137.16.1781785853605; 
 Thu, 18 Jun 2026 05:30:53 -0700 (PDT)
X-Received: by 2002:a05:6102:5120:b0:631:28c1:154e with SMTP id
 ada2fe7eead31-727c69420fdmr2114527137.16.1781785853164; 
 Thu, 18 Jun 2026 05:30:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm66294740f8f.5.2026.06.18.05.30.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/48] target/arm: Better describe PMU depends on TCG or HVF
Date: Thu, 18 Jun 2026 14:27:57 +0200
Message-ID: <20260618122825.90331-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cNyso1qriumV9CoIAN9tH68JFsMOsuD5
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33e4fe cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8XozVr1CCwoAqskwOO0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cNyso1qriumV9CoIAN9tH68JFsMOsuD5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX19oKTdVqLR8s
 jTWCG49mbZzZrTGB4LIeQdtR5v9aIrMKHNzVZpmJbDiH2vgmUhzvD4exEHf3DlgDpCvrX4Hse1S
 xmq1hs9ZKRttSTz9mIjaFLRnQEIgj1w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX3yc0cDqtxlFA
 VHxFcEj+0uP7ftnDVDawn0kHaP2Tte+R7XkftEXlz7Xvutm29Z/uUzMvSRVAM42sWrZgUBWRsOa
 XaUnzXVJ/eQnzYimy2uK1sg5up8LtFsPD9a+W2djlMDkCxII/Gr/EvOkGWv8FIe2hicA49/HAOh
 rVG3iYRIT11KxEWN6LG8y7ay74sB3Q+AKAfhH1NOjnDgDN+kwqrNWgK82O7pEcOoz7aalLpZwx4
 bJPqP1gLAiLpV/IWgksW6zJPxl7iB6cgQNYKT+Vsg6E0h1gsuzVu1gd3Ni5vfkvQVwrh8yxEBVg
 +kAuHQazx0eyEsMHSs5gnyIlYkvqsMzu2PtoReMJsCyE2dp/0/5HE1PVmv2S5eEEvmf9hNZDOGt
 VBzdfINsV8CWrA/zJtt5UtlqXtPBlkeBUWPwZYV3K0WyC/1WVEo702Z6/MtGd+zmvSM6MrfDmHR
 ubyKnZfDVCNwYb0Rkeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

PMU is supported by TCG / HVF but not KVM. Make it
explicit rewriting '!KVM' as 'TCG || HVF' (ignoring
QTest, because vCPUs are not available there).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20251028054238.14949-57-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.c     |  2 +-
 target/arm/machine.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 419e0b3ed41..86aae36ae55 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2183,7 +2183,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_PMU)) {
         pmu_init(cpu);
 
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || hvf_enabled()) {
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index fde3b3e8d75..89127e5d83c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -3,7 +3,7 @@
 #include "cpregs.h"
 #include "trace.h"
 #include "qemu/error-report.h"
-#include "system/kvm.h"
+#include "system/hvf.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "internals.h"
@@ -983,7 +983,7 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(&cpu->env);
     }
 
@@ -1021,7 +1021,7 @@ static void cpu_post_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(&cpu->env);
     }
 
@@ -1055,7 +1055,7 @@ static int cpu_pre_load(void *opaque)
      */
     env->irq_line_state = UINT32_MAX;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(env);
     }
 
@@ -1234,7 +1234,7 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(env);
     }
 
-- 
2.53.0


