Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA37CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZq95-0006HU-54; Wed, 17 Jun 2026 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZq93-0006Gp-3j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:17:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZq8z-0002zk-B4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:17:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UhUa2219571
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I1vkX42dLPWzlx1/akBQJD0lpDlJlCiCwqb90advl6Y=; b=eLNGZ++XAAwfCKZ3
 8akkI0hqFPpTDwXtnsdD8ofkXNnNtMCW7BS2orU1tRll3xqbBuJZl4S4Bnea5xy1
 DlUlH/2Ijp6sf2gNNi0qvbcwfjQiSMH/+rKUXuMY0n7+wh7FhPxVgY79dK3UsN2R
 aX5Deu7OqIdClULALfyqX81/2z/VYe9uAHLOMtZJ/Za/xB5Yl5J56d6QgoyhPwos
 1C9Ne8OMYpQ/XrDn7vFt1aGBsOX3XYBUcZS8Y0i29wF5MDu7TIfP11IS390Zl5OZ
 9aVXkdLebVBb1QuM0beFm2/tX4xPPVuStCxLk9mXWm1aTqJhXuAA+puaPP/V706f
 khwRNA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerbb5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:17:24 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7ddd34a6336so97150137b3.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781702244; x=1782307044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1vkX42dLPWzlx1/akBQJD0lpDlJlCiCwqb90advl6Y=;
 b=bDjUpe1048cV3lloVA2lQbnkIWLgsBH9LgT2SBwPIl3N3OnDHEEL9ZzcHN7qnT8jH1
 UKotBhIwXB3gIjWclkkSJMxB0akYamh9Pj3EWRGr34MXDpiOgVHS/eO/dmh5sCet4iOJ
 XKZPnXtC2cVTkK4bM5eJF8xzfkl+Azj3VDILgqQCbFZ2KaKyQtwu/SH/OkbFMdPiaCR+
 PAzprDZQ8smFC6Lw1HmSWg5XQDOQl4o1/GtNNFDj0p46yOv/mrg/A+1jwpJrUdnQ/jq3
 kg6hFPnYzzo1gfCpS1tIoeCiQpostqM7tBVt7u//FFJEYvxpiY4fkM7+nkcg46Q3GffY
 7phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781702244; x=1782307044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1vkX42dLPWzlx1/akBQJD0lpDlJlCiCwqb90advl6Y=;
 b=k+lE/2ilys42caL4LJzmd2h3QzJ8Vexl65SYfKASeu1rBNJr4ZODSp/ocR/A3c3JbX
 KqZU9k+5Th0OSIoiDoDtTURueTa78+7OpZJ2aJ6X2XkRbAu1OAqZ+bzCjV2dhL6pySTz
 Da05a+2bCa4VTU4KGCafQXU71z/nyZnvA9KVZ504OXB54z6CvqMcBIAcO9tMc6V3vmV6
 Ri2v6AL8JrlXPc7vu9OakJiiyOAR2tO/U7UrQRkMPP0tgJUUkRF59NBkpOSBnUEqCi/o
 XZf6BZVebo48mom5gliZ1gQzlMLlm/jCmOuDrXlplQTNj2NteFfKt0L/vaahCTSbVZvn
 wa9g==
X-Gm-Message-State: AOJu0Yy+ZUOD1Q415mpzjgJUlx42UByW+H/KuJrm/ASz8G9HHCgrbZVe
 H+KOgqZvQxsQRQWHoJAldza4s5OE84/Ml/gkP+TW+FGaGmm2k+nsdK/4LpH1I/+/7ZrfUEJHOBF
 keXsqLCVI0rOd1bjFYyMuLDClqq1IrFB/LUjxc8D/B2n8d7qdlhxr7dXr/z8awPecgg==
X-Gm-Gg: AfdE7cnbTJ+s+zfXKNaWPLFxhHAze+Ivt5p8Fa8KAMZO2YA4AUm19lxTnGYRCLHTgrZ
 TNd3cLLScfDtLRSWkm7UnKvImEHwWt0VshI8dVxw6YH4g09n7ochF1xrO5BCTHcLVF4pUEBYM9F
 AEFhsuCoXO+EltxkqD15e2cyxuNw+1ICEdvGNDcyoK0tRkLl9OwMkYLO9/hqk7pgckm6UGuF5gF
 0GMTs1penVuke03cCwQ0LYEQvE5iOLnccKeAV/fR+WdSOEBAnHazobhup4mb7NvB8tesFGAwSsM
 uVF09D6RAQBzshrW3hY2r5TYxFL691a69bNwwS0lmaWVrSPU323eFHCv0+5nqNPlv18UIxVYjKG
 4yXdSs6DZbGJNS3tT+xzJqiHtWzSygAIfYTpPlDNyflpHyk6s
X-Received: by 2002:a05:690c:4d01:b0:7d1:c256:b5a8 with SMTP id
 00721157ae682-7fe5e39c0c8mr34761007b3.40.1781702243782; 
 Wed, 17 Jun 2026 06:17:23 -0700 (PDT)
X-Received: by 2002:a05:690c:4d01:b0:7d1:c256:b5a8 with SMTP id
 00721157ae682-7fe5e39c0c8mr34760357b3.40.1781702243163; 
 Wed, 17 Jun 2026 06:17:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd345a5fesm44861707b3.36.2026.06.17.06.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 06:17:22 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 3/3] target/riscv: add 'num-triggers' debug property
Date: Wed, 17 Jun 2026 10:17:10 -0300
Message-ID: <20260617131710.1855353-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
References: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEyNiBTYWx0ZWRfX8Uxh2smDxhI5
 MT5dX9v+fpz/M0VOzfyYoTAsrRyfascRUp+kCVmHXZXHOoMA6DRHXqrkPlt3F31U+lpClD4y+s3
 3O7mWKF8da3C0v80bEsEYZGwAT+TrDM=
X-Proofpoint-GUID: gMEGJvp_95mmvaRxNVAkiZ6pMoKt85N5
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a329e64 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=KJWeSTv_TiI39BqBT3cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEyNiBTYWx0ZWRfX6+lpgErarnoy
 hHMs1sdx70dgUcyErt8eF3WIHsb7VzBC60/ehha8BedMWWKTqYgkddvhjFzV9joBIr0EfhpZFoA
 rKoAQM9T4/Nss482zVIpREZWmiGIQMcxK9ulGMT/IWMn0qU+/FUXHp+RcVhiQpWkPBbVlxCKLql
 5m8lvFdptlW+RrvU9k8OsZdswMCgq0coGuJkRa5mgV3yZmhli51KR3pfqvMYty1xMV3G6fBboZW
 AfM41wJCzcbsw2Bf+2/+zQDFQ17s5+X1H2aYlbI0d3T2cBmF/9VvFXKkCPZCI8RrgCzzjKQZMGy
 STOoej1nbvHL/U52vEy+aC4millnxo94idjjjjhewwtScQJO6ZkDgdJCtDjay1qraIYYg7ahbpU
 ipFERRyC9G3dFCBNmgpt8lG82ehb4cMZEZ71LvgdfgLh5B9yGMIJqIBTB0j2WDm62OxjtCAdXsu
 0dgoovCiI/Gorx0zlog==
X-Proofpoint-ORIG-GUID: gMEGJvp_95mmvaRxNVAkiZ6pMoKt85N5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170126
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c   | 11 +++++++++++
 target/riscv/cpu.h   | 19 ++++++++++++++++++-
 target/riscv/debug.c | 16 ++++++++--------
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e7318fe9f9..e16608bbbe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1164,6 +1164,11 @@ static void riscv_cpu_init(Object *obj)
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
     qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
                             "riscv.cpu.rnmi", RNMI_MAX);
+
+    if (mcc->def->num_triggers) {
+        env->num_triggers = mcc->def->num_triggers;
+    }
+
 #endif /* CONFIG_USER_ONLY */
 
     cpu->user_options = g_hash_table_new(g_str_hash, g_str_equal);
@@ -2616,6 +2621,8 @@ static const Property riscv_cpu_properties[] = {
                        DEFAULT_RNMI_IRQVEC),
     DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
                        DEFAULT_RNMI_EXCPVEC),
+    DEFINE_PROP_UINT32("num-triggers", RISCVCPU, env.num_triggers,
+                       RV_DEFAULT_NUM_TRIGGERS),
 #endif
 
     DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, false),
@@ -2761,6 +2768,10 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
index af246a56ed..bdd28d329b 100644
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
@@ -577,6 +592,8 @@ typedef struct RISCVCPUDef {
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


