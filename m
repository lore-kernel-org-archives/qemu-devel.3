Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65B9C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlX-0005cq-QQ; Tue, 28 Jul 2026 00:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZkU-0003Kp-7Q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:49:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZkS-0002Bb-Hk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:49:01 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3acsd1527533
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 komVS5Q386Li/2iTO3xxjVdEjO/Jk3xRUotZcpCPyOc=; b=WmK+q2TG6ymB3A/v
 Ja1amyzEQYROMS8H8IqAZG3CJwz7ywJo+18UNaLSmcPizo2KJyF+PMjZawtW/XxD
 BvaYME9Z0tGQaHEGHEz2R8DwWlUS3saHf24RAHeiTktaXbwISkVWyBEuMqs7KMKw
 rFVr460UCKEET3I02Mgb7JBQ2P3QBWnDaRI13Xry1+E5U7GS8WthrJxuJeKXlY6T
 CYC/uQ92weWV9ywPdo9D9Oxvjvb5hMCs/dJCk/ipw/JLum/W44sR7WY05c2Pt7Cj
 43JgOcmi/wcfzfCpL4sWVRyvs2cwd6oEcBAcfogn76X/6bzscMn/JL1aThkN9gn6
 3q/euw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8addf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so4224782a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214127; x=1785818927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=komVS5Q386Li/2iTO3xxjVdEjO/Jk3xRUotZcpCPyOc=;
 b=OZDaAYV0Y0dOMErrdmQrhxd8hICZiFRGUIbu66Cqk5rGz0q9ir1rG79Y+bIG5/U9hy
 EdCJNftFx7ncgaTfFq6JZJDv6Yp8iEGWlKXHzSZM6mDnekFOry+e0xoEA/qQfMhLbgm1
 LEMzHy0ajGSeJHRbwPD/xBDxXkklItjwp4Av0FYU11qeFveV8YKiQJNCLtQc9ia+a7Tv
 /4YBOAZEStZns2RLnOUoeqj4DTeO4tB2+atstMZLuNs4ixnzhns+8qcWbqzBjINMqFhA
 JW9l95CThUJsiFk8iaC9NpTzCY30BPrwnZDYejipDbTj8bGEGHG+sza92qPG3wthu38G
 tZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214127; x=1785818927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=komVS5Q386Li/2iTO3xxjVdEjO/Jk3xRUotZcpCPyOc=;
 b=gO8e5IGURH5YB3fozhTgaeXmBgsY35mbZc0I2+Frk/9AdskyerYxEz0GW9uFFGRCwd
 1dhkmQ54gekwW48xLbaSrOnkjMavhFKt4qGnrRJ0RVlvCXv0Wplv53GTM8VngBftF9Jq
 d06ZN3VosrO5dKDMKAuCaeWNR4lBfGlR/YDrPl8H4B71jxFVIzI/mkB+HmcsU47CGpJl
 qEXxo40t6e8IoLgN8AKuw4FUKIvRhTs7CjG3U4VnGePMTxJZ8NtYxa645mCGcxxESNBs
 +RtyUIOw1xDRkAr9cOe4E+exGTxE+u0+3IM3AZjMiCI9XB2s9I8Ls63/XnxKnduXUbdM
 y1+A==
X-Gm-Message-State: AOJu0YyAK0MhDZ8+iNcyJOpFFUCONJ1rZflx2W343bxX1oeLe0Ltiy1w
 92kn1WI6l7R+SUuwQ/q2YxCtqRrselyt+q8tJM/JR20eLlSoYnqtqJ6Y+Qz9oqCnlQvRK2tJ3a8
 B0dy/m+K3S+gDgF9zGM9aYZiSQD8BuYSWC1KxFBJs4JS6UzD430Q+PCN6HtqzX5aCaQ==
X-Gm-Gg: AR+sD10JoZuvzqk15W1Xe/kY1/2tB9LS8zzrtTU7MnIMeqEI6tSNbtx+U4+QUz27tgU
 RBa9KaqXAE0xqbMY33Og07eWUmOL/LjpoPQQcNsEVKhGfcLsenXP0TMHyiTWzldBrfJoRCAuLyb
 vr6OIp8m5/H+dTCjMR3HnQ1SJoJZyXBAPbJ/7FzDRZetP/+gyhMR+HHJmJgg7d7dMIx7u4qzG0c
 cJn4FkQD8hkHWtKQNvsIASh98LEHLvDOqyDrZupBBSyx8NElKAA2sDF11YFGxWi3TJjkpifhK4n
 VXIhFDlojAFfUfzNCn+yjOb8+9sz3zENqwSoHfvG21joNGMeT/Par4+aAzBUHdJ++rkBCNEv+cK
 nZ58TlBzUympO2mOmrd8XtAxmnIhlAXP74iUr/0HuKI+1U20585/y2qQK78XXjt3xkXUXTis=
X-Received: by 2002:a05:6a20:6a2c:b0:3c1:b9c:4890 with SMTP id
 adf61e73a8af0-3c8aafda2a0mr1136070637.22.1785214127198; 
 Mon, 27 Jul 2026 21:48:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a2c:b0:3c1:b9c:4890 with SMTP id
 adf61e73a8af0-3c8aafda2a0mr1136028637.22.1785214126774; 
 Mon, 27 Jul 2026 21:48:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 079/103] tests/tcg/riscv64: user tests
Date: Mon, 27 Jul 2026 21:42:23 -0700
Message-ID: <20260728044248.137626-80-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX2pxL9ep+Vbsy
 V/aTpGHoihIdc2sAsaCTenH5jiMD9K4kMaN5FohK+oOiUyZDDzEac0jNuDY0LAmnu9AU4RP8qEf
 RMOm/zytROsWyySMflszdO2cjpVW+U9AsqvNoPXRRduaE54tjYzu+RSqQUGQF0LoCsir9n/4sRz
 NOb7mtQdjkqVii/kP61ByAGQrFzpq2huQgvSSelj5YR4lIdVW8V8VIoD5aJtMV52t/FWJ5WAXAs
 mVsrAJdpYC/p4/PF3HPkf9iCZf6nX3ijuAix3FHHv9mQzTCYJXhCJoKJ1ACcxNYgfm8pkh2c3U9
 0PVESDhgURrFSGOCSgcE0latyo1YMsRVgRB4KHy+u9KIQXwF2QeafySZ9dXmv7hgj+eNDH9GnWY
 cjJ0nuRYZKNGfCxOidOnyrz/KoL54sVJni8cz/Mjta0eqNJxvtXqm5XcXs7f3m+mbhPCt6MMOy/
 Df2uUb8KEzjdP/cREqA==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a6834b0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5DMF9D8strQ8DeCtIJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: qVs8Yqmjtb647jtIff7LN9Ioe5iV8C5n
X-Proofpoint-GUID: qVs8Yqmjtb647jtIff7LN9Ioe5iV8C5n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX4hPIy3eidMZk
 dTzFg78bisgo4ufN7nkZGgE01sFwThNt48dSJ7LiQ1zfq58+bykoemqhzCybmXpbm2wu/u8wM5t
 Lr2WOy00fQOqGJ+4W7oSYmNvu7Cyafo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             |  1 +
 tests/tcg/riscv64/Makefile.target | 20 -----------------
 tests/tcg/riscv64/meson.build     | 36 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.target
 create mode 100644 tests/tcg/riscv64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 349fd0aabc7..8bceaf7c000 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -151,6 +151,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
deleted file mode 100644
index 4da5b9a3b32..00000000000
--- a/tests/tcg/riscv64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-# RISC-V specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/riscv64
-TESTS += test-div
-TESTS += noexec
-
-# Disable compressed instructions for test-noc
-TESTS += test-noc
-test-noc: LDFLAGS = -nostdlib -static
-run-test-noc: QEMU_OPTS += -cpu rv64,c=false
-
-TESTS += test-aes
-run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
-
-# Test for fcvtmod
-TESTS += test-fcvtmod
-test-fcvtmod: CFLAGS += -march=rv64imafdc
-test-fcvtmod: LDFLAGS += -static
-run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
new file mode 100644
index 00000000000..b5f574c1377
--- /dev/null
+++ b/tests/tcg/riscv64/meson.build
@@ -0,0 +1,36 @@
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'noexec.c': {},
+  'test-aes.c': {'qemu_args': ['-cpu', 'rv64,zk=on']},
+  'test-div.c': {},
+  'test-fcvtmod.c': {
+    'cflags': ['-march=rv64imafdc'],
+    'qemu_args': ['-cpu', 'rv64,d=true,zfa=true'],
+  },
+  'test-noc.S': {
+    'cflags': ['-nostdlib'],
+    'qemu_args': ['-cpu', 'rv64,c=false'],
+  },
+}
+
+if 'qemu-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


