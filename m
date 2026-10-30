Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1906606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXN0wpcI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bd/DLjN7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqp5-0005rW-3L; Fri, 30 Oct 2026 13:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoM-0005X0-JP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoK-0007ph-Kl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERF7n378152
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 944e6IXe1zC+n4TQQdlRlGpKLAVFF/LXu1eo7WhasrY=; b=cXN0wpcIz7vO2a82
 qSjjRs3JrJ0zo+pYi0SffUe6/Ecblav/qBo79PPqFqb/wIkWi6ovtbxyLzJ41naR
 6C6GY7WZlA0dRHA+qmpg9Omgs7zUdgT/NudgqDSkqQVKflNJ2ZhFi3D0cpjr3YLq
 0NvprsHVXxKCpE6h8XkGuySi0qypRlozJpiG9jrhlcMGwltx9HoO/JjA+gNgxYjh
 rFbrnTj7nAt26UIYwfXvlx/EMIlB0MBvFCxZehMQZNwvnksC3GBbItmguT2eaHfR
 fOV+X/AB7akV/jLYABXs+r9ouCIgF+pj0On2BxgDW9zjPzuxNE0TKnf1U7pMoi09
 KlSrhQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754a1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:39 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso235929241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382878; x=1793987678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=944e6IXe1zC+n4TQQdlRlGpKLAVFF/LXu1eo7WhasrY=;
 b=bd/DLjN70oPwQC9K14J6EnBBSQUNu265ZSBe+Fh+oKCwQ24+CqRNjp7xuXnb9Zx2+f
 rAWzO59D4+IUWMN5pTFlF0ggXCLP6jYvD5CyhJ++FYfRFoSMD+W0OEhpJqVEL1qbsTIK
 E2mkPst3PfjYVHGqlrw+MdAXMC4tPoZvQBbgX7UM+wTAmcTCYwVdSmFnP14d8YY3IPfz
 LW/SUqXctc3ShZIJ6tmlEoXhVaJ5D9UJbXLilO44RYcKEZ4SxH3vcR/lF+eSpPrIgLYH
 Z0aVHUlfD/mZSRqEjU8d+f8zYQp97LeA+QOugW+/Vh5utQUsIYx+CBQIrUrbngmleggq
 r18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382878; x=1793987678;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=944e6IXe1zC+n4TQQdlRlGpKLAVFF/LXu1eo7WhasrY=;
 b=At485RTCNeq+G7nA8NhxsWJCS65OGsK8ao0x7KQXGW1OxG/PZlGwyYdc54OwDudomf
 +1BiuTm5EEcOyPJu0cZ5GLkEuVGm+1lOl1WTEzE9eAUludjWI+DPzGb0YvmnKE+UjwHJ
 dT4ouAb+kW6aOxJi7wfO28IeW+gKsu3k6J7Bn8PLM3PPnVR8nGJHhD9psq6hQpBqF49e
 C4T7ICco+k7q42V9/HNlYlrYAZL1i8Dk+g4wrwV9hUHZBbAPh6DiMY/qxjVKIL51vPUj
 UpeseDNY81/hCwUVw8aOrL8i6xTXK04TaX9GlTxtWxEL0pu1BbFHxOu0konWhEGtlRxJ
 WnMQ==
X-Gm-Message-State: AFq9FYKOZFS58YJkUUVgJgsaQlZmEEEhb0LTQqabC6QRgF280RO3oPbX
 3NDsJosYg18O9xdEOYahGIk67iBjzn3YQ7hHvP5zuFilfMN5xs0AoC2zEyPpBviAwX0FdQtJhci
 unSQjKzisWFMze6gVNf3OyDAxWrwxI+XKRgMLqlbvcRtIBh+WtsFBrBQhklwW3dEQ4Myq
X-Gm-Gg: AYBFou3felwpWUp7LYbApL8tn/UAh21E8XPnqSuAfxrq8SSFjQx5Uep1wwBZYa3yTcN
 dul6bvIFksw7Pl9JbjT76mhZv5BMuzDvjuZLpnDJ6h3GU3taoGcQXv4mAXTwzcowVr9r/6HolNf
 5x3obKdhQAl81QUT8ob5SaSr10JHO7JDgmLcAi5jQZ2GsnqMqFG8nVMeylhgB41T3trptrgaTpC
 3eKF7E85iPpuhrpGE4wY9N3RqDQLRX2lVAoL0WGnt+g46kbqQMV6Hu8n3aYDYwHrEqcGKsQJfoL
 VDJakO+s1EsNm1uuODJ3HE4+j81dnAnvTeqwaKFCN9SgdyMHYGa8e4VlB9YIZ7+0EvhQANOJgCq
 aH406qvVsVB/n129VctIBMRVZFvf1cskSRFZjGa75TT9A3FlYEU2EBB3ChL1TFSXUWwKKFMacn6
 WMd0wFc9KYV8/d8e3nnZHhGCAr8FiwJQ==
X-Received: by 2002:a05:6102:3707:b0:7c2:799c:9031 with SMTP id
 ada2fe7eead31-7d072d11c63mr1470733137.30.1793382878198; 
 Fri, 30 Oct 2026 10:54:38 -0700 (PDT)
X-Received: by 2002:a05:6102:3707:b0:7c2:799c:9031 with SMTP id
 ada2fe7eead31-7d072d11c63mr1470721137.30.1793382877669; 
 Fri, 30 Oct 2026 10:54:37 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm3834906f8f.59.2026.10.30.10.54.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:54:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 05/32] tests/tcg/mips: Group DSP ctrl tests
Date: Fri, 30 Oct 2026 18:53:27 +0100
Message-ID: <20261030175357.99684-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CPU_mCX6W7rt56yesOQ1s02AUZj-_xYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXzPwleKQS2jus
 43SZ2st6XsQapiFDkiji6j5MQP2BX/IevcV8FNXLb6dNIJfDiQsVx7hunnWxaS+E1B2O4R3Kmun
 D36VHYH3oujKyEzIZuDETpVzMNcsaATFEZ/GqRhJUZnRHZ2aB9cqZ8trNXQG5NYVlwmWc85BQM6
 33fyE8JK7HzZ47PY70cv9eCr/9FnuTN1VZjQce32UWGDIsnp1PD7xFdxVt5vyFJfTBablmRdpEz
 5+3M/eiH7gYGsoWcEOcTmwtqRAcGHezFBoP6I2xVo/QdMgbRbHWtGbzF8ImjnEzw1fEGlrMwdYw
 jhKIqf/wx4GZ2SWrw1n6TZOKRyQg63VrDC7dyARJN1DF1Yr+a50yVsKMsIXOk56VqPDF4pkYbKF
 SDMhTODjO5QLl3gYYD49Foe8aj3DozVc7FAeswDLc8019MUqEW2xEpvx9ezw5hWxKHuOSgUcQEz
 1jJuHZfN/sNkYHmztwg==
X-Proofpoint-ORIG-GUID: CPU_mCX6W7rt56yesOQ1s02AUZj-_xYZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6yKz17ym5nb7
 4CcsVciQjPvfoTnf1tEwYu7483flWoGWQWj48YW0TCqohfViigq9suL7+6OLjoJ17FvpHdR4ENV
 vVPUUu8IPATU2oZ/N3v/ZAjl22Ko6Go=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4d9df cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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

Build the 6 per-opcode ctrl tests as a single executable,
test_dsp_ctrl.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_ctrl.c        | 44 +++++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_bposge32.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_lbux.c     |  1 -
 tests/tcg/mipsel/test_dsp_r1_lhx.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_lwx.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_rddsp.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c    |  1 -
 tests/tcg/mipsel/meson.build            |  7 +---
 8 files changed, 45 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c

diff --git a/tests/tcg/mipsel/test_dsp_ctrl.c b/tests/tcg/mipsel/test_dsp_ctrl.c
new file mode 100644
index 000000000000..08186e22f1f1
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_ctrl.c
@@ -0,0 +1,44 @@
+/*
+ * MIPS DSP ASE tests: Indexed Load and DSPControl access instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_bposge32
+#include "test_dsp_r1_bposge32.c"
+#undef main
+
+#define main test_dsp_r1_lbux
+#include "test_dsp_r1_lbux.c"
+#undef main
+
+#define main test_dsp_r1_lhx
+#include "test_dsp_r1_lhx.c"
+#undef main
+
+#define main test_dsp_r1_lwx
+#include "test_dsp_r1_lwx.c"
+#undef main
+
+#define main test_dsp_r1_rddsp
+#include "test_dsp_r1_rddsp.c"
+#undef main
+
+#define main test_dsp_r1_wrdsp
+#include "test_dsp_r1_wrdsp.c"
+#undef main
+
+int main(void)
+{
+    TAP_START();
+    RUN_TEST(test_dsp_r1_bposge32);
+    RUN_TEST(test_dsp_r1_lbux);
+    RUN_TEST(test_dsp_r1_lhx);
+    RUN_TEST(test_dsp_r1_lwx);
+    RUN_TEST(test_dsp_r1_rddsp);
+    RUN_TEST(test_dsp_r1_wrdsp);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_bposge32.c b/tests/tcg/mipsel/test_dsp_r1_bposge32.c
index d25417ea77b2..f39eae531c8f 100644
--- a/tests/tcg/mipsel/test_dsp_r1_bposge32.c
+++ b/tests/tcg/mipsel/test_dsp_r1_bposge32.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_lbux.c b/tests/tcg/mipsel/test_dsp_r1_lbux.c
index 2337abea2acb..3436289b5a65 100644
--- a/tests/tcg/mipsel/test_dsp_r1_lbux.c
+++ b/tests/tcg/mipsel/test_dsp_r1_lbux.c
@@ -1,5 +1,4 @@
 #include <stdio.h>
-#include <assert.h>
 
 int main(void)
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_lhx.c b/tests/tcg/mipsel/test_dsp_r1_lhx.c
index 10be3b385fee..28795dbf701a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_lhx.c
+++ b/tests/tcg/mipsel/test_dsp_r1_lhx.c
@@ -1,5 +1,4 @@
 #include <stdio.h>
-#include <assert.h>
 
 int main(void)
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_lwx.c b/tests/tcg/mipsel/test_dsp_r1_lwx.c
index e6543c9e7eae..ac15edb7cf94 100644
--- a/tests/tcg/mipsel/test_dsp_r1_lwx.c
+++ b/tests/tcg/mipsel/test_dsp_r1_lwx.c
@@ -1,5 +1,4 @@
 #include <stdio.h>
-#include <assert.h>
 
 int main(void)
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_rddsp.c b/tests/tcg/mipsel/test_dsp_r1_rddsp.c
index 2f3028503324..a0e413614d58 100644
--- a/tests/tcg/mipsel/test_dsp_r1_rddsp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_rddsp.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_wrdsp.c b/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
index dc54943a99e8..57869203102e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index e8737308c40d..1c2851f56369 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -7,8 +7,8 @@ tests_dsp = [
   'test_dsp_acc.c',
   'test_dsp_arith.c',
   'test_dsp_cmp.c',
+  'test_dsp_ctrl.c',
   'test_dsp_r1_bitrev.c',
-  'test_dsp_r1_bposge32.c',
   'test_dsp_r1_dpaq_s_w_ph.c',
   'test_dsp_r1_dpaq_sa_l_w.c',
   'test_dsp_r1_dpau_h_qbl.c',
@@ -18,9 +18,6 @@ tests_dsp = [
   'test_dsp_r1_dpsu_h_qbl.c',
   'test_dsp_r1_dpsu_h_qbr.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_lbux.c',
-  'test_dsp_r1_lhx.c',
-  'test_dsp_r1_lwx.c',
   'test_dsp_r1_madd.c',
   'test_dsp_r1_maddu.c',
   'test_dsp_r1_maq_s_w_phl.c',
@@ -51,7 +48,6 @@ tests_dsp = [
   'test_dsp_r1_precrq_qb_ph.c',
   'test_dsp_r1_precrq_rs_ph_w.c',
   'test_dsp_r1_precrqu_s_qb_ph.c',
-  'test_dsp_r1_rddsp.c',
   'test_dsp_r1_repl_ph.c',
   'test_dsp_r1_repl_qb.c',
   'test_dsp_r1_replv_ph.c',
@@ -72,7 +68,6 @@ tests_dsp = [
   'test_dsp_r1_shrav_r_w.c',
   'test_dsp_r1_shrl_qb.c',
   'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r1_wrdsp.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
   'test_dsp_r2_dpa_w_ph.c',
-- 
2.55.0


