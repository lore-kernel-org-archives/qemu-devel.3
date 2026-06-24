Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C27CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9E-0007Tk-44; Tue, 23 Jun 2026 20:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9C-0007SR-PR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB99-0003DN-Pa
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwnV4706731
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8CGENXBDENB0oBVBQujZCqmzhM2oRFjHKcfx/ZhXG40=; b=fFTKc/+K82I5e7UJ
 Bmompu8seLjbu+Pp8dKCDaq95mmpv231jPBpXg6mFXoqSBdgjElVbPgQtHH9PdAr
 Xs5KzE1VqZCvujIqM9bd2506uz2k0wxGtnNdYW3VDL5crbqaROvFDud8m04saKyk
 GEzmhMFZhYwKybaP/FggFGCVAkRkVoZSBnvPPwNdEfdo45Jy9bBfOU121PoVLGXp
 2Tw3RuCjB4hrB8+JAatUv8nzQvxO+EkTrryI9jMc9ivNgGEBGplEW7j977Qe7HEn
 /oEz/8oV3Il1SVDyZSr6nfL/AcCEEguRa67yLdb87SL8JZh1WOIJH9bhsYaLelnn
 q33lDQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29kta7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178fc89b2aso4759981cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259631; x=1782864431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CGENXBDENB0oBVBQujZCqmzhM2oRFjHKcfx/ZhXG40=;
 b=GfsABpWs8V9ZdoLVncMfE5oO0Fzg2Eqpogr6bRS8CggF4Zb/Apmu6EYzU1AGN2bZbN
 ElTGUbY0hFDaF+70Mf3JFYL9dWVo+VuD9hlRoKmhU944U0GpGLh1YUox+Djx+YQOcptd
 /jfM6vE4435mOrH/BTAOxPoKfqF5BjscGvAm6sGrmHYP40aejSGDhyusyYis0785J1VU
 3suue6Ng6o826paR0VDJzapBJDBuzAkL411eiu7tDAb0cuPd15idrqlXCyKqQSmdQ2SL
 Drw58Cp1IXSVPcPfzzHMkEYE1NBH8oBIDz4IGVLP8GpZ8zw0rz44/UcMCCzuyEetObc1
 lgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259631; x=1782864431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8CGENXBDENB0oBVBQujZCqmzhM2oRFjHKcfx/ZhXG40=;
 b=etbT5ZsFWDXdFzZMzmVdgE5CJLZewHEnoFs0B23fng1AMN5X5KNrAal9Hg+ytxLf6T
 GwiFYHC0Hcu+LHNRH7cdAfeXhis/wp8vPAn+TpUdJqK109kX1R1QHzGnST1ecsHsaFzq
 vPEoAU0zSKIU2DquftdaM72OsVJilT6viQr4LwKR+CPKsf6ZuHNMfLB3WBa41JaZcNtG
 709sZWeu1aYBxVKzKWLyfWLLfQAZFJy3DhX2B55L3dM1h4CnOmCwWnHQ3Vf6QHh7juIb
 PQG0wuL1zKYWQSMIsrqWS0o9mpuS8aLyMKfMR3ztZgHevULDHfJMPulDs2Fh5PuHKE92
 515A==
X-Gm-Message-State: AOJu0YxyN+YaGtzUlaOV//NzSQXdZ8Oe/ZWrdcy8dDX/UfSJEfu68lSK
 UQSZIDf6umHl1ZhAJEm387JanTJua+1VFTJCU/VtE/CViQqqDt0yj3ybDzryM0USebx90hCUG+Q
 4sCa9FnbolCOQaipmNOuKWShzhUBVPnq98lQBpNFErJFXAUr10SEQgjWMbC1o2ynsUg==
X-Gm-Gg: AfdE7ckRE3fn6PM2Y7RRI8hFliLmrUQzUGWjFx/ndUHHlbjHtb89E35/8LO7dUvEP24
 rEX3vDGXz2w3IrZkVfT5kmDuZZOf1rsStbkkRHAkFDZRGvfOKNmkFYQvUOoregeKgsSxB5H8GOx
 k8t07UrQbbR0/TZDCf6pAGWADE33b3c1VK/WzRLH2r/VODzNUoe/BEFxd6wrtlvS08zLkD8SO7o
 Bfwp4tVyNdHMQofyEoZRh/f9wvqna2KHTN3d+aZAbDmugw7Cw6C4x7iS0/pVdyA50YfYwJTVtp9
 4lODYhgOCNYmDc/BTMxIbD8wNvg01njoXNDO9eM3XvaS9LKs49fvVlqU0Jc3mCFgL1Tt3Yy1D0g
 bgPxT7aDgM/coaAfbP/4ZILbKu1SHikZSKMKC+FoyTO0NTg==
X-Received: by 2002:a05:622a:6082:b0:519:f2bb:1036 with SMTP id
 d75a77b69052e-51a61ba8cdamr20872071cf.36.1782259631059; 
 Tue, 23 Jun 2026 17:07:11 -0700 (PDT)
X-Received: by 2002:a05:622a:6082:b0:519:f2bb:1036 with SMTP id
 d75a77b69052e-51a61ba8cdamr20871561cf.36.1782259630648; 
 Tue, 23 Jun 2026 17:07:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:09 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 10/24] target/riscv: move custom_csrs logic to tcg-cpu.c
Date: Tue, 23 Jun 2026 21:06:17 -0300
Message-ID: <20260624000632.2149359-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3b1fb0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pNhwjiGmTFK0dS8zIOEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: RQ4dgZY-t88u7k_DIkSx9KLBacugM1cy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX7rjguRwEEhkl
 Y1oFIRRVQKF2cq4amnxbUDLBqhFSP7jHaMdXHMihVgImfJydU0qEq6uEZi+d++Dvu4XrXFJ3gUq
 9rewavhIRQ3ALjBKWplC3U9DAd752dA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXwBN54WZoIInf
 M0qUqP4QFXN6x8uYbC1RReTM4urm2rHwPDADcAMSq/kvVvVn3l433AiI954637Ra1nu2ESJ5Aay
 xKhT55MZMy5AFXb4nvKjdLpt/9r6Mi4GGWlMZp1/grQvWHGvoImN+LyaVsezXJMFqIzOsyzYtfQ
 pTUtMOrJyYo9XnVEA4aDjPQlEzeIzUP9BWue5NoGEnexWIcnUx1Lmzkk261d9tGR+u6NPIRtasi
 W8wMQ7eZ+aZFNXyDHHApC6rZy+9zFrK817BqLPdNSxpBOQ++SBTAmtZPuymPcP85CQekCSbCZ7a
 irsLWcokTNFVnoijlwXeWyQfGKnni0b5SzLc/zqRJC+CnU7pttdT7/KTpGafBGfjZBqbhjJnHT6
 Y8OK1ZPoNIH9L9o0I6QjfBJ465T1jg==
X-Proofpoint-ORIG-GUID: RQ4dgZY-t88u7k_DIkSx9KLBacugM1cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We have a couple of CPUs that has a set of custom CSRs that uses TCG
specific APIs.  Move the related code to tcg-cpu.c and do not set
.custom_csrs if we're not in a TCG build.

What we'll end up doing, sooner or later, is punting all these CPUs to
tcg-cpu.c since they're all TCG specific and KVM has nothing to do with
them.  Another time.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 26 +++++---------------------
 target/riscv/cpu.h         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 96c92de2ee..5e951ea19c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -524,19 +524,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
-static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
-{
-    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
-        int csrno = csr_list[i].csrno;
-        const riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
-        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cpu)) {
-            riscv_set_csr_ops(csrno, csr_ops);
-        }
-    }
-}
-#endif
-
 /* Used by csr.c and the KVM driver */
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask)
@@ -1244,11 +1231,6 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
         cpu->env.vext_ver = mcc->def->vext_spec;
     }
-#ifndef CONFIG_USER_ONLY
-    if (mcc->def->custom_csrs) {
-        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
-    }
-#endif
 
     accel_cpu_instance_init(CPU(obj));
 }
@@ -2822,10 +2804,12 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         if (def->custom_csrs) {
             assert(!mcc->def->custom_csrs);
             mcc->def->custom_csrs = def->custom_csrs;
         }
+#endif
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3178,7 +3162,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.mvendorid = THEAD_VENDOR_ID,
 
         .cfg.max_satp_mode = VM_1_10_SV39,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3224,7 +3208,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         .cfg.marchid = 0x8d143000,
         .cfg.mvendorid = THEAD_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3429,7 +3413,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = mips_csr_list,
 #endif
     ),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c0e9098728..34c63a3628 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -591,7 +591,9 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     const RISCVCSR *custom_csrs;
+#endif
     /* This is just a setter for env->num_triggers.  */
     uint32_t num_triggers;
 } RISCVCPUDef;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fe6350f497..fef66557c2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -38,6 +38,7 @@
 #include "system/tcg.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
+#include "target/riscv/tcg/csr.h"
 #endif
 
 /* Hash that stores user set extensions */
@@ -1650,10 +1651,30 @@ static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
 }
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
+{
+    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
+        int csrno = csr_list[i].csrno;
+        const riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
+        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cpu)) {
+            riscv_set_csr_ops(csrno, csr_ops);
+        }
+    }
+}
+#endif
+
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
+#ifndef CONFIG_USER_ONLY
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
+
+    if (mcc->def->custom_csrs) {
+        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
+    }
+#endif
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-- 
2.43.0


