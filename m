Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C58606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eJktbHxY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IeSLxIPb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAs-0003dj-TC; Fri, 30 Oct 2026 11:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9w-0002BU-NV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9t-0007Hh-Gf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERnvQ1953686
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NGE4WrTGJIc4moSGjwi6R1+HFVCc3oj2PkHiPocQhVE=; b=eJktbHxYPPxuqLGV
 wDbREIb+GYkTZxjptU82wYcMp38tIEqBsfAqmCYGj04wANnRIurggpO6fN0xMYr3
 iJuFZl+2vGHCYbleT9uZNs9u+QzfCDNCzq8fzdXKiQwR6tXDuu8JjktSiwmMfMKe
 d28Zpv2ym+jwa37WyJv5Ri1pMjbsL0VdI+UxOCd3P5mnFnxAPq59T519gg/r8Ii5
 yr7NcxT7z5/YK1vLa5gEah5JZXFWhJGcth8eCbdF5FLe7orZ6VxBtXFi5+GZt1ro
 gOuAm2j4E/eYX9t2BnoRXkQ0B4ABmJDVgslEZJji+UAHrzQWU2vauUfzxg0RMuIi
 Vmggnw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pknfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988b86c66e5so1569885241.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372681; x=1793977481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NGE4WrTGJIc4moSGjwi6R1+HFVCc3oj2PkHiPocQhVE=;
 b=IeSLxIPb9Xq8NfjbEu/XDF1QpvsCpOIiHhkBp68yzSJhXTxiAj9gey2D6001OjSw6W
 qwtKjlPZsfXSzPt/pQSEXxX2e5oj6dGaSqNrrJIrwSy4V7SxrQBajoI2A2/xKXdrGiuj
 dak8RlB+StP5HrWl6+3NBALTBJv9Hha7TCd8rC5o9t0OEyhvL8qmrMDLka/DcmH6emKr
 1RqjeBYUCoTbsSEQiNgvmUqhHrQGMT8gWfpNvJDZhe6dp+uMnTpEw8WB6MG522NUs3Xm
 vz0wXuC5s2pkfUM12O3S0VHeAQcsU8+hVICd3VnBo3u1kr2qSyP2l6ZNHtL7Vilmcgbs
 Oq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372681; x=1793977481;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGE4WrTGJIc4moSGjwi6R1+HFVCc3oj2PkHiPocQhVE=;
 b=G7CfpJC0eQMAZdV+rRv9BcXE2s8hhlRnCLKmcQdMHnsJJraXMDY2RWNV1QK64/aZAW
 YrmV6CkEbGYKWKECmtzndIX5h4hjyEq5IcTExFNWZyB5vmEWknDwRmgNXQTC8rcOuNbm
 oEJMOe0nQFuw7g0FwSfIzAq7Myu7Zv9Tx3hKuyHcIpQFD3qSpiM0sFG0USkAvf0Ph95t
 kfNVWbFa9UYttiVdinHkOGjRelJBoO3Hn5n7FYbpfHQf7J/CYXicPelwnV7hZKxPRC0k
 0G6TU2lOzMMFTtxMtTi9nlUHebQyOGGHcaeG3M6MwWzJrAgc11ijACATk/fhEK+ut05g
 FgKA==
X-Gm-Message-State: AFq9FYJub1Hgwxdidi1obLUZJtPYO4AFXkLzoIQ6it5x8jlya1GpULfz
 AFgfFdjZ6QAJv3uXFAZtJ0YXklZjR6hOWrZ5NNnpVxhKnyvWwNqvNIm1lB8ez9BenFUax9QpPIZ
 yitIft+B4zlmLAr+C2pkHaqc67AuW/udkZhMzIrU87SyOj2dXRQrWbdpdajEDYhPD3Ry5
X-Gm-Gg: AYBFou0dfKjY3MscJzekx2HKf5SbFBl0HEXI4j/vWE/CklMJ/XhD8oSP/6bXgqzD+ZO
 Aok2Eda1A0GCXCZSXDqSh9Jn/kB5S8mVTm9zQucOrnh5G1/uc70jyYjx9/XxcIWNIZ+yYtg0uDF
 8D+2zz1cwc/R73rS8wrdWNR0euauOzTfPpMu3wZT+wpNF5zGjs36MRJ6MijBDRKqXKIjrySh6fH
 4goguUUtl6hSJKknVk2SWeaBbzAzxIUM3Ayd7ptD9OhI4tg+u0goilfesxuFAB89/Cy6zWVXjjt
 l8jnrbIYe1jYA4ahzOwz8sLAstoWzSboM3t4NmT9jvKs4E2yMX2QFn+00UqLfN7iciW6MnndOkg
 +fEyZziAmgyabQPIk19QVDcpIG7VUy59DvNWWQJe78LSwlu8s5MkLRlgJoV9IZ/CPZuMlhHPITw
 oQsFHrUIc0PZQHKoWykhjOoCAUKY0T3Q==
X-Received: by 2002:a05:6102:4455:b0:7b9:5abb:eb17 with SMTP id
 ada2fe7eead31-7d053f224b6mr1584970137.3.1793372680358; 
 Fri, 30 Oct 2026 08:04:40 -0700 (PDT)
X-Received: by 2002:a05:6102:4455:b0:7b9:5abb:eb17 with SMTP id
 ada2fe7eead31-7d053f224b6mr1584903137.3.1793372678315; 
 Fri, 30 Oct 2026 08:04:38 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b727c6sm3810042f8f.16.2026.10.30.08.04.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/31] tests/tcg/mips: Group MSA float-max-min tests
Date: Fri, 30 Oct 2026 16:01:48 +0100
Message-ID: <20261030150202.61556-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX8tWfb19MFuGa
 BIYx5NYLgYMPfO2t/Go6sOFJThqn1RwC+fh5jbmx6LYUFgiRbb+I6o1xL8jG14YubvpNZNFFvo5
 cud/NNB6lXtd+7/1MSfmXhIs6Sukd+UDUTgNxe7Px+3HdKPoh3sZwu+WngUOh97n5KH1GBwogaJ
 Fz+V+wGc9kCZdLc5VK3vSoCpVuh7bSaNIUgMkBhypqmtYk65BlNaTMk0ZGVSFP7iikoxDlnwGF/
 vyfbiNCk5d4t398NoS1CEpCfRxN3yDVdnTH4ExkZCVSqAPI5UZ7a4mcpSBPW4m0ke2YZghCksCb
 kJwfyjdRPkgjQAxnmmDbrayGFDrY3z3vRQsnj+//MviOPCBgR4+Uo4TyjKtVHjnMfZ96Ap7/6RY
 PHCNy4Rk0El9Ut31iPAUS0COjcP5dtLbvpOxqu0lq+mf2cRoXKF9RS0K1fX8CM3tpLVh0A2xuJe
 jXIMDvFHNhKg0Xr0t1A==
X-Proofpoint-ORIG-GUID: 81ro2eQAKDO9kyBXlQRIgBeavatFu_xG
X-Proofpoint-GUID: 81ro2eQAKDO9kyBXlQRIgBeavatFu_xG
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4b209 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=oKQZkuFmXZLJHpf79lgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX3pIx2hy6wg7w
 W1u48OnSh7S20XOhRJSHV35bg22PPX70sVygeLw8v60yhmikKg4F/s5WAUhAp5pkiTnIO4Ifhvp
 jVcxyjIHt3kwiSWtb2K0NgKh3Gv4kaI=
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

Build the 8 per-opcode float-max-min tests as a single executable,
test_msa_float_max_min.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_float_max_min.c | 75 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build              |  9 +--
 2 files changed, 76 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_float_max_min.c

diff --git a/tests/tcg/mips/test_msa_float_max_min.c b/tests/tcg/mips/test_msa_float_max_min.c
new file mode 100644
index 000000000000..13f8bc79b0e6
--- /dev/null
+++ b/tests/tcg/mips/test_msa_float_max_min.c
@@ -0,0 +1,75 @@
+/*
+ * MIPS MSA tests: Float Min / Max instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
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
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Float Max Min", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 17e3fe3e55ae..5e14bc3197a5 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -6,6 +6,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
+  '../mips/test_msa_float_max_min.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -73,14 +74,6 @@ tests_mips_msa = [
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
-- 
2.55.0


