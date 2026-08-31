Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E0BC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12ia-0003yK-MD; Mon, 31 Aug 2026 10:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iY-0003s4-UW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iW-0006gT-Pw
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBALx13862477
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uyIMjdORxSC
 dzJiND3iob1aQ/UfnM73aHaUyj+BBUnk=; b=TMScCV3hHF+lKJgAh3xrjolOf7e
 OqItHtmeCjIOj8Hi1AsfP4qTXuZjrT+655xkjbG2Pa9MZc9Vq2b54GjIAdg1JpuS
 rIfabZtYxlrCmf3QqNdyhr3OTC7GPM4IjZAmpKCrhgrMYovqaC9kKW6zhJAPMGnI
 I8TylF0+A5/q1za5/MkWKQ0yILNBxdsthwPO2B/jk3Sb05Bo9O6AE48lbE3PqKID
 y6FA4J8SjD2tXc3caGug+Fm3MSgGlUcb7oWOe/D2RpK2p/lxX+SWEQo6YOKTcbWE
 ww3EtNbs77NwOem9NbipMimTdCcMQPNfUGfxhDyqmaAFbBmNBPkm/EMDDJA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pm9ucq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:31 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6b34d7f21d0so1270025eaf.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185431; x=1788790231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uyIMjdORxSCdzJiND3iob1aQ/UfnM73aHaUyj+BBUnk=;
 b=GDaU/YaqlAVRoy+mcd14f2MQ9iyb9P0vc9lWm+hJZAWyXJ/BG++Lhwmam/ieFwvrvY
 ArKAcWSH81RyY+iJgadhftlR4AB8xrVop7KU8ob7Kz/HJMkuW8GMqcVM/pmLHbvw4HgG
 3jPnhF4CGy9JZteSmy61gFquPGGb9mVdiORyeJ6rl9ZoVEKlG/Qw0X0uUSeLjZszj7Ut
 cU7Wkcsls5i/4R4F1Kj8GQJ3HbFYC7jlcl3pJYGh3cNqcYvrmT/0Ew45tqL0ui8hW0Wp
 NQxui5kmtdtH28Sz6CepfXH5Dv7E7mzQ1pHp1EXPF3moY0a2ZYYVzIY9M4Gt7cJFF/n9
 4jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185431; x=1788790231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uyIMjdORxSCdzJiND3iob1aQ/UfnM73aHaUyj+BBUnk=;
 b=cawTbHaz4339H5rys+8/CrDnBOqqfjezFMeMBso6OBG75+C1bWHhV+I7UHG5bSXZzI
 ywg5JHjxv232jPlIt5+IcHca6o4e8YxOe/eVDNiw00aWJ/jdHIA5erWcgtB0d+fD8UNh
 jNrwVvCuUFXI4V9vkn/4NE9zaWBMZEicqp14tpRinuHxLKUdn8PN4mBy19zL5/n3fZ/D
 hDS7W0KINrIWclTyZ5l5KWtuNtsiSKDXm76Q72h+vxjDAikXD0PJMI3wN7EgoZ5dLdfi
 FaMwkKd7aS9XJ4scrOe46rpFbGt7IALdG1PVZJ7rC4/XoPF80V/9ko3QYtQRhLoiOiSB
 /C3w==
X-Gm-Message-State: AFuF++m9HrIXL399HG2nxlaDOFfBA5ftNH4C1ratIUTNTSm366J6ha1v
 0LvijCktYPmKXBrmcebTOOdlTO8qq9FVKW6315qeRasKljMl7dNXPKQir1WWXiTCsA4rIlE8Sic
 1ooVzlTrmdscVZLyOJ5AmKylNe9wqbMGg9gD92awRcpjaXS4uqnTjsxCpJN4XV7faCQ==
X-Gm-Gg: AR+sD11z/rPp3f1U8mFCbximpByYQR//9+dZEtHU9l6xTsH4GuyFqS00nBLQgdxhawi
 20eisyuGj/AXWKpvqUyH0/KuQQVASMPL/rUhceSAzPs9El7C1Qs3eUGQ+XF9+g1QmaSDTztNcIu
 A1L9R4QCgUtfNtHDaGq+AZ3DbKajCxH1lG02+t+RNifOQSDRMA28vcgrAykwjm/yX9Dd1oazx1E
 YpXSJzRdbFmiX88xFqjsa0D5bM+jMO1wT0vh0ZstZOmZYh1jCIs8avF4r/ML2EC2naEfeH5f5g/
 gs/cK9qlhO3xi17S8abiLWPT2giDpyS/DRoDCRengFPrLIXWdGtNPSDrDW6J/q9ZQG3aChOnFG5
 bZ0yeAdKB7qsXECFZ2irXhoWxlx8tdNH2gZnRrQ==
X-Received: by 2002:a4a:e84b:0:b0:6ac:b1ae:6ce3 with SMTP id
 006d021491bc7-6b1c66f1945mr24425031eaf.32.1788185431066; 
 Mon, 31 Aug 2026 07:10:31 -0700 (PDT)
X-Received: by 2002:a4a:e84b:0:b0:6ac:b1ae:6ce3 with SMTP id
 006d021491bc7-6b1c66f1945mr24424957eaf.32.1788185430616; 
 Mon, 31 Aug 2026 07:10:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 6/7] target/riscv: add sdtrig trigger action=debug mode
Date: Mon, 31 Aug 2026 11:10:05 -0300
Message-ID: <20260831141007.353854-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4u4yCdtJfokmYCIYHWkRjwNIE6O5sWaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXyYMokBTvEE5o
 9B4IGkXbLL0EBYZ7WhrWMpzPBIdE5bE79E7z21tFYjbHQOIuP5/iFGkHlcP1dccuycFFIatnRpD
 BKVKor3Be+l3HgxMjEQ6x13XnKHIrsQBEi83wi/R0SshXa3o17qevzCWYltsfz00cBjGmspp69X
 0Odc27Ymr9VqBKjMoHvHDPN48vJXASyuy00ix94hY+fwK2tou3fzqHDxZcYZy8uJod5nDyWAJOX
 SZt5a06NRM1PagOMZNgHDSo0OaicB0yADVgC0H0JwvAu0zkecFBYW/nA7sNbEBAKlIXy6FK13w/
 XALvTqqvS45iGQ6IUjyNHwygw8DIqedsnS3xRgRzki66UJT4e9AXW6C4OSGyHcOpLJOIVxNeJEv
 +ns82pDa7mKg9SwmyQpg0B/RMAFUb0BQ8jduLV1AyBlRqjGFFXHOXonEiQtQlzzgtaFgCbe/aGy
 6dbB1E/WzTpZsbGdEXg==
X-Proofpoint-GUID: 4u4yCdtJfokmYCIYHWkRjwNIE6O5sWaM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX9V9gQo6f2h/y
 LWzRoCnDtLNNaMFpvtHY4KVPhTUo69HNk23KlgB+PKNPFN1OXyde9zGgDH0cE16tMQcd3fVsKl4
 UwkGFhll1lhOUktxxdBcOa6VAe99yvc=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a958b57 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=jq8im54kr7_wP6Zmv5cA:9
 a=k4UEASGLJojhI9HsvVT1:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
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
---
 target/riscv/tcg/debug.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 5ab69bdc8e..44399a5d53 100644
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
@@ -958,6 +1007,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
     target_ulong val = BIT(TRIGGER_TYPE_AD_MATCH) |
+                       BIT(TRIGGER_TYPE_INST_CNT) |
                        BIT(TRIGGER_TYPE_AD_MATCH6);
 
     if (debug_trigger_version_1_0(env)) {
-- 
2.43.0


