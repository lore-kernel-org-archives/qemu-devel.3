Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8367C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UyZ-0002JX-PH; Tue, 01 Sep 2026 16:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyW-0002HN-1O
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyT-0003UE-8l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgMji3228308
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+1VSVSBxGg3
 3owI1wY/Ik+9RAK8tassq8FGXU807x24=; b=pvyLBPATUrzOQy1GScErjJbSHib
 xJoI5kQnrEHftlT4tJU682hL5PkAqt5lGAWFI8UR1ATckHxZnKLaL2Puu0mOoQqY
 EddxZQE06RpgutWKAQtwNkZeMCly7JdnDjfKRTYJaSduKwAsud8h89RnXeRNWSsq
 VAjsD3/u1nl5VJGGtYKPOoHuvntt4Q6S0Hv57o1E4A5WpFud9VNZuYm0yBKinzUh
 kce7wIWnHINGGuuMIbBZTpRQ2eyCPlDTTsqZ87PdroaLzc6AMd6wQ1RhEN9aIFoe
 IvA0eCGJnRgv/p/TdHHr+5VyAAEDTh4our2VsMC49Wdeks2z7KRKr9DYRFg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdvmm2su1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so277366a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294051; x=1788898851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1VSVSBxGg33owI1wY/Ik+9RAK8tassq8FGXU807x24=;
 b=MPjW31iKtqO5lSWnPQxdW7AiaZvcClLj7y7/zLXlwr1yfpx3bthRGHc+UdtQSXJjll
 xHCbYMm6rXq+Z3Bi89lx5JXSOxMYTeCBefm7Ri+dBypXi9hkXWIl3PY08wnk2yVurRd8
 IDYAG0c3bPdX6ik1utE/pbl0Awt76GAP2kV2/UNYgOvN233wZjVSgcywuilVJN9XJkla
 k+RRE4hDJ5PUlsSI2XE8s6faRiixS+aJW9B/75Flef6djhyF3dCfsWJE5J+Y/RdrfBhp
 b9/kOv3XtU6/tXmUEu0FzXDL5xo/1Mv6F59rPRCbAogOscdu3ZiX71jKdcZmcsEImB+Z
 pCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294051; x=1788898851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1VSVSBxGg33owI1wY/Ik+9RAK8tassq8FGXU807x24=;
 b=E12DK7UjT3I+24ZVkMl8eiuegjLeeSZMz7WDqcr9IpaTzByWLX0gaN/jYHRffgxHT+
 eMn53k16E3Rd0Q+pR5Gkeula7XBLcyMtxQSK2fPMHoR5xrJJG4Ks+rziCuoQZfFz0io0
 6T0d4TKNHEE2oDQzw/su+cZkazsv8Sf05PoM39XUrc5TmXNy/TTAMumPY8HSpp4nLcXr
 ueDQhiXGv91huf3jZ/cEJVpf+qOuSTLZx7Xlrqrh7NeuqqInzdZe2a7DMhHmZp47WHZ4
 TP92rIKv632tbo2M/sqXyeYRQWU6t2q3+JZ0Sxzt7z+7YsL5tNjAh+T/bK0bDw8jUBWk
 kJ9Q==
X-Gm-Message-State: AFuF++kHPv0FVpSkmELmETr1c/a4IoUAThQz0YeAwfb57v9BS5/kEJ0Q
 kUNqkfE1S0HhK4gQxHNf7MqzBjfQklT5jmObFGbexWcdlYmgi4a2jfmSx/TTP6ngeUWx8t5QMAV
 ItfzV24HveQ+9qY2mkQ810EPzYoCra7tIWTnbeuAoA8bIflR2kxDk0DfBfSbXaQykbw==
X-Gm-Gg: AYBFou1yBFOK3evwy8NujxrPhapLyqma6AaWWTV4b7fNQcmW1ocY2j1gnm3jSQLgseg
 xsuOnurASF0NunTEUDfsqk7RULTtKsLh3iDmaqOA55nmFPSmHsu7pSwVO83g85sL9z3Vdt7a0KJ
 6B+dsyxAZ66CrlSymVwCh7a81gaGvzXIihtorfkfJietqI8ZXh4mU6kFIH+hyp6EJrYj+OC9sKZ
 ueErr0w/GN7/AjHlJ8+kC4NUqPAOzsSV7teqiEk4pG1sF0xD3QD6ZACb02Um5AqsNxBIoGSkADM
 HU2bKUgphhreQyZp3Tgt57zkweA727/BPyBn1ozGiTksQlNmj2o1kWPMdO/3e5xnUsUv1tPaH6Q
 ekt+sczAlhbs1Ob8cJSWzSvEjcTLGQ0EsMYFas9XQ/HLFCzXucNCmDUCjRVY=
X-Received: by 2002:a17:90b:2692:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39ae83ec5c6mr1054010a91.14.1788294050832; 
 Tue, 01 Sep 2026 13:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2692:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39ae83ec5c6mr1053953a91.14.1788294050374; 
 Tue, 01 Sep 2026 13:20:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/14] hw/arm: filter minimal set of machines
Date: Tue,  1 Sep 2026 20:20:31 +0000
Message-ID: <20260901202043.26532-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: srBxaTwnWro_4Nk8ooLwRRwXpIImH7XY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX7/7XL4sSzf9f
 adzQP7yGC4wCOtMGicHwnINiesXJOSC7LnQ1PRQ+Haqpy2xJRYOatB2m62mWgFKUyl5X9Pmnekl
 5mYNgR5H2FoU7VfDGalHu+vk0+/lVpU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX4gpKLjJxOR9s
 P8nqyeMPyd/9r8zhBlx6+yTBaRy9UvqmJOzjt42ihhJihD5DuaM7N7jX1rePvqWuLXTEodJNsJD
 3QuCvOTOl6JTYh0wj+TPvCp9Itqfa5SGEVPiXJxWmz1GILUl2P+1oS/ZGdbv7f0oTLiMVqWeJAv
 1xq9/62W9/4J4XotunrbIXG0brWh0c5GwxZRRF0fG8tln02b91T4GaHBszYfobD04TUDmemJsIw
 yJulXEOzQuQZWmhveuFxD0YyEBEj3jrU0nF1c+Nna7+FUDkdyCv3NQ3TTYWK6qwyTMD+Ou9zUVI
 qolj02yQyxgPVocolflmKv8l8snthkzuKZS19+JbyvDoE4RIok0uDZP4/Vsly2Ia5yr3oFtjWf7
 jBylFK0d+3q2XSaWUSVufIGDMk6YmYhpnahs9+nsjD+WHhjfxrC0j7jetbIYaQWL6TZ6Sox3aUe
 UXstUsaian8fqsIUpDQ==
X-Proofpoint-GUID: srBxaTwnWro_4Nk8ooLwRRwXpIImH7XY
X-Authority-Analysis: v=2.4 cv=GfwnWwXL c=1 sm=1 tr=0 ts=6a9733a3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=uqJ8O8kv5ld6GfOkGsEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
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

We are about to change the filtering logic for machines. These boards
are impacted and already are conditionally available. To not break
existing binaries, we need to filter them accordingly with new mechanic.

From there, we are free to remove the previous filtering mechanic
without changing any existing behaviour.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 1 +
 hw/arm/aspeed_ast27x0_evb.c | 2 ++
 hw/arm/raspi.c              | 2 ++
 hw/arm/raspi4b.c            | 1 +
 4 files changed, 6 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ceeae336df1..54230aa92e6 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -235,6 +235,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     },
 };
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0ff1bebeb0e..2b767808e12 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -76,12 +76,14 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .is_available  = target_aarch64,
         .interfaces    = aarch64_machine_interfaces,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
+        .is_available  = target_aarch64,
         .interfaces    = aarch64_machine_interfaces,
     }
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3f99e87428c..bbaa20bd630 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -407,11 +407,13 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index e1595a875fe..2ad561fdcfc 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -126,6 +126,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .is_available   = target_aarch64,
     .interfaces     = aarch64_machine_interfaces,
 };
 
-- 
2.43.0


