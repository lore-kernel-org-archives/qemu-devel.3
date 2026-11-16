Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B188606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOAhUO1I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iViklbaQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63v-0003hb-MZ; Mon, 16 Nov 2026 18:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63q-0003Tm-HY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63o-0003L6-1u
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:30 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfa1c2590429
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MhNRwx/QiNiEsCAqBhBXK9GcoPunZ5iN0Mnu8YrekKg=; b=TOAhUO1IlWm4Z9tm
 c7q08yWOOrsTeV6B9vhX63EHwMA4wfrxKmUloHRHroWNsjxAGnnWx+LEiumb6smK
 78usuLOuUDAmxHxs363689pfwht8WfNSgoPacM5o64KJ/IOge8c4+DxYtvGdbNyb
 zuJpU2VkeWD+rz+3v6mNjJmGvfEAgMxxw2hyaz0m54zMJg0hWq0/HIvNjTWDJ1z/
 gmnjwjfT50HdQemyzJiiNf6PwZPbcXHpqmd7o4DxPZ0GMLXiZvUGPHmVV/kc24LW
 CkmJOVV9rTG6NW22ZloUXyEJb5RBgPOEnPU1rrVKGTpM7y4+ocTz7RDydDJgoFDW
 B/HGnQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k8a6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-990c957f129so244680241.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871466; x=1795476266; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MhNRwx/QiNiEsCAqBhBXK9GcoPunZ5iN0Mnu8YrekKg=;
 b=iViklbaQ74Xx+Iq0Ab3ROxbLQcD3FR1ypJPsnV6+ws+ervDs/GULca02Ubvzeapk9T
 Bzer8YswSZosLFiJCTwBdfxMRTiPTZFAweMW8OKZqFi7nO3tIRhBCNJ+ccgpxlNhVA0o
 Nutf0yD4BNjEAoatC/nmXtNaAuX6de66ONequj7GLzAZYg5t79IO/FLWX/NkUrublhFN
 4pAow69J/Qpk80E9OFHTWhUtBRjlyO9w6tsWWQoUMVZuHvVb8S8mQoR/ISKxIAETo/wW
 +iIfwq5ATXbLJgJokOSZZhoDkvQ0GDSsjFpwjQOMv0fmDd0HAlgqXTxkqL0sZWgELaCR
 EOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871466; x=1795476266;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MhNRwx/QiNiEsCAqBhBXK9GcoPunZ5iN0Mnu8YrekKg=;
 b=NMXw/OJB+8HnaCGH1crG4458IZIzsbz3XlckFEWKDJaNM+GAg0b6+w+v+aYvn7MOL0
 AQ7mGAm7kGFShgxCBWDUPPD265gLIqpetQzKNqh+61XnCmdDbjHziPazUAb3VblLzcO4
 eDPoJ0dWJ45HvK3XYbWfFoRRoGucZ7gsHRFnbcCZuvDGUJlZl7cjxRWnIXrzLEwW9BOu
 gs4Hi731nE0uiKKQfBgPm2pKtSMxn07sblDjSIiNW4eOWbIpogSEQ/XnN9rmeo9MDnzf
 sBcoFTlT9eXjS1IcwEQsYSSqsdy4XUCew2QQgngosw/7fEFIwCGCXSR6MYUVctdWsIiZ
 r5hQ==
X-Gm-Message-State: APuU4Z9bzO8Y/GvB7Mgb3Uh6shw3V1+6Ejwp3s8tLdcSglgr0kXLxjuc
 6JkuIoX3Cntuin/W+0qPBLxCukj+ojOOWtWVGDMV2RWYfW21YRLAPGcemaYlfouZoY7KEpF/Uwu
 8uV1aa7tfMlBVEsXKDvu8sS+KuwuntckNY+tQ0zhMSXbFnVyB/AanSyormHbT8wmuFA==
X-Gm-Gg: AYBFou1K0IV6rFsJo+iGnyAvV/sY9oZX3Y/ZQkPYFP7hBkLvbJ7KYivTwh7DLyRDIk2
 C7oe71Dq8q5LmHg0TQkoMqbKjTzFY5s3pkmgouDpxqYSfM4ghd414bpoVlO53hirQZ+xqJ7cw9q
 bYVYZAQ231/Ukqa6XEK8KuRrkfZPpQFw1O2bZrkAQTQ2P9N4N1pFrrycN16x7LvuKABN4c5kSdG
 wq3VhAN+FAsq/suGTegU8PrgBOvEKyV3pvm7pG1UZa/tuOShMRSDiqdKJu6xKsBzpxG9gHKLnBw
 q6v40DcOkcU9zCRldDKZBIXB0i40wtQy02UCEnNuCRyfF+igJihvKpQ5E2HY3Gi6gu/i/J4NTMH
 w7oCwUNRozR6ezpXqjst9ETv27xPrSmpq7WawqDebLNTfUoPgkQrtYC7iu4Jd0rnjjeA4jv7FrE
 KTuEOrfy2bDQWE/A==
X-Received: by 2002:a05:6102:5cc1:b0:7c2:b741:2391 with SMTP id
 ada2fe7eead31-7d69f80fb58mr292781137.30.1794871465640; 
 Mon, 16 Nov 2026 15:24:25 -0800 (PST)
X-Received: by 2002:a05:6102:5cc1:b0:7c2:b741:2391 with SMTP id
 ada2fe7eead31-7d69f80fb58mr292776137.30.1794871464963; 
 Mon, 16 Nov 2026 15:24:24 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78346f4asm21523635e9.0.2026.11.16.15.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/22] tests/tcg/aarch64: Add vector immediate regression tests
Date: Tue, 17 Nov 2026 00:23:19 +0100
Message-ID: <20261116232335.31593-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb90aa cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GbGmGPNHq4wrv3Bv-ccA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXxv5+EdafQd7W
 zDFDgJ9EeKv3/FkIW1pp8irmuqeR8QmGRVgPfm2+Cx3nrhhEnIj0gUTfbLZ9QV79uftp56lGpfK
 e0qAIkM4OsK73hKsnbaS4JgltzZ4lk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX/0668QfD8shV
 JM1WF+1WCJ6NxCObSIRmDrywNjTvoKDPCOpCK3gi2n1x60vloOxX8ffHwLKL4xhbGHWzcBI7DL1
 KiJmTK3RpkSSJWCxbc9cobk67tg2G1/ZKj/ht7gc5z2lAMvTglzIuyz79rA68Nz2N/OFjCrF2ce
 /DTu+OvSnmgHriE65IkC4cvOu7oEUp6WUlVLfHdcDqmYX6HSOAOktY+7XwbDwkmZVNJI6kUAadd
 k+ozZSNk0Cc4B/2/Ss1e7dpbGRz5ri2en9vzXH+3TrZlgY56QcLpT5UNBwdsENE0EokhRC24z5b
 gVhYfl0YeveVHjxTbkH7FARITE4GJuICjKHwlQdDdIi+CXhZ1yBKoRC2c3V58I3eYYGw7BPVUoG
 0whb1yM90dQS1Y+vicpc/Tk+nYnUOSyF4qLGfqZYcXVGTZUR9TKQglMkeE/JF4N/2JC4e14Ox4X
 /f+/mX6lw5xlH/SA+Xg==
X-Proofpoint-GUID: ts7IqrtbicA75gR85BIlpu8RRnEcPGQb
X-Proofpoint-ORIG-GUID: ts7IqrtbicA75gR85BIlpu8RRnEcPGQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

Run SVE/AdvSIMD immediate operations after an operation
of another element size, at every SVE vector length,
against scalar references.

Catches backends encoding the replicated constant or
using a stale element size, as tcg/riscv64 did.

AI-used-for: Regression tests
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261028143330.6518-7-philmd@oss.qualcomm.com>
---
 tests/tcg/aarch64/sve-vec-imm.c | 233 ++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/meson.build   |   1 +
 2 files changed, 234 insertions(+)
 create mode 100644 tests/tcg/aarch64/sve-vec-imm.c

diff --git a/tests/tcg/aarch64/sve-vec-imm.c b/tests/tcg/aarch64/sve-vec-imm.c
new file mode 100644
index 000000000000..62391824946b
--- /dev/null
+++ b/tests/tcg/aarch64/sve-vec-imm.c
@@ -0,0 +1,233 @@
+/*
+ * Vector operations with immediates, at every SVE vector length.
+ *
+ * Each case first runs an operation with a given element size, then
+ * an operation with an immediate at another element size, within the
+ * same TB.  This catches TCG backends that encode the immediate from
+ * the whole replicated constant, or apply it at a stale element size.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/prctl.h>
+
+#define MAXVL 256
+
+static uint8_t in[MAXVL], out[MAXVL];
+
+typedef void test_fn(void);
+typedef uint64_t ref_fn(uint64_t x);
+
+#define TEST(NAME, SETUP, OP)                                       \
+static void NAME(void)                                              \
+{                                                                   \
+    asm volatile("ldr z0, [%0]\n\t"                                 \
+                 "ldr z1, [%0]\n\t"                                 \
+                 "mov z2.d, #0\n\t"                                 \
+                 SETUP "\n\t"                                       \
+                 OP "\n\t"                                          \
+                 "str z0, [%1]"                                     \
+                 : : "r"(in), "r"(out) : "z0", "z1", "z2", "memory"); \
+}
+
+#define SET_B  "add z1.b, z1.b, z1.b"
+#define SET_D  "add z1.d, z1.d, z1.d"
+
+static int64_t sext(uint64_t x, int bits)
+{
+    return (int64_t)(x << (64 - bits)) >> (64 - bits);
+}
+
+static uint64_t sat_s(int64_t x, int bits)
+{
+    int64_t max = (1ll << (bits - 1)) - 1;
+    return x > max ? max : x < -max - 1 ? -max - 1 : x;
+}
+
+static uint64_t sat_u(int64_t x, int bits)
+{
+    int64_t max = (1ll << bits) - 1;
+    return x > max ? max : x < 0 ? 0 : x;
+}
+
+static uint64_t ror(uint64_t x, int n, int bits)
+{
+    uint64_t m = bits == 64 ? -1ull : (1ull << bits) - 1;
+    return ((x >> n) | (x << (bits - n))) & m;
+}
+
+/* Arithmetic immediates (add_vec, sub_vec, saturating ops). */
+TEST(add_b5, SET_D, "add z0.b, z0.b, #5")
+static uint64_t r_add_b5(uint64_t x) { return x + 5; }
+TEST(add_h3, SET_B, "add z0.h, z0.h, #3")
+static uint64_t r_add_h3(uint64_t x) { return x + 3; }
+TEST(sub_s7, SET_B, "sub z0.s, z0.s, #7")
+static uint64_t r_sub_s7(uint64_t x) { return x - 7; }
+TEST(subr_h3, SET_B, "subr z0.h, z0.h, #3")
+static uint64_t r_subr_h3(uint64_t x) { return 3 - x; }
+TEST(sqadd_b3, SET_D, "sqadd z0.b, z0.b, #3")
+static uint64_t r_sqadd_b3(uint64_t x) { return sat_s(sext(x, 8) + 3, 8); }
+TEST(uqadd_h9, SET_B, "uqadd z0.h, z0.h, #9")
+static uint64_t r_uqadd_h9(uint64_t x) { return sat_u(x + 9, 16); }
+TEST(sqsub_s4, SET_B, "sqsub z0.s, z0.s, #4")
+static uint64_t r_sqsub_s4(uint64_t x) { return sat_s(sext(x, 32) - 4, 32); }
+TEST(uqsub_s2, SET_B, "uqsub z0.s, z0.s, #2")
+static uint64_t r_uqsub_s2(uint64_t x) { return sat_u((int64_t)x - 2, 32); }
+
+/* Logical immediates (and_vec, or_vec, xor_vec). */
+TEST(and_d_f, SET_B, "and z0.d, z0.d, #0xf")
+static uint64_t r_and_f(uint64_t x) { return x & 0xf; }
+TEST(and_b_f, SET_D, "and z0.b, z0.b, #0xf")
+TEST(orr_d_m16, SET_B, "orr z0.d, z0.d, #0xfffffffffffffff0")
+static uint64_t r_orr_m16(uint64_t x) { return x | -16ull; }
+TEST(eor_b_f, SET_D, "eor z0.b, z0.b, #0xf")
+static uint64_t r_eor_f(uint64_t x) { return x ^ 0xf; }
+TEST(orr_h_f, SET_D, "orr z0.h, z0.h, #0xf")
+static uint64_t r_orr_f(uint64_t x) { return x | 0xf; }
+TEST(eor_s_1, SET_B, "eor z0.s, z0.s, #0x1")
+static uint64_t r_eor_1(uint64_t x) { return x ^ 1; }
+
+/* Shift immediates, including counts above 15 and 31. */
+TEST(lsl_d40, SET_B, "lsl z0.d, z0.d, #40")
+static uint64_t r_lsl_d40(uint64_t x) { return x << 40; }
+TEST(asr_d63, SET_B, "asr z0.d, z0.d, #63")
+static uint64_t r_asr_d63(uint64_t x) { return sext(x, 64) >> 63; }
+TEST(lsr_s20, SET_D, "lsr z0.s, z0.s, #20")
+static uint64_t r_lsr_s20(uint64_t x) { return x >> 20; }
+TEST(lsl_s31, SET_D, "lsl z0.s, z0.s, #31")
+static uint64_t r_lsl_s31(uint64_t x) { return x << 31; }
+TEST(asr_h15, SET_D, "asr z0.h, z0.h, #15")
+static uint64_t r_asr_h15(uint64_t x) { return sext(x, 16) >> 15; }
+TEST(xar_d40, SET_B, "xar z0.d, z0.d, z2.d, #40")
+static uint64_t r_xar_d40(uint64_t x) { return ror(x, 40, 64); }
+TEST(xar_s20, SET_D, "xar z0.s, z0.s, z2.s, #20")
+static uint64_t r_xar_s20(uint64_t x) { return ror(x, 20, 32); }
+
+/* Compare with zero (cmp_vec), including the adjusted LT/GE forms. */
+TEST(cmeq_h0, SET_B, "cmeq v0.8h, v0.8h, #0")
+static uint64_t r_cmeq0(uint64_t x) { return x == 0 ? -1ull : 0; }
+TEST(cmgt_b0, SET_D, "cmgt v0.16b, v0.16b, #0")
+static uint64_t r_cmgt_b0(uint64_t x) { return sext(x, 8) > 0 ? -1ull : 0; }
+TEST(cmlt_b0, SET_D, "cmlt v0.16b, v0.16b, #0")
+static uint64_t r_cmlt_b0(uint64_t x) { return sext(x, 8) < 0 ? -1ull : 0; }
+TEST(cmlt_h0, SET_B, "cmlt v0.8h, v0.8h, #0")
+static uint64_t r_cmlt_h0(uint64_t x) { return sext(x, 16) < 0 ? -1ull : 0; }
+TEST(cmge_s0, SET_B, "cmge v0.4s, v0.4s, #0")
+static uint64_t r_cmge_s0(uint64_t x) { return sext(x, 32) >= 0 ? -1ull : 0; }
+TEST(cmle_d0, SET_B, "cmle v0.2d, v0.2d, #0")
+static uint64_t r_cmle_d0(uint64_t x) { return sext(x, 64) <= 0 ? -1ull : 0; }
+
+/* Vector constants (dupi_vec): vmv.v.i, 0/-1, and wide immediates. */
+TEST(movi_s5, SET_B, "movi v0.4s, #5")
+static uint64_t r_5(uint64_t x) { return 5; }
+TEST(movi_h99, SET_D, "movi v0.8h, #0x99")
+static uint64_t r_99(uint64_t x) { return 0x99; }
+TEST(movi_d_mask, SET_B, "movi v0.2d, #0xff00ff00ff00ff00")
+static uint64_t r_mask(uint64_t x) { return 0xff00ff00ff00ff00ull; }
+TEST(mvni_s0, SET_D, "mvni v0.4s, #0")
+static uint64_t r_m1(uint64_t x) { return -1ull; }
+
+static const struct {
+    const char *name;
+    test_fn *fn;
+    ref_fn *ref;
+    int esz;        /* element size in bytes */
+    int neon;       /* AdvSIMD op: only the low 16 bytes, rest zeroed */
+} tests[] = {
+    { "add .d; add .b, #5", add_b5, r_add_b5, 1 },
+    { "add .b; add .h, #3", add_h3, r_add_h3, 2 },
+    { "add .b; sub .s, #7", sub_s7, r_sub_s7, 4 },
+    { "add .b; subr .h, #3", subr_h3, r_subr_h3, 2 },
+    { "add .d; sqadd .b, #3", sqadd_b3, r_sqadd_b3, 1 },
+    { "add .b; uqadd .h, #9", uqadd_h9, r_uqadd_h9, 2 },
+    { "add .b; sqsub .s, #4", sqsub_s4, r_sqsub_s4, 4 },
+    { "add .b; uqsub .s, #2", uqsub_s2, r_uqsub_s2, 4 },
+
+    { "add .b; and .d, #0xf", and_d_f, r_and_f, 8 },
+    { "add .d; and .b, #0xf", and_b_f, r_and_f, 1 },
+    { "add .b; orr .d, #-16", orr_d_m16, r_orr_m16, 8 },
+    { "add .d; eor .b, #0xf", eor_b_f, r_eor_f, 1 },
+    { "add .d; orr .h, #0xf", orr_h_f, r_orr_f, 2 },
+    { "add .b; eor .s, #1", eor_s_1, r_eor_1, 4 },
+
+    { "add .b; lsl .d, #40", lsl_d40, r_lsl_d40, 8 },
+    { "add .b; asr .d, #63", asr_d63, r_asr_d63, 8 },
+    { "add .d; lsr .s, #20", lsr_s20, r_lsr_s20, 4 },
+    { "add .d; lsl .s, #31", lsl_s31, r_lsl_s31, 4 },
+    { "add .d; asr .h, #15", asr_h15, r_asr_h15, 2 },
+    { "add .b; xar .d, #40", xar_d40, r_xar_d40, 8 },
+    { "add .d; xar .s, #20", xar_s20, r_xar_s20, 4 },
+
+    { "add .b; cmeq .8h, #0", cmeq_h0, r_cmeq0, 2, 1 },
+    { "add .d; cmgt .16b, #0", cmgt_b0, r_cmgt_b0, 1, 1 },
+    { "add .d; cmlt .16b, #0", cmlt_b0, r_cmlt_b0, 1, 1 },
+    { "add .b; cmlt .8h, #0", cmlt_h0, r_cmlt_h0, 2, 1 },
+    { "add .b; cmge .4s, #0", cmge_s0, r_cmge_s0, 4, 1 },
+    { "add .b; cmle .2d, #0", cmle_d0, r_cmle_d0, 8, 1 },
+
+    { "add .b; movi .4s, #5", movi_s5, r_5, 4, 1 },
+    { "add .d; movi .8h, #0x99", movi_h99, r_99, 2, 1 },
+    { "add .b; movi .2d, #0xff00...", movi_d_mask, r_mask, 8, 1 },
+    { "add .d; mvni .4s, #0", mvni_s0, r_m1, 4, 1 },
+};
+
+static int check(int vl, int t)
+{
+    int esz = tests[t].esz;
+    int n = tests[t].neon ? 16 : vl;
+    uint64_t mask = esz == 8 ? -1ull : (1ull << (esz * 8)) - 1;
+
+    for (int i = 0; i < vl; i += esz) {
+        uint64_t x = 0, got = 0, exp = 0;
+
+        memcpy(&x, in + i, esz);
+        memcpy(&got, out + i, esz);
+        if (i < n) {
+            exp = tests[t].ref(x) & mask;
+        }
+        if (got != exp) {
+            fprintf(stderr, "vl %d: %s: byte %d: got 0x%llx, "
+                    "expected 0x%llx\n", vl, tests[t].name, i,
+                    (unsigned long long)got, (unsigned long long)exp);
+            return 1;
+        }
+    }
+    return 0;
+}
+
+int main(void)
+{
+    int err = 0, nvl = 0;
+
+    for (int i = 0; i < MAXVL; i++) {
+        in[i] = 0xa5 ^ (i * 0x37);
+    }
+    /* Zero, saturating and sign-boundary elements in the low 16 bytes. */
+    in[0] = 0x7e;                       /* sqadd .b overflow */
+    in[2] = in[3] = 0;                  /* cmeq .h, zero */
+    in[8] = 1;                          /* uqsub .s underflow */
+    in[9] = in[10] = in[11] = 0;
+    in[12] = 0xfa; in[13] = 0xff;       /* uqadd .h overflow */
+
+    for (int vl = 16; vl <= MAXVL; vl *= 2) {
+        if (prctl(PR_SVE_SET_VL, vl, 0, 0, 0, 0) != vl) {
+            continue;
+        }
+        nvl++;
+        for (int t = 0; t < sizeof(tests) / sizeof(tests[0]); t++) {
+            memset(out, 0xee, sizeof(out));
+            tests[t].fn();
+            err |= check(vl, t);
+        }
+    }
+    if (nvl == 0) {
+        fprintf(stderr, "no SVE vector length available\n");
+        return 1;
+    }
+    return err;
+}
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 52eb67ae6ace..2033356e3625 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -145,6 +145,7 @@ tests += {
 tests += {
   'test-826.c': {'cc_feat': 'sve2'},
   'sve-while-ptr.c': {'cc_feat': 'sve2'},
+  'sve-vec-imm.c': {'cc_feat': 'sve2'},
 }
 
 # FPRCVT test
-- 
2.55.0


