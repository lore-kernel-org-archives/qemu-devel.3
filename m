Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15D0C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3V6-00055X-12; Thu, 23 Jul 2026 20:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uy-0004z7-CT
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uw-0006BC-PZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeV2N1237280
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=siNGbdBzXGj
 bkqS9DSFf1MuzNdQbWL0FC7eccs/vbxk=; b=QaLGHrskY0IWI2CmUITf/S3u0CD
 91aF1UH0CbaYboHPJXC6G36FuNb0bM+0VuWtD78HN3MZJmS67nZS/r8wu58rt0qX
 ltaiRLzGl2jTfO+UVah38T0Y1Tubjlv9afPE0giIQ6hpGy5SLLHXK28eSvZTaLTC
 S1y7z4O/GI+g6e2i8H4sfVLoxq6+tuzHLUw8sX5meawVYL5+6aSIIVzwZ8FjkNTM
 TnwEi7TztQuPQH9RsMVtM4ejTxwAHeEVchGLBlF5e8bZx7yqNyp96OUVnVj4XmGr
 p8BCnUX6OASH4vf8EWHITowu1Cb+qVWE0CgY/UbaawnFoMzVDdik+LYOtmw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso10115265ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851831; x=1785456631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=siNGbdBzXGjbkqS9DSFf1MuzNdQbWL0FC7eccs/vbxk=;
 b=G1AjStZm7E0yRxyDGhFaWKGIXo/jjKB75DEyKYVcGvhkucGNO39hCBf4MheERB7/Nk
 /cx/6Rhb7OJtIMgZcECmKNUFXq40Usw5QSTM81JaOnDMN95oix5Ahdusbzliz5+YO6Kc
 9LcpIac6TWrS4k1+F8bwdVWIAWksQb6t/Tx3TZaxVuqLdK0EmnEXGwqJLlcqioPnhkSs
 jFyT7fIbjZY7RsvoOaWSDhugqiUq3hphZTY7lB0D9olsxl+HzthVGcX3AvEyXqhwk3g+
 xVw9tXx7LOViFHCZPwnbRrLt9AHIQqYrhVqP/VTsnOoEaCGW8YmPcUrE85FALq97qJkB
 UzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851831; x=1785456631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=siNGbdBzXGjbkqS9DSFf1MuzNdQbWL0FC7eccs/vbxk=;
 b=GBa6BIj73dubk5EWaZn0DfUkDj2Ra08Uvz6WSAJMWhF5DnQiSDC1szmiOuDfKjtGIP
 K8bWTqgfDE6bAh/jejE8FBkSMbot48qe03+qnT6VvD3C2/WvgA2aWD9WR0LGAPn9MvtX
 jEYyMvzrBaGbrLg8O2JqyfyYpxkXBDCTJ1BGaP3L6kUZOUGkXovkhRLrbePlifS704/A
 eERd6i26CEIGtJ4i6VchvVOZkQuKcCSaigU0QEMm24L6NKqztPS4RzJu4S4SDRIAcNYv
 F5zcsgemVsgm6XE4d/9446/mitlqLLChpYHNM6zOfixUqDUT84PsElUKh2XdgORfOFiP
 1jbA==
X-Gm-Message-State: AOJu0YzSG7z2Ph6kwQJnCyMsHQyyuN8qi8u0/enDRHMPKY55Ve+3lfwA
 7tMyoOANG4hRQSrUXmT1bg8aTI6kFap1mwqnF3JmvMNlUsFbnKx1SBCdcDt39kn/GvMo0H9MrEk
 j9E3vDMvXbUPBGcr6D3nKdWTST4aYV5Da8Uiz06xLGFgUMLDts9YZ20MvMTW60jzYKQ==
X-Gm-Gg: AR+sD10/rMNdSyVqnLROXjvWg7OAEA3U1t7s2VFlXAoVXV5Cchllll6nCqUixjT+LzJ
 gPuDzqWkIacE90RKPTzSK0kv06V71mKr9kKEa40iNLu1zCx9od0iMLkHpksfTF7j+NZ0XepSaiR
 aL1gyzf/rBwzeWTFPyvUgzPtQ6Zz4pM+Cnr7N346FzV+BZOhy4OvTD4MdX0o27Xp4m1kw3P91bV
 Nfltf5pjMMtsj87LQ/DncuqU4sw/dRkT40jWcHBvbSe14CkQ47UuGxv/VLWWxIYx1XQjzA4Luc4
 /LUkMq+XWawFGgYQZ/tzS6UttK3gLIGB9Bk3FSwekOaVSaTzBR6jSP/53xO3E5+ajePH7qNqRBx
 sEZEXFNP3eKdjcJYS/Y5ZNjrAS49e8pVKSMzVH/+HKy8G+vNWK1K3PdrNULjCCSeE3uXzz0s=
X-Received: by 2002:a17:903:3b86:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2cfa94566bcmr54126615ad.7.1784851830830; 
 Thu, 23 Jul 2026 17:10:30 -0700 (PDT)
X-Received: by 2002:a17:903:3b86:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2cfa94566bcmr54126145ad.7.1784851830322; 
 Thu, 23 Jul 2026 17:10:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:29 -0700 (PDT)
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
Subject: [PATCH 24/27] hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
Date: Fri, 24 Jul 2026 00:09:44 +0000
Message-ID: <20260724000948.234657-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX5ceAlfgwR49F
 ghdYY9suOsWmXayHkzxH29rhF9YDqflckDHpS9b3nwxv3BEViOK0q/8lqsbq0fQwCF0twVp/1hb
 d3iwa1EN2KoWNLbeWsFdQLeWzTnyY58=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX8WONpCC6eFOk
 vS1UOx5gFsybCujAK30KAebvNPHXidGlSKtDusm46ckhgfyy4AoBVkT9Ea5heO3YhY08TOIgIMZ
 2sW8+txysTlzleQDn3K+NNtMVXFrfJiiwWrjiXB5i8dBB1+XFb3Z2uJlH2P7nfa1ga3kvP6rtq2
 18yxA6hRQVB+1/9EUUU4BFNlvk6aMra6dcc0twyKMGPFm8c3NJmfSEtA8ZT9EHDBzYjT7/dX/Vp
 zV8pcXO7EhOx73ZsGFJVxsmxs9ApkTpHBSV+iflDXDG3ipVCmzLCd14Bi5CsfwzCHLfwsqwDCta
 sHVHjpu/pW8o2tSjYeUQi0CzHMp6s5dG+s5O/RYGve0xvFVxgR7jFqokhYTGwckIrTlrfEpES+F
 X6kZMNzcXC8S/I3m0AlxOUXQFqKy3Pe0UCI7Ab+8qcB04ghKlqoQee64FXtijvkGiipHw8nitei
 ouclOf5p9I7nO0gA3iw==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad77 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0FYQ3Pt83D7t2YWPM1cA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: OqxGfrLE1dL3f4OtDYKaqCiwO8U0966v
X-Proofpoint-ORIG-GUID: OqxGfrLE1dL3f4OtDYKaqCiwO8U0966v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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
 hw/riscv/boston-aia.c           |  2 +-
 hw/riscv/microblaze-v-generic.c |  2 +-
 include/hw/riscv/machines-qom.h | 17 -----------------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 42b16945c12..8c9d50ae762 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -475,4 +475,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE_RISCV64("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 7cc24ed189f..e742e67c232 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -188,4 +188,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE_RISCV32_64("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 57da218d959..0d30759bdd4 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -13,21 +13,4 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qom.h"
 
-/*
- * Helper macros for defining machines available in qemu-system-riscv32,
- * qemu-system-riscv64, or both.
- */
-
-#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            type_target_specific)
-
-#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            type_target_specific)
-
-#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            type_target_specific)
-
 #endif
-- 
2.43.0


