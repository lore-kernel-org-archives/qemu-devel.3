Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D491EC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziS3-0004sK-I7; Thu, 27 Aug 2026 18:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRn-0004LH-70
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRk-0007GW-3l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM1xw3848356
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r0biU8F4qmcwBuL7Wy3Q32DrwQ2FLV40qJgobHvGsRY=; b=hwgnoWssvKsXwFoR
 x3rIvir0KrxtbsIvjlpCid1/ty/CgL0RliBY0t1Q3ipgVEsWgt9Z2+UFmK8yIcSS
 YeVpSHnsXe0hLtO4YZ6ChDKWBqrcVMY8UfRT7E8yMjLuVvEqK+TIdONOJ9FSlvfv
 OjbHjOqU/D1Su1342kfl78Clg2PMW19uo/nQo/UCCSBgoJ3dgZ/2w4kPS6Z0JW+s
 ncIvMp0JaFGRJzLxgM3wIW5rdOwMECGI52zJikUHgdO/356bv/7EA3FfEvRrUhQG
 RFaollNRzWewKtLIaYY4NXqW4R38SoV1X49vD+pAbp8saFmV6JplMRvel3xlk7Nh
 ik9vEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0ua3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so922848a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869182; x=1788473982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r0biU8F4qmcwBuL7Wy3Q32DrwQ2FLV40qJgobHvGsRY=;
 b=CSiEcKsWPRvYu/Gz9+sYi41QsFcaUTjzSHmZa/KH5r/gUslMB5YEWnb9CuLhNn7HgK
 gjuj1gFqQ+lqUWHXPwPGwgdyyA8K6sE0Sm8o8aU9tQAx1Ct2jTK8NrEK7PyLZ5ngY4ay
 6/hiArhE8hG3PTLIIZltYAuHsNEbGO+5mGNReOPRM6u2hlnY0KCJTtnMJXZQUl3nkqm0
 FgaqJ86O0sYxYVp869Hwe81nY24OIDzTFJZdxLTy2fi/G2SShfmqQu8S0qhXNmsJbWCM
 eRQRmLEfLiHYrtoxIrx/lG80KrRYfGYWuXGlXDk5Xz85i9ewnBFXEc7hXxmtv6YyQxtv
 tKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869182; x=1788473982;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r0biU8F4qmcwBuL7Wy3Q32DrwQ2FLV40qJgobHvGsRY=;
 b=Vbs/91dGuLQ4FjgoB1zifJeDxgGp0qfSmmRyrNenqiDa0XUUPZ9A51CthN8z5msfBV
 YiD+qBqCzQSNYYQElUDYFKiW/MGJ/QooTkz+/aXEiFbU1C4Ht6j08u0S0TM1aFxTRDSL
 x2A7UnwP+4t4EOK6o++O09YZtfMhYmA+cgmAmF2x4vgxJEHkeAPxT0pUtHdufDcRINPA
 6s4f5LlXPLIEiLz9PcRDsc5GbKjXRAdxfd1cEJrqFoJNrz/BedI9JjwbouLNllNehG/R
 u39R8uGm1e3VWEMAIwCqqjZE2OxdtoxvLrxaRZGy+JXXfXokDbZXWyHrzPFFP5/mGaDf
 KnHQ==
X-Gm-Message-State: AFuF++l73G30lLd9NPYGuQ6Jy7IAw71CQeGcPFhhz2Hqy48viFSQbZOx
 iUYmyIWUm4EAVerSN5UQ7k2we/Kjza3PB3m7Ez4zF4pLJ70vYHBSELgJ62vLlE7XmIIB6tTlE9f
 NbRexfcX6iwOqg+QexHEC5ld2bZqnRTtv0u2e1n5NSevIYcy9wQo+hN6MdIUGSCjiIg==
X-Gm-Gg: AR+sD12pt+HOVsPWLK5NpBJvhkvTeitGLwig/HpPY1Ry569ZzWrfx+izyR0nF6L8HH1
 KGi911WDNO08y0JyycYEA/qw7EAN8WDKYl4E7ZUWOcA1Hrd/QM029+HjgbLJvfdJjyMb5YIXSL6
 qLSwoTkxvcQ48UYeIXuEVDyb36SxSkZK6uLiFkY5lLubmr5VsqDIT3/A4Z69SGGp+4R7JXzCu93
 YcuZbtqZSbhZv5vJ5VtbfXHEaWKTyvVqr7QNiy6a/yjt9aCRp1WWuWkUemmjWpZRiD8ioAln5X0
 W22C8N/ClHJf/KaVEGt+KCknNDImKTWgqA5sTCxv/iZZAjaMsNxHC9GNnLR3JegCWqlyMRqdtpZ
 b37Js+EyHSzlMc58pVPCde1TeLNrSxCZ5iOwDSBdxvA9PsTMaXo0gXfGvb/Y=
X-Received: by 2002:a17:90b:54c6:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-396d0e24bdamr4728581a91.1.1787869181878; 
 Thu, 27 Aug 2026 15:19:41 -0700 (PDT)
X-Received: by 2002:a17:90b:54c6:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-396d0e24bdamr4728467a91.1.1787869181413; 
 Thu, 27 Aug 2026 15:19:41 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 063/105] test/tcg/mips: user tests
Date: Thu, 27 Aug 2026 22:14:24 +0000
Message-ID: <20260827221506.91574-64-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXwnpsrQsombEg
 LhdeX02RYWZv424SvD2Kxt2OIsHrqQBDh45XQXNJ5msqHA97TZjODx2c2nRguUYBywPcWzmfMKh
 JlVx88QGrkzsklGQ5H6H7DovVGQ5DMxdQGuJ5ZjGN9vm0wLuff6r4C5+cJk+tE31/BX08HIWcGE
 jmdVhdfD31f2uzxw5mMUZJfkUZm1KllNnO9ZRVXh8KSjwUqjKd8q0/yPXFN2t3o9FO08njjUtA6
 qMQHmIykD3NJuzNjh17gzE6VDIsuX6Y7/zJde3tTvyh+442G3mSV5ZLgmvzpsDtkIpJVTL6YeYI
 PJiUxcmXXMu+MX6gav3WdPr8M6EwAcc9p1q5jBC3eyQc/JxIbEmpg4VaT9eGfHlj8l/uOJoognz
 yZY5AYe0Sje0+78WlxK5/CXiLRW1lv/cSxHX1P4oAzMQrzpthXGIQGrL918FzV/3euH0bpHNqKf
 W35Uant682D2Bz2xLuA==
X-Proofpoint-ORIG-GUID: l-imuNe5z-jAmzDpJmAW_zrtVhm3IYhz
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b7fe cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=stLDFHwS15Zl94BXwzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX75Dsy87ruV/M
 ftOJgqexBVywDG6aWs8W/90AJL0HWr7K4fGnA1+LPOXGdIXynF9RNTUEq6NoI7LPQCINdYb8ok9
 re17cAZF4CHbn/HlByt+OUS5uD0h6sA=
X-Proofpoint-GUID: l-imuNe5z-jAmzDpJmAW_zrtVhm3IYhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build          |  1 +
 tests/tcg/mips/Makefile.target | 19 -------------------
 tests/tcg/mips/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 19 deletions(-)
 delete mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index dc83b7447bf..3d7438245dc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -145,6 +145,7 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('mips')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
deleted file mode 100644
index 5d17c1706e4..00000000000
--- a/tests/tcg/mips/Makefile.target
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# MIPS - included from tests/tcg/Makefile.target
-#
-
-MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
-
-# Set search path for all sources
-VPATH 		+= $(MIPS_SRC)
-
-# hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
-MIPS_TESTS=hello-mips
-
-TESTS += $(MIPS_TESTS)
-
-hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
-hello-mips: LDFLAGS+=-nostdlib
-endif
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
new file mode 100644
index 00000000000..3c4f6ec482d
--- /dev/null
+++ b/tests/tcg/mips/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-mips.c': {
+    'cflags': ['-mno-abicalls', '-fno-PIC', '-fno-stack-protector', '-mabi=32',
+               '-nostdlib']
+  }
+}
+
+if 'qemu-mips' in emulators
+  tcg_tests += {
+    'mips-linux-user': {
+      'cc': 'mips-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips',
+      'gdb_arch': 'mips',
+      'qemu': emulators['qemu-mips'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


