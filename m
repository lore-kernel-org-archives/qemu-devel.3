Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gGEM24dz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yx3yYUlP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUE3-00030T-Aa; Thu, 29 Oct 2026 13:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBv-0000Fa-SW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBt-0003x4-Mc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3xB1143411
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YqkFJm/dcpi/cCeqhUcTxPrdos0noHZTqyRPrgJpPSk=; b=gGEM24dzzWxGIjFR
 nwxSNl8Aj2Gl+6M7+GiaD+ITYPXjHljYFW7BlbZk/YsnAaXBiQknaeYLvVobMNPF
 O2SK/LAHGiGGFSqav+poPycWX8B/IgPLhZPMeyj9jZ+PBQHAWViIPDzrVA6WuxAz
 ojlf19S7LHIiqRfVoZYYYMUBOZcc9OY4T9yfcG/D6w8jArhzLGGvWpV4IXsX16tE
 hMvfq1skfIHCC7+nijPHO6OWr446Thw18rlYoDxk4Xu2yNjAexXesTt5K8W6C8ca
 472uLilHkBP0ruh2+TlS+plVZPq+m1WIbYDX3e3K9dVAsGEWuqWVZN2AkxxMnnmW
 f3fK/g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76chsj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91becce058aso48828766d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295928; x=1793900728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YqkFJm/dcpi/cCeqhUcTxPrdos0noHZTqyRPrgJpPSk=;
 b=Yx3yYUlP7qsuyWlDIhFt3/Wy4pb2E8BqlSqirsR9EsHRWq9Hd5WggeU4scfgw/k2qo
 Urw+CFPHTuaANWZNQPi68UZ3JzQqGvlsQt758j5BstM11mJKncRJgoECN+bWhoezxHAR
 mWJ2FTCzeJCRybOjvu2niSNWI1pbJUdC/rBN2O4x+o6SkdXAZAbHqJLZPfrzuyHSgO+0
 qrWmzgtmnkJocjUIJyBSy+6fJzaf91LYDfocipDN2FRjVtV5eHH9NyjVsf2xZFyiUY/s
 9Flr7ctdFIQKVFJTHUXxXygNFx96GQj1Pw/IyvNN7LQKdDk1M0jSlIFgIpKntaepbNZh
 KQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295928; x=1793900728;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqkFJm/dcpi/cCeqhUcTxPrdos0noHZTqyRPrgJpPSk=;
 b=K2wZpB8tMdsTHPjRHQOTAkWDW6oJmlDdH05adkvgEfee6EgIJaLsjuKfZNBeDuq13j
 sMbJl/sIH143F94yQeMayZAnDb2HhcNml5L2JFK/LRD7RiKs7XRcl3yQysWtSJH0H5td
 Omiu/JwnF1e22JjHDTbg2EXrbfg+ftQcPcuml85KRi0HYevIxGBy7yZcJcL5gOOSkQQ6
 Kr1/y2s93qMA9r+Vs7eMbwdh+MZ6OCuuC2tEATmRv9gZ9vzSpEUUeGI+XZXWQoRdLhfx
 c2WZI9ZdRclDdPbu3+HhcD7lhjAn+cjPOG71N8tkED8M4TTdf4b5tCT5vuHWJ8CVXK9K
 QC+g==
X-Gm-Message-State: AFq9FYIoerh0KHr17KEscF48gp9QCta7eVj8nbAb5QyG18/PUzKa8cTB
 AYDSfYbjQsgpeaA8+pBh5NsWeCqOWKm7OK7wt+RoKL9yGhsfmriiJ8RI4d9lEz+53J7YLRSqQmc
 9k99uWBPdxW5Z8ZVKNqC9Nm9g3hunlZVbj3JEG8Gmy5MCW+LsLAtDUJ8lbl3Ct4dFbMAl
X-Gm-Gg: AYBFou3r3R4nK7bLNx0+YsB+KukXds1oXfjA/qJqKM5FN+jW2lIsJzrZnvPFKsyoZLX
 0NLE4JasO8gNzMoeKYbbD7WC4OTs6sD9D44zI/CUN4Eo2W9hFiT4fzzoYZTaqzagY4h0enk0d+s
 vbveVkvOc5X4SI6IHusTXu5GgdIlbTYaR56QLnY0mVKIz3IEpHQBIXl+zsB5a7Zv+5tf1/za9Wu
 AihMUpHInDUbFpbBWDeKYHDGMUzi+oz5d+nBS/ThHsoDJdzmuF/PFpeA2BQ/8P7ciioTPrkbfgs
 qws59qc19alREh0lhKKvG1OO9Yztv1PY8IX6wVxGN5uLalcQV+G5b0R1ad0PmG0VE/3IA92HUNU
 jWVHmPMJE3s+AvTG/25jCVkGLuF19EGhE8Yv7fsPtN1ZkUVqF27MpFSjMWDRXXPZRY6UgUzx7zj
 PvnI4KS/ZtQBlpKxPVq9gDJklOMK9yKA==
X-Received: by 2002:a05:620a:4727:b0:943:f4a1:7bb9 with SMTP id
 af79cd13be357-94408aa13d9mr945409485a.18.1793295927837; 
 Thu, 29 Oct 2026 10:45:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4727:b0:943:f4a1:7bb9 with SMTP id
 af79cd13be357-94408aa13d9mr945403685a.18.1793295927209; 
 Thu, 29 Oct 2026 10:45:27 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm36848755e9.12.2026.10.29.10.45.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 07/12] tests/tcg/mipsel: Add MIPS32R6 PC-relative tests
Date: Thu, 29 Oct 2026 18:44:28 +0100
Message-ID: <20261029174434.27985-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 91CAJBpagPXKPM9hv5uoKHef0bSeDBjw
X-Proofpoint-ORIG-GUID: 91CAJBpagPXKPM9hv5uoKHef0bSeDBjw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2WZtu2vc/w11
 1BaNRBSRhrlqGbCFxfPsyeGmxrfzvse2LVY2enGp/T5Cu9k4hYvSgUE3DcZ08uijpOxsQp1pweN
 draHM0S6PAtK5E5mUqhk8tS7oJalC1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXzYiJcRmxoG8R
 tOh060Q/RM+GMzhQWr9k6pHiVP9J6srB6ecV4dbH4pkksYzQi1Plsb/wxX8MKK6SZcKm1rDTYC7
 dQ0qCGnmA3PSWxCC9tDlksT9cw76MW80RvM10nvwg/KaChzupCgt1DdTqPEbSjCdn5k9Q7Mf5mp
 RO9RpbYD7sB84+JbYFJLc3CFS2cJgm9rtj4Fud9bYK4BilfNunSUXodm2RXNmaUvNr1i9Hkpcjb
 N+LzxAjZtCwib/5gUc9535HL6vkKVKL0DmRJae5CT+uTA6QHM8YclFbnI2gOF3UzqKa6fdVQM9B
 NGzFetzDqAFULFt/V+eK6nKnqeoABrWpBpdgBBQ9+4luPzLhaB+Y+K8az9mP2+21EKvgTT1/tjC
 7B2S50A648sJrNApAWytE691VqzRhQ==
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae38638 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Qa2biqyKpYfkMrCa2ZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Test A[L]UIPC opcodes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_pcrel.c | 95 ++++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build           |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c

diff --git a/tests/tcg/mipsel/test_mips32r6_pcrel.c b/tests/tcg/mipsel/test_mips32r6_pcrel.c
new file mode 100644
index 000000000000..dd16357953ae
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_pcrel.c
@@ -0,0 +1,95 @@
+/*
+ * MIPS32R6 tests: PC-relative AUIPC and ALUIPC instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+/*
+ * Run INSN with the immediate IMM, and probe the address of INSN with a
+ * second AUIPC (which yields its own address, +4 being INSN's size).
+ */
+#define PCREL(insn, imm, res, addr)                                     \
+    __asm__ volatile (                                                  \
+        ".set push\n\t"                                                 \
+        ".set noreorder\n\t"                                            \
+        insn " %0, " #imm "\n\t"                                        \
+        "auipc %1, 0\n\t"                                               \
+        ".set pop\n\t"                                                  \
+        : "=r" (res), "=r" (addr))
+
+static int count;
+
+static int check(const char *name, uint32_t imm, uint32_t res, uint32_t probe,
+                 int aligned)
+{
+    /* The probe AUIPC is the instruction after the tested one. */
+    uint32_t addr = probe - 4;
+    uint32_t expected = addr + (imm << 16);
+    int ok;
+
+    if (aligned) {
+        expected &= ~0xffffu;
+    }
+    ok = res == expected;
+    if (!ok) {
+        printf("# %s imm=0x%04x at 0x%08x: got 0x%08x expected 0x%08x\n",
+               name, imm, addr, res, expected);
+    }
+    return !ok;
+}
+
+#define CHECK_AUIPC(imm)                                                \
+    do {                                                                \
+        uint32_t res, probe;                                            \
+        PCREL("auipc", imm, res, probe);                                \
+        ret |= check("AUIPC", imm, res, probe, 0);                      \
+    } while (0)
+
+#define CHECK_ALUIPC(imm)                                               \
+    do {                                                                \
+        uint32_t res, probe;                                            \
+        PCREL("aluipc", imm, res, probe);                               \
+        ret |= check("ALUIPC", imm, res, probe, 1);                     \
+    } while (0)
+
+static int test_auipc(void)
+{
+    int ret = 0;
+
+    CHECK_AUIPC(0);
+    CHECK_AUIPC(1);
+    CHECK_AUIPC(0x7fff);
+    CHECK_AUIPC(0x8000);
+    CHECK_AUIPC(0xffff);
+    return ret;
+}
+
+static int test_aluipc(void)
+{
+    int ret = 0;
+
+    CHECK_ALUIPC(0);
+    CHECK_ALUIPC(1);
+    CHECK_ALUIPC(0x7fff);
+    CHECK_ALUIPC(0x8000);
+    CHECK_ALUIPC(0xffff);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0, r;
+
+    printf("TAP version 14\n1..2\n");
+    r = test_auipc();
+    printf("%s %d - MIPS32R6 AUIPC\n", r ? "not ok" : "ok", ++count);
+    ret |= r;
+    r = test_aluipc();
+    printf("%s %d - MIPS32R6 ALUIPC\n", r ? "not ok" : "ok", ++count);
+    ret |= r;
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 9d7cfcf1c6a0..3425962d3715 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -91,6 +91,7 @@ tests_mips32r6 = [
   'test_mips32r6_bitops.c',
   'test_mips32r6_logic.c',
   'test_mips32r6_multiply.c',
+  'test_mips32r6_pcrel.c',
   'test_mips32r6_shift.c',
 ]
 
-- 
2.55.0


