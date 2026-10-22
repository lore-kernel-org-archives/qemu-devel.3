Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28F606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFxy8InM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eid5zi3L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0lC-0006fF-P7; Thu, 22 Oct 2026 17:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kv-0006Y3-Mo
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kt-0008IH-S4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLossW859259
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4pZeHr7fQSTYV4Cs9i/OIvuyTVd94XKDI/q3PP0LM9M=; b=oFxy8InMiY8Dy9Yp
 QcDtRj8TrP3hUPgLmV3WdjXkEW7DwpgfP3y8xe9ot7lw+g2NOd9qR7Tz3XHn2xFH
 q2OJa+B2y0OlW9DcEYvMvns8kTsdp9UHxZLaxN/ocxB9mtXImT2dQT0pMyVu9yHz
 DpxDFrFHdStudja91SIh0IHt5+HsVSGuQ/LlJ4C9zTKtcGBFxHlD7lT39gAB+Tq5
 3tBObknCIkN4F+7/EdLeSG9lvJk0Xc7MNTIjqMUiVijH/O/3BvlRw9H3S0NZXNIC
 DBw2UuCjvDzSzOCOxWtPr7OY2imGW95n+hqPzbT0p/KxfNWGlVycLRhtuD7SGzk6
 MY8mVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw17wk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso43602185a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706122; x=1793310922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4pZeHr7fQSTYV4Cs9i/OIvuyTVd94XKDI/q3PP0LM9M=;
 b=eid5zi3LV+RiBB3O1lRFlv/otNsMPwvtRLCW6yGr3ywIwknRRHH49f5+f5RMdxzdhY
 IlZBxxBMnwl9Vrj34Ivl0jXONiIsEKJLUkS/8sW0WcdOlcso55tEnKzfuNn+TOaZ77PP
 /zYxfV/hO0lfU3ll0oq3ISw92F48SsoPO3VldlwzJJIbUReYtLoZvoJW+19ppyp8zsV7
 DlSaRBUeOOBG8zGrojOtly6PSVrN3TLFHz/EwC9MC+Md7Mi+KKyTGSPT70Bz6SHSpTRB
 Sji5+zKvEilcEHOZ0jINlC3S3A3LURIkX/IVKdc4AhzuLQmKw1TEmjB0KGPmS2UB/Mpa
 Cj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706122; x=1793310922;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4pZeHr7fQSTYV4Cs9i/OIvuyTVd94XKDI/q3PP0LM9M=;
 b=epH9J1oLeZyBapuHVJ+z2jp0bFefyW/hb/fgcfEzclVHrzq+OryX7Kh3T6iQGD843i
 1OvYpENnC18/FQ+GFBUnPyQwMZIadg5sQhi78ZXGnTIaRQGtO14z1OII9py1amXERC2+
 1DuepHj+q6ohHWmW8ZsWOMvDqycPqdpaJArNb/a6hiRDQDlRPBj9ekt0LHjg7JjPShKB
 WrNp2gbyJ6LdO8+T9dnDyMXkAv2TekbZuRi5EK/JQM7VEZVoRNfiLx+mJGujgFUF+PHh
 sZ5NLdeeTB1ro91VA/PRidBydW+tyZJrCYPMv1fnyYorJacx22W50tynhF4bNd4v8d6A
 2LqA==
X-Gm-Message-State: AFq9FYILbdskexXUvdfEbIdokQCHZPhFkc+ilQV9DGoX0zPt1Gao4iC2
 6AeTP3DpG+tm7Cs5BObsWH/GJGbfM7L2obHQYa/PiW+mfmOutR622U1eAQ7lJjoWxqK6V/SjwIp
 63nl4cIa6th6Fm9FNdP2uQEaf2f3J3uiVOsgPGeUyr1CbQStnrxKkvDfmSdQTAqFvzw==
X-Gm-Gg: AYBFou19CIgWY6pJK+jRdhrkw6OnK3u1cmer9hRZhHy4kC2RYTH/rM0b4oY8C4NmB/3
 AipkW1yzc9OQ8feHo7hR1echATnL6/m1xeJIlEVpfAAcJZsccx1xh8m+zrDtBqZIdV0kL0xpiQT
 IBl5TTgWmuWtVsDJEwuqqOI+miRFF+BTXUEu37yIOnM5IaQ8Ua82Iq52FBnn6bcL8PyFm0RElu4
 X/ANZ8e6iLI92lsQ8H+TLnO53J3R+eYVwzyaFpmr1yq2Y2DYOkE1xQY6ulg2Wnq3t40wY0N79tW
 LKWhu/uavYPouJ2oAPKlm08EIRZkFGu3jhtRYUWOyD0VE8StMKdc84bogi5DvFXh0r520SfVfht
 ava3fgckrH6CogVI63iKFLnSXcq15vx7i/bLaFzkK
X-Received: by 2002:a05:620a:1b98:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-93f6f782e79mr153932485a.29.1792706122030; 
 Thu, 22 Oct 2026 14:55:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1b98:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-93f6f782e79mr153930785a.29.1792706121577; 
 Thu, 22 Oct 2026 14:55:21 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38031494sm559037f8f.26.2026.10.22.14.55.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:55:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 33/33] target/xtensa: Implement and register
 CPUClass::exception_name()
Date: Thu, 22 Oct 2026 23:51:13 +0200
Message-ID: <20261022215115.19680-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zh1Pw4lRwGpu06ky6JT9Ksl2gskYk9RX
X-Proofpoint-ORIG-GUID: zh1Pw4lRwGpu06ky6JT9Ksl2gskYk9RX
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada864a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-R6i_BgWeFa1qxdD66wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzM1fnfsUZ/ra
 y+xPpKo1TIk3CplptdVvFlBX1pHEAudFOiqeQiQ6GQ65IaXU7hybaznClIGtHfkNBsyuPuHfGbm
 xj7zbAVkuwgOqfgbqBlbocaJgYa2U/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5GWT8oWlS4pq
 OJWw9ywMkQQTL3o4OpPXwlcHhPtna+vFxkkIKkkN6zmSllR1vDIux9mKr0K1+MkO4Fj318V9jhp
 Rm1mC5fr2PFieogTVxdisLHJDmN7Xbv1+PlyUTF81CwugbL8GTey+JpUhk6SXms/PhffR3q9InH
 q32wUkUQKpiCcFgebJaNpPnD0ncM1JnHRYVDtx6kYT608xNeADXY/NJDcBqLo9k5WKQpDTuAkYm
 SnNbRi5Wi+9Eax+cyzdeH8XO5b70JmXcRz1529O0CSURMtE3IG1w+tRIyAYqlYNc9ME6BFK+mP3
 sie4M97jNRvSTVQCOtIPkxSFC2IHaG92lK2nqNXhQg3B4aMVmbf3Mh0wPILtsNL7rIBmj8P6KNv
 zsOIt6zow/VbtChrIJMsjgl0l/tQFWWnUOYdQF3BURnWWWXGkpbOdwl9xPDlzfcNzUw1wDLlrG+
 nPNWJ6ccMvaVbuWt5+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
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

Implement xtensa_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve Xtensa exception codes to names.

Use the new helper in xtensa_cpu_do_interrupt().

With '-d int', xtensa_cpu_do_interrupt() now logs the exception
name after its number.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/xtensa/cpu.h        |  2 ++
 target/xtensa/cpu.c        | 24 ++++++++++++++++++++++++
 target/xtensa/exc_helper.c |  3 ++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 49d6ad9083d..3440c27862b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -262,6 +262,8 @@ enum {
     EXC_MAX
 };
 
+const char *xtensa_exception_name(int excp);
+
 enum {
     ILLEGAL_INSTRUCTION_CAUSE = 0,
     SYSCALL_CAUSE,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707..169d6835418 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "exec/cpu-defs.h"
 #include "cpu.h"
@@ -239,6 +240,28 @@ static void xtensa_cpu_disas_set_info(const CPUState *cs,
                                      : BFD_ENDIAN_LITTLE;
 }
 
+const char *xtensa_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXC_RESET0]                = "reset",
+        [EXC_RESET1]                = "reset",
+        [EXC_MEMORY_ERROR]          = "memory error",
+        [EXC_WINDOW_OVERFLOW4]      = "window overflow",
+        [EXC_WINDOW_UNDERFLOW4]     = "window underflow",
+        [EXC_WINDOW_OVERFLOW8]      = "window overflow",
+        [EXC_WINDOW_UNDERFLOW8]     = "window underflow",
+        [EXC_WINDOW_OVERFLOW12]     = "window overflow",
+        [EXC_WINDOW_UNDERFLOW12]    = "window underflow",
+        [EXC_IRQ]                   = "interrupt",
+        [EXC_KERNEL]                = "kernel",
+        [EXC_USER]                  = "user",
+        [EXC_DOUBLE]                = "double",
+        [EXC_DEBUG]                 = "debug",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -348,6 +371,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, const void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
+    cc->exception_name = xtensa_exception_name;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 7cb67d179a8..ff71e5d6462 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -236,9 +236,10 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     case EXC_USER:
     case EXC_DOUBLE:
     case EXC_DEBUG:
-        qemu_log_mask(CPU_LOG_INT, "%s(%d) "
+        qemu_log_mask(CPU_LOG_INT, "%s(%d:%s) "
                       "pc = %08x, a0 = %08x, ps = %08x, ccount = %08x\n",
                       __func__, cs->exception_index,
+                      xtensa_exception_name(cs->exception_index),
                       env->pc, env->regs[0], env->sregs[PS],
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
-- 
2.55.0


