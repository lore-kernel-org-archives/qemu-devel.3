Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD9606B57C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DcO4fXIQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQEQDjvo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMms-0002fl-45; Tue, 20 Oct 2026 23:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMmd-0002cG-Ji
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:14:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMmZ-0002P8-KS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:14:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FUrM1957044
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GmBaoVMdCwT2LP6J+khBfIaHiJ5Qzmmbvw+E1oGxKnc=; b=DcO4fXIQcpROfRoX
 eDosYQIvVaJ2YkgVHCs9g9b/RBHRL25jajlFbE8xGGAMta25tkjH4AXF+ddV2zuD
 JvVoWlj6pmrGzKs5PERfq4kMot518eHZxog32uvYOdnGynLZU+K/TIC+DAcWEYoh
 gRuSpOqKEigTAr0PpN54PNv11CWqDjEMuU+GQKinMWPmzvO7nRhM9x2s/voquKUi
 UpGGKk+gdc/A0EC/p0IJrhKLeZ8DME0pPulMoJ3d+aTlFSv5UTVtH/7uYAu4DcX2
 NM0KGWxOQz6qGd5yGcmGGmghMr20gfx9ScSy2NIdRRBxkRfEyWDawEe5DqNdiktm
 dCBVww==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvb6j2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:14:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so96474485a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552465; x=1793157265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GmBaoVMdCwT2LP6J+khBfIaHiJ5Qzmmbvw+E1oGxKnc=;
 b=jQEQDjvoQY3di3Kkds/+IbAJBLFMFsmZI3vqs0EwXHUfTb0YGCzYHeB5vjrDV94UDt
 DVggQNqmEN1CwvTgae7njYdiMAnCYFNphVyFFH1arFlzWOAcwxChWxgR/cFpKGzvNzjc
 DbhWvByZ5O3URtEAbBVuOTlEDvI7krxKiQkIM62z5x6gtQtcryqRIMnUw305SLlhVRmD
 dx6LQvAwkOvtop9RNjGWF3+T6yJSfR6gBITegWckjAOh0DWGw4dq0gqARvhSJi8G9qzB
 oLDbgNbV/hnsFqMgKyu6sMMRkSUHivfOcIdGS1mX+0rqsqQbM22ofE0QDddNOLymUTGT
 1fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552465; x=1793157265;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GmBaoVMdCwT2LP6J+khBfIaHiJ5Qzmmbvw+E1oGxKnc=;
 b=R+IJwJaA5GgelMm+FLR3ou5Wo/4kwEKKwyV48MMa77QBoQZ31i1dTZFKlFxG+Kz0P6
 ueQ9d/9WfFgimqJVQk9LsPieBZ5hT6+SZ79TJZTn65hkFoV79qBNGkK7xpK/pOA7L3eI
 3NPBNNxkQRzLzO5K3rlqxxpJ0yrBNHWtZ+AEx9BRgmI6nKxgE6dA39uLEoYUuD/zYMKs
 GyzPDc3wfOLRDO/uIJ+lHZv9h4kyOwIG6gFx3EiXvhSqOuX5hNZAUW2hHq6ufT6zMcU0
 oD8tXfH318nl7I3ZeEwdndzU5p04kgorAYBRLwBVjOjLntbaJnRYfgA4BKlm0dVB+qVu
 Dv7w==
X-Gm-Message-State: AFq9FYL/pH/FKo5ZZvYdm1YE/hBg0ojBHZ7J47So/OO/m+pfp/gMJDMX
 EikpsRoWq5VTnMAEO5YuAoJp9ZEJVZUwALo9XyCJ/69inFwoDJQVmkpEsPuPiOR1DpH+dOxipo+
 uxozNputh0VXHc2FZBm2bwwLqEeJMKnkRBcat+cqvECX3320Wj59d2JdSY/qPyt+hMwZ+
X-Gm-Gg: AYBFou36OBreKydGaojgc0iTvtu67mcaBExeNX1sXVyGyJo1MRcrM3Yfr647zFk/hz1
 YfUVdcBdOm2+7RctqWjPr3dYfMUhpwofsq0wc26jzXem41MWXjLnqVPm2IGSjciR47zm2jV255z
 knGFl56SMf2fN+VCJCIuMph1/Ku3igHNfdd0BsvPzDuYPwYuS6sdY3W4bKfi6KVy1MARsI7G914
 j0FJHD12BL0Q+y0J7u7pilZdWjAEHkA8vVyUMZJ1cK/YMyILC5pLvupefkYJGwyvhO2GIbyAaII
 wsiym2ubLp9ereuhst9svgnyUQj7ll+a1JehU9bVqmgOhrKk1pEbnH5U561TFERR1uAS0wZDyUF
 WWZQLEEW4UMyeG02x/Zqo25U1w7z2BsUMmvdMeHIT
X-Received: by 2002:a05:620a:2a04:b0:93e:c12c:fbb7 with SMTP id
 af79cd13be357-93f57f92f86mr230674585a.68.1792552465416; 
 Tue, 20 Oct 2026 20:14:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2a04:b0:93e:c12c:fbb7 with SMTP id
 af79cd13be357-93f57f92f86mr230671685a.68.1792552464998; 
 Tue, 20 Oct 2026 20:14:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0bdsm2398029f8f.19.2026.10.20.20.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:14:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 02/33] cpus: Add helper to log raised exceptions with '-d
 int'
Date: Wed, 21 Oct 2026 05:13:35 +0200
Message-ID: <20261021031407.24862-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXwdosWQEFEVqg
 ItdvvHmj3Le9F6I6WDxVX9rEi4VJSVd1P+UKhQF+tnOe3jyknRQHm+aFQv9czf1Ls09+Lx+6BL7
 ly2CZnTzvQDrqtBdCe/35a/dq4fFPZ+OX++nog8CdExCBABIzneeSoEr9iDOsAV5iTR4pn4jvlZ
 TYOzJaUFWPZUJ/t3AXM9zfWZp1MBwniTxemx5coztjknf8FbmPwsoVTVh8Yi+2gq6VdORde9ipG
 B//GLJCXVTqenYf36LrcOPcAZQG2bdKWGzFbVd8veEJHcXBhiiEEyp2ltwVHaxb4pSedyZRr+8D
 0lhl2NhtE6V7zjFXNhdkjllLlFAMjAV7kBWxlamrBovTyK6ik8DErR24ANQjnZ8z3U1Qcvqw3+5
 5tWuNX0KQigGzjl18Q2tvwdtj1wFDxn8F9/dS6RTFL89l43Q97eY5/eC66H53rY3ImUBaP3viTv
 SVq/UEGMY7XzL8Jgcdg==
X-Proofpoint-ORIG-GUID: NAiDjK3mHmM03Qy4k9UrnE7Djho9iMpS
X-Proofpoint-GUID: NAiDjK3mHmM03Qy4k9UrnE7Djho9iMpS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX+EjYYKbUVNdX
 5hQnNwSW9h24599e2xBQxFgP8gW5PKPUI8jXuNkKmjEX+P8GkG/vOLMdmElbxBuDeEHP+3PVkLl
 7RwwR5Dq4fmzQLxaiuWV4/Y/9DlKmhs=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad82e12 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=0xCBr3yVtZFRf-pbA1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add log_raise_exception(), a common helper cpu_loop_*() can
call to log a raised exception when '-d int' is used, and
qemu_excp_name() to resolve QEMU-internal exceptions to names.

Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec-common.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 68077c8fd9d..2ac8380d0bb 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -89,6 +89,37 @@ void tcg_update_all_cflags(void)
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
+    if ((excp < ARRAY_SIZE(excp_name)) && excp_name[excp]) {
+        return excp_name[excp];
+    }
+    return "undocumented";
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
@@ -118,5 +149,6 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     /* Prevent looping if already executing in a serial context. */
     g_assert(!cpu_in_serial_context(cpu));
     cpu->exception_index = EXCP_ATOMIC;
+    log_raise_exception(cpu, EXCP_ATOMIC);
     cpu_loop_exit_restore(cpu, pc);
 }
-- 
2.55.0


