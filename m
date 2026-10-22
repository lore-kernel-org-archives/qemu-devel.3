Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA0606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mK75/xYy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J4T5H5l5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0o0-0002cV-40; Thu, 22 Oct 2026 17:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nt-0002Ls-ER
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nr-0000Ml-2d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtmEG388899
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ligiy4U/d6p
 aJvblZ8bFHm+L6m3y0e7ul/ewbUz1S+0=; b=mK75/xYyzWlVcVqQp0N0+40PVas
 2w/bEUYiBLCD0lft1BCxSBWjjKhFsiembi3RPGi/TSrhu5PzXGTmRm20GmBFU9e2
 SHRCFPNhqTM+RvGuMsUCwgJAzOoXdf0a4Q1De97TNhHXebuXf22StnqHaIdpE2Ga
 84Q/qgR7V3z43etFnGybecrUCeNheb9Fe5pt5wPdNaDwCXAZIza3400ju1IX+XmT
 uD3ub5C70/dMC6fyNd6aWx0o6dauXWC+FNLzRgUJs92rY6AZH5h+lp/rK1hXjOPo
 u/1pPZVgb3+oU6zlzm2gJ2F2d33Pm1UpJVKRZ0YXNBnxNL17W7HBU9BTD/g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc73895c7d5so271713a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706295; x=1793311095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ligiy4U/d6paJvblZ8bFHm+L6m3y0e7ul/ewbUz1S+0=;
 b=J4T5H5l5T4Z/SUWr52e0OjDYZ/7AGE6OdUXau6pRAmqHROATdJg59LJNult8iYd6fo
 wGfiFYdE6GlBo7gkjcj629h5H9g495xFWUImmOq8/gav9a5l+VLXlOSHrbh57nUST0+o
 KIXcevvmJs1NQjAsMm4ljXiZXwQ+uyALhc62sgmyoCuNqGCa3u0P2DPuBAIyrh9gHFz1
 +DlNsL8qEDMKZw42EnewEbO1vVkbJNNMi+Awahl3T8JWk7eSXIunpEEnD5/UDevUGRhi
 tnJID/2+v611xl5OlMd+h87y1iJTSiJ8YHhcI+SSd9qOQzlAMFx6k1+IgirTXJ/IPaXy
 SO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706295; x=1793311095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ligiy4U/d6paJvblZ8bFHm+L6m3y0e7ul/ewbUz1S+0=;
 b=FhQLoU22FTxIxxEyTn5VQfcnWJQRYUYmAJgR538NSo3IrMkqFeKxO46OfJ5jy+duIg
 HoY6cCJi92A3JAUP0PoUBZZ6Cw5MUcEz0POdAvzp+d6A7z0yr7bDwNyHx3x7WFaBu/lA
 GvF6n34yvB4HhwiunaP1nH251018Hmd/o5iySWVWkdytwA+8y5fze8w9rd2E0ToCLbVk
 x2fzi6EXgL4V2A8FhIZ0ctFVPYfgaFnBHAeTZjaxturc/VezWGjOCxhggVo5Il2hxevJ
 iD36AegmlAd/zG/lPJHy7O1n7mYOLY8wV6w2vhp7R06NVlAkLMsfGGCMEL6sQlgjF1cM
 b/nQ==
X-Gm-Message-State: AFq9FYJJcRXf+M5iDxspqr73rxcdeurVblZYq1ikuOpGgm3QqJsoa/vO
 I6Z66CrCvMGl8w30FEewVvkggPsBrsXu7Ba7DQJxogkmw8p+uMUwzSnbZPJD49BOzEWSq2ziQuU
 fzXKMJYXRaf/CTQtTc0mumvuNbiTuylVi7E0gMc25FYaA/CXP8XoooczWu+CUDURjJg==
X-Gm-Gg: AYBFou37mpXl7yJ1GtH2pz7UzeMEarE945Gk7Juyby3QtyZzEYkiZJzLaO18b+gjNnu
 4Koby9F1TTW69big8AoPXz/EAUWOHa2k1jcF4ettmLcolykd2Uwo0M18vQeRDsNsGSMew5Frdux
 AqN5ck/dKzV78w04I5dMDaHWgY7N11qMN6/sjehupdu/RBCxmgXfz+oWhYwT1OdtoWk7UsK+5JW
 3u6ahCgFsljyKLKoeH70sne3vSqb6CkcTYBHQ0w/HNgbayRSjbcFFYkHd+zC4e4NiQzXhZu5iEo
 hog14ZinVUlJ70YY3WS/ncHT3YWyUhUfq/LTe4Xr0NDqKesD334yRwEK8fXr1fmSVRn/lJ9Ie7S
 dO4AxtOylZc00AjHlJ4TrRcM+Wh9z6EGYyn8BlCWeQGq7iro+4EtQsEKw44+lxBA=
X-Received: by 2002:a17:90b:5868:b0:3ab:1285:dfd6 with SMTP id
 98e67ed59e1d1-3adce0ce013mr184782a91.38.1792706294937; 
 Thu, 22 Oct 2026 14:58:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5868:b0:3ab:1285:dfd6 with SMTP id
 98e67ed59e1d1-3adce0ce013mr184771a91.38.1792706294465; 
 Thu, 22 Oct 2026 14:58:14 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 27/27] qmp: reimplement qmp_query_cpu_model_expansion as a
 dispatcher function
Date: Thu, 22 Oct 2026 14:57:46 -0700
Message-ID: <20261022215747.2479440-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ARMcV22FD_xlPJBl7ToBz_v-FcM459bP
X-Proofpoint-ORIG-GUID: ARMcV22FD_xlPJBl7ToBz_v-FcM459bP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX26oymuBIBtOk
 0ofMuLKOGxV36buGAu3LbCUnBzVFAXeG+3cq502V/8mneYdJmNbE+Uy4iI2LGxwDEJzYck+TOoi
 USN9smVNduFa/NEBzULjxDJhgZCbtlg=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada86f8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=TponJfNvcDRDIxXhc9UA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX377Gs1ptRy6J
 Znxl0KnHEN6O50eCC7FC8aZII3v61oXbrWtf3F5dQYVL7R1t8DJMgEAtPeVWT/cZ0dGDDfYf1eA
 meeqVlsC/UdJVapygGKankGmR3DpW8QjbcQlSzw9xTNnDlMSEXuIJ5EOIhN9QTGAbQ5cJgJ/mQu
 FPy1JYPEHZyVLTSobcSJb3eyeWMKVb232WWeOsvomzmOdlw6RttQJD9FE56METbHxlnSa2PopZg
 pffvUSQffStJ1R16RmP0DXoi7LdRv45EWP3k1bGP+W2zSu3J92GfFRUyqFl2OagB3JdeH8B5Mw3
 0MbudrEf/NOYtOPIhZ4qnOWAkLVEa278EHqQgRTaT5494/IMYjUcHNB1uKALqw2ixS3IxHBgPsg
 DN8pUJOsdMPTZefNK/jpXkXRUFMajOdnFvIGt4j3ljXBsoGPeDT1lypYVeMGEm8u6NbhmTS969y
 Qdpz8iOfRKQYLlh8ylg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that we have per target implementations of this function, we simply
dispatch the call to relevant implementation.
This eliminates duplication of qmp_query_cpu_model_expansion symbol.

mips and ppc implementations were unsupported, so remove them and let
them be handled by default case of the dispatcher.

We need to define individual stubs for targets function since each
existing binary only has one variant defined. Stub mechanism works per
compilation unit, thus we need one file per symbol.

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261016162509.24854-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
 stubs/meson.build                     |  1 -
 stubs/qmp-cpu-arm.c                   |  8 ++++++++
 stubs/qmp-cpu-i386.c                  |  8 ++++++++
 stubs/qmp-cpu-loongarch.c             |  8 ++++++++
 stubs/qmp-cpu-riscv.c                 |  8 ++++++++
 stubs/qmp-cpu-s390x.c                 |  8 ++++++++
 stubs/qmp-cpu.c                       | 14 --------------
 target/arm/arm-qmp-cmds.c             |  8 --------
 target/i386/cpu-system.c              |  8 --------
 target/loongarch/loongarch-qmp-cmds.c |  8 --------
 target/mips/system/mips-qmp-cmds.c    |  9 ---------
 target/ppc/ppc-qmp-cmds.c             |  9 ---------
 target/riscv/riscv-qmp-cmds.c         |  8 --------
 target/s390x/cpu_models_system.c      |  8 --------
 15 files changed, 66 insertions(+), 73 deletions(-)
 delete mode 100644 stubs/qmp-cpu.c

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3fee45d568d..07a048d0a9e 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -125,6 +125,32 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     }
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_AARCH64:
+    case SYS_EMU_TARGET_ARM:
+        return qmp_query_arm_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return qmp_query_i386_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_LOONGARCH64:
+        return qmp_query_loongarch_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return qmp_query_riscv_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_S390X:
+        return qmp_query_s390x_cpu_model_expansion(type, model, errp);
+    default:
+        error_setg(errp,
+                   "CPU model expansion is not supported on this target");
+        return NULL;
+    }
+}
+
 MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
                                     Error **errp)
 {
diff --git a/stubs/meson.build b/stubs/meson.build
index 4a26f795a6a..744fb759a2f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,7 +84,6 @@ if have_system
   stub_ss.add(files('qmp-i386-sev.c'))
   stub_ss.add(files('qmp-i386-sgx.c'))
   stub_ss.add(files('qmp-i386-xen.c'))
-  stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-arm.c'))
   stub_ss.add(files('qmp-cpu-i386.c'))
   stub_ss.add(files('qmp-cpu-loongarch.c'))
diff --git a/stubs/qmp-cpu-arm.c b/stubs/qmp-cpu-arm.c
index 6249d7bde8d..0336508ac9a 100644
--- a/stubs/qmp-cpu-arm.c
+++ b/stubs/qmp-cpu-arm.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
+                                  CpuModelInfo *model,
+                                  Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-i386.c b/stubs/qmp-cpu-i386.c
index 4858951f8c2..f8a485c23ea 100644
--- a/stubs/qmp-cpu-i386.c
+++ b/stubs/qmp-cpu-i386.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
+                                   CpuModelInfo *model,
+                                   Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-loongarch.c b/stubs/qmp-cpu-loongarch.c
index 695b6558d7e..42231e816b0 100644
--- a/stubs/qmp-cpu-loongarch.c
+++ b/stubs/qmp-cpu-loongarch.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
+                                        CpuModelInfo *model,
+                                        Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-riscv.c b/stubs/qmp-cpu-riscv.c
index ce500ffa3f3..a448f060e22 100644
--- a/stubs/qmp-cpu-riscv.c
+++ b/stubs/qmp-cpu-riscv.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
index 4556072a226..e664ddd68dd 100644
--- a/stubs/qmp-cpu-s390x.c
+++ b/stubs/qmp-cpu-s390x.c
@@ -10,6 +10,14 @@ CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
     g_assert_not_reached();
 }
 
+CpuModelExpansionInfo *
+qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
+{
+    g_assert_not_reached();
+}
+
 CpuModelCompareInfo *
 qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
                                CpuModelInfo *infob,
diff --git a/stubs/qmp-cpu.c b/stubs/qmp-cpu.c
deleted file mode 100644
index ac185f09f2d..00000000000
--- a/stubs/qmp-cpu.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qapi/qapi-commands-machine.h"
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 2614aea258f..9d3a3d9aa47 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -203,14 +203,6 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_arm_cpu_model_expansion(type, model, errp);
-}
-
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index f85dc4a7036..c03cece7bd8 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -242,14 +242,6 @@ out:
     return ret;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_i386_cpu_model_expansion(type, model, errp);
-}
-
 void cpu_clear_apic_feature(CPUX86State *env)
 {
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 59f8069d8f2..99ccd47fce1 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -135,11 +135,3 @@ qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_loongarch_cpu_model_expansion(type, model, errp);
-}
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index ccbdbf8877a..66f70ddac68 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -13,15 +13,6 @@
 #include "system/qmp-cpu.h"
 #include "cpu.h"
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
-
 static void mips_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 1338233ee63..98ea8291cad 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -31,15 +31,6 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
-
 static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d60c6073bbe..4d94cd9b51f 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -227,11 +227,3 @@ qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_riscv_cpu_model_expansion(type, model, errp);
-}
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index ccfc918b383..5cf6469f0c2 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -260,14 +260,6 @@ qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_s390x_cpu_model_expansion(type, model, errp);
-}
-
 static void list_add_feat(const char *name, void *opaque)
 {
     strList **last = (strList **) opaque;
-- 
2.47.3


