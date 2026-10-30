Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97A606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q3bvu53w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ag8SzxbU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAo-00039D-FH; Fri, 30 Oct 2026 11:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoA0-0002CM-LS
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9y-0007I3-N6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDD34141549
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nIdTSnbDPwBoWrYvddDmoPQ/avQDUjcefX+hHH6Ng64=; b=Q3bvu53wbQoMvZPw
 h6WJFlU87rDTsyvuGylNhNWaFLq+MhfI54DZqRrr6Epge1nOlKNAcdH3UZAqo8oT
 U8OegHo/Iqcu4p1H/hmfyLK5x1BTIhSiXrnffqW3Xdrd7doaRF/Pnzy/RJaSNqxe
 0KT5DyKW3S7QYYeoCNVhUiJnug54Jt3lBlKiFmTgL3IJ561tVosCqRB81asLijdn
 MmfWMX3QACwu0B4bSpkiBDBblAABNuB5hs2yqoCxHh3eT9vtV/vTPNKYzGGu1cjI
 RajRhzB0Ob7/Tw0hCBDN/doo1+eD2l1W9zDk8jcaqHM49f8DKNYJotBELifb+iwP
 dgq4dg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6quktg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:49 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99077a0be0bso171963241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372689; x=1793977489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nIdTSnbDPwBoWrYvddDmoPQ/avQDUjcefX+hHH6Ng64=;
 b=ag8SzxbUyEp4NPMi8xwurz2a3ZTYQsHcn3Ff+sV1Enf6H9dU4GGs5D+YQ1FG3N8nlC
 h0wDbSsa3hD6YQwR82TC+V2q/Nx59BKIS1FGBMh+/cSPpuzdDUcUOFRTVl1p4B8xx883
 2AlPx+sNZJ6lGq5eIf/UaGh4xYdlcdlySdSVJaeWdUAeUIBYEThPKr0tURnOrq1Cp55g
 97pf+kpSMLKVQg7BCT5F+pPU/wh3jnr6L52GfouBg5On41k6mmCFBch+CTW+FkVC3Ro7
 lyoA7fIpRWdo527lmiE4S7GzhRNEdou42fWXE6onvWzJ4tvDuKjiM0VmMS5Gg+5G/Pp6
 RUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372689; x=1793977489;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nIdTSnbDPwBoWrYvddDmoPQ/avQDUjcefX+hHH6Ng64=;
 b=hld/7xqXwHDNs3Hb4rDDnfOsB5kZYZOU8UqFq6b4lkOMyCuqNWew2w3ttW9NoBJE3u
 9/VPAko0MUwqoc8+NDEn7mOpMbMZT8HBP7Asx31Vodyjl+6OtMeFevaBrQWhCWDdqvZn
 i+xSgvb99PCTdo9QeM3oR223aF2ickmDv2x9YWuwk6EB32DtsQxFr7hNCtQeXL7v8Lkv
 iMFQxOKkB55sBPHHWKrhwyKGcfPPQ6PNrANiMG7TSN87rHEVGdQZbtB35FqSoY3QwN5X
 VzRV2H46MlkY4ITs8EYlRJTAw1IbLdRzS00kYJFBUC65q8CfarsywXJl8IlQ5JjcgekQ
 VeZg==
X-Gm-Message-State: AFq9FYI+97Q87KJ8vzJgnrEi6PCRAo5+s0g2ueKXdSV6vGHmPG9o1ueU
 Mt8sK6MAwY0MlyJ+0M/5tVRB4sw5iWPLFGaeZuo5mCfOBlFinSNkRjS8jJg23gDh8db1vGQvui3
 xgnLmpBzLS9uA3I3LjSPH2X3xvCJdJ3+IE6HRxj/qjPEaE6N7orlaI5p/qb9wys8ejxEB
X-Gm-Gg: AYBFou3xVSPlKSwhfQy/L/3CGPUaoQR8rmJZoezkan0spK7pFDU9zQ7aM8gMWhvQVSl
 Ma0R1q8rOM93UZT7agSUbU+HP6fOpXKCj8/rxYRbXwcU12YxMRYNTzvWzfz0xH6I75oJ59fvK6o
 HIrbeBuAY4DPh19fJ87lFkQni5HDKxBnRjxklCK0C4dXGGCG7HQgDtrTQPA4Tf7M5OsHJWw5arb
 2FZwtZ6OG/U0dHFOPkDXjNNoiERZj75tDBblT6XviD4/IuoML+ZEiQHUVsv0U4a8+UkLeIL2Ll+
 B+1KTMS0Pg+UxFh/Ny9iv5f7WbeXBDijF3FP2I1kbXrOhoV8rhbVHugJSILRIdtu+rOl4s+CKKS
 JF0otAGl28UFMFDQyzWvWPvYOxU8KUjEVyOiAQ3fmN76WFk/zn57DIRBdRStBY0+1K92BSP0N3u
 702peiP3B6cvSTi/IRizIdCfpRXfzU8Q==
X-Received: by 2002:a05:6122:512:b0:5c7:a9ee:dcfb with SMTP id
 71dfb90a1353d-5ec68718ff2mr1298207e0c.5.1793372688895; 
 Fri, 30 Oct 2026 08:04:48 -0700 (PDT)
X-Received: by 2002:a05:6122:512:b0:5c7:a9ee:dcfb with SMTP id
 71dfb90a1353d-5ec68718ff2mr1297950e0c.5.1793372686726; 
 Fri, 30 Oct 2026 08:04:46 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b77f06sm3714715f8f.21.2026.10.30.08.04.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/31] tests/tcg/mips: Group MSA int-add tests
Date: Fri, 30 Oct 2026 16:01:49 +0100
Message-ID: <20261030150202.61556-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -gyF7iyaL5NPnSrBctM47lRWBqAY02eV
X-Proofpoint-ORIG-GUID: -gyF7iyaL5NPnSrBctM47lRWBqAY02eV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXykB3D2U2mI1w
 dXcyoIxwRQwe3jXSshj6KMeNQ3RzHma2fXQe2XXapQdpbf4JJNg2eaSAy75VuFSHGUE9eOnX1W1
 Ep6GBKDfEFFvdY3dAKRkT3JK8xxCIDQbZ0anODSQKuZD657stQdYjBtQP/eVGqucSIKyqCjiMzc
 qbUK4oktoDxbHzF32wh4YCvHKJiedBuwaOD/n+3uzpkyOIAikWxwHCMuBmYxMzVgFdXOkTUXlCk
 Bk/igbvFSLU9P2DPPXe0bDttKpBMslyfjforr4Dl+FxjSh7mkjrPWgHqUANgL+VC6qlhycNQAli
 JiJphDGfNod9YbLWuUowkagptbIQI0dVB1s3vkhoe6prT49t8dvB9izPNnVYHJx5uk3/HzbfJ+v
 EntBJUBk5Lm8DE+Q15lggUC+27gVNWPhCGo9yOU364ii7BfzItJIxwPHf7w2iueiY75Wr5XT2ot
 rfvRhyY+LczZcN5vzBQ==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4b211 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=31ySfBESk6nFzokIpWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX2ym5ruCb3psE
 Vdr8bvFyfIqEBTuXFx/XUozthf9/joNVNX4KPUaQhRcSTIbwxnb/soRrQD+p3xbAjQ6ckdXFW62
 FJlVfpNK6XihIFF7Ijqr4mls/6Z3/gw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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

Build the 26 per-opcode int-add tests as a single executable,
test_msa_int_add.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_add.c | 183 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build        |  27 +----
 2 files changed, 184 insertions(+), 26 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_add.c

diff --git a/tests/tcg/mips/test_msa_int_add.c b/tests/tcg/mips/test_msa_int_add.c
new file mode 100644
index 000000000000..c29663c1bfa7
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_add.c
@@ -0,0 +1,183 @@
+/*
+ * MIPS MSA tests: Int Add instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_add_a_b
+#include "user/ase/msa/int-add/test_msa_add_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_d
+#include "user/ase/msa/int-add/test_msa_add_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_h
+#include "user/ase/msa/int-add/test_msa_add_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_w
+#include "user/ase/msa/int-add/test_msa_add_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_b
+#include "user/ase/msa/int-add/test_msa_adds_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_d
+#include "user/ase/msa/int-add/test_msa_adds_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_h
+#include "user/ase/msa/int-add/test_msa_adds_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_w
+#include "user/ase/msa/int-add/test_msa_adds_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_b
+#include "user/ase/msa/int-add/test_msa_adds_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_d
+#include "user/ase/msa/int-add/test_msa_adds_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_h
+#include "user/ase/msa/int-add/test_msa_adds_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_w
+#include "user/ase/msa/int-add/test_msa_adds_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_b
+#include "user/ase/msa/int-add/test_msa_adds_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_d
+#include "user/ase/msa/int-add/test_msa_adds_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_h
+#include "user/ase/msa/int-add/test_msa_adds_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_w
+#include "user/ase/msa/int-add/test_msa_adds_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_b
+#include "user/ase/msa/int-add/test_msa_addv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_d
+#include "user/ase/msa/int-add/test_msa_addv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_h
+#include "user/ase/msa/int-add/test_msa_addv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_w
+#include "user/ase/msa/int-add/test_msa_addv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_d
+#include "user/ase/msa/int-add/test_msa_hadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_h
+#include "user/ase/msa/int-add/test_msa_hadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_w
+#include "user/ase/msa/int-add/test_msa_hadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_d
+#include "user/ase/msa/int-add/test_msa_hadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_h
+#include "user/ase/msa/int-add/test_msa_hadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_w
+#include "user/ase/msa/int-add/test_msa_hadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "add.a.b", test_msa_add_a_b },
+    { "add.a.d", test_msa_add_a_d },
+    { "add.a.h", test_msa_add_a_h },
+    { "add.a.w", test_msa_add_a_w },
+    { "adds.a.b", test_msa_adds_a_b },
+    { "adds.a.d", test_msa_adds_a_d },
+    { "adds.a.h", test_msa_adds_a_h },
+    { "adds.a.w", test_msa_adds_a_w },
+    { "adds.s.b", test_msa_adds_s_b },
+    { "adds.s.d", test_msa_adds_s_d },
+    { "adds.s.h", test_msa_adds_s_h },
+    { "adds.s.w", test_msa_adds_s_w },
+    { "adds.u.b", test_msa_adds_u_b },
+    { "adds.u.d", test_msa_adds_u_d },
+    { "adds.u.h", test_msa_adds_u_h },
+    { "adds.u.w", test_msa_adds_u_w },
+    { "addv.b", test_msa_addv_b },
+    { "addv.d", test_msa_addv_d },
+    { "addv.h", test_msa_addv_h },
+    { "addv.w", test_msa_addv_w },
+    { "hadd.s.d", test_msa_hadd_s_d },
+    { "hadd.s.h", test_msa_hadd_s_h },
+    { "hadd.s.w", test_msa_hadd_s_w },
+    { "hadd.u.d", test_msa_hadd_u_d },
+    { "hadd.u.h", test_msa_hadd_u_h },
+    { "hadd.u.w", test_msa_hadd_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Add", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 5e14bc3197a5..7ef3d6aafa8a 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -7,6 +7,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
+  '../mips/test_msa_int_add.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -94,32 +95,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_w.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-- 
2.55.0


