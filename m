Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0520606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIm1qNk4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Row+M44P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAx-0004Cy-OU; Fri, 30 Oct 2026 11:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAf-0002ax-3f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAd-0007Vv-6z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER5iR2596635
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zhd+SswohxoTjYD3Gra5w9RZuzmiiU319kwx5MH/SQM=; b=SIm1qNk4cBkGdcTG
 f8N3zh51sJI6f8R8ZZsf7f1kWN6fwUXzDYcS36o4uqXWhqwJpBJN852GiBjX4Dox
 m9iR8l0YtKvRBJHi6yikN9/SHKcBs+VYwo7vXUiMmPVA/cPDH+cfGNvuqiAlWs2u
 RHqVERneZ3crA75debbQGX4QaplsqSlXAbo+4SbziTKlNIGbCDFR4On/PWZ20D0y
 J749Uh/rQwo7Dmer+siFF0L8umIrLZxXiTFyMFCYBE/Lp3VzNmvr6w234aBTIsWY
 GwYVBg6RqRGHeXvfpi3F8a4daHZraHOuUKC1Kh7oqmffu+XeSu0Dbsr3l7AdlnCZ
 v0h2qg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pbnfx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc0418036bso58188137.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372728; x=1793977528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zhd+SswohxoTjYD3Gra5w9RZuzmiiU319kwx5MH/SQM=;
 b=Row+M44PQaEDx+ZQunAHM1hrSAlwjNVxwpQkpo2Yi/pWw8sRIy/tQZGk/HX9LNQIDT
 qGlYxRxr/UBXC8i+JGqiCo0nvI+Qqt3avm7DID3kB/d7lx2ycLdePE/D3WB/ugX4Ez+b
 IE1V6Q261xS9UWGOx4awZFFGpDdmpjvDgNGo61VNf5rdWOb8X5tKCES0zgglDQoqlPIG
 T9UjoE9yf2IW8e99fbpZ9i1rakMGbWc4K2R9yp/slO8mbJ9IcIvjeVLwZ3IF+RrNbFBo
 Vh6YVpddhBN9JGtuvqu2OrcAfva4bVY4IBOKPh8XjzpLAn/vgN9PNDynglSwie6SUtNj
 9crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372728; x=1793977528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zhd+SswohxoTjYD3Gra5w9RZuzmiiU319kwx5MH/SQM=;
 b=a5wSSCW/W2zwVNUV81KwqsRL+cflxUqFlxpHWCUv0g3CwKbM7N/0uXXByy0/yg1cbX
 OktVSKFbJjsIFa0xKtNuXZbR+14H6f0jdhHfB4ASZhOVBrWoLtGgzkIEHiiHGFuKK2Br
 zyl2hSNV+jLKQOmHV6PAlRCj7E9Nqg01Fo3zxCTZ027g3yQy96tOPQR3e+6Nk4kPmLv1
 AxTgdoPX4bpOdMtyDfkbCHChTF52Fp0Pdv1rLPgvIDA6YyapQwm7/iTXK0R90LLJJ7PG
 utxDLRPdzzraqEG03wqXuMEWisSXujAOzH9wEsBJKpEolI5cFtK7zT9kb/niw0u8Qc1H
 cvAQ==
X-Gm-Message-State: AFq9FYJs0u31qdEkkPf6CAU4aqMKA9XI8yaWD8IdhJai2ip2gBJYmR0D
 CTCqAnD92TsGa9ZufijQrZeFjEFlb/vrUQwlrWWwKHEQjPtJXCulb2mFfmuZM7ySyRLzf8nDnR1
 XE7p7vFmRo0G/Tl3HwPctmF+6rDbs93mTlgIS12pP7+qG7R19Nd+6NLpOjQQ112jk/ZF0
X-Gm-Gg: AYBFou36T7PPUiWpBhgPSkYwAuVJtFeOYHaaiZTNy5+Pjt3HdtKgjyy2/6e80CQryRN
 B+hi+PsfH7Ud2HMCChbhh+YF1OCZxc8kz760zceh3mgLa9DWiur7QsoFXeJ3Ri7mUcyJzejpPEb
 vNlswuecMttk+eM1IjrEtpSxyscCBXmihWADcjwsmSuUlatNW2PQPLAa8BEIsVd2litMLUUMUF7
 +K8uD4rkMB6Jo34ZMRXXuzdwczGBbsQVSWbvfgboAv4gFzDDgft6YyndxYtNOn7+iM+E3q5N1d5
 CNunqEP5W51/v0xjsW4uzsUMarccCGWqMs4baRYCbfcvOmgc9dgpsw1Zsr9GFt8u2O7twAmC4Lw
 KOluLFbKT5lYnnaNsvGT+nafAEqYhDHXMA5MkyvuUibbqAqOuu0mS54c5s5Fe0BniRbB8WbCTHd
 ahatpSt6yYJxNt5BKoITBnAaQJTvAA5w==
X-Received: by 2002:a05:6102:c50:b0:7cc:198d:e2f4 with SMTP id
 ada2fe7eead31-7d072233015mr1170575137.3.1793372726316; 
 Fri, 30 Oct 2026 08:05:26 -0700 (PDT)
X-Received: by 2002:a05:6102:c50:b0:7cc:198d:e2f4 with SMTP id
 ada2fe7eead31-7d072233015mr1170448137.3.1793372724944; 
 Fri, 30 Oct 2026 08:05:24 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm140365805e9.0.2026.10.30.08.05.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/31] tests/tcg/mips: Group MSA int-dot-product tests
Date: Fri, 30 Oct 2026 16:01:53 +0100
Message-ID: <20261030150202.61556-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX970R90OyBwqk
 9MZlGwtAVOe6cw87o961wcOQcu0hUTWW2F0ClIf5sEco92y2JeATwNsFJ1MCDLdmVCl26cE2Oqf
 dpI2A4Ydh2zm5zWFSPcdse+CbTyJ0926+BTXacSu8R+CQ2XHazC4xL1Q4Oh9s/smdvYha8IMjEV
 Qi4aXmi8t8B1/9nBQZp5SKhrg+zaC3ebpml8HLObr9mVco6Ae2h7KrycqgCBmZw756d5f0VwiZ/
 3BrZSCzb1Vfa7pdK/l69t9C2Y7aspAHfiMKlengHwRFqqHMRpO1tH8rDN090tatgbsVrmItuMtk
 IAA7+9bH3zb9ITqJIxBftnBDC1swmSnwig6N1z0AKQos9cIUe0+Jjc8PyizlErvNoKn8t9DvOLC
 Mxek9MUndU/X2MmzrKWCF8ACRKZRzlZVoO4SsI4rh7YJZCyhunzvDHirbSfrW/9PpbVMW0ganko
 gdTXbC858wyTZEeOFGw==
X-Proofpoint-GUID: pU4VYs0sRQ8e9WpMvPCswl6vyoeCiLo1
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4b238 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VhQGtWI-d0xSCWyjZuUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: pU4VYs0sRQ8e9WpMvPCswl6vyoeCiLo1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfXyHHiIybFKCP/
 FA98gJtBrhM+w7+ADFhQ3mariGLvODopu4KN9mMTe3SkxhLPp3nhx15meqt8YpjYiMf5us0QCUZ
 wQX7jtpa9xehI/m5B7TgyFovBCWp/+U=
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

Build the 18 per-opcode int-dot-product tests as a single executable,
test_msa_int_dot_product.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_dot_product.c | 135 ++++++++++++++++++++++
 tests/tcg/mips/meson.build                |  19 +--
 2 files changed, 136 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_dot_product.c

diff --git a/tests/tcg/mips/test_msa_int_dot_product.c b/tests/tcg/mips/test_msa_int_dot_product.c
new file mode 100644
index 000000000000..fcbd414741b9
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_dot_product.c
@@ -0,0 +1,135 @@
+/*
+ * MIPS MSA tests: Int Dot Product instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_dotp_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "dotp.s.d", test_msa_dotp_s_d },
+    { "dotp.s.h", test_msa_dotp_s_h },
+    { "dotp.s.w", test_msa_dotp_s_w },
+    { "dotp.u.d", test_msa_dotp_u_d },
+    { "dotp.u.h", test_msa_dotp_u_h },
+    { "dotp.u.w", test_msa_dotp_u_w },
+    { "dpadd.s.d", test_msa_dpadd_s_d },
+    { "dpadd.s.h", test_msa_dpadd_s_h },
+    { "dpadd.s.w", test_msa_dpadd_s_w },
+    { "dpadd.u.d", test_msa_dpadd_u_d },
+    { "dpadd.u.h", test_msa_dpadd_u_h },
+    { "dpadd.u.w", test_msa_dpadd_u_w },
+    { "dpsub.s.d", test_msa_dpsub_s_d },
+    { "dpsub.s.h", test_msa_dpsub_s_h },
+    { "dpsub.s.w", test_msa_dpsub_s_w },
+    { "dpsub.u.d", test_msa_dpsub_u_d },
+    { "dpsub.u.h", test_msa_dpsub_u_h },
+    { "dpsub.u.w", test_msa_dpsub_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Dot Product", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 537de9ea4a2f..2d2dc60789b9 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -11,6 +11,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
+  '../mips/test_msa_int_dot_product.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -159,22 +160,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
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
 ]
-- 
2.55.0


