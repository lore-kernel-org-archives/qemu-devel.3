Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34A606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MCVkR/9Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Be8NDS/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Dx-0007Nk-SH; Wed, 28 Oct 2026 15:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Dv-0007I7-PF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:22:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Dp-0005o2-89
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:22:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPKst1942039
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KodiandkrgvXzvzXYKS6HS/EfKb5P0LLdohFsTPZGvo=; b=MCVkR/9QRH6YFura
 AdkzlvxDqlFfm/z2LLWqy816liNnO6cSQRT9BTiZTKbSdC9jyQya1cZKeyHraYwb
 oizm2InioHtg/meErD4kb5E2yQuZ579tMFDcWW2mijtqBnDmDv++ZKpL5F9Gjx0c
 7D5kJCMxL/98k4q8hHgo91bKBBAVlCG/F+0h1DZmjqrISCVxn5OP5tkpe4Tb4Q6A
 aDTigkDZ36kaHwooe/7286nEgrxKOGoGsE3OMj+O69VJ8/vkROt+ml3IzKi3JXFR
 W+zJ+3903LWJ+nsD2uxoTnNeWji1XNe+8w29/QPGdcCB8go0Wg5mQ7ZrgiAyvztL
 Erp2Tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwb4y0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:22:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f322ef7d3so277956285a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215322; x=1793820122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KodiandkrgvXzvzXYKS6HS/EfKb5P0LLdohFsTPZGvo=;
 b=Be8NDS/qbApZQCx58EqirYFQQ3wlSpNxZni2bmo0SZscTLoBE1vAuxLLwQMDSTekeS
 Y5iejOY2jVJDlnRBD8TUB7BKse/cu3m3YvNj6I9rSM5TtaPDqbFWD2Rw9HuKXmR0SWnS
 aYMtiZSjNAsc/xm6y9kpGx9+F5ntWquJ1/0I7YquhOmbCLMfJ8rJRl2lXKQZO32P2q29
 Ri0qUVgEw/8y+jSaS3mTiw+7oJMKc9dI/fm/CVecsPwsP1dHCtFttBC/9k3EjoljhPnO
 wN2Yie1HCdP2WFjux4Di9/27vB6rmdLInLK6STZlVOzIngCn6q5rvcWd4UxmzG863I0Z
 R4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215322; x=1793820122;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KodiandkrgvXzvzXYKS6HS/EfKb5P0LLdohFsTPZGvo=;
 b=HrR/kvOwz6lN3h+gdCCyI6C1u+TU06WTiHNFE5JVOYLFZ0IXh6R3KpPE9cOLPYoss+
 ThVN3qLFqwC/GFaELT1Rhl+HTwxmTOzXjmvK7kIMqzw4RhJ6yZp1UucYYbI9ai+JMIgk
 ITSPVvxOfrHsLwKwzq+Q062XcPkWTxP07w86uFyGP/v1VsMI+LrdF9ROE1ilM8QmovqL
 b9ELVeaihnWCe/sZmoy2assZzIcCz0WgTUUANHYJwuRP4446cRt4KsjFn2iui5wdNxBl
 OyHt99wUT42RJJk1AgoOuzfdqj0ZDpkxQQxil/edCCPIWdS6sJ5iJm6dUqe0I67hnGqn
 slbA==
X-Gm-Message-State: AFq9FYLbfmPg+u1WauFFUNtE2ajJ8Z4ZLFa2va8we/uDikSQU2x7SqBn
 cI8DzvoUXKTm9dheiRwKlWzzRqiJfH0tYzffq/lVXOdgLWjzoDMYM0ud/eDpLqok4WNPgIOYfSR
 pr9SxVnb614Btu/Kz05TcOmdX/hEI3tN0KcCg8K3pIukcaYlRoB6pwEkxCiYRoLbcBBdq
X-Gm-Gg: AYBFou2W376X/mKtAv4Q/+p+Ms3dYTyYVaRREr7uHMpJwpZV+XE1jehlZPiBmanmsp+
 3NwJ4+9vRTH1cc92LpcHG8sXUqx7GRUTL+14hntlvZ+l4xKihKNdHE1+TENx9Ff7jlmB4zXB/E5
 l3XMK098gc42pQVVmCPNH3h2bzHdRUFh+I0F4crlMwiJz/3bZPX4NnWzfCLCxxsNT5cveoRhkWS
 b+X+KkCr0S1CfjFRlxhdPFCiodB55SVkiX+qYRoosNd36qqXu2XssB8pYxoF1OQAIgdWTXWAFrw
 rZqpK2/50cXS6cfOToGXB3P4cIjAVowQwF66Cqx7bgcTaJqkvDScKBubib3HjrQ8JgonBudccYW
 OkuakkJvseiH7QwW4Th95Pk7i/f2ebDsbNYxy6S3ZWs/CEEDxrnQDG9YjzMxBPGYxOmzoJJ4iz7
 ecIXol6WA+dCSgvmlSkGjrEQOIvdGo6Q==
X-Received: by 2002:a05:620a:4001:b0:93f:3f86:c4e9 with SMTP id
 af79cd13be357-94408d58fffmr516881985a.79.1793215321231; 
 Wed, 28 Oct 2026 12:22:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4001:b0:93f:3f86:c4e9 with SMTP id
 af79cd13be357-94408d58fffmr516870985a.79.1793215319719; 
 Wed, 28 Oct 2026 12:21:59 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8dcfsm29723043f8f.50.2026.10.28.12.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/4] tests/tcg/mips: Group MSA tests
Date: Wed, 28 Oct 2026 20:21:23 +0100
Message-ID: <20261028192124.30941-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192124.30941-1-philmd@oss.qualcomm.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D1w3o0iJgh1wWvakbqR7mRcUVw7b07Jn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX+0xQsNsXCPTV
 fXRaikRX8p9Yiflcpw13pfds5M1pWz4058YBHNZknlkL9oxhOIKvJD14GfWBzGfCMbs8vZHqpX7
 o3Tqy3VDr/XJkyebIaMH7RdBYnk8ZTE=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae24b5b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=upY6tyncq-S_-SK_EtUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: D1w3o0iJgh1wWvakbqR7mRcUVw7b07Jn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX7NcEs4WC94iZ
 ltn9kAFI9GR1YrzDORa7p6zNu3vDXWpzE6sdTcAvFAElUUQNjJ2DCudpuWUgWY2hltW2P6pCJnI
 djdt+LUBjAgsPkpgvLk8KjVdgLRMa4C2OQOWIr2IYb6QfZJqp+FUGDXeGS2lte9C73I+CinsUiK
 BTHoroRDloRhpGnkontX1jN3lTAAgxjbtryHqwUhkqSdWC6n+YVkuZ1Aj6a7QJHTlK87u8IGEIT
 6irhww9K4Io6+1emE9irSmG0/i9kxUwcm3SLUle78yP1t8PatHhZplqph6ORpYwCmJJIEZcw+wJ
 tSKA5R5S/ect6FQaXgDDgrndAXnDL07ityTfvNVenYz4w3JNjCV7il3zr2CzKb85SfK/Vmteriu
 BcH38LqBK8g1Pm3zajWugAjtIO9TMSGBesUFRjJ94rud2F5slRUlpq/Hehj90T10ZrKk0JB1fP0
 /yenL7+z/wW+u/TBVZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
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

Although meson parallelize build, building 822 test executables
(274 tests * 3 for each target) is overkill. Keep the per-opcode
files unchanged, but add 17 new files for each group of instructions:

 - int-subtract
 - int-add
 - int-max-min
 - int-compare
 - shift
 - int-dot-product
 - int-average
 - interleave
 - int-divide + int-modulo
 - pack
 - int-multiply
 - fixed-multiply
 - bit-set
 - bit-count
 - bit-move
 - float-max-min
 - logic + move

This reduce to 51 executables.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 .../user/ase/msa/test_msa_group_bit_count.c   |  82 +++++
 .../user/ase/msa/test_msa_group_bit_move.c    |  76 +++++
 .../user/ase/msa/test_msa_group_bit_set.c     |  82 +++++
 .../ase/msa/test_msa_group_fixed_multiply.c   |  82 +++++
 .../ase/msa/test_msa_group_float_max_min.c    |  58 ++++
 .../user/ase/msa/test_msa_group_int_add.c     | 166 ++++++++++
 .../user/ase/msa/test_msa_group_int_average.c | 106 +++++++
 .../user/ase/msa/test_msa_group_int_compare.c | 130 ++++++++
 .../user/ase/msa/test_msa_group_int_div_mod.c | 106 +++++++
 .../ase/msa/test_msa_group_int_dot_product.c  | 118 +++++++
 .../user/ase/msa/test_msa_group_int_max_min.c | 154 +++++++++
 .../ase/msa/test_msa_group_int_multiply.c     |  82 +++++
 .../ase/msa/test_msa_group_int_subtract.c     | 214 +++++++++++++
 .../user/ase/msa/test_msa_group_interleave.c  | 106 +++++++
 .../mips/user/ase/msa/test_msa_group_logic.c  |  40 +++
 .../mips/user/ase/msa/test_msa_group_pack.c   |  82 +++++
 .../mips/user/ase/msa/test_msa_group_shift.c  | 130 ++++++++
 tests/tcg/mips/meson.build                    | 291 +-----------------
 18 files changed, 1831 insertions(+), 274 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_bit_count.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_bit_move.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_bit_set.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_fixed_multiply.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_float_max_min.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_add.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_average.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_compare.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_div_mod.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_dot_product.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_max_min.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_multiply.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_subtract.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_interleave.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_logic.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_pack.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_shift.c

diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_bit_count.c b/tests/tcg/mips/user/ase/msa/test_msa_group_bit_count.c
new file mode 100644
index 000000000000..1cc721890fd1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_bit_count.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Bit Count */
+
+#define main test_msa_nloc_b
+#include "bit-count/test_msa_nloc_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_d
+#include "bit-count/test_msa_nloc_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_h
+#include "bit-count/test_msa_nloc_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_w
+#include "bit-count/test_msa_nloc_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_b
+#include "bit-count/test_msa_nlzc_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_d
+#include "bit-count/test_msa_nlzc_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_h
+#include "bit-count/test_msa_nlzc_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_w
+#include "bit-count/test_msa_nlzc_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_b
+#include "bit-count/test_msa_pcnt_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_d
+#include "bit-count/test_msa_pcnt_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_h
+#include "bit-count/test_msa_pcnt_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_w
+#include "bit-count/test_msa_pcnt_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_nloc_b();
+    ret |= test_msa_nloc_d();
+    ret |= test_msa_nloc_h();
+    ret |= test_msa_nloc_w();
+    ret |= test_msa_nlzc_b();
+    ret |= test_msa_nlzc_d();
+    ret |= test_msa_nlzc_h();
+    ret |= test_msa_nlzc_w();
+    ret |= test_msa_pcnt_b();
+    ret |= test_msa_pcnt_d();
+    ret |= test_msa_pcnt_h();
+    ret |= test_msa_pcnt_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_bit_move.c b/tests/tcg/mips/user/ase/msa/test_msa_group_bit_move.c
new file mode 100644
index 000000000000..8de38d75578c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_bit_move.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Bit Move */
+
+#define main test_msa_binsl_b
+#include "bit-move/test_msa_binsl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_d
+#include "bit-move/test_msa_binsl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_h
+#include "bit-move/test_msa_binsl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_w
+#include "bit-move/test_msa_binsl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_b
+#include "bit-move/test_msa_binsr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_d
+#include "bit-move/test_msa_binsr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_h
+#include "bit-move/test_msa_binsr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_w
+#include "bit-move/test_msa_binsr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bmnz_v
+#include "bit-move/test_msa_bmnz_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bmz_v
+#include "bit-move/test_msa_bmz_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bsel_v
+#include "bit-move/test_msa_bsel_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_binsl_b();
+    ret |= test_msa_binsl_d();
+    ret |= test_msa_binsl_h();
+    ret |= test_msa_binsl_w();
+    ret |= test_msa_binsr_b();
+    ret |= test_msa_binsr_d();
+    ret |= test_msa_binsr_h();
+    ret |= test_msa_binsr_w();
+    ret |= test_msa_bmnz_v();
+    ret |= test_msa_bmz_v();
+    ret |= test_msa_bsel_v();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_bit_set.c b/tests/tcg/mips/user/ase/msa/test_msa_group_bit_set.c
new file mode 100644
index 000000000000..9f2b71bbeddf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_bit_set.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Bit Set */
+
+#define main test_msa_bclr_b
+#include "bit-set/test_msa_bclr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bclr_d
+#include "bit-set/test_msa_bclr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bclr_h
+#include "bit-set/test_msa_bclr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bclr_w
+#include "bit-set/test_msa_bclr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_b
+#include "bit-set/test_msa_bneg_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_d
+#include "bit-set/test_msa_bneg_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_h
+#include "bit-set/test_msa_bneg_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_w
+#include "bit-set/test_msa_bneg_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_b
+#include "bit-set/test_msa_bset_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_d
+#include "bit-set/test_msa_bset_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_h
+#include "bit-set/test_msa_bset_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_w
+#include "bit-set/test_msa_bset_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_bclr_b();
+    ret |= test_msa_bclr_d();
+    ret |= test_msa_bclr_h();
+    ret |= test_msa_bclr_w();
+    ret |= test_msa_bneg_b();
+    ret |= test_msa_bneg_d();
+    ret |= test_msa_bneg_h();
+    ret |= test_msa_bneg_w();
+    ret |= test_msa_bset_b();
+    ret |= test_msa_bset_d();
+    ret |= test_msa_bset_h();
+    ret |= test_msa_bset_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_fixed_multiply.c b/tests/tcg/mips/user/ase/msa/test_msa_group_fixed_multiply.c
new file mode 100644
index 000000000000..58c1c0373cff
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_fixed_multiply.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Fixed Multiply */
+
+#define main test_msa_madd_q_h
+#include "fixed-multiply/test_msa_madd_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_madd_q_w
+#include "fixed-multiply/test_msa_madd_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddr_q_h
+#include "fixed-multiply/test_msa_maddr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddr_q_w
+#include "fixed-multiply/test_msa_maddr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msub_q_h
+#include "fixed-multiply/test_msa_msub_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msub_q_w
+#include "fixed-multiply/test_msa_msub_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubr_q_h
+#include "fixed-multiply/test_msa_msubr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubr_q_w
+#include "fixed-multiply/test_msa_msubr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mul_q_h
+#include "fixed-multiply/test_msa_mul_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mul_q_w
+#include "fixed-multiply/test_msa_mul_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulr_q_h
+#include "fixed-multiply/test_msa_mulr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulr_q_w
+#include "fixed-multiply/test_msa_mulr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_madd_q_h();
+    ret |= test_msa_madd_q_w();
+    ret |= test_msa_maddr_q_h();
+    ret |= test_msa_maddr_q_w();
+    ret |= test_msa_msub_q_h();
+    ret |= test_msa_msub_q_w();
+    ret |= test_msa_msubr_q_h();
+    ret |= test_msa_msubr_q_w();
+    ret |= test_msa_mul_q_h();
+    ret |= test_msa_mul_q_w();
+    ret |= test_msa_mulr_q_h();
+    ret |= test_msa_mulr_q_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_float_max_min.c b/tests/tcg/mips/user/ase/msa/test_msa_group_float_max_min.c
new file mode 100644
index 000000000000..eef4e72063f7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_float_max_min.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Float Max Min */
+
+#define main test_msa_fmax_a_d
+#include "float-max-min/test_msa_fmax_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_a_w
+#include "float-max-min/test_msa_fmax_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_d
+#include "float-max-min/test_msa_fmax_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_w
+#include "float-max-min/test_msa_fmax_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_a_d
+#include "float-max-min/test_msa_fmin_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_a_w
+#include "float-max-min/test_msa_fmin_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_d
+#include "float-max-min/test_msa_fmin_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_w
+#include "float-max-min/test_msa_fmin_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_fmax_a_d();
+    ret |= test_msa_fmax_a_w();
+    ret |= test_msa_fmax_d();
+    ret |= test_msa_fmax_w();
+    ret |= test_msa_fmin_a_d();
+    ret |= test_msa_fmin_a_w();
+    ret |= test_msa_fmin_d();
+    ret |= test_msa_fmin_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_add.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_add.c
new file mode 100644
index 000000000000..b5d739c961b1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_add.c
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Add */
+
+#define main test_msa_add_a_b
+#include "int-add/test_msa_add_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_d
+#include "int-add/test_msa_add_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_h
+#include "int-add/test_msa_add_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_w
+#include "int-add/test_msa_add_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_b
+#include "int-add/test_msa_adds_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_d
+#include "int-add/test_msa_adds_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_h
+#include "int-add/test_msa_adds_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_w
+#include "int-add/test_msa_adds_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_b
+#include "int-add/test_msa_adds_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_d
+#include "int-add/test_msa_adds_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_h
+#include "int-add/test_msa_adds_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_w
+#include "int-add/test_msa_adds_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_b
+#include "int-add/test_msa_adds_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_d
+#include "int-add/test_msa_adds_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_h
+#include "int-add/test_msa_adds_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_w
+#include "int-add/test_msa_adds_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_b
+#include "int-add/test_msa_addv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_d
+#include "int-add/test_msa_addv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_h
+#include "int-add/test_msa_addv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_w
+#include "int-add/test_msa_addv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_d
+#include "int-add/test_msa_hadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_h
+#include "int-add/test_msa_hadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_w
+#include "int-add/test_msa_hadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_d
+#include "int-add/test_msa_hadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_h
+#include "int-add/test_msa_hadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_w
+#include "int-add/test_msa_hadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_add_a_b();
+    ret |= test_msa_add_a_d();
+    ret |= test_msa_add_a_h();
+    ret |= test_msa_add_a_w();
+    ret |= test_msa_adds_a_b();
+    ret |= test_msa_adds_a_d();
+    ret |= test_msa_adds_a_h();
+    ret |= test_msa_adds_a_w();
+    ret |= test_msa_adds_s_b();
+    ret |= test_msa_adds_s_d();
+    ret |= test_msa_adds_s_h();
+    ret |= test_msa_adds_s_w();
+    ret |= test_msa_adds_u_b();
+    ret |= test_msa_adds_u_d();
+    ret |= test_msa_adds_u_h();
+    ret |= test_msa_adds_u_w();
+    ret |= test_msa_addv_b();
+    ret |= test_msa_addv_d();
+    ret |= test_msa_addv_h();
+    ret |= test_msa_addv_w();
+    ret |= test_msa_hadd_s_d();
+    ret |= test_msa_hadd_s_h();
+    ret |= test_msa_hadd_s_w();
+    ret |= test_msa_hadd_u_d();
+    ret |= test_msa_hadd_u_h();
+    ret |= test_msa_hadd_u_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_average.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_average.c
new file mode 100644
index 000000000000..c51ed23698ad
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_average.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Average */
+
+#define main test_msa_ave_s_b
+#include "int-average/test_msa_ave_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_d
+#include "int-average/test_msa_ave_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_h
+#include "int-average/test_msa_ave_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_w
+#include "int-average/test_msa_ave_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_b
+#include "int-average/test_msa_ave_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_d
+#include "int-average/test_msa_ave_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_h
+#include "int-average/test_msa_ave_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_w
+#include "int-average/test_msa_ave_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_b
+#include "int-average/test_msa_aver_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_d
+#include "int-average/test_msa_aver_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_h
+#include "int-average/test_msa_aver_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_w
+#include "int-average/test_msa_aver_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_b
+#include "int-average/test_msa_aver_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_d
+#include "int-average/test_msa_aver_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_h
+#include "int-average/test_msa_aver_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_w
+#include "int-average/test_msa_aver_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_ave_s_b();
+    ret |= test_msa_ave_s_d();
+    ret |= test_msa_ave_s_h();
+    ret |= test_msa_ave_s_w();
+    ret |= test_msa_ave_u_b();
+    ret |= test_msa_ave_u_d();
+    ret |= test_msa_ave_u_h();
+    ret |= test_msa_ave_u_w();
+    ret |= test_msa_aver_s_b();
+    ret |= test_msa_aver_s_d();
+    ret |= test_msa_aver_s_h();
+    ret |= test_msa_aver_s_w();
+    ret |= test_msa_aver_u_b();
+    ret |= test_msa_aver_u_d();
+    ret |= test_msa_aver_u_h();
+    ret |= test_msa_aver_u_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_compare.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_compare.c
new file mode 100644
index 000000000000..c61347ad0210
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_compare.c
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Compare */
+
+#define main test_msa_ceq_b
+#include "int-compare/test_msa_ceq_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_d
+#include "int-compare/test_msa_ceq_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_h
+#include "int-compare/test_msa_ceq_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_w
+#include "int-compare/test_msa_ceq_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_b
+#include "int-compare/test_msa_cle_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_d
+#include "int-compare/test_msa_cle_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_h
+#include "int-compare/test_msa_cle_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_w
+#include "int-compare/test_msa_cle_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_b
+#include "int-compare/test_msa_cle_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_d
+#include "int-compare/test_msa_cle_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_h
+#include "int-compare/test_msa_cle_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_w
+#include "int-compare/test_msa_cle_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_b
+#include "int-compare/test_msa_clt_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_d
+#include "int-compare/test_msa_clt_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_h
+#include "int-compare/test_msa_clt_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_w
+#include "int-compare/test_msa_clt_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_b
+#include "int-compare/test_msa_clt_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_d
+#include "int-compare/test_msa_clt_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_h
+#include "int-compare/test_msa_clt_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_w
+#include "int-compare/test_msa_clt_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_ceq_b();
+    ret |= test_msa_ceq_d();
+    ret |= test_msa_ceq_h();
+    ret |= test_msa_ceq_w();
+    ret |= test_msa_cle_s_b();
+    ret |= test_msa_cle_s_d();
+    ret |= test_msa_cle_s_h();
+    ret |= test_msa_cle_s_w();
+    ret |= test_msa_cle_u_b();
+    ret |= test_msa_cle_u_d();
+    ret |= test_msa_cle_u_h();
+    ret |= test_msa_cle_u_w();
+    ret |= test_msa_clt_s_b();
+    ret |= test_msa_clt_s_d();
+    ret |= test_msa_clt_s_h();
+    ret |= test_msa_clt_s_w();
+    ret |= test_msa_clt_u_b();
+    ret |= test_msa_clt_u_d();
+    ret |= test_msa_clt_u_h();
+    ret |= test_msa_clt_u_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_div_mod.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_div_mod.c
new file mode 100644
index 000000000000..22f38f34293b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_div_mod.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Divide and Modulo */
+
+#define main test_msa_div_s_b
+#include "int-divide/test_msa_div_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_d
+#include "int-divide/test_msa_div_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_h
+#include "int-divide/test_msa_div_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_w
+#include "int-divide/test_msa_div_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_b
+#include "int-divide/test_msa_div_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_d
+#include "int-divide/test_msa_div_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_h
+#include "int-divide/test_msa_div_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_w
+#include "int-divide/test_msa_div_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_b
+#include "int-modulo/test_msa_mod_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_d
+#include "int-modulo/test_msa_mod_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_h
+#include "int-modulo/test_msa_mod_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_w
+#include "int-modulo/test_msa_mod_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_b
+#include "int-modulo/test_msa_mod_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_d
+#include "int-modulo/test_msa_mod_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_h
+#include "int-modulo/test_msa_mod_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_w
+#include "int-modulo/test_msa_mod_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_div_s_b();
+    ret |= test_msa_div_s_d();
+    ret |= test_msa_div_s_h();
+    ret |= test_msa_div_s_w();
+    ret |= test_msa_div_u_b();
+    ret |= test_msa_div_u_d();
+    ret |= test_msa_div_u_h();
+    ret |= test_msa_div_u_w();
+    ret |= test_msa_mod_s_b();
+    ret |= test_msa_mod_s_d();
+    ret |= test_msa_mod_s_h();
+    ret |= test_msa_mod_s_w();
+    ret |= test_msa_mod_u_b();
+    ret |= test_msa_mod_u_d();
+    ret |= test_msa_mod_u_h();
+    ret |= test_msa_mod_u_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_dot_product.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_dot_product.c
new file mode 100644
index 000000000000..fb9d9d63ee42
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_dot_product.c
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Dot Product */
+
+#define main test_msa_dotp_s_d
+#include "int-dot-product/test_msa_dotp_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_h
+#include "int-dot-product/test_msa_dotp_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_w
+#include "int-dot-product/test_msa_dotp_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_d
+#include "int-dot-product/test_msa_dotp_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_h
+#include "int-dot-product/test_msa_dotp_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_w
+#include "int-dot-product/test_msa_dotp_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_d
+#include "int-dot-product/test_msa_dpadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_h
+#include "int-dot-product/test_msa_dpadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_w
+#include "int-dot-product/test_msa_dpadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_d
+#include "int-dot-product/test_msa_dpadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_h
+#include "int-dot-product/test_msa_dpadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_w
+#include "int-dot-product/test_msa_dpadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_d
+#include "int-dot-product/test_msa_dpsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_h
+#include "int-dot-product/test_msa_dpsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_w
+#include "int-dot-product/test_msa_dpsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_d
+#include "int-dot-product/test_msa_dpsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_h
+#include "int-dot-product/test_msa_dpsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_w
+#include "int-dot-product/test_msa_dpsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_dotp_s_d();
+    ret |= test_msa_dotp_s_h();
+    ret |= test_msa_dotp_s_w();
+    ret |= test_msa_dotp_u_d();
+    ret |= test_msa_dotp_u_h();
+    ret |= test_msa_dotp_u_w();
+    ret |= test_msa_dpadd_s_d();
+    ret |= test_msa_dpadd_s_h();
+    ret |= test_msa_dpadd_s_w();
+    ret |= test_msa_dpadd_u_d();
+    ret |= test_msa_dpadd_u_h();
+    ret |= test_msa_dpadd_u_w();
+    ret |= test_msa_dpsub_s_d();
+    ret |= test_msa_dpsub_s_h();
+    ret |= test_msa_dpsub_s_w();
+    ret |= test_msa_dpsub_u_d();
+    ret |= test_msa_dpsub_u_h();
+    ret |= test_msa_dpsub_u_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_max_min.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_max_min.c
new file mode 100644
index 000000000000..0342230f749d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_max_min.c
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Max Min */
+
+#define main test_msa_max_a_b
+#include "int-max-min/test_msa_max_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_d
+#include "int-max-min/test_msa_max_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_h
+#include "int-max-min/test_msa_max_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_w
+#include "int-max-min/test_msa_max_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_b
+#include "int-max-min/test_msa_max_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_d
+#include "int-max-min/test_msa_max_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_h
+#include "int-max-min/test_msa_max_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_w
+#include "int-max-min/test_msa_max_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_b
+#include "int-max-min/test_msa_max_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_d
+#include "int-max-min/test_msa_max_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_h
+#include "int-max-min/test_msa_max_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_w
+#include "int-max-min/test_msa_max_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_b
+#include "int-max-min/test_msa_min_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_d
+#include "int-max-min/test_msa_min_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_h
+#include "int-max-min/test_msa_min_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_w
+#include "int-max-min/test_msa_min_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_b
+#include "int-max-min/test_msa_min_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_d
+#include "int-max-min/test_msa_min_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_h
+#include "int-max-min/test_msa_min_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_w
+#include "int-max-min/test_msa_min_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_b
+#include "int-max-min/test_msa_min_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_d
+#include "int-max-min/test_msa_min_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_h
+#include "int-max-min/test_msa_min_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_w
+#include "int-max-min/test_msa_min_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_max_a_b();
+    ret |= test_msa_max_a_d();
+    ret |= test_msa_max_a_h();
+    ret |= test_msa_max_a_w();
+    ret |= test_msa_max_s_b();
+    ret |= test_msa_max_s_d();
+    ret |= test_msa_max_s_h();
+    ret |= test_msa_max_s_w();
+    ret |= test_msa_max_u_b();
+    ret |= test_msa_max_u_d();
+    ret |= test_msa_max_u_h();
+    ret |= test_msa_max_u_w();
+    ret |= test_msa_min_a_b();
+    ret |= test_msa_min_a_d();
+    ret |= test_msa_min_a_h();
+    ret |= test_msa_min_a_w();
+    ret |= test_msa_min_s_b();
+    ret |= test_msa_min_s_d();
+    ret |= test_msa_min_s_h();
+    ret |= test_msa_min_s_w();
+    ret |= test_msa_min_u_b();
+    ret |= test_msa_min_u_d();
+    ret |= test_msa_min_u_h();
+    ret |= test_msa_min_u_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_multiply.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_multiply.c
new file mode 100644
index 000000000000..1e74616b01ce
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_multiply.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Multiply */
+
+#define main test_msa_maddv_b
+#include "int-multiply/test_msa_maddv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_d
+#include "int-multiply/test_msa_maddv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_h
+#include "int-multiply/test_msa_maddv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_w
+#include "int-multiply/test_msa_maddv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_b
+#include "int-multiply/test_msa_msubv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_d
+#include "int-multiply/test_msa_msubv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_h
+#include "int-multiply/test_msa_msubv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_w
+#include "int-multiply/test_msa_msubv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_b
+#include "int-multiply/test_msa_mulv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_d
+#include "int-multiply/test_msa_mulv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_h
+#include "int-multiply/test_msa_mulv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_w
+#include "int-multiply/test_msa_mulv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_maddv_b();
+    ret |= test_msa_maddv_d();
+    ret |= test_msa_maddv_h();
+    ret |= test_msa_maddv_w();
+    ret |= test_msa_msubv_b();
+    ret |= test_msa_msubv_d();
+    ret |= test_msa_msubv_h();
+    ret |= test_msa_msubv_w();
+    ret |= test_msa_mulv_b();
+    ret |= test_msa_mulv_d();
+    ret |= test_msa_mulv_h();
+    ret |= test_msa_mulv_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_int_subtract.c b/tests/tcg/mips/user/ase/msa/test_msa_group_int_subtract.c
new file mode 100644
index 000000000000..7407fd1eb575
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_int_subtract.c
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Int Subtract */
+
+#define main test_msa_asub_s_b
+#include "int-subtract/test_msa_asub_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_d
+#include "int-subtract/test_msa_asub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_h
+#include "int-subtract/test_msa_asub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_w
+#include "int-subtract/test_msa_asub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_b
+#include "int-subtract/test_msa_asub_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_d
+#include "int-subtract/test_msa_asub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_h
+#include "int-subtract/test_msa_asub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_w
+#include "int-subtract/test_msa_asub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_d
+#include "int-subtract/test_msa_hsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_h
+#include "int-subtract/test_msa_hsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_w
+#include "int-subtract/test_msa_hsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_d
+#include "int-subtract/test_msa_hsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_h
+#include "int-subtract/test_msa_hsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_w
+#include "int-subtract/test_msa_hsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_b
+#include "int-subtract/test_msa_subs_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_d
+#include "int-subtract/test_msa_subs_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_h
+#include "int-subtract/test_msa_subs_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_w
+#include "int-subtract/test_msa_subs_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_b
+#include "int-subtract/test_msa_subs_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_d
+#include "int-subtract/test_msa_subs_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_h
+#include "int-subtract/test_msa_subs_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_w
+#include "int-subtract/test_msa_subs_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_b
+#include "int-subtract/test_msa_subsus_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_d
+#include "int-subtract/test_msa_subsus_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_h
+#include "int-subtract/test_msa_subsus_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_w
+#include "int-subtract/test_msa_subsus_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_b
+#include "int-subtract/test_msa_subsuu_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_d
+#include "int-subtract/test_msa_subsuu_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_h
+#include "int-subtract/test_msa_subsuu_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_w
+#include "int-subtract/test_msa_subsuu_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_b
+#include "int-subtract/test_msa_subv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_d
+#include "int-subtract/test_msa_subv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_h
+#include "int-subtract/test_msa_subv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_w
+#include "int-subtract/test_msa_subv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_asub_s_b();
+    ret |= test_msa_asub_s_d();
+    ret |= test_msa_asub_s_h();
+    ret |= test_msa_asub_s_w();
+    ret |= test_msa_asub_u_b();
+    ret |= test_msa_asub_u_d();
+    ret |= test_msa_asub_u_h();
+    ret |= test_msa_asub_u_w();
+    ret |= test_msa_hsub_s_d();
+    ret |= test_msa_hsub_s_h();
+    ret |= test_msa_hsub_s_w();
+    ret |= test_msa_hsub_u_d();
+    ret |= test_msa_hsub_u_h();
+    ret |= test_msa_hsub_u_w();
+    ret |= test_msa_subs_s_b();
+    ret |= test_msa_subs_s_d();
+    ret |= test_msa_subs_s_h();
+    ret |= test_msa_subs_s_w();
+    ret |= test_msa_subs_u_b();
+    ret |= test_msa_subs_u_d();
+    ret |= test_msa_subs_u_h();
+    ret |= test_msa_subs_u_w();
+    ret |= test_msa_subsus_u_b();
+    ret |= test_msa_subsus_u_d();
+    ret |= test_msa_subsus_u_h();
+    ret |= test_msa_subsus_u_w();
+    ret |= test_msa_subsuu_s_b();
+    ret |= test_msa_subsuu_s_d();
+    ret |= test_msa_subsuu_s_h();
+    ret |= test_msa_subsuu_s_w();
+    ret |= test_msa_subv_b();
+    ret |= test_msa_subv_d();
+    ret |= test_msa_subv_h();
+    ret |= test_msa_subv_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_interleave.c b/tests/tcg/mips/user/ase/msa/test_msa_group_interleave.c
new file mode 100644
index 000000000000..660ffa196029
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_interleave.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Interleave */
+
+#define main test_msa_ilvev_b
+#include "interleave/test_msa_ilvev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_d
+#include "interleave/test_msa_ilvev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_h
+#include "interleave/test_msa_ilvev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_w
+#include "interleave/test_msa_ilvev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_b
+#include "interleave/test_msa_ilvl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_d
+#include "interleave/test_msa_ilvl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_h
+#include "interleave/test_msa_ilvl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_w
+#include "interleave/test_msa_ilvl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_b
+#include "interleave/test_msa_ilvod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_d
+#include "interleave/test_msa_ilvod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_h
+#include "interleave/test_msa_ilvod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_w
+#include "interleave/test_msa_ilvod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_b
+#include "interleave/test_msa_ilvr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_d
+#include "interleave/test_msa_ilvr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_h
+#include "interleave/test_msa_ilvr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_w
+#include "interleave/test_msa_ilvr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_ilvev_b();
+    ret |= test_msa_ilvev_d();
+    ret |= test_msa_ilvev_h();
+    ret |= test_msa_ilvev_w();
+    ret |= test_msa_ilvl_b();
+    ret |= test_msa_ilvl_d();
+    ret |= test_msa_ilvl_h();
+    ret |= test_msa_ilvl_w();
+    ret |= test_msa_ilvod_b();
+    ret |= test_msa_ilvod_d();
+    ret |= test_msa_ilvod_h();
+    ret |= test_msa_ilvod_w();
+    ret |= test_msa_ilvr_b();
+    ret |= test_msa_ilvr_d();
+    ret |= test_msa_ilvr_h();
+    ret |= test_msa_ilvr_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_logic.c b/tests/tcg/mips/user/ase/msa/test_msa_group_logic.c
new file mode 100644
index 000000000000..44f045a7efe8
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_logic.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Logic and Move */
+
+#define main test_msa_and_v
+#include "logic/test_msa_and_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nor_v
+#include "logic/test_msa_nor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_or_v
+#include "logic/test_msa_or_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_xor_v
+#include "logic/test_msa_xor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_move_v
+#include "move/test_msa_move_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_and_v();
+    ret |= test_msa_nor_v();
+    ret |= test_msa_or_v();
+    ret |= test_msa_xor_v();
+    ret |= test_msa_move_v();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_pack.c b/tests/tcg/mips/user/ase/msa/test_msa_group_pack.c
new file mode 100644
index 000000000000..2eefc509d11e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_pack.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Pack */
+
+#define main test_msa_pckev_b
+#include "pack/test_msa_pckev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_d
+#include "pack/test_msa_pckev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_h
+#include "pack/test_msa_pckev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_w
+#include "pack/test_msa_pckev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_b
+#include "pack/test_msa_pckod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_d
+#include "pack/test_msa_pckod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_h
+#include "pack/test_msa_pckod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_w
+#include "pack/test_msa_pckod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_b
+#include "pack/test_msa_vshf_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_d
+#include "pack/test_msa_vshf_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_h
+#include "pack/test_msa_vshf_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_w
+#include "pack/test_msa_vshf_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_pckev_b();
+    ret |= test_msa_pckev_d();
+    ret |= test_msa_pckev_h();
+    ret |= test_msa_pckev_w();
+    ret |= test_msa_pckod_b();
+    ret |= test_msa_pckod_d();
+    ret |= test_msa_pckod_h();
+    ret |= test_msa_pckod_w();
+    ret |= test_msa_vshf_b();
+    ret |= test_msa_vshf_d();
+    ret |= test_msa_vshf_h();
+    ret |= test_msa_vshf_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_group_shift.c b/tests/tcg/mips/user/ase/msa/test_msa_group_shift.c
new file mode 100644
index 000000000000..d642931dbb7c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_group_shift.c
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS MSA tests: Shift */
+
+#define main test_msa_sll_b
+#include "shift/test_msa_sll_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_d
+#include "shift/test_msa_sll_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_h
+#include "shift/test_msa_sll_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_w
+#include "shift/test_msa_sll_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_b
+#include "shift/test_msa_sra_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_d
+#include "shift/test_msa_sra_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_h
+#include "shift/test_msa_sra_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_w
+#include "shift/test_msa_sra_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_b
+#include "shift/test_msa_srar_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_d
+#include "shift/test_msa_srar_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_h
+#include "shift/test_msa_srar_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_w
+#include "shift/test_msa_srar_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_b
+#include "shift/test_msa_srl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_d
+#include "shift/test_msa_srl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_h
+#include "shift/test_msa_srl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_w
+#include "shift/test_msa_srl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_b
+#include "shift/test_msa_srlr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_d
+#include "shift/test_msa_srlr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_h
+#include "shift/test_msa_srlr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_w
+#include "shift/test_msa_srlr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_msa_sll_b();
+    ret |= test_msa_sll_d();
+    ret |= test_msa_sll_h();
+    ret |= test_msa_sll_w();
+    ret |= test_msa_sra_b();
+    ret |= test_msa_sra_d();
+    ret |= test_msa_sra_h();
+    ret |= test_msa_sra_w();
+    ret |= test_msa_srar_b();
+    ret |= test_msa_srar_d();
+    ret |= test_msa_srar_h();
+    ret |= test_msa_srar_w();
+    ret |= test_msa_srl_b();
+    ret |= test_msa_srl_d();
+    ret |= test_msa_srl_h();
+    ret |= test_msa_srl_w();
+    ret |= test_msa_srlr_b();
+    ret |= test_msa_srlr_d();
+    ret |= test_msa_srlr_h();
+    ret |= test_msa_srlr_w();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 88d598a4f89b..11642da4122e 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -23,278 +23,21 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_d.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_h.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_b.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_d.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_w.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_d.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_w.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_b.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_h.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_h.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_w.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bsel_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bmz_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_b.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_d.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_w.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_h.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_w.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_w.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_w.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c',
-  '../mips/user/ase/msa/logic/test_msa_or_v.c',
-  '../mips/user/ase/msa/logic/test_msa_nor_v.c',
-  '../mips/user/ase/msa/logic/test_msa_and_v.c',
-  '../mips/user/ase/msa/logic/test_msa_xor_v.c',
-  '../mips/user/ase/msa/move/test_msa_move_v.c',
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
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_b.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_d.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_b.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_w.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_w.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_b.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_w.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_d.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c',
+  '../mips/user/ase/msa/test_msa_group_bit_count.c',
+  '../mips/user/ase/msa/test_msa_group_bit_move.c',
+  '../mips/user/ase/msa/test_msa_group_bit_set.c',
+  '../mips/user/ase/msa/test_msa_group_fixed_multiply.c',
+  '../mips/user/ase/msa/test_msa_group_float_max_min.c',
+  '../mips/user/ase/msa/test_msa_group_int_add.c',
+  '../mips/user/ase/msa/test_msa_group_int_average.c',
+  '../mips/user/ase/msa/test_msa_group_int_compare.c',
+  '../mips/user/ase/msa/test_msa_group_int_div_mod.c',
+  '../mips/user/ase/msa/test_msa_group_int_dot_product.c',
+  '../mips/user/ase/msa/test_msa_group_int_max_min.c',
+  '../mips/user/ase/msa/test_msa_group_int_multiply.c',
+  '../mips/user/ase/msa/test_msa_group_int_subtract.c',
+  '../mips/user/ase/msa/test_msa_group_interleave.c',
+  '../mips/user/ase/msa/test_msa_group_logic.c',
+  '../mips/user/ase/msa/test_msa_group_pack.c',
+  '../mips/user/ase/msa/test_msa_group_shift.c',
 ]
-- 
2.55.0


