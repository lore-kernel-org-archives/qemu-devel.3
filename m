Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ADBCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOJr-0004tD-NF; Wed, 07 Oct 2026 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODL-0007bb-PO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODK-0000Lq-1x
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jnY03334832
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GmBaoVMdCwT2LP6J+khBfIaHiJ5Qzmmbvw+E1oGxKnc=; b=coiWrPxZi9a32HQ4
 mJM5qJCkUhKq8nmnrlXvqfnP1eBB/p+P54ic5yGC0RIxQscgI7IXwuoLRVxlHWRU
 UGRXKfsxutEuCZE7oeTpxVX+rWi16nkZzl/LxyGnhjBU8QonhJ3XDvuYJtzykzd1
 CWNC8rbYa2k8qSd1M0G677xdBTFC2UgKy49OAHbUa4x0OM/JUJ3ZS0ngz7yykcin
 ZK/3m4vAGqqOAOp26WVtgfHYki8yu8werBAqULINDNpY16IK7YrznmQT9OnsXzf1
 3a+31u9Ee85Ho67W1wUK61VZgO5goN54vWRiHIr9j5sIK9p5zDKjOqpQ/c3hUUi5
 w9G3aw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54623fsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:45:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf7856ffso672569185a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366327; x=1791971127; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GmBaoVMdCwT2LP6J+khBfIaHiJ5Qzmmbvw+E1oGxKnc=;
 b=MLC84r7LFAr+t3BHkjGYUbq4GEXLUPuqbBDcJolVZrRQZOdZgmSD2KBHuYnkeamLw3
 FXjuNf3IySh5U7qgRSvUzyTYTiVY5cCiQhVg+k9xiQnaA70MLYXq6P86t1cziwevWmju
 qWZIrD+nO1g4Kr4/D5/DHoEaaHsG6WtmQiYxjOvhZ1n7Vu+l9/uOMER/0r5ohD6suSb1
 8usroXi3RtJJ5W6uE6yMzWphbcKuq4H373F4sTHgRuJiXTCpEBrQmU54iwpHcGjHj5Y0
 pFu3/wq2C4kPOuzC9BfI8FfuUUK1ERv8l+Ot9diGkQ1MU+GPAXOXEbk76+aherRa48IQ
 vdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366327; x=1791971127;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GmBaoVMdCwT2LP6J+khBfIaHiJ5Qzmmbvw+E1oGxKnc=;
 b=w393rYMdjEQ/uoNTI+8gSmCOM04ssI6f/19TA23tAyBx7fgvNE52e3YVDtkZNnyqTf
 31lWiJ7r9iTREsxB8/3lmB5XInLK90nrZz2uR+SKuW9BW5olPP5qV86dOO7KCAKxT+zg
 pGEcjC9a8d8HZAb/ntZoNQrjB0pP6AOmvMxA7ogl2hY/4szpRBpLw2712VNaBMqiGC+O
 tOqZO7OZ90SBq3POAMymUuBGRIi5WY+oUYHJ3aZC4wv+9inyJTN3EBSX4w0u5X6sEzxx
 Tzaqkwl4AAD0LQhY9l7Ly4cQyXeFZcXjmVYqwHfO8iZN4x5lOEuFtCuzrrw2Hg4VUE4+
 oVQA==
X-Gm-Message-State: AFuF++n7Gqy4hscmg0Zbre6NV8I22Y1VRpEYOBuCfYAHXQ350t15ialV
 nCsWEfKiaVCOQXzU8sHp6cDcq94FKwlkMTljiEVexMbdvy7p9grZBXmCGyNrOvw6UbZ4pFjpi2l
 SHOfr2VO6bXXWH9i+3EmWrlVp8ZXiWX8nhHFT97LKyknlKN3NOXqs1b6KK6+1caeh9CFA
X-Gm-Gg: AYBFou33rZw6qwirqnZL+EYm8i2oyjahCW5mgngzo4IGcfdxUqEkPBtO9gTnJz9n/og
 QfxfkHPJrMHbczXJXpF/xyVuzSVPTJ98C5n68bkgJ5vFoeSPFnNaW+SYtqm8q27YD7KNtPucxLM
 0pLO/PTDlgzsEZ9RvxDh1+k5TcdwmVV6q/PZr+82R0zJ3mGkKH7U6u74C+qW9JJxwDVDwM28FUa
 en+kMqZ8Ktwjj1BFBDhuDR4hj/UvSQpOwKbWm40Vd06XpfX40RZZ3g82UEzCYtjNQffvlLjsUHt
 xYrwp4GHP7u8p5Zi7tr8cKRKUzqF4OKe2gg0alKypHEzqVxr0UBGUgQZIP/laU7h0NyavgE8bhE
 EhIXmOz1UV8OOY9PbEpj1SV/2HnayFDD392ui110U
X-Received: by 2002:a05:620a:17a1:b0:93e:8c7a:bbf7 with SMTP id
 af79cd13be357-93e9b3473ffmr314285585a.10.1791366327218; 
 Wed, 07 Oct 2026 02:45:27 -0700 (PDT)
X-Received: by 2002:a05:620a:17a1:b0:93e:8c7a:bbf7 with SMTP id
 af79cd13be357-93e9b3473ffmr314283585a.10.1791366326536; 
 Wed, 07 Oct 2026 02:45:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c49c35sm154948755e9.9.2026.10.07.02.45.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:45:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 01/27] cpus: Add helper to log raised exceptions with '-d int'
Date: Wed,  7 Oct 2026 11:44:49 +0200
Message-ID: <20261007094516.75732-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CTyYdRV66YaK8F3nESCm7CIxexZ4eZ6E
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac614b8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0xCBr3yVtZFRf-pbA1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX7RG4MN6bEsQ1
 u0iBxiAQ1A01tcd5+pjjBoPn/audvr+A54OVW/isuZi+/LCXuAYs9D4nPdKmujDgqIEscleeNfq
 J9xpmsfGMDbvnmeIcpXvp9ePO8F52+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXyswLwAdOJJc6
 U+vMo7O+WGFi2vuY4pzGkI/qQCVYVboF7zmWHt62D4GIvAyTGZ18O9xkBJaTEWQ4T3IoaKrhUNT
 L4r8bOs5hHkmgVVEIB2UAQJtuoU+4vZidcCerItxq8Uh5XbFj9tIsDPUeNFmxubZ8x/R66GcmVp
 bXWKITPehJhggqihnIYquGp3I1f3M9pHQyLvqRgTMSZO5oqCgFVMtvMqvONsN/0wUHETyoqL57w
 Wx8WggwxA+TENaLpVEKTWcthcI8uV+Ym/hiN68j3Ableq+O2xy7GPpchEieqC16QawQGWICqF0T
 NjomcKOI03Fhoz4R72ZYJpN+5zJNPzAON8uVEhgMe7qi5WQDTqaLmIjFcIZCG+g+92V98cBnzOJ
 o6EIdYpdoGeupubeLZTjaIuSWjjwyuM+aQCtvgvRLTRdE8mnB2EGwqBJLk1rGA6s3hNP/5a4jeI
 WzxsGMWp74f5A1Ek/+Q==
X-Proofpoint-ORIG-GUID: CTyYdRV66YaK8F3nESCm7CIxexZ4eZ6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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


