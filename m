Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C4CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHWp-0004ya-Rg; Mon, 28 Sep 2026 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVc-0004LD-W2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVY-0006kR-PZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHvfKS1457506
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E1XJr91Z9/W
 OpJPaYnmJllfqFKpVjckfx04k0/PB4bM=; b=BcL8AU1xOkxp1c7p7H9BhCC/hq+
 OeXWE1hDN4Tfmn4nojVdZD267JZqxAKaD26d8epubsCJsXYCtGYm6nq2ALEkRlPL
 7qlomrYAbAYq4NkAu1jwO+c4iu6HVoJwXIrh+N9VDqQFALC0hE0StCcdviykwdl5
 KBTsHSWuQO47TpjrjjpQZG9awSYuQ9/TvkLnekXYyZ9MHk1JJSjstzECBk1LwcZZ
 NjRb1RQVOswa3jXa7ElhK5cIW5f4SxZCoD62j2GPbGjTUR2h6hsKaxe4FxgyUfe/
 Caze/HEXwEt9HjE66OFeYxgR6jL/X4ZoVw5UWUEU9fEpgvlxQBV0Rkd944Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw20k26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530d028f779so40931851cf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790625566; x=1791230366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E1XJr91Z9/WOpJPaYnmJllfqFKpVjckfx04k0/PB4bM=;
 b=Cj4L1zOLGkU9/qwphIub5P8sGpIzaQ7JOvWI9QEryANaDUYCClDTa5JQL3ZuoTXNTJ
 RdnCcJZnxyRAvamaf8Yjj1hee/ZWBJ08bYhpnmoxd4YLMAAdVFh2NfzIjxvd86An0dri
 iskJ5gO/C/vCJHYAekXfii/wS3JeFiYS5qTRWqX0XQwCpyvXqCRrtnE7BQpOA+i63L/D
 yuPeFqbczb3qrSijVgB0VoHMx4IQCP4I1AKvlgN1tuNF6BmfPicgF8yAZQGaY0mrKmaG
 Gg99VOwFLW+EMKyRVQ9u00HRRGAL57atVQ2fQWeuorBARsoWrv/BGaC13ryqIhyp8/BB
 GrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790625566; x=1791230366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E1XJr91Z9/WOpJPaYnmJllfqFKpVjckfx04k0/PB4bM=;
 b=UT73NZ2MilLkMIcIguqHaRj/R39iBPd8IMOEGLBpANYV7qY0NJP3OjH09/SeofQJFv
 7cAtLBQg+pVchSwFz3+q+fgf5AhoG3cqlcKA29SH/JRIpcWO/3ppTIe+qeLPHXBGokl7
 e2GX3Cv3ngdW5z+BHtl+iScmF2nOg1AMzfwkgA9++MiL9vilbCoPv6wGylP+TYOOT4TQ
 jneNhwTuZlv/i/Wjjrcx2mESKJvqKnC5C3vAYPrHJmE726SR1gzaAL1WPwbdFmFx2EbW
 MmC/qjC+AkLij8jvkL35kjyL8I5bfJwhoautzS2AM/NQXS1tfSPXSrWS1e3sB7YNK9ex
 vFDg==
X-Gm-Message-State: AFuF++lcSp+eoZHROwUjCWx+4WiYiCBKGZKGxhUTI5Zm9mBUDCrxK91d
 oQ6EWeGzZpKb0pO6W2LnbimM6bDt+hM5Qnjug/DFQ2gkgMPdnUtZ8M/fIGbe4fGL1tp9XfeO8vO
 l2q7rAW+Znt99As5n6eoPMIi+U8ZT++FTJzwe7joaGyuV3SdqoBcLttWbehZoLgJWKA==
X-Gm-Gg: AYBFou0nhsvsdZjJJ+Da0upKChGgV+YeF7LvnNSuRwr9rqD1hF3d8Mimy0LBjkNJz9R
 6YjhlIC+ddYdE9LsHIN6wCflD7y80L/FWfkdemJRy97U6O+MRN/UORG3qXFQKftbW3g0Sx9rx5P
 qmC+VMsejTgX6nOHBMEWi0cy5eF+x6nY13Xx2kE/mK0xAjB/vy+tIcsY/8lcS93pHtLKJyCN+dS
 iiTk0/RoV5t++sLDlbEm3AvX9cU7i9M9KSxNIVnSboP1jX4ixP9oaiIanfiPw/EBwB9p1GOvNUJ
 aEINRZyTaaRQYZLN3OPgEi8JV+li8qQ4lxy/Bcd6BXIn9BeVde+0tBFjz2Utd5b+h6TkFabzBya
 hi4b9TWmiSEbutS9VGf4zsoxK35+BJeyDKFM=
X-Received: by 2002:a05:622a:5147:b0:533:42e0:a1ee with SMTP id
 d75a77b69052e-53342e0e0f7mr89126071cf.37.1790625566260; 
 Mon, 28 Sep 2026 12:59:26 -0700 (PDT)
X-Received: by 2002:a05:622a:5147:b0:533:42e0:a1ee with SMTP id
 d75a77b69052e-53342e0e0f7mr89125661cf.37.1790625565739; 
 Mon, 28 Sep 2026 12:59:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9143d0a64b9sm75905556d6.35.2026.09.28.12.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:59:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v10 6/7] target/riscv: add sdtrig trigger action=debug mode
Date: Mon, 28 Sep 2026 16:59:00 -0300
Message-ID: <20260928195902.2045235-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
References: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abac71f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=JF9118EUAAAA:8
 a=jq8im54kr7_wP6Zmv5cA:9 a=a_PwQJl-kcHnX1M80qC6:22 a=_Ge82aPy-h_wFa7gWU4u:22
 a=xVlTc564ipvMDusKsbsT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: QaRlJb146gvzhQHpQEDeed-fmK_czXaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX3zLP0XOx0tbd
 Acaa57pMeDLlhioQW764zFu6xWEN9v5CUXyAC4gk7CRpQiT4aNseKPmOAcz3YfAGu5wwy3NCKhF
 G/UVOpB3G1dODHB10j2ORcok+EV1jn3zE9mrDK4iHsMev9yZ7tpSV67UKvaIfEWbxamR0zSX1gt
 nEDRNHOcg+R6hBjIYAvzk1+15iJ3IanXZHSsYuKaQ2tchXqp4JGR4DvKBpvoRiE2zu3VPNgw/16
 A1rXIUMUA+bOmJAkzPPQyyAMeMlah19qYA86vat/JFzYsJoTOx8Q5nWwquXQB/CWPgsk7Cnh3BP
 Ump9h8VbIOYAosKFGGh5viE4W21njHm3FmBLYx4jT1Q+o8sV//yvhTMrO0pgWmuP4+13GhsFjP6
 do7IaU8kRrZ51pL1x05jsXP1LXKNRI8v9vjSzDa7IQ901uvX5wxRLHMDQ8HG5GP2kpYlqnDunQD
 GJZ6F9p2KKMKpWLZ7jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX6gK0xd/DujBy
 leSrZ/5sJBihE0vWLY238Q6C3p/9+8hOaboqzTV6xicuVxJNLsjnnVqbozwVQesR2VH+RaP+s0H
 PNmxwboYceET4+QkzfSNDSkRH369uvU=
X-Proofpoint-GUID: QaRlJb146gvzhQHpQEDeed-fmK_czXaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
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


