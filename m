Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA04606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N+VNiAao;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HFghQJSP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Dh-00074E-Gt; Wed, 28 Oct 2026 15:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Db-00073s-3U
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9DX-0005nJ-Ls
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPdTV1580033
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bTWs9d5IYy1TcCTJ3r2dFeJytgwKuWm8MOe/W2OCq6c=; b=N+VNiAaogIdh2JJy
 0arKd3xYbB9Lzi6rw/nbyL4N378UzHlelTjxtVUxQ0tF5yIGB5QQVRdVb/fp+jaK
 xyjwzTjxBcAOq8ZwKkU2wBaLVSV1d1Rkhx1Ov9fk+L8jj2hNFN9nyGZezT9V/YgY
 4QKakE4U/robvs1PCvXnwrvKDqEgEJlQG7oKVdY4c9TWlyXvfTeExW/WdqUwaIe/
 1LGkH0hjavoraIi8tE7WNkSYbJjICxEWfC1Fhk1MxCW8W50TCsnhHbFDwFNdPztw
 WMnr6mnm+clmtpHXfo99QmbwSK50gxTohHeM+mvqbBPwOBOalUTEIDOR4E/oL4qT
 IFovHA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8ddv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91785bd637bso22624396d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215306; x=1793820106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bTWs9d5IYy1TcCTJ3r2dFeJytgwKuWm8MOe/W2OCq6c=;
 b=HFghQJSPBch1e6Q6h7rj2YS8wexck2Vv9/uiQj54T0j8E8qeuZL8Zq5v1Ra07AiTNp
 UBIc+nToccP3/ICq3rNQ8xWcpQlSyLXW8bNx4GFbtQoSDEzacJzsGWKmSUCjq962u7Wk
 Zh4Aki5peuHYfnVmbAx1WI4GhpqeT/WLbnpHWcMPw81fYw3qtvWbbpD9pUcBEPd1Dg42
 8UkAW5DcAAl0vAmdJGy/HtIvAhLu+BX8ZCe0UC6E2XyfWmD6dvMM2R3ZKVPyZ9fbxFxa
 m7O4gl1Tt9NorQEHK7xWMF0x+nJeCqrcnVuBWB8Ai8pZ2+t9zVKTSUOqItBRDUo6LcbL
 tWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215306; x=1793820106;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bTWs9d5IYy1TcCTJ3r2dFeJytgwKuWm8MOe/W2OCq6c=;
 b=njIHQBL4/C9UDiRzItMjndatyx/nikLc8Pk9yIgtqQ5b5ccQ56Vw6jGZY52oNss4e8
 i684TNmU3gC5BUVyMW5d+trD8xdE6+bGcA8RHQtpPWf8x5z5BVr7DjRSgOUERpWRWGTm
 H8itnPP20yDBcIqhu9G9jewSGevQmP37ZnbqDxWIiMtDr+sk+wEaSZzFQ8oDPo0Rm9wK
 HjwlIKEYvykw2JyVMqrx2ib8Dmj4gPk3w+0Nfm1ciS+/gxBVlBJsul2m37YVNyVdVUWg
 9dmk62vqgy5PIkkNic9qJPanRE+PLt3RkGuqkmW9XXsKAEgvPvTpMGPpxCrlq4eVSAiA
 ef8g==
X-Gm-Message-State: AFq9FYLjU6S4jtqYFzngujhqk4oQvG0Fp/0duqqtbOUyI33j/iNYrOPZ
 tJe/grrTL0+HFH3Vb8Ijb/CKztGN0SsaQ611sMLiNo2awKXt58PZ+Lye+phbipV2DdIbFjn9Csp
 6T5t9cin0u0cj6xfJVAHc3d0IBMDq1DQp0gSdR4TdkAfAIF22lgn1sOTfGfelrSFgo+NT
X-Gm-Gg: AYBFou1b3GDmGPNQuWEnewpKUTQ1sxpPglpnajOVu7hbtAQPvP2FP7B86J43KtgvKYP
 19ACWFZ9JFKVsHKkSzMVs9S6EKwRx/B7O9veHBSBAk7oO0AzSwfdYwi3Q+btwBHs/nBbTA6X+oL
 RnCSk749b0ZPu42Sw2ZDmnUADR1VWsYc4Sio0PurFJ8DDCMeorCmcVzWWpExOkeXarwJHazQsso
 MZnzFrsphn3zACUSphP1jU2SOdZhDU6wgUpn5fCPmD3btWPcczfFZs5zOjLauXgWfCp2zkujdr4
 GT6UcgfMd6UOJtt7pS7a6U2PaUjnac3uSSsTKksmdCCy/lFxVmyfqmZ9qbhoAqifS9c3v7M4ZRd
 ZCGbIkE6ZjJu529VnKBAzbVZm2eo8dtQeV9xGSFDYNFKGkrGupuKIwbl9fVvQbJL5wWxBh6b1YR
 0kH9OFtgVkXOg7gSn623/7XLrqW6NVcg==
X-Received: by 2002:a05:620a:460f:b0:93e:53fd:4139 with SMTP id
 af79cd13be357-944089436a6mr520342085a.9.1793215305529; 
 Wed, 28 Oct 2026 12:21:45 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93e:53fd:4139 with SMTP id
 af79cd13be357-944089436a6mr520336585a.9.1793215304828; 
 Wed, 28 Oct 2026 12:21:44 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfd8dsm28499639f8f.56.2026.10.28.12.21.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:21:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/4] tests/tcg/mips: Group DSP tests
Date: Wed, 28 Oct 2026 20:21:21 +0100
Message-ID: <20261028192124.30941-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192124.30941-1-philmd@oss.qualcomm.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae24b4a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=xMH7j5H72Cn68J5e2XYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: zgfk2a1wMeRQQOeLC1HEBXfpxSxTwhVu
X-Proofpoint-GUID: zgfk2a1wMeRQQOeLC1HEBXfpxSxTwhVu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXwDJEeVuwYlhl
 zmjMCBxf+qbHMTX+sRDlPIadtBRuo4Ht3B8mCFjc5WKI92KHXaJ2PR0M+QlSuLv+eRR2D/QSgzS
 JiUWLgrdKxHG2C26oRoaeUe0JpnDMSY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXwjgJjLIoWc1E
 PfCe1tsk+muqlFPF38jbv2U4xxIJ/uPuZZcRJrh/nWC+ABeX4cCiH0RKy8x6jZzU5vDXxf7JfQ2
 1GVn/6NcLigeYePsqgQzYguN9zV1l8YuftrIu54VEywEaWfe44MU0t8JvXEbzqQutNSTi+TqLbz
 9l0esFk+RtYSJTxQfHixD7niUVxpweLmqzIWmsawcOBOkBHDXnSApkRar1maV8eL9glD+t6n+w3
 fWm6ztEMfTk6pigr7OlMZL6ieSgrQZj3bhvWHK96FJ9J5F4AKE31eAWVXnDdreCpOY02RBN7nMu
 9IL7wsnsb35GR3tbN+vZse1QQs/6/rDYyfno1AG78gx2+stJ9Sn33gueIrbiNLRqP8q0f6fY43R
 6iTwzt2VXspkzNYgEz0Z2BJ45/ku7SFUPeM3dHifsbjUvVW22kfXxTMNxM2oTdVuMiVnjz0oiI2
 H8TTDNQz4Ul5J9lElFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280077
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

Although meson parallelize build, building the 159 tests is overkill.
Keep the per-opcode files unchanged, but add 8 new files for each
group of instructions:

 - arith: add, subtract, absq, modsub, raddu
 - cmp: cmp, cmpu, cmpgu, cmpgdu, pick
 - dot: dpa/dps, maq, madd/msub, mult, mulsa
 - mul: muleq, muleu, mulq, mul
 - acc: ext*, shilo, mthlip, mfhi/mflo/mthi/mtlo
 - shift: shll, shra, shrl and their variants
 - pack: prece*, precr*, packrl, repl, append/prepend/balign, bitrev, insv
 - ctrl: lbux/lhx/lwx, bposge32, rddsp/wrdsp

The tests still call assert() so the first failure aborts the whole
group but we can still identify the opcode in the assert message.

Drop the unuseful hello-world file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_acc.c     | 105 +++++++++++++++++
 tests/tcg/mipsel/test_dsp_arith.c   | 175 ++++++++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_cmp.c     |  80 +++++++++++++
 tests/tcg/mipsel/test_dsp_ctrl.c    |  40 +++++++
 tests/tcg/mipsel/test_dsp_dot.c     | 150 ++++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_mul.c     |  60 ++++++++++
 tests/tcg/mipsel/test_dsp_pack.c    | 145 +++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_main.c |   6 -
 tests/tcg/mipsel/test_dsp_shift.c   | 120 +++++++++++++++++++
 tests/tcg/mipsel/meson.build        | 168 ++------------------------
 10 files changed, 883 insertions(+), 166 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_acc.c
 create mode 100644 tests/tcg/mipsel/test_dsp_arith.c
 create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c
 create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c
 create mode 100644 tests/tcg/mipsel/test_dsp_dot.c
 create mode 100644 tests/tcg/mipsel/test_dsp_mul.c
 create mode 100644 tests/tcg/mipsel/test_dsp_pack.c
 delete mode 100644 tests/tcg/mipsel/test_dsp_r1_main.c
 create mode 100644 tests/tcg/mipsel/test_dsp_shift.c

diff --git a/tests/tcg/mipsel/test_dsp_acc.c b/tests/tcg/mipsel/test_dsp_acc.c
new file mode 100644
index 000000000000..57710072d4bb
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_acc.c
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: accumulator access and extract */
+
+#define main test_dsp_r1_extp
+#include "test_dsp_r1_extp.c"
+#undef main
+
+#define main test_dsp_r1_extpdp
+#include "test_dsp_r1_extpdp.c"
+#undef main
+
+#define main test_dsp_r1_extpdpv
+#include "test_dsp_r1_extpdpv.c"
+#undef main
+
+#define main test_dsp_r1_extpv
+#include "test_dsp_r1_extpv.c"
+#undef main
+
+#define main test_dsp_r1_extr_r_w
+#include "test_dsp_r1_extr_r_w.c"
+#undef main
+
+#define main test_dsp_r1_extr_rs_w
+#include "test_dsp_r1_extr_rs_w.c"
+#undef main
+
+#define main test_dsp_r1_extr_s_h
+#include "test_dsp_r1_extr_s_h.c"
+#undef main
+
+#define main test_dsp_r1_extr_w
+#include "test_dsp_r1_extr_w.c"
+#undef main
+
+#define main test_dsp_r1_extrv_r_w
+#include "test_dsp_r1_extrv_r_w.c"
+#undef main
+
+#define main test_dsp_r1_extrv_rs_w
+#include "test_dsp_r1_extrv_rs_w.c"
+#undef main
+
+#define main test_dsp_r1_extrv_s_h
+#include "test_dsp_r1_extrv_s_h.c"
+#undef main
+
+#define main test_dsp_r1_extrv_w
+#include "test_dsp_r1_extrv_w.c"
+#undef main
+
+#define main test_dsp_r1_mfhi
+#include "test_dsp_r1_mfhi.c"
+#undef main
+
+#define main test_dsp_r1_mflo
+#include "test_dsp_r1_mflo.c"
+#undef main
+
+#define main test_dsp_r1_mthi
+#include "test_dsp_r1_mthi.c"
+#undef main
+
+#define main test_dsp_r1_mthlip
+#include "test_dsp_r1_mthlip.c"
+#undef main
+
+#define main test_dsp_r1_mtlo
+#include "test_dsp_r1_mtlo.c"
+#undef main
+
+#define main test_dsp_r1_shilo
+#include "test_dsp_r1_shilo.c"
+#undef main
+
+#define main test_dsp_r1_shilov
+#include "test_dsp_r1_shilov.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_extp();
+    ret |= test_dsp_r1_extpdp();
+    ret |= test_dsp_r1_extpdpv();
+    ret |= test_dsp_r1_extpv();
+    ret |= test_dsp_r1_extr_r_w();
+    ret |= test_dsp_r1_extr_rs_w();
+    ret |= test_dsp_r1_extr_s_h();
+    ret |= test_dsp_r1_extr_w();
+    ret |= test_dsp_r1_extrv_r_w();
+    ret |= test_dsp_r1_extrv_rs_w();
+    ret |= test_dsp_r1_extrv_s_h();
+    ret |= test_dsp_r1_extrv_w();
+    ret |= test_dsp_r1_mfhi();
+    ret |= test_dsp_r1_mflo();
+    ret |= test_dsp_r1_mthi();
+    ret |= test_dsp_r1_mthlip();
+    ret |= test_dsp_r1_mtlo();
+    ret |= test_dsp_r1_shilo();
+    ret |= test_dsp_r1_shilov();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_arith.c b/tests/tcg/mipsel/test_dsp_arith.c
new file mode 100644
index 000000000000..37a47cd036c5
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_arith.c
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: add, subtract and absolute value */
+
+#define main test_dsp_r1_absq_s_ph
+#include "test_dsp_r1_absq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_absq_s_w
+#include "test_dsp_r1_absq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_addq_ph
+#include "test_dsp_r1_addq_ph.c"
+#undef main
+
+#define main test_dsp_r1_addq_s_ph
+#include "test_dsp_r1_addq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_addq_s_w
+#include "test_dsp_r1_addq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_addsc
+#include "test_dsp_r1_addsc.c"
+#undef main
+
+#define main test_dsp_r1_addu_qb
+#include "test_dsp_r1_addu_qb.c"
+#undef main
+
+#define main test_dsp_r1_addu_s_qb
+#include "test_dsp_r1_addu_s_qb.c"
+#undef main
+
+#define main test_dsp_r1_addwc
+#include "test_dsp_r1_addwc.c"
+#undef main
+
+#define main test_dsp_r1_modsub
+#include "test_dsp_r1_modsub.c"
+#undef main
+
+#define main test_dsp_r1_raddu_w_qb
+#include "test_dsp_r1_raddu_w_qb.c"
+#undef main
+
+#define main test_dsp_r1_subq_ph
+#include "test_dsp_r1_subq_ph.c"
+#undef main
+
+#define main test_dsp_r1_subq_s_ph
+#include "test_dsp_r1_subq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_subq_s_w
+#include "test_dsp_r1_subq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_subu_qb
+#include "test_dsp_r1_subu_qb.c"
+#undef main
+
+#define main test_dsp_r1_subu_s_qb
+#include "test_dsp_r1_subu_s_qb.c"
+#undef main
+
+#define main test_dsp_r2_absq_s_qb
+#include "test_dsp_r2_absq_s_qb.c"
+#undef main
+
+#define main test_dsp_r2_addqh_ph
+#include "test_dsp_r2_addqh_ph.c"
+#undef main
+
+#define main test_dsp_r2_addqh_r_ph
+#include "test_dsp_r2_addqh_r_ph.c"
+#undef main
+
+#define main test_dsp_r2_addqh_r_w
+#include "test_dsp_r2_addqh_r_w.c"
+#undef main
+
+#define main test_dsp_r2_addqh_w
+#include "test_dsp_r2_addqh_w.c"
+#undef main
+
+#define main test_dsp_r2_addu_ph
+#include "test_dsp_r2_addu_ph.c"
+#undef main
+
+#define main test_dsp_r2_addu_s_ph
+#include "test_dsp_r2_addu_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_adduh_qb
+#include "test_dsp_r2_adduh_qb.c"
+#undef main
+
+#define main test_dsp_r2_adduh_r_qb
+#include "test_dsp_r2_adduh_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_subqh_ph
+#include "test_dsp_r2_subqh_ph.c"
+#undef main
+
+#define main test_dsp_r2_subqh_r_ph
+#include "test_dsp_r2_subqh_r_ph.c"
+#undef main
+
+#define main test_dsp_r2_subqh_r_w
+#include "test_dsp_r2_subqh_r_w.c"
+#undef main
+
+#define main test_dsp_r2_subqh_w
+#include "test_dsp_r2_subqh_w.c"
+#undef main
+
+#define main test_dsp_r2_subu_ph
+#include "test_dsp_r2_subu_ph.c"
+#undef main
+
+#define main test_dsp_r2_subu_s_ph
+#include "test_dsp_r2_subu_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_subuh_qb
+#include "test_dsp_r2_subuh_qb.c"
+#undef main
+
+#define main test_dsp_r2_subuh_r_qb
+#include "test_dsp_r2_subuh_r_qb.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_absq_s_ph();
+    ret |= test_dsp_r1_absq_s_w();
+    ret |= test_dsp_r1_addq_ph();
+    ret |= test_dsp_r1_addq_s_ph();
+    ret |= test_dsp_r1_addq_s_w();
+    ret |= test_dsp_r1_addsc();
+    ret |= test_dsp_r1_addu_qb();
+    ret |= test_dsp_r1_addu_s_qb();
+    ret |= test_dsp_r1_addwc();
+    ret |= test_dsp_r1_modsub();
+    ret |= test_dsp_r1_raddu_w_qb();
+    ret |= test_dsp_r1_subq_ph();
+    ret |= test_dsp_r1_subq_s_ph();
+    ret |= test_dsp_r1_subq_s_w();
+    ret |= test_dsp_r1_subu_qb();
+    ret |= test_dsp_r1_subu_s_qb();
+    ret |= test_dsp_r2_absq_s_qb();
+    ret |= test_dsp_r2_addqh_ph();
+    ret |= test_dsp_r2_addqh_r_ph();
+    ret |= test_dsp_r2_addqh_r_w();
+    ret |= test_dsp_r2_addqh_w();
+    ret |= test_dsp_r2_addu_ph();
+    ret |= test_dsp_r2_addu_s_ph();
+    ret |= test_dsp_r2_adduh_qb();
+    ret |= test_dsp_r2_adduh_r_qb();
+    ret |= test_dsp_r2_subqh_ph();
+    ret |= test_dsp_r2_subqh_r_ph();
+    ret |= test_dsp_r2_subqh_r_w();
+    ret |= test_dsp_r2_subqh_w();
+    ret |= test_dsp_r2_subu_ph();
+    ret |= test_dsp_r2_subu_s_ph();
+    ret |= test_dsp_r2_subuh_qb();
+    ret |= test_dsp_r2_subuh_r_qb();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_cmp.c b/tests/tcg/mipsel/test_dsp_cmp.c
new file mode 100644
index 000000000000..47553313eb6a
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_cmp.c
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: compare and pick */
+
+#define main test_dsp_r1_cmp_eq_ph
+#include "test_dsp_r1_cmp_eq_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_le_ph
+#include "test_dsp_r1_cmp_le_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_lt_ph
+#include "test_dsp_r1_cmp_lt_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_eq_qb
+#include "test_dsp_r1_cmpgu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_le_qb
+#include "test_dsp_r1_cmpgu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_lt_qb
+#include "test_dsp_r1_cmpgu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_eq_qb
+#include "test_dsp_r1_cmpu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_le_qb
+#include "test_dsp_r1_cmpu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_lt_qb
+#include "test_dsp_r1_cmpu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_pick_ph
+#include "test_dsp_r1_pick_ph.c"
+#undef main
+
+#define main test_dsp_r1_pick_qb
+#include "test_dsp_r1_pick_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_eq_qb
+#include "test_dsp_r2_cmpgdu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_le_qb
+#include "test_dsp_r2_cmpgdu_le_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_lt_qb
+#include "test_dsp_r2_cmpgdu_lt_qb.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_cmp_eq_ph();
+    ret |= test_dsp_r1_cmp_le_ph();
+    ret |= test_dsp_r1_cmp_lt_ph();
+    ret |= test_dsp_r1_cmpgu_eq_qb();
+    ret |= test_dsp_r1_cmpgu_le_qb();
+    ret |= test_dsp_r1_cmpgu_lt_qb();
+    ret |= test_dsp_r1_cmpu_eq_qb();
+    ret |= test_dsp_r1_cmpu_le_qb();
+    ret |= test_dsp_r1_cmpu_lt_qb();
+    ret |= test_dsp_r1_pick_ph();
+    ret |= test_dsp_r1_pick_qb();
+    ret |= test_dsp_r2_cmpgdu_eq_qb();
+    ret |= test_dsp_r2_cmpgdu_le_qb();
+    ret |= test_dsp_r2_cmpgdu_lt_qb();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_ctrl.c b/tests/tcg/mipsel/test_dsp_ctrl.c
new file mode 100644
index 000000000000..40b0bd1b785b
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_ctrl.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: indexed load and DSPControl access */
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
+    ret |= test_dsp_r1_bposge32();
+    ret |= test_dsp_r1_lbux();
+    ret |= test_dsp_r1_lhx();
+    ret |= test_dsp_r1_lwx();
+    ret |= test_dsp_r1_rddsp();
+    ret |= test_dsp_r1_wrdsp();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_dot.c b/tests/tcg/mipsel/test_dsp_dot.c
new file mode 100644
index 000000000000..5a6b9f0b0853
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_dot.c
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: dot product and multiply-accumulate */
+
+#define main test_dsp_r1_dpaq_s_w_ph
+#include "test_dsp_r1_dpaq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpaq_sa_l_w
+#include "test_dsp_r1_dpaq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbl
+#include "test_dsp_r1_dpau_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbr
+#include "test_dsp_r1_dpau_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_s_w_ph
+#include "test_dsp_r1_dpsq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_sa_l_w
+#include "test_dsp_r1_dpsq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbl
+#include "test_dsp_r1_dpsu_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbr
+#include "test_dsp_r1_dpsu_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phl
+#include "test_dsp_r1_maq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phr
+#include "test_dsp_r1_maq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phl
+#include "test_dsp_r1_maq_sa_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phr
+#include "test_dsp_r1_maq_sa_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_madd
+#include "test_dsp_r1_madd.c"
+#undef main
+
+#define main test_dsp_r1_maddu
+#include "test_dsp_r1_maddu.c"
+#undef main
+
+#define main test_dsp_r1_msub
+#include "test_dsp_r1_msub.c"
+#undef main
+
+#define main test_dsp_r1_msubu
+#include "test_dsp_r1_msubu.c"
+#undef main
+
+#define main test_dsp_r1_mult
+#include "test_dsp_r1_mult.c"
+#undef main
+
+#define main test_dsp_r1_multu
+#include "test_dsp_r1_multu.c"
+#undef main
+
+#define main test_dsp_r2_dpa_w_ph
+#include "test_dsp_r2_dpa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_s_w_ph
+#include "test_dsp_r2_dpaqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_sa_w_ph
+#include "test_dsp_r2_dpaqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpax_w_ph
+#include "test_dsp_r2_dpax_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dps_w_ph
+#include "test_dsp_r2_dps_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_s_w_ph
+#include "test_dsp_r2_dpsqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_sa_w_ph
+#include "test_dsp_r2_dpsqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsx_w_ph
+#include "test_dsp_r2_dpsx_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsa_w_ph
+#include "test_dsp_r2_mulsa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsaq_s_w_ph
+#include "test_dsp_r2_mulsaq_s_w_ph.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_dpaq_s_w_ph();
+    ret |= test_dsp_r1_dpaq_sa_l_w();
+    ret |= test_dsp_r1_dpau_h_qbl();
+    ret |= test_dsp_r1_dpau_h_qbr();
+    ret |= test_dsp_r1_dpsq_s_w_ph();
+    ret |= test_dsp_r1_dpsq_sa_l_w();
+    ret |= test_dsp_r1_dpsu_h_qbl();
+    ret |= test_dsp_r1_dpsu_h_qbr();
+    ret |= test_dsp_r1_maq_s_w_phl();
+    ret |= test_dsp_r1_maq_s_w_phr();
+    ret |= test_dsp_r1_maq_sa_w_phl();
+    ret |= test_dsp_r1_maq_sa_w_phr();
+    ret |= test_dsp_r1_madd();
+    ret |= test_dsp_r1_maddu();
+    ret |= test_dsp_r1_msub();
+    ret |= test_dsp_r1_msubu();
+    ret |= test_dsp_r1_mult();
+    ret |= test_dsp_r1_multu();
+    ret |= test_dsp_r2_dpa_w_ph();
+    ret |= test_dsp_r2_dpaqx_s_w_ph();
+    ret |= test_dsp_r2_dpaqx_sa_w_ph();
+    ret |= test_dsp_r2_dpax_w_ph();
+    ret |= test_dsp_r2_dps_w_ph();
+    ret |= test_dsp_r2_dpsqx_s_w_ph();
+    ret |= test_dsp_r2_dpsqx_sa_w_ph();
+    ret |= test_dsp_r2_dpsx_w_ph();
+    ret |= test_dsp_r2_mulsa_w_ph();
+    ret |= test_dsp_r2_mulsaq_s_w_ph();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_mul.c b/tests/tcg/mipsel/test_dsp_mul.c
new file mode 100644
index 000000000000..9ffa52683ccc
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_mul.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: multiply */
+
+#define main test_dsp_r1_muleq_s_w_phl
+#include "test_dsp_r1_muleq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_muleq_s_w_phr
+#include "test_dsp_r1_muleq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbl
+#include "test_dsp_r1_muleu_s_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbr
+#include "test_dsp_r1_muleu_s_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_mulq_rs_ph
+#include "test_dsp_r1_mulq_rs_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_ph
+#include "test_dsp_r2_mul_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_s_ph
+#include "test_dsp_r2_mul_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_rs_w
+#include "test_dsp_r2_mulq_rs_w.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_ph
+#include "test_dsp_r2_mulq_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_w
+#include "test_dsp_r2_mulq_s_w.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_muleq_s_w_phl();
+    ret |= test_dsp_r1_muleq_s_w_phr();
+    ret |= test_dsp_r1_muleu_s_ph_qbl();
+    ret |= test_dsp_r1_muleu_s_ph_qbr();
+    ret |= test_dsp_r1_mulq_rs_ph();
+    ret |= test_dsp_r2_mul_ph();
+    ret |= test_dsp_r2_mul_s_ph();
+    ret |= test_dsp_r2_mulq_rs_w();
+    ret |= test_dsp_r2_mulq_s_ph();
+    ret |= test_dsp_r2_mulq_s_w();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_pack.c b/tests/tcg/mipsel/test_dsp_pack.c
new file mode 100644
index 000000000000..a2a85061d3ec
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_pack.c
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: precision, pack, replicate and bit insert */
+
+#define main test_dsp_r1_bitrev
+#include "test_dsp_r1_bitrev.c"
+#undef main
+
+#define main test_dsp_r1_insv
+#include "test_dsp_r1_insv.c"
+#undef main
+
+#define main test_dsp_r1_packrl_ph
+#include "test_dsp_r1_packrl_ph.c"
+#undef main
+
+#define main test_dsp_r1_preceq_w_phl
+#include "test_dsp_r1_preceq_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_preceq_w_phr
+#include "test_dsp_r1_preceq_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbl
+#include "test_dsp_r1_precequ_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbla
+#include "test_dsp_r1_precequ_ph_qbla.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbr
+#include "test_dsp_r1_precequ_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbra
+#include "test_dsp_r1_precequ_ph_qbra.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbl
+#include "test_dsp_r1_preceu_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbla
+#include "test_dsp_r1_preceu_ph_qbla.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbr
+#include "test_dsp_r1_preceu_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbra
+#include "test_dsp_r1_preceu_ph_qbra.c"
+#undef main
+
+#define main test_dsp_r1_precrq_ph_w
+#include "test_dsp_r1_precrq_ph_w.c"
+#undef main
+
+#define main test_dsp_r1_precrq_qb_ph
+#include "test_dsp_r1_precrq_qb_ph.c"
+#undef main
+
+#define main test_dsp_r1_precrq_rs_ph_w
+#include "test_dsp_r1_precrq_rs_ph_w.c"
+#undef main
+
+#define main test_dsp_r1_precrqu_s_qb_ph
+#include "test_dsp_r1_precrqu_s_qb_ph.c"
+#undef main
+
+#define main test_dsp_r1_repl_ph
+#include "test_dsp_r1_repl_ph.c"
+#undef main
+
+#define main test_dsp_r1_repl_qb
+#include "test_dsp_r1_repl_qb.c"
+#undef main
+
+#define main test_dsp_r1_replv_ph
+#include "test_dsp_r1_replv_ph.c"
+#undef main
+
+#define main test_dsp_r1_replv_qb
+#include "test_dsp_r1_replv_qb.c"
+#undef main
+
+#define main test_dsp_r2_append
+#include "test_dsp_r2_append.c"
+#undef main
+
+#define main test_dsp_r2_balign
+#include "test_dsp_r2_balign.c"
+#undef main
+
+#define main test_dsp_r2_precr_qb_ph
+#include "test_dsp_r2_precr_qb_ph.c"
+#undef main
+
+#define main test_dsp_r2_precr_sra_ph_w
+#include "test_dsp_r2_precr_sra_ph_w.c"
+#undef main
+
+#define main test_dsp_r2_precr_sra_r_ph_w
+#include "test_dsp_r2_precr_sra_r_ph_w.c"
+#undef main
+
+#define main test_dsp_r2_prepend
+#include "test_dsp_r2_prepend.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_bitrev();
+    ret |= test_dsp_r1_insv();
+    ret |= test_dsp_r1_packrl_ph();
+    ret |= test_dsp_r1_preceq_w_phl();
+    ret |= test_dsp_r1_preceq_w_phr();
+    ret |= test_dsp_r1_precequ_ph_qbl();
+    ret |= test_dsp_r1_precequ_ph_qbla();
+    ret |= test_dsp_r1_precequ_ph_qbr();
+    ret |= test_dsp_r1_precequ_ph_qbra();
+    ret |= test_dsp_r1_preceu_ph_qbl();
+    ret |= test_dsp_r1_preceu_ph_qbla();
+    ret |= test_dsp_r1_preceu_ph_qbr();
+    ret |= test_dsp_r1_preceu_ph_qbra();
+    ret |= test_dsp_r1_precrq_ph_w();
+    ret |= test_dsp_r1_precrq_qb_ph();
+    ret |= test_dsp_r1_precrq_rs_ph_w();
+    ret |= test_dsp_r1_precrqu_s_qb_ph();
+    ret |= test_dsp_r1_repl_ph();
+    ret |= test_dsp_r1_repl_qb();
+    ret |= test_dsp_r1_replv_ph();
+    ret |= test_dsp_r1_replv_qb();
+    ret |= test_dsp_r2_append();
+    ret |= test_dsp_r2_balign();
+    ret |= test_dsp_r2_precr_qb_ph();
+    ret |= test_dsp_r2_precr_sra_ph_w();
+    ret |= test_dsp_r2_precr_sra_r_ph_w();
+    ret |= test_dsp_r2_prepend();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_main.c b/tests/tcg/mipsel/test_dsp_r1_main.c
deleted file mode 100644
index b296b20c9254..000000000000
--- a/tests/tcg/mipsel/test_dsp_r1_main.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include<stdio.h>
-
-int main()
-{
-    printf("hello world\n");
-}
diff --git a/tests/tcg/mipsel/test_dsp_shift.c b/tests/tcg/mipsel/test_dsp_shift.c
new file mode 100644
index 000000000000..a88e46508fab
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_shift.c
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS DSP ASE tests: shift */
+
+#define main test_dsp_r1_shll_ph
+#include "test_dsp_r1_shll_ph.c"
+#undef main
+
+#define main test_dsp_r1_shll_qb
+#include "test_dsp_r1_shll_qb.c"
+#undef main
+
+#define main test_dsp_r1_shll_s_ph
+#include "test_dsp_r1_shll_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_shll_s_w
+#include "test_dsp_r1_shll_s_w.c"
+#undef main
+
+#define main test_dsp_r1_shllv_ph
+#include "test_dsp_r1_shllv_ph.c"
+#undef main
+
+#define main test_dsp_r1_shllv_qb
+#include "test_dsp_r1_shllv_qb.c"
+#undef main
+
+#define main test_dsp_r1_shllv_s_ph
+#include "test_dsp_r1_shllv_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_shllv_s_w
+#include "test_dsp_r1_shllv_s_w.c"
+#undef main
+
+#define main test_dsp_r1_shra_ph
+#include "test_dsp_r1_shra_ph.c"
+#undef main
+
+#define main test_dsp_r1_shra_r_ph
+#include "test_dsp_r1_shra_r_ph.c"
+#undef main
+
+#define main test_dsp_r1_shra_r_w
+#include "test_dsp_r1_shra_r_w.c"
+#undef main
+
+#define main test_dsp_r1_shrav_ph
+#include "test_dsp_r1_shrav_ph.c"
+#undef main
+
+#define main test_dsp_r1_shrav_r_ph
+#include "test_dsp_r1_shrav_r_ph.c"
+#undef main
+
+#define main test_dsp_r1_shrav_r_w
+#include "test_dsp_r1_shrav_r_w.c"
+#undef main
+
+#define main test_dsp_r1_shrl_qb
+#include "test_dsp_r1_shrl_qb.c"
+#undef main
+
+#define main test_dsp_r1_shrlv_qb
+#include "test_dsp_r1_shrlv_qb.c"
+#undef main
+
+#define main test_dsp_r2_shra_qb
+#include "test_dsp_r2_shra_qb.c"
+#undef main
+
+#define main test_dsp_r2_shra_r_qb
+#include "test_dsp_r2_shra_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrav_qb
+#include "test_dsp_r2_shrav_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrav_r_qb
+#include "test_dsp_r2_shrav_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrl_ph
+#include "test_dsp_r2_shrl_ph.c"
+#undef main
+
+#define main test_dsp_r2_shrlv_ph
+#include "test_dsp_r2_shrlv_ph.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_dsp_r1_shll_ph();
+    ret |= test_dsp_r1_shll_qb();
+    ret |= test_dsp_r1_shll_s_ph();
+    ret |= test_dsp_r1_shll_s_w();
+    ret |= test_dsp_r1_shllv_ph();
+    ret |= test_dsp_r1_shllv_qb();
+    ret |= test_dsp_r1_shllv_s_ph();
+    ret |= test_dsp_r1_shllv_s_w();
+    ret |= test_dsp_r1_shra_ph();
+    ret |= test_dsp_r1_shra_r_ph();
+    ret |= test_dsp_r1_shra_r_w();
+    ret |= test_dsp_r1_shrav_ph();
+    ret |= test_dsp_r1_shrav_r_ph();
+    ret |= test_dsp_r1_shrav_r_w();
+    ret |= test_dsp_r1_shrl_qb();
+    ret |= test_dsp_r1_shrlv_qb();
+    ret |= test_dsp_r2_shra_qb();
+    ret |= test_dsp_r2_shra_r_qb();
+    ret |= test_dsp_r2_shrav_qb();
+    ret |= test_dsp_r2_shrav_r_qb();
+    ret |= test_dsp_r2_shrl_ph();
+    ret |= test_dsp_r2_shrlv_ph();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index c9e869b000f4..d0745c2c185f 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -4,166 +4,14 @@ tests = []
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests_dsp = [
-  'test_dsp_r1_absq_s_ph.c',
-  'test_dsp_r1_absq_s_w.c',
-  'test_dsp_r1_addq_ph.c',
-  'test_dsp_r1_addq_s_ph.c',
-  'test_dsp_r1_addq_s_w.c',
-  'test_dsp_r1_addsc.c',
-  'test_dsp_r1_addu_qb.c',
-  'test_dsp_r1_addu_s_qb.c',
-  'test_dsp_r1_addwc.c',
-  'test_dsp_r1_bitrev.c',
-  'test_dsp_r1_bposge32.c',
-  'test_dsp_r1_cmp_eq_ph.c',
-  'test_dsp_r1_cmp_le_ph.c',
-  'test_dsp_r1_cmp_lt_ph.c',
-  'test_dsp_r1_cmpgu_eq_qb.c',
-  'test_dsp_r1_cmpgu_le_qb.c',
-  'test_dsp_r1_cmpgu_lt_qb.c',
-  'test_dsp_r1_cmpu_eq_qb.c',
-  'test_dsp_r1_cmpu_le_qb.c',
-  'test_dsp_r1_cmpu_lt_qb.c',
-  'test_dsp_r1_dpaq_s_w_ph.c',
-  'test_dsp_r1_dpaq_sa_l_w.c',
-  'test_dsp_r1_dpau_h_qbl.c',
-  'test_dsp_r1_dpau_h_qbr.c',
-  'test_dsp_r1_dpsq_s_w_ph.c',
-  'test_dsp_r1_dpsq_sa_l_w.c',
-  'test_dsp_r1_dpsu_h_qbl.c',
-  'test_dsp_r1_dpsu_h_qbr.c',
-  'test_dsp_r1_extp.c',
-  'test_dsp_r1_extpdp.c',
-  'test_dsp_r1_extpdpv.c',
-  'test_dsp_r1_extpv.c',
-  'test_dsp_r1_extr_r_w.c',
-  'test_dsp_r1_extr_rs_w.c',
-  'test_dsp_r1_extr_s_h.c',
-  'test_dsp_r1_extr_w.c',
-  'test_dsp_r1_extrv_r_w.c',
-  'test_dsp_r1_extrv_rs_w.c',
-  'test_dsp_r1_extrv_s_h.c',
-  'test_dsp_r1_extrv_w.c',
-  'test_dsp_r1_insv.c',
-  'test_dsp_r1_lbux.c',
-  'test_dsp_r1_lhx.c',
-  'test_dsp_r1_lwx.c',
-  'test_dsp_r1_madd.c',
-  'test_dsp_r1_maddu.c',
-  'test_dsp_r1_main.c',
-  'test_dsp_r1_maq_s_w_phl.c',
-  'test_dsp_r1_maq_s_w_phr.c',
-  'test_dsp_r1_maq_sa_w_phl.c',
-  'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_mfhi.c',
-  'test_dsp_r1_mflo.c',
-  'test_dsp_r1_modsub.c',
-  'test_dsp_r1_msub.c',
-  'test_dsp_r1_msubu.c',
-  'test_dsp_r1_mthi.c',
-  'test_dsp_r1_mthlip.c',
-  'test_dsp_r1_mtlo.c',
-  'test_dsp_r1_muleq_s_w_phl.c',
-  'test_dsp_r1_muleq_s_w_phr.c',
-  'test_dsp_r1_muleu_s_ph_qbl.c',
-  'test_dsp_r1_muleu_s_ph_qbr.c',
-  'test_dsp_r1_mulq_rs_ph.c',
-  'test_dsp_r1_mult.c',
-  'test_dsp_r1_multu.c',
-  'test_dsp_r1_packrl_ph.c',
-  'test_dsp_r1_pick_ph.c',
-  'test_dsp_r1_pick_qb.c',
-  'test_dsp_r1_preceq_w_phl.c',
-  'test_dsp_r1_preceq_w_phr.c',
-  'test_dsp_r1_precequ_ph_qbl.c',
-  'test_dsp_r1_precequ_ph_qbla.c',
-  'test_dsp_r1_precequ_ph_qbr.c',
-  'test_dsp_r1_precequ_ph_qbra.c',
-  'test_dsp_r1_preceu_ph_qbl.c',
-  'test_dsp_r1_preceu_ph_qbla.c',
-  'test_dsp_r1_preceu_ph_qbr.c',
-  'test_dsp_r1_preceu_ph_qbra.c',
-  'test_dsp_r1_precrq_ph_w.c',
-  'test_dsp_r1_precrq_qb_ph.c',
-  'test_dsp_r1_precrq_rs_ph_w.c',
-  'test_dsp_r1_precrqu_s_qb_ph.c',
-  'test_dsp_r1_raddu_w_qb.c',
-  'test_dsp_r1_rddsp.c',
-  'test_dsp_r1_repl_ph.c',
-  'test_dsp_r1_repl_qb.c',
-  'test_dsp_r1_replv_ph.c',
-  'test_dsp_r1_replv_qb.c',
-  'test_dsp_r1_shilo.c',
-  'test_dsp_r1_shilov.c',
-  'test_dsp_r1_shll_ph.c',
-  'test_dsp_r1_shll_qb.c',
-  'test_dsp_r1_shll_s_ph.c',
-  'test_dsp_r1_shll_s_w.c',
-  'test_dsp_r1_shllv_ph.c',
-  'test_dsp_r1_shllv_qb.c',
-  'test_dsp_r1_shllv_s_ph.c',
-  'test_dsp_r1_shllv_s_w.c',
-  'test_dsp_r1_shra_ph.c',
-  'test_dsp_r1_shra_r_ph.c',
-  'test_dsp_r1_shra_r_w.c',
-  'test_dsp_r1_shrav_ph.c',
-  'test_dsp_r1_shrav_r_ph.c',
-  'test_dsp_r1_shrav_r_w.c',
-  'test_dsp_r1_shrl_qb.c',
-  'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r1_subq_ph.c',
-  'test_dsp_r1_subq_s_ph.c',
-  'test_dsp_r1_subq_s_w.c',
-  'test_dsp_r1_subu_qb.c',
-  'test_dsp_r1_subu_s_qb.c',
-  'test_dsp_r1_wrdsp.c',
-  'test_dsp_r2_absq_s_qb.c',
-  'test_dsp_r2_addqh_ph.c',
-  'test_dsp_r2_addqh_r_ph.c',
-  'test_dsp_r2_addqh_r_w.c',
-  'test_dsp_r2_addqh_w.c',
-  'test_dsp_r2_addu_ph.c',
-  'test_dsp_r2_addu_s_ph.c',
-  'test_dsp_r2_adduh_qb.c',
-  'test_dsp_r2_adduh_r_qb.c',
-  'test_dsp_r2_append.c',
-  'test_dsp_r2_balign.c',
-  'test_dsp_r2_cmpgdu_eq_qb.c',
-  'test_dsp_r2_cmpgdu_le_qb.c',
-  'test_dsp_r2_cmpgdu_lt_qb.c',
-  'test_dsp_r2_dpa_w_ph.c',
-  'test_dsp_r2_dpaqx_s_w_ph.c',
-  'test_dsp_r2_dpaqx_sa_w_ph.c',
-  'test_dsp_r2_dpax_w_ph.c',
-  'test_dsp_r2_dps_w_ph.c',
-  'test_dsp_r2_dpsqx_s_w_ph.c',
-  'test_dsp_r2_dpsqx_sa_w_ph.c',
-  'test_dsp_r2_dpsx_w_ph.c',
-  'test_dsp_r2_mul_ph.c',
-  'test_dsp_r2_mul_s_ph.c',
-  'test_dsp_r2_mulq_rs_w.c',
-  'test_dsp_r2_mulq_s_ph.c',
-  'test_dsp_r2_mulq_s_w.c',
-  'test_dsp_r2_mulsa_w_ph.c',
-  'test_dsp_r2_mulsaq_s_w_ph.c',
-  'test_dsp_r2_precr_qb_ph.c',
-  'test_dsp_r2_precr_sra_ph_w.c',
-  'test_dsp_r2_precr_sra_r_ph_w.c',
-  'test_dsp_r2_prepend.c',
-  'test_dsp_r2_shra_qb.c',
-  'test_dsp_r2_shra_r_qb.c',
-  'test_dsp_r2_shrav_qb.c',
-  'test_dsp_r2_shrav_r_qb.c',
-  'test_dsp_r2_shrl_ph.c',
-  'test_dsp_r2_shrlv_ph.c',
-  'test_dsp_r2_subqh_ph.c',
-  'test_dsp_r2_subqh_r_ph.c',
-  'test_dsp_r2_subqh_r_w.c',
-  'test_dsp_r2_subqh_w.c',
-  'test_dsp_r2_subu_ph.c',
-  'test_dsp_r2_subu_s_ph.c',
-  'test_dsp_r2_subuh_qb.c',
-  'test_dsp_r2_subuh_r_qb.c',
+  'test_dsp_acc.c',
+  'test_dsp_arith.c',
+  'test_dsp_cmp.c',
+  'test_dsp_ctrl.c',
+  'test_dsp_dot.c',
+  'test_dsp_mul.c',
+  'test_dsp_pack.c',
+  'test_dsp_shift.c',
 ]
 
 foreach src: tests_dsp
-- 
2.55.0


