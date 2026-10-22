Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DF606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j9DOTkvz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SNBy1d2o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0kG-0004mH-Vm; Thu, 22 Oct 2026 17:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kE-0004dr-4n
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kC-0007nR-9U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIGYe93579047
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DlS8nMfyuUr8+SqfwQ3mSYpjBfIILWSlerArAA5KpUM=; b=j9DOTkvztmvwq3Nd
 krtzblYT4QnXUyal6EVRpaEIOXG2dLJmzowHbmVr0htiE5hHcYicG6Vn6j5if/Kb
 AwmpXAwO0O8GYQWgvrfnnCLSzhRL4xh/rpIFJ8xTT/2UobEWEXiq6JobVj4Kq0Hz
 DDGxggh3IVdOcHDrGFt6KWS4m3wWFMeXMUONOy+9dIZ9u3qvMMoXooiw6Sjt//GP
 geHGJbgxKqcRdB1LqvVa6sd9ygWZCwbUE8k1YjL/w0pczgMHkn0M+UpiL+NH1dCE
 IKvqqngT2BaENmq0tfVSszoUp0qlNIydck2C7ee+DwnM+uBuipVyWja/KcvJGqco
 +fF/uQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbgqkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so33712885a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706079; x=1793310879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DlS8nMfyuUr8+SqfwQ3mSYpjBfIILWSlerArAA5KpUM=;
 b=SNBy1d2oU958ewDxlPy6WQmMcT4EGgbW1iwpuURWOLzFqgK4cLK8mG92fcLm9RAFWW
 niU7MqXiu2R+zZuu1i7BjZ9JIrDiFc+2fcTHJ1zzsgncfP0DqH1IZYLGnPpXKne04lMA
 u5RJ826fKCKDn2TRiTAG37eef6iV4EcnlmYODrD4AeOTQQPKrimtvmxCayYypAvgecmT
 MoDkg+R6oCzYNoyei8CKCLquC0vpTbihc0YD+g8wokkYRkVqhRv03FzIrZwqS30Y1QLk
 7kr9Uvvyry/4cpoe5NaNL1P512YWs/rDAMaOVB5KpCuo3Asl4ybc/pOnpZGTAsxkBcl+
 wzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706079; x=1793310879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DlS8nMfyuUr8+SqfwQ3mSYpjBfIILWSlerArAA5KpUM=;
 b=vOnlPwf+LVAuu75JCiGuZKvbGg4KradrD/k9mJpypnWqbHlA6fEzBcvGyurdHtUTDd
 pPrxg446mG0cqqc8cdfgSKLKAmj6zg6F0GF2rAzaWsRmr3PjIMqLJwRAK3cOWlUP6j6j
 t20FVSfAZm2VHbY0RERdWlNEHJo+/6Sq9aQ5qTiA715CWg64eHaQylAf+MvXa4+T6ZpH
 9zVx8OM8ngc6gyIDlbBTmc9H9zY+hAeybw0wuNPGOVCKVi7Hutm9GPw0a9t4M6rgip8V
 1sqgnVLBYdj0gfmNhgI7MEXKVBiAXywvG7dZrigTZi6fkAZLopB2Szmfp2sKaXL7xJQe
 hW4g==
X-Gm-Message-State: AFq9FYIiPbQvq/RvJHnApn5C2/MJyXstOOTxlUDccPOiIL9/E3xKQ5Eo
 McTYM4T97e+3jAHH5uAoGMAEWm+Noes028UUcG5IQl7B5x8zw3ex5R2xinS8YnZXdZ6T9cxKdNp
 QLVgwSkeQddbgfD5ZmV15NJMix3exRuPgIQWJBqPnfPGlsHqJDXhozI+Ta1TTE6sr7A==
X-Gm-Gg: AYBFou3ozaFuSJorwKq3Nbx+yr9m9exuXQ3iAobGYevnyyVAEWcjXhsMhqJlms/Mh+s
 Mz9GeE+WvuirM9+KQf9SxEIWcLlWrccoQVFt/ecxsfeWLGrgerC0tieCXDntnFquJrGgUPYyzzZ
 GiUfGMuAis6SSOwlRgRRGjg2JR0FlH9EXeE7cw8LRSrjcnTzRWvw821B0XS3IryJKklcUx01/JR
 8lMk4D8Sj9fmb+IZ9Nhl+Y5IYNJWIkVBRr+C1F70hAN72lycgnoXXraAnm2rMwkfZX0Scbrsanw
 fvp549jgzv7K4zHCYYILato5wK/rqQKDHxvQtYocJhLPgWg/6Cvh7C1MtGn/YePphfGGSjwHUEv
 04+rv75oFDd/rVH3Z9cvdot1VR2DrgZTyYu27jAwz
X-Received: by 2002:a05:620a:17a7:b0:93f:2cf4:e6dd with SMTP id
 af79cd13be357-93f6f9a285emr128633685a.51.1792706078342; 
 Thu, 22 Oct 2026 14:54:38 -0700 (PDT)
X-Received: by 2002:a05:620a:17a7:b0:93f:2cf4:e6dd with SMTP id
 af79cd13be357-93f6f9a285emr128630485a.51.1792706077847; 
 Thu, 22 Oct 2026 14:54:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38061f41sm643430f8f.53.2026.10.22.14.54.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH v3 27/33] target/s390x: Implement and register
 CPUClass::exception_name()
Date: Thu, 22 Oct 2026 23:51:07 +0200
Message-ID: <20261022215115.19680-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5MzhBLELOgQx
 XLaonv2NTgQhjJheLW41mvOTcwgRyotUSu7DPod0cHW6hw9BV9mzQFXu9+SBjeN8ilpWkhBlqnn
 Cnqog5WycyWDKO9Ssh0KT0VsNt0V4zk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9qbAfEU6i86y
 Ey7W90eL6yWE9HRw369kVMKbWBaOfbPilMl7P2f05ws0qOTa5GUZ7jFQQGsGqCg7qTWj7R+p+LP
 DWKYGPRJ9TBqY4ZlBQvX23cmZxpoWY3Dm7k785wXmPq32XG4I+EXWxs7ketkPUrNmkbb5LY+ksn
 CajVACsjo+pERkBKNYF9gcOSz67OkstAdP/7cpxfnUDywzPFLEfYu69oJ30dgroQcFijsRJjC6Z
 A3ZSWuzoAlZleG32cgrGpkS5Ti/MsmWOEZJAVc+1NsCMhdabD81ZMiAHnRS+NIuiWW6L88zDeiM
 NtLHFdmLGpbRk3XNiBxZwrUxxdQDqtcyg3FDZ5GO2nxWR1xtG3Hx8ma0j09oj6jIFtq6JjE43Ym
 qkdbsZVxUpfh1zkaqu+2HjMw4bELsFJ8kS1y6WJ5170sQ2O8SauQg+eh4AwryW2Qee3iEpoQvRD
 CKzq2aT66V1rWPIyBGw==
X-Proofpoint-ORIG-GUID: S5eKajzViatT0GmnFKNXQJDsqySxm7ZO
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6ada861f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=u-qA4s_dmyebC3KKCgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: S5eKajzViatT0GmnFKNXQJDsqySxm7ZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Implement s390x_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve s390x exception codes to names.

Use the new helper in s390_cpu_do_interrupt() and helper_exception().

With '-d int', s390_cpu_do_interrupt() now logs the exception
name in parentheses after its number.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/cpu.h             |  2 ++
 target/s390x/cpu.c             |  1 +
 target/s390x/interrupt.c       | 16 ++++++++++++++++
 target/s390x/tcg/excp_helper.c |  6 ++++--
 target/s390x/tcg/misc_helper.c |  3 ++-
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ef73b15218e..37b6e541312 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -437,6 +437,8 @@ QEMU_BUILD_BUG_ON(FLAG_MASK_PER_IFETCH_NULLIFY !=
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
+const char *s390x_exception_name(int excp);
+
 #define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 85afc5dec9a..275cc6cd53b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -408,6 +408,7 @@ static void s390_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->exception_name = s390x_exception_name;
     cc->list_cpus = s390_cpu_list;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index d7e3fd45e4b..28174522944 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "kvm/kvm_s390x.h"
 #include "s390x-internal.h"
@@ -19,6 +20,21 @@
 #include "hw/s390x/s390_flic.h"
 #endif
 
+const char *s390x_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_EXT]      = "external interrupt",
+        [EXCP_SVC]      = "supervisor call",
+        [EXCP_PGM]      = "program interruption",
+        [EXCP_RESTART]  = "restart interrupt",
+        [EXCP_STOP]     = "stop interrupt",
+        [EXCP_IO]       = "I/O interrupt",
+        [EXCP_MCHK]     = "machine check",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 /* Ensure to exit the TB after this call! */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
 {
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index d952bb20cf1..83fe65e1f8c 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -508,8 +508,10 @@ void s390_cpu_do_interrupt(CPUState *cs)
     bool stopped = false;
     uint64_t last_pc = cpu->env.psw.addr;
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
-                  __func__, cs->exception_index, env->psw.mask, env->psw.addr);
+    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) at psw=%" PRIx64 ":%" PRIx64 "\n",
+                  __func__, cs->exception_index,
+                  s390x_exception_name(cs->exception_index),
+                  env->psw.mask, env->psw.addr);
 
 try_deliver:
     /* handle machine checks */
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f1c8563af00..a01c5d894e7 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -61,7 +61,8 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
 {
     CPUState *cs = env_cpu(env);
 
-    HELPER_LOG("%s: exception %d\n", __func__, excp);
+    HELPER_LOG("%s: exception %d (%s)\n", __func__, excp,
+               s390x_exception_name(excp));
     cs->exception_index = excp;
     cpu_loop_exit(cs);
 }
-- 
2.55.0


