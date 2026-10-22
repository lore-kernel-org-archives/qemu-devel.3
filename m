Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C8606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UO5fctYA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIuADa8j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0he-0005XW-Pj; Thu, 22 Oct 2026 17:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hL-0005U9-OI
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hJ-0007RZ-TB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHI4W4086726
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 397+WIQY2ybNLOSVs8NOLYSwYJ+29m21CUbWJyFkndk=; b=UO5fctYAW+mu/Pq6
 meQ2u1IbRgOgLxUrvagayR95/jfbkGxcSJyiDdqeJsb6NRF9Kx6MCuVQ7zhYdmPx
 GBCHflStHAo+GxCc6YibU/HGzTiw9ndzZqr7dVgfFFBashvNjGpNHE4YUXyvwuVy
 MiS3auAVhjYu5xh93n3jTCpk9S2pEArG8UeLGhMWRJnE4uDAp/PXPN92nD9/dOsS
 FiO278OelfD4+asVZJbhXfwsw/5T2EjWGNQjaHNJRwv+ymdalTIwyiyg62mOYYWW
 fBpGXa29lLCSlZbJqkkch5WObffP8yGfYFgKdj//EInuy+8mdKLbPGPq/XNmsEKw
 MXiDLQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrpgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so46808885a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705900; x=1793310700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=397+WIQY2ybNLOSVs8NOLYSwYJ+29m21CUbWJyFkndk=;
 b=kIuADa8j40huzFSPT70eylGw49grw5qA0p9AxBHW/YBhIE1NrfYdr8P9DktDh6xWvY
 2/8GxBlGqUgRqXavtipPN9tKYP+n9I3+WdUETKi3DYNCmPWAasrDkTAi3XkRN8q2f97b
 UI/UPpZdOQUOQbYB/A/0U+IQ2YxU7Wz3RsvhYDUKuPeVG1oH6xJBB4hPllsn5WfkmJ3c
 S8sBGNN5ehB+9uCCG57OEP7ZQynQGJ9n+0PlP7vPjDc8voW8oPPu8tblcbZxf2JEg/hn
 OvizyUOaeP4TEgXVl+WGD0p4neRyEjG8r2MmBKJmCQnwhENN0ihLfy9edMu1eZBF8anS
 1iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705900; x=1793310700;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=397+WIQY2ybNLOSVs8NOLYSwYJ+29m21CUbWJyFkndk=;
 b=t1dEdJas4DmONbrNg/aippbkLsISxnAlLLmC7WXsbGoJjsc2FDFFFYDyypf2fLnTan
 7CZH0gKDktzjJ4w7+5vB3o1XaehhbumUkvyenF7SlJ0FWfed0m18UfjhiG+pSspEmmXt
 apIVIF7tjhCOT4x1roaYZrL/+sO1+y1RQAzYyL3z2E3gP+1xaPNkJ3wYU+GbLjLsWtNJ
 Ylr0PO3XnfpC3Xo4cUAQ0Oew1kxLWvzipLKvEI6RmHysYMs8givPbThXJXk/AN5sojv5
 8nUxgBmLrmYbkPk9AOQvucAbEog+xtObrWWOmvAREZ1XBkdSQyhl1M1Xt2wdxYC85B6T
 YT1g==
X-Gm-Message-State: AFq9FYKuL3pCqj3fT/WvAlMjHLOfR8RvQFpWk32shPzWYX5/UWq1uMAU
 MgbDIik/GXuXgvRqKz2NU5K92kUdZvURXX1s/0x8bDs4iXHXdnN+woKKdi6AlZbScfVNcpJo/1L
 YPaxSN6UZZnHI7wMicymf9/TJ+ujbeTDRFp623RqiZL8IeRy1iOqZolIhn+/WVGKBcA==
X-Gm-Gg: AYBFou1h5xJDGyw8CuaLVMwHVIzLEaJ6NUTEIOlvxM1+JLtkDkAyapm4yYheWxHj1Cm
 /rgb4boIEVX9rtuVpThiQQsHlb5cet3H2COHEPZkzZNiJDueNQtRWY64wGOt7/XvCPlYJBLr5ON
 LWhVNAE6z5WetUx+IfQVcW3nvfYFkB2WJLM+ew0CQ172kyIg9wUeiMXCkrs0UM4CbtswhXat59e
 QHTt0OyxWuNHX9rdyxqYYB+cRaSoXhgpjqzpXAQdcyiSr6YSqdmiOopr771BZDjYiPKbLCqkc/C
 771K01oeGXM/GYUmEagV6TjG5uDzlySZx9K5P64oe0VA4K5nK4gTSLfoOur7gW2Pac+Lp706MHR
 FaQSg8Pzsj/wYfT8xVo34TqTh4fg7EnnsBmKapgvh
X-Received: by 2002:a05:620a:8084:b0:93f:2e08:6420 with SMTP id
 af79cd13be357-93f6f82da45mr131639385a.38.1792705899621; 
 Thu, 22 Oct 2026 14:51:39 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:93f:2e08:6420 with SMTP id
 af79cd13be357-93f6f82da45mr131637685a.38.1792705899106; 
 Thu, 22 Oct 2026 14:51:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38061c7dsm550593f8f.54.2026.10.22.14.51.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:51:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 03/33] cpus: Add helper to log raised exceptions with '-d
 int'
Date: Thu, 22 Oct 2026 23:50:43 +0200
Message-ID: <20261022215115.19680-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada856c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0xCBr3yVtZFRf-pbA1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: d69_BjGETHrHCdsXudhLuqxp9tC43ul5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX7MGSzzZ9iXRG
 K0rxq1dl5o0c7tT3OL8S2XxBWQsNyxscLiHJyQ4XJkH2095DqKDEouEGFMoXjE81g8ZO7QAd49q
 iQ70KZxQMLy+g4TPBZ2sfryHL8DGx2xaYE3MK4j77KmxgqaJqw50WM5LnKuSYFbLrUCOvdTMyfJ
 ywYGZWg0vTjKGYZ1TF6SEAV7omzLURRj7qNROEhmNZP+cTGpzwgQzb3q57yRatZt+xR7PVSuo6X
 T0kHDlPCGQVInoYuJJGGjuKJoCQkJVS6dAk1gDsPx6Su1w+3uITb3BDjBDSoyevTbp92h8Apyxl
 gksP9MlmgJG3xEYQ6SOI4OJfE/06za+BHTDjkaAMr1iymPevfyxkjPyWBZCNid9rnZTCxgXzQgu
 NHJNjnvhET8hyBMBf9TUJeJcu7TO51yCR8m05cu+DfmqxAF9x8wEYO/RmhubHuEIUhsdGw6vkuA
 PA5JFLmkfPuq+pjKVYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6aBXLXWvDhCY
 5Xpt/bzW8vbamOqOmphdTkn8esDNlw0raabbnyusmvoUkgci8+Pk1ublTOlv4js+iAPfm9Dx9W5
 xPk195ZiHmZ1sLr8AhXaihJX3eFQ5Ms=
X-Proofpoint-ORIG-GUID: d69_BjGETHrHCdsXudhLuqxp9tC43ul5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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

Add log_raise_exception(), a common helper cpu_loop_*() can
call to log a raised exception when '-d int' is used, and
qemu_excp_name() to resolve QEMU-internal exceptions to names.

Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/cpu-exec-common.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 68077c8fd9d..bd2cb9d6311 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "exec/log.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
@@ -89,6 +90,34 @@ void tcg_update_all_cflags(void)
     }
 }
 
+#define EXCP_QEMU_INTERNAL 0x10000
+
+static const char *qemu_excp_name(int excp)
+{
+    static const char *excp_name[] = {
+        [EXCP_INTERRUPT - EXCP_QEMU_INTERNAL] = "async interruption",
+        [EXCP_HLT       - EXCP_QEMU_INTERNAL] = "hlt instruction",
+        [EXCP_DEBUG     - EXCP_QEMU_INTERNAL] = "debug",
+        [EXCP_HALTED    - EXCP_QEMU_INTERNAL] = "halted",
+        [EXCP_YIELD     - EXCP_QEMU_INTERNAL] = "yield",
+        [EXCP_ATOMIC    - EXCP_QEMU_INTERNAL] = "emulate atomic",
+    };
+    assert(excp >= EXCP_QEMU_INTERNAL);
+    excp -= EXCP_QEMU_INTERNAL;
+    return STR_ARRAY_ELEM_OR_NULL(excp_name, excp) ?: "unknown";
+}
+
+static void log_raise_exception(const CPUState *cpu, int excp)
+{
+    if (!qemu_loglevel_mask(CPU_LOG_INT)) {
+        return;
+    }
+    if (excp >= EXCP_QEMU_INTERNAL) {
+        qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
+                                   excp, qemu_excp_name(excp));
+    }
+}
+
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
 {
@@ -118,5 +147,6 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     /* Prevent looping if already executing in a serial context. */
     g_assert(!cpu_in_serial_context(cpu));
     cpu->exception_index = EXCP_ATOMIC;
+    log_raise_exception(cpu, EXCP_ATOMIC);
     cpu_loop_exit_restore(cpu, pc);
 }
-- 
2.55.0


