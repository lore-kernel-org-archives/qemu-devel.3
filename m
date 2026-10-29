Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4B606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksbwDq3T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z5MuAMsr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTr3-0005bH-6X; Thu, 29 Oct 2026 13:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTr1-0005aw-Pu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqz-00012p-VK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3bI1143414
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ixzp4XtDpOUbudE0t2NpnH0GcOhMXu6sNpaxUvwyDec=; b=ksbwDq3TV8p7kIOB
 yeOEyH96ET5RcQSODDj88KMO1JAS3Uqh4gTSnDhrFa4x95+a+vcWQGNviTmqVb23
 rAJyWS9mLMnGQ52I+lD7CWVn32aTnGE8gck2tcMU0xgg95uC0/KZ/rdwQcb5lRuG
 73HVVJHXuEoBVf1peq2xYVKbb+A8JY5uT0Et1B+INTVJ59bqBNiVl+ORD/7OWQTp
 0nv4pCa2lYi3aDcNxWBRtq9lavLnS0jh2N6ER+nZhgtGCY3g+8aOZJXd2okwfex+
 DliUFtcg9qOXlsbZv53rHdBsnYKTOn+Py11HFfB+CsMfm43Ih5ZczObfF9zdg4Qk
 C5im3g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76chfdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:52 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf45388253so1104912137.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294632; x=1793899432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ixzp4XtDpOUbudE0t2NpnH0GcOhMXu6sNpaxUvwyDec=;
 b=Z5MuAMsroDy3tXz/dp2Nw7hHRg7tUGiPkmnr6GYv5tqNzb8bjtIW4BpgVSFLDvZams
 r8N+37PCgssMFKrxHbbZXyYmK/HG9srHK3TyEaUvfya/eslLSoOqCGs7B56gHAoVAOkH
 STRnrNHwsxk0gYkT8gGpQb7HEMgpoyjPJJJ0wvWH3kRJtmd583+blKIM42lBhpL2F/Gc
 3iqM4Hubfpaem5UKqafIuMWC6pFmn/jYgbXi/+t8fjNoyIiyZPRL2/CZZuQQ5viKWoAE
 +ME8YeUwp1l4o1f53YCFTtdTo3Dk+VWYVP3tSnLA5PDqm5oLx0dGP/Jsy8V6+08dvvkN
 gNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294632; x=1793899432;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ixzp4XtDpOUbudE0t2NpnH0GcOhMXu6sNpaxUvwyDec=;
 b=0eVv6rxDixenpPBATJ7Mj8KRpfOGOdo6OMoURUzb+++Qqf2XGTUiY/YZqg1xTJw57Q
 hvOc/5hNx3PF8ZNy4NhWqcw5hx7OdINOdJRvNMqxp/MUONKuZyMhHVLVHBRlVYdIDIyu
 avi5Zjt1Ty0x9CjG3V52jr7eZm8d4CuVkMySMbmW9ULNoOAqYmSQE8gBOXg5xc9IGgOE
 0KY2Ai5lNIoFYokwRvioCNDkIqRqEculuPyxwFgcGUQb8sOO2iu1wT1nE0ZPwkdNcY+7
 /vwdB5OLyEjTc3gHsApwfBAvLE7WbnFs7uUWm8QUsWR4/ZRbnS5sPeU7+jDbDpP3OCSa
 nrkg==
X-Gm-Message-State: AFq9FYJjbbTL/qhqaPrBPl0Okq0Bu0irpBdQ/xn+/Z35wsQFn1oVI4Sv
 Ist5IxMrwsu5LQJRXgXvwX/qxODMIBD97fsltaHuejK93w9bTuAIrVGoR+9likITGtD9Dl2Xnqv
 C6cMxnXJfV4keXIIJdNGSNVeMBYOPY2Ru2kjvrMMsLPI48jL4qs9mMym5WYTnCyjH6iuy
X-Gm-Gg: AYBFou0auFn7wjCPFjqCtf8gXH7dY7XEJSbSPSdUTU//7VgqGxmO2uxtpKbyZmRY/ql
 n9mGf5kJwXLJ44PW766M192Jj9n5+Ls4YC+3CQDTVt5tMx07yhPKsfth0pKAuZCFYvG5/c+CD4N
 GTPd2LD4y35o53aOTtPHcQMCxwi06MWpomrGOZx+sHVTYym+Yy+HhtIX5R1fIVFgthVNwflMAuX
 zzQmj+wiSFDImqnK0ZF5RUR2SI+O1Gf3WzvCI3rEwpEffUI3NgZgDOHO6ElZ9+h0ZsVsVVjBJqR
 aXZmR0dnZrn700QvYywAOY2Ib5yo7t1OsTKBXdTJPDNaa3U6Vc52ssH2bmi5/yxVjhyw9Ud1D0F
 P5J+7drJavdBbN6rBGnmXQCyO0cGCd6SvXgEzpQr0/rkQovgJTgzhdXm7SVQVuZJTaB3108FOFS
 NPkY/1g87gtbJ+j2YUBhDcmbmhVZspKA==
X-Received: by 2002:a05:6102:4b03:b0:7c1:9f20:36ad with SMTP id
 ada2fe7eead31-7d03a1f19femr3474532137.2.1793294631882; 
 Thu, 29 Oct 2026 10:23:51 -0700 (PDT)
X-Received: by 2002:a05:6102:4b03:b0:7c1:9f20:36ad with SMTP id
 ada2fe7eead31-7d03a1f19femr3474518137.2.1793294631382; 
 Thu, 29 Oct 2026 10:23:51 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df97d17sm322659f8f.28.2026.10.29.10.23.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:23:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 04/31] tests/tcg/mips: Group DSP ctrl tests
Date: Thu, 29 Oct 2026 18:22:48 +0100
Message-ID: <20261029172319.25766-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zT1FaNptM5TKmZgq1D8CmYZPLG1_6Bjt
X-Proofpoint-ORIG-GUID: zT1FaNptM5TKmZgq1D8CmYZPLG1_6Bjt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXwFJVeWGaXrlM
 LiDU8bWuyu3i61YOM4jDm/xCntNGyDvHwF4o3Dx/l1xQDqC29YSzQpeVq4miuDjWx80Vi9CL1mr
 zkWEPerrSIDBm0gkiS7FMMrAvcXf90A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX+okAzM1n43YG
 gcrrj3CO0Vgvy8O+RXXNNoH6G38EdqLLubrMFrJ/Zgx6/S5NvZfFnUB4dghuhvPhIWvD+ndH7Vc
 3TWf0ZDlolISqxzCKNF8WgzTjEZkVLAuR+r47/VEx6vAACM700kycWAjBa72LZK01Op/sbJuE0/
 uwJpmvPg+Ia3fCuDjBb+f+OYd8s35dBIeL54RZL7qQaUtqAyrU1OdIzGTwSzLJJzcJm3AbbvT7R
 aFj6RWXTmGeuoQQJBxk6vd9jrvZmmu+gqE6nJxKn/7y/84tnszlPQsolLyEXN0KLqmZEFq8dnpd
 k235dM9A22nHbCpD/T4QhEV91j+7F7opqE0pIvnSiOAcaU5VXIJClh+xJuSpAM25UH1oW11uNDq
 t8oOQFKnLmt3txL5vha+XTQ7z9nw+g==
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae38128 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=r3qF6kzAbVZcg8o22goA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Build the 6 per-opcode ctrl tests as a single executable,
test_dsp_ctrl.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_ctrl.c        | 47 +++++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_bposge32.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_lbux.c     |  1 -
 tests/tcg/mipsel/test_dsp_r1_lhx.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_lwx.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_rddsp.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c    |  1 -
 tests/tcg/mipsel/meson.build            |  7 +---
 8 files changed, 48 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c

diff --git a/tests/tcg/mipsel/test_dsp_ctrl.c b/tests/tcg/mipsel/test_dsp_ctrl.c
new file mode 100644
index 000000000000..a7f21e84a069
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_ctrl.c
@@ -0,0 +1,47 @@
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
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_bposge32);
+    RUN_TEST(test_dsp_r1_lbux);
+    RUN_TEST(test_dsp_r1_lhx);
+    RUN_TEST(test_dsp_r1_lwx);
+    RUN_TEST(test_dsp_r1_rddsp);
+    RUN_TEST(test_dsp_r1_wrdsp);
+
+    DSP_TAP_PLAN();
+
+    return ret;
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


