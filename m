Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B965C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJYI-000595-J6; Fri, 24 Jul 2026 13:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnJXy-00053U-2C
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:18:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnJXw-0002Pu-2S
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:18:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGrgcr3629559
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UQwPgf3w8MVcmHmmsC/pJFzYRwiHOyqIqAWQ9Uk+49c=; b=kxeQ41D+2eWpkbeK
 BewirEoKkml5RQp8SRXkDsEr1seXzxpSVo8+Hm8JD27NVeGvWC1xVg4+0pNeYhM0
 CWMw4Jfr8sIXpHEbsYIOsZf853Pr7u1sfPGYVW9nFexeJjcwqmusOeKssvZL2MKc
 z+tDEeTZwsEWaj3ovdZLIobTRjCvauAG43R8++SPld4aIPELlLd5Kw6zbiIbo28V
 WpDOLAl7lam44gxhHzmtltS9as84psAghnPf538UjZTsVM6uTEF4p8rqII2D2S7w
 JMTnnTN24YaPykZIpek/qYBvrXQyDtJfcqZAjCjZv22OOldXIE293cmwtjlyUeCG
 3gwBvg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yahjun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:18:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab041eced3so916965a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784913529; x=1785518329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UQwPgf3w8MVcmHmmsC/pJFzYRwiHOyqIqAWQ9Uk+49c=;
 b=aF/bVdoWh3dMk4JmkSrx0fBv+eAahcpIT1gMvZ2PljOAmp1zPKlgNRTOEE1cBAzl2Q
 +aB/sRilSrq9BNdcVkTV3owZvmWvVnbcc8ub9G4Tt9R+9OywR7pcsuG692ux+ER6ZUcg
 3qYbU3LY7LCrlplIcAlnprYmuiZDxzqV77SHHLQSFJGHx8UG+t5QQbmAY6dfCcGcCR+q
 Wdf0XciSJr8kFAWbMo7EeJY1aso8XUCPnDp8bwSeN028BFMHJRa5sU1xtdlA1UXfARRv
 L84rD30FX9iKwu48BIqf/EDycmr4oTA5XCG1UD1hpYL/CE5FfTcJ33tq3qMUsRYzVwYk
 FZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913529; x=1785518329;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQwPgf3w8MVcmHmmsC/pJFzYRwiHOyqIqAWQ9Uk+49c=;
 b=TNoSdZIUE73/udh0xFwlGs5s6J9au29hFdt5z5BbmCLq0A7SSrjkNHCH7FMf7Sml+B
 OvpKivbLnSGtU19wKxhGeUXaY7zdlQrld1xyksMqhXdUsOf4Mh7F2IfqKsCLpDPBEthu
 TV8k6YgAcpUgbvFYvRTsAdb6k1q4tcyWwDlxJxnlAGwuqElbMci9sEO68rc1kr6RRv2t
 hAe+eNpmPM4NDVXYhr3dpBlMdJJrrDVMGQmrWd+ZAW+HwHWdOjqi9LZF7RmBanvt6QmI
 RRcrsXnam+7SAuuJVX8SoNtwE3pTiTKNG1gQZKMVSnNJh99+uYT7/sh3mfxLInRXkyuW
 ff1w==
X-Gm-Message-State: AOJu0YxtyOexqg8Ai3yT+uYk5/0VCHnJx63R7IssY41NmFLT9Fpx+WCj
 GcGyJ9ETnrWmY8rKpvUFx052iYqo4CZBeJfJ0XBSSsDPJm9ymoz1c9Ak8NwsPEZPKgVD/QkHsMS
 +/pZlGKi1yd1pBQ9EwFGE7mdzKz86OpTFloXqBW7E00fvYsebjC3Rmqy0Yb0bo/NJhQ==
X-Gm-Gg: AR+sD1294JMp6v4eK2SE/ZpRA8JJluxF82Iapo1YxbpnEoeGCwnuT1SXe1LOihFB+8d
 JDS0bKJhuwPZMkKWkaif3bPbOVaMxuL9/RADoo0kUIyeJInwygob9iu//m0ql/qIl5aZHgx4MFo
 t/vVr82VokQPGSrH+F3jcIRTJ3lPy3msRa3YYRoZrZO7qGzgJbYLXNy5/r+FMBtOvD+7V5ctYdQ
 Jcr4nrCGiB51lAlLzL0JsxfgYFaF1dnNL0EZMVoEbr65kNnT7Jy4IgfkSqZRAKO/I4pB1dieV7a
 YXO4WnxAGCBmHicqiVrpI3dGLDYIY1RrbasYPfmcD6eJiEWw7Wt/un6DzmRaE2wT3UHwQO98ujO
 h80HHUldqYh/UF0mSjIfmaZQXIEDq/MZlilhdWFbP/okSCW2w
X-Received: by 2002:a17:90b:2dcb:b0:38e:740f:9764 with SMTP id
 98e67ed59e1d1-38ec65297e1mr8290472a91.18.1784913528680; 
 Fri, 24 Jul 2026 10:18:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2dcb:b0:38e:740f:9764 with SMTP id
 98e67ed59e1d1-38ec65297e1mr8290448a91.18.1784913528035; 
 Fri, 24 Jul 2026 10:18:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130158c0sm27816798c88.6.2026.07.24.10.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 10:18:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/2] tests/tcg/hexagon: add slot-assignment tests
Date: Fri, 24 Jul 2026 10:18:45 -0700
Message-Id: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724171845.78440-1-brian.cain@oss.qualcomm.com>
References: <20260724171845.78440-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX8XK0Qw8PLzHM
 pMHeoBJTo1ACwA5CGdCdVfAsq+HAdsaNjJj0v22/w3jCS5DcR/0fw98EZ9NZm3j878ECaTw4FNY
 Rz+ue19+btOw8IpwquJjQopYLtmV+TA=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a639e79 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=r_I9Sa7bfjC0UZVyMegA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: u5HJaTs8_QHR29fgwqlyFyXM-ibnORa2
X-Proofpoint-ORIG-GUID: u5HJaTs8_QHR29fgwqlyFyXM-ibnORa2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX7ManqFq4VI6p
 EtMrBMxC0yeAmcUejH26wdBOsTOjfhscIJMKbvN/puXYQAKxzusD/H10fu6Nxi11VsoityvSuTP
 KtwyMwL39Cw9H5U//fnCv0LR7mvuMOGQswJ5d4xw2hpqopyMytkxAEElmnerz8cqEyk76Iygi8V
 va4d3GA5U+zPpU0Xbp1T40PbvCbaDIuw99Qh3ol5jLjGoUhsX4fG8Tgq/0f8rVTuREUayUpxBFR
 pt5Vc6Sq3alCa6Hxzegj+VnWUjvWAVZHlrs0Mj9vBVjkxSqh/CL0+5AU1LblykrtmAnOm3ij1Ia
 YnQ6c4lBMVnsJvq6Xcj2qkle1gtfa4vrXxen7HfavWOypqnbH7les4AB15+n2y0pwivbdC0AoJV
 F+UevNr7XwUJU5AepBkqaCSCyK0oa8CbAtqlb+EhrvIgNwm2xNB4HwsWp7obkyKQGmLiIhCmfIi
 TCB3MP2Hc8n1h8vKQzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

valid-slots: packets that legally share a slot and were wrongly
rejected before the fix (load and transfer, load encoded first;
dczeroa packed last with three transfers).

invalid-slots: unassignable packets that must still be rejected:
store + duplex, load + indirect jump, three logical ops competing for
slots 2 and 3, and five ops for four slots.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/tcg/hexagon/Makefile.target |  1 +
 tests/tcg/hexagon/invalid-slots.c | 72 +++++++++++++++++++++++++++++++
 tests/tcg/hexagon/valid-slots.c   | 62 ++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 tests/tcg/hexagon/valid-slots.c

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index a2a0ffc69b2..80e56f7d055 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
+HEX_TESTS += valid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += multiple-writes
 HEX_TESTS += unaligned_pc
diff --git a/tests/tcg/hexagon/invalid-slots.c b/tests/tcg/hexagon/invalid-slots.c
index 607027f314d..f2dace2e541 100644
--- a/tests/tcg/hexagon/invalid-slots.c
+++ b/tests/tcg/hexagon/invalid-slots.c
@@ -55,6 +55,75 @@ static int test_invalid_slots(void)
     return sig;
 }
 
+/* Load then indirect jump, load encoded first: no high slot left for jump. */
+static int test_invalid_slots_highslot(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "r3 = #mem\n"
+        ".word 0x91834006\n" /* { r6 = memw(r3+#0); */
+        ".word 0x529fc000\n" /*   jumpr r31 }        */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r3", "r6", "memory");
+
+    return sig;
+}
+
+/*
+ * Three predicate-logical ops: each is restricted to slots 2 and 3, so the
+ * fourth-and-fifth-slot-free packet still has only two slots for three ops.
+ * No change-of-flow is involved, so the only reason to reject it is the slot
+ * conflict.
+ */
+static int test_invalid_slots_crslot23(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x6b024100\n" /* { p0 = and(p1, p2); */
+        ".word 0x6b224103\n" /*   p3 = or(p1, p2);   */
+        ".word 0x6b42c301\n" /*   p1 = xor(p2, p3) } */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "p0", "p1", "p3", "memory");
+
+    return sig;
+}
+
+/* Three transfers plus a duplex: five ops for four slots. */
+static int test_invalid_slots_five(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x78004020\n" /* { r0 = #1;           */
+        ".word 0x78004041\n" /*   r1 = #2;            */
+        ".word 0x78004062\n" /*   r2 = #3;            */
+        ".word 0x28452856\n" /*   r5 = #4; r6 = #5 }  */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r2", "r5", "r6", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -65,6 +134,9 @@ int main()
     assert(sigaction(SIGILL, &act, NULL) == 0);
 
     assert(test_invalid_slots() == SIGILL);
+    assert(test_invalid_slots_highslot() == SIGILL);
+    assert(test_invalid_slots_crslot23() == SIGILL);
+    assert(test_invalid_slots_five() == SIGILL);
 
     puts("PASS");
     return EXIT_SUCCESS;
diff --git a/tests/tcg/hexagon/valid-slots.c b/tests/tcg/hexagon/valid-slots.c
new file mode 100644
index 00000000000..70d9b0b6acf
--- /dev/null
+++ b/tests/tcg/hexagon/valid-slots.c
@@ -0,0 +1,62 @@
+/*
+ * Regression tests for valid packets that qemu incorrectly rejected as
+ * invalid.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+int err;
+
+#include "hex_test.h"
+
+/* volatile to keep the load from being optimized away */
+static volatile int buf[2] = { 0x1234, 0 };
+
+/* Load and register transfer in one packet, load encoded first. */
+static int32_t load_imm_pair(void)
+{
+    int32_t out;
+    /* { r6 = memw(r3+#-4); r7 = #0x4ae6 } */
+    asm volatile(
+        "{ r3 = %1 }\n\t"
+        ".word 0x97837fe6\n\t"
+        ".word 0x7845dcc7\n\t"
+        "{ %0 = r6 }\n\t"
+        : "=r"(out) : "r"(&buf[1]) : "r3", "r6", "r7");
+    return out;
+}
+
+static int32_t dcbuf[8] __attribute__((aligned(32)));
+
+/* Slot-0-only op (dczeroa) packed last with three transfers. */
+static void slot0_restricted(int32_t *out)
+{
+    asm volatile(
+        "{ %0 = #0x11\n\t"
+        "  %1 = #0x22\n\t"
+        "  %2 = #0x33\n\t"
+        "  dczeroa(%3) }\n\t"
+        : "=r"(out[0]), "=r"(out[1]), "=r"(out[2])
+        : "r"(dcbuf) : "memory");
+}
+
+int main()
+{
+    int32_t r[3];
+
+    check32(load_imm_pair(), 0x1234);
+
+    dcbuf[0] = 0x5a5a5a5a;
+    slot0_restricted(r);
+    check32(r[0], 0x11);
+    check32(r[1], 0x22);
+    check32(r[2], 0x33);
+    check32(dcbuf[0], 0);       /* dczeroa cleared the line */
+
+    puts(err ? "FAIL" : "PASS");
+    return err;
+}
-- 
2.34.1


