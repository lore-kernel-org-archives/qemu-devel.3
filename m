Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888B8CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtKF-0007OR-7K; Wed, 17 Jun 2026 12:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtK8-0007LP-Sa
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:41:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtK1-0004aH-QH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:41:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpR8o3284167
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XQjhXbGLqdW7rKXKjn6j6dIB3mgq7X0w5oo2Uo85GV8=; b=QvI2TyzJo1O3h1Sq
 59p76s6s48QNn6VTqOT0Jcz6zSv1xW86mfUrrfla9bwpyDXq0vdOAZqFTTzY5GoQ
 4UFDeNQr/bReWGmDT6+0D8GLxO381/0Sv1Etilvqcx/ZdK/uDZJKpKA1wUlwRNk8
 1TrwqpsNS6UWaAGAQn0KoN4TxeT3u7MPdEwmPCb8eo/6ueITCpzzLzneDfJZau9L
 x9flbyl4DhUa86kMo5KJDfi2Uy5EJNsUgN1aLOgrBvjSt7+6y5LbEQA5xsFxtjoM
 ULvSqZzHWCYqk/E8+ZhKtrlIqhsX8LYUNZ6UpUXfmfnmEJZeOq0LED7kC3pGK29B
 rnC4WQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevme2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:41:00 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6751c50552dso2802254137.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781714460; x=1782319260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQjhXbGLqdW7rKXKjn6j6dIB3mgq7X0w5oo2Uo85GV8=;
 b=cf4O824NoK8Wjw8f1El+GYi+iG3jpI7ck1/L1UfXmI8SPZcD/e1J8XdVgkk910bEyw
 Fo+V8BW8vG5UOnnF0mDosUCjlQkHeeWUZ1VJrs/2QpL+BweKkOESaMDYyq6kyU3ur5I2
 4NQLHegwruccfevkg8etOuu5J2NAQHIXvRFxqMCbhVuCGHS3Rdfqn4xckI3j6W5eJhD6
 thogNlD5RnLYbABwD1uxS9hO8dni6YqHmdrgHvFt/tZC2ZwVqWBQDyZZcvKMOEywVpD2
 jF/XKpiTL8PHE36GGLdKNbC9YNR3A8fsIREKZYBup9bwWVbzZXm389SO0vLArSzLEoOr
 kv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714460; x=1782319260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQjhXbGLqdW7rKXKjn6j6dIB3mgq7X0w5oo2Uo85GV8=;
 b=JD8A2cInS0/iAXIw9TBSmDnMYM+GPBz2lxPLPVkl+1HObvy4XRIA6Llp9pQmeZOtpQ
 KnVZABbkdFWxiOzx/Gvodutiuhq079B/cvpCP3UGKTgHQSBghtpUz1vGfgCIlUgO3LoS
 bqzBYu0/q3EXj84bl5b0J0UzJQvOscJi+TdlHBN6EEDsR1R9d8FCQjptpeXQ4Q02L1od
 Xh/tCZK2t8GoKvgxQP6kdPHPGSgSRVk7tIJtx0Zu9/8hdg14Ot12CpuJEhqSpg+Zu+mG
 QgwX4EO5i5CqNCRw1DiXBGdHUHTUi+ubMMaKIVcXy/ny4ETVJWEE8VLtK/u/6217pSi3
 oIrg==
X-Gm-Message-State: AOJu0Yyevpk8DopDrZ34Sf0l0Cuvuhxej85mWmck1DnXsXP7ndPmcYa+
 78s0FjP+YBZy901Ne7Bg1i6Dpt8ieAbbsk6JkUjpEaF/U3CCcbftVhHZxEz5GK328HNRhDUTh7O
 IjJPqrVjPh+Fa1fiKV4OEzcP96H0EMbxLnKo7WNXi/EWWVZRJ6gg4cmnURHZ8gKmUdg==
X-Gm-Gg: AfdE7cnYxNvBotZxBkcOB1w2dgpm/3STgn6Is/Svzs4yWz+lvKCftLYX8hLxo8o0D06
 tG8Fs/x2MOM9dfMDNe6FOZmzitcyrnseew8+gNtVigPJA/5CoXHfahTkRlPAXuSRFLivri52rOp
 9w8I9f/kZP3S9bc4TGNhWiSfTAhL0VAe64MMzswxxrutwDL6D9O/WM6QxP47zOXGEeDYq/jEnFe
 Fzn5kcdKUclVm6RvdkoLiw68YoGcSwdDhOvocErXeyyUyYBai3hIzxLb+YWc1Ot09sYrYHgcwHj
 yvtcEbi21m8zszUPNMwOdJiITkGlNdb8KycH9aKsbrd/6/a2EZ6weJ/TNcMiuoUiJr4lD6FUXme
 /X8xTiRnwHYph/x3Tuyiy92vbUzwGX+4B7dfVV5N5dy427ZbtWn+oK3pTyt3M+yR1h2m9
X-Received: by 2002:a05:6102:3913:b0:6dd:405b:26d0 with SMTP id
 ada2fe7eead31-7246d111387mr2970920137.23.1781714460136; 
 Wed, 17 Jun 2026 09:41:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3913:b0:6dd:405b:26d0 with SMTP id
 ada2fe7eead31-7246d111387mr2970892137.23.1781714459726; 
 Wed, 17 Jun 2026 09:40:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm59718794f8f.28.2026.06.17.09.40.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:40:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 3/3] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
Date: Wed, 17 Jun 2026 18:40:35 +0200
Message-ID: <20260617164035.70788-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617164035.70788-1-philmd@oss.qualcomm.com>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfXwSevMAfCoMnv
 eeT9BuS2FhU3lwUOk2OQ1/girax7tPNYiRFSHpxJlbCzuvT6SStVSoxCncRqzwfIpSxBAGZBT1N
 VLvqzo3nReENeu5k0F8dDIgrW8AZ48XHoMiCRReq4FqONum0uG5s9aa64qfvAh8RNe6FCeojt1j
 85LiO3g/Ob8ULiBcM472V/tm5zn40kh5sAf3UJ0lheblaPBMEKWsRvnSRHxL61cdDg7vMk160qt
 wYl7lWqU1BrigrO+RwWJiL6GJvy4UeWgWDvqshN3t7y6DDlKiNSEHeMk/ORZcyQ/Nfls8SsFo3b
 N8eHaXZYLALcX5WN/MWJbh5JmmdAeupUqn+XQIankk40XFStcT447hIOcofrJvjcbGQ/2+fPt/I
 9CIV+9M2KT2TlvmSYozerL1DEzWk8aEJroMtu0kSlRYd4OEj90rLxvKPMd8tIyVPD+MQ/WR9uEB
 ciNubSab0q4Moacq3QA==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a32ce1c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0p4Q2w12W8ILsTrsKtQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: Dl5vGCM2iYgoa9-if3PQpIoaGMAh6yj_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfX4bOaRk3uBmbI
 wMlUtB9JdVWW0HqsgiHJVG/d1PCXdYchLIl1Qyc9ELA9LuYSh3TVSe/mDKHzkmlBKzw5p3Zfm4M
 z996goPdB5tXKuC7PbWdjtegiB/fQlY=
X-Proofpoint-ORIG-GUID: Dl5vGCM2iYgoa9-if3PQpIoaGMAh6yj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170160
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
index 1babcd2b7dd..28d22cdba41 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "system/runstate.h"
-#include "system/tcg.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
@@ -689,10 +688,6 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
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


