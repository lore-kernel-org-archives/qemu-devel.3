Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1A6CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4lG-0005V1-OF; Thu, 04 Jun 2026 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4lC-0005TA-MA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4l8-0003j4-Jq
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UiC81132984
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 09:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rIJ+z58zb6Q
 93VW8mtj9oFZEH0MU8/yOI5xPORlDuXc=; b=H4DgzJRi3qK4f71Vc4QY7aOnGLt
 +3WhfiQvbv7NCNvQdxSqTUQn3MISSUEHy017UH4aJCCGE6EjlFynTDAw7epZ7eEu
 a7zhpQzjYbsGUqPnE6rLYdpMGqKzTQW1q4wRZNcqEtACTCSjHK76R/fH5qoGdk7S
 +ehafBAM7DBEDXL0U97pPUxlppeShWCakspP+aKIhb/uMVynO4T/sUw9JxcywKFS
 /DdnAB7EdsCqMLnnHQodDrcCCelaAAlTPNuVA+npd0S6afI6ka+n8JlLMuDzf2nG
 HwCub46l92YGfQz7+Z12NLmONmVOra9kyOsWY7YWTJzQ8gDZAe/udys3xvA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsga8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:53:05 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-660668ea5cdso846813d50.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780566785; x=1781171585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIJ+z58zb6Q93VW8mtj9oFZEH0MU8/yOI5xPORlDuXc=;
 b=Qmf1y7Y8FKBNKFF5OMTAbCODW0ihPTX/XGGuBjD9vdcj7K4HuFeyCNziPG+L0CBNoS
 3YzYT841aZkU3jhueNx4VD+mBX11ZmGqq0iOc79STXo24Zy5eHSePR8iXA+FsetqHAbW
 26RapzzHlKvdzv/dtyBLcJM4xnKKIZ2weUkkh0lN4XYuyx0lIFscyoRSLIR3HGhPqMPs
 VD/F6II2OnoBEF8RtvL1fqsb/vTtc40OJJqSD1J1nU4i2m9+qeXwtR9+wjLgMaNCw0g9
 0iFnMxb424EDz9UtNkP5MATT5Cdy9IS+R4xTp7eobz5T1UODMorAMf64Oc5S0wfqGR58
 gv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566785; x=1781171585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rIJ+z58zb6Q93VW8mtj9oFZEH0MU8/yOI5xPORlDuXc=;
 b=QEMPDHfdPMn7S3fMHuUrVP1AoxhrR+6WdiTjTvYJg4SMwibnwQOYVt/R8qxlt+ikHM
 DdCBJ2zIAMJObePB+uj4TSzKB/7qxKLljlLgN4CRGdGuT+QXWK+leVDq0t+T+P4zTU2S
 iHqYePoDF27qr8J2qVSvRH7Lq2leimH3oH1hqaSPhv2gxU+MHI2r/g3RKlMFILKP/AOK
 Dtz1opbCciSgY+Rf94hRFhmqfqgLmAM9KGAKzM59qqbTwcE7ZDPQ3gdlBfdR9WObPaWy
 IPRHrPPNC1obEbm/IM1PbCivr4JK44oRUnEebOfhtPl60F9/plLS35LHXnHdAfQ8HxNV
 6y1Q==
X-Gm-Message-State: AOJu0YzzzJM4HSRKLlplVgSzoaA+8eCKQNBTwV9KQzgjOYVBLA2Gevie
 aJMnvz7lJ37cPpoOdwpdgA1Jy2o33PXOP0ZKxjnOXe9IFMYq01XiMzE3OT+XDvYAGtIEg7v/AOY
 QcFa9wmX/NLJOolNeravG0Zf0hkxEt/X+LntleVFuMrUvJegjO4sPUl+7+bYECBMKfA==
X-Gm-Gg: Acq92OHK0vmz0aRumrXfXXiT0EaIT/gkZitoQFmYWmg4o/fNxonAvHS/HSljF5c20Zn
 owNruG3LPgKQlML3f+iDKoxo5JcWViNfZJ0uxqIzEkOYdZafKaDH21QA6iBWaRQel3n3CcgMt6A
 UBj8gvWh+eQSaPuQdW9QmTHFlf4Px1ZPLnR8Qx6DT/xU5iSl9ouCGiHHD2Vk0vYAdgOQBI6grjt
 ixIfDGuxKQxLRjOJB3uKTfwKXKRjTcovrHZxPPD9eRyHDXE4XTdorrW/VrXTa6BF/lqps/S2Si/
 jPoX91vqD58MrZpbqorfJSikK9hhV53klHeo+yLOqNTTiX0TAKSR3vS3uGODyW5CiDb5c1r8NHm
 537Ko8SktKReAE7g6WGDHBjPNemtVApvcb8Dzguz0EPPap+t+ElL8pwTSFgI12WHh66Qoyg==
X-Received: by 2002:a05:690e:bcc:b0:660:eaa5:c13f with SMTP id
 956f58d0204a3-660eaa5c3fcmr4660782d50.28.1780566784617; 
 Thu, 04 Jun 2026 02:53:04 -0700 (PDT)
X-Received: by 2002:a05:690e:bcc:b0:660:eaa5:c13f with SMTP id
 956f58d0204a3-660eaa5c3fcmr4660772d50.28.1780566784141; 
 Thu, 04 Jun 2026 02:53:04 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64ba680sm3522830d50.21.2026.06.04.02.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:53:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
Date: Thu,  4 Jun 2026 06:52:41 -0300
Message-ID: <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2gYE8LxH5R1nlzP9vLdzGBr2eftuts3X
X-Proofpoint-ORIG-GUID: 2gYE8LxH5R1nlzP9vLdzGBr2eftuts3X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX80ftUKAQnDpp
 M8RBZ37z0GRdHM5+eG8BE2J25eBGYAjFg4fPy5Xl1aR2R5TZ7tG55axZtRhkqjytQ4NKx7qYQja
 y+0yFfGVzg6efDWsJbZrCiz3pP3XTjgRM0w/7MEhMKoQYcdkeb0C7WvvNmQxIj97nKLvh5z3qzd
 DKzrGevcv0/03zVF6QLIZb/7axqALJgnje4SehqiDV9ihO8Ngo0prYjPPP00nIxwM/aKkyg/7Z+
 pFubqbutnSYcTdKNdBaH+YVFvWwKT5eq0uaY18NrgU2liPjU3Ibbs2YZrWUHPBONwubZwwKI6JR
 GpjwFtg4Bolfc3Ri3xc51JIfGv8izwOcmzns6/A3a+1n1DHTx8A0VmMvl7oCHaoI0qjf5DBoumy
 1KfjDjzTWJeJ1U4OmjBCeNtH9kcBCTBTIGFnSz1rlrvqUa6jtGJdRjSvCxN0y6t1XFldTzEFOPj
 IajWpWpazGUSbxU+Y9w==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a214b01 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=V1jnuoLLAAAA:20
 a=uTRCLKPYAAAA:8 a=EUspDBNiAAAA:8 a=EVmsHFvQfC4jtDmeNssA:9
 a=yHXA93iunegOHmWoMUFd:22 a=T-agBWn15iSmxapsA1lH:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040095
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Fei Wu <wu.fei9@sanechips.com.cn>

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support and others.

This patch provides a new "riscv-server-ref" CPU to go along with the
future "riscv-server-ref" board.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 30dcdcfaae..a150acd151 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
+#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3f0f931335..c4a5a7f1cb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3315,6 +3315,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .profile = &RVA23S64,
+
+        .cfg.ext_zkr = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_sdext = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.43.0


