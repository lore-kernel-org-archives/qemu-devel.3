Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19254606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eBeWhZtf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQSUAT5X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnzh-0003u3-PR; Fri, 30 Oct 2026 10:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnyN-0002D8-3G
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnyJ-00069a-8G
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER12B2595780
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kQsZw3MgRbxdJL1gUCwKaWrwHxBpWWaPpyM/yFj0LFM=; b=eBeWhZtfnHFmsIzy
 +25mAcC/89skt/O2IaOVImmfRdv9s4aJq3uWpDldCyrnQmZEujm9xyoMqVl9a6P3
 4Ji+jzaAU9LLZhYlCn2upMYCncIGyhoKcLHKXRxkrfc4p/laQYcEh+L+lKzDwQXB
 WxC9zS9HyTe8bWIXnDX9hde2Ig4yYqHlT2NOBp4LH5TSxLQiWWWUxaTND8CrVXMD
 XyF4MihiASYtZg8ltf6eSC0ogCj94rlQDIKE4vwzEkpmXP6pFRnu0OYE05GWbNpy
 EnuYmhSwnNWov+9qvOLetModkisU3zpV0hO9lIUxhyH8BH0atA3PvrHIW4WFozGa
 /w8f/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pbkpj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f322ef7d3so130051685a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371964; x=1793976764; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kQsZw3MgRbxdJL1gUCwKaWrwHxBpWWaPpyM/yFj0LFM=;
 b=VQSUAT5XYnMGaD9HtI+g8Ynp0K0KJVuHzp21FQD4XS30FGEttS2ifHkfYPLXPOK+om
 s43C7DUMUGnHv5Hy1SZVoXheGKdHk2YpIVFpjgwWnR+mhCnuArLiE0LvwKCEeU5BcaF/
 u61Zh67uq8FQC4LCeuJx7fHR5oR/s8j5rq/m2mPlnPnKh5EKrlWBx4me/cU3pn2+8hoO
 iIYviKzOpdrsxHJVY9sVqITnzw4R1JxQ0s39c8OHWWb4WoKIv0U5nrvQnJABkY/JTijv
 yZE5CTSMMZ91Dz7kUa5Gq+TXpq4EdkOrg9oSiSzc73+nIp2oBdFAcy7giPjVANV3LEV1
 4HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371964; x=1793976764;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQsZw3MgRbxdJL1gUCwKaWrwHxBpWWaPpyM/yFj0LFM=;
 b=YxqmCKPAirjIlLKiWHMbixl1+L7X80DHhb5b1/WzgMqjfRucaCu8EPz+SR3KEFMJ/z
 01rUls3Xdh+c/oETDrfw6aYWhxaydxfL47TLcyWd8Khk9aC7Wm9Hp7xXZ8J9I3LsQ+vO
 53SOtavk9l9clLUQFlNHgXBlYGLwyS59rf4V9BlFulxnzR5EkBZfK5qBLxCnRndyrUHC
 2sZ1Y7hk7ea6t4QkOObl8zdLXhV/ZVzymY7hrKvBE6OyKnyie+NBC/f98osK6eWB3BQp
 2ff+yH4+9rtF8ypVlUJgNTjvNutFUT/Mo1yr4YMEoQrvW4MCJhP0eCkZy0UaJBqrQi/g
 nOjA==
X-Gm-Message-State: AFq9FYLprqbhTRl8z7UzeHG18vpAiP/PVOHiYtdnTezXAnDwaWn8hrFb
 QAGRpB4g7/NZaUBD0aZxptf4KCNLnbqRja91eeWXMKI9g7lcnSaAGpBvbJFGOLe6OhjRCFIDe/Y
 6MZwGkuaZVQ5eSkYuHP1SYbVfYL4rou8Zj52FoXzVGHb+fiQU36Vh7yFdw7Y3UPKSBfb5
X-Gm-Gg: AYBFou0Ca4Y4jrb/9LfZOu/YJlNfUxztcP0LD12zcbC8pWEf7YDe+mRLEeQ693pip3k
 vdzJSmwhMKWouz+LJHSMWoiTH5kLPWUsi7/LcRk+aO1t9P1lNejVz0iL6MwLXUMpAK1tYGl2j+8
 GB5EbOfKCqEbPPtzNETbzwBnlIBWQlLXBZmMVRIG3GO7J3AxwH0LwC3p2E7mRp32PJkeMs+2ygz
 4OBlkuDQogfBMyJU9b1bRhzUmPLmO+tavsew8d2/jekFIOuxZXuLOo40t7ynJ36mrN2MCVFveCs
 it/RcGynpfXVlhFFGm9OXIUVVXeu1Qd8FNnEzV7w5QDqBD99sxK3ufdcZAVGMJXllHVLdsOOghK
 HpNk+Xfv9KSVmKR/s3axmD8M7czIjgqYXIDPNPKPxRR1y2cSP9/JrgzAveQZIFCdqwIOQWG89Sa
 9BOGLcsfJCd8qGPLh5x++OWbzQW6hgjA==
X-Received: by 2002:a05:620a:19a3:b0:93f:33a8:8e84 with SMTP id
 af79cd13be357-944217a46ffmr420921185a.56.1793371964255; 
 Fri, 30 Oct 2026 07:52:44 -0700 (PDT)
X-Received: by 2002:a05:620a:19a3:b0:93f:33a8:8e84 with SMTP id
 af79cd13be357-944217a46ffmr420916185a.56.1793371963591; 
 Fri, 30 Oct 2026 07:52:43 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aab10sm63970845e9.9.2026.10.30.07.52.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 07:52:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v2 3/4] tests/tcg/mips64: Report Octeon test results with TAP
Date: Fri, 30 Oct 2026 15:52:17 +0100
Message-ID: <20261030145218.58385-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030145218.58385-1-philmd@oss.qualcomm.com>
References: <20261030145218.58385-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX460rI273XW75
 YUOHnEPjKKPU2uGFORPT0sJDioytldXEsBPpvbppLHxJ9Pfo2pyp4Ag0Ma90e/elAWWm5CXoHbj
 /Y2+zvCPO5Dx0Gp5NbznWNbZ9U2wVYxz1ZJP5y6mL+XIt5AdSHZDGZmDPT8PYTuoZinYnd8YvlL
 0uAd9CiYh5oXboVmvGAd1aHCs+P6bMVYkDdNSu6X3iCXaROreDI8M6j2PO4Idn0ehQBkprsEGk9
 AFdHxd7vuBxunFQKmMLniMGMs4B30ukSxOxn40s/kVUuLEZPIdqVs64IuZ6Y7bQS7tZ9jDXOLk7
 1hcf5VuTFb4Ohuhp7STKhdDYdDkcbZNT6ySJ1VAegwLtx87bLq5Aa5UYVPb6vtxvW/ABa9rwmHb
 dFM3qBjbldjZXviND8QbQMNv4pzQJ+WDFm4ZH+BpG0ZRli3maoCa5pKPG3yoxkrl9cBykBKeGC5
 XP8BTqNFha+Zr5pe5OA==
X-Proofpoint-GUID: DlYuLSG8q7owHDhulR2Q3dlkhQGM2NO9
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4af3d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=24OdzgigavIs_6l_i50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: DlYuLSG8q7owHDhulR2Q3dlkhQGM2NO9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX4H56eTWJZwRc
 H8C0saKncqb4gM+RA/vEhmNBiq2vFaJKTj+ZwOQV+jqv5pFkwKpoxhq9RyxZ88x2yBi+IHICFCS
 Ux/fb9pgQnprF8Wkt9Rsmi32LSlV/jA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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

Replace assert() by a TAP_CHECK() macro printing one TAP line
per check, so a failure no longer aborts the remaining ones.
Select the TAP protocol in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/octeon-insns.c | 65 +++++++++++++++++----------------
 tests/tcg/mips64/meson.build    |  1 +
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
index 6fffc8201034..208002c711a2 100644
--- a/tests/tcg/mips64/octeon-insns.c
+++ b/tests/tcg/mips64/octeon-insns.c
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <assert.h>
 #include <stdint.h>
+#include "../include/tap.h"
 
 static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
 {
@@ -385,36 +385,37 @@ static uint64_t octeon_rdhwr31_non_decreasing(void)
 
 int main(void)
 {
-    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
-    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
-    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
-    assert(octeon_seq(0xabc, 0xabc) == 1);
-    assert(octeon_seq(0xabc, 0xdef) == 0);
-    assert(octeon_sne(0xabc, 0xabc) == 0);
-    assert(octeon_sne(0xabc, 0xdef) == 1);
-    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
-    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
-    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
-    assert(octeon_vmulu(5, 7, 11) == 46);
-    assert(octeon_vmm0(5, 13, 7, 11) == 59);
-    assert(octeon_vmm0_zeroes_mpl1() == 0);
-    assert(octeon_mtp0_zeroes_p1() == 0);
-    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
-           0x1122334455667788ULL);
-    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
-           0x8877665544332211ULL);
-    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
-           0x0102030405060708ULL);
-    assert(octeon_cop2_keylength_readback(0xa5) == 1);
-    assert(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
-           0x0102030405060708ULL);
-    assert(octeon_cop2_crc_len_readback(0xb5) == 5);
-    assert(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
-    assert(octeon_cop2_gfm_mul_reflect_write_readback(
-               0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
-    assert(octeon_cop2_gfm_mul_reflect_readback(
-               0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
-    assert(octeon_rdhwr31_non_decreasing());
+    TAP_START();
+    TAP_CHECK(octeon_baddu(0x123, 0x0f0) == 0x13);
+    TAP_CHECK(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    TAP_CHECK(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    TAP_CHECK(octeon_seq(0xabc, 0xabc) == 1);
+    TAP_CHECK(octeon_seq(0xabc, 0xdef) == 0);
+    TAP_CHECK(octeon_sne(0xabc, 0xabc) == 0);
+    TAP_CHECK(octeon_sne(0xabc, 0xdef) == 1);
+    TAP_CHECK(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    TAP_CHECK(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    TAP_CHECK(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
+    TAP_CHECK(octeon_vmulu(5, 7, 11) == 46);
+    TAP_CHECK(octeon_vmm0(5, 13, 7, 11) == 59);
+    TAP_CHECK(octeon_vmm0_zeroes_mpl1() == 0);
+    TAP_CHECK(octeon_mtp0_zeroes_p1() == 0);
+    TAP_CHECK(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+              0x1122334455667788ULL);
+    TAP_CHECK(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+              0x8877665544332211ULL);
+    TAP_CHECK(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+              0x0102030405060708ULL);
+    TAP_CHECK(octeon_cop2_keylength_readback(0xa5) == 1);
+    TAP_CHECK(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
+              0x0102030405060708ULL);
+    TAP_CHECK(octeon_cop2_crc_len_readback(0xb5) == 5);
+    TAP_CHECK(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
+    TAP_CHECK(octeon_cop2_gfm_mul_reflect_write_readback(
+                  0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
+    TAP_CHECK(octeon_cop2_gfm_mul_reflect_readback(
+                  0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    TAP_CHECK(octeon_rdhwr31_non_decreasing());
 
-    return 0;
+    return tap_done();
 }
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index c80a3716f559..3b895a169758 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -5,6 +5,7 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 tests += {
   '../mips64/octeon-insns.c': {
     'qemu_args': ['-cpu', 'Octeon68XX'],
+    'protocol': 'tap',
   },
 }
 
-- 
2.55.0


