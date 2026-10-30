Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ffHM/+ta;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YLlbI1gM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAq-0003PG-JX; Fri, 30 Oct 2026 11:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAb-0002a3-Bj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAX-0007VO-Cw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERJon2596868
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6RyVs3nUetjaaD9VgdwFw8WA7SXZIHT2DbGgv6Jstn0=; b=ffHM/+tauSLeL51e
 VA+3siFe/Dh4RwjtswIBFoeZYssnNKnBvc9srSKRW6xnCJKPFPBvurG2+2RXFxTx
 5vO4wCS4c3B7WxK1KgIA/EpzLt6YCOYUd/RpjexDfq/dp4VQ3KeKQoDTSg1MGZF8
 RWi439Rv8yLAM/mgx+u+PSf5Lpr4CYhRZVUi+xxfU1u2FE2/+CLgIADS9Ro3D6Oo
 vVG+hBaCQbwqq5i0jb1qxhdRJz2WeW7EFMS4VZeEWt8k7Tt5sBsCluW60u8MUJ6I
 ktr7G6IWfzgnYBSE/1jXzuWPdolYFijaWOHmvWyIokqdl4fjzho7Jt95dtnEi2Ju
 b2ynxQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pbnf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:22 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc06b9cb33so159775137.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372722; x=1793977522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6RyVs3nUetjaaD9VgdwFw8WA7SXZIHT2DbGgv6Jstn0=;
 b=YLlbI1gMuDzyn7ns8vTWjVWv2Ve/xai1G71nziX09iclBxT5vzaO87RZIq8JNe1y6X
 CNUmiPJE374ExqJUu+OPWPqQ0zQ+sQnP1emKdusjUvHDAY7pKC7uQpz/+6afbKNdMSTw
 6xdc2LFujLfx1eeMEid5A+QCRvLLgHiHJRSYo0Z0dqqbVY7TRaTmXyWx8LMOpdwbkVSp
 KdA+UNEwI+kOvYdAUJC2CfF8MvLNSr/NDntvv6zeA8c9YHWs4sRXzjPPRajWHFBDZj2g
 70AQQQ4IxzC3zes7P5w/OXtYsc6Xkp5q2Vht9KeNwd/LQ2DeHPmrq5Jgx6TnTbMB/6fq
 nAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372722; x=1793977522;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6RyVs3nUetjaaD9VgdwFw8WA7SXZIHT2DbGgv6Jstn0=;
 b=fq9WHcnwsDJYv+c0BoKUo+vII1krhPyPYF2p8Kzs9IDbxFr1XcJ4X9P9P3Yhy7V0sB
 edtuyo4pi1HU2bHI+v6gKkaG6uCEbp9w7n80+l1P4DJ5Zcon5GleKWYwE3R4ZT4lIGTF
 MMug8l6hucu7QUrakV3fqaH/2DFXlQy+a9YIVNlH2WYR0MrGph67W0alSOZ5tGi2SxzO
 JNVtprXj/K1eUglwyjFdWcmKAmoAa65CbpFdtUhEpYaLlOi9S6kyvOzyQ4rFqsQyvMLc
 DW7mu4SJt8+fh3dO6djmLclJ+fupZCZbKLXvCpUFOSHo/Iioxo1r2JxCdRjj36uRXZ9v
 KOlQ==
X-Gm-Message-State: AFq9FYIiYccYRornHPh6OxmmBVpHuuyLOSEn0tPSwbDYH328t/oAgMEp
 YI/tQGboz/i7CV265hjSD5ctVMYqhcftnQcIqs1m/jVK58i44qobn175PrVHWYapPjjHHlXtdK4
 X91eBrC8EbEIYLo9fE3ADcUaa0XhwMSoXboDlUbHwAK7wa1wZ0qHoFJoxuspFWm8irlXS
X-Gm-Gg: AYBFou3cwTlvVyFF+ewjyfnIi4q7hgxGZNeGCvww7sl24aoBKZT2K2zSpxV83e5eK7d
 s/XAolh4Ust4NIAsz2XtzmdZEdNtgI3vEw/NmzxQ/P6SdKFEpKIhGq5tYPXxFM3egOL0CqcHwX8
 uHa8jqwxpMX6z98lvmPlsX3411gYQj3xHHTEhVvcIyljAkiyPyctQNrS/AEAcKcpi+vLb7IZn5P
 iWX07TkWb7k9HFihKY0PkalwW5f6XEeayor989ovOAmLGOJOYTJYJhvlZewa5dFYSm8yVwuCUuX
 zYOVzSevoLrUrwpe21KZxy9imNTVgA5YfGfdLmVW3tkrTH33N8SDOteBL94AEHcpeirzPJKJDgH
 UUm3HR1EkMZHtckwot+o5nTTaP1UVAbMjp109Uo6IPT1AGs/szEINYPp5cPEsJOejnfwtgybyAT
 95bs+6fzjlISvTvb7YthR5OyOUrxtEOQ==
X-Received: by 2002:a05:6102:418d:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d072554415mr1288641137.9.1793372720166; 
 Fri, 30 Oct 2026 08:05:20 -0700 (PDT)
X-Received: by 2002:a05:6102:418d:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d072554415mr1288490137.9.1793372718102; 
 Fri, 30 Oct 2026 08:05:18 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09cc3e9asm26116895e9.3.2026.10.30.08.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/31] tests/tcg/mips: Group MSA int-div-mod tests
Date: Fri, 30 Oct 2026 16:01:52 +0100
Message-ID: <20261030150202.61556-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfXzrMD/Zi34GH3
 5bwN7DdIAmYNTTotm16EPkGcNr4JPLXQ//jgz+gGX0QY9uNQX3K+I2aVSLj7iszT55KKM5eumFI
 J/a3svIlwdy60j5jX6S1GllXyXcrpLOLOUApB8yJFiHMUyQL+4CAswP04l/YfXy3ZzsSv9A7WWd
 YGagXqp4vm0eEbn6Zw7SCD+s8N8Hts4NNMPTTp3EWqIpbMIgRRTAI5norDl5TtIA7lNjwK6oqwP
 /98nbK8tMx8oYOmapRnjoF/IJkWTm2YmHJZo0X+Yz/ALODwAwCyqKPSCEBoemXVxiRBpRUb4G4b
 L7sSGYqYm+RMCdnvNk43Oobqf7PXhCxxJ4ZYHh3CTILH7wyUjgEpGHlnmaz3oI/z/qBbIVYrqrS
 EY+ImzKcC3ORNFc1gcLyyiOAUnCtG40gDU9KJda4VAR3vXDTMw1bZ0uD+p+Whlb/BqZM9waXtwf
 TpKa3gn5L3ToYsmqr/A==
X-Proofpoint-GUID: 7cf3hD1EoWM6wpgjGDE2PJJzh6gk8KDq
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4b232 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XlFCZ7tVMrZGAbOMMLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 7cf3hD1EoWM6wpgjGDE2PJJzh6gk8KDq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfXxDOlp38PbY2a
 1yVUjGPICLCG88fLgIBds1TplONcJS3OmaamkCIvskJgUk65e1YD3HXAKLSCOixXxZs0JYGDHmZ
 lr4hwkTzJG9Z9FV//PIJV1LldHixqmU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060
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

Build the 16 per-opcode int-div-mod tests as a single executable,
test_msa_int_div_mod.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_div_mod.c | 123 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  17 +---
 2 files changed, 124 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_div_mod.c

diff --git a/tests/tcg/mips/test_msa_int_div_mod.c b/tests/tcg/mips/test_msa_int_div_mod.c
new file mode 100644
index 000000000000..764054c2a57f
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_div_mod.c
@@ -0,0 +1,123 @@
+/*
+ * MIPS MSA tests: Int Divide and Modulo instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_div_s_b
+#include "user/ase/msa/int-divide/test_msa_div_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_d
+#include "user/ase/msa/int-divide/test_msa_div_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_h
+#include "user/ase/msa/int-divide/test_msa_div_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_w
+#include "user/ase/msa/int-divide/test_msa_div_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_b
+#include "user/ase/msa/int-divide/test_msa_div_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_d
+#include "user/ase/msa/int-divide/test_msa_div_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_h
+#include "user/ase/msa/int-divide/test_msa_div_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_w
+#include "user/ase/msa/int-divide/test_msa_div_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_b
+#include "user/ase/msa/int-modulo/test_msa_mod_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_d
+#include "user/ase/msa/int-modulo/test_msa_mod_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_h
+#include "user/ase/msa/int-modulo/test_msa_mod_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_w
+#include "user/ase/msa/int-modulo/test_msa_mod_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_b
+#include "user/ase/msa/int-modulo/test_msa_mod_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_d
+#include "user/ase/msa/int-modulo/test_msa_mod_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_h
+#include "user/ase/msa/int-modulo/test_msa_mod_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_w
+#include "user/ase/msa/int-modulo/test_msa_mod_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "div.s.b", test_msa_div_s_b },
+    { "div.s.d", test_msa_div_s_d },
+    { "div.s.h", test_msa_div_s_h },
+    { "div.s.w", test_msa_div_s_w },
+    { "div.u.b", test_msa_div_u_b },
+    { "div.u.d", test_msa_div_u_d },
+    { "div.u.h", test_msa_div_u_h },
+    { "div.u.w", test_msa_div_u_w },
+    { "mod.s.b", test_msa_mod_s_b },
+    { "mod.s.d", test_msa_mod_s_d },
+    { "mod.s.h", test_msa_mod_s_h },
+    { "mod.s.w", test_msa_mod_s_w },
+    { "mod.u.b", test_msa_mod_u_b },
+    { "mod.u.d", test_msa_mod_u_d },
+    { "mod.u.h", test_msa_mod_u_h },
+    { "mod.u.w", test_msa_mod_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Divide and Modulo", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 199b1b934a5e..537de9ea4a2f 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -10,6 +10,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
+  '../mips/test_msa_int_div_mod.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -35,14 +36,6 @@ if 'qemu-mips' in emulators
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
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
   '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
   '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
@@ -89,14 +82,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_d.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-- 
2.55.0


