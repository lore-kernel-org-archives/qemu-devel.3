Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXjGWXN/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LJXIMdc0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDw-0002kC-8l; Thu, 29 Oct 2026 13:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBd-0007Fo-6m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBZ-0003k7-5j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDjKA182196
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PuhLkghWWpUfBAEQxJAhMyMHK9cr78T+0H1BmdUqTlg=; b=BXjGWXN/XnvROmBY
 bCO32Y+m7PcL4Mq7hWd4Tiar/x2I229PaS25nUFOamvtRJg3gZIsCnGaFfv8ShrL
 2zTny7Ay6BY2VKdHMfEB21dZJHQ/gFGrZHEZ/IE7HYfrg6wJuvYmBkBIf+ihr+U/
 35qJcOckG1O9z5v+jxSt0UDG1hvBLBRdzT5KDrkXnKylEVRkowFrWj4CdFUmg7VT
 edt+W6EoCLX+lgvH7x0Bs00uMyYZ0ygiY19I28rvm6CRVZvZP50fLjzFkY0kQgZk
 50qYacPRKqzOdQXhTQWvGD0Mrsj3xOqIcQ1rzvK3ph1a0BPhl+DlqWoTXcspt1p+
 kW1ixA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r5t2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb71b1443so502914285a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295906; x=1793900706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PuhLkghWWpUfBAEQxJAhMyMHK9cr78T+0H1BmdUqTlg=;
 b=LJXIMdc0GkFXQb/UtxjlO3tODD45xTUtwrJWleNzoEnoCgcBF+oIYUtAkV1KqAAR1X
 CjGtmvSR0suSFWWDVw/c5txz115DgY9ruTvyRlRIV6TXA2hqaXpJxa/PuMw0WabRTcmN
 EhJSJ9r37HpC0/Wib4ZGCUZPqjd57bdg/EeNcKn3EQ/TED3B9g3V1rx8bjaDBrwvKRPS
 2FayD9vGDj5Uwb8n3Ie2ZyGCjYu8uqEx4b6N//61FLpsB1/OOJoqhBr0g0Ufp5UDb2iz
 LsG1Fi19xikz1KgAGqNeXG4Hg+v+aZXDlvf2uG/NlqDBItloFu3dKNa8R0ZihF1krl+t
 hFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295906; x=1793900706;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PuhLkghWWpUfBAEQxJAhMyMHK9cr78T+0H1BmdUqTlg=;
 b=y3iTqgil0zBkAytZDpxNJSP1S3uJW/6MhK1T6j37yM0tUa9/m7GvOWz8+kuSm2U/Nx
 fns5czx5FGw6XyXYZC2IUoT3Suc1lXnArFLv4hlZ9V2B97vsBK03OhG9bY0suMqw2ML1
 X0W9kfx6DqJdlzO67bmtF/2yJqIcVLNQY6IiQAKDwt9OqCByMcQi4dhsVhom72i6f0mL
 d6b4y91RwGjzvHBHCcDkcCmdAzGixcIixH0D/lgiH+oBlnyxJm8nteTS8delABbl618g
 yZ5hiFMnTtrYF4ts4uIN9GkzeFHggZOqIbO8kSTqP43fkv72eI5FFNEVkEJXlaWdSFPh
 ZZDw==
X-Gm-Message-State: AFq9FYIFMLf7ncZ0dDZ2woMfFrOB8yx1gcFYzT1kGDFHiHKAi4ToLbpa
 SdwHf2BOHhF//Vcfaw9BULbaDNj5PA9hVAsim2jDC0tsCwr/pr0Ni5SrfNQhpyoUyLmx+g51gTo
 ZQ8H1GK/sWhjns0Q48oSXJCUNjZ2IdWZrbEj4sqo40bzANHdqg1PoyZgbLjL8XIBe3196
X-Gm-Gg: AYBFou0aYq7NyL70v9d8jnIw0luFrqa1VukQmo+OhDMI+mM9YqkrBg+EaR/i42QdcEO
 knn9Gnl0RbQmIC3Wqavrc0zU3MedOy5/0EsUveFJWu8dXmJjqYmHMl5BMdNCjal3hESJxgERNyb
 0RVaK4sL5PAFXa0JzNwcrQSidMVzO9E36RAEFrK3KB/vfK7g1Ft7+WAqDoJeSk3csdt60ybLqkm
 DJM2J1cyY79kUJvU+nDpIOQn/+YSN/+UjDNVPzHfRGKbqSQZ7Uz0x3Iu6Q01oDaQdHHanRvBRrf
 gTZXNaR/6EzbUU84gEmD1Gn+HSNWz5UmnL4sU961T/4J4APE2N8ZHz24QTloevY1AbWUOiN3Mng
 rY28nn68yrN3oZoSY9A6CNIwVSIfvZKlHaWXeUIlyt3GquGJOYuWEjrAnAtpZiBBGhw17h1A6YZ
 qx/HStGQNFDZL9XMK6/RRBMSKSKTCk0w==
X-Received: by 2002:a05:620a:4453:b0:93e:4e27:359b with SMTP id
 af79cd13be357-94408a5f7e4mr994803085a.24.1793295906034; 
 Thu, 29 Oct 2026 10:45:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4453:b0:93e:4e27:359b with SMTP id
 af79cd13be357-94408a5f7e4mr994797785a.24.1793295905440; 
 Thu, 29 Oct 2026 10:45:05 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77c132sm2307335e9.1.2026.10.29.10.45.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 04/12] tests/tcg/mipsel: Add MIPS32R6 shift tests
Date: Thu, 29 Oct 2026 18:44:25 +0100
Message-ID: <20261029174434.27985-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QnuBZJoOCA6Rz9bBhreYWSbicr0nNM3W
X-Proofpoint-GUID: QnuBZJoOCA6Rz9bBhreYWSbicr0nNM3W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX9BmcKPlg/CfR
 /pDMV5exGl9Rljapz0oVofZSHGi318qDFid/v/p83UcBU4XqVHn8lAJRFQ+7UMyCG6Gu3fHneUa
 2czY7fdx+suEQafVPDkpu+l9iCe5iOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3o3I4dWZGPO8
 78s54PoXFmn5dy8Es8W7Lbj2Jp+CwHIAZJO5Bz6p+ov2wrW8KKIP75+pGiPpxsdn9bTag1SjJzV
 2xhg1Jle+vfebhsvjrF00zReEnBC5PblVHpoRm/PavbgDr81n8AK2b4WMCeKcPXu0AxnF7ggNxT
 NF60Z95U1SaHgIllVdn0UElqJgqjuocJs4gxkS/x8ZFN8+rn/yhHofye9aFt9c1BYpVVMxbAI+y
 ZgAL+eSNm8owWyH2HdlXX3FB8O00uwT1MkUcl90Hay/bWEI/XN6V9jLzLrjM2vssIY8lQ+073Yy
 oIoDay67Tf1etPuICpy0vXggO2iLTBYm1Lukm7uQs4KQsQrGMFp8g1P6RBzioKCeJbzrw7TOgKU
 uJEDUHqACjGJ2egf0WGYv4qJ6pblC2xN38rzRvk0peJP5MAgUBMlku1LImkkZv8CV6WMK+e4faZ
 xKp1vCW/vsiwQ1ZJVyw==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae38623 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uLWhfN5tPcu-BnL75HQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Test SLLV, SRLV and SRAV.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_shift.c | 74 ++++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build           |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c

diff --git a/tests/tcg/mipsel/test_mips32r6_shift.c b/tests/tcg/mipsel/test_mips32r6_shift.c
new file mode 100644
index 000000000000..c4389b5d232a
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_shift.c
@@ -0,0 +1,74 @@
+/*
+ * MIPS32R6 tests: shift instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+#include "../mips/include/wrappers_mips32r6.h"
+#include "../mips/include/test_inputs_32.h"
+
+typedef void (*binary_op_32)(const uint32_t *, const uint32_t *, uint32_t *);
+typedef uint32_t (*ref_op_32)(uint32_t, uint32_t);
+
+/* Only the low 5 bits of the shift amount (rs) are used. */
+static uint32_t ref_sllv(uint32_t a, uint32_t b) { return a << (b & 31); }
+static uint32_t ref_srlv(uint32_t a, uint32_t b) { return a >> (b & 31); }
+static uint32_t ref_srav(uint32_t a, uint32_t b)
+{
+    return (uint32_t)((int32_t)a >> (b & 31));
+}
+
+static int check_one(const char *name, binary_op_32 op, ref_op_32 ref,
+                     uint32_t a, uint32_t b)
+{
+    uint32_t res = 0;
+
+    op(&a, &b, &res);
+    if (res != ref(a, b)) {
+        printf("# %s: %08x, %08x: got %08x expected %08x\n",
+               name, a, b, res, ref(a, b));
+        return 1;
+    }
+    return 0;
+}
+
+static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+{
+    static int count;
+    int ret = 0;
+
+    /* Value/amount pairs from the input tables. */
+    for (size_t i = 0; i < PATTERN_INPUTS_32_SHORT_COUNT; i++) {
+        for (size_t j = 0; j < PATTERN_INPUTS_32_SHORT_COUNT; j++) {
+            ret |= check_one(name, op, ref, b32_pattern[i], b32_pattern[j]);
+        }
+    }
+    for (size_t i = 0; i < RANDOM_INPUTS_32_SHORT_COUNT; i++) {
+        for (size_t j = 0; j < RANDOM_INPUTS_32_SHORT_COUNT; j++) {
+            ret |= check_one(name, op, ref, b32_random[i], b32_random[j]);
+        }
+    }
+    /* Every shift amount (including ones with ignored high bits). */
+    for (size_t i = 0; i < PATTERN_INPUTS_32_SHORT_COUNT; i++) {
+        for (uint32_t sa = 0; sa < 64; sa++) {
+            ret |= check_one(name, op, ref, b32_pattern[i], sa);
+        }
+    }
+    printf("%s %d - MIPS32R6 shift %s\n", ret ? "not ok" : "ok", ++count, name);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    printf("TAP version 14\n1..3\n");
+    ret |= run("SLLV", do_mips32r6_SLLV, ref_sllv);
+    ret |= run("SRLV", do_mips32r6_SRLV, ref_srlv);
+    ret |= run("SRAV", do_mips32r6_SRAV, ref_srav);
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 5553ae33aec0..7a6dff32cbf4 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -89,6 +89,7 @@ tests = []
 
 tests_mips32r6 = [
   'test_mips32r6_logic.c',
+  'test_mips32r6_shift.c',
 ]
 
 foreach src: tests_mips32r6
-- 
2.55.0


