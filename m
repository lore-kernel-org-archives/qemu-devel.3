Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070F606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OFIlwI+B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hQRH5djS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrJb-0005zF-J1; Fri, 30 Oct 2026 14:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJY-0005o6-KS
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJW-0002PP-Ph
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuRM8411165
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2lyv5b79nTQdp4OncOwo6NDlb6bPO/fzYsDUGatZXvw=; b=OFIlwI+BJ4oETDuS
 tceeRtIxFjbnB+mwyysl9TO2+04QuBCtp3bElipqmuQAJxCXFlclSD2WrGu3BjqK
 1WZfGXqce+fQU3eVe9/KwX+e3o4qfrneHD4sMNYsqf/Bhg9Yq1c7o9rTB/hhg2MD
 NkVG1uQzL0jcCoK76utUMu7YiKBT2rW3W9uRY34nnTFMjf1GQoCLhb4nGeR3MHXZ
 JkOjcB95017shahnXZIJAlvncHopmBc6DpICk9+DXdGWETO9GTm3rmiZjzPUKmD4
 1sOdOZEaq/gGKub9dzOvhXUy5RwhE4Z+F3P++s4ElUXEkKVp4g5bM8JOxXYI3eUW
 tdhtYQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qvd7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-988bea8fed6so782596241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384813; x=1793989613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2lyv5b79nTQdp4OncOwo6NDlb6bPO/fzYsDUGatZXvw=;
 b=hQRH5djSIhma6Kj6r+wkqXGC1Wcs3AhV9n9lsP2xY2KED+Nuqxu0SD2NshbNy3Z5i+
 QPgkeSC62T+KVO0yQpTHL7+LnLy6em90K9CGRHOGLeIqkEcE+lxPNeW+uP2605uYUBmH
 oKGkFG9cDI2p8AzHsy2qimH66VWEG48uyky/U7UrSNo3LO7+LVGFf+Giv1niNfHVRYLT
 1rVXusEqm9IHPukmU5x7d6Ir+aTBPQx+Bg4Q3abYcc6bVFunyTqtV/lPN58uqSrWU3vW
 xBH94M2w9LJ9pX/4oPYduO3Agf4zZHzwvwIZKuhAeTtjqx3N6hv74j5YSK9z3DivMFeG
 J/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384813; x=1793989613;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2lyv5b79nTQdp4OncOwo6NDlb6bPO/fzYsDUGatZXvw=;
 b=qLn2ZUrCik5Ow5R4agztWxMYMQUQQCUEpfMX5pNdSrSmF8htPHWewiKA3377ZDtb/R
 9CB/5WX8dwkLBeI2td1etI9xEmNBOC8b/meOEIEck/buhW5A15GFz/Meluxpwz5AUUpv
 82I5x9+1WNoDIiXtoMZ1x5cDADOLtS6epbtSUenTLCrgDFv9Ci+zgxWwTP77oXv7Qn6F
 PT28MK0LyrRU0b45007hUEKYb4hnZVj0fNMGKLcIVTXzPxQuZJXIje999ZFSTsSQgwhL
 ki/CNgkoH/3qlHVEwVQLASqvo2ZydfRHLLEgo9YcFNZCSyLacv75UslNdIhPGYdnOrZf
 WTOg==
X-Gm-Message-State: AFq9FYLSIPInizk74tjT5itwUylYzBIVcGmyC/hPfMaeF/0zJJ3cN2z8
 BOdUX2d3IdbNrip6xgqZP9mbr6bOkkLAdCtKq1XzfNWDwE+4Z3dS16tS+oeFyxSYSuzbOiM8CTz
 f5RLBkY2UqetlhZBVaW2tiA5dTkilWt+Iw/5JVp0jO6CfJokU+5quWAFh4+eQAHmohw1j
X-Gm-Gg: AYBFou2nopN53yc8n8HlRnWCxNJ3tTPqCiUz7j1tto8NseStqEIhH4vn1Up1+dR07s7
 UCG0Opx1WjyagLlJXi7/BGXlSbrldhfHX9Y5Wm11nxVc2kienhxqfpZlh3El6aNwehK/YLZ0eNm
 0YJg5+hly+OmP3FzB2Putrpfh/y2uLH8tonL778Q2W3Ajlebu5POi4iNS91xuzdZitCyk4yNE3w
 5guamh6bT31wqR4P2z5hZdLtkHe1e0mRlm+k1zclgkiuoDHDNfPd5XDX7NfAJW0QpHvUc2gJFRk
 5sUyU3tyMvZ63YPZm8Go/nB2OdIzGGAN2bp5R5DiLJaVeBhAiv07w7yct5z8iLEAiZc79ZPDRfr
 auX8fD+LorH6/Go6r3SK3BwggxzLiMyUIOaMuSntFRC4WxdNuJek3CAhBGzi0Lonm2F6G+ii9/l
 aiJAKmMRsGDVJekLK7hxGvQjXX5+fp5w==
X-Received: by 2002:a05:6102:3ec5:b0:7ce:6289:314 with SMTP id
 ada2fe7eead31-7d07269900fmr1755346137.14.1793384812761; 
 Fri, 30 Oct 2026 11:26:52 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec5:b0:7ce:6289:314 with SMTP id
 ada2fe7eead31-7d07269900fmr1755326137.14.1793384812226; 
 Fri, 30 Oct 2026 11:26:52 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3f9sm4920719f8f.4.2026.10.30.11.26.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 07/12] tests/tcg/mipsel: Add MIPS32R6 PC-relative tests
Date: Fri, 30 Oct 2026 19:25:40 +0100
Message-ID: <20261030182546.2508-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -E5I8ohcRQ6oqvg6U0nQeCkZs81U1CxR
X-Proofpoint-ORIG-GUID: -E5I8ohcRQ6oqvg6U0nQeCkZs81U1CxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX2/drvon+KA3w
 YQphPNSz4fRKdaRqvKl/eogRbd/0TV9qYZYAjnkUbUEPqGrE6ufziU8nhM5EBrpof+GXjbPOlFX
 wLIjXClV3Kksh+OfVBeDplS5aNpyeApggKj22JlrcpeUqvV4YQLsMFy5UMbblCbtABvB1dqauSN
 kRiE/zLIVep69W5o9/DHJbabGHfmEBNTbQFQhuMMoa/qCFui+JTsEgqle0kq/x+JJ21Wa4dNM6q
 qOq3trJS9Y0kGR/PucL+5MPjX9X+gZ6h85d63sbSlQdDIq4Up9339H2olzBAwFMrLmwWU1Tnv1H
 azS8Z8/rX/RRZuA5HD0tZJMTJ0vmVUOzldqUYguVD1a+IOrM4Nuxy6qz1bZucOc5sNgkm6ou4fx
 K1+wpCsE5en+38ZmrpYvs8qM5DIQq74S5ndh6PHuWrArMUrYknNZulwNLAqPER2xLGCHqyjrSy6
 Lot/aJEzuIwAKtvoVsQ==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4e16d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Qa2biqyKpYfkMrCa2ZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXwru5rjIWUOXk
 YLD0/m3p4W5A2FtsHGCP4gzSZLCKiR89en054eOUApb7Q56/3IMpZ63yjyQq1Ni+jhJce5J5KTc
 HG6+NC3RuWoaCf9e864rePDjfi7bZDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
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

Test A[L]UIPC opcodes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_pcrel.c | 88 ++++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build           |  1 +
 2 files changed, 89 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c

diff --git a/tests/tcg/mipsel/test_mips32r6_pcrel.c b/tests/tcg/mipsel/test_mips32r6_pcrel.c
new file mode 100644
index 000000000000..c93bca0ac06e
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_pcrel.c
@@ -0,0 +1,88 @@
+/*
+ * MIPS32R6 tests: PC-relative AUIPC and ALUIPC instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+
+#include "../include/tap.h"
+
+/*
+ * Run INSN with the immediate IMM, and probe the address of INSN with a
+ * second AUIPC (which yields its own address, +4 being INSN's size).
+ */
+#define PCREL(insn, imm, res, addr)                                     \
+    __asm__ volatile (                                                  \
+        ".set push\n\t"                                                 \
+        ".set noreorder\n\t"                                            \
+        insn " %0, " #imm "\n\t"                                        \
+        "auipc %1, 0\n\t"                                               \
+        ".set pop\n\t"                                                  \
+        : "=r" (res), "=r" (addr))
+
+static int check(const char *name, uint32_t imm, uint32_t res, uint32_t probe,
+                 int aligned)
+{
+    /* The probe AUIPC is the instruction after the tested one. */
+    uint32_t addr = probe - 4;
+    uint32_t expected = addr + (imm << 16);
+    int ok;
+
+    if (aligned) {
+        expected &= ~0xffffu;
+    }
+    ok = res == expected;
+    if (!ok) {
+        TAP_INFO("%s imm=0x%04x at 0x%08x: got 0x%08x expected 0x%08x",
+                 name, imm, addr, res, expected);
+    }
+    return !ok;
+}
+
+#define CHECK_AUIPC(imm)                                                \
+    do {                                                                \
+        uint32_t res, probe;                                            \
+        PCREL("auipc", imm, res, probe);                                \
+        ret |= check("AUIPC", imm, res, probe, 0);                      \
+    } while (0)
+
+#define CHECK_ALUIPC(imm)                                               \
+    do {                                                                \
+        uint32_t res, probe;                                            \
+        PCREL("aluipc", imm, res, probe);                               \
+        ret |= check("ALUIPC", imm, res, probe, 1);                     \
+    } while (0)
+
+static int test_auipc(void)
+{
+    int ret = 0;
+
+    CHECK_AUIPC(0);
+    CHECK_AUIPC(1);
+    CHECK_AUIPC(0x7fff);
+    CHECK_AUIPC(0x8000);
+    CHECK_AUIPC(0xffff);
+    return ret;
+}
+
+static int test_aluipc(void)
+{
+    int ret = 0;
+
+    CHECK_ALUIPC(0);
+    CHECK_ALUIPC(1);
+    CHECK_ALUIPC(0x7fff);
+    CHECK_ALUIPC(0x8000);
+    CHECK_ALUIPC(0xffff);
+    return ret;
+}
+
+int main(void)
+{
+    TAP_START();
+    tap_report(!test_auipc(), "MIPS32R6 AUIPC");
+    tap_report(!test_aluipc(), "MIPS32R6 ALUIPC");
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index f540d18b3bd2..a7af2f16192f 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -70,6 +70,7 @@ tests_mips32r6 = [
   'test_mips32r6_bitops.c',
   'test_mips32r6_logic.c',
   'test_mips32r6_multiply.c',
+  'test_mips32r6_pcrel.c',
   'test_mips32r6_shift.c',
 ]
 
-- 
2.55.0


