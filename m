Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722BBCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXecH-0000uf-K3; Thu, 11 Jun 2026 08:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXecF-0000tP-CR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXecD-0003Fd-5R
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCSlhf617027
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 00KbK1S1IWvvNGVuVqgP78jmaIapBz81rKm4LfL28IM=; b=hkRJGABfJwXf7WB4
 h3+IYPq/KPa2R6u0KkNkFARJrHHqA2l+oRXW4JSSSCVpJvdJ4PBxVkPVwf6rq+08
 fxYcOnCHyzow+LdgyEQl79qkdvMgVwb78tI+f5msydxoXhzgPUGCUYXEKFmmPWjA
 /xPDwy2bvlltmi7RU8l+XKhUAn2qVHs2moDGwe6O0f6osZ6I86yZ2jFYrW58FVMV
 ZIiZNmNPdw3BCwqh1bT6E0XyA09Cv5Qcp8uEYrelbMnHvitF9BJnV5CgBTMx4Ul3
 IXS7wgcqnORmhclbJU1dPy3Tl6MlBstlRe/YORv5heCPzx3/MSUxFNPpG16flZBM
 fK4X4A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tkdq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915c364ae3bso1061338785a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181270; x=1781786070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00KbK1S1IWvvNGVuVqgP78jmaIapBz81rKm4LfL28IM=;
 b=SV/0AheN398/NdlU57oYZM542ynzxl9FpwRQOw2pLgEQezuD7gFNP8BsFV//UozUCU
 ybVaEUyASI7z/TtjqsAojYqYwlParpL60ScOULXBXk+osJ03g3QVT/xSAeRJHZUNSwSH
 paNvL3wsTrusUCoharF1tGUumPrZPDoZfoUhRjxzMoPPcg6/t94vTLHIIPF4SSiyG/dW
 hSvN2zEyxmycWlGOhy403MHtJjD9hO7ifxC6NoAh6cdJcwLXwwBFw9Y7C079L4IdNHIn
 lWipf9eKfC27v+6ZucAl1l71WssYcS1pZehYBo2jWM6R7V/fGc9Msnph4L4o2lqIsna6
 vDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181270; x=1781786070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00KbK1S1IWvvNGVuVqgP78jmaIapBz81rKm4LfL28IM=;
 b=WrswBT/VO60WIK3LsU/LQdJTfyKrPzaXxlEKqTMJnDZV1d/YLVkfIOEbFE+vZg3v6l
 3Zvz1Jrz7ORxNgHgI9P6GstWiJkutH96m+jacn+gqRwVEC1QWmd/0gQAON5tdbD9S5xu
 y5QH3WJm2P+7qXraXd71ljZn93H4HYF59iadVdv/EBvibzrYzZpDkbhN/P6CXXZekDCI
 fW/tS1Eq1iG+sxvKmV2rL5TrA5TAXR2ihcv1wdpC6J4oLFw8rL6/U0W9prLjvqbA3f4F
 i2eftlXIPngIp1ru4fA1hY9bfnP1ec5f7h04Gs3T4m5E4b/IoUpdvBoG65EGRUB3Yans
 ATvA==
X-Gm-Message-State: AOJu0Yz7dNVxpWJ0N+xBvIuIYLdgLd3y9X6USAkkywbJexClcK5QVYOD
 QcTaTmLapAmj9OxejhO/CE/Pi26XWaP1wRVUHaszkK0KRYoF2bBwRh9+ebJVmGNX0n5Ee2tsEx0
 12G4I8dnkz8UDnG04QaJ4yr9SLkYtCPR2r2pD9/76MMQVeaF6BqsfAx9VPz4dLr167g==
X-Gm-Gg: Acq92OHbKf82KL4YMA819Mo61CSA2WK2Rdzxg7BO+sG8wtVqHtHNIWYsqrdmnh2rvEv
 Ixsfwyut0FqyHa4JxkLsHF5jTdDkUokP/t41Ovq/bxRsAEyf7tgzqSl9OQotWdUraAGYZszTIBJ
 4Y7UIwxK5VY5uRvei3G6Bt220LTTSTAv+HrUy6WbKjUpRvIkyj6n7Vfz68rEo01nQkk7bFITH10
 gpLXWaSYoXmDLQ2MZZzjrzuGYvnG13UNy9Q6YC9pk92nyPwN1MHV3wPGUKHtt/PvrN8RHCSTuJh
 iHKeLbZH1cc+640QebEZRQp79fDyipz8VmGSaBdFVKxv+VGVkSvShvMQrUe8DF4/Phzd1gygbuh
 hAkcLQ+bXQv3vaYJzyGWC0dY9yxrMtrycuFXIwbpjMFJN+GKZSal8f81tYkMNA1E3eQmIa/DTD5
 PkfRFbAQ2UTcBbs7pTzw==
X-Received: by 2002:a05:620a:1790:b0:915:f360:e97a with SMTP id
 af79cd13be357-9160ac95a91mr339557385a.1.1781181270400; 
 Thu, 11 Jun 2026 05:34:30 -0700 (PDT)
X-Received: by 2002:a05:620a:1790:b0:915:f360:e97a with SMTP id
 af79cd13be357-9160ac95a91mr339549885a.1.1781181269769; 
 Thu, 11 Jun 2026 05:34:29 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (201-26-7-9.dsl.telesp.net.br.
 [201.26.7.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160acd7904sm181042185a.21.2026.06.11.05.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:34:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 3/3] target/riscv: add 'num-triggers' debug property
Date: Thu, 11 Jun 2026 09:34:12 -0300
Message-ID: <20260611123412.2135600-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX5Tkh6ZTo8BYS
 tFo8N4e5iAArpIUSjqqU7/TPTDt8SGwHO7wdl97HQ+zpNugUh+LZlaoJ8dcSx0EWK6zI6HC6F9f
 9TX+hJwe8Y8nGJPPJjLvFb+/KnbL0lVHiRzbezWK3y6HaevW03tdsGyn77PJkOMe2LRMK5hhjK3
 22pxXh9jaf2F9F40DjouqZM61lRMK8balJ0Zkohxg47ah/tsK/i11MbyOGgZBKMd3DfP1U4favV
 hHmoNtpbG+3Yu+8jbWyIzjeIE+vVY09eqaHb0YRo14K1hZIw0NMjSMgeNwqQU5EnwwMoyhm2viO
 599kxFHtTmB/xlGO0sbYnr5O4KTzsxjBsPhHV+qyxN5TmkQmA7IDRZpx3UMOaQNaqXyQq/Flhvb
 CyBrpIXjLb0CZsnkETW5ohYIcfwLa1mH/vF93Tqs+D8qgrKQlkMWLbaWXwASBMMo9T0LeYpO2qo
 CLaN2U91WnydOHPQzng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX3J8SAB3cdrNp
 DxeGAF5NCQO4LIko1RzWhb9N/w/maYIYHNZBV1UO5H1/wGC/zfOmgLW3/dH819CP/oFFYT/ZlJ8
 F89dyfvzbVfOi58hzbal9GH4O2SKYh4=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2aab57 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MITIYaLR+oYcSln1dApPwg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PTs9gLp4gcwu7tsOPYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: WJKAx3KdY8o0aP4V4CU0lFp5lM2c1PSQ
X-Proofpoint-GUID: WJKAx3KdY8o0aP4V4CU0lFp5lM2c1PSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110125
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

All CPUs have the same amount of triggers: 2 triggers per hart, set via
RV_MAX_TRIGGERS.  This is not enough anymore: we'll have at least one
future CPU that will demand more triggers per hart when implementing the
RISC-V Server Ref Platform, requiring at least 11 triggers per hart.

Parametrize the trigger amount using a new 'num_triggers' property.  The
default amount is kept at 2 for backwards compatibility.  The new
maximum is bumped to a generous 1024 triggers per hart, which hopefully
will be enough for the foreseeable future.

The property can be set in two ways:

- a '.num_triggers' CPU definition flag, allowing CPUs to set a custom
  amount inside the CPU def in DEFINE_RISCV_CPU();
- a new 'num-triggers' user property.  The user property has a higher
  priority than an existing '.num_triggers' CPU def setting.

Assuming a hypothetical case where a CPU 'X' is defined with
'.num_triggers = 8':

- -cpu X,num-triggers=30 => num_triggers set to 30
- -cpu X (...)           => num_triggers set to 8

For a CPU that doesn't set '.num_triggers':

- -cpu rv64,num-triggers=30 => num_triggers set to 30
- -cpu rv64 (...)           => num_triggers set to 2

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c   | 11 +++++++++++
 target/riscv/cpu.h   | 19 ++++++++++++++++++-
 target/riscv/debug.c | 16 ++++++++--------
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b20271a220..6d8f9ad3a6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1167,6 +1167,11 @@ static void riscv_cpu_init(Object *obj)
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
     qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
                             "riscv.cpu.rnmi", RNMI_MAX);
+
+    if (mcc->def->num_triggers) {
+        env->num_triggers = mcc->def->num_triggers;
+    }
+
 #endif /* CONFIG_USER_ONLY */
 
     general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
@@ -2619,6 +2624,8 @@ static const Property riscv_cpu_properties[] = {
                        DEFAULT_RNMI_IRQVEC),
     DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
                        DEFAULT_RNMI_EXCPVEC),
+    DEFINE_PROP_UINT32("num-triggers", RISCVCPU, env.num_triggers,
+                       RV_DEFAULT_NUM_TRIGGERS),
 #endif
 
     DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, false),
@@ -2764,6 +2771,10 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
                 !valid_vm_1_10_32[mcc->def->cfg.max_satp_mode]) {
                 mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
             }
+
+            if (def->num_triggers) {
+                mcc->def->num_triggers = def->num_triggers;
+            }
 #endif
         }
         if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ea92e2c68c..38f02a9dc7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -189,7 +189,22 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #define RV_VLEN_MAX 1024
 #define RV_MAX_MHPMEVENTS 32
 #define RV_MAX_MHPMCOUNTERS 32
-#define RV_MAX_TRIGGERS 2
+
+/*
+ * The Debug 1.0 spec allows a humongous amount of triggers.  Section
+ * "Enumeration" says: "The above algorithm reads back tselect so that
+ * implementations which have 2^n triggers only need to implement n
+ * bits of tselect.".  tselect can have up to XLEN bits, so the max
+ * theoretical RV_MAX_TRIGGERS value is 2^XLEN.
+ *
+ * Allowing 2^XLEN triggers per hart is silly so we'll set a max to a
+ * modest 1024 triggers, which is way more than what we see current
+ * hardware use (most chips uses 2-4 triggers per hart, RISC-V Server
+ * Ref requires at least 11).  With a 1024 max per hart we'll be set
+ * for a long time ... hopefully.
+ */
+#define RV_MAX_TRIGGERS 1024
+#define RV_DEFAULT_NUM_TRIGGERS 2
 
 FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
@@ -576,6 +591,8 @@ typedef struct RISCVCPUDef {
     RISCVCPUConfig cfg;
     bool bare;
     const RISCVCSR *custom_csrs;
+    /* This is just a setter for env->num_triggers.  */
+    uint32_t num_triggers;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 9a4910c431..ba5bc6ae13 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "target/riscv/debug.h"
 #include "trace.h"
@@ -1049,14 +1050,13 @@ void riscv_trigger_realize(CPURISCVState *env)
 {
     int i;
 
-    /*
-     * Alloc env->tdata1/2/3, cpu_breakpoint, cpu_watchpoint and
-     * itrigger_timer dynamically.  This is overkill now
-     * given that they could be static arrays with RV_MAX_TRIGGERS
-     * but we'll parametrize the trigger number later, i.e. the
-     * array length won't be static.
-     */
-    env->num_triggers = RV_MAX_TRIGGERS;
+    if (env->num_triggers > RV_MAX_TRIGGERS) {
+        error_report(
+                "Invalid configuration: 'num-triggers' must be less than %u",
+                RV_MAX_TRIGGERS);
+        exit(1);
+    }
+
     env->tdata1 = g_new0(uint64_t, env->num_triggers);
     env->tdata2 = g_new0(uint64_t, env->num_triggers);
     env->tdata3 = g_new0(uint64_t, env->num_triggers);
-- 
2.43.0


