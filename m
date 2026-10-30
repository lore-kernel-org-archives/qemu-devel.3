Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F55606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i31ka/FC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JGlW3ufd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrKO-0006mN-5L; Fri, 30 Oct 2026 14:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrKA-0006Yr-OS
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrK7-0002R7-Hr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu5Pr3430785
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3XRd9qQrKrqFBWzWiu2+f9niagjSSeh/wAU3QeXKSBI=; b=i31ka/FCa0oVsmrf
 INGWl2Tz4OuIGPAT28uhhJkckE1A39FkG/xio3uo09gFSA3ZgnE4fW3e8MnQBGMT
 Jtvtv7fxxb/fJCVKlXPr4t5w4/pi1Ikt3DTaV+lgjkHWu78BVcZQePSCTDxAl6X7
 aB84+2ADxJoKgnL+m2BHEIEL/VAX8o0NFqI6d4kY704GZeJnOYD4qZz/XTNt28Se
 1u94RYELllvCXUbAE6rRECkeiup3bXep6mn8pDj9dvXg9Pqd42NfoYz5+malBuQY
 uyau0Qy8w0K6RUAxbn0WH5kz+5r1p2+uTvs0AQeac9qnlA/9HGcn4d4iSFdq735a
 jtt47g==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmfq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:28 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso244003241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384848; x=1793989648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3XRd9qQrKrqFBWzWiu2+f9niagjSSeh/wAU3QeXKSBI=;
 b=JGlW3ufdS8W6NXsmZ9aSLAJiZ1G/fTFm5aLDxuisOesgh3uiGtcrGK1ADkA9FDRfd/
 CQvK+UvK9X8h+FOk1/aKe/wnIChHe6a+cyKB0vwCTMP8XVo8evUkk5H+4jv24Mw97UMM
 PxUeCqO1tS5WSfmrqsy2Pf6/XcY1ZA/kN+zPdNxtXUFoQgFYNj3X/f+NinA2BxKkruQ5
 /6NNWURS1Juv+x4ul1ecVi7tjptsoGu1UF20msTWJsm5lE8bARTfolp17ASRNRW0kbBi
 sD9H50IqFfa3g0jpH9Uib3/VbI/VW1rAt0X7yE55NOE8Zn3mgCyFlVHrbX5vrByZjnKT
 9uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384848; x=1793989648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3XRd9qQrKrqFBWzWiu2+f9niagjSSeh/wAU3QeXKSBI=;
 b=gEMg/hDGd9pU210M9iJgEKzu+9GNQR63sp9a71zCiDxq3n9i6+fS+BRmbsXY+AoZ74
 1Xg3mDTq/H90qQq5vCjZL2rN1SQAOCPd9HcJfffUhK8mKRgsh5BKF+87SZGzlYmf5YBS
 vz0U8n73xrqSjIRRQ1o6OPYiUAEahNg1d8f1EPPFlsQrGa1BuNv3gyRP8bkOUaARZHXq
 T1YVj2xt0r0qYgWp48b2W6UvK9+c0z1UCuScpEl2aSaIhUs+W9KuGaF8zWdeJxP6imnN
 qV3ofRuY3NPl51tLUP5LpHWyF7vqkQPriQP4l6zs9RJqoa/NgqQmuZ0dUIkVYXGcEqyn
 diVQ==
X-Gm-Message-State: AFq9FYLZLfTs6oKaB6TrLAP84+Up43uLQk47Mps4knrVn5cT/K+jc77A
 O9WViRop/YhP6imIAm26LeaUV71g8qi3AYCASCo0J0id/U6Sa1LqDKe3z5O6qAjeo2s+ZMTLgSE
 cOeduSu/DQ/TslMLezaF4+tM+mS6Fu4yYQPtLsSNVyoY4QuuEc6oSkM89Ibdla1Asr8DF
X-Gm-Gg: AYBFou2+gRXH7Z3H3yQNGBvuLce+q8qFeA/Q9ypn+OvR8Q+cr1B1W46bBJeB0BOcw72
 8U+jL9fNU1jjGBX0fsAauqt0KrVhoI35D/MrCdPp5gtwFYkxa4AaLUlWFod4DgqoKtX3Bt/ZuJx
 REp3SYlX97XKiMC8yXhCAgIMLCxPvUI9RfBVZe3VtJj1D9363Wo/YwRx5b1AeDb9nK4dMpx04/T
 PuiUOPcA1UaJh4x5qYjcZC8EX/9XTWyGJ2pQXl34PXTebJByKYey/SdM2mO4rr7Kq4y/9HYEB3G
 Mcg5GEncwSGWQAK3g5fzjUFxilUTyCt/EXfiefzeOlr+goYKex0u9wdK3LHAyXApQ2w9ZR/kjqz
 sTw+ntDVhRYeEn1G6mWanviGnutcH2OzRiEIKE0xr8WEqJkJS54pHFxhqFIlcnE9EDfcX8jdvjn
 nX3AG/JFdmAKkKM9ymAalVI+zaoxxHFg==
X-Received: by 2002:a05:6102:50a5:b0:7c8:4efe:5243 with SMTP id
 ada2fe7eead31-7d072c0ccc7mr1621804137.14.1793384847787; 
 Fri, 30 Oct 2026 11:27:27 -0700 (PDT)
X-Received: by 2002:a05:6102:50a5:b0:7c8:4efe:5243 with SMTP id
 ada2fe7eead31-7d072c0ccc7mr1621785137.14.1793384847192; 
 Fri, 30 Oct 2026 11:27:27 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9c4f4sm4543950f8f.48.2026.10.30.11.27.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:27:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 11/12] tests/tcg/mipsel: Test MIPS32R6 BALC
Date: Fri, 30 Oct 2026 19:25:44 +0100
Message-ID: <20261030182546.2508-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXyeMGD1mrFlKt
 R5aeux8jl0nxiJhkdOKysTv6SZg0V04g7sVWAS1G7UdhG7i3MsvDSlOFFDOVhI97ixrYYJAohwf
 yCeZQwdd+sLor3EXATocpkCQDNh0wiBEmsN2CfCHcI+/dxVczZb8KX0ABAriXGswjISzmCQdbu3
 PL+aE4dA9B/kXF4HnJnWu8d0qIdL1vdx6kFT17kOHsBQlazK1hvMx/AsOX3jBoWC9We84ivqf1s
 S00SrxPfiulFiD3pbTxS455IBjJf4wTHZympGG5TxVbD9r5PjZirhDuDFy0Bx7dueGAUcAIKUKj
 PvMJhFkGJlaipXZ8LlXJTTCEyDnKFVx2g1QCP4WahNWAKNzB7jMjK0P47ljoW72o8gmwq6RfD09
 1eIgqlwjQ+6kb6ME8MC5uRI/lPR8YF5e30oBUT2bmsMA83llJIe5exp2qtLaHJdPTidihVca3Ng
 kJmkADmfoconJVYK9EA==
X-Proofpoint-GUID: T1HCvmmM0PRGvFUw5HHw_-Sz8GJZmnrO
X-Proofpoint-ORIG-GUID: T1HCvmmM0PRGvFUw5HHw_-Sz8GJZmnrO
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4e190 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hTR_K8myB3fJVw4RT74A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX7YbypNJ6T0bu
 F3g280f2IGVvo9+c2xK2sRsvbBERMDPysUM5u2sBH8w6Zfct4ynOkr2T3blTyeGOcJcRPR/ogeI
 oxcs8qBYP8DJ9kSAqf3TDU41FCdatYo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
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

Add a branch group, starting with BALC.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_branch.c | 53 +++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c

diff --git a/tests/tcg/mipsel/test_mips32r6_branch.c b/tests/tcg/mipsel/test_mips32r6_branch.c
new file mode 100644
index 000000000000..83580fcbedac
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_branch.c
@@ -0,0 +1,53 @@
+/*
+ * MIPS32R6 tests: compact branches and jumps instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+
+#include "../include/tap.h"
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
+        TAP_INFO("BALC: ra 0x%08x expected 0x%08x", seen, expected);
+    }
+    return seen != expected;
+}
+
+static int run(const char *name, int (*test)(void))
+{
+    int ret = test();
+
+    tap_report(!ret, "MIPS32R6 branch %s", name);
+    return ret;
+}
+
+int main(void)
+{
+    TAP_START();
+    run("BALC", test_balc);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index a7af2f16192f..fc27a4f6eb96 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -68,6 +68,7 @@ tests = []
 
 tests_mips32r6 = [
   'test_mips32r6_bitops.c',
+  'test_mips32r6_branch.c',
   'test_mips32r6_logic.c',
   'test_mips32r6_multiply.c',
   'test_mips32r6_pcrel.c',
-- 
2.55.0


