Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UqhhoW8w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P3QRynik
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFI-0004k3-FZ; Thu, 29 Oct 2026 13:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCO-0000el-FY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:46:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCM-0003z6-D8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:46:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDd4n3689767
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nNvHD3B/0r9mwhpXe8XYGjc6SNsenHSntZyLxVipYLs=; b=UqhhoW8wraHpUJww
 ulnxoLQplk7DwgWghBD/pHl7lhDd4qEo1NBcq9pRmFZs2GpTcuf13HLs6uF6bftg
 52HQZ+tbmXz3BwbH+mLD/nCrBOkp5DVb3gduXhuixryqgo6YoqXnQFOVb+5ZID4q
 1uQIFvO9CU/Xk1weSTjovGe//IOdnJ5jsu8y7owrekrj5N0BjV06nd7TXWNjUoks
 0Tr3+mgJc7ahcoRXnwCDa+270nZNW4gMiNzxOn4rLniuhlrLoipozacF8iJKjstV
 mCelsZPHyZvZOWVPfu3PTNbmhwi0d2RZYunq4hSuuBK7j0Es49VLhQQ/kdhU3Srw
 wHabWw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sbhus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so503107285a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295957; x=1793900757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nNvHD3B/0r9mwhpXe8XYGjc6SNsenHSntZyLxVipYLs=;
 b=P3QRynikrSVAAPSkWIuvdpoVc/7YDk91qsIlfgTRsXPb5UIinR5KWa4TylCPz6eSVI
 hMT60uxuqgDvstGs8FAbiDwacukafoaipkdDH5C/lDuQi6YiIw4vRybq+1QJgcqJDRjY
 r1zCW/DytZarMLz3ICC0WFz4hPZTxosqB/nQhnpQdaZ6TEPdtPufQRubZ6vDtQ8/xvW5
 V5o7qm/xaXSB+zvDu0PjGiFnj2xGZVGncxvHxRqn4TbSsgJB9ltJy/DStvDFwIFS7Nik
 JCwiazHJky777JOjuLtRKNfJRbyqQvsaf+ruhP2PohBlGLI5O2RQqG/RXu/i9c9roWDQ
 KPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295957; x=1793900757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nNvHD3B/0r9mwhpXe8XYGjc6SNsenHSntZyLxVipYLs=;
 b=vaPgYUGYYw+aHVlBM/BOBw4pwL98JHice8aUQnt0GJjtvQW8RsG4yCJyYY8kudSR8n
 ww5oAQyQzvNO7T6eyNFbCTdmbxEL1MJBaLmLHFhEdRvAB7JZQpqohKvld2PoDzAEj637
 oxNrahUjcB6WfzuRSmDGe5Vos0mpyNnGDt3s5tJxhmiJqYDOqK0jeaHj2G7ZS07LF6kL
 7iACtnqJ4UKeC9J5LB/qwQOUAoFiLlxwhgZMcHC+YLsSDT8bLnu4bcIr93ZHc8P8S2V6
 Nxt9EO2uGge15VlNsejq0/uDWdYrznfAQ2SN6YMDTV25+/GLMa941FoFfSuTOPA4WMIG
 65CA==
X-Gm-Message-State: AFq9FYJ86ztoAcJgJFwjTxahnYwl8aBaACmgq4yygThB+nzPF44EI4nu
 UU5ZSNTwejhvU0PxRL9ExBGbKsGwNGXoedEzaglTTktt/Iv9xGP45yhi9Aii7WlEzNU/yF7fL57
 UUx6O3e/7mJvVodvaAArVWAEdusmFag1+JXAkLkB0ZydlPudJJbKSCoZJKUP4CLswI24M
X-Gm-Gg: AYBFou1aemKPobmBcJVp3KaDUUYB3OKl2RvfiAg0W+OZAjnoBRehPwh/yyzqWfJLMWc
 J8we0N2+DFPd7/gHEZtR02fe3buWQh5/9zhIjhBybNecbrHZRp0wGFOyXUujQ4hhEXQ1IPAzoqD
 +dTi2KnP37oheMWFpQYWGHT/veS3tKqkxf2JxAvIQAlD1DCZFx3ugJBAuYJ1OjCve5dxSQmq2s0
 HepWmRgYYnxphe7hpFl3jnoA7E8Q4aNtez1BxD+iIMJRvInYXQzGJHFSOQd7ISbM/3l7FbeJo32
 e069s7KxcBq7pzp5elX+aFywi9V0gYen0mY89UVyMD1l0xiCS2ajkppCe85yPUNE2CyNHaNmV0E
 XDTrIum0HBFOIfDxcg/Ns8w7CvWEspCbLTxS/CgZ64TWmhNS8Oe7jwiYCcGgNvx756fjnrT1wJH
 U7iHW6WUdvUs5Z6oFQ0OW6Ru22ANjuBA==
X-Received: by 2002:a05:620a:454b:b0:93f:5f83:2cbb with SMTP id
 af79cd13be357-9440891c49emr991638485a.7.1793295956907; 
 Thu, 29 Oct 2026 10:45:56 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:93f:5f83:2cbb with SMTP id
 af79cd13be357-9440891c49emr991634285a.7.1793295956310; 
 Thu, 29 Oct 2026 10:45:56 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm63145445e9.15.2026.10.29.10.45.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 11/12] tests/tcg/mipsel: Test MIPS32R6 BALC
Date: Thu, 29 Oct 2026 18:44:32 +0100
Message-ID: <20261029174434.27985-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8XU4x26Bnb9g
 +6DBHmaVToSzP9umpIIHgG89CNQJFJVkgOw7gfaLE+gyGb8fpW95u6pW+ytR6XbVZoJo74xPC/u
 Tc2fS3ZzH0nRZsZ7PGBe3c52P66O03E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX6BNuGdHACWWp
 8zkmIBioc24w8kVA/Y6vzDQKZKicCpvuf+gNmCVL8ScHy7hAHgQG+wxakvLS/Sy1RYi28yT6DKY
 m80AP6N6QuxntgicK1R6xkKUwHPaW/OBq6ZJSuCMm7tAWhd3akSVjMf0XrzKva6r6f0EDK7moMA
 Igf0jzhfQP414a2qPr4V5jW098Sk8LF3sai4rm2AHsHsraaGi4+7K33WFdV2H7RDFeejp71Arhd
 agwHWW72sARcCeH9ksxv05wFrEPebgKiXr8odWm42vTbhC6h3KVd3m8HZ7wqfWvCfkvKKd9PlDA
 BSI3g0TyoVUP7NXHmAh+MMeBN6Kcdx+opPCyJHCNdnzQ6F01iC04Rt5k7BxY6GsAEDp8tpsgryZ
 LcXEOBi4IuHE+ol7LGRpJ40SKrKCOA==
X-Proofpoint-ORIG-GUID: eBTQisB-0e5fdCXeT2RVECxCoNKxzh1r
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae38655 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QQnBqfZ-nRg7-byQzzQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: eBTQisB-0e5fdCXeT2RVECxCoNKxzh1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Add a branch group, starting with BALC.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_branch.c | 57 +++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build            |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c

diff --git a/tests/tcg/mipsel/test_mips32r6_branch.c b/tests/tcg/mipsel/test_mips32r6_branch.c
new file mode 100644
index 000000000000..73a0036997f9
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_branch.c
@@ -0,0 +1,57 @@
+/*
+ * MIPS32R6 tests: compact branches and jumps instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+static int count;
+
+/*
+ * BALC: branch and link, no delay slot. The callee records $ra and returns;
+ * $ra must be the address of the instruction following BALC (label 2).
+ */
+static int test_balc(void)
+{
+    uint32_t seen, expected;
+
+    __asm__ volatile (
+        ".set push\n\t"
+        ".set noreorder\n\t"
+        "move %0, $zero\n\t"
+        "balc 1f\n\t"
+        "2: bc 3f\n\t"
+        "1: move %0, $ra\n\t"
+        "jrc $ra\n\t"
+        "3: lapc %1, 2b\n\t"
+        ".set pop\n\t"
+        : "=&r" (seen), "=&r" (expected)
+        :
+        : "ra");
+
+    if (seen != expected) {
+        printf("# BALC: ra 0x%08x expected 0x%08x\n", seen, expected);
+    }
+    return seen != expected;
+}
+
+static int run(const char *name, int (*test)(void))
+{
+    int ret = test();
+
+    printf("%s %d - MIPS32R6 branch %s\n", ret ? "not ok" : "ok", ++count,
+           name);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    printf("TAP version 14\n1..1\n");
+    ret |= run("BALC", test_balc);
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 3425962d3715..145d88dda19c 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -89,6 +89,7 @@ tests = []
 
 tests_mips32r6 = [
   'test_mips32r6_bitops.c',
+  'test_mips32r6_branch.c',
   'test_mips32r6_logic.c',
   'test_mips32r6_multiply.c',
   'test_mips32r6_pcrel.c',
-- 
2.55.0


