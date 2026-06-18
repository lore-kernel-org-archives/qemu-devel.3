Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE1BCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvz-0001un-61; Thu, 18 Jun 2026 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvx-0001m5-JV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvv-0001Nu-KY
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAreZZ3763657
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 njrORuK0p64AYtYneoocEnb959WwMM16V4FhFR/1im4=; b=oU2Ej0BvS8PHjuzy
 5yajF+R4VNud5Aac6HBmDFycW+sjtuEUQMe83g3SJM2Tk2PQ1izk9J3e1adJCd7/
 kJ0XRVXDXUhLa8rRAx7Stf+RVDE54JYWvEd1R/0Sii9tx491pWp4z3sUg9K06O8a
 gHGMBNpCkONkfsqJMLw5ZafXQn8GbA61ssEhUMQHqr4Cdiz4KuLPtPKC7N42Vg1X
 YrNcCL1r6aHuKVW6mMzZhFBQl5P4Jg87cQbYgVHaYjwusVkLSrs3SzNYHzD5tFdA
 gmFVddSSDV38QC/fZc57n6BMMyltmae35xFMSt9iyxpbFeyfk4u1RWiJgSWklr/f
 TsnOKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk3b6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157f1be083so195101885a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786001; x=1782390801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=njrORuK0p64AYtYneoocEnb959WwMM16V4FhFR/1im4=;
 b=UYYlv0GXqDUX6EMXwYwveeXdMTsKQ3eVm7U4N5hmAzjbcNaINiNGPTRjSknBWCYQwG
 Jr7yLqqTlqery8GjbVITarp3a3B6Uusxt79TnwRTlH2OA84SSx9Xlz/cwzKtEufGoITq
 NlYzVb/SX/a2PfecTxNbjNmpoft25+zK7oSs5UUOD5debCg+fIbyHcXuMHNjn+T6+sKW
 O1DgMOlt0qoR9arduxKjABKqwMePgDeP4Fl10bv+pVKqxA+b6d5fPMr8nLsczJIJN2nK
 ppbnXoma2kP1kkm0K3BQ37GNaMkc2elI0ctXbJtPgaXVpnlW2sG17lQrwVxsn4Rdn1Hc
 w4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786001; x=1782390801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=njrORuK0p64AYtYneoocEnb959WwMM16V4FhFR/1im4=;
 b=j3/t35ogcAs7Df5vi2tlB3FY6UjPPViEy9cdaaB3euVxnH9LFwhWlmIA2X1NCuGiHN
 XbqwdC1hA0xzrDoqZW3C4Z/jR85n9Jio0j0muyfWzfs195lQ2XvbHI2tTwGfDpKn2KdN
 E8wIjxCaVx5eqQHDwiK7FdMj+Ih8k0aVsf4DNlijkhobEONUDD+NCkVhg0r3a3vgBJYQ
 uta/anK3GOHxU/SwDapGASWMZBTei78rrc7k54vGAkgGMVj23aKFvk2gtauXvpSyuZzl
 FOzEjMpK3cMQ7pyd+AF6S+7IttxpJ0ulsHtXKfl4UfVHjdgEeZ2+AfOixkVlmlg5GeSN
 XOXg==
X-Gm-Message-State: AOJu0YwVjFnlVfonvDclszxmBlBY9WPSaR9tJF6qGVrSz04wAY+KE8In
 p6P6Se4WznuT+9oxf5YdSOU7P3Op9JBH1G8qlVfKViXi3P5wCMjSg9Na7MTXhdTLZGQ6HpgmoZ5
 e8FmvTJysaQWUuSDmSF4NG07B6c4ytlEpzEaLNvjGSJx5O68ffdo50AiCbxwQmLXJZg==
X-Gm-Gg: AfdE7clCpHi6ij7LYe8REXk9tBA3MlQI9fbjTGU5Ehr6rBlC5/QxXFp129m2hfGXBWZ
 6Km4VFP7XSr4PSny2RbWOjFhe3m5lVjSaJDN4Ec45Ri2NB7oPOMPgqH8NF3AkaEVYUI7IQ/cb4E
 SrWmzlP1icTvjYx5WxV1qybGAyLXTKXQBnW8HWzIk2EC0A2ACssYvWYEoSy+uY5BIVl5AR7WT9c
 9bdBjQI/NFjaQFvufP4btwXg9yhn94B4rdEaM/LncMm2ZAhQWAxoxJ9hNw3/oFZPRttUaUPAobD
 tt0lBOAVH6ho9i26rZozL0G4zlwt7ej+67aB0QX+OHHsY2+/ymOvofGVvEHpBf+skgTWipUwCLv
 FsYLIsrI5wYdTTXWiCexTKspudJ08OJqhUlBq1nVem+hu6U02jQx0EcrPfLGHvve39p3K
X-Received: by 2002:a05:620a:278a:b0:915:9fba:878f with SMTP id
 af79cd13be357-91f8ba807ffmr270429585a.5.1781786000930; 
 Thu, 18 Jun 2026 05:33:20 -0700 (PDT)
X-Received: by 2002:a05:620a:278a:b0:915:9fba:878f with SMTP id
 af79cd13be357-91f8ba807ffmr270421785a.5.1781786000263; 
 Thu, 18 Jun 2026 05:33:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4601esm267798365e9.1.2026.06.18.05.33.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/48] hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
Date: Thu, 18 Jun 2026 14:28:17 +0200
Message-ID: <20260618122825.90331-41-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SDVxXXNljg5F9rBWUINyMEIYx5YMF6VS
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33e592 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=O4nC0eKGiR0KFeLeyJoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SDVxXXNljg5F9rBWUINyMEIYx5YMF6VS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX0G1wOsFoIoqw
 L6Q3FH9iGkg2WSoC/h4Jm1E4+4+JgjusCK+CM2wIjrEHVNdDaui7qzCBI9rU/ip28Y/AtV1VvVy
 VmQfNAsWd6jvdDuFfVaybYRoNSygYWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX1L6CJgkH4tTw
 lLMCd2w2EeA7iW6MH7UXQMYO0jw87vsh6/ZIxYx1MZfohWLSm4jkr9Qmwu3L9FGZV76xMCJ2K8t
 dbqBozfH1mkFDIWn5oyJqS6Ai0DhUOh7hrNXKV5bxtaJI2+Db/79SG/ptv1avWzAjnjHqGzXc0P
 4wiX3U7nI0Qf1WTX32vfCh8YWOGdpg+5hWsEFBVmOMEjWGTywW1RKOtm/dvznv6MEQC/HyvHjcM
 /NdOX7xNY8MsLynwph8n6C1PjPnWhjjFJB6AmnU0AGH1plZVNZDaU3bJGD0DaAUja34QoEId7Fp
 lKCxVLWhgm+oFH7/PANdUhu2pGLQ+AT0C15hAqJAGtF8kxWlyhkV3Mk1FlGBcBHVMSh4ED1Luke
 fG5Fil3E2GwJ9MiEYBzFXtdJBRsUllWBsMdgvHvf4LFcrIfUXFJu63Nyt/NsJTH4nq4WXypL8T8
 lWYeOqqHSzkY3XmHfZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Message-Id: <20260617164035.70788-4-philmd@oss.qualcomm.com>
---
 target/s390x/s390x-internal.h  |  3 ++-
 hw/s390x/ipl.c                 |  5 -----
 target/s390x/diag.c            | 32 ++++++++++++++++----------------
 target/s390x/tcg/misc_helper.c |  5 ++++-
 4 files changed, 22 insertions(+), 23 deletions(-)

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
index 01cc802eaed..80f09584789 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -95,7 +95,7 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     }
 }
 
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
@@ -105,34 +105,34 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
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
 
     switch (subcode) {
     case DIAG308_RESET_MOD_CLR:
         s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
-        break;
+        return true;
     case DIAG308_RESET_LOAD_NORM:
         s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
-        break;
+        return true;
     case DIAG308_LOAD_CLEAR:
         /* Well we still lack the clearing bit... */
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
-        break;
+        return true;
     case DIAG308_SET:
     case DIAG308_PV_SET:
         if (diag308_parm_check(env, r1, addr, ra, false)) {
-            return;
+            return false;
         }
         iplb = g_new0(IplParameterBlock, 1);
         s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
@@ -159,11 +159,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         env->regs[r1 + 1] = DIAG_308_RC_OK;
 out:
         g_free(iplb);
-        return;
+        return false;
     case DIAG308_STORE:
     case DIAG308_PV_STORE:
         if (diag308_parm_check(env, r1, addr, ra, true)) {
-            return;
+            return false;
         }
         if (subcode == DIAG308_PV_STORE) {
             iplb = s390_ipl_get_iplb_pv();
@@ -172,30 +172,30 @@ out:
         }
         if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
-            return;
+            return false;
         }
 
         s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
-        return;
+        return false;
     case DIAG308_PV_START:
         iplb = s390_ipl_get_iplb_pv();
         if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
-            return;
+            return false;
         }
 
         if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
             error_report("Protected VMs can currently not be backed with "
                          "huge pages");
             env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
-            return;
+            return false;
         }
 
         s390_ipl_reset_request(cs, S390_RESET_PV);
-        break;
+        return true;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        break;
+        return false;
     }
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


