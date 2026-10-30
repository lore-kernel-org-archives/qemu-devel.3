Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8294606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SRXFXDOP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GTdPRkRt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoA5-00025V-GH; Fri, 30 Oct 2026 11:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9C-0001to-Fn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9A-0007EX-Ip
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER88f3552223
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uiBgXIYWT1lKSeD68gMwZsgRcMUOVYm6Nfc+9WFPjig=; b=SRXFXDOPF4y26HL8
 2PNCbL3mmEGjiOjUb0KDYP7Gd82lWzySdqR3JMHk1JIw5k9ApPaRLiKneAVmcWlO
 b8nQcTD5vogbaewaZ/0NbADgbHGQ0ntx/d+zxcIOBlC2hT88hcdN+nr2qtbWL5qe
 cxdBcLa+4JTsm/9Nwxs8jxLD8wa3/yjQt09ZQLPNPLiibhEByU3f/D8JHU50KYj5
 no69fINc8FElkM122AgN6O+90JGT8ysM+STReZtcAiW9uqhIykkT9HI48g9tCYhu
 gbquKcSxU72SoHoyJBrKO0vfHbDph8GUaX8X1WHV5a1k67eC0vD6+qRMvOaEIxu8
 51cicg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkkat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:59 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c0bad5ec1cso184868137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372638; x=1793977438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uiBgXIYWT1lKSeD68gMwZsgRcMUOVYm6Nfc+9WFPjig=;
 b=GTdPRkRtUjFhnfAStD/FVpGBNJsrRVYycALJbImxcciKUyirxBzFw/HKjTn40tDPwz
 z3BoDQw4s4F/ohiLiQeG0mjzJRfKevr4QE52uVyQxd/x+ozCrRijpVYPj6wCPCKHPscZ
 JE6evDfAazc9vHhyuXLseecmUeCYlk/5GU0OnQHyRM/6M/yqtactC055ZZbTjY5rxXNS
 7exstAYxlBjdI0igvjuKIrhcoHZhR9mLjMOQqSEo/o+umE7bAdSqTWQ0i4k/FiMYO1WM
 WG1zrULkGNgU+vgMZHeiybYM7oCGEfEeS4HSklm/ohND3u5URYrLSpRZJUE3O7Cpg24U
 k5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372638; x=1793977438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uiBgXIYWT1lKSeD68gMwZsgRcMUOVYm6Nfc+9WFPjig=;
 b=NvHLvTk2ADl2DLDcb7496ttTt219n+i2fCiqP6Rx+ITyVeEMzsLu2tQT626/ux0j+t
 Igw6J31krAtwmHoyRkKns0V397C6rBYR7U5ypQev/8qyHGFLHOqAA3kP7LjcXKujkhAB
 876pEEplwvP3UsDM8Tn27/NRgA9UAs3SbRxro59qHiepUgoNLBRyXo7SizGMjFQAQtd+
 q58bfU1uqNBil1PPe8Lb8kO/62TKvvSFgXydMqtygj/IRlYveE/PPk1uykSGeXvI94U5
 HSZxTTt2FGjnvfjOipYVuJlJcWa88pIw9gLfqGyvzGcBqWbCbRXmfXGBTHqV/3tCK7no
 uKkA==
X-Gm-Message-State: AFq9FYLF/MdCO6Tf5edCpM+nHd39uZDLXAJcUxv+tUQHIo7/SXGMuYfd
 EgHACSMT1RrsuAEmF1N1RSnFoAm1BWngMztt/EfYEkNvicXag58COtpdk7SVtEdF4+tSOpBhq5g
 BdaqZt3VqY2mbjT3KNayvI50t+JqPoLQL82LBR0uw3gm5HTcdBxJtT7zkVQlcwzgHzCbu
X-Gm-Gg: AYBFou3E/Hfl2vpXjt4AxOY95RzMa0COcQLcgqSBEI7vFRQeQy5pwyjyXqNmHmJaqjm
 bbTiAUAc5gQRIVZ1zfiTHb5AQ9p8VIGGANTRmZmZnh37HnXAubgRsW8GnY91efqyRhYGJYDM4GM
 kkG9maKemXPcPNsQ9FcZ1t/U/SThUF5M6I9yPnTyXa3fsS6nqmZvIBtLRsb1/MLnPMGtQ34t/EI
 Rk+c1bKBJUTJj2xaOcNCR84AZxLC8waohaSvftm0Oqb5aqsw/yOyFbZXLRjF8TfRFSToftgBhsb
 rZXQcglcMgev7XP5xrOVVnshvKBLDT8RO1migksE+CgLBmWfZQuI2qf6gropzoDCeQ+hdqTybLk
 JXxbsh05jCkddF68hmrskl2XofIeN3c3boEtWeQ7Gu+/Bp+EG9qeSZglh6MOXnR35jlaFdtnFPM
 UhbAT2A1kYIcRQwkOs1b+uQiV9VzFJzQ==
X-Received: by 2002:a05:6102:548b:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7d072d2ca10mr1103285137.33.1793372636916; 
 Fri, 30 Oct 2026 08:03:56 -0700 (PDT)
X-Received: by 2002:a05:6102:548b:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7d072d2ca10mr1103030137.33.1793372634902; 
 Fri, 30 Oct 2026 08:03:54 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm141294855e9.14.2026.10.30.08.03.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/31] tests/tcg/mips: Group Release 6 shift tests
Date: Fri, 30 Oct 2026 16:01:43 +0100
Message-ID: <20261030150202.61556-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XEjus6XgBWo1iQeKeqx0UYAAB-4n5HL0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXzedAeyxXzT0T
 CWcLtj2OXl2kkROi4n5Dz+ZNvOMk/gqEskWN4B5ke+GKsLq/VzAa3RDXGMtk2S/n/lCW6qD2C3r
 3eiz0MtkW21u+yaF8iC4Nf+ylhsMlDg=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4b1df cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: XEjus6XgBWo1iQeKeqx0UYAAB-4n5HL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX05ACZEpzestT
 QeKixo04/Hwn935LAs6zSEUyb+/TBG3jo+elaUkJjiVZHMTwjfNJ/RuZgleQfs3yv7mQ0ErOf6u
 O2MW9Qc9cDJ957WXZqdkFQ1XOtw6RzSVbswE7OSW8J/FN3LsDY7NGA/GvmXBT9KeIPlUIUSe1zv
 RDMb5aoWKzMV4OmHCo+wTY38LfiagQ6iaDF++DVUL+dw7XyDUroVI+GmzJ/8UttecRXKeK85bn7
 50k29QCsZToeFpbR0oQ1OkC0Cw4rOKzLaJR45B2xUELAJzFnocE2wnBFhuSh4gOtDs7uZDF4XxU
 BJBXQzhGPEFefvQfC9Dh87A6yN5FYAz7x3QMNzDDBwiEUdt/QUpBTdN5n1g4QuofRJf/YkN0aw1
 +YBavAZX2hpdsuc7oNUvbi9XvHjhd5An/IHsBEfxLWvX1lKrXigSxgULJKN7cYdiy9QT/Sf7PQE
 bkNv2vq0f5Pxcqk1+zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
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

Build the 6 per-opcode shift tests as a single executable,
test_mips64r6_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All Release 6 tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_shift.c | 60 ++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build           |  9 +---
 2 files changed, 62 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_shift.c

diff --git a/tests/tcg/mips64/test_mips64r6_shift.c b/tests/tcg/mips64/test_mips64r6_shift.c
new file mode 100644
index 000000000000..928112e35c0d
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_shift.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: variable shift */
+
+#include "../include/tap.h"
+
+#define main test_mips64r6_sllv
+#include "test_mips64r6_sllv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_srav
+#include "test_mips64r6_srav.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_srlv
+#include "test_mips64r6_srlv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dsllv
+#include "test_mips64r6_dsllv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dsrav
+#include "test_mips64r6_dsrav.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dsrlv
+#include "test_mips64r6_dsrlv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "sllv", test_mips64r6_sllv },
+    { "srav", test_mips64r6_srav },
+    { "srlv", test_mips64r6_srlv },
+    { "dsllv", test_mips64r6_dsllv },
+    { "dsrav", test_mips64r6_dsrav },
+    { "dsrlv", test_mips64r6_dsrlv },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 variable shift %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index d356689e54bf..894f8e9e23e1 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -32,16 +32,11 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_crc.c',
   '../mips64/test_mips64r6_logic.c',
   '../mips64/test_mips64r6_multiply.c',
-  '../mips64/test_mips64r6_dsllv.c',
-  '../mips64/test_mips64r6_dsrav.c',
-  '../mips64/test_mips64r6_dsrlv.c',
-  '../mips64/test_mips64r6_sllv.c',
-  '../mips64/test_mips64r6_srav.c',
-  '../mips64/test_mips64r6_srlv.c',
+  '../mips64/test_mips64r6_shift.c',
 ]
 
 foreach src: tests_mips64r6
-  tests += {src: {'cflags': '-march=mips64r6'}}
+  tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
 endforeach
 
 foreach src: tests_mips_msa
-- 
2.55.0


