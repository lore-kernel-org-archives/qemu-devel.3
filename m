Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF70606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jfnwEtKT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IHkGddQq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9IZ-0002Fz-0F; Wed, 28 Oct 2026 15:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9IV-00024S-Hu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9IQ-0006F5-I0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPKrC1942049
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3OXiIwz3EsOLHTYtcrWZ7oYehUBMFD4b4I27qAIy7ec=; b=jfnwEtKTxmStj1Yp
 WtdvDh1vU5omJpZMQQrSAMqKhXnDtmLvrIUCBVlVUp7lP8+dbxY0a36hHME7vBQC
 RXJ38noUggpw8dmrdRNFqt2rsHb9myLB7tTEaffpj/dbkYiMYNvD/v9nuaD/YgYu
 DLcQ6NXxF4VEL0qarfH+ABStq/qG8SmvHV1uyZtYj8bQZ6ezQ/d1hNXUcWWpFk5Z
 +JZiTn+PzoBGd3Ne8muwAHEvUh9VBQ/NSYk2wd3TqKawquiV3/sYDfrfhciXjI3e
 Xh2MelWAdYVgQCyIlgpB5GgWxCE7bVqcPVhwsoz/spmxtP+hW3gmH77WT0Pbm0/a
 XpbkAA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwb5hp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb6391e89so272657785a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215608; x=1793820408; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3OXiIwz3EsOLHTYtcrWZ7oYehUBMFD4b4I27qAIy7ec=;
 b=IHkGddQqTQ1WJyAQDpbo2bm3Iido0s4PshBy1rG7oG4EdD8dG7biEkzrOZI54whIPD
 s00csmqc4FopoaVBrWbfOfDxretY+3NEetnwsJHfgR7xYxCgx4obFCoJxulX0C3swnFr
 dRuWPaFUv/OyXAYBnGrjp8Rn+mSabQHcUz1RPVWHRsR9mYtw8fgQGDT9eAv20Fma6rRX
 pYoAzkMiQjjpoG1d+hxF+Qh0l+otBi1piM5EG8W8W0TGPacKFTA8m+NelzkofoGm4sn0
 U8JxUOPFzWRJ+VbXoPuo6j0+CPaA2V46PORHd7PLuyk+8S9v3/0vBJf5mKyzn+oAns1H
 +Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215608; x=1793820408;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3OXiIwz3EsOLHTYtcrWZ7oYehUBMFD4b4I27qAIy7ec=;
 b=w4t3/4J3IVcWPjf8enfmQixbJ/auXzQEgcqr3TBrdE2yd9ejnznD/8I9rdyiXvrYkM
 71RgZjlD+8wOhbhsOqCpGw1S7O+fpQV3doyC88YTSuRH8fbXXPEZ/gk0KUsdndXjID7E
 CwbroiOl70QJCe8SgGllw1xtprZUiFOpbQhm+DD0hnZ4+Li9kE49MEjKsiMMwwWipwbe
 PBWeR0jxwLZvIA+5PwA7XLAPJYnxmRU0bgDiFtUIF7K8bLflPzgsKSrxN3RP/Y79oAYk
 RcM8Oju6vCvYEj29J5if3gTRaSM4FiAPmZ/AgEBibR5XgechRM2W0f70CPgujwZSYh4E
 z+FQ==
X-Gm-Message-State: AFq9FYI13xnRu949YErY4OVWmD/iBQtHPnY/rTiRNjSezffm4R174Z5b
 qAygGLGfwIQoX+6Hg+vccwlFehCkTnQH6mDtyYhsr87ydYM665CCOPFOo3IHOsqvfmacvOiRVG9
 tonEvccOVG8MRbjQxHN4ElqjISwzZ2ZZSMbxRRkBnxxBvtCzPQ0mzvGlkNPgor+UD64j4
X-Gm-Gg: AYBFou3fpxXeAjMkP3LdxSh+ECNWywWPTSiaGJI2Ncmo2/51H2qgSix1WUadZSm9L7q
 4qyXNqzU8Huq6KT5K3whoUtX2RCt5OF4A/nTf9sxLbltciz/ck30YCBoxlUS7OfzIzW2dnVZjxa
 vGPRo8l9kTyQZQBlhgvHnc1dVVoyp0JOyj6DPj15ZAkFstzrxb91/uDi27dVqF8L2g42xkWPosh
 epEWIainwyeO1mGqtKTaRuK8Nis+NY1Z3y7wKn7GTBB1bqlzpMlOkDtXkW7sN+JBlbjmypPhbPu
 qMPNwDmDUr7aiDQGOgmjFxQkiMBr8DwvT1Eo7eam/hMjuBv0ElMeaBC6i1Rfi0d0KgqF4ZS4vcc
 61LdYmEIX4q5x1nBr17E0tBRjAAkWqKweawlgtUDKAQh69aaQpfBdcN5NCeLbeZa5Hcuaj/t37Y
 VVblqGHYrLoRqblSRBn1DJpSB0Ome0hQ==
X-Received: by 2002:a05:620a:7108:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-94408d509f3mr488631685a.76.1793215607682; 
 Wed, 28 Oct 2026 12:26:47 -0700 (PDT)
X-Received: by 2002:a05:620a:7108:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-94408d509f3mr488625785a.76.1793215606965; 
 Wed, 28 Oct 2026 12:26:46 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a93103e72dsm49386405e9.2.2026.10.28.12.26.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 9/9] tests/tcg/mips64el: Add a TX79 instruction test in
 system mode
Date: Wed, 28 Oct 2026 20:25:37 +0100
Message-ID: <20261028192538.31600-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1J9s4qcK7AXIhXIRxgMkMy89xlhkZqtx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXwqUYH5rlAKME
 IfFPLcrvUujroq5gF3UCkzZw77GoS+XgRwDhwjPrrsPMuhymuFNHXERPeW+NgiZdlayAJJgKjKR
 ZgMqjxLx+mUvlWxeQH4nDnABXcO9KFk=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae24c79 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Exv68JOPKqC82kISgxAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 1J9s4qcK7AXIhXIRxgMkMy89xlhkZqtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX+gqSgH2w27jz
 gCTdzYjVWdXAjPedGTzMokZjf3CZtw5GVLm46Lz7AA+CtIgGVJfj22334qix2pOfUhKLrY8Um1l
 QweKJOMKv+Q34B0javTbxUaR/wKrFxe5yzDwcWf8OY9PYIS6dDWSgPpdqjBJatbQ55jvjxPbOz8
 XmtnWhvc1gEY83tQUDfpWNvwmB8f5g9HcRdFbQ1eK/eDLLWt2cgJWjWP4d/mLkoFVEcEcD1qElT
 d3PscWuP5igO1oAPAdppjiqGBQifvF+byT5wD80H1p2PC1iMXIBV5XqSUOiPlX8XTias82bbX5m
 1k+s97Y0WzUuu9/tjN3Zk6UsqCdPEZmt1f6urYs4+4tRcSXZTgWDSSVOvTCdWK/WpGrzKkwlVYT
 2wygg9bK9wBhelKljZofhlHf9oiBCFCFn09lEZUETuMECqu7sjH/GZ0teycaMYOtEvf3XQqxsrR
 qiX+JdgOMnBljGLYZTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
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

Exercise the instructions decoded by tx79.decode (parallel
arithmetic/compare/logic/extend, PCPYH, PROT3W, HI1/LO1 moves, LQ/SQ).
The instruction words are emitted directly, as the assembler does not
know the TX79 mnemonics.

Build it with the n32 ABI, to move 64-bit values to HI1/LO1.

AI-used-for: tests
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64el/system/test_r5900_tx79.c | 477 ++++++++++++++++++++
 tests/tcg/mips64el/system/meson.build       |   9 +
 2 files changed, 486 insertions(+)
 create mode 100644 tests/tcg/mips64el/system/test_r5900_tx79.c

diff --git a/tests/tcg/mips64el/system/test_r5900_tx79.c b/tests/tcg/mips64el/system/test_r5900_tx79.c
new file mode 100644
index 000000000000..64b9b53b9440
--- /dev/null
+++ b/tests/tcg/mips64el/system/test_r5900_tx79.c
@@ -0,0 +1,477 @@
+/*
+ * Test the TX79 instructions decoded by target/mips/tcg/tx79.decode.
+ *
+ * The instruction words are emitted directly because the normal MIPS64
+ * assembler does not know the TX79 mnemonics.  LQ and SQ are used to move
+ * values into and out of the emulated 128-bit GPRs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+typedef struct {
+    uint64_t lo;
+    uint64_t hi;
+} __attribute__((aligned(16))) tx79_qword;
+
+#define TX79_STR1(x) #x
+#define TX79_STR(x) TX79_STR1(x)
+
+#define TX79_R(rs, rt, rd, sub, func) \
+    ((0x1cU << 26) | ((rs) << 21) | ((rt) << 16) | ((rd) << 11) | \
+     ((sub) << 6) | (func))
+#define TX79_LDST(op, base, rt, offset) \
+    (((op) << 26) | ((base) << 21) | ((rt) << 16) | ((offset) & 0xffffU))
+
+#define TX79_BINOP_WORD(INSN, A, B)                                      \
+    ({                                                                   \
+        tx79_qword _result;                                              \
+        asm volatile(                                                     \
+            "move $7, %[a]\n"                                           \
+            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, 0)) "\n"           \
+            "move $7, %[b]\n"                                           \
+            ".word " TX79_STR(TX79_LDST(0x1e, 7, 9, 0)) "\n"           \
+            "move $7, %[a]\n"                                           \
+            ".word " TX79_STR(TX79_LDST(0x1e, 7, 10, 0)) "\n"          \
+            ".word " TX79_STR(INSN) "\n"                                \
+            "move $7, %[result]\n"                                      \
+            ".word " TX79_STR(TX79_LDST(0x1f, 7, 10, 0)) "\n"          \
+            :                                                             \
+            : [a] "r" (A), [b] "r" (B), [result] "r" (&_result)        \
+            : "$7", "$8", "$9", "$10", "memory");                    \
+        _result;                                                          \
+    })
+
+#define TX79_UNARY_WORD(INSN, A)                                         \
+    ({                                                                   \
+        tx79_qword _result;                                              \
+        asm volatile(                                                     \
+            "move $7, %[a]\n"                                           \
+            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, 0)) "\n"           \
+            ".word " TX79_STR(INSN) "\n"                                \
+            "move $7, %[result]\n"                                      \
+            ".word " TX79_STR(TX79_LDST(0x1f, 7, 10, 0)) "\n"          \
+            :                                                             \
+            : [a] "r" (A), [result] "r" (&_result)                      \
+            : "$7", "$8", "$10", "memory");                            \
+        _result;                                                          \
+    })
+
+#define TX79_LQ_OFFSET(OFFSET, BASE)                                     \
+    ({                                                                   \
+        tx79_qword _result;                                              \
+        asm volatile(                                                     \
+            "move $7, %[base]\n"                                        \
+            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, OFFSET)) "\n"      \
+            "move $7, %[result]\n"                                      \
+            ".word " TX79_STR(TX79_LDST(0x1f, 7, 8, 0)) "\n"           \
+            :                                                             \
+            : [base] "r" (BASE), [result] "r" (&_result)                \
+            : "$7", "$8", "memory");                                   \
+        _result;                                                          \
+    })
+
+#define TX79_SQ_OFFSET(OFFSET, VALUE, BASE)                               \
+    do {                                                                   \
+        asm volatile(                                                       \
+            "move $7, %[value]\n"                                        \
+            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, 0)) "\n"            \
+            "move $7, %[base]\n"                                         \
+            ".word " TX79_STR(TX79_LDST(0x1f, 7, 8, OFFSET)) "\n"        \
+            :                                                               \
+            : [value] "r" (VALUE), [base] "r" (BASE)                     \
+            : "$7", "$8", "memory");                                    \
+    } while (0)
+
+static int check_qword(const char *name, tx79_qword got, tx79_qword expected)
+{
+    if (got.lo == expected.lo && got.hi == expected.hi) {
+        return 0;
+    }
+
+    fprintf(stderr, "%s: got %016llx:%016llx expected %016llx:%016llx\n",
+            name, (unsigned long long)got.hi, (unsigned long long)got.lo,
+            (unsigned long long)expected.hi,
+            (unsigned long long)expected.lo);
+    return 1;
+}
+
+static uint64_t lane_mask(unsigned bits)
+{
+    return (1ULL << bits) - 1;
+}
+
+static int64_t sign_extend_lane(uint64_t value, unsigned bits)
+{
+    uint64_t sign = 1ULL << (bits - 1);
+
+    value &= lane_mask(bits);
+    return (int64_t)((value ^ sign) - sign);
+}
+
+static tx79_qword ref_sub(tx79_qword a, tx79_qword b, unsigned bits)
+{
+    tx79_qword result = { 0, 0 };
+    uint64_t mask = lane_mask(bits);
+
+    for (unsigned half = 0; half < 2; half++) {
+        uint64_t av = half ? a.hi : a.lo;
+        uint64_t bv = half ? b.hi : b.lo;
+        uint64_t *dst = half ? &result.hi : &result.lo;
+
+        for (unsigned lane = 0; lane < 64 / bits; lane++) {
+            uint64_t shift = lane * bits;
+            *dst |= (((av >> shift) - (bv >> shift)) & mask) << shift;
+        }
+    }
+
+    return result;
+}
+
+static tx79_qword ref_compare(tx79_qword a, tx79_qword b, unsigned bits,
+                              int equal)
+{
+    tx79_qword result = { 0, 0 };
+    uint64_t mask = lane_mask(bits);
+
+    for (unsigned half = 0; half < 2; half++) {
+        uint64_t av = half ? a.hi : a.lo;
+        uint64_t bv = half ? b.hi : b.lo;
+        uint64_t *dst = half ? &result.hi : &result.lo;
+
+        for (unsigned lane = 0; lane < 64 / bits; lane++) {
+            uint64_t shift = lane * bits;
+            int64_t as = sign_extend_lane(av >> shift, bits);
+            int64_t bs = sign_extend_lane(bv >> shift, bits);
+            int match = equal ? as == bs : as > bs;
+
+            if (match) {
+                *dst |= mask << shift;
+            }
+        }
+    }
+
+    return result;
+}
+
+static tx79_qword ref_pext(tx79_qword a, tx79_qword b, unsigned bits,
+                           int upper)
+{
+    tx79_qword result = { 0, 0 };
+    uint64_t av = upper ? a.hi : a.lo;
+    uint64_t bv = upper ? b.hi : b.lo;
+
+    for (unsigned lane = 0; lane < 64 / (2 * bits); lane++) {
+        uint64_t shift = lane * bits;
+        uint64_t dst_shift = lane * 2 * bits;
+        uint64_t mask = lane_mask(bits);
+
+        result.lo |= ((bv >> shift) & mask) << dst_shift;
+        result.lo |= ((av >> shift) & mask) << (dst_shift + bits);
+        result.hi |= ((bv >> (shift + 32)) & mask) << dst_shift;
+        result.hi |= ((av >> (shift + 32)) & mask) << (dst_shift + bits);
+    }
+
+    return result;
+}
+
+static tx79_qword ref_logic(tx79_qword a, tx79_qword b, char op)
+{
+    tx79_qword result;
+
+    switch (op) {
+    case '&':
+        result.lo = a.lo & b.lo;
+        result.hi = a.hi & b.hi;
+        break;
+    case '|':
+        result.lo = a.lo | b.lo;
+        result.hi = a.hi | b.hi;
+        break;
+    case '^':
+        result.lo = a.lo ^ b.lo;
+        result.hi = a.hi ^ b.hi;
+        break;
+    default:
+        result.lo = ~(a.lo | b.lo);
+        result.hi = ~(a.hi | b.hi);
+        break;
+    }
+
+    return result;
+}
+
+static tx79_qword ref_pcpyh(tx79_qword a)
+{
+    uint64_t lo = a.lo & 0xffff;
+    uint64_t hi = a.hi & 0xffff;
+    tx79_qword result = {
+        lo * 0x0001000100010001ULL,
+        hi * 0x0001000100010001ULL,
+    };
+
+    return result;
+}
+
+static tx79_qword ref_prot3w(tx79_qword a)
+{
+    tx79_qword result = {
+        (a.lo >> 32) | ((a.hi & 0xffffffff) << 32),
+        (a.lo & 0xffffffff) | (a.hi & 0xffffffff00000000ULL),
+    };
+
+    return result;
+}
+
+static void tx79_set_hilo1(uint64_t hi, uint64_t lo)
+{
+    asm volatile(
+        "move $8, %[lo]\n"
+        ".word " TX79_STR(TX79_R(8, 0, 0, 0, 0x13)) "\n"
+        "move $8, %[hi]\n"
+        ".word " TX79_STR(TX79_R(8, 0, 0, 0, 0x11)) "\n"
+        :
+        : [lo] "r" (lo), [hi] "r" (hi)
+        : "$8");
+}
+
+static tx79_qword tx79_get_hilo1(void)
+{
+    tx79_qword result;
+
+    asm volatile(
+        ".word " TX79_STR(TX79_R(0, 0, 8, 0, 0x12)) "\n"
+        "move %[lo], $8\n"
+        ".word " TX79_STR(TX79_R(0, 0, 8, 0, 0x10)) "\n"
+        "move %[hi], $8\n"
+        : [lo] "=r" (result.lo), [hi] "=r" (result.hi)
+        :
+        : "$8");
+
+    return result;
+}
+
+static int test_hilo1(void)
+{
+    const uint64_t hi = 0x8899aabbccddeeffULL;
+    const uint64_t lo = 0x0011223344556677ULL;
+    tx79_qword got;
+
+    tx79_set_hilo1(hi, lo);
+    got = tx79_get_hilo1();
+    if (got.lo != lo || got.hi != hi) {
+        fprintf(stderr, "HI1/LO1 move instructions failed\n");
+        return 1;
+    }
+
+    return 0;
+}
+
+static int test_parallel(void)
+{
+    const tx79_qword a = {
+        0x800000007fffffffULL,
+        0xff0080007fff8000ULL,
+    };
+    const tx79_qword b = {
+        0x00000000ffffffffULL,
+        0x01008000ffff0001ULL,
+    };
+    tx79_qword got;
+
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 9, 8), &a, &b);
+    if (check_qword("PSUBB", got, ref_sub(a, b, 8))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 5, 8), &a, &b);
+    if (check_qword("PSUBH", got, ref_sub(a, b, 16))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 1, 8), &a, &b);
+    if (check_qword("PSUBW", got, ref_sub(a, b, 32))) {
+        return 1;
+    }
+
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 2, 8), &a, &b);
+    if (check_qword("PCGTW", got, ref_compare(a, b, 32, 0))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 6, 8), &a, &b);
+    if (check_qword("PCGTH", got, ref_compare(a, b, 16, 0))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 10, 8), &a, &b);
+    if (check_qword("PCGTB", got, ref_compare(a, b, 8, 0))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 2, 40), &a, &b);
+    if (check_qword("PCEQW", got, ref_compare(a, b, 32, 1))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 6, 40), &a, &b);
+    if (check_qword("PCEQH", got, ref_compare(a, b, 16, 1))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 10, 40), &a, &b);
+    if (check_qword("PCEQB", got, ref_compare(a, b, 8, 1))) {
+        return 1;
+    }
+
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 8), &a, &b);
+    if (check_qword("PEXTLW", got, ref_pext(a, b, 32, 0))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 22, 8), &a, &b);
+    if (check_qword("PEXTLH", got, ref_pext(a, b, 16, 0))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 26, 8), &a, &b);
+    if (check_qword("PEXTLB", got, ref_pext(a, b, 8, 0))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 40), &a, &b);
+    if (check_qword("PEXTUW", got, ref_pext(a, b, 32, 1))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 19, 8), &a, &b);
+    if (check_qword("PPACW", got, (tx79_qword) {
+            (uint32_t)b.lo | ((uint64_t)(uint32_t)b.hi << 32),
+            (uint32_t)a.lo | ((uint64_t)(uint32_t)a.hi << 32),
+        })) {
+        return 1;
+    }
+
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 9), &a, &b);
+    if (check_qword("PAND", got, ref_logic(a, b, '&'))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 19, 9), &a, &b);
+    if (check_qword("PXOR", got, ref_logic(a, b, '^'))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 41), &a, &b);
+    if (check_qword("POR", got, ref_logic(a, b, '|'))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 19, 41), &a, &b);
+    if (check_qword("PNOR", got, ref_logic(a, b, 'n'))) {
+        return 1;
+    }
+
+    got = TX79_UNARY_WORD(TX79_R(0, 8, 10, 27, 41), &a);
+    if (check_qword("PCPYH", got, ref_pcpyh(a))) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 14, 9), &a, &b);
+    if (check_qword("PCPYLD", got, (tx79_qword) { b.lo, a.lo })) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 14, 41), &a, &b);
+    if (check_qword("PCPYUD", got, (tx79_qword) { a.hi, b.hi })) {
+        return 1;
+    }
+    got = TX79_UNARY_WORD(TX79_R(0, 8, 10, 31, 9), &a);
+    if (check_qword("PROT3W", got, ref_prot3w(a))) {
+        return 1;
+    }
+
+    got = TX79_BINOP_WORD(TX79_R(0, 9, 10, 14, 9), &a, &b);
+    if (check_qword("PCPYLD rt-only", got, (tx79_qword) { b.lo, 0 })) {
+        return 1;
+    }
+    got = TX79_BINOP_WORD(TX79_R(8, 0, 10, 14, 41), &a, &b);
+    if (check_qword("PCPYUD rs-only", got, (tx79_qword) { a.hi, 0 })) {
+        return 1;
+    }
+    got = TX79_UNARY_WORD(TX79_R(0, 0, 10, 27, 41), &a);
+    if (check_qword("PCPYH zero", got, (tx79_qword) { 0, 0 })) {
+        return 1;
+    }
+
+    got = TX79_BINOP_WORD(TX79_R(8, 9, 0, 1, 8), &a, &b);
+    if (check_qword("rd zero", got, (tx79_qword) {
+            a.lo, a.hi,
+        })) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static int test_quadword_memory(void)
+{
+    static uint8_t memory[65536 + 64] __attribute__((aligned(16)));
+    static const int offsets[] = { -32768, -1, 0, 1, 32767 };
+    const tx79_qword value = {
+        0x0123456789abcdefULL,
+        0xfedcba9876543210ULL,
+    };
+    uint8_t *base = memory + 32784;
+
+    for (unsigned i = 0; i < sizeof(offsets) / sizeof(offsets[0]); i++) {
+        int offset = offsets[i];
+        uintptr_t address = (uintptr_t)base + (intptr_t)offset;
+        uint8_t *aligned = (uint8_t *)(address & ~(uintptr_t)0xf);
+        tx79_qword got;
+
+        memset(memory, 0, sizeof(memory));
+        memcpy(aligned, &value, sizeof(value));
+        switch (offset) {
+        case -32768:
+            got = TX79_LQ_OFFSET(-32768, base);
+            break;
+        case -1:
+            got = TX79_LQ_OFFSET(-1, base);
+            break;
+        case 0:
+            got = TX79_LQ_OFFSET(0, base);
+            break;
+        case 1:
+            got = TX79_LQ_OFFSET(1, base);
+            break;
+        default:
+            got = TX79_LQ_OFFSET(32767, base);
+            break;
+        }
+        if (check_qword("LQ offset", got, value)) {
+            return 1;
+        }
+
+        memset(memory, 0, sizeof(memory));
+        switch (offset) {
+        case -32768:
+            TX79_SQ_OFFSET(-32768, &value, base);
+            break;
+        case -1:
+            TX79_SQ_OFFSET(-1, &value, base);
+            break;
+        case 0:
+            TX79_SQ_OFFSET(0, &value, base);
+            break;
+        case 1:
+            TX79_SQ_OFFSET(1, &value, base);
+            break;
+        default:
+            TX79_SQ_OFFSET(32767, &value, base);
+            break;
+        }
+        if (memcmp(aligned, &value, sizeof(value)) != 0) {
+            fprintf(stderr, "SQ offset %d failed\n", offset);
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+int main(void)
+{
+    if (test_hilo1() || test_parallel() || test_quadword_memory()) {
+        return 1;
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/mips64el/system/meson.build b/tests/tcg/mips64el/system/meson.build
index fd5a759c20fa..66c3d61c3134 100644
--- a/tests/tcg/mips64el/system/meson.build
+++ b/tests/tcg/mips64el/system/meson.build
@@ -39,6 +39,15 @@ foreach t: [
   }
 endforeach
 
+# n32: 32-bit pointers, 64-bit GPRs are needed to move 64-bit values to HI1/LO1
+tests += {
+  'test_r5900_tx79.c': {
+    'cflags': cflags + ['-mabi=n32'],
+    'qemu_args': qemu_args,
+    'gdb_test': gdb_test,
+  }
+}
+
 if 'qemu-system-mips64el' in emulators
   tcg_tests += {
     'mips64el-softmmu': {
-- 
2.55.0


