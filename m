Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C004606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HtB9s2og;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z8uV0l5m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqq0-000760-Ik; Fri, 30 Oct 2026 13:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqph-0006ME-3Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpf-0008FN-F6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu26u4011238
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uiBgXIYWT1lKSeD68gMwZsgRcMUOVYm6Nfc+9WFPjig=; b=HtB9s2ogLp4kP1zn
 2vIiwm/q33pK96P6PKuOQEFU1E5Xa/RqBKQKsYGri+4PwpEP7WH8kwVIGRAiyMXW
 UBSxCd0Y5+BsObC/TsyZ3IDyMsc2ByzrnLKvZzIOeZ2IV4K0F/49nb7B1sOKzZCz
 k1JWQ+MPev3XQFuREYWLfLZo84Q2FHYzhEe1TJOlFye1F2ktwZH9nK/jSg6RgRsk
 VT/SlkrhE3CDn5yFQsYtyWhVGZdaLVRMjpd3L6F5D/iDWzAfhqrDWl01KBk7o87s
 UrlFBOUTwuJN6a7h5DrE5J7+exKT0dHX0QwZhbLq1II23IqhD8ZIfg3Iq1Jm8u6q
 cIBGRg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm8d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c861b562eso19304956d6.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382956; x=1793987756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uiBgXIYWT1lKSeD68gMwZsgRcMUOVYm6Nfc+9WFPjig=;
 b=Z8uV0l5mgY1CnS48+oayDg9GuoW5zd7c+ls/vNV1f3FgwpDwzJPxXqF5lg3v1Yz2pW
 uX0N031b+hU/rqvBXgWYBitZQU/CzxKyhuhBM7NoVcP/mUm8DEF59zrdgl3HmVJQPIj2
 BTZ2SsQ8P197uaTcWeFoaS4nTa8gNRjyG1KrzkxkjN0FxJl3JqX08J8jgjjmNRlh7DUy
 OJgctH6YXNrSBBGs3OJlOsPXatHhR5nu4E8TucDY1jAxH12kbZ/MPVVVYJi5lxolHJHL
 2GMNqux7OrMcjl+LXCqy1eioT6vIBywrPYeug6auQBzQ9CnqW0oh4vNek2XuvTfaFXJ5
 WbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382956; x=1793987756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uiBgXIYWT1lKSeD68gMwZsgRcMUOVYm6Nfc+9WFPjig=;
 b=qA5ITebqEa8hTvZJhVik71yuntfk099W4RH+p2OEsyiE6mQL3nDN13FJa1g10wGaSV
 hYz6+TsovyK1HX/OQIrQDFkBPTnd/jl53tp67RQsPwoI0E1nML78q5oWzkbVzpzFcZbD
 3cNJDr8el/oMqFN9gYfKPoJpUeKIMV+VE4TspQ4BVh1AMNyOmSau5yXCSwcNPaOltyFV
 s9AkS7jdc0fbAuNrUDdk/hSWGm0qnyRDUsPNhrl9gy6LWnEiZosqmeQJRQwdta5IhpLv
 R5HcW5ejfBv/VQPRMOZcIsDQmFb7UnpFGeKm5Qm4JM/f1Q50DrXTAC6jZ0IfnDgJ6Pry
 B8jA==
X-Gm-Message-State: AFq9FYJfHiqnL6vb0mlUmw6XhzzHYl/pvL9wxx1ZSc/6p4OjLIWWylZb
 LLaaCBP772CZzBWo5zw70xPh0PDBRNxftC2rrtonAN2oIWMvQDKWWRuIXqYNNQ44O57XmwdzVCk
 48GD9l39FXiCVGVQr9Lhu8g/kvgMaVq9CEGWnvDCC7wEmfL98ou0A/Jmi6VY/rxYURj4E
X-Gm-Gg: AYBFou2Tnc5EIOzqipAqrszwnvvT5CWQsC9DYM+1M/TkC0KXct98rM80pRSktCRMu9h
 c4n/+dl2kqPYgxBrFT3871WuJhRMtw5kp52fxdKjwdt4hzTAaoIKar6Jc289g0WO2uSsMAmNqCB
 dStH2/7EqEgc7f/1tigUsZjacMSbSIK0aeo1QfO9DqT3AmmzzTjc1cNuCOr2/XiC1+158SdfLy5
 dOc8oYCmC9TWKSaSpZUSZeL3QK2YRDpZVhHzwDPa8HBzTtF0/0L19ZIlcgnnoLBZi3by7ejAXxP
 4ciPyulaK2NQtzPv09UeWmY8yduoSSJhtvgcRMrbJ12kqHquuaCDL22hhhUOkmuzaChRFvMWdYP
 CFbhf47knUksYbHEShA8XSf258lG/SdHSskpEuF8CrL0bS6wJivm/m7x0dFh4sEwYroPQ9jWnXi
 JQwU2vnnD5UQecOGQn1b/DAONcrv9J+w==
X-Received: by 2002:a05:620a:8017:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-9442171b967mr524099385a.26.1793382956230; 
 Fri, 30 Oct 2026 10:55:56 -0700 (PDT)
X-Received: by 2002:a05:620a:8017:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-9442171b967mr524096885a.26.1793382955750; 
 Fri, 30 Oct 2026 10:55:55 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf7146621sm77996885e9.13.2026.10.30.10.55.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 14/32] tests/tcg/mips: Group Release 6 shift tests
Date: Fri, 30 Oct 2026 18:53:36 +0100
Message-ID: <20261030175357.99684-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 45PVoKp4zaGkWXHStsjURg9jRqPecKdq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX3kFi/dt1dDg4
 v734PVPKf2HTMb4w1iyX8MXKcpGbqABK9YUl8Xr6TCmrlRW2U06MCp0VNfhAlNzK3MNOxwsRZ2N
 i5qWL3sb/eFcekHgvrCSPcrKpqZcAok=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4da31 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 45PVoKp4zaGkWXHStsjURg9jRqPecKdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX3SNpLvPCsOe1
 iSQcZezjK6zIUj4imjHws9QofKESonagYp5PZMHjOBJXwdYkNfJnrelIPa73RXVYzNzxHDF6JhK
 P5TLnu79qeLKH/x53wBHSVhC8Kklonez8ssLT3O11EejU8dj0N/YMpynz/6YmCNU8uoLKO8M6Ee
 wTD/m1TmZycga4Rg7HRlToNdm+gJ+HIvuHlZaUe5H+09glaJzoiVkhAmMHKEovjZAikQdL6zY4f
 hAs/kL8VsqSZAbClo8MahOFooFqaK7FOSlm98RHCq1f6R6eTIVGE8GUGTUllhYKOIUOEtTuL7/q
 xXlOpgxKttfJWUg3dVVnCPqYyoDWcvCvfZnRxk0V4JV8lfWzT7q/sCm8+1SHRzHSS5cjqvArXO0
 7vH2+4vNpcjcSNoXL6yr34I/NzpfhckJiJ2b11U+2mmf1hay0SbDSz7cMkKCFbilGm6f8KcpiTe
 TUHPslcADA7/eVfmwLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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


