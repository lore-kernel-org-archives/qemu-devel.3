Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C08C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Um-0004xF-7V; Thu, 23 Jul 2026 20:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uk-0004ws-Rq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uj-0006Ai-77
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NMTAmQ697402
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=T12oUeII/tO
 ydjJYTOL7NxNfM0bUgSC3fJkr1OJx+2M=; b=UfbwgSJYZAWb5LV2jYc9tNpxWKx
 frRiK6jYi+1uYykZL2ZMPfs8Y5S2TaembWph5JKxXZqh5pWvyhwqbtckAKvlqFAF
 T9kHBifZNZAopUCd46VRC0ly/RunaDfaPhO/7tOax5EVLQrrNGI2Hz4vcLbpffjZ
 fbq7FeL7n3aXjkVZWemRcKE+MWquwzGaVKkWrIgahR51+gACrGVXKOKzacwZYiTo
 stW3+mxp7ZAVKMCdIYUwd+kzqf7H2LYbZ/P3aXvpRntodUeG/AHTscy7uVcsl7Gf
 b2bKjx/brIKZC80RE46SyQceKkVlAEn5BGlHPTJsZN2qEfn4jl9s3bTmEyQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkusrr7tm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38edd45cbc4so1080710a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851827; x=1785456627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T12oUeII/tOydjJYTOL7NxNfM0bUgSC3fJkr1OJx+2M=;
 b=YY8TfWaV7utOSPs9hYtwXvj1TYLE4Pf9BSq1lCP8g8yykb+f9OpqR8LbAeqjDyM9YV
 K+1arnCZ1TsW/oLWIK4zOjA+znHNaGvJJnGIO2hg+PNzVsZM+8IVQqm0MW6PN+4fLv0J
 toWGosW7gJp/PfLHjDW8JVdyOqltFzkWukSg7xwLszwOYzG+HxICOvfjcBpKVgJ8kl+E
 HDWFjsHs2NNLNYn21iptdAfWY5bE6LTo4UlTrowLiDc2sa3qTmEm9lb32KsVYNQww23F
 yqxVUGYTRt033iSLAfwWdoGKmqcrZDpI1XcgJseYeh7v4Tu/fP2eAZ398wV91dvB8TYr
 S4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851827; x=1785456627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T12oUeII/tOydjJYTOL7NxNfM0bUgSC3fJkr1OJx+2M=;
 b=TPFsJPywoNAwzvWhuWwBWk8j5JKoQp2nLvVGNVXhQ+yfkwKzMa9DZ1/Y2UqED3hAJe
 qX4c9+bxS4jmeKibNiDA520C4abN/3SmgEsFU93i1N0/V0Sh9T3IHtItNjtJBj+ATrVz
 0KIHINb5qDgbdsFuhulKBc77k4W1nSuZAHhNJ76XyE5O3pOhCOP2dEcmQhlSoB7Db8h9
 XQOJdSUTL55A5yXVHgfDy7PsFWttMrXhKY/syttTQAW6rNfrHxR5ItXFgIjtc3wJo3gs
 +6Y6jCYb+7a4eUZ2mxLStsWZElm6PhsTIQwSJukAFEXiFN5aMnuwaVVMxOLMVe+4YS+9
 w82A==
X-Gm-Message-State: AOJu0YwPTQ3SZLwQIWs9Khmfb+VOXfX6PeR5ogfDgmU9h6obYQziFGLU
 ss4NdhNTBYJ6S3CRb0zDq06RPsj5qHj0EJk9oQuVLQ14QAsbS8uQZjmRMlIPdhzteIR6+aOrQt0
 NfiUd9ouPZa7EP70z5lTIb6205ak1033CvDCalRwLnswfHan2kFQ6KN8C8qXtl703OQ==
X-Gm-Gg: AR+sD132i2oxSW5CJcY13i6QGzZApRlCvX8JS/2v1WuA5Rbbnss+GIXrRo/+Aiuhodl
 SiwtnncZoX0+wgOCww+KDQ9PuQ7XApSj4XDwn7eZkHpN0rsALFBCGuISoPPDMumhh4expogaISW
 ZBGAZFGAWPhkTlt6voUznwIh83KRTuUtE0g5GUx00iEJGSuj1alu+fhu+TcTPKlXEu2Y40c6QkS
 gLcaIC7KO5R9RLE859tMRzIokKIejBGSkib3vqfr54RGhzT+wSfZpVdf5wQOQboJwnI+q5QtOQg
 CKOzW1tPBlcPdfqNqkZMeQ7rvscC0N1tQg2jHPzfZP6VfrQSyU0DY+fmZlk1YwPDBKa9h9bUuF6
 qivemPnjJwp5prdZ6LfGdtVGEPATu05SJXcHGzYxkSAzej7BRhvhMAGxpHGQhXDv+DPf8jac=
X-Received: by 2002:a05:6a20:2591:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c44b06e27amr5530333637.32.1784851827044; 
 Thu, 23 Jul 2026 17:10:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:2591:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c44b06e27amr5530301637.32.1784851826645; 
 Thu, 23 Jul 2026 17:10:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 22/27] hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
Date: Fri, 24 Jul 2026 00:09:42 +0000
Message-ID: <20260724000948.234657-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXxpPfC5d/liwI
 1MIeHdiG3SoAAV5wnc4/wXVPgcbO59412VlwoRWA/DAatJI70m2H47JkE8cZ3K6IT18Yj/ll1ka
 ld9kEcZc2RtQkUBDpyrZwVuShjZiRMc=
X-Proofpoint-ORIG-GUID: Ed_qDbzNtVkDF6aBqS2r8y8OlkKnE1lC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX7gJZVigwQnQj
 nwcxga7BOmdqp0um1ZSQpb7hpzsDru9L9jCTdkd+XmvjW8ja7LHWOP3fJrospBgDjFUKLYx7SsH
 GWmCm8g/B+6z59szydYd/IfFZNMQnAy6E1EGulYPS9GJGHzkwbVIw1tm4pzdMl84eO7weu3KsLl
 FdXHagpppoMZFXOT+JH2eeVqVRzb7vvX+Lg8FaKEeC4Y+lMS3Sgk0yc+SywC+kUJKwm6ngx6q3s
 USGQeRn9XX9ewsOvKR8yObYi0dBiPruA86qSsLDXqrmx/OJapKP1JskkMQu8VTygAOdqpZn+MMe
 2G0BCVeaAspTA1Oh4N7Kvi2hTglbCS0IT9bGhoXEwBAYM2WEt9Qw7FtQ1eJ1YvYqZLc2kjiWE35
 zYGrr7P2RJVkMS38cn9fx8FIxJIQ0Zq6dj76Ie8UqeBz6kLT8jwPMk1HhcEx89AGLDG9ZzVXDWX
 mGPBB7AmbD6mkZeHqhQ==
X-Authority-Analysis: v=2.4 cv=PtejqQM3 c=1 sm=1 tr=0 ts=6a62ad73 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=fBgaTaYr_MVs_1uIMZUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Ed_qDbzNtVkDF6aBqS2r8y8OlkKnE1lC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
 hw/core/null-machine.c          | 5 +----
 hw/riscv/virt.c                 | 2 --
 include/hw/riscv/machines-qom.h | 6 ------
 target-info-qom.c               | 8 --------
 target/riscv/machine.c          | 4 ----
 5 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 2aa748233b3..2f008c4a702 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -56,7 +56,4 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_RISCV32_MACHINE },
-                               { TYPE_TARGET_RISCV64_MACHINE },
-                               { })
+DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51bac47a91d..f9de8827624 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1791,8 +1791,6 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
-         { TYPE_TARGET_RISCV32_MACHINE },
-         { TYPE_TARGET_RISCV64_MACHINE },
          { }
     },
 };
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 5a5b5e05f58..0f9f3b94eac 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -13,12 +13,6 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qom.h"
 
-#define TYPE_TARGET_RISCV32_MACHINE \
-        "target-info-riscv32-machine"
-
-#define TYPE_TARGET_RISCV64_MACHINE \
-        "target-info-riscv64-machine"
-
 /*
  * Interfaces specifying whether a given QOM object is available in
  * qemu-system-riscv32, qemu-system-riscv64, or both.
diff --git a/target-info-qom.c b/target-info-qom.c
index 30982d9d18b..5e0f21a319c 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -26,14 +26,6 @@ static const TypeInfo target_info_types[] = {
         .parent         = TYPE_INTERFACE,
         .class_size     = sizeof(TargetSpecificClass),
     },
-    {
-        .name           = TYPE_TARGET_RISCV32_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_RISCV64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
 };
 
 DEFINE_TYPES(target_info_types)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 507e862f061..484a3730ef4 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -539,18 +539,14 @@ const VMStateDescription vmstate_riscv_cpu = {
 
 const InterfaceInfo riscv32_machine_interfaces[] = {
     { TYPE_TARGET_SPECIFIC },
-    { TYPE_TARGET_RISCV32_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv64_machine_interfaces[] = {
     { TYPE_TARGET_SPECIFIC },
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv32_64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
-- 
2.43.0


