Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F10CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpy-0002Z6-Qm; Thu, 02 Jul 2026 09:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpv-0002Q9-5b
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHps-00086k-3y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0Zbg518963
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9lGD5GeHecb2OOSvUk0owk6VDTYeqc3BhhTyXlyS+eU=; b=Jxd7PI7AwguO/bAF
 QezDu0PFjcGpElkG/jHqMd58sFuc5GP1KSMOmrc3mnSP5/ZvHDjnTyb3B7ln9CO5
 jHdQLy4yBT82gsM4PLx7dzEgR7jBQZu6ll8A136UYTG/WapBws/JduHqSo2rW40e
 vGQadOo4Tg3e9u+hgq9LSYEnw5zXcBYjFsR1E+LReyeTDJObdQMSdQoSCV7g3spX
 /KlxvFKxx7ABEqxtTC29HLMZPjt6zCU2sEfsHkDRQmtgcvtqbRO09v/yaICyqs9I
 nsobq4iJbEZfh2CLkSFEOuBPwAKpv9+x/ceJIN01kelZhvuw6Axo7n7PRg7X9BP6
 iCDBzw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnp8eua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:01 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-738ffe90415so456673137.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000320; x=1783605120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lGD5GeHecb2OOSvUk0owk6VDTYeqc3BhhTyXlyS+eU=;
 b=bSMTooK7iSHoB8bhOWl+/keTp+QRyeNqZUfL01crExo8d4JuLaFWC6mybh0st0h6t6
 9zk8GTeOLSFKu5XQkTyYRh0v72tlNdSpiM8/B+tT8wk2SMLe7ZdjjuErdbcULOby4mzE
 DWaGIz4KTKDcBLvRzJcaCLCsw+MMH6roOmLyxsaROl2Xe1kNjIkdA0MYx7XRdr1t8hT4
 b7VJiiZHjHBnJs8cAow4a5horhSxiRNDkvFnlsVJ33w3p101sZQDnwYk8+m+7hEBjUCq
 6/h/Tm4dIFKipHBgJv2pZmTRtPEWnQgjWv3J7HTffEI17Dj8+NCJfreXaI/oaxpbvNS9
 g60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000320; x=1783605120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9lGD5GeHecb2OOSvUk0owk6VDTYeqc3BhhTyXlyS+eU=;
 b=odkUKpRYW+Px+HWYDvpoR72m8ziTJbf+S4myM1gKVE11Ykb2etqb7tjaOsZppvS6nw
 lPwxgLU4Ot1vizwioxqsT3kDYaZPPknwbHvMsj4o2XowRmpjZYGnkj/DTOhrUcsfQGUE
 XmTZicimWTiF/Z92pgWuTvKY5hlFb/VkqGQQZbWScpFiLyywUIFHEowtnhv0nja3ptHY
 jJljrudLiYMnN2wy84QjEGRqz2QroCByj8tOV7+PSDrOPw2rdUoyJIf0B3nKEebWDJ4k
 6l6NheEZinyW3xWPVBuV8ux2tPMdwNu8i9Ks2yge5fQocHR7MF50iKKuNw5asRrGbSiv
 LMeA==
X-Gm-Message-State: AOJu0YxYTmxy1HAkWvpl6azr/OlrA8c7kQOrMlJlw+xPunIKtTTDAhVk
 g/f0jMZCMpd+qL8IFHgq5OfqPMewMTNG2MB1ixZU6a0K+KcqnvWL8fJ7njIyGoT2XdZ5/uqu4Lw
 V2btprhX3NU8qmuAfsxU4Kjhn/mtgydyNSoSznHEG0G+JFSnrWM+kfURzyKkXXPWJ9Q==
X-Gm-Gg: AfdE7cmvIxaWxsYXq6fmV3NTdwx007qGlTvZEXhlzoOr3l4Uf2YCSQfxpteXa/Rm8I0
 +KecuUL26xeIBzWsi7lulw4ZjrP6UU/KkWCGqw+Edr+ZTI7EAvoOeyNFnGH9zGxr0i/HyZcFQ73
 EFAGi1Wyi67//W8dIFURt7jTD9WmFIbXK0Cfg2lQNKS2GgaKEQdDf6ptY9Q51zyQW60tbAdxhe2
 zKbWWcfGNJ+ICjRpsD/okdLj4e3HvZfm4EfOY1sGbbzkQItPlLIe9rTzOkNES4QibPWyKO2C4tA
 2F7Ix0PIVf1TWF35oz5Gc0I7ACHOWTakb0vCKHFT5oY9cnjU9bcmf0kFywe2WEaaJqheOK1y26e
 3mBdJWeh2L81PQsJQO+MJxbD8MviKu6sih8noH5LlLTyjuA==
X-Received: by 2002:a05:6102:374d:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-73dab0e668bmr2476555137.14.1783000320376; 
 Thu, 02 Jul 2026 06:52:00 -0700 (PDT)
X-Received: by 2002:a05:6102:374d:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-73dab0e668bmr2476540137.14.1783000319881; 
 Thu, 02 Jul 2026 06:51:59 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:59 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 10/24] target/riscv: move custom_csrs logic to tcg-cpu.c
Date: Thu,  2 Jul 2026 10:51:12 -0300
Message-ID: <20260702135128.1188021-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXwFyYy5vdcdm1
 A3OiSXaqKblW/aqlh0txmSxdjebx5gH7SmULMBis+HigM60wa8uEtUPzOjzg+V1Ba/3BScIf/lM
 55eK8DjYud8KOXOjeDxDCkQiUn9jXlQ=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a466d01 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pNhwjiGmTFK0dS8zIOEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX7GHUv3TX3x+C
 RoPYHub8V39kNTqZ3VjYKFWUWwh+vYkbwpxV4HAODeJDtdxhGnf5wby9vgIN0zzSe2ar9LVcF8V
 uIKbJHZDVLE5TuiXQJkceoFCpZWqw5MSwv42XOrNh61qOp/+/4ADyteWKKmx03DW0pHYyITUhZ6
 KuiQAuGLdy/edfqQ2VcHiYuTcP8shlh2gAwQz3ikVTaApkBcBENpQ0NMjFRGxHlsouDy2vC2qgN
 M0P70NwGUg4+8+XwgzSpQTaK9FxJwv60CZK8K8AHeRGsIg3UqnVxweFJZO60Hm0AM9KC0MkH0h2
 IKlNpR+Ne0tGbSBTKoNul8mkXr4UilDsLLVnH4bdaC2RVKEWVKqdXCnU2tsRVPvzF+9gHCfT1mg
 8+aNIjDRVaa3hKQukyy+FG8wV0kC+XTn/7vw9joDN4vtvkalTKAYbsu5E05Yg2lk3aI+alexDn1
 2MfRQA0LbmbKyzutmbQ==
X-Proofpoint-ORIG-GUID: 16so-FZAkJPRIGMrT7glNd9EfzqT1JYJ
X-Proofpoint-GUID: 16so-FZAkJPRIGMrT7glNd9EfzqT1JYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020144
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
index cc739e3f38..feff7e62e9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -531,19 +531,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -1255,11 +1242,6 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2833,10 +2815,12 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         if (def->custom_csrs) {
             assert(!mcc->def->custom_csrs);
             mcc->def->custom_csrs = def->custom_csrs;
         }
+#endif
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3189,7 +3173,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.mvendorid = THEAD_VENDOR_ID,
 
         .cfg.max_satp_mode = VM_1_10_SV39,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3235,7 +3219,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         .cfg.marchid = 0x8d143000,
         .cfg.mvendorid = THEAD_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3441,7 +3425,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


