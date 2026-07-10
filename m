Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEA2C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ68-0005x9-9x; Fri, 10 Jul 2026 17:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ61-000591-MI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5z-00051O-G4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3KnE1832515
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HAWc/zJ+kRI
 VJD4HS+c3LUthROticxb/WHb9/kCP/w0=; b=pXUORwaYRQH3AZyXEaKnZ+ibwMK
 ONGgG+PQy7cmWZKmVCSGdA56zJeSRqGSItyEs7ZhRAMcBHtGnWtqCTqPO/HZYM1f
 7y8QTLKWs1uaYkBPe1OaQE40TJbnxvF48AFJ+BiBEVypmDwanMeidLn4PV1WNSE+
 7Laq472TYGFb8BQCwVgIFHhe1ytbjQKGjCjmDRpgMZO8BkTdL41fCv8LW0CpdLzG
 ExqRm6gHsyLLUoN1tzlMZ1e+1kf1wne2rQcltth290AsRFX6FQCI0aOvKooWVD5f
 Y5UiIABNiOIBhudWu8wd0nuWop4PBYZep9k4xG57sSeABCplcpU4gWIcXRw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwece3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37e24235ce1so2564519a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720147; x=1784324947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HAWc/zJ+kRIVJD4HS+c3LUthROticxb/WHb9/kCP/w0=;
 b=ABq73612MxGYDQakwQVyz75yfriWM2V+R3PgUzi9LqwLIcNa7Xfkx4TMLxwajVveMw
 rty9psBdjEoTsgE9nrjgYfMjJPHrjsC4yhD1e9e0GcebiYLsUA2vsyo7IaLwpLHqBKvX
 SA/jDrMfNVO16r/cwgdPk7kZlqDJD6i4C2fDOQuKHVsVPCC1Qm3K5RBgSVt8pz7iKjld
 RfEc3IOpio6rXunJlgs3DjMMRROrENjO2KCcEhTsr2ri4Ih0LmD7XFxIpGpmT9eZ2Qf4
 ILmowNOAmZR8NIdA/boJhtVLLAVD/eOKE7njU816cl22IovbAy7+8yDU4T6bfLt5UZ0z
 2cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720147; x=1784324947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HAWc/zJ+kRIVJD4HS+c3LUthROticxb/WHb9/kCP/w0=;
 b=IGiD4Wscx3qHEr8QMd/C6QCPavMqsBy+GUZ9MdJu23aAaFEIlmbVS8jc7OZTvi30YW
 Tri+VzWEFsvxgp5krdkKeJ0rMFFXtOQsGFzMKpCNqVmLKg5IimCpqbs7EQfwd2h54sfh
 1m+7QIi5jGH8pnqZNHEhu/6nZzbadB6SpW+LFq7TgTAc5WrTNfas2VyVUy0RSkWqXgl1
 V17O7o68NsYQq9RPZwVEpF9ND02GI+74TfylLwI0pX3Rs8mLk36ydDDFYEszPB99c4IS
 GVIYVJcYbbupDMw7ke/ebjU2GufGSJGFVBZWSeha9z9dURSQUpdZRsdCJXXtvsMz6mw5
 2SwQ==
X-Gm-Message-State: AOJu0YwXs03rycx3Khb4kwjtjrZQ3B4t2RKKjfIaIMcaTi38zSE/Pf3p
 KYtCKWE5HdbjTLTEeLN1hD+rJro7Kuypum/Aakmd65VSS90oMKJalNGAH7ndbTS0figcZUjkhL+
 QHAUO68b/IANUGI5ZPGV0izHSVmJFi4BDBd3iDVKbO73mI0GgncaK/qe3v9K1ioxhvw==
X-Gm-Gg: AfdE7cmsXPykrLUzY6ldS31N7OpQNWyrgEYLnTERH9BnA6eZ9cYpFKca9BUlgvx/ADl
 b+9X6K/16X21goh4gUPBmzBoY+sgdBKQ7FqrslDoAz+DgTsdUhdVeCcydO6aQs9PXijnNPaYNWb
 L7COIGE9onRdZK04uEnnr3sQK5oGw6OE+8Z9VTtsk2tLnzWT4R4lb1TH3YcwFnOymZtllSUnD6D
 xHQof9BYDJJAxXynpTsLce1TQpX0vlXBtq9Jn46804UDv75DI6SkjeSpO+Thi/Bwq4rpbpKXMQS
 JCkeWtbwMpcoW30e+fJvG05SbLV8BCsJ6kQvVw1W1TNCoMLhi+ZS3z6dIvjFplZzfxwzK1jFH2G
 ZbaEIH9q5RPYzzrsP05dU/rNdoCxy5lDVk3QQtoSfmR5qc8JhbEgALYTPY2NGhtXPxpBVxxyY6c
 JJo1JMGw==
X-Received: by 2002:a17:90b:4f48:b0:36b:a2cc:485b with SMTP id
 98e67ed59e1d1-38dc7769d4bmr593818a91.21.1783720147451; 
 Fri, 10 Jul 2026 14:49:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4f48:b0:36b:a2cc:485b with SMTP id
 98e67ed59e1d1-38dc7769d4bmr593795a91.21.1783720147030; 
 Fri, 10 Jul 2026 14:49:07 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 63/98] tests/tcg/mips64: user tests
Date: Fri, 10 Jul 2026 14:43:07 -0700
Message-ID: <20260710214343.2065491-64-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5168d4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=d1guRcTfha0oDln5RU8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX0ZtWj3KfxoA0
 hCfWm/PI/fY71uFFx3kFfY6g8GJyFGGEM87VhDfrRRoT1/4WIKZDD/tPz8GQIyMhG1XWDQPQ5ZT
 UoK0epoDinhnELy870mj5n5iUEwgbm7tBxHpjFPDW5Dx27M9+fL6ir+MIOGmr0f/TMT8hP96Dus
 F/NPFfu9TpBSpRVcWhmvs5DJEifnH8J+d7M1jGe0Bm1nY3mx2qQ5ql+Hy655HezzTUCkp7TY5Bm
 NNtCTaU/YPqPG8Gqce3irF8Emave2qRoCXEQnqWjbRqSQlc2FATuzNLT69O3Jne2Nb5lD5wkike
 RxMAJZBwnUneMaoz3CFzfk3AeN4ol9tQDkOcNfFOGzYgrz+kKYoy2dOYVgHyhE8J6C1VN/mvd00
 3e4gAYRCfpfyqaNZijb1SeQSnif592iRY8QrwC7StmYGn4Lp0yI4z0sDmXASWp9QXQAePjL4Y1w
 x7g+KwMnEZGjziY23rg==
X-Proofpoint-ORIG-GUID: ShS94eTohtL5RrAYTOUagk-_t_JUX-UB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXyWMVVBjzkf6z
 4cR/JN1YbE+mvav0ZdwW2ag1bXf+LnYE17ghkS3Fi+dkONAz2myowNFSKVnl+Zzs7n3wf1b2Cqx
 vPWvj0CtPgxSTqaLYUREL+6lsgRQekM=
X-Proofpoint-GUID: ShS94eTohtL5RrAYTOUagk-_t_JUX-UB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64/Makefile.target   | 20 --------------------
 tests/tcg/mips64/meson.build       | 27 +++++++++++++++++++++++++++
 tests/tcg/mips64el/Makefile.target |  2 +-
 4 files changed, 29 insertions(+), 21 deletions(-)
 delete mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d8a96802d57..ab367896bf2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mips64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
deleted file mode 100644
index 042855844a8..00000000000
--- a/tests/tcg/mips64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 - included from tests/tcg/Makefile.target
-#
-
-MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
-MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
-
-# Set search path for all sources
-VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
-
-MIPS64_TESTS=octeon-insns
-
-TESTS += $(MIPS64_TESTS)
-
-$(MIPS64_TESTS): CFLAGS+=-mabi=64
-
-run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
new file mode 100644
index 00000000000..69391c23187
--- /dev/null
+++ b/tests/tcg/mips64/meson.build
@@ -0,0 +1,27 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  '../mips/user/isa/octeon/octeon-insns.c': {
+    'qemu_args': ['-cpu', 'Octeon68XX'],
+  },
+}
+
+# export tests for mips64el
+tcg_tests_mips64 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64-linux-user': {
+      'cc': 'mips64-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
index dbc5f8dc5fe..78c722a583d 100644
--- a/tests/tcg/mips64el/Makefile.target
+++ b/tests/tcg/mips64el/Makefile.target
@@ -5,4 +5,4 @@
 # MIPS64 little-endian - included from tests/tcg/Makefile.target
 #
 
-include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
+#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
-- 
2.47.3


