Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7F606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b60MtCmA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i47pMzup
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAc-0002Ta-W6; Fri, 30 Oct 2026 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9p-00029n-8B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9i-0007HF-Nl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UESGFA1954473
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9BQjzX+azq2orh3caPQpg5u7CALnO/bV2U9gqPrzxVI=; b=b60MtCmAkpjbxFqi
 RegLAYdpwSbXzAl8WR1Wx9BPpkrlDfvQkJAK8CJ1s7dn5FUDuWkqUkc2BqPmIimA
 Y8VHar5BQiTb/pRbJl6MAJr2gev4qggIwQRiw2gQWl0hu9VSctADLPKcTaTkGVtT
 CUww+qjF8kZ56qYkU4V1gQ1PD3TKO55CJKwAGSQFEfXGd3QuaFlPu8Yv912mSsKf
 3h3Eiva3bbdVmteAicgQeMjscwWUfkK1tfqs16gycqZ6kfyN7SxIQnAqOQ6cOdQ6
 sM/pMnUj+Wb9nAVlO/5BPEw7Yy9sIlAiEm1kuh8Blh5Igf9JBv4mwVbJBUFu3K+D
 GnqVLg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pknep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:33 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso59237137.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372672; x=1793977472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9BQjzX+azq2orh3caPQpg5u7CALnO/bV2U9gqPrzxVI=;
 b=i47pMzup8UDfEjfv3vwT8ZvZzr8vrz/uis4CejFWSDR3EhzBr2o8ZJ5pTO0ej87Jgj
 3Tq+UtWTbv1z7OQbZKzG8i4pcXKTvZ3F4o9HP9X/ZLdvO1/axaKrc+ac201/V8XjVv65
 +GyhuyEZQD2JhawL2wmB4OzyTyR6+tajoG/oCSNELnzA1DctzX890xMYmuT0N0QVd9Mh
 +VLWzAF+/pAqhyFuusVM8Z8Glt+s4CrqBGhPrjWEuNJjGnfa1sEXJ5AdF+hNEy530J32
 2UkHQATqqPcgnGNCBfHDBm+Nwn90Kwvdww5vX2+Vy6s72KMWZf9pC6KsHMc4tMJf/LlK
 0TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372672; x=1793977472;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9BQjzX+azq2orh3caPQpg5u7CALnO/bV2U9gqPrzxVI=;
 b=CcXpbCQFXaVxdAAqpgi1quDx7oi1EmVuq4TPVhnY/lQgnuqXPJHlnnt8/smQdhy2gU
 BjXK08L4aAhGDn5zUWWWeUp8QCxB1EYQwZLjg71KTaJZJZGenUndGyFNE6IH3002w/RF
 ZOddsfa5LfWPglDPz+Pw/f/q0G/V2sinC4xmWNZhiqMLInMm7/PM6EfN+e0T4H/XSrGE
 LmYloaBeGjxVis8a6/dCkwvKCYoN3DG7oZhcFPEg/0GbyGNGURDbknKpHmv7FwX2/t7W
 zVkgO7+/pkCZ8Yssjq9pxBhHzNSgrMeiAvKiXIb22Cod/lv9x3xfGWuWGUOKHmJN8oTF
 Genw==
X-Gm-Message-State: AFq9FYLZMEWYIC21VZsrmzLF+dXhzTyHSlBX9WUVzekPEgSFJQArBx98
 YyzmR9d41NPquhvYd1lDeLqJptvIxBfs9HOEEqG9Kt3ccd2Lh7CulTceHyPOlK2VHspwkl1M2Ba
 ApP+Fek5ONpdm0viyPG2jNGhiS0r68dcZSSoX+trUHQrbWFrgsa5ILt+btWq8zYg8n610
X-Gm-Gg: AYBFou3H4w3+W4OuKJoa7dmx+Nyc4aTovK7MZPsH6lldKeT85+JhcrP9GNRQoyFZvRv
 IZY+epq+bg7z/nSXSSEqgZ5JcYhlnvoNvAB9+ZQC1JMeSxIowFJjZUg5GWrS6nveJ2tH9yczaun
 4R9BzTRTXFEIX0Oqth69RVLylMHiiFla94J8XH8PMgLaV84FeDySxtQyhSQQXdGSqDgPJbRDB1F
 oiZ/0c0n2CIYtN9tAMI2ROANg04eESsO46XrDtZhbTii5hAfmhaXHNTK5bx6yco+E9MkZ1wdw5Y
 4spP8IaFeN9qjNxNEMZ/2vWLF1x1SeHhf8TolOI8M7sRbD2JDbwy51/iFJOVd0njKb7v37Nzg67
 8MJ/4AoptFZmfbSvHQnRZmsoIDMi0/cumP1KvtwP8FGswXC5vltVPGCyyTPTOD7ykxqL4A34y4m
 eixpsl5H9tAGnn+ioiwerPjPJg78kNwA==
X-Received: by 2002:a05:6102:6cc:b0:7d0:3da9:3e16 with SMTP id
 ada2fe7eead31-7d07227aaa9mr1244613137.3.1793372672175; 
 Fri, 30 Oct 2026 08:04:32 -0700 (PDT)
X-Received: by 2002:a05:6102:6cc:b0:7d0:3da9:3e16 with SMTP id
 ada2fe7eead31-7d07227aaa9mr1244532137.3.1793372671398; 
 Fri, 30 Oct 2026 08:04:31 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09fadb75sm38982035e9.3.2026.10.30.08.04.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/31] tests/tcg/mips: Group MSA fixed-multiply tests
Date: Fri, 30 Oct 2026 16:01:47 +0100
Message-ID: <20261030150202.61556-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX1M94CQ6v3rTU
 /FMNy0NEGYJEIlbQ35HDPNFGCBavFUzrA8RVqQithMGmk7F6iKX/QXP2PPmxqaBa5x0ACp06XQA
 pIs4zJ9PwwLktIuh7ZXR28A0JqindFiipuut20/dAbAbCKCAse+fXZ7j91CA4Qe5wcYX6pwMp96
 i4ce8hm3cWDL0F2IWuR8jW+mp7cs4xpTrC2sCEe/wbFfP0jX8ktLQGku3O/WcCO8Po8D3S6uPMP
 CgNhFP6U4yAAl01kGmHhBwKQZVlPjiqENwtb7qJQK5lvV5Sc41JgqnE6TBiJOXLFHoGBUkJVmdO
 DmJVE9T+rYbM1j4TycDuCilHUqK5ippv59PBQRu2zUdtM5Tn0ugsNodgVYtj00Kd5MK7zOPqS+2
 5uOl63QsGQjxi0GO9bR4GD8RByCSq3BM4D/LFJFeAjHH8y9hf5cXUeoJZY2vyfbF3Hjo9NERjlw
 L/idIf4eRNpMaBW/eIA==
X-Proofpoint-ORIG-GUID: J1Npt6LMEdh8vlUt94NvVqMrhmAP0O7m
X-Proofpoint-GUID: J1Npt6LMEdh8vlUt94NvVqMrhmAP0O7m
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4b201 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX41ivPTt+Xg0l
 bS8hFcx8E7jVvcip2Us5qI040hcZth92jRSXwWxwqhC7hyfv54O1o/nTWrgz2OggvxwJ12ilcrD
 Y5bioN7r6E8rz+BhHz5+WE7q7JH93w4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Build the 12 per-opcode fixed-multiply tests as a single executable,
test_msa_fixed_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_fixed_multiply.c | 99 ++++++++++++++++++++++++
 tests/tcg/mips/meson.build               | 13 +---
 2 files changed, 100 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_fixed_multiply.c

diff --git a/tests/tcg/mips/test_msa_fixed_multiply.c b/tests/tcg/mips/test_msa_fixed_multiply.c
new file mode 100644
index 000000000000..7eb5bfe1b539
--- /dev/null
+++ b/tests/tcg/mips/test_msa_fixed_multiply.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Fixed Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_madd_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_madd_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_madd_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_madd_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddr_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddr_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msub_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_msub_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msub_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_msub_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubr_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubr_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mul_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_mul_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mul_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_mul_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulr_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulr_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "madd.q.h", test_msa_madd_q_h },
+    { "madd.q.w", test_msa_madd_q_w },
+    { "maddr.q.h", test_msa_maddr_q_h },
+    { "maddr.q.w", test_msa_maddr_q_w },
+    { "msub.q.h", test_msa_msub_q_h },
+    { "msub.q.w", test_msa_msub_q_w },
+    { "msubr.q.h", test_msa_msubr_q_h },
+    { "msubr.q.w", test_msa_msubr_q_w },
+    { "mul.q.h", test_msa_mul_q_h },
+    { "mul.q.w", test_msa_mul_q_w },
+    { "mulr.q.h", test_msa_mulr_q_h },
+    { "mulr.q.w", test_msa_mulr_q_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Fixed Multiply", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 03f3ce57d3cf..17e3fe3e55ae 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -5,6 +5,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
+  '../mips/test_msa_fixed_multiply.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -199,18 +200,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
   '../mips/user/ase/msa/logic/test_msa_xor_v.c',
   '../mips/user/ase/msa/move/test_msa_move_v.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
-- 
2.55.0


