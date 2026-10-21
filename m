Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE475606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VYJthidc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F0Dlmefp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMqe-0000Pt-VE; Tue, 20 Oct 2026 23:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpo-0006AQ-Ka
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpl-00035M-Ep
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2me8x4061147
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f+unoWEpyvuNLBR69b+ztcLrqtjbmc4XhPLbiXQofKQ=; b=VYJthidcj55P1Nvt
 49DJMSwTJWp4BzlRmHsw5B/raEhyRjIQtSvEAby/RSWMNABvtf9viZ8CfU0tnR6+
 mjuM8UryWJ1K4zRFCz+WGzTti9XeBx9zSw9e8Xd5XIPatngx2SvgDxSDyVLgEGTC
 Rnjj2RiOVh7ydKGaLtDjqJ7BjYzybQ/wZGvHqmlx0kUlWpOnj2OQha4+O830giia
 PsZApRndr8sqSeTX0VOsQ866hnbMLvaFrLnH58UOQDfDtT1EMLHWUX20egaqdkgQ
 1BQ/LWenqoM1p9p8BYBDDk9cj8fsGcJVCOPcZCMcBinnBhUyxXdnDxXaZ5urV/Bv
 ns9rYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajhrgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f559420f3so33739485a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552654; x=1793157454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+unoWEpyvuNLBR69b+ztcLrqtjbmc4XhPLbiXQofKQ=;
 b=F0Dlmefp+qDwHWWSjq7nraF04YTcpcCSbOWYtl2NN5P+LMWl1hMJtg7TLh+pErDCmK
 5qmghQPDJqRi3iKXmClhqFmFNClYHlwoKMQisPm64B/qCS+YcQPnwNEXAx01r212Gtwp
 z/b6Phro7pfvcRz9lflvrRW7uGXJM2giPPiiMqvH/SKXyTcg01TMTyFO+0bR75vXo+WG
 VwqJ1Zj/yFfkgEL60EXetg4NotpdG5C6AdXoprzSKY5FGK58s3esPGtIY+vF9xETndZb
 Uwbi/bEvL4dfaPvI7FZBSmSNjPDFLs3oQ9f+O+G0sEyyFAk7Vp1VLhSr8QLTc7i/3sgG
 QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552654; x=1793157454;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+unoWEpyvuNLBR69b+ztcLrqtjbmc4XhPLbiXQofKQ=;
 b=apts8Fk2MnC48mSLeRggW8ZP8850HMKAphD+kxFKQJw7F61j0lr84q8DCOIIxVrKX2
 2Y/iKpMFlPeMqKagtApQ9WLzshlPv27LKfPZoU+Z4Eyh8H0+MpOqBpZDexyBHGN5SsVf
 wAEu/XeJV/OmSLgqvvD/kAGhUZreBreQXZxxu8RgpjuhfNzskcyG7voDQNx1zbJwmBZ6
 luu4RHiXXcqIQj76guxxFsFPb6r3LlTev94SvkfR437HP1K2V+w4LY/+nw+Aj0T6vD1Z
 jS2N/fCEO/+T6nENLK4drOjpizqfVhvWxIgmFrzIaFAxbJ9/z8eUKeYqfhh3h8GBUGvf
 pO3w==
X-Gm-Message-State: AFq9FYLT7DGbH5WY4ZcBFFVq9Qkofs+X9IeEvlbWh2PQLRwICZcZ3z+a
 bgS6+mHSanwEMlT04Kq1p20t/oin+k/ctKW+FJ7WH81sHL2fqrRTM0QiRi/bh6yn3BXad6ag8My
 Ks3HEzQRLd2ZI3jsCpB2vdDkL2CzQmXB1jOgCpDTnWixBxrCP7gekMMcC6xRUmSbdeXCh
X-Gm-Gg: AYBFou03m83g1yXeQWZBv1hJsYRPa7u4l2rCf0knfkrneM/HrE2tpPnObK0x7PMs6me
 EQKdZsIpfC1FPbVb+wMIelcLb0fqlGNE7rs5n8JBRbnmucgyHf7P6pC655UMWC3xTQu564aRXz4
 kGyrxXGm6wBLj8lwWufvo2E99mIMUduJjVpuDhfXH8QZfPuubrGJ+V/MeZv2B6NxvJSfwoEQlpO
 Q9+METh3iJpvcVU83nlLfc7fZVesw/KJcKlvGwMhLYi73m0TYJb/cU4DqPHv236wxC5/tXVR1IS
 XxVbq0nu/j/4ddBHKpsmqAz0jNgL16e2LWYLAZmCqFzor8dyPcF8S6DZ1fRB06u25xry8P1ctl1
 KsiJkoC2SXpTwyxh5ZOP9LmhsVA0j5Xoc3AGxqPrp
X-Received: by 2002:a05:620a:4547:b0:93e:c12c:fbd0 with SMTP id
 af79cd13be357-93f57fb9e65mr198326885a.76.1792552653576; 
 Tue, 20 Oct 2026 20:17:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:93e:c12c:fbd0 with SMTP id
 af79cd13be357-93f57fb9e65mr198324985a.76.1792552653094; 
 Tue, 20 Oct 2026 20:17:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0d4sm2394749f8f.13.2026.10.20.20.17.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:17:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 26/33] target/s390x: Implement and register
 CPUClass::exception_name()
Date: Wed, 21 Oct 2026 05:13:59 +0200
Message-ID: <20261021031407.24862-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX7YYM5gE1kBgX
 DeCjAKOHJ2zVIREFaXSF8rQNtCpu5It1cxPAQV5QepDWTyGkcyEMkSKC/qDwhxdYbHGIQuIEH5i
 ogfMCcmNAuQxdUk9f1CIaqZvOUjiuDc4dhe95yT99Ew+HHGlWJ+qkZOROm4KTFFtkCQiCWvxoPC
 9Ws6PXrtgAu63RgwWUfl8OhKL3Qc6srqvkJMrZABOW8a3YaJ+c0JRKClfyC1DsTCVS+fG34po/I
 hRRKZS/C+/ue15KBkkJoBLcWKakfonRaXaoMpt3aSa9yvvpZTpv0SjekQSjz+1WvmTQm0hOC+QS
 xySgK3ZM/1WXuY6euqrkpt5EYxWiIGTKq3ByHhwVRSm6jh5fuyJz0NMEMo0tkak8Ldf63AuLKjb
 fNu6gLQq3gRcpit83Z9WLkipykncDl0TOJkrP33OT3U12TXArDPNJPs6nBR6tL7Z4hFTh6AshHU
 pVzIFUhv2RRYwooRFGg==
X-Proofpoint-GUID: P9XN2FSdAqSiJ4HG819xA_XnBwHSopIm
X-Proofpoint-ORIG-GUID: P9XN2FSdAqSiJ4HG819xA_XnBwHSopIm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXyFsWPET83wTm
 BFUNVWfiuxYsS7FDeMrhPNWK5cQLiZeagXgmQxQCIjqcXRK1t3LMYY5O9T4f7TCOzVI+CESGxQ3
 Bex4v61555H54ww/s0k6lzGhDbCv/2I=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad82ece cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=lKt1HvW_8kBegW_OfZ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Implement s390x_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve s390x exception codes to names.

Use the new helper in s390_cpu_do_interrupt() and helper_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/cpu.h             |  2 ++
 target/s390x/cpu.c             |  1 +
 target/s390x/interrupt.c       | 15 +++++++++++++++
 target/s390x/tcg/excp_helper.c |  6 ++++--
 target/s390x/tcg/misc_helper.c |  3 ++-
 5 files changed, 24 insertions(+), 3 deletions(-)

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
index d7e3fd45e4b..e00ec93cbdb 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -19,6 +19,21 @@
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
+    return ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
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


