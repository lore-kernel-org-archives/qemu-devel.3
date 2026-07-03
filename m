Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A0C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHV-0001Pq-9I; Fri, 03 Jul 2026 14:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHS-0001Nu-66
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHO-0002CO-3q
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiQQ0530587
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2hVju+s1+n1Em/XHNrvkFJcoG265qiUdl//6HcY5Aow=; b=Y8XU+xC/wTN/0V6M
 lkqg8FWaH0yhiL1fgpchRHKF/Czs6C7xMVYmJQzgW5skaw3kvztFTkv87moFxdgN
 i0uIs+9GOo+nCBa8qmtqeMP6vl24n2MX+eYtD7skzaUrZcNwOa8c7VHXjsxSXIU/
 0uA4pkKP5u65L3rLh23SxevYjkv20EHAWVntYfwcqJ+KDTtEFv1p4IoRfkrTd1pd
 AjLGw6UhwKRbDdPL+GQaOXsgsOrDtG/LxM/0WEOtT1AWkPZGUxgZY2blvZGC38QW
 SuU0QnTGdhaCcOWYEqJ23oYzbcWjGTGusq0+YkkeQZnCAJ4dlH1afLVelVKoLggO
 C5jMbw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n3gse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso7209791cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101976; x=1783706776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hVju+s1+n1Em/XHNrvkFJcoG265qiUdl//6HcY5Aow=;
 b=M47v2M3YJKmPGzCSjQOARxc6uvFwgvejH8qMx7oKAaHiWQZ/o4MxaWtszn2VG5M3h7
 uNK9h4pWAR1W9r94DlEdD2UacfspF2avMMmmEzBKq28UodArQdijCzPGYSw5zzRZhGyQ
 +4w2xCFquPE89O7CrmVVxW4qyOxb55ChZtDBIA7MsOll/R6KdZldD7OJ1fyYIpMJWWmJ
 RSy1DqiFpTjj11FLcY71RVy77zhWEbxW6ucRfGJA0q/SaMlBAyjEqXd51jY6bI0XLjbU
 c4o5az3kx+iqngwC+McO55W/qbqYVhJRwb6CPDeF48kfOm8Jv1DdMXrOOjZjeS1ntw8D
 SiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101976; x=1783706776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hVju+s1+n1Em/XHNrvkFJcoG265qiUdl//6HcY5Aow=;
 b=GqRKRieljsPvl6/rTxdTA25SR8r7OO26Gf2l7o7zrqhAgS/IxjwYHsx3pBC/S+e7c+
 nHjl14fM2GlSfbju2WUztNeyeYY6YIjojsZqU9oGADA3K9tgp1JNHHtwsh3kGcaV3ZMt
 CVRlW3/Kww3Rta+febdDE1VIHsg6EWsZQj1fJkvShvcK/nnmIP8UTX2mUCkfTH6AuOor
 zUgcFSmfjt3+PglB7DVXkCnAoFJsBNDiybeS0rCNa3zaBTiXpiYaGM28F3WpuW4eYcdO
 zETr04W0HO/u33kdW/LZ9eusjk3pDTf4Z5DKyW1TQpIfCKbsM5ES/z/1tF6Vy7GuRrgk
 vCRw==
X-Gm-Message-State: AOJu0YyYRmEiXyzcwkN1B8rcyVo90H2Ljay4AQKTDHjNUB5tpXOyOWeY
 BcnKvPRLix+bY2+6SzvAzwNRbbSuEq3Irg/Pp78bUyGbltgRdHx8else2a8Oc0x4+ZyDMyDgLOK
 wyS1vgDMSqoYxduW91dtACj8NaVK+iJPmyB29yxwvHYp5f/Q+gJi2yFfcVkpRe/1HQQ==
X-Gm-Gg: AfdE7clJcHDoU2ZavWyg49NM0vD0JOVwOYmF9yJLVB0wyip7oS0c7hLzxo4qaU9sKjC
 eE73f5QKSh8oFjg585ah1XawFMYdWLDH2NHO2gUqg9QK+n/JaK+tDDlhmi75wfzNNwuKRZoPJRL
 3r0xhEwcZjlcw0TeL9VaF46OnopXVWAky3YTte4T9Yv1/oowN394yqlpRvqaBw2iFUZvKbuVhmd
 0oY4ekZ87fsRx8f3m8V8cJAdDv4Y2PcTaUL5W7naRztoPrq/NqWdeRU5RRBWBW5BICFTXkXZdE6
 WRtfoNvUakY6jBkVpGbx95s4JcoLwie5DpUR2ejhKymXUIIEnp+M8HRCIAI1riGKoVs6irsSi0w
 EyoAByfye4c11hQok4RQDN5sW4aIPE/lIOj/ypuBqevV0Wg==
X-Received: by 2002:a05:622a:986:b0:51c:ca9:7cdf with SMTP id
 d75a77b69052e-51c4d054c00mr2885191cf.2.1783101976195; 
 Fri, 03 Jul 2026 11:06:16 -0700 (PDT)
X-Received: by 2002:a05:622a:986:b0:51c:ca9:7cdf with SMTP id
 d75a77b69052e-51c4d054c00mr2884571cf.2.1783101975561; 
 Fri, 03 Jul 2026 11:06:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:15 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 11/24] target/riscv: move custom_csrs logic to tcg-cpu.c
Date: Fri,  3 Jul 2026 15:05:23 -0300
Message-ID: <20260703180538.3346781-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX3J6LhuHuoS2A
 PQUoAeXom1jATa9sOg1FCyqrYxI041EYGp/owjguE/ziOqK7qyBJE75QNYAxT766eQMvtaBuHUz
 1MOWqrbc2xdWMdy4qc761y1iLuLszAo=
X-Proofpoint-ORIG-GUID: m18coPAV4suhMlskac54B41zSyp1xumq
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47fa19 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pNhwjiGmTFK0dS8zIOEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: m18coPAV4suhMlskac54B41zSyp1xumq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXwlDK5GPbyI81
 07AXl58tYamyRId3sTZdDxvKGdx8q4oGiehJq1vFOT7/yPg7gSAaWcR8WSZMvo9QfdzAObw/bf2
 CT5kvF8QHBqMg5hgi+/c4U+9oKRdITQ+xcQITqQMGDgLFUP2Cqc2fE6KpeRGUrZU9jAAxqFm5fH
 BJCN1BxK5G8VwUqItpXTn4qvX+YapEoIPEcdYacuhjnG5xqsbzXEbbpXDtFhTCzo9W2vDmitM71
 yNJCY2Xy8Jx3/NOPmBnJGkCRr6cIQxfENIXpZPbT572fkGz7+O72ESeROp6aerauGcfSNTPSVWs
 UIxXizCitl6Ha7ck+l86tB8zHkTGbCWBada1hAJBzH7QpB0OQmHDZa/yx2xZl3P8Kwt2Hyel6os
 znBA9NUClrzgOXnuvaQPWfxu2lsiNL4vRjnQ3PoImJob6D39HftKSAUVBkMqj4AjOmk6GkKEe9W
 xifN7OGS25XoYjq1Ggw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We have a couple of CPUs that has a set of custom CSRs that uses TCG
specific APIs.  Move the related code to tcg-cpu.c and do not set
.custom_csrs if we're not in a TCG build.

What we'll end up doing, sooner or later, is punting all these CPUs to
tcg-cpu.c since they're all TCG specific and KVM has nothing to do with
them.  Another time.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 26 +++++---------------------
 target/riscv/cpu.h         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c5b03847bf..bbce58ee58 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -544,19 +544,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -1268,11 +1255,6 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2846,10 +2828,12 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         if (def->custom_csrs) {
             assert(!mcc->def->custom_csrs);
             mcc->def->custom_csrs = def->custom_csrs;
         }
+#endif
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3202,7 +3186,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.mvendorid = THEAD_VENDOR_ID,
 
         .cfg.max_satp_mode = VM_1_10_SV39,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3248,7 +3232,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         .cfg.marchid = 0x8d143000,
         .cfg.mvendorid = THEAD_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3454,7 +3438,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = mips_csr_list,
 #endif
     ),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a8c7e21bec..82430ecec6 100644
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


