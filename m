Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D02606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=debfWmoq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZDYLBUTy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8TE-0007Cb-0X; Wed, 11 Nov 2026 08:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xR8T7-0007Bf-BD
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:34:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xR8T4-0003W1-UK
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:34:29 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZEji2001872
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7d+r/tZvhHA
 MLWehqosyCq7mdTcvGc3EMzY/E+wk2qo=; b=debfWmoqhycdOokb5HkvUZBG3ZQ
 QU6LZr3hnxVJpaLlrBAlVmyeso9Piw6AcS0jrVALSE739ywliSKsOsTGLXuM2zEp
 v+9xU3GeXw9tAj3sabChZlQizDMwSH3dzUDLv/INJNWvgWKr+qgFsHlCgjMjzwuG
 q9zolmqAlaR4CTVfLr5Lt3ceqqQtbif2wOKD/aIs4FjrnKW0Y7PGYm2NWXCwtUuv
 3F1xCRLr4QfAylsqdj6IUBrUB01tQwX3edt+9UJB8K4mpD+KClv8C4qGgYDXL5Jr
 n4N6XwxE+ZmiCsqlxi5tUugKntKXZqFfYerAlToh1c23gOWqYrqG7nDcGEg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh2u63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:34:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6202980eec.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794404065; x=1795008865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7d+r/tZvhHAMLWehqosyCq7mdTcvGc3EMzY/E+wk2qo=;
 b=ZDYLBUTyy4Nks03pyqs/Y8JCIwxoHFbzMLpZXKMmfr8LCo6Ws/14N2EobX8l5c5fvJ
 J3p/Yo5SC1fhSzxLHXdYjAuVkjlvZjkoz+HOrLvr+oM6VPCTKZwB71Hp4osT6FKgpq5U
 lF586v9xSj8CmGoShM2+sZf+mUjKX+G6T7FYtgZ5R602ck0feY+zLAh9od3coBTY1xzF
 c9ahUx1VarhsCtP69PM2gJnW29SMqkhbNKqR9eIJiLOE3LoClKg20OOGgw0fpfbF1A1V
 6dKIlZ8KUl1KCtKUnyx4rEMWG8FD7NPuY4Rf43p7qoMdOGSi3csfK8BI7IhoB0Xl6Y2T
 aF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404065; x=1795008865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7d+r/tZvhHAMLWehqosyCq7mdTcvGc3EMzY/E+wk2qo=;
 b=nMLSGEcSd18h/KaTvkfo+jPpm794GvSvp7vlsckbPZs7OdfLZceOCLodYpHoGZU8XX
 NdF50+NoNdw/YcirYMhvNLMhfqNi/3WlCxG5Ui1XC6SQihVrB6zCz2PzfvmrxC/3dgRd
 FtKqp+ObrHXp59YjLcjpol9+qhkSk5MldPXydIpozNw0vxcSHg9FqHAhIRR8xKo3oWKm
 w7G513PaHSDg3JuK5fH6nKKBFF7KJ+V5iy9+ir0VIQTAjJbVXYr+4TWSPxSQ96xrRMfd
 KB6wviNTXMuMXjVMA+zAceYlKcJhwArKG5Gl/MG+USnMltSN9n5BRdarnJDqKsfVXrFQ
 /rEg==
X-Gm-Message-State: APuU4Z+QpLeay1LhgR9WQRILtivqxFCssia+4DBhs+lzOKqibTtXyBrR
 HqgVDBOtePTPvNQQ7yFJgcTJzdPGXetnZV5y5hj04IshOrqKOtD+FIYoaZIkWX/DBREpBUVm7TD
 lLoTWmsrdTLCOdK4GmEgjzatLMnlDkDdWnp9XCIypgqvYhhrzKdfWP5EKD0PCkaFXJg==
X-Gm-Gg: AYBFou3ndonRPXvhuIlnjrjoYBrx8IwPZ9vd/fzBlkrsN0FKFh+KrCcAIShf39RXHAL
 TDGzYDOgzAspbC440RfyIQ5/67j+fcfKTBCm5fJ7xKS19nMqb5BZpkVG1YDhYgktqrBzOLzjW4D
 y0rlj6CJ8g7N26iTJUFNwTfr2yjDqoPhlm6lfouBt07jwhB1c5nCLDIirTTRDCnsQLNDa9YJvv8
 XNrGvTf4E9Zes3rATOxVOqAN5eXbn+HaTwi56VEkPzbuww48LseHnjsAwZX57StenalvoMjWeLb
 okPdNwUA0Uj4nyuRj3r0AmtGUPugWv3h3fcd75AsvBT0Zu+0HLN2ECv8WxE9R4z2qrnKEN31ixD
 h51gg152yE9HnevPARQDzvHUGe/i1twGwG6hQnxa7WDjnZTXGuSeSO7a5s8Sn6pgahlbCF9Eqt+
 sZtW2c+M1lPIhFSge+XKSUpHCT+Dh4+eqf1ovAG8HrjdgU8FQIq15ZzEwyKbUlJHZSw6DIM558
X-Received: by 2002:a05:7301:619a:10b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37685d72791mr2912624eec.26.1794404063543; 
 Wed, 11 Nov 2026 05:34:23 -0800 (PST)
X-Received: by 2002:a05:7301:619a:10b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37685d72791mr2912592eec.26.1794404062749; 
 Wed, 11 Nov 2026 05:34:22 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520cfdfc6sm18350810eec.17.2026.11.11.05.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:34:22 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v2 1/1] target/riscv: Fix icount trigger exception PC
Date: Wed, 11 Nov 2026 19:04:11 +0530
Message-ID: <20261111133411.1922854-2-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111133411.1922854-1-himanshu.chauhan@oss.qualcomm.com>
References: <20261111133411.1922854-1-himanshu.chauhan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXxWgxeTMmDQ89
 8JEDy+14fQCL/uaUuavSCxFc1cZiKpD8lgCCRAfjN1moQlFap2erh/zmm/p77oCCaLZOAv5EUUA
 dKZcKNruLvtci2Ye0TjtDeiitgjpc9U=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af46ee1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=E6I8QaTN8wrSaqNYwnwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: nb4N83M1qzCdrKaSQbxTExKBz9Xv5r2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX/EpxS5qZ8AwG
 8LL/JVA8r1FazTczCLBou2fUIL9npUox/s18uzzK5FcPZU239C66rlkNpbYlvgm16LGlaHkUoEy
 fRb8JYyNSx5Y11qEPERGXJydvsXoxrG/JGGu8gM6Bgdv3irjIgHysyOkDbDifeDUJ48mUcedi+E
 pg7sbmk/n5wt3QUcWrcwBr81IKzkbm2BUFuF9GIyh2A5mmgIp2ONQQAYF9l/UiUwZwXBnghMI75
 LGO+cIZKai0hKNbn8x+CtoeNoxLz0mZ6ViG8H474ExMSl9X1uybGCzANAVyAE4VUN3hGQQq0zjT
 NNyOAEOCMWxtDP181wNiNBPoQLj80ggUV/JhVjJkTifV69U4yRQwNYNqeC5ok205S4wMXIr0aY4
 MS05EDf0k/sDMvXNS5lq8LjRMATpN1GmS8oVzOcDdDWEXMGX7jrqptxawpsknYUJwpUGfxFuihF
 AsTX/9DV0PEmKRqIKXA==
X-Proofpoint-ORIG-GUID: nb4N83M1qzCdrKaSQbxTExKBz9Xv5r2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=himanshu.chauhan@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Per the Sdtrig specification, on a breakpoint exception with icount, the
xepc must contain the virtual address of the next instruction that must
be executed to preserve the program flow. So for a one-instruction
trigger must fire only after the counted instruction retires. The xepc
must contains the architectural successor PC which for a taken branch
should be the branch target and the fallthrough otherwise.

QEMU previously disabled the translated-block trigger flag when icount was
enabled and relied on timer and privilege-change callbacks to update the
count, so the trigger could fire outside instruction retirement before the
guest PC advanced, causing Linux to observe the old PC and re-enter the same
breakpoint while single-stepping with icount.

Fix this by
  - publishing the icount trigger flag in translated blocks even with
    icount enabled
  - making the helper decrement the trigger count after the
    instruction has committed its successor PC and raise the trigger
    action only then
  - privilege-change callbacks refresh cached enabled state because itriggers
    tied to privilege mode.

Also make trigger data CSR availability depend on an implemented trigger slot
rather than the currently selected trigger type, so software can disable a
trigger with type zero and still write the rest of the slot state before
selecting another supported type.

itrigger timers are completely removed as they are not required now.

Fixes: 5a4ae64cac49 ("target/riscv: Add itrigger support when icount is enabled")
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 target/riscv/cpu.h            |   5 +-
 target/riscv/machine.c        |   5 +-
 target/riscv/tcg/cpu_helper.c |  10 +-
 target/riscv/tcg/csr.c        |   3 +
 target/riscv/tcg/debug.c      | 170 ++++++++++------------------------
 target/riscv/tcg/tcg-cpu.c    |   7 +-
 6 files changed, 64 insertions(+), 136 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdb..3109d71470 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -484,8 +484,7 @@ struct CPUArchState {
     uint8_t trigger_cur;
     /*
      * num_triggers is the length of tdata1, tdata2, tdata3,
-     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
-     * arrays.
+     * cpu_breakpoint and cpu_watchpoint arrays.
      */
     uint32_t num_triggers;
     uint64_t *tdata1;
@@ -493,8 +492,6 @@ struct CPUArchState {
     uint64_t *tdata3;
     struct CPUBreakpoint **cpu_breakpoint;
     struct CPUWatchpoint **cpu_watchpoint;
-    QEMUTimer **itrigger_timer;
-    int64_t last_icount;
     bool itrigger_enabled;
 
     /* machine specific rdtime callback */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e9588..74176e7c6e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -22,7 +22,6 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "migration/cpu.h"
-#include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
 #ifdef CONFIG_KVM
 #include "kvm/kvm_riscv.h"
@@ -339,9 +338,7 @@ static int debug_post_load(void *opaque, int version_id)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    if (icount_enabled()) {
-        env->itrigger_enabled = riscv_itrigger_enabled(env);
-    }
+    env->itrigger_enabled = riscv_itrigger_enabled(env);
 
     return 0;
 }
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..0375b930be 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -940,10 +940,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
-        if (icount_enabled()) {
-            riscv_itrigger_update_priv(env);
-        }
-
         riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
 
@@ -982,6 +978,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
             riscv_cpu_interrupt(env);
         }
     }
+
+    /*
+     * Icount triggers are scoped by U/S/M and VU/VS mode bits.  Refresh the
+     * cached translated-block flag after privilege or virtualization changes.
+     */
+    riscv_itrigger_update_priv(env);
 }
 
 /*
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..7c05c866fd 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5732,6 +5732,9 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
     }
 
     env->mcontext = val & mask;
+#if !defined(CONFIG_USER_ONLY)
+    env->itrigger_enabled = riscv_itrigger_enabled(env);
+#endif
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b58cbd07a..53b1e41f6c 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -32,8 +32,6 @@
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
-#include "system/cpu-timers.h"
-#include "exec/icount.h"
 #include "accel/tcg/cpu-loop.h"
 
 /*
@@ -53,20 +51,6 @@
  *     1 |    2 |         tdata1, tdata2 | Address / Data Match
  */
 
-/* tdata availability of a trigger */
-typedef bool tdata_avail[TDATA_NUM];
-
-static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
-    [TRIGGER_TYPE_NO_EXIST] = { false, false, false },
-    [TRIGGER_TYPE_AD_MATCH] = { true, true, true },
-    [TRIGGER_TYPE_INST_CNT] = { true, false, true },
-    [TRIGGER_TYPE_INT] = { true, true, true },
-    [TRIGGER_TYPE_EXCP] = { true, true, true },
-    [TRIGGER_TYPE_AD_MATCH6] = { true, true, true },
-    [TRIGGER_TYPE_EXT_SRC] = { true, false, false },
-    [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
-};
-
 /* only breakpoint size 1/2/4/8 supported */
 static int access_size[SIZE_NUM] = {
     [SIZE_ANY] = 0,
@@ -165,13 +149,17 @@ static inline target_ulong build_tdata1(CPURISCVState *env,
 
 bool tdata_available(CPURISCVState *env, int tdata_index)
 {
-    int trigger_type = get_trigger_type(env, env->trigger_cur);
-
     if (unlikely(tdata_index >= TDATA_NUM)) {
         return false;
     }
 
-    return tdata_mapping[trigger_type][tdata_index];
+    /*
+     * tdata CSRs belong to the trigger slot, not to the currently selected
+     * trigger type.  A type-zero trigger is disabled, but the slot still
+     * exists, so software must still be able to write tdata2/tdata3 before
+     * selecting a supported trigger type.
+     */
+    return env->trigger_cur < env->num_triggers;
 }
 
 target_ulong tselect_csr_read(CPURISCVState *env)
@@ -729,6 +717,30 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
     }
 }
 
+static void no_trigger_reg_write(CPURISCVState *env, target_ulong index,
+                                 int tdata_index, target_ulong val)
+{
+    /*
+     * OpenSBI programs DBTR slots by first writing type zero to tdata1, then
+     * writing tdata2/tdata3, and finally writing the desired trigger type.
+     */
+    switch (tdata_index) {
+    case TDATA1:
+        type2_breakpoint_remove(env, index);
+        env->tdata1[index] = 0;
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+        break;
+    case TDATA2:
+        env->tdata2[index] = val;
+        break;
+    case TDATA3:
+        env->tdata3[index] = textra_validate(env, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* icount trigger type */
 static inline int
 itrigger_get_count(CPURISCVState *env, int index)
@@ -754,21 +766,6 @@ itrigger_set_pending(CPURISCVState *env, int index, int val)
                                    ITRIGGER_PENDING, val);
 }
 
-static bool check_itrigger_priv(CPURISCVState *env, int index)
-{
-    target_ulong tdata1 = env->tdata1[index];
-    if (env->virt_enabled) {
-        /* check VU/VS bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_VU) == env->priv);
-    } else {
-        /* check U/S/M bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_U) == env->priv);
-    }
-}
-
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
@@ -776,7 +773,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (check_itrigger_priv(env, i)) {
+        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
             continue;
         }
         count = itrigger_get_count(env, i);
@@ -803,7 +800,12 @@ void HELPER(itrigger_match)(CPURISCVState *env)
         if (!count) {
             continue;
         }
-        itrigger_set_count(env, i, count--);
+        /*
+         * This helper is emitted at TB exit after one guest instruction and
+         * after the translator has committed env->pc to the successor PC.
+         */
+        count--;
+        itrigger_set_count(env, i, count);
         if (!count) {
             /*
              * From the 1.0 spec: "When pending is set, the trigger
@@ -822,61 +824,21 @@ void HELPER(itrigger_match)(CPURISCVState *env)
             itrigger_set_pending(env, i, 1);
 
             env->itrigger_enabled = riscv_itrigger_enabled(env);
-            do_trigger_action(env, i);
             itrigger_set_pending(env, i, 0);
+            do_trigger_action(env, i);
         }
     }
 }
 
 static void riscv_itrigger_update_count(CPURISCVState *env)
 {
-    int count, executed;
     /*
-     * Record last icount, so that we can evaluate the executed instructions
-     * since last privilege mode change or timer expire.
+     * Icount triggers are matched from translated code after an instruction
+     * has committed its successor PC.  Timer and privilege-change callbacks
+     * therefore must not decrement count or fire the action here; they only
+     * refresh the cached TB flag state.
      */
-    int64_t last_icount = env->last_icount, current_icount;
-    current_icount = env->last_icount = icount_get_raw();
-
-    for (int i = 0; i < env->num_triggers; i++) {
-        if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
-            continue;
-        }
-        count = itrigger_get_count(env, i);
-        if (!count) {
-            continue;
-        }
-        /*
-         * Only when privilege is changed or itrigger timer expires,
-         * the count field in itrigger tdata1 register is updated.
-         * And the count field in itrigger only contains remaining value.
-         */
-        if (check_itrigger_priv(env, i)) {
-            /*
-             * If itrigger enabled in this privilege mode, the number of
-             * executed instructions since last privilege change
-             * should be reduced from current itrigger count.
-             */
-            executed = current_icount - last_icount;
-            itrigger_set_count(env, i, count - executed);
-            if (count == executed) {
-                do_trigger_action(env, i);
-            }
-        } else {
-            /*
-             * If itrigger is not enabled in this privilege mode,
-             * the number of executed instructions will be discard and
-             * the count field in itrigger will not change.
-             */
-            timer_mod(env->itrigger_timer[i],
-                      current_icount + count);
-        }
-    }
-}
-
-static void riscv_itrigger_timer_cb(void *opaque)
-{
-    riscv_itrigger_update_count((CPURISCVState *)opaque);
+    env->itrigger_enabled = riscv_itrigger_enabled(env);
 }
 
 void riscv_itrigger_update_priv(CPURISCVState *env)
@@ -911,18 +873,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
 
     switch (tdata_index) {
     case TDATA1:
-        /* set timer for icount */
         new_val = itrigger_validate(env, val);
         if (new_val != env->tdata1[index]) {
             env->tdata1[index] = new_val;
-            if (icount_enabled()) {
-                env->last_icount = icount_get_raw();
-                /* set the count to timer */
-                timer_mod(env->itrigger_timer[index],
-                          env->last_icount + itrigger_get_count(env, index));
-            } else {
-                env->itrigger_enabled = riscv_itrigger_enabled(env);
-            }
+            env->itrigger_enabled = riscv_itrigger_enabled(env);
         }
         break;
     case TDATA2:
@@ -931,33 +885,17 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
         break;
     case TDATA3:
         env->tdata3[index] = textra_validate(env, val);
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
-static int itrigger_get_adjust_count(CPURISCVState *env)
-{
-    int count = itrigger_get_count(env, env->trigger_cur), executed;
-    if ((count != 0) && check_itrigger_priv(env, env->trigger_cur)) {
-        executed = icount_get_raw() - env->last_icount;
-        count += executed;
-    }
-    return count;
-}
-
 target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
 {
-    int trigger_type;
     switch (tdata_index) {
     case TDATA1:
-        trigger_type = extract_trigger_type(env,
-                                            env->tdata1[env->trigger_cur]);
-        if ((trigger_type == TRIGGER_TYPE_INST_CNT) && icount_enabled()) {
-            return deposit64(env->tdata1[env->trigger_cur], 10, 14,
-                             itrigger_get_adjust_count(env));
-        }
         return env->tdata1[env->trigger_cur];
     case TDATA2:
         return env->tdata2[env->trigger_cur];
@@ -995,6 +933,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
+        no_trigger_reg_write(env, env->trigger_cur, tdata_index, val);
+        break;
     case TRIGGER_TYPE_UNAVAIL:
         qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
                       trigger_type);
@@ -1147,8 +1087,6 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
 void riscv_trigger_realize(CPURISCVState *env)
 {
-    int i;
-
     if (env->num_triggers > RV_MAX_TRIGGERS) {
         error_report(
                 "Invalid configuration: 'num-triggers' must be less than %u",
@@ -1161,12 +1099,6 @@ void riscv_trigger_realize(CPURISCVState *env)
     env->tdata3 = g_new0(uint64_t, env->num_triggers);
     env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
     env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
-    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
-
-    for (i = 0; i < env->num_triggers; i++) {
-        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                              riscv_itrigger_timer_cb, env);
-    }
 }
 
 void riscv_trigger_unrealize(CPURISCVState *env)
@@ -1177,11 +1109,6 @@ void riscv_trigger_unrealize(CPURISCVState *env)
 
     g_free(env->cpu_breakpoint);
     g_free(env->cpu_watchpoint);
-
-    for (int i = 0; i < env->num_triggers; i++) {
-        timer_free(env->itrigger_timer[i]);
-    }
-    g_free(env->itrigger_timer);
 }
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
@@ -1209,7 +1136,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
         env->tdata3[i] = 0;
         env->cpu_breakpoint[i] = NULL;
         env->cpu_watchpoint[i] = NULL;
-        timer_del(env->itrigger_timer[i]);
     }
 
     env->mcontext = 0;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5834ec1524..027fe5b46a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -181,8 +181,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
-        && !icount_enabled()) {
+    /*
+     * Publish itrigger state even when QEMU icount is enabled.  The helper
+     * runs from translated code after committing the guest successor PC.
+     */
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.43.0


