Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0572CCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZI8-00082G-S0; Tue, 16 Jun 2026 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZI3-0007Qv-F1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZI1-0004eH-CA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOMr93965396
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wl/l58jF266TXr78IqsbM7hWW/TfYtT8wj4jmm3NV1I=; b=FNQE2GOcQTvAw2JN
 7XeOHWTp04ik0fIsyQusEX0TR/hFsGMGDi8i5n5yPsSBP0YmDoAauuVW15EQruNk
 6HBJT6yyQCEwIX8R4kfVineT++L0P7/QSvVYPMklkEsrnUoZUxM8EbqKPu67nb0D
 Kj9zm03GZ7qst9LkQAD1sn0KxRV1Wm3Yaa60DnCiqPKw5DKq9YKrJEYHDpsNwLTo
 dG4PPCS7WSv1rhIb6Qze4+Ey/TIeuqY+94FTXfOWRyL7n8PkBypJcsUiNNivbRLy
 bFyPkK4oK68YGIgvjSgL4geE4YccYeupLpmuaZV957QXoh8GEyeHyWIvdMBmA2Da
 LRi9TQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etx8kcd3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915d3261c5cso1001888185a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637453; x=1782242253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl/l58jF266TXr78IqsbM7hWW/TfYtT8wj4jmm3NV1I=;
 b=U6g6M2einPGI628vqPqMbjnDDiibsSKbmji6TU5AoAo9n5LV+Zd0Ad3L0xm0udvKAc
 CAHL6LwvREAoJKevDFXk5nJL7Ids1Gm442R4gqLETJoQbgLJulGjYAr1ep3f6XE+lXBW
 pGo0yLrsL86flwhASrVQ9I2vaFnfelw0CMnDlhGUwKWX+AfYh2/lWT0fCvIec7B5JkYV
 grS8GRjbRIl3HipyEZEDAu6xYQaWJr6b2gqcoLlgCPvKUQeeXpmY5dZVcTwMEoQftN6R
 9Qm35qry+KBVowx4xGp68BggJf8dLDwCxQBJ+4gsX3wkAotIN4zyo2z7VOhHeZ8p8SzD
 gnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637453; x=1782242253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wl/l58jF266TXr78IqsbM7hWW/TfYtT8wj4jmm3NV1I=;
 b=awr6nq+FZ92kV0JcAlmYCzLsyWT1IDqZkdJr6/1fq3Ns2ObKvvwu5SWypuKlrXZjBP
 MDgO97xp4TLmERkMhtb95tuu0oBHUD3vdYskFSg2w24GNZW5gY2mYqtySqpXugdWBGq3
 Hxr94F85sHlZMuoh+l+bVeGdv/RfyY0NB9ZuY3E/+tsYUUNAFq1QKC7/mUSARh4wGZOX
 0W2SzYMp6bX4sAq50otxajRBVoxUviUyYmPdoaV/w7NH7zj+l3zPMOBNtU4X3w/X6hA5
 Q5dNIGwpNx2jAYXzi8HAZLn5XG6HsRlEWzb6kJPhxoUgLieWAZeJwVheCzFJ7nYo8oG5
 xRLQ==
X-Gm-Message-State: AOJu0YyZ3pL78x9h9R1qqeZ6EnlotUkfovuoamnxJpQI3YX97Z0i6M7o
 U0Vm4E1HrJA/J3sOImP6l7Ug8r5w8VYwBk7kOdRGB1nRnv8573VHNRkacHuw7a88SFGsEfHSZXY
 snkjzZDj1cVgDaouizvlVg9tcKk/DM7SL36tWn1ADKWMUWrNQ8wv53ChD/6zksu36ww==
X-Gm-Gg: Acq92OEPkt4BpDMVeWc1a+wo0SUlXljWD58Fr61wJ3haCv6ksdOActG8adgqh4bw73x
 XeuZp/iTTlUE6o3QXcv2Rdw/nHtwvgoDlWvYXcIWSIykQyy6QSh5q03TuQ42iOwsKitG8AMDS1i
 gHP1Mpyn6w2mA6T7JXhiwN6FJaxUrDbiKxBaWrOj4jsYqXiA0LBm8mihC2QHpmsGjF4DlbDWtMj
 /R71eXlw5j/y0Dh1RzQwz/ZokWJM7GMGKxkM46vQTF+lEO6HaOzPt8uGlk9dRUY4J9lzQCVz2ee
 uF0DOfzaUNSVYVpBK3CwkF8S7BE9Oucn2EySDUMdopiYi5Z3itkcGDg+IQxpVA36d++O0tQ7ula
 grXZQZTmLdyu/sOXfhg3KG/nRKudy0UM3/ggPauMklgrZsER6fblhRSDg+wpjq3bWiw9PGbVatX
 dRpOs=
X-Received: by 2002:a05:620a:f0b:b0:90f:7732:4bcd with SMTP id
 af79cd13be357-91d8aadf83fmr179315985a.27.1781637452996; 
 Tue, 16 Jun 2026 12:17:32 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:90f:7732:4bcd with SMTP id
 af79cd13be357-91d8aadf83fmr179310385a.27.1781637452523; 
 Tue, 16 Jun 2026 12:17:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462236047c8sm2124542f8f.10.2026.06.16.12.17.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/10] hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
Date: Tue, 16 Jun 2026 21:17:08 +0200
Message-ID: <20260616191716.12932-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfXwK137k43I3L5
 ykUiUb3yO6LHTANYzXvWpfXIsc4WqI0g0xMTWHeRRWGuoCx/BYK3Eix50sK1IFz8DIlErqtL+zX
 XUGbXfMbbzWEV0TAKrxwqdNYAD4GsyqPKOSY0gcPzL/IABNe84wZbkai436voGyA2Zpcp0TH9BV
 SHGNlFdt4HCAxtqAZms/SdhCALA39qlGYrGCaVVRj+zxyLZ8RvnBww56cS1T7xc1FLopDsak+6W
 JeUbI0p8K+C/3J27y9UB8RHhXIgOzw1htQ9hUHLH/Z0Yl62XM6gB/pb4F5TvVwl6637G3mi7csS
 9zcfMqdmpqd8+R2/lFuc/CwlRaBZLL4MVhL5ofTM/AI4VCLHjpfXkgZoBh8DAlLuxPZ4tJvYc/o
 8VKZuoa+Hr4ZrGGxO99c8oRB5mEK6p8xsPWsNpfYCYl9Jws+gb2JQukMAZWauhmqxlnMX67BDpv
 +8U0TZ8a2R4wmZIDfpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX82NkS05DWLfp
 ML1ii3VE04sXJiZKmFRaPW0WqAP6XVoKRwWUUTk7l1KKo6lzvEqDDiNEsaubyk8tx0NSeoOzMTk
 tY8f14kyJvig0O2Wp44t6WLu8Nt3eSI=
X-Proofpoint-ORIG-GUID: j4w0vrSK6CbdRFk--d0yw7fuKOfWBHyg
X-Authority-Analysis: v=2.4 cv=dZawG3Xe c=1 sm=1 tr=0 ts=6a31a14e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=O4nC0eKGiR0KFeLeyJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: j4w0vrSK6CbdRFk--d0yw7fuKOfWBHyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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


