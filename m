Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51403C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPU9-0006s8-0B; Tue, 18 Aug 2026 15:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU7-0006mn-QX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU6-0007ZE-3c
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIn4Q1971936
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 22URDdqhinmBEgy6NKIh5uuq7h1J/PPpgxypWgqbkeU=; b=TDdjN7aWfJPp74Mv
 sW6IYERXAAxEVvK/lEX8VsRIIc3Cobz4cobcNmqtLlLMmhUuWOF4XR031CTGEg+m
 4e4ta+gGOva1bI2vuX9AWtpeW0UxmMEfgCDikNSls3SkvewCyK8jClKr5g2irG4i
 nFyEbDXWcFX+rSP2H7H0rLQwMFfXvXQ6pJZ8odbUvaoViFqEcM6PMnoHNl6k0FHD
 IIGkToVa/CEXrDteGNHIHzI0WjjavXOP8OPVOcl/1TC8OKr4xDEeW8MvZR7ImWVJ
 Z2zJnZxG8pnPlIQdSKpHR8jHQsXEWInMeyivAK68jbARgm5nqEiFJ4RP+6wM60R8
 HFWyeA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1sx8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso166969a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081308; x=1787686108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=22URDdqhinmBEgy6NKIh5uuq7h1J/PPpgxypWgqbkeU=;
 b=PzflWETeTWYOxp3g9Hckk6hNGYuN8MxfUUv1ltN6E1T3875CreON6FQTfMxBKuhpBe
 Ofoo/rPoTRrG1C0VT3V1kqbodVUvYMMz7c5jVYGP58agQXl2TTg5P+3F28M9u71gWTgG
 WoI3RugifEUfzwTboNAbA55oulq0QV66e7bTJu1QQ+mOPkaqskAmWklabqjwlOWhBgXI
 t8RxfShkep6JqkIGcaQV2OJ2U5Zq+LSJztF1Yq90QMT8fJnU23hBRHAWHsOl2Ok7GKrt
 yjSDTfEpupUBD1R8Q1/KEWetF8fgelD6+qr5t31ASVjxUvi83Lb2VpdwxqOAu0WAaBy1
 Q7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081308; x=1787686108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=22URDdqhinmBEgy6NKIh5uuq7h1J/PPpgxypWgqbkeU=;
 b=kbnw+YE2k4ZXqqwvlZS0bR3t9+0iwrtw3m40WJfvc8LhvN+Iv1zTQ7nMbynJljpy1B
 ahtvxUUzAcQIiaQzZOD+Tw5BZllnPr5Udo+3nhjfWm0XTQKiIn2aszEimgJgFk2xS+aL
 nAhcGRTM4qmvstPaeFS3/wQRPOWhHXrLBgcKj/z3Rx2qlJUkvdnp7z0RY7nT600sbl9R
 sVaIs3geWu6EOuqU+WvSDOpmqgIBH966A1qwrFZnuw7tzi7aL5K/CQ0nNZIHnLdTPQLw
 bGY+FfJHaz37fdd3aU1PW6fav9p77cEZozkA1ifUagIL/fniSzZpE267G+fcAur+00Bb
 mqDA==
X-Gm-Message-State: AOJu0YxivuB30troriX1jgqnKKaEYxKZbMf/sRhZkc0YTf1wxrTy/964
 Kt31NxvErAVdcQE8qwRqq/qjAaFRZOLQoW+ZaCr5ObYkuEx+uIHysU5Bg7lBxl8avPFMmqBq9kP
 7HYk+hIL5z1Z6svF+0PNYVV2tKnYHcNwMrMG7u9iuhi1EiRFXDaprxOnWuhllYRVRPw==
X-Gm-Gg: AR+sD11ews9PRGSg2B88yorbcsZO9xbU6/sYJGbag/RGkc6OmZfGexy7s2fN/1r92Wf
 yywugzWUfFgY7LZKwP9WBhoEUmsVFue35bvzZILm6ahh9cp8RCOuZEp4Bb4IK1WdDhNTJxOEhhD
 ++JXqGpAOFMIhH3e5AcZTJ8ChUzdKp25epeGB/ZIubtHKVt7r0MjjXfcGezjv9ouraNT0cWMuAP
 RaV1siCHnqH2vlvc+nvGSDtgxhmKCPbgnVZrnnZhTI/lcRjBXJ4PiQ6glo7oDIg3z32fNmkrX6I
 /sfd8E9mzOLwxnicgHbZi2Y7LHcOOQ7g3Tk78tDZnLkul5cF4DMV2JoYY2E1ket6XoJe6PpOqQA
 YuXUyc4DIU0ZcuaWzg15Knsb3ZgdPOyMvFTDiTekG0lmzdmKXmrKSlCqAspY=
X-Received: by 2002:a17:90b:3c08:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-3957afa5d52mr283913a91.5.1787081307856; 
 Tue, 18 Aug 2026 12:28:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3c08:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-3957afa5d52mr283830a91.5.1787081307330; 
 Tue, 18 Aug 2026 12:28:27 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 065/104] tests/tcg/mips64: user tests
Date: Tue, 18 Aug 2026 19:22:29 +0000
Message-ID: <20260818192309.22169-66-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1zfM7g15rTAx
 N49HIY7PVsgF1X9aSHnUUb4p2POyAVG1sdEs/DO6oyWK2mdBru0OjPPRpeW2ELpcs50JPrGA/cr
 q+NI1mI+fzQPEIDRUpLxDTlOuhS/+I0=
X-Proofpoint-GUID: v4k9XN3CKmXcmCOaRFvuKyfO1ygI8qcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6uNn7Cwu3hXJ
 DqLjlaMHx6//hduQrykLw/5icpAhvWKPYAET9NGPpbWTw0Xrc6v9azLNZSFLZtZfrvUpSapAQsM
 wTXet9uM6kRn8HrZTmi9i9HIJRQAZyMPu4bwL6/s28ff9XlbJZNSrbZPrDBgvgN4oYueDJF9wL6
 S9K0+fvzlly0iXNodEzOH0Fx0l90Q0/JKi+fdFQCSFXmwoUSl4CZEj04NAGvF94x+CXrOC3jbYC
 rhN9UoEpuHLoY0l7gEVWSKXr5k7pauwQPQh1WVOs0r3u2BkGy33Kt69invMTwxD/mQqnVHZtGzV
 oFe38cM/O2P8CC+9RVVNiYz8Qt2jO4U1pJUNcv6rJ6WHVlY+pNSGaiK+odc5PfKS3GNpfOrsG50
 hgkoZHXrHZEQFEe6mMk3eUC3uhKTD/b95f2r78DKJCqQtT7iRKgOSLDjywM3xRwyQ+y0jGtl0UC
 VE6JKEtYeXXfqtKeXTg==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b25c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=d1guRcTfha0oDln5RU8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: v4k9XN3CKmXcmCOaRFvuKyfO1ygI8qcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64/Makefile.target   | 20 --------------------
 tests/tcg/mips64/meson.build       | 27 +++++++++++++++++++++++++++
 tests/tcg/mips64el/Makefile.target |  2 +-
 4 files changed, 29 insertions(+), 21 deletions(-)
 delete mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3d7438245dc..0102e74e8a7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('i386')
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
2.43.0


