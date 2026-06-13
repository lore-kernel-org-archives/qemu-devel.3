Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E01CD98D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYSF8-0007S6-LP; Sat, 13 Jun 2026 13:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSF4-0007Rf-Sb
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:33:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSF3-00070T-21
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:33:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DF8oQl2687826
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dTpnQ41zGsuue20sXorMPK
 ROEDQ2CTmJnNgFVzF40CI=; b=HZRqzF8fdyXU7Vc/OFRtDcBxSITWTyi0qexpOI
 tIKUntUTtQA65J8j3AoI4X+J/L4Vgqw1kG0Mf/E0KW2oOoBUpBh5OxlavPVGcKek
 56O84s3R0ZcAYynrgFiQfI7VV2ag61Z6bKfWD0jXxdntui9aNfNtiiykV26kjn5H
 yYP+aTADcZHJa3f89DermddP3yRgI48jIxiJyYxxwcg5dn2Z9YG2N81MGgQAWdiU
 KXoV7QJ83MKsJvaKl1VdOTofjilBHPRAsKAcMPg2GAYx1xBium/e7HVl7h/tIFk7
 hWMYeCKmlxqcBhH4dNoIU8yRHzPNL7h2fTYWE0Ef2dxDZ3dg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryybsjx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:33:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91931144870so39088385a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781372034; x=1781976834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dTpnQ41zGsuue20sXorMPKROEDQ2CTmJnNgFVzF40CI=;
 b=Kl49UOn0+W9gnBjCHSFazDqP9VkiYqXdzbuh/Z8j/S7ZpW08ULoQF56v1cRqQ9ycGQ
 5zvnvaD7IQXGN6FW2oJfLvIgx1JNcJfSN3YlQWkeA1WxI7DAIL2vv2ga++lQ/b7b6enq
 /joXzRbONb3UvExkoSvlB18it5LKIRDv7WcBs5sg8B/cfuSFitfjmcWlWqcgZXHFMlsd
 PjbigOItxj5PvtYiulYDzmm5lCMoB7ZRpon88ZFiIOqs6PiNzm6SUWXzJ6tAXqSKGxLv
 fSjEzhX7PP4GcZk8BorZeM8KHBkJI4xoa8HO2K1toIwMt2HhxkTVmkPBRrNRKMcqPUPG
 ywuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781372034; x=1781976834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTpnQ41zGsuue20sXorMPKROEDQ2CTmJnNgFVzF40CI=;
 b=q9NcNcp6r3zi2fiTjC7jLeFOE0R66HLl68XIAEfWjCiOUv4uc+xidaETAoRHP8kcYo
 ApC2SbLOTk6kV1IvkyL98dyeP4NfqRYGezprRlNkf0KbrZPmt6WTlFLXIdyFa31ulugg
 AnFldQMBDAPVfiOXilmmuMWYxn2fTxPw6S/kIIFAIBxOojRNMVgZZy/xWBQ7bIH8aylc
 6MjaFUP2XkyCW4qQzOpxytbTbsGi/EsWbSrV6Pz+pyDw/6uPrNI5UE96BjI/pLarBNEo
 uzQWmGwHCZk8ZBLbWRCZiobPQZpk/w0Kwc6OKD1wh2zvXRhq8vcOlU9cr94ZodSQQWgt
 +c7w==
X-Gm-Message-State: AOJu0Yxl0Fd7/4xB23WmanjiKC8VLTnp8RthSUahGiFIdQjpzoWXsw+f
 pNmPK/ju4mtQxen39lgJWUgyUCG3H2PBXyRA5iLmEV962p6Uk1cW+5keNKODcmq3N/cynyUS3Av
 Y53WmBE1FfPXaGf/MsvVxHE7E5Fugf/9IeoWAKHk7j7Qv+Dm2DEoNTMlDdtqWIbhS1g==
X-Gm-Gg: Acq92OGMUrl0h8hAhtHOwUYIaVgzypkzZZIrvD0OwaXYapAR1RZ0AtO4dP3rmBN8IW4
 cKVL4h3YYwuInNrG6z7+RELNyHiMk5zASkM4LmwAtyThSqpn1u9OzS6BORmOnQ7ij4VCvHdHvE9
 1S7BKNjN4Gnz+H58uRcEbdUhjGLAquBbVBFJgZO6kMbIs+zU+RfLugq2MUDMhHzIzkEq/RzU3dV
 qHC3Me2H/MflqJJJeU/eZztDFTVwzMHXo3DJ8/R0ffYp6HevRHqVR96C2W7iC24S1XU2E8MQtev
 K65EHMMSFI5UMTLfD82vcMIN2bXu8SCLYhsc75EXZGXx5x4akv+LE67uvaEIZ+74hfayJCaPl2e
 vAJMwuOMlKgMQRv17pUxXZSWbmu8gJqfAXAS456qQ8lIRubYh64SquY8kADIcChkyxltTLyi3ha
 jarpRtVZAQ
X-Received: by 2002:a05:620a:1981:b0:915:b9f6:71ab with SMTP id
 af79cd13be357-9161bd40722mr1208956685a.44.1781372033567; 
 Sat, 13 Jun 2026 10:33:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1981:b0:915:b9f6:71ab with SMTP id
 af79cd13be357-9161bd40722mr1208951885a.44.1781372032991; 
 Sat, 13 Jun 2026 10:33:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203c0801sm82080245e9.10.2026.06.13.10.33.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 13 Jun 2026 10:33:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
Date: Sat, 13 Jun 2026 19:33:50 +0200
Message-ID: <20260613173350.99843-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ACZob4miYwZS-EXxz0812ude_wyEYaJa
X-Proofpoint-ORIG-GUID: ACZob4miYwZS-EXxz0812ude_wyEYaJa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE4MyBTYWx0ZWRfX3ENtE085brj3
 1M5CS8Ca6z8lBN5kagsvGZsgTDU//cEW3x8gNBHKLZnjUoByAC+HJOgcAgufeLCTbwWz/0Ivd+K
 nZDcT+Wb/hy7mCNvdmZYOpueW6tL0g8=
X-Authority-Analysis: v=2.4 cv=JLYLdcKb c=1 sm=1 tr=0 ts=6a2d9482 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=O4nC0eKGiR0KFeLeyJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE4MyBTYWx0ZWRfX/a1CD7ob0m9n
 hAczIvvRFJBD9n8VHj7yTo0FNZ9lMcRqmXaSFkusHxeMvv6UODJWs+tWmfJYYXRCTBp0dv2NADn
 rWuLH/rlQ0u5NBdbXi8+UQGEqCb3G/NCCu4PUYDOGg1v/G2LF47akUN76jBRaPtXSs78XYaGfZ4
 FIs9tKtCeoQeOgoupsqTzzSWeoOAcHfAhTIilInTkuGFnOroojapOeTjzQiCnIWyvqQsTlCXL9T
 +b9Dhnvgk8fYKVfudMRscUw94vouMUIw2lLEi1zcvn/tuyiyiSUsyjN1duzBnlCzMe9+o2FG9na
 fbbG2U6Lk77LYiDschtsn9dzcU5HY+9pfCgx8tRjsUF83rLDiqgaiJgNMeRZnEYkM64ENUBQUlB
 v48Vj2h/qp0yh4xY24o/+9tEYbE2zAZsC1gpyw5L2+t/19NJrCs8AR9BjmNKYlnPTyKFsCZ098s
 0XNeLVobwyotaUp1Qzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130183
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
 target/s390x/diag.c            | 28 ++++++++++++++++++----------
 target/s390x/tcg/misc_helper.c |  5 ++++-
 4 files changed, 24 insertions(+), 17 deletions(-)

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
index 01cc802eaed..714ff88e0d0 100644
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
@@ -172,17 +177,17 @@ out:
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
@@ -193,9 +198,12 @@ out:
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


