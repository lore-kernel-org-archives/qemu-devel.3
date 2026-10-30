Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F99606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RvjVDIIW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8NS910+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoBw-0006Jw-8p; Fri, 30 Oct 2026 11:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBU-0005fj-Hj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBS-0007Yx-P1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERiLf3207515
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ln5a2kmJSKTRp3xk1+kyEyXYJkvlbQ1tjCGZIF1mlFE=; b=RvjVDIIW3e4TaZVl
 9hRaOvlwQaevBTp8x5BKrCWJQh3s1PI4uPIApxAnUFDSbnb8MINIbcndZjdRVw9M
 I/zet77XTerwziWAwNTKWtXnbRKA3GjNajLZHx+XqjILGF8Xa5g+HZ73vhxr5mct
 R5AIqjTKa2wepXK8TeBHPzmsL9NCalEgvPpJv50OayFEGEhebs4CvJ0i+dXi3gt2
 L8uTUGT0iuIFM06AXfv+2QH7VJa8sRYlyGJCsoSYD6K44F8gFDbIoyGG+whxEivQ
 KW9Ox+IkiYm6px2fSJXiAlt7WpuHQYkoVmeNHQimoeEWyG+e1qV6dVeUk0lrnc2p
 8VtYGg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkn7c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:20 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eab2a9a633so803226e0c.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372779; x=1793977579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ln5a2kmJSKTRp3xk1+kyEyXYJkvlbQ1tjCGZIF1mlFE=;
 b=e8NS910+7l5vbkI8rme3uy+RCaQdYscWZIOqYN8mjQlO5QIG/bVvRYONuZ1tLyyt5B
 /cTuB3Lyq81yxb0eHToXEOffun7jU/nf7W4UNl3rqNC5HagbjhFSWhf1HFgZH+E9SRTG
 7JyJI8L7EZb9/ZdSvQ4GlugzmahTOhxtpTTXVxq5FqqXNmJXJJb52T77EmGZBG/J+ehm
 wY1xWGZyktbZitJRFi4jm1xoFUKednWZvfol1NShcU3iY3LB3kI7xAbQSwbcr+26fblb
 CTYsaFKMxOYbq6NSqYQjIzO3Z2r0pNojHtSA6DXiMmhnWWdL6crVNqlQES1dWah4uxaL
 xYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372779; x=1793977579;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ln5a2kmJSKTRp3xk1+kyEyXYJkvlbQ1tjCGZIF1mlFE=;
 b=P4WzUpQkPnlrxcn0rlCggmhnx/koCvvZKmNRuEprvaFFs1D61UEUPO3cwZpTA+GWoo
 ti4Vpez724XtZIIspNOamRtIQ+wZCATJvkgeqMfsa96mL6FPXy+3CxJemdxGwnqrahSt
 9n8ouRLENAl7XfPwGzkkztq7C0GGN0LxoyC3aG64JOcZIYPKKTe8bhr8Iz9p934Qko/N
 RBD6h697BMLfeBV9UqsNekVNzZvkOXUY+Q/Vxa+dXsihDAkkQmm2P8uKzkOAbPfI9s7s
 zMroW2oMy8RMmscd92QvucfniMhEF5qtbij1Ih1gphU4PC5Nrw33Ug8MQu25v6oUKuGM
 kUYw==
X-Gm-Message-State: AFq9FYLeg6u6NoYUWO+K4h6vKS96EUqe2fvQl8jzn9YIZY+KdyfqTyNY
 cI7FO2fpz7EAQleW5btzXP+EmaRdTxIrwTairhxjlAewxEHowW3e7rQjvqx5Bh1NgtDd8X3mcXA
 t1DhWQvl++ca4syyAbxddUssfnKUA2kf/re0TBKs6tr9wasF4ox90zYDUw3nMiB/B5jzi
X-Gm-Gg: AYBFou2wjTa8aCXtXNJsO3N0EMHLMBwfn1+sWNen67xhDelLXBJ5U+PdEnN/BwJNHBP
 TGeWMpVLKiL3GzTpiaQaaA4nbr+VnykMH+n0zcgQ7kDao1LhI/MXbbBTwO3d+/oYCFx8Lu5bLkd
 u0YMDbybqVcIvxrnrGGgUEIaRtFWWfwK+YYWbHPPq2oos1EECCXdGVT9BswYMe05IJydwnG8ChN
 u3zFNjiBXOFip0gR+svH8rBH1WKqUJmYnAM1EWtEGrTnuDaMDfyTTJG3tBMJ6nnjeGRJUM33qyG
 pNCBz8cUO55i97iQwzByaVbXge8EVoQ7p+i28cuwYvEiViObqbElzd67nbBduKGD82gGGlZnVWR
 3/GsFCqZG49MRtx79NTHnbnlNDA1/3L2QmICf7F/Po8muuqLATdyXF7GB4bVbIfG6aGFQSPDlUY
 WpZcxA9ebz+IVcwy+za9toKgclXwSCKQ==
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id
 71dfb90a1353d-5ec6871d3d2mr1553956e0c.4.1793372777853; 
 Fri, 30 Oct 2026 08:06:17 -0700 (PDT)
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id
 71dfb90a1353d-5ec6871d3d2mr1553052e0c.4.1793372771723; 
 Fri, 30 Oct 2026 08:06:11 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80306sm4032021f8f.33.2026.10.30.08.06.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:06:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 29/31] tests/tcg/mips: Group MSA pack tests
Date: Fri, 30 Oct 2026 16:01:59 +0100
Message-ID: <20261030150202.61556-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4b26c cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: fsoyW6EfJp8O9Xj7o95PHMN4CHERLdw5
X-Proofpoint-GUID: fsoyW6EfJp8O9Xj7o95PHMN4CHERLdw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfXyFKesq5EnCRm
 xb9VsJMsba0HXHHuEnJ9xW4bdTT99yFhaHFfthskaIOTpTEfYLGExGRGFzRrB1jiyDHuDL1OduA
 zhUK+8VfqObLUjGSzpjNaJyDXSzXk5ZzKRWgoUmg98jqA0uG6xetXzSCI9RgrcX9PrInv53JKbK
 3LHXQMFI9YhD9qxny1mS4tGsg9n4ofJrZLahEZDWlzi3Xbqirqlvkl2E5RXSXP89HbcEtr191tu
 Njv9iqYifQGgc1oSNi051ApVhXst4F+DEDiXcO7VJM7LOtNClPFUzeJELK2A9OlktUYFUUgpqiV
 MhEoTEY1s4dANtoKLljQC188rupq/nQos8oVV9ogB0pa+/223hinCgBKuedJqrExdzg6akLoluT
 D7V4e5D+Trk0kXoeW5UOTlHKsoJ+d2iL9zLWXZiz3hAKiV0N/DIk1RLHJXbf0uQxxHDUaelphQN
 Sgc2vLCD3bRIT+/cGHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX/MVh1AmJCAdW
 FqSC913rcMDDHeqL7EyOmgsq2a8h3CjmrxmxT2oD+07HKfNKHSeGTuk1GrYB+fov/SjPLxU8i8b
 gCk0z6Mwfs8LetAAYJtRt1D7udnBO/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Build the 12 per-opcode pack tests as a single executable,
test_msa_pack.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_pack.c | 99 ++++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build     | 13 +----
 2 files changed, 100 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_pack.c

diff --git a/tests/tcg/mips/test_msa_pack.c b/tests/tcg/mips/test_msa_pack.c
new file mode 100644
index 000000000000..d9b911336474
--- /dev/null
+++ b/tests/tcg/mips/test_msa_pack.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Pack instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_pckev_b
+#include "user/ase/msa/pack/test_msa_pckev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_d
+#include "user/ase/msa/pack/test_msa_pckev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_h
+#include "user/ase/msa/pack/test_msa_pckev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_w
+#include "user/ase/msa/pack/test_msa_pckev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_b
+#include "user/ase/msa/pack/test_msa_pckod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_d
+#include "user/ase/msa/pack/test_msa_pckod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_h
+#include "user/ase/msa/pack/test_msa_pckod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_w
+#include "user/ase/msa/pack/test_msa_pckod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_b
+#include "user/ase/msa/pack/test_msa_vshf_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_d
+#include "user/ase/msa/pack/test_msa_vshf_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_h
+#include "user/ase/msa/pack/test_msa_vshf_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_w
+#include "user/ase/msa/pack/test_msa_vshf_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "pckev.b", test_msa_pckev_b },
+    { "pckev.d", test_msa_pckev_d },
+    { "pckev.h", test_msa_pckev_h },
+    { "pckev.w", test_msa_pckev_w },
+    { "pckod.b", test_msa_pckod_b },
+    { "pckod.d", test_msa_pckod_d },
+    { "pckod.h", test_msa_pckod_h },
+    { "pckod.w", test_msa_pckod_w },
+    { "vshf.b", test_msa_vshf_b },
+    { "vshf.d", test_msa_vshf_d },
+    { "vshf.h", test_msa_vshf_h },
+    { "vshf.w", test_msa_vshf_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Pack", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index ae2c2fa6aa48..8a0ae3cdaeb8 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -17,6 +17,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
+  '../mips/test_msa_pack.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -42,18 +43,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
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
   '../mips/user/ase/msa/shift/test_msa_sra_d.c',
   '../mips/user/ase/msa/shift/test_msa_srl_b.c',
   '../mips/user/ase/msa/shift/test_msa_srl_d.c',
-- 
2.55.0


