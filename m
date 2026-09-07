Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D4AC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XoQ-0002sa-Pd; Mon, 07 Sep 2026 07:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3XoG-0002kQ-Up
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3XoD-0003GO-M6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvPjl496297
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=agsb+31+gBT
 rXzGhEiv94ST7wrQa2woGkjbFulwC/V4=; b=L/Pt6BmR+X4FieKjpHs3HPZg8ln
 +CmIY1rdEBuj7K8FcXs8eFtzDi4eV7TZy320CqneeDiSI75x+kBfCSbfb+Ji5Y1a
 byKICAcev9ZIPApNr0tXeOhjVCeRg9YWzbTvUQrbGrEYu82T3/n+7qSw44OISSxa
 OZuoRaDwk07MbrYUXDUR1IObhLStcTPDTBjyQ2Rtnk4bBeed9yNywyTmmU6e3irI
 eyZYc7vnJWBU+hArIpGznpJjiyLfAHcVYUapAmSM4HZci0Pw7E7jmzvnfkk584ON
 JuCwEINnU0LWXaLvar5ItbQuF7i9a/akVSwO3lwESX2DRXw4/igHg8WxsBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk853f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-530256c61b4so62608101cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781600; x=1789386400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=agsb+31+gBTrXzGhEiv94ST7wrQa2woGkjbFulwC/V4=;
 b=E34RoUzkhrEw/vMLifp80ybBNk0RQMKnfSvQ0LE/FhgGMroKKWvaOZ0a6SjvxdkqWR
 6sCmpI2g26wH2C1GSRUakTTWvBjg5JMdmJgV3mkG6yhSJWwiKesGbwOhw1EzxMRoQUd4
 aeY8aJeOFAU12b0+F3O0CU60os/2JHjXDwIR69wea508FgiyJftoHnmbBCE19M7rC7GQ
 zxb9KbB4NIh12cULVz1RsFC5pDAMiDhHVOev/XsRq9ppwMQ/ydogoyJUjpRR3Ajp5BWC
 SMzeJJ2mBi1DPWq2Ad2UzLRYMGMLU+WaxDlWEQEeQeAubEQCZNwSNVNQ+ERJpPzkzDu2
 P/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781600; x=1789386400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=agsb+31+gBTrXzGhEiv94ST7wrQa2woGkjbFulwC/V4=;
 b=Ymdi4tWVly4f4sNCN96ZNNxcGZ7ZgPECAnMswzSZcnfTSodIqhgCfjvmf8xLHtkeDn
 eaHCEnLW9uK/JcSY7nPaUkmIQsoLxf13Tw7Om9huC7v52Si9wpyCwAjN/T4Rbfd8jFs4
 fkH/oEpaYTkivufWeHzJ6IaUoimak2CntgPneXV0daK8oq+eUt+szYyf8281WMRyI8Oh
 BqPvDiXDArpuIvVM/2CZsgrI9ovypfN3alb6u9lFR1CcaRzehvsuVZpNL49jbDWZGbjk
 hsbpjU+PCZh7VqBDlQ8WyAJmAUl14L7jLR3OrSFYsDE1BNIksU/ANOATlTmYriCiybdB
 Q7YQ==
X-Gm-Message-State: AFuF++nYFbvQVcr74PG0XJ2OMzecSJ7tkDZP2911Bt6lh8UzvDE3ek7r
 7DKSfxPdJ97ENtNkuBxkvUHFDnnyMvGn8mQwzl+h0zeUXREfYkVp7PnCTn+Z1R4E6/bGCWqruBT
 wLeueKnHiLtH+mQRC2O0GgBke1kr1nMe83L1/6CD1oa+pC3C5LS/0O0pk/J9Fjii/nw==
X-Gm-Gg: AYBFou0uW6/fqYk483HfLKVNSsAsCfGSWKvp8IiUfELdK4Iz/wbbf9exX5zGBzp8mXB
 9GndHm5OzCcKQ6BBl+FCBHwlCCfvyqvlqRfcgMae8jiFB5IoOzEEfuR2cN2ii/3E6AZHT4R/VU8
 FC8OGN0IKwQwqPi2/sd7p6/B/l2UmqKzVA/PJzXyffAE+HG9xOJ1U8ALYGgLtrN9MEfjPuIGkpN
 tkipTpe3AH2CAeIcRq11O4vtHHRu1VnLLFYtFnN3HfUoiVZo92lLWniyLc88WsGyTOVdZ91CMfG
 omwmAM4IEPWnY/NyCiZPzASHShgLCX7zplMCbwzzXPs8eGjr1wXMEZQHTnnOuQnmACUDpV2vw/9
 Q5gHvDUiKVUXgXddEf3ax26D5/HmvlJFiYLng
X-Received: by 2002:a05:622a:17cb:b0:52f:a0b3:bcb9 with SMTP id
 d75a77b69052e-530546cfd29mr225688111cf.10.1788781600351; 
 Mon, 07 Sep 2026 04:46:40 -0700 (PDT)
X-Received: by 2002:a05:622a:17cb:b0:52f:a0b3:bcb9 with SMTP id
 d75a77b69052e-530546cfd29mr225687701cf.10.1788781599892; 
 Mon, 07 Sep 2026 04:46:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:39 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 6/7] target/riscv: add sdtrig trigger action=debug mode
Date: Mon,  7 Sep 2026 08:46:13 -0300
Message-ID: <20260907114615.1609913-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
References: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX4JitsXKFXa8Y
 on1c9WpDfteEUi6uKZ1cKeDzxqWE76QzbKVbl+fkw9SiTaoxk6IVb3pA5aPwF0elWMjEgnedELT
 cN47vmjlKs00ERllxnFXsbht3dNhg9Q=
X-Proofpoint-GUID: -i3MtNASy9H7x7HUBy896rgsI7vg6p9G
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9ea421 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=jq8im54kr7_wP6Zmv5cA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: -i3MtNASy9H7x7HUBy896rgsI7vg6p9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX0crn2lyfAGGl
 LTAOZDeQfNke84Zb34F+JaC7j+oqmh4E9yXBwzRVDTmYcev/npp16bsor8dvt+c67kWeTZnx32N
 848m+v+qpdDYxaacfoEor4F/Q/O2h6r1N6qpSw+avQF/pTadK6FbzwCKRTBFRKL8BcNVuD1tdyA
 UyMJDKUSBH4QNB4mGKt8gyIHGxW8L1oJqzVh3hW9td7t7t1RMjETz10GJw+GFOoXzLIxYLdpCnv
 +YK7U7tLPKLWTqSwqPc6LU5HuhBz9xoU6bL6nLBYvhd5uXvpL/IMbBcokeU22o1tSBpkxgPCcyX
 qWydNS0eOAiPhdLWXSxIWETfi3N57cNCtziPPDOJmAyMTR8sTKShKy8/KKGTD4J+Xb/wtzdoSzS
 4+Ul9S1TFCeiYuI+ayt9SfnM22WQkJ0iyCgMjLTqHkQLRE7tV/vZaE/I3g1OQJDj/TxYRhjrXYS
 dZslr6LQjLNk4ELoE8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Allow mcontrol/mcontrol6 action=1 when Sdext is enabled. When such a
trigger hits, enter Debug Mode with cause=trigger and stop with
EXCP_DEBUG.

Also report inst-count triggers in tinfo and read their action field.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 2537515f54..aaf2dca17e 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -34,6 +34,7 @@
 #include "exec/watchpoint.h"
 #include "system/cpu-timers.h"
 #include "exec/icount.h"
+#include "accel/tcg/cpu-loop.h"
 
 /*
  * The following M-mode trigger CSRs are implemented:
@@ -117,6 +118,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
+        action = tdata1 & ITRIGGER_ACTION;
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
@@ -287,6 +290,7 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
 
 static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
+    CPUState *cs = env_cpu(env);
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
     switch (action) {
@@ -296,6 +300,21 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
         riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         break;
     case DBG_ACTION_DBG_MODE:
+        if (!env_archcpu(env)->cfg.ext_sdext) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "trigger action=debug mode requires Sdext\n");
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
+        }
+        riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_TRIGGER);
+        /*
+         * If this came from the Trigger Module's CPU breakpoint/watchpoint,
+         * we're already returning via EXCP_DEBUG. Otherwise, stop now.
+         */
+        if (cs->exception_index != EXCP_DEBUG) {
+            cs->exception_index = EXCP_DEBUG;
+            cpu_loop_exit_restore(cs, GETPC());
+        }
+        break;
     case DBG_ACTION_TRACE0:
     case DBG_ACTION_TRACE1:
     case DBG_ACTION_TRACE2:
@@ -448,6 +467,7 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
 {
     target_ulong val;
     uint32_t size;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH);
@@ -455,11 +475,25 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
     /* validate unimplemented (always zero) bits */
     warn_always_zero_bit(ctrl, TYPE2_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE2_CHAIN, "chain");
-    warn_always_zero_bit(ctrl, TYPE2_ACTION, "action");
     warn_always_zero_bit(ctrl, TYPE2_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE2_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE2_HIT, "hit");
 
+    action = (ctrl & TYPE2_ACTION) >> 12;
+    if (action == DBG_ACTION_BP) {
+        val |= ctrl & TYPE2_ACTION;
+    } else if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= ctrl & TYPE2_ACTION;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* validate size encoding */
     size = type2_breakpoint_size(env, ctrl);
     if (access_size[size] == -1) {
@@ -576,6 +610,7 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
 {
     target_ulong val;
     uint32_t size;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH6);
@@ -583,7 +618,6 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
     /* validate unimplemented (always zero) bits */
     warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
-    warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
     warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
 
@@ -593,6 +627,21 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
         warn_always_zero_bit(ctrl, TYPE6_TIMING_0_13, "timing");
     }
 
+    action = (ctrl & TYPE6_ACTION) >> 12;
+    if (action == DBG_ACTION_BP) {
+        val |= ctrl & TYPE6_ACTION;
+    } else if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= ctrl & TYPE6_ACTION;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* validate size encoding */
     size = extract32(ctrl, 16, 4);
     if (access_size[size] == -1) {
@@ -959,6 +1008,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
     target_ulong val = BIT(TRIGGER_TYPE_AD_MATCH) |
+                       BIT(TRIGGER_TYPE_INST_CNT) |
                        BIT(TRIGGER_TYPE_AD_MATCH6);
 
     if (debug_trigger_version_1_0(env)) {
-- 
2.43.0


