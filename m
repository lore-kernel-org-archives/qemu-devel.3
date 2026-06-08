Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C5BCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbqh-0006G8-Jl; Mon, 08 Jun 2026 11:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4619146f5c=eblot@meta.com>)
 id 1wWbqW-0006EG-8z
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:25:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4619146f5c=eblot@meta.com>)
 id 1wWbqN-0000Ry-DM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:24:54 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6588qoUR450713;
 Mon, 8 Jun 2026 08:24:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=bLBZgXPwsgTWZN0lTz
 VAS83AJlcYlioM7OeN01gaweg=; b=n+KFiugq0rNLIFhgnlulBGbIAMlhPoWrS4
 0r5C5+RNrFBOJEh1nvtGSrGil9od2VnQWi8Q53/IiuEPe/eANz96cUetE8qgGnSw
 /1Oj18MTauHxA+KlW/hkfHrzBkqniiAxgdYDuqkOwB2oGRkHxagxPgShQH40VYEG
 Y2iGq4Z/LgdFG5EVnjlMu9FQKU/9SLRdF0P88Yns5M49+BiZ+yZ+ILaMTjU0Etsi
 INlNhI5y9X/lngcF7Gsy+xYVfHtNL8l3N6iUGy2RvUh36aK6w37tmcASz70qjm5j
 +/LdLYeYoZA4+uZO7aFhoW2keUiADkqcjsXkoAfVyNIbLQSnFENA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by m0089730.ppops.net (PPS) with ESMTPS id 4emf1ssk65-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 08 Jun 2026 08:24:45 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 8 Jun
 2026 15:24:44 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Mon, 8 Jun 2026 17:24:24 +0200
Subject: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260608-testing-macos-v1-1-42774498936f@meta.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqEMAxA4atI1haqg/HnKuLC1qgRrNLUQRDvb
 p1Zfov3LhDyTAJNcoGnLwtvLiJLE7Bz7yZSPERDrnPUqCsVSAK7Sa293USZusAS7fAZK4TY7J5
 GPn+/tvtbDrOQDe8E7vsBcVg/+XEAAAA=
X-Change-ID: 20260608-testing-macos-b95676cd3f86
To: <qemu-devel@nongnu.org>
CC: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780932283; l=2537;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=URyxt08pTQlxIIkAKvDMUQuVL5rmXvlZlpoVr7f+juQ=;
 b=nb39DCBlH2bnvmXIFL3SzvyGkQcYa4TTX17PX3bAw9I7v8Jm4y/OH/Pbro7ytK1CbJ43f+7Hs
 /UFhJUwrCjXCb3V3sa9nikB5ujM/2oeZY6jYoScrn8C1JIkIND4sBvf
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c0a8:1b::8e35]
X-Authority-Analysis: v=2.4 cv=DcwnbPtW c=1 sm=1 tr=0 ts=6a26debe cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8
 a=Wxe4bKpe3w3-Q3TRPKUA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: mf4XSRiw9vECEqIJ9K994AR2955442KK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0NyBTYWx0ZWRfX/91xJHlm6uPD
 2/ZygmmTL3SQ/Y0e673btMwPEv9f5bs0ZH5knWKEm0JcvxMVvH0SbR7Zg5zGEuJzBswZ5CE38OZ
 sav7Nw5gVgaVFcMGNfrttAq/XPfs2yVSpMDOFkYH4A/DOUO5EEGxmMzl7jmTJRjPYsNJ8ICCuLU
 yzTPka0UCNCvzvngE/2t35d38gCKzgDBWNmD27WiKJUDAAWo6F1IQ8vfSG50x8Yz2umgHKDSnlK
 ZM9yL1DdPUyDLXrvBi/mFkYvkbluj6y2/49crfU3yqcV8cuLf8GNwXQuoiRLiz1SfQTxcH0UX8U
 MjG1dWc2gU+D5aYOz1vvJLu5T2MIZLuSGcGlw3sb+DIHqsMCUILtwvgpw/0DUYByvEOPYIehOUt
 1M4BQKInRHJP0CAe3TDecsLmZYJwLFDvB1tgAwQPB+ENRDxkXIKDu1Q4eHzB1EPYG0N460CJdVt
 oh6csNbWYqF3t2+q7VQ==
X-Proofpoint-ORIG-GUID: mf4XSRiw9vECEqIJ9K994AR2955442KK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=4619146f5c=eblot@meta.com; helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On macOS, plain QEMU binaries are named qemu-system-<arch>-unsigned.

In libqtest, qtest_get_arch() extracts the architecture by splitting
after "-system-", which yields "arm-unsigned" instead of "arm".  This
prevents the QOS graph from matching any machine node, causing all
QOS-based tests to be silently skipped.

In the functional test framework, the same suffix causes the arch to
be parsed as "unsigned", leading to wrong output directories and
teardown failures.

Strip the "-unsigned" suffix on both code paths.

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
Address issues with liqtest and functional test framework when run from
a macOS host.

Unsigned binaries on macOS may be appended an `-unsigned` suffix, which
confuse these components that rely on the binary name to recover the
guest architecture. 
---
 tests/functional/qemu_test/testcase.py | 2 ++
 tests/qtest/libqtest.c                 | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index eaec1bea13..2885fdd44c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -204,6 +204,8 @@ def setUp(self):
         self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
+        if sys.platform == 'darwin' and self.arch == "unsigned":
+            self.arch = self.qemu_bin.split('-')[-2]
         self.socketdir = None
 
         self.outputdir = self.build_file('tests', 'functional',
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 4e22c66b75..e31f060152 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1033,6 +1033,12 @@ const char *qtest_get_arch(void)
             g_auto(GStrv) tokens = g_strsplit_set(sysstr + strlen("-system-"),
                                                   " \t", 2);
             if (tokens && tokens[0]) {
+#ifdef __APPLE__
+                if (g_str_has_suffix(tokens[0], "-unsigned")) {
+                    tokens[0][strlen(tokens[0])
+                              - strlen("-unsigned")] = '\0';
+                }
+#endif
                 arch = g_steal_pointer(&tokens[0]);
             }
         }

---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260608-testing-macos-b95676cd3f86

Best regards,
--  
Emmanuel Blot <eblot@meta.com>


