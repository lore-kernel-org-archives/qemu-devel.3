Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F08606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SfSybaHO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=goTIzUpb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo83-0007Px-8Q; Fri, 30 Oct 2026 11:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo80-0007Jy-EK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7y-00077n-EW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBq52494580
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z63GwOrdI4x+GXU7UyHKS586C1xC/1OcZnKuijV3FEM=; b=SfSybaHO5VAgAOjR
 MsBaffwMPEFjOuG5f+heHp2kddkq/g5Aa7b5NbfS/QX5897rvbnfnWf7I2oOyCVr
 lMvu2DJlpYWkXxb5/lV87SvTHLDiLC1aD+2cXmtUOZXhS9UuGeJCTrxnLfMy0Qub
 XmybmlMpb+bjNsLIFRXC9vVJN1hv4iHPN4e+P+EIqFkI/aLhQKSyKHEaqOJifcGe
 lzEV/meNxeW41VxlyMd5MceY4JTsCmxhk30Xm9XxtL3BV7UHXAtSgMOeCTRrSO3m
 VFpKK5LxukzRQMsOihn5l43OivK/Jkg1aMReZGGfsZjniaqzHHBfep0kLLTgiHZ9
 Hc9l+A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3p9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eabb3a1bd8so895895e0c.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372564; x=1793977364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z63GwOrdI4x+GXU7UyHKS586C1xC/1OcZnKuijV3FEM=;
 b=goTIzUpbDWk/iczIrBxHTvRH9i3p65ObaQpb1yinwHbA2AWtvxB8dumtbFAfmUNj0M
 HBp8SJrUykWHg7ijUvlOkdlZ0Zjr93Nfo8/ZC7bzTfnbzgDAoqY3ECWWCEbd3+rFDJdE
 WJl6G9JDxtZaOLXD9i4LobEO3UtMGdQi7hLahKswgzkOt4thZLCbagrsqOMT4+5PwU6h
 k2V833wJ38outQ/NPIqcxRAPf+8HzhdIWTxlGxTnlirP6DzdXcdc3rV3zCvxMARfvbUM
 5awVgBXWglwW4L4OkebmaiFJo5SLJGf1ciOVn69yGqqT1pQpH5UbWpExqkYVCkApltgf
 0xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372564; x=1793977364;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z63GwOrdI4x+GXU7UyHKS586C1xC/1OcZnKuijV3FEM=;
 b=IbxufkhiY/dTHTpYo1hWaj3FUZc+Lrjind7gZO+tjnW0evR5VM6TQHRg0+IeuyQTPW
 SMshJJVpZkdRaEGNaI/+O4IFALQl+L+zECTDQJp0nrNo/2OCpvwipaNpQZMuiqc9U64V
 SpgOITcLKFn02XvwbLdf3Iz2WV53ReUbyp2gMjnx0oAXUNW6ZvgQ5/CRkiE6Er64FAbr
 KDad1VSHCBBAznXe3FysPUaJW1DDeJ4gS4HamTrbObjcY4zeIlryBJ+fC4srydj88wE5
 2LqjkYnhTChq+3tzosJR8pNY7b7PsdVIMO82ZG6lnbxaYOpHfzB2l/ST7IEYeYiAXK9L
 5A5Q==
X-Gm-Message-State: AFq9FYIoVx5BERK7/nS2OW1wkhuvfIPjzxlv4tlrlxr/Oqj8PwB+7o4L
 a42tulU9TZd1tMyXuREvHrxS4haAthCA3QlEsDrPPcx9x9QA8vMG5DRJ69Zzc8xnwUYRyojhxCn
 e3Owbq4F5LT6u303SluMyMN+r93uGCHXX2AiNDOKknpvuEOwAg2PRyCSn4XWYFlkMxERv
X-Gm-Gg: AYBFou3/EI7k7Nm/mF1ItkCe1hIfUaRGIjpb+NVV846g6wNBesuWX92LwXg0vdutZgx
 wUvH3BmWgPACY1NTGKqdxonJcJuXth483MgX3WoCcLFiYK0CdB2meKP7rEHnxz3gmocwGgsNV8p
 bELFs9iQOLeibUmRZndEplPcUhn4OtLMDkekEOLbqzYSn1BtEmw8xMbRo+esaOctaN29S2mbZX2
 QF4fkBQaT2T1vpQdwENaFQFjXQQ6CBDGpUkv6L3MhJK6PQ+aUUxNbyd3l33TGnF+kE+EIKyPNeQ
 MCjniYXnB2i6879VLQ3r+1hZzdNiDzS8KWX0PDy3+/ej9txv+h/Z5bltsIcWVKdug9Dt0ZoSV13
 qv04esWMbG5DGG/saqeNOr3Cd8tQVYQdHuUIWdvbKX//WARjjvQXp6chKszudfD4dMem3mfBrLO
 SaNjtaaBmRZ7/HeKAKUgw4OjFZ+GtiMQ==
X-Received: by 2002:a05:6122:e46c:b0:5e9:6d96:a598 with SMTP id
 71dfb90a1353d-5ec68953084mr1447294e0c.6.1793372563829; 
 Fri, 30 Oct 2026 08:02:43 -0700 (PDT)
X-Received: by 2002:a05:6122:e46c:b0:5e9:6d96:a598 with SMTP id
 71dfb90a1353d-5ec68953084mr1447205e0c.6.1793372562770; 
 Fri, 30 Oct 2026 08:02:42 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9c4f4sm3655393f8f.48.2026.10.30.08.02.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/31] tests/tcg/mips: Group DSP ctrl tests
Date: Fri, 30 Oct 2026 16:01:34 +0100
Message-ID: <20261030150202.61556-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX0JlyNNMQu76T
 ez1LmevNRumQR0hOPO7oePly68cGTT+AoHNbH0+T3eWtLP/f3Bzqsbz7u9X181LJzv5j2i8KR68
 tuysvj2o5FsgZHsV8Y7sYwerGpEFdMXW3bewormnjU3PcXTUF5v33VDxndDM0ATydKWQEJ1kK74
 w6ofVVsjg82aKPv7pStyBpYYcUKoLAs4UzgCptLy57Rriuxft/8/oV9wxOa0KDweErl/+MqB32L
 aV5pqzLjAgcakM+WZ9qbnMTvcFLVkhvxLRCul17q7qlfVE4nzBgAuhb6ds+uFTpXeDR3FeBo85B
 eqoqUKO68ItgpOx0/GjgjP2yDRAf+uefLRP/vccBjCossXT5FnRWk2ASNnvii7sqMTK1EWEOmuo
 wnQwaeluDOWPoTpfB9x0IP997ET2hbB89wCObssVZPoMRZ58eZwberwK0n8sweL6fC0TDBL2+b2
 Z2JN94nW/hU45j05QQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX2AqwhR3juv7K
 m01Zo6ZFY5vmfBmrkw5eG3g7o8WBAWUzvfWEBU4UImqYABkVVD6Yd7oYT7nfFi7R1khGCZky+aT
 AIOXyScPnVc4Avf7Y0Hn6imjYbAhWVU=
X-Proofpoint-ORIG-GUID: YSqANjIUBlLLAA7C3f8c3MdIL7tkCb0g
X-Proofpoint-GUID: YSqANjIUBlLLAA7C3f8c3MdIL7tkCb0g
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4b195 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Build the 6 per-opcode ctrl tests as a single executable,
test_dsp_ctrl.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_ctrl.c        | 43 +++++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_bposge32.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_lbux.c     |  1 -
 tests/tcg/mipsel/test_dsp_r1_lhx.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_lwx.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_rddsp.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c    |  1 -
 tests/tcg/mipsel/meson.build            |  7 +---
 8 files changed, 44 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c

diff --git a/tests/tcg/mipsel/test_dsp_ctrl.c b/tests/tcg/mipsel/test_dsp_ctrl.c
new file mode 100644
index 000000000000..4f7c648d5472
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_ctrl.c
@@ -0,0 +1,43 @@
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


