Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E5CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJMM-0004V9-EQ; Mon, 15 Jun 2026 22:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJMK-0004UW-Q9
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:17:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJMI-0002hs-Ud
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:17:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xhan2271129
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Wl/l58jF266TXr78IqsbM7
 hWW/TfYtT8wj4jmm3NV1I=; b=TYRWyQvKMOR9kQqgAxVFGvqzF6Q59q/eIf56nL
 BEz1Y8CzTptW1gy1IDWADK5BKQDRZ2Lfa6Crp5AFzeJ6WTuxlpx9heuXJHCwrSrE
 m5OByfdaomkeXZFmYuXKDONY4iziJf/3gFTouNgNuFKcSnHvaosVOHeg6QAP2m7p
 ln4f6g26kooOe59tfrNeUpYLNUrUykDalcbIFSgTJG2EimIWIUkl6UCZfIQRM0p5
 OjFu+nzd+rXyoSbb9p7w4y5wvA+crWlAIpn1Fg0mWKLGAV6sqjWt9e70s73fmc6q
 rg95OyYY+iJuYwmo1AkrKwMafpSBGzzkXhc1H3IEqjB+x78g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteguv7ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:16:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cec2c6b821so84634656d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781576217; x=1782181017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wl/l58jF266TXr78IqsbM7hWW/TfYtT8wj4jmm3NV1I=;
 b=hbNPBEsn/2iBKz4eHkGgGuTW62hL4Qn5+G2xBTVFN3TwndB+jLJN4WHzzbLAlFrF2H
 8iEh8HiWPEKm/WUslNY1UIeYtVW3/deKI8xgYE2ojqIPSI/ORO0H4OBKKTYOCK7F2qIC
 2xDHsR5hmSyYxhQi/sL6b7EG677uMS3CT6fzu0qx6IxvNSw8laqVXzTsTEVEKXtrZrS0
 CRUef8NXxiJEQcm1h1QDsDjWYuuXbsh8+W60EkhqelCc3SiARXY0X2doTkNj5Xy2Hqbg
 aGJcPxb/Er8AJY2sJncGX+P0ygrIoiFJH99bf5/5YQcfuEzaTrxkO35j9u0XMUvCsfbD
 p1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781576217; x=1782181017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl/l58jF266TXr78IqsbM7hWW/TfYtT8wj4jmm3NV1I=;
 b=B6Mjohd5fb7McaJpBCKEBDs/Q3R6tnXOqlBWtv6ww2TrcrwhR3GeSCLwP87hnsMy/1
 auW+wq4RPwswzB7P2dKE5RkX7r92z7q9sLecmhzfyuL5boIOtl85vHN2w/EdtnmD3SAi
 Ynp8qzldTVe5HQc2xGsBwlnTuqq6A4CsqHsEd5WS1jKVwgzGBJjJN7gk30cKpAlWXU4u
 wxz+UzWt7WPbH8Ta92QR1g2V7c2rb72+Ec+mff62+JUYT5zYm1AJSQ1QOKICKGCR3tvc
 Fgsv+nQ9fppGu8nD5Bm0BADyg1NdTG3doBk129kuZrF3lteDnsk3aFIYLqe5E+CKFyY5
 wByg==
X-Gm-Message-State: AOJu0Yz3D2EL7Jz8khPBqbstZTd8l17vT4K7n9I/EI2OwpWSV8YYQ/po
 mBZdTBLRftjgi8JtQBAsAVteY0Bw8hpFGHpI9LyNY6SkRewS5j7n5N8+d8H/UoDpxln66zmlHqQ
 LqaG4VuVJf34g4NdJb0NRuNGZFGg8+uUtczrtZ810tDXThLxkta2G0k7bqM7lz66kZg==
X-Gm-Gg: Acq92OEhidexk6IYisnxcqL3TjKSB8S5z0AieGGbRgp64vNUvI8Abm4s5oQuhgC/O+n
 Whrl3/ck0ImJhAKA/EjS8HqnLwLbV8hlHwPEKFL+MXmsgkOo13txUj81xbiCghBS+Ia+R7WDO04
 tAtNhL5RIdI/G02pCbE6q/DVgSGVmTt13NImunvh1xExU543Wd7XB5jjsJGkOwMOOQknuyB/h1w
 HtvW1Gcn+L4wonqf+2kbJf69LkxVvLfeBCs/5nwKNXiQdymABy+UDEiIyQfGEUpxOg3P1ODTOcv
 y/1mhvN+k3P3ZjBngAd98annUL91erhFiejWuHBT08soGr0RmZkuPJaAHwBpnGM0Zd0yc1VOHFR
 8mqiU/eneWBD2LAOg6X7/aHuJ/YJ75A+lqnPBBXjS6+ieCLhOwNnU0VTsp1oTJwB8FBuMH8aVhg
 Smc+I=
X-Received: by 2002:a05:620a:258f:b0:915:7c1a:1390 with SMTP id
 af79cd13be357-91c47d7aff7mr277723785a.39.1781576216669; 
 Mon, 15 Jun 2026 19:16:56 -0700 (PDT)
X-Received: by 2002:a05:620a:258f:b0:915:7c1a:1390 with SMTP id
 af79cd13be357-91c47d7aff7mr277719985a.39.1781576216264; 
 Mon, 15 Jun 2026 19:16:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3basm37831582f8f.12.2026.06.15.19.16.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:16:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2] hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
Date: Tue, 16 Jun 2026 04:16:54 +0200
Message-ID: <20260616021654.22892-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOSBTYWx0ZWRfX5GYJikhix4Rd
 AOD2jIOCmHhKhXQyYTJAJTLf6xEMl+Nknd83Ooc6P6KVluHc2vZs1RZZW3h5IU8FmvNYE95lxgT
 Zam01cwjbN2GYDwQXwLYjkY8ljgsZlH/EqW36Z85U8/6dAqeHRIbom3veJ9zF1QkEq00rnvbDM/
 VVqAKiGntlVScvlndZZQB0O9RE1RwBS3rm1UYjl9KHRui5KZkfm4KFZSRjN+R7s/j/0WQlZjgna
 UJ86ERy0Zve86fd+uOmjR7Pt+LM0z1iLCpEneMZB68/xfGCJKm30HRs9Nit7OuLNUUn5AqAirQV
 um7RGRWo3Uzl0BngY71ibgcZB2C+Bek3BMqL+ZzXoxakSQazMqci/XRAUYb6tKj5PkWDHAN/w5X
 +oNUmlYkc3IM8WfWAfCE55VuNtdCfaJJbtGh9Exlm3CTsSipeiRuQRX9duxm/QVnQajPjHsNCLK
 a8hHOnOmtE91srdvhxA==
X-Proofpoint-ORIG-GUID: nHV3Uc7iJVHF3-hMj5dHQ6aye3nSu2k-
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30b219 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=O4nC0eKGiR0KFeLeyJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOSBTYWx0ZWRfX114p/rNw0oIF
 DSCLsvj49OC/MZBHa+KkDrr2d+2ohGHs97eyd4/m5HuFjY4ONY/IR6bysjzY6Y9HmNRzUZ3VPAa
 q9pyqvJGgvojj8LnHl9KNOYR8hpMIz0=
X-Proofpoint-GUID: nHV3Uc7iJVHF3-hMj5dHQ6aye3nSu2k-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160019
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Rather than calling a TCG specific method in s390_ipl_reset_request(),
have handle_diag_308() return whether a vCPU reset is pending, and use
that in the TCG DIAG helper to return to the main loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/s390x-internal.h  |  3 ++-
 hw/s390x/ipl.c                 |  5 -----
 target/s390x/diag.c            | 30 +++++++++++++++++++-----------
 target/s390x/tcg/misc_helper.c |  5 ++++-
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index e7e4f2b45d4..35d1e34ef4d 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -385,7 +385,8 @@ int mmu_translate_real(CPUS390XState *env, hwaddr raddr, int rw,
 
 /* misc_helper.c */
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
+/* Return whether a CPU reset is pending */
+bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
 
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fa50749a7d3..4cca21c6217 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -18,7 +18,6 @@
 #include "system/physmem.h"
 #include "system/reset.h"
 #include "system/runstate.h"
-#include "system/tcg.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
@@ -690,10 +689,6 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
     } else {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
-    /* as this is triggered by a CPU, make sure to exit the loop */
-    if (tcg_enabled()) {
-        cpu_loop_exit(cs);
-    }
 }
 
 void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type)
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 01cc802eaed..618ae41289b 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -95,44 +95,49 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     }
 }
 
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
+    bool reset_requested;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, ra);
-        return;
+        return false;
     }
 
     if (subcode & ~0x0ffffULL) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        return;
+        return false;
     }
 
     if (subcode >= DIAG308_PV_SET && !s390_has_feat(S390_FEAT_UNPACK)) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        return;
+        return false;
     }
 
+    reset_requested = false;
     switch (subcode) {
     case DIAG308_RESET_MOD_CLR:
         s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
+        reset_requested = true;
         break;
     case DIAG308_RESET_LOAD_NORM:
         s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
+        reset_requested = true;
         break;
     case DIAG308_LOAD_CLEAR:
         /* Well we still lack the clearing bit... */
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
+        reset_requested = true;
         break;
     case DIAG308_SET:
     case DIAG308_PV_SET:
         if (diag308_parm_check(env, r1, addr, ra, false)) {
-            return;
+            break;
         }
         iplb = g_new0(IplParameterBlock, 1);
         s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
@@ -159,11 +164,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         env->regs[r1 + 1] = DIAG_308_RC_OK;
 out:
         g_free(iplb);
-        return;
+        break;
     case DIAG308_STORE:
     case DIAG308_PV_STORE:
         if (diag308_parm_check(env, r1, addr, ra, true)) {
-            return;
+            break;
         }
         if (subcode == DIAG308_PV_STORE) {
             iplb = s390_ipl_get_iplb_pv();
@@ -172,30 +177,33 @@ out:
         }
         if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
-            return;
+            break;
         }
 
         s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
-        return;
+        break;
     case DIAG308_PV_START:
         iplb = s390_ipl_get_iplb_pv();
         if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
-            return;
+            break;
         }
 
         if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
             error_report("Protected VMs can currently not be backed with "
                          "huge pages");
             env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
-            return;
+            break;
         }
 
         s390_ipl_reset_request(cs, S390_RESET_PV);
+        reset_requested = true;
         break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         break;
     }
+
+    return reset_requested;
 }
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 3d13c8bd8ea..036be93fb32 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -135,7 +135,10 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     case 0x308:
         /* ipl */
         bql_lock();
-        handle_diag_308(env, r1, r3, GETPC());
+        if (handle_diag_308(env, r1, r3, GETPC())) {
+            /* As reset is triggered by the CPU, make sure to exit the loop */
+            cpu_loop_exit(CPU(env_archcpu(env)));
+        }
         bql_unlock();
         r = 0;
         break;
-- 
2.53.0


