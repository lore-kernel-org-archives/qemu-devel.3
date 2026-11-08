Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46458606A321
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pO+tGzB8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e+JRQ/8R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ0eN-0005vF-I2; Sun, 08 Nov 2026 06:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xQ0eK-0005sG-Tl
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:01:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xQ0eI-0003qY-2E
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:01:24 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A8Ai7Rn1875977
 for <qemu-devel@nongnu.org>; Sun, 8 Nov 2026 11:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=C8Xd0INM509L33gWfQUQdZjBss268iQ9tD2
 5qj5eUdM=; b=pO+tGzB8A315ivJxLZcrAZWf8Uz9uJc57LJ34w7fv0dGd8qHdPY
 v5zfoDRU2vKd1BKGG+N2ChFwJ1p3gTiqXDXNPIPNYmiU1FtB75zCYiZ2nH/Vgy68
 eoq0Q82SajWm7L12l6uuF7HnISxE0NRnQZBKjUmuawy7nU/Zn+ioiNmi2wctDsFh
 bEZTrEclG8B3d5amirlsvyNtBqwfzQ0dytQJy34ChApj9rtb03vC8TptdD2V479u
 d4y7dT2JlSZxJd+/VfzrOXuA4H5123U2s48WfyZCi6uOPln0JFjLFRySaQF6TLkJ
 h7fX6E6MSoyL5iQuQclJ4LRPvRna78MXNuQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxau3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 11:01:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso253768eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 03:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794135678; x=1794740478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C8Xd0INM509L33gWfQUQdZjBss268iQ9tD25qj5eUdM=;
 b=e+JRQ/8R/nAjeWuCyci5qN+y0fYZBeqBq/TlGItWX/UBPFiaOSnpxULKtq5ivahmNz
 hjAEqS96xQgIciDj7L+XAx4H6GoqS2h+4TpYfVxGfU5hJZRxLvu6WC779FS1mQ+97s7e
 kFVU2lWYlCDndZSXnwxewZFk7sdsIlCdqEWTA+87ys32mGBF1Lq0oNkSDinsAQ9F0j8T
 pVwfMcdw5Jdm+cgqWIin2aowWM8ZQx4kbIe/Nd9g2gqJjVdGP6B2psqKhnyijMh87RJ1
 rnk2qX1CLGEB3s/BfAsbrNKNW8CP1V6rGOwJZ9PbMbpwBS8B0jC3uQb6ItibwmXmvgZ7
 fvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794135678; x=1794740478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C8Xd0INM509L33gWfQUQdZjBss268iQ9tD25qj5eUdM=;
 b=1uykICKn1RxvZGoeXj7YSKTS9YpaWTThdHPdEH9Ip7qJp4KK9XnAvc5vknq3Q570+C
 Q9s3KshymrR+qJBopflapUY8fw/d7Moo5Ep4UdmMaXxHVJ4VlY90U1DiyRyYeAf3eMFF
 lIme1dSSUck2AAab02IBhOEX7IEbLO6+7U2XDTMNexzALFin2GGmHqYBPaFe46AtEuTs
 5zGrOSUOW8zWQyfMcE1iqQKW9Uut8xlfZh6OIxYL//WecZAS7MWq8BCAwTjrV2Hb7k8v
 iE19ESK9KTKZAcDQhf9ePq+VRR1bR9KCE7hLEj1vae7Wxo2TdhSeNFEy26xS/PCdPyV4
 1uxQ==
X-Gm-Message-State: APuU4Z8MB9t5NlCQt5HlF+w3dWaxpFL5W2x4u4Wop/SfoyoXX/XEU/em
 PbfvpIaubNMDM5oPeNCyT2pChp9pdgu/Qsbs+A4H4zxe35H2/qIi0+toQpXZxXXTgmRdgeaWRJJ
 yFlS76w6c+2zTcgSghkR+svfXqpEJvTujORtd9jYeAj57PRHLzTit7W8/Q0pHKcE9yw==
X-Gm-Gg: AYBFou0RiATpKTQ6AIv05oyFkU5PYAbwqh7cshJFTdEBSF71IKtVsVITbPmW1QBLc1h
 t9Yk0mZC/ODgtG5M+3Z+dtI+VGR44GTYKLSQMoabc4wOw6oFvewDHGmgj6wvEmDEQGkbhC/8lgL
 CvrWLu8arVKfDZc9h9XpeAv+3Ps5HuB6TbHZMHk15RkEMYpZtfYNyOExvsaJp24+mPuJESsxor2
 ZsxjYdLiAxPcOLojsPP3svNWKCZUlL5TdCkbXDrYu3eKJL5lVI/FLZayLdt+lT2IaIHv8dTxnaq
 6cIkoahxczxZ8o9cyqanT40ir9M2WJerHOJ3ARvQXLb/G9aL6x9vRe80XZp/pNbuekuzZCAvHnJ
 O6h4vHutZIg4jZVoZPTPXFZgK2vH6tSNAPU9zntVXulWGGkF5dw9Sjo3rtbgpeGE6zQOy0+vYaj
 yMqZzejdg7CwyJZnqDOrveAkQYe9fe1B9I1JgopapucdU1QTp7vt0+ha2yCqUyFZEJSPRYjSMk1
 w==
X-Received: by 2002:a05:693c:4144:10b0:36f:65b6:d137 with SMTP id
 5a478bee46e88-3725e33a3bdmr2578027eec.24.1794135677432; 
 Sun, 08 Nov 2026 03:01:17 -0800 (PST)
X-Received: by 2002:a05:693c:4144:10b0:36f:65b6:d137 with SMTP id
 5a478bee46e88-3725e33a3bdmr2577968eec.24.1794135676639; 
 Sun, 08 Nov 2026 03:01:16 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372665db733sm4234794eec.23.2026.11.08.03.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 03:01:16 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH] target/riscv: Fix icount trigger exception PC
Date: Sun,  8 Nov 2026 16:31:07 +0530
Message-ID: <20261108110107.1752051-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yhxA6BXhV6b3uIG4XpVZk-YvgYt_6DAz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA0MyBTYWx0ZWRfX7NfSkCcd1mjo
 oph2KyXSNdmQa9cvQ3k5zOgP91BMBHu/Q1R3+H1ofxK1nciPZAYaKf3eLX12iFwWak4yLRw0hvI
 7Q9BsM2XLfaSbbzz2EIpHSHp8EzJYSCePlvUUz/gC9UE5+67L4UQnFEXgjlrohfxzNCkg8NM698
 U4dg/589/0IgCHTYBjUHTq4Evk+9WAkiLtoe0DZwni9irRExfiCLwAdhQvye9eulJHV7BfnLees
 gEZFXGghb+oXMVFA7A5HJq7q8QHwnWRzfbaExHUiLclovUtn9sw02ZdpuZikJRcc+q9YOD1l0VQ
 MmZAa1XVhI7ChY6SkUN9/FtjSLQD3KvZCD9ZyxIGQn2IoFJYEN6ajXQeeMpuunZSczYBGYz0vU+
 t96bz8jjhZ7pVKlNLz86HtuejDFyYYkPun0DIYDz6dqgvcl5b42SjAntJw42fH3dGjDA+YggIuM
 bDEH/OcFPfXGx71MAZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA0MyBTYWx0ZWRfX8lNx1aRlIBge
 qMkGw1ZuYWdK97mw0Aup5afPXfYD1sYTltxvz6s3CTGzHo9Rw/3/LQju14ROZ8AKwPdcU3V3Zog
 FLV1xERfTJJJY3mkLb6ZLPSEOJaDHiw=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af0567f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4Onx-hqAXmI6024lcUsA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: yhxA6BXhV6b3uIG4XpVZk-YvgYt_6DAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080043
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=himanshu.chauhan@oss.qualcomm.com;
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

Per the Sdtrig specification, on a breakpoint exception with icount, the
xepc must contain the virtual address of the next instruction that must
be executed to preserve the program flow.

Since SBI DBTR exposes these trigger encodings to supervisor software, an
icount trigger used as a one-instruction step must fire only after the
counted instruction retires and the architectural successor PC is known,
which for a taken branch is the branch target, not the trigger install
address or fallthrough.

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

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 target/riscv/cpu.h            |   5 +-
 target/riscv/tcg/cpu_helper.c |  10 +-
 target/riscv/tcg/debug.c      | 169 ++++++++++------------------------
 target/riscv/tcg/tcg-cpu.c    |   7 +-
 4 files changed, 59 insertions(+), 132 deletions(-)

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
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b58cbd07a..2c9c251643 100644
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
@@ -937,27 +891,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
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
@@ -995,6 +932,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
+        no_trigger_reg_write(env, env->trigger_cur, tdata_index, val);
+        break;
     case TRIGGER_TYPE_UNAVAIL:
         qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
                       trigger_type);
@@ -1147,8 +1086,6 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
 void riscv_trigger_realize(CPURISCVState *env)
 {
-    int i;
-
     if (env->num_triggers > RV_MAX_TRIGGERS) {
         error_report(
                 "Invalid configuration: 'num-triggers' must be less than %u",
@@ -1161,12 +1098,6 @@ void riscv_trigger_realize(CPURISCVState *env)
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
@@ -1177,11 +1108,6 @@ void riscv_trigger_unrealize(CPURISCVState *env)
 
     g_free(env->cpu_breakpoint);
     g_free(env->cpu_watchpoint);
-
-    for (int i = 0; i < env->num_triggers; i++) {
-        timer_free(env->itrigger_timer[i]);
-    }
-    g_free(env->itrigger_timer);
 }
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
@@ -1209,7 +1135,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
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


