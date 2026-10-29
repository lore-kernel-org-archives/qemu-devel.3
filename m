Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD61606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iv6F6xMO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGOqyOIL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtR-00085d-Fl; Thu, 29 Oct 2026 13:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsi-0007QY-4v
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsg-0001Rm-33
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXpq3234242
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9PGMwAF0ci1YJDmb2FTLd57bpc2HRmE1pQg1xuBwJc=; b=Iv6F6xMOBZ0dmGc6
 Un6wbXxp/esEpvLkj13Yi/e/z3fJbdk3vIHAwwH4NQA+wHHJv4pjCcrbgwM//23G
 B1sAZ5zV3XVmGDwWbu3A7AsuaKoCjNvSoe3ZEibEsyRlFfwmJzaasHDEuj3fTsoF
 749psEgdYOwJwHggk7BYq+hPQV1iGrmJYdmciHZhey7HKW37HBCrf4ueSnjo7dUx
 jYk97qHeBYvVwuVunudOKSloId4y/Et4pC8Av30X09LhL/Zw0rrUewnIYBJWDQK1
 D0b4Ly9BykZeT3zPAnTmlJMGVcaHqxNJ6q2SGxp8yi7Ypne884KZlzb0U8TmKnsU
 huFlzw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b24g6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so564455685a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294733; x=1793899533; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W9PGMwAF0ci1YJDmb2FTLd57bpc2HRmE1pQg1xuBwJc=;
 b=RGOqyOILhMLwlVY/ZTyZEEzLaI5xSMtfSEsG6GxXDqv5y4VsNCeF67Gb+0CWBUmaJt
 tA/+jUTd84iWixGYpKBx3H6GmNz/11j9cpJ2JqzU262dovVL85s0TmLctMqhFvn8QJ6R
 zLN2ftHtzOmBcAJfmqd2A8wHtqsFlLqMUZTIsqMMypXXzsLQ9V0qmnzh3BHmeldDJdE7
 xHV+Vk2CUUXxxjQwTe7U7zO88xJNE0SidzLfsVb1qkhPXRZZFlCasTgbwcN9pCbRanUs
 cuwmAVSxkaYb/8xnbsyOdbY7U53byYsjYLL742Poyj/LZS5f4WOsLXFWa6qDX+mNdI/c
 lprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294733; x=1793899533;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W9PGMwAF0ci1YJDmb2FTLd57bpc2HRmE1pQg1xuBwJc=;
 b=dpLQ0PSN4MlnElObMJxqulP9afQDxtImaHDiAyZj8noHd879XKsmdKwpFwUxpKrVgA
 gmjFekeMspUZKdTR2fWxbeYrHVB9YDU9GnlczlYd/yx65/BKLeLWK6XPxDnbJlHpSsOG
 6N7VbnTk1Wq87E6b1cVXcvGt+vss8vOtF+CZ631Q01q4gMLyEqTfWLHaQHv4FLwRX1X4
 xRQWlL6rFDlNcKjYFHd53RccvBGHJQFge1s51emW933+sFhZiOORZfQyMdNuWxgHdMFn
 Ay9/vOetHh1EHftnktPBPMTAD6lYEu5gz5JlTUcJPPEnRdMLKqVGVMHqeGQXFg+R55bZ
 EqMA==
X-Gm-Message-State: AFq9FYJpMz++u/6BVskI+Jas5W+TeclRCgfaELddWigXZ93TBG/wkMBJ
 cUKawTqsV5sc8B+nXJotTFwsYSMyC27Wr3XezPa3X58c8AADVJ5b7pv4PlcvPGrxAXY2B0lQ4cW
 MKEPdwuhJIAl576LsmVV70uXioQPoI20HfQkqjtwBbB1eFzEJtxaY9m7v9IHFCAjeN/jV
X-Gm-Gg: AYBFou3ActMNsbJBL0A1XRIbJYGBb5PyRfCAtk+B7gl52Qw7N2DoDCchU7MyMLRMZ3m
 bt/NRmT1g4paqMuPWXrFssIvdssSiRyTLQtzv7KC/Q9ACdES28ewPCjiZ544T43AUQNL8qGJcBl
 a8YlDwFPm+xntt9B+9clpNEehx2m+/3tDhzlLH+uFs59/4scpT7Waa2OwfgbikempTw+rRSJnul
 B5C0/RxykfST2LDDmmqUuixrQZuBk3BFyLUnzV2FBSrVfLdHx7wNJo+PDF8N1AXdMVZW+xWCyEm
 6hYFjQ2fr5W9uZUukfbZDdEEF/yhvqgjfGyf/BjNJNojdhLvAnVe0DHok7vlMujasaJYKV21GA+
 hIz6FrtJ0I0gHSoFswIk3XCiHXX+9/iY2NcMZJqW5UDiPKwfKk4ZTOx9k0hGprPKSWmANM9mzTw
 YmmZLNSh1Rmy/jFvjhyArCtsqZvzhSLw==
X-Received: by 2002:a05:620a:45a2:b0:93f:31f0:6a7f with SMTP id
 af79cd13be357-94408d5db27mr996474185a.69.1793294733073; 
 Thu, 29 Oct 2026 10:25:33 -0700 (PDT)
X-Received: by 2002:a05:620a:45a2:b0:93f:31f0:6a7f with SMTP id
 af79cd13be357-94408d5db27mr996468685a.69.1793294732589; 
 Thu, 29 Oct 2026 10:25:32 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7fdb75e0sm79340665e9.10.2026.10.29.10.25.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 18/31] tests/tcg/mips: Group MSA float-max-min tests
Date: Thu, 29 Oct 2026 18:23:02 +0100
Message-ID: <20261029172319.25766-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7xVgOoBifwL2
 WTcljBMRybYlJ0xZJgEDIDjnPQhcq5G7QPKuLmA2M6UAj97XpEsAVETDa9hzy2CKTOw213Vwp0G
 qhemM0HpxmkdFYTUTAuTEt0+gSATFgM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2XNYnIZ8d/7C
 0XO9EKMGrLGVEZVQjmW9+XECHWeZlH/VrU+noEHtU6LxygbqZstDiFrijiTNSG4ePcIHtMfFdZD
 H6sCAs7cqJEAhvFq6VjjiS1BAufFgu/7NhU8sblg0MN0kx5MTJ6VMEknykyAQs34p8MyvF+A215
 rqHfxHgk2r+k1GQ7mKBoz3SYVYnMEtx82FWBFfCRi4dIqoK04LRgQzl+KdXldXkwRxAk0UpZydy
 15NnwpUkMLxr3xjKntXsSepPGwFwD2qTpCUNyCDHSRDFX1AChEbgUETfJ+MR8CFVJSSv5N592Aj
 a0aXBNygf4rPedsHuES986fjVEhD4rB42NoOdYmTMUGdfnT4P1nbp3OYfxTMja1exFEljpQsMlN
 1OgBp1c5Z4g56bSc/+8wyKS1DyNz2Tf2353fI9Ctbes4IjsGI4H2y+3saSwjS9ZncRayhWIQHdR
 1+d+mgTp1r0WzdkQqfw==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae38190 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=5Dn7miAWBvvkMBm5KWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: auVCE-jMjAixPetJGO3RDy5s1m2MgXHf
X-Proofpoint-ORIG-GUID: auVCE-jMjAixPetJGO3RDy5s1m2MgXHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290068
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

Build the 8 per-opcode float-max-min tests as a single executable,
test_msa_float_max_min.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_float_max_min.c | 79 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build              |  8 ---
 tests/tcg/mips64/meson.build            |  1 +
 tests/tcg/mipsel/meson.build            |  1 +
 4 files changed, 81 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_float_max_min.c

diff --git a/tests/tcg/mips/test_msa_float_max_min.c b/tests/tcg/mips/test_msa_float_max_min.c
new file mode 100644
index 000000000000..77b8954f92c1
--- /dev/null
+++ b/tests/tcg/mips/test_msa_float_max_min.c
@@ -0,0 +1,79 @@
+/*
+ * MIPS MSA tests: Float Min / Max instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_fmax_a_d
+#include "user/ase/msa/float-max-min/test_msa_fmax_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_a_w
+#include "user/ase/msa/float-max-min/test_msa_fmax_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_d
+#include "user/ase/msa/float-max-min/test_msa_fmax_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_w
+#include "user/ase/msa/float-max-min/test_msa_fmax_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_a_d
+#include "user/ase/msa/float-max-min/test_msa_fmin_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_a_w
+#include "user/ase/msa/float-max-min/test_msa_fmin_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_d
+#include "user/ase/msa/float-max-min/test_msa_fmin_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_w
+#include "user/ase/msa/float-max-min/test_msa_fmin_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "fmax.a.d", test_msa_fmax_a_d },
+    { "fmax.a.w", test_msa_fmax_a_w },
+    { "fmax.d", test_msa_fmax_d },
+    { "fmax.w", test_msa_fmax_w },
+    { "fmin.a.d", test_msa_fmin_a_d },
+    { "fmin.a.w", test_msa_fmin_a_w },
+    { "fmin.d", test_msa_fmin_d },
+    { "fmin.w", test_msa_fmin_w },
+};
+
+int main(void)
+{
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n"
+           "1..%u\n",
+           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        int r = msa_tests[i].fn();
+
+        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
+               "Float Max Min", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 21cf734c1763..413879c205c2 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -65,14 +65,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
   '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
   '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index e1963c9b16f5..adc9eda70f3c 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -44,6 +44,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
+  '../mips/test_msa_float_max_min.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0b8a8b77a514..fd4325f817a6 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -45,6 +45,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
+  '../mips/test_msa_float_max_min.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


