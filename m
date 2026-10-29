Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB9606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V99AFfUB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F1/c0Xo0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtw-0000VY-U8; Thu, 29 Oct 2026 13:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtN-0008KZ-EL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtL-0001VA-4m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDIgL1654937
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uQGJcj4fYDSURYCUE/Jx2v7bzNMyhyp4amRFAmz9cJA=; b=V99AFfUB7p7nN7sr
 +gBR3vntbNr15Q/YQj8nfg+lPHQ2gQGYI9r5yrjmkiZjxeNDPmZA4LeQ/a6j3Yjw
 Ou9pc6g9TxnKds0ifpuObyjMSlHNmW00cLeoREUAO5O2ayeDuhfTpqGcyX3Skv1r
 xr5PBVWYFuHVYRn82Yzwek4i9Xa4Rs8O0eCZ2Iy8Wb/Smlv6CxiUDDS/Lx+FNTdg
 nLPAJL5RDHlShPaPpeVBS1oPxbig5oHf88VvsuZWbslyz5vq78zfTY9XTBgjxW/2
 izV/NzBTmM5l0xcb6WwfzkMflr0Wbd0G8bz2aEUATfog7BCMSKKL0r8fQ3U+foXN
 N97+5A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a21srs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:17 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so2078469241.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294776; x=1793899576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uQGJcj4fYDSURYCUE/Jx2v7bzNMyhyp4amRFAmz9cJA=;
 b=F1/c0Xo0UlHe7poukSuX84j+XWsuwuiClua5u4TXu+skC5lS1vhpF4F2nsmmlYLz1n
 XaMab4yjzgXUZUq9XLGPYrdWRdcthQUtW9ZCEcqevj60nmU9IhQwIkGnwU8KjFp2n/QF
 pPjo2xo9CayaIm03f6BxV9E0VJ6HHTcec+8KYheh1wz36wbCoKl6afR9q9coGWVCEdFK
 Itbl1saB+kYQuz324WyBrjrT2NuvYm1yJNnlyVLyXkAG6bEESOWqm2IwUa86ou0uuKW9
 p1W4yHWDkZMfK92vRLeGpuKJbmVM4jjzLCzXsYg4Ug0ZbjD3d+FA1/uytARQTr22NiF6
 JVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294776; x=1793899576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uQGJcj4fYDSURYCUE/Jx2v7bzNMyhyp4amRFAmz9cJA=;
 b=eGHu8FOpbhiClyGbuzE/KfLlzgP6KKzu/AYI4dq+MHAuqVLLBf5TyXQvEHxzvGy3Ph
 i78euKfLDeLZ16Sqt6AuxbylbPToH4igiav87+zdATYl3oWJ5GpYAGZyIMf+blWBeCOu
 ub222Gk0vePw1kIHcnBJfCsS8jb0LaRVzOI87rkle9Hsc6jfXH2LiA5sABXnmSCSZG0s
 TUy1DPq4bNXh3rOhV97WVSW06IPC+Ep/yygmy6eDHk3QqV4bNfrF/wM4oJK4B5O0Ochd
 OZ0Ff4p/OCHQAt+Z5Rm12L4zDKYPOCYTnyEygVohEfp1GvfO3AOSvfo4z0J6RaYzJmHw
 Rf5w==
X-Gm-Message-State: AFq9FYJneVVkWlquOEZiEUgLZaRIkYhIIa4FivkfqMXMkQLzoVaTdbFQ
 Gut8151XcPfzu8VBuQ3Q4lTd/LSxl+0yMLBP3ntwjkS9JoDqmcPVDdxwOoTe5yr0fYaXJTa/uM2
 S+bQH36H77CejCYHzjKflTbRAa6A0XW034qZZtz4s0SvxFpvud802PtGkMtyrdgtVuDq0
X-Gm-Gg: AYBFou33NvxgymU57ku5ODnYUH3LAWyV5kOKJ+ftxSA2zwFD6xKgpWVpZ+UKFqqXT3C
 54PGQkMCW6kveQi6wj3ZCJwNbScQ2fmb8AzSP8tsvY605BKpLCRJaHpfCa2jOEv5Gc9XHIBl45P
 jjfC6vzyUS99NS8MKU/Mpcku7yuBNMcfUOcbH+F/zkgIjn5p+6eFF2B6XOdyq/u8Z5qwJhDTRrH
 WHj8ke9PwEk47I33vAuBjl71g/n2JRUxUq1tfm8mwrNsLzeDlAa6AHXRviDOIfLkSFnc2b6RGrO
 0e8yzZdEehfxNKF0LfZSm63xtQbiH6oQM2g3o6Zjg6BAfi/7P6Ry5K6q/bhrOAlKh1MD8B9XquA
 5tA8MDSpZ/rqFpK1q9giZa2DyCUmJZuyBUIDXkjpWxEixzfQaaLK2eHrPkQXxSr9Wnb2d+D+CHA
 iL5XggupxWGY4sfbkoJOrahomSuVi+Mw==
X-Received: by 2002:a05:6102:418c:b0:7cc:56a:58d2 with SMTP id
 ada2fe7eead31-7d03a541676mr3187209137.31.1793294776110; 
 Thu, 29 Oct 2026 10:26:16 -0700 (PDT)
X-Received: by 2002:a05:6102:418c:b0:7cc:56a:58d2 with SMTP id
 ada2fe7eead31-7d03a541676mr3187193137.31.1793294775645; 
 Thu, 29 Oct 2026 10:26:15 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0610sm479598f8f.31.2026.10.29.10.26.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 24/31] tests/tcg/mips: Group MSA int-max-min tests
Date: Thu, 29 Oct 2026 18:23:08 +0100
Message-ID: <20261029172319.25766-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2KQ0ejyjNlhQ
 FJwqqZU2kWP8A4BVCd8H3PH01ZXdBqo+By9bK9CtIzPhXCc0eR8hmfEdhmHMOUoNWTSq39jP1IZ
 dTcmLD/51/qpdzyPg6Uh5lfb4u+bqD0IX4ytWBj1gtss7ZBvcdGJyp+RKh5jIAQYP7R+cile3Ij
 AT/wbhkZAMEcsKqPniFJP8PK93dE7An2QwXawueuCqf8qkujoyiMAvm/f8IK1SOwXI3J0WOaRpx
 t02Wtw/iUuotvRXCb9sVYY6oS38rlBH0Wjs7Z8zjUO9lybSXLj/jRpMFQ09rwIw/iEe3uRgH1RL
 TDT3/joIt3ZUoQ86xnGmxGzzDsdsj+ky+ilrJ1ew816976IrQKFmnPGJej3K9eac71PG3W/A5g2
 Vg1frGVZa1vC+FbVqNDcH9dDECrcrVYDBhgS6RWJHe6a5wJmnpqyk1mFlRS8MxZ590q8bFcxC6d
 +oungXi3DMR9RSgRY+g==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae381b9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xSJLvnGiI23x1uoAYFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX35RKbpgUUuSt
 1Jn+uBHJVSwOCisCKJS3MsbRk2r0uxNqTnprtuGC+xm8gsiWFkBAvgzSyoePFYeQ3YoI6SVgXFj
 LobUW2jxVnApYEptPuORPQLCUCP5Lvs=
X-Proofpoint-ORIG-GUID: KvaGYSx1A9syo5BDCkAmbvNbgeYTNsaL
X-Proofpoint-GUID: KvaGYSx1A9syo5BDCkAmbvNbgeYTNsaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
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

Build the 24 per-opcode int-max-min tests as a single executable,
test_msa_int_max_min.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_max_min.c | 175 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  24 ----
 tests/tcg/mips64/meson.build          |   1 +
 tests/tcg/mipsel/meson.build          |   1 +
 4 files changed, 177 insertions(+), 24 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_max_min.c

diff --git a/tests/tcg/mips/test_msa_int_max_min.c b/tests/tcg/mips/test_msa_int_max_min.c
new file mode 100644
index 000000000000..aca44867e872
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_max_min.c
@@ -0,0 +1,175 @@
+/*
+ * MIPS MSA tests: Int Min / Max instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_max_a_b
+#include "user/ase/msa/int-max-min/test_msa_max_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_d
+#include "user/ase/msa/int-max-min/test_msa_max_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_h
+#include "user/ase/msa/int-max-min/test_msa_max_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_w
+#include "user/ase/msa/int-max-min/test_msa_max_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_b
+#include "user/ase/msa/int-max-min/test_msa_max_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_d
+#include "user/ase/msa/int-max-min/test_msa_max_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_h
+#include "user/ase/msa/int-max-min/test_msa_max_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_w
+#include "user/ase/msa/int-max-min/test_msa_max_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_b
+#include "user/ase/msa/int-max-min/test_msa_max_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_d
+#include "user/ase/msa/int-max-min/test_msa_max_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_h
+#include "user/ase/msa/int-max-min/test_msa_max_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_w
+#include "user/ase/msa/int-max-min/test_msa_max_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_b
+#include "user/ase/msa/int-max-min/test_msa_min_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_d
+#include "user/ase/msa/int-max-min/test_msa_min_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_h
+#include "user/ase/msa/int-max-min/test_msa_min_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_w
+#include "user/ase/msa/int-max-min/test_msa_min_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_b
+#include "user/ase/msa/int-max-min/test_msa_min_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_d
+#include "user/ase/msa/int-max-min/test_msa_min_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_h
+#include "user/ase/msa/int-max-min/test_msa_min_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_w
+#include "user/ase/msa/int-max-min/test_msa_min_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_b
+#include "user/ase/msa/int-max-min/test_msa_min_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_d
+#include "user/ase/msa/int-max-min/test_msa_min_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_h
+#include "user/ase/msa/int-max-min/test_msa_min_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_w
+#include "user/ase/msa/int-max-min/test_msa_min_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "max.a.b", test_msa_max_a_b },
+    { "max.a.d", test_msa_max_a_d },
+    { "max.a.h", test_msa_max_a_h },
+    { "max.a.w", test_msa_max_a_w },
+    { "max.s.b", test_msa_max_s_b },
+    { "max.s.d", test_msa_max_s_d },
+    { "max.s.h", test_msa_max_s_h },
+    { "max.s.w", test_msa_max_s_w },
+    { "max.u.b", test_msa_max_u_b },
+    { "max.u.d", test_msa_max_u_d },
+    { "max.u.h", test_msa_max_u_h },
+    { "max.u.w", test_msa_max_u_w },
+    { "min.a.b", test_msa_min_a_b },
+    { "min.a.d", test_msa_min_a_d },
+    { "min.a.h", test_msa_min_a_h },
+    { "min.a.w", test_msa_min_a_w },
+    { "min.s.b", test_msa_min_s_b },
+    { "min.s.d", test_msa_min_s_d },
+    { "min.s.h", test_msa_min_s_h },
+    { "min.s.w", test_msa_min_s_w },
+    { "min.u.b", test_msa_min_u_b },
+    { "min.u.d", test_msa_min_u_d },
+    { "min.u.h", test_msa_min_u_h },
+    { "min.u.w", test_msa_min_u_w },
+};
+
+int main(void)
+{
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n"
+           "1..%u\n",
+           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        int r = msa_tests[i].fn();
+
+        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
+               "Int Max Min", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index fade579a822c..aad18213a460 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -122,28 +122,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
   '../mips/user/ase/msa/logic/test_msa_xor_v.c',
   '../mips/user/ase/msa/move/test_msa_move_v.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
 ]
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index b7daa9d0f014..41a8c22234f1 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -50,6 +50,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
+  '../mips/test_msa_int_max_min.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 7a0026075567..66041e0d191c 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -51,6 +51,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
+  '../mips/test_msa_int_max_min.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


