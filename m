Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13A606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cz0yPf5P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XsNHBKEh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrJP-0005L1-2Z; Fri, 30 Oct 2026 14:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJH-0005FS-3X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJE-0002O3-IT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2xM4011198
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ppuAHVKzdnaZcaz0VZJLUE/73N1uz51RNcxnbHlXUU=; b=Cz0yPf5PldBy4sRK
 LIj5pZEIjrFOKSwZPo0rL7oPBMOgL9zBrMci0LDsJZMrJZcnJR8YAdT3t/oRWTiM
 +ZEq0/6zehd0o29W1dZBoNiEUwIZyB/oz1B1U+GAYHXWDKr7FnshXvx1BHu5d+WS
 +Yj0NRQZ4q17l7gSo8IFbVnbf2ABC5ydgVxgHRH6HNNf7XQqhR66AK97C5QWxciR
 E1ofIQdQGIux480p0Qo5Mcb7f/cdDMVw+aM7u9+ktrM1Mzllq2G84Ej6a2pvRvVN
 DDDxBEolbFHFyBpzDtAUfBO+tgyUibbAmZ+nXtSPWKgumaXFfXBTjf1n79CIc/1P
 dfEUAw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmc69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9905fc56b60so829656241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384794; x=1793989594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ppuAHVKzdnaZcaz0VZJLUE/73N1uz51RNcxnbHlXUU=;
 b=XsNHBKEh5WBSHEctWY0qAgPEhj/n44FK62dR7A8W0gyzdpfh65Cmc45icCEsYEDmVt
 pUfPK56PPA57FlvExuU0XxINg5PV0ee7pS70ltv22iqYOm5trtydnNK/FtpaheaTcdzW
 cTBHGLj5q93xJp6dust3xK1apYxW9Oqe76IWVy6DPqQOwld4cYJIP/NntRd0PFigGVgG
 OiFEi7kiQFii/6xB6y4n/e9u92urpjtfFR8r+d8VU/cd/AZIeQuHxoz87nXA5BSYWOgN
 GMxsfDcuLuef1nz6Tyge2byAJ2eamincx7jkW1j3X/ylzp9zXk91yKNFzRQLyq3/zEp/
 SpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384794; x=1793989594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ppuAHVKzdnaZcaz0VZJLUE/73N1uz51RNcxnbHlXUU=;
 b=kaUzf7G66i7ER9nxbLeuo7XDhXNT+lRDUJosB9Dk0bamc4B/334QhGAvR+itXO3opg
 RH3tZn9mCO4AqV4MicS8UPpWdLEJmwSomIOxDuLTLqLa0kU041sbzuuPBT8cjJmlMn19
 g4ovqBvdOEL1CXRM6Eab1D9gNBRu/nVFjZxTXG4zsmurYNqEUMLQgbMVaypssPV5l3mK
 nT9+xYz3YqiEsVbUzwqpVHBH/2YYK/2Rsma4ZDaBrs0ny2IZHDbrt2CtO8B5EZ7T3ozq
 s9fHNrWcxnaud3ErRy03z46kfjC1Vdlvrr18nR720wjlCRxXSuioW3ip3BtkNSenu6zN
 QF2g==
X-Gm-Message-State: AFq9FYLz7KCle2rDMCFlCoIs6KcJEC/7gPHEyZ5aDmmpRDIOQIl1O1Zf
 lO11TULeoknpWvoEapVgtK7I5Y4tjblNG+LGGr5yzLAevJjsRC9DTkLlwpn+US/y9rqoRpkbBZp
 N0fr3W+xhhGacuC0Iz55ypWsNHwaEqSBb6QjhbQA7Vgz2Rke/gJPIUobu4XSxln/IZP+D
X-Gm-Gg: AYBFou0htGfDoGnfg/gvJoB+B/fiC0waDzGhLuQXnlEk+DgHc0wseR8IBlWisRpDKwl
 wr66SMyfrSZ5G6OeHK6ytXJ3iwiIA/mi/e/9S5CdfH3ALfMvmmwZMVg9iTnslIaN6O9ojgVwCv4
 WPpsW+BtqkNft59VvY83KrHOf4AyS+ACPWygLSkKfs7xXmdThrgO2TnBpRm3yyoYrHtY8dbZbc2
 b9+RNrscbLgS1gCinH4UC9J12L65SVgwVwaTKNymej4i3H3T3rPydEDsUGQcTA1hrZM7NYGBpCO
 NLdXzuMmS0wSr/hQSfk0Vf6H8XKrrNVhDdGxm0SnQ+bho9+Z7ON8ZMp12sGG+NafNDDZVPNHwQE
 FyNxNrYGdhgOmeIzjiXiP2cY0k9EDniDq7iKggic6Yjg9ClkFq9AMr0sWad9Ui3YWdXCmZb9jmq
 cqiQSS+obCPgmxSbPzkfXMlLR30Qt2aw==
X-Received: by 2002:a67:e112:0:b0:7b0:bd98:68df with SMTP id
 ada2fe7eead31-7d0543acf6dmr1734066137.41.1793384793704; 
 Fri, 30 Oct 2026 11:26:33 -0700 (PDT)
X-Received: by 2002:a67:e112:0:b0:7b0:bd98:68df with SMTP id
 ada2fe7eead31-7d0543acf6dmr1734052137.41.1793384793231; 
 Fri, 30 Oct 2026 11:26:33 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c0b6sm4244898f8f.41.2026.10.30.11.26.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 05/12] tests/tcg/mipsel: Add MIPS32R6 bit operation tests
Date: Fri, 30 Oct 2026 19:25:38 +0100
Message-ID: <20261030182546.2508-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5xuKWk4QGdQAE2Rieu58D0Y58hz7P1Ni
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX9QlOBpIcOK/i
 p5WDaW+qZg2V6IByy9tDHE7VxNDRPwdXnu5PSL73/kt7JckAbvwieuNCjY2e4NO+vAeEMDXZLlK
 35OokSa4f+Bh1253QTJUffahKnlPlCc=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4e15a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xpWpbzVTnifO-OPWo9MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 5xuKWk4QGdQAE2Rieu58D0Y58hz7P1Ni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXz9dyzt/A4xXO
 pCkB0odnIrVN6GI/+TwdMHDJp4ptVjgB2142Opb1obwElYR6qTWTbAeMZowfgncuACsecn5s/vn
 l6mSHfvvvhW4B3IwvUcGNttzihPXnc9yo78qtC+VMe1TJ0xW873xUJRUWXL9IjZc1o3owIkDqAc
 RrhPbtUYoGFkhwKdOJN5DJTD+BHqbJ+CzgMvqIGSFnzWrK+3kj2aRU+LaBf360b5bowCS6yb5h5
 Mrq/CzbMwsv3UGWCwFbNgkXw1xaLokGaXCfqUAJ1KvDGN5dKPo8Z478f4AdshNWidSQYtIPn3hr
 fcakO/ZfmcwJKOYQx3ueV4WjKFiLQVc65C/HqfzVeiMCU7KRR00vr9FHaDAstiCI8D9IoAOKSca
 8XgOFGNZ2QpYYYvLQZa0aORIg/ufzt/cIC5pBSZn/rVEaY2Z817hNR+uBkncu92/SqexkPhretC
 Z2lxi1byfwSLB9r+9Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
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

Test CLO, CLZ and bitswap.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_bitops.c | 79 +++++++++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_shift.c  |  8 +--
 tests/tcg/mipsel/meson.build            |  1 +
 3 files changed, 83 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c

diff --git a/tests/tcg/mipsel/test_mips32r6_bitops.c b/tests/tcg/mipsel/test_mips32r6_bitops.c
new file mode 100644
index 000000000000..8546209b50dd
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_bitops.c
@@ -0,0 +1,79 @@
+/*
+ * MIPS32R6 tests: bit operations instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+
+#include "../include/tap.h"
+#include "../mips/include/wrappers_mips32r6.h"
+#include "../mips/include/test_inputs_32.h"
+
+typedef void (*unary_op_32)(const uint32_t *, uint32_t *);
+typedef uint32_t (*ref_op_32)(uint32_t);
+
+static uint32_t ref_clz(uint32_t a) { return a ? __builtin_clz(a) : 32; }
+static uint32_t ref_clo(uint32_t a) { return ref_clz(~a); }
+
+/* BITSWAP reverses the bit order inside each byte. */
+static uint32_t ref_bitswap(uint32_t a)
+{
+    uint32_t res = 0;
+
+    for (int byte = 0; byte < 4; byte++) {
+        for (int bit = 0; bit < 8; bit++) {
+            if (a & (1u << (byte * 8 + bit))) {
+                res |= 1u << (byte * 8 + 7 - bit);
+            }
+        }
+    }
+    return res;
+}
+
+static int check_all(const char *name, unary_op_32 op, ref_op_32 ref,
+                     const uint32_t *input, size_t count)
+{
+    int fail = 0;
+
+    for (size_t i = 0; i < count; i++) {
+        uint32_t a = input[i], res = 0;
+
+        op(&a, &res);
+        if (res != ref(a)) {
+            TAP_INFO("%s: %08x: got %08x expected %08x",
+                     name, a, res, ref(a));
+            fail = 1;
+        }
+    }
+    return fail;
+}
+
+static int run(const char *name, unary_op_32 op, ref_op_32 ref)
+{
+    int ret = 0;
+
+    ret |= check_all(name, op, ref, b32_pattern, PATTERN_INPUTS_32_COUNT);
+    ret |= check_all(name, op, ref, b32_random, RANDOM_INPUTS_32_COUNT);
+    /* Every leading-run length, for both polarities. */
+    for (int n = 0; n < 32; n++) {
+        uint32_t v[2] = { 0xffffffffu >> n, ~(0xffffffffu >> n) };
+
+        ret |= check_all(name, op, ref, v, 2);
+        v[0] = 1u << n;
+        v[1] = ~(1u << n);
+        ret |= check_all(name, op, ref, v, 2);
+    }
+    tap_report(!ret, "MIPS32R6 bitops %s", name);
+    return ret;
+}
+
+int main(void)
+{
+    TAP_START();
+    run("CLO", do_mips32r6_CLO, ref_clo);
+    run("CLZ", do_mips32r6_CLZ, ref_clz);
+    run("BITSWAP", do_mips32r6_BITSWAP, ref_bitswap);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_mips32r6_shift.c b/tests/tcg/mipsel/test_mips32r6_shift.c
index 0594796709f3..6828e90dd8af 100644
--- a/tests/tcg/mipsel/test_mips32r6_shift.c
+++ b/tests/tcg/mipsel/test_mips32r6_shift.c
@@ -62,12 +62,10 @@ static int run(const char *name, binary_op_32 op, ref_op_32 ref)
 
 int main(void)
 {
-    int ret = 0;
-
     TAP_START();
-    ret |= run("SLLV", do_mips32r6_SLLV, ref_sllv);
-    ret |= run("SRLV", do_mips32r6_SRLV, ref_srlv);
-    ret |= run("SRAV", do_mips32r6_SRAV, ref_srav);
+    run("SLLV", do_mips32r6_SLLV, ref_sllv);
+    run("SRLV", do_mips32r6_SRLV, ref_srlv);
+    run("SRAV", do_mips32r6_SRAV, ref_srav);
 
     return tap_done();
 }
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 3c40a556ad46..0c43c31e7355 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -67,6 +67,7 @@ endif
 tests = []
 
 tests_mips32r6 = [
+  'test_mips32r6_bitops.c',
   'test_mips32r6_logic.c',
   'test_mips32r6_shift.c',
 ]
-- 
2.55.0


