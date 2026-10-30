Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7A606A33D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Azrk07eS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gM4mc8WM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqro-0000Xn-Fd; Fri, 30 Oct 2026 13:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqa-0008Ci-5N
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqY-0008Ik-5H
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu8LC373415
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J5zM6rPAVM4954wK0YJT2FXUcIUk7rKVpkzOWfHeu3A=; b=Azrk07eS+2CbrVi9
 TcizPCBVBXE02M0iTy9vMLLfwk72Z1SVXSendNZgfGQGwyRU1AwRhoHky9KLQOQq
 2TjpUoXFUeKoRDnFZW5sQBQI1M+/RPQ/SYFYk+V8jhbN2FFls83cT8qQecJNjogt
 YXhYL+emN+YyXWMv9ZQh6zVYfYF0N1/Biplx9gauY3Qwu5HYMZPZWSqLvf7i06Iy
 0+ePpucr1Tiw4P9DBY3yWvTQGqAbXBSsT3CLuAdGbdrx9K6HdQmLGA7BNyPyMagy
 5hJ31oBa8grt96qLJlWRa4GgU+HcE4MvozQlU2JAsVN/l6syD4Ars7/UkVFJgwdJ
 YvZLFw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmb8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so153477985a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383016; x=1793987816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J5zM6rPAVM4954wK0YJT2FXUcIUk7rKVpkzOWfHeu3A=;
 b=gM4mc8WMSxW5bv2qSsdjObKex0onkLIhXXxfpkkR3Qn+ZxfIbacg64U9JXOltRw218
 xKiEK3HvjCiBxRJO06Y+QGBEiMcDO/PQE2dqR5rNmqr9IRCklh5TzkgEvHC+m+wdv46J
 cvuQusSKUAlGIj3Is0QVBhjiaDn/QqkhiOWYAoz5Kp8I79KKEborQarzRijG08bI0Iml
 lR1c1xkcnYhA1QJCSwltkgCwdYz+48X/BXERu3AYoPzVs56v3PLGjWb150cF141y4Sr8
 /PD/5pKXN5tib0uccsMp0vqG8O2eoRK3NPWqtxzY8TYrD2SAL2Ba9SHl3mqhOVvTXVLl
 huBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383016; x=1793987816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J5zM6rPAVM4954wK0YJT2FXUcIUk7rKVpkzOWfHeu3A=;
 b=zWJFYgrUGyPI8J7XKMC/DBBh+HZADWW2t2ZnjeK4qHqOixB9GqKfJxdaN0zzaUd0+S
 OYgiwTVUXvzIA7ICiwHpqs/49TAIwf9g4GjaZM5tklbwHWM2mwlxNqTv7yket/Dy6JCO
 JLCTvOvHd9/GtHT0IYaLmYg592z+4Vn/3vHs0t66qc0lXjZDDoDtsemZCYJVepLzf3OQ
 swGl9PZu7B/qo6xFGU8FWjCnYf9W25M2tLKWIaWgqFOIHR/3zRhTEAioc9N2LIn9+YH5
 5Vsd/li8JRw12oKyDy+80UBhBEHFrTSp/HntGeTs+PRbY6IgRG5sxcPFuH5Y32c+80RS
 v+zg==
X-Gm-Message-State: AFq9FYK4vRuzVrg6CRMFGE+8iVWGEttLP2b2vng/ynL+oEeubbyPiZDN
 oczp0CsOPxbD1kyr4LtzRaf1u4WnH6Jl+g09WhQLhC6/Y0uhY8E4HgRQJazud8aR6bSSJ/BxDX4
 9/m+aGBWx2t/XlTg8CEjF54b2YijyNRP5BtxKI3YxCbNaps2YEmSTteyKY9Op05r31/TO
X-Gm-Gg: AYBFou1FQIkeXfKGYZnNYXd4gt9TYMyzrBeH8jYH14vm4tQQwL7uXBKLdEHh7Yti2Nw
 x/QRKrrHqBfrNAMedhN+9Hu/ygrSr6ppzV6LlDnD3xPaCMm5PcNJtx839LPjvQywHfIzal5KE+G
 W8YeusAiXPR8xwuq6EEjei/os7lViXm40GVN+IGaBzgwIXByH0BgG7yStUfqYgZaaJMG/xVvGNf
 RWL9hyHsnC/lHnT0fYdx1MPuNXg9+21+D2S/P2BzbumROqhvE1WS6xr0UX3rb7zDGm/eZCioW/r
 aPLuijug1PTQkc8YgkQaKvaNUn5HEkZx77Mt9EEzqlBVfWxtn/xQ7rKrVq89Z7pe6JzITK6ToZ0
 d+C4IT31sz9La+b/Oxo8ljdnsL1chtCSAaCeB5ttk6ewhdu9hl+qzzXa3360MJoUDzNHYOkB/Fr
 ns5ZKixiQ67ZTH9IhIzVyEOEwepCM8TA==
X-Received: by 2002:a05:620a:6014:b0:93b:ebd8:9147 with SMTP id
 af79cd13be357-94421611a7amr528263585a.18.1793383015683; 
 Fri, 30 Oct 2026 10:56:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6014:b0:93b:ebd8:9147 with SMTP id
 af79cd13be357-94421611a7amr528259785a.18.1793383015185; 
 Fri, 30 Oct 2026 10:56:55 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf396dfdbsm78342605e9.1.2026.10.30.10.56.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 21/32] tests/tcg/mips: Group MSA int-average tests
Date: Fri, 30 Oct 2026 18:53:43 +0100
Message-ID: <20261030175357.99684-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX0jM4a6gnJkFZ
 fN3C561GGl+VsfGky7d4A927wUVjES88xI6XsvtRdokmnimJwfS4wHtbWwtHxI5cPVMHWzUcO8m
 A0XVS+Wq7qwmpi+eDqA9pkYyPPfxf8N+56wY0p/hXGQIBruIlAyxD2TQegMkKaXHbLvVbLv80HT
 OuFuhAHaAcRei0W1wPCcN84hffxerz5p1Af4inQjFhFZx+d1RNsY6axmDXvDFkqNTf4s4iXQLpU
 eChWzBtcnhWMRA2tkUHhmAxq5zfe+xgSNaJIhzGJ3PJWsoTAWobMkRkJCBGfOfQMsmT/a9FWZ4q
 Fb84skfepfV7PHzwEaFoMJqRXbCkV3WdcvATOoIAYl5oDVLlfFQ7L3eesBpqcItzTrGaNGlaCB0
 pz57kYjWCFKYlvoimvErozfqnCgC7gzEWCXCx/CAuPnwOcR9AVBtlraTYifeZYE/7E5R+x30VDH
 jtvME4mL5wkkiP8gy4w==
X-Proofpoint-ORIG-GUID: 3ZiGQ1Fa-3z99KUwf32LINREV044M4av
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4da68 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XlFCZ7tVMrZGAbOMMLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXzRlK/kSjypSw
 bSzeunSCUi8+0a22QIxUOJmwQLfj7qoQPtmKMASoGM3AlDHYtpNatzL1YYMlkzEYmm0qswE1Li9
 PpwMafwjQMhuMSExO5/VTrCjv6MWXt8=
X-Proofpoint-GUID: 3ZiGQ1Fa-3z99KUwf32LINREV044M4av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Build the 16 per-opcode int-average tests as a single executable,
test_msa_int_average.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_average.c | 123 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  17 +---
 2 files changed, 124 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_average.c

diff --git a/tests/tcg/mips/test_msa_int_average.c b/tests/tcg/mips/test_msa_int_average.c
new file mode 100644
index 000000000000..f3ff9fd345bc
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_average.c
@@ -0,0 +1,123 @@
+/*
+ * MIPS MSA tests: Int Average instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_ave_s_b
+#include "user/ase/msa/int-average/test_msa_ave_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_d
+#include "user/ase/msa/int-average/test_msa_ave_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_h
+#include "user/ase/msa/int-average/test_msa_ave_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_w
+#include "user/ase/msa/int-average/test_msa_ave_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_b
+#include "user/ase/msa/int-average/test_msa_ave_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_d
+#include "user/ase/msa/int-average/test_msa_ave_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_h
+#include "user/ase/msa/int-average/test_msa_ave_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_w
+#include "user/ase/msa/int-average/test_msa_ave_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_b
+#include "user/ase/msa/int-average/test_msa_aver_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_d
+#include "user/ase/msa/int-average/test_msa_aver_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_h
+#include "user/ase/msa/int-average/test_msa_aver_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_w
+#include "user/ase/msa/int-average/test_msa_aver_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_b
+#include "user/ase/msa/int-average/test_msa_aver_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_d
+#include "user/ase/msa/int-average/test_msa_aver_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_h
+#include "user/ase/msa/int-average/test_msa_aver_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_w
+#include "user/ase/msa/int-average/test_msa_aver_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ave.s.b", test_msa_ave_s_b },
+    { "ave.s.d", test_msa_ave_s_d },
+    { "ave.s.h", test_msa_ave_s_h },
+    { "ave.s.w", test_msa_ave_s_w },
+    { "ave.u.b", test_msa_ave_u_b },
+    { "ave.u.d", test_msa_ave_u_d },
+    { "ave.u.h", test_msa_ave_u_h },
+    { "ave.u.w", test_msa_ave_u_w },
+    { "aver.s.b", test_msa_aver_s_b },
+    { "aver.s.d", test_msa_aver_s_d },
+    { "aver.s.h", test_msa_aver_s_h },
+    { "aver.s.w", test_msa_aver_s_w },
+    { "aver.u.b", test_msa_aver_u_b },
+    { "aver.u.d", test_msa_aver_u_d },
+    { "aver.u.h", test_msa_aver_u_h },
+    { "aver.u.w", test_msa_aver_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Average", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 7ef3d6aafa8a..7da4aece8409 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -8,6 +8,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
+  '../mips/test_msa_int_average.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -192,22 +193,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
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
   '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
-- 
2.55.0


