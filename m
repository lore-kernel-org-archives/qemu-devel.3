Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E6606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VgLokB99;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EUcyuSBj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqq2-0007MI-KF; Fri, 30 Oct 2026 13:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpp-0006SA-0d
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpn-0008Ft-6W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu98i3057245
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YLL5RXWILMB7fjfKuCCyY50o+eS5IMIpVByg0Qj6qbI=; b=VgLokB99JpZaAbdo
 Aij4iju/e6iQsLT1e6cA5nhHfEihwJ/jLfmdOu/WhEuL9p4R/MJQJYC0ajW52PqK
 HVJvS50mG48VW8rX9CfM57fT/6FgxlWx48JayWGAdBeQHqc0cArvoohItxmoVpkQ
 Jzm2JMTnZJgH9E7U2+fLyaZadzeylNkJSKLsNVECX/Sd10UIhDi9koHs0PE61Rrl
 sAguPQvPIdn7SC0Hy05Hxajq4J8zouPST91k3Aonz+iEu/BSXFXRIPt/zobCiSrM
 8Xe4ihArafK4q6BFrXEFWAa5XykRitW3aFCoMNpyMYzvd6bdW1vwe0aktqtFHfN5
 bEy2GQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pcbbf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:07 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d06f3784e2so233173137.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382949; x=1793987749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YLL5RXWILMB7fjfKuCCyY50o+eS5IMIpVByg0Qj6qbI=;
 b=EUcyuSBjeAgpnW96lPbG7HZX7XwCZkKPz5i8Zrv/uJ1Ai0AiLbtHY1K+YYIPT3p1Wc
 PW7lrLNTxQBYCQwna2e7NycdviCdOslWQ+AYBZZa55DapzIJsYLwuWoXyTIXCqU/gn/0
 zTidoTjNJ3l1bWDLvHSzkJMGrAQ0w7We8OgRzlVs0+B+awHLLzsoCost6jO8pVL9Vp/U
 rMsHy+4eocDdW03Wygv0u/2RgulW3wWjOWN65LLEbIS/5z5g27+fbpykZ+U8B2UrpsJQ
 SCmhJot579oPzgznY06X0kbV+mSHNRJ8prcx6gM6GEU7q7J8TyKD3H2SHUtaTrdJ16/5
 Ff5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382949; x=1793987749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YLL5RXWILMB7fjfKuCCyY50o+eS5IMIpVByg0Qj6qbI=;
 b=MMqwKrH2UBIiiWCyqzKksnz8q0mRXHceczrDHSMg9aJctowJ9HviF1ETShteyrVnVH
 sRxwgbkUAl2R753r9m886SgDkZR+aBV2QK9QG6+6+QxJse38Ui93kYhQUgPu3MCJGIhp
 ryJ3vbXToTyZ+Ge58GUAKxPNa/qgN9YtZUt1wVKwR9mdjebpNAmETXI/j3+wA32YL3cw
 vMuCuZLddFeQcsFgKEtR4bVOr6kZo34Ep/lQB2usJV2tT2niP/23hYMinAMxk7xZFOcQ
 0cM3yf8JK+VSgoEwDi9hCAIVtT7ef0zjSPxJ7IdrzNeAQrUsxrsH7rird98XRk6LGyvP
 bLTg==
X-Gm-Message-State: AFq9FYKek9P3qeZUhbTXBKQ3zSaABHvoq7e494sAs/ToD7w2oLqUT+JM
 nVof/RhQSWX2N7PT74daMVjuRJhbf5yzXydyJL3WaKWBOS0V1LcI4nMf69rHD+TCAmnmwxBNQ2h
 X4oGjeoI3EQzY1GhRWr5xG0tKIDxwTxuGIQszWQ6VKVP/TNA5dQEk2NwoIDF5dvUIZoDF
X-Gm-Gg: AYBFou3p470XEPi7UdVZ4+vAXFCIvQn8Hc4BikiuKLNHFwhtAuJPT0tZRjZCZ/wSNP5
 /Lt3VRDPCjGRrQEM0mGd1+aZmHZ0p8IJq6xCCaXMwufvPCLTVr7PY8F/UiGYOC5/mNwbhZkwmsJ
 xfnduWwmnIfBUpGosdKuB/X+eAguBzptVpYJ4jY0uoJlCvm/0p53qpV1e/7JiWO1cltFlABcDwZ
 wzAHqxiMdVrwLpNAh2VHUTDDYLY6qQuamK0OgYA9gNwQnvqNALPKuMr3iZGJJBX+g/NNBRLN0l9
 2lKlRBNVTuy6hRhLmuc7DjHRKLx4CnNAZkmwPOJE1bduQiu/Oyoc9feiRZdhVXwVxTy3XYQ+uOA
 3H7RfhQLj1Erw2OJ2XdWtrohhDntWHtrnVnqIZUSR/XGXwOam2IDzpyhpO6ZmaqihURKNvc7AAk
 xQQ7innBCHVL2GZWFZjWMjvOvBbPKM0A==
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id
 ada2fe7eead31-7d072cc29e5mr1244023137.28.1793382949248; 
 Fri, 30 Oct 2026 10:55:49 -0700 (PDT)
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id
 ada2fe7eead31-7d072cc29e5mr1244012137.28.1793382948793; 
 Fri, 30 Oct 2026 10:55:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm4522921f8f.2.2026.10.30.10.55.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 13/32] tests/tcg/mips: Group Release 6 multiply tests
Date: Fri, 30 Oct 2026 18:53:35 +0100
Message-ID: <20261030175357.99684-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXxz+zvGbAZ1cH
 OmNirA4Kicv3RmbAqwJ7z7STlm5kBxvjFRxwS7TqeqRmNrPEqs9rkZuaUaVrX4ZBknDouSAvdEF
 iP/W0Jyl8BmEtuKbAp6+SfJuuhWbU3imrjlHnm2vebwQc2UqTG2vXtVgKj6qHJs84s9+eq3QyXH
 DqbXH1MDVH8Rdwdt4gzdv/Zz7SFrsSixZOBT04qAu1ljmFxofImaAK0orf5HMYTCWlc1AYCNt4o
 GFo9/AxdlP+twILLrJ4avQnhgpJu3UnKb0xvQ4KULNXxy2Dguo+UXcREIprX/+LOPA3NydY8TmE
 UYW4/Nb9RI9z9kwQMP91LHYvMAKSiMRfEnsdzHKEovJMLlc3dj3Ds5em80TAP2JHtNm1YMtmkQT
 h/fUVHuxZQwSzMCiqirQ6/HSlLYn7CrnmsgTf4wlig/GkQPoaJwiqRGpBuo5SZ09jyGstFPhbdx
 Sux1tvEQWKdssjssV8A==
X-Proofpoint-GUID: neuxnxvo81RX_Pnr8SHjO86Zt-ijecMh
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4da39 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=bvgRRmj5kG-2naEzI9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: neuxnxvo81RX_Pnr8SHjO86Zt-ijecMh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX/BQMdgBjoe4Q
 wqBmdgXtm8a7rY1k/L4buBUQnm30izU0q2vLUJeeoWCyjFRuaFtisOi+ep61rKKGTAUGBPJqZ2p
 oNNL/Yw5BGEOgfodE+egkO4bxArjSpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Build the 8 per-opcode multiply tests as a single executable,
test_mips64r6_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_multiply.c | 72 +++++++++++++++++++++++
 tests/tcg/mips64/meson.build              |  9 +--
 2 files changed, 73 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c

diff --git a/tests/tcg/mips64/test_mips64r6_multiply.c b/tests/tcg/mips64/test_mips64r6_multiply.c
new file mode 100644
index 000000000000..e400d418b9fd
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_multiply.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: multiply */
+
+#include "../include/tap.h"
+
+#define main test_mips64r6_mul
+#include "test_mips64r6_mul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muh
+#include "test_mips64r6_muh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_mulu
+#include "test_mips64r6_mulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muhu
+#include "test_mips64r6_muhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmul
+#include "test_mips64r6_dmul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuh
+#include "test_mips64r6_dmuh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmulu
+#include "test_mips64r6_dmulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuhu
+#include "test_mips64r6_dmuhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "mul", test_mips64r6_mul },
+    { "muh", test_mips64r6_muh },
+    { "mulu", test_mips64r6_mulu },
+    { "muhu", test_mips64r6_muhu },
+    { "dmul", test_mips64r6_dmul },
+    { "dmuh", test_mips64r6_dmuh },
+    { "dmulu", test_mips64r6_dmulu },
+    { "dmuhu", test_mips64r6_dmuhu },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 multiply %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 657a1c4d5cc9..d356689e54bf 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -31,17 +31,10 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_crc.c',
   '../mips64/test_mips64r6_logic.c',
-  '../mips64/test_mips64r6_dmuh.c',
-  '../mips64/test_mips64r6_dmuhu.c',
-  '../mips64/test_mips64r6_dmul.c',
-  '../mips64/test_mips64r6_dmulu.c',
+  '../mips64/test_mips64r6_multiply.c',
   '../mips64/test_mips64r6_dsllv.c',
   '../mips64/test_mips64r6_dsrav.c',
   '../mips64/test_mips64r6_dsrlv.c',
-  '../mips64/test_mips64r6_muh.c',
-  '../mips64/test_mips64r6_muhu.c',
-  '../mips64/test_mips64r6_mul.c',
-  '../mips64/test_mips64r6_mulu.c',
   '../mips64/test_mips64r6_sllv.c',
   '../mips64/test_mips64r6_srav.c',
   '../mips64/test_mips64r6_srlv.c',
-- 
2.55.0


