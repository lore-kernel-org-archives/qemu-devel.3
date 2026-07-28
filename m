Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B23C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZkL-0002pU-Hv; Tue, 28 Jul 2026 00:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjX-0002Gh-Lb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjV-00027F-Of
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aXc11714737
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a3vmyNpZhY5+KeR6alIgqTqDzltfYBKEWV2pN9BgLEk=; b=Za92e2zkRPOsm7D4
 bV1era1GwFGUAvWQ8UraEONvS4NOBkM3G42SyyT4F0wAWyl8yyYuUK06xNsiJz1Z
 IjThcuL+vuB5Fl8cuUz2bvtoiUballW58Kuz4cHPWjyreJn1jRtqq1rtoKlPGSl+
 JPn9lz3TcMl6U4z9C5os2CO3kaNqeMtAXfalSmXdNM3miy5RjN7dK/BLcrPXhQSI
 Sw47VBD53j6TgF1C106aJUDkIhVQY++TDGx0hwKEMewbhGLN5CWRrYudD2Bzm8FO
 /EWvPgMASbI6cKZO6X6wqbRyDUUfdh2mvx6IOR8+AzGVtHHeh8YFMFAJT/fk5kD4
 /O8wkQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjygq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so530762a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214080; x=1785818880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a3vmyNpZhY5+KeR6alIgqTqDzltfYBKEWV2pN9BgLEk=;
 b=F5vyIJG5VtNCyAMP0lPQb9/pjYjctQ6zDMqIy/3W7NJgek+eyBwU1JkaxLLnN7JNJf
 uX8kBqE8FRvi30xnD9Hm4psDZfrOOlEPWwAqiKJSPrTHMpnYC9+XtxC3QAoI0SQ2AIc/
 HoZWkjf9BMXcyQ7b7agoPgKC8JOTbVVzM0rZ9juP/8M2AbVCUy3ZP9S9u/+nrf2mA27p
 33grTqoioESm5D4/X1y9gWe3X4ukckToeKC6oen2O+LEtrNeyyAMnZki/txLzK+uQutl
 20NmDHMSFqbkRcw6D06FdlVHHPb/83zdCCCR5WkI9mreefIQ2b1L1bX5+Pt9elKVJc1A
 zqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214080; x=1785818880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3vmyNpZhY5+KeR6alIgqTqDzltfYBKEWV2pN9BgLEk=;
 b=I4m8zQ37d6w4Vd02IjvsEw1Nw7d5xiWMrNqn6QM8hC2yuWXFvO8o2NbKDuoEtODztd
 /Dl4tI6d4fN+76gHJRXsR4fGxqx3sQFb/XkqDedr/dQDgJzfW2PNspfT7tHWHMfSyOz3
 YT5RGZqnpIGxXmgZYL7L/Umhw3OTT1m5zBYVArUSPcTlTVy0RiUrQwHWVSnLqe15FPBp
 E/Y/GvTLy79buiy+WvsIBwYxr/HB7K4I463+WVG6OSguzvO+x7lKjYpHcL5CoCERMXyF
 vVl3VSJ6hC5t6qKqQup/T3pHFzGa+QWfzFpQi9AdYf1yPLpC2JC+EydqItb4SRXGMMIu
 TkLA==
X-Gm-Message-State: AOJu0YyUhVoPw24OMZkj8VnISvo9MaLscpaonzJx7dCMLzclBU8AAat0
 WhcJIaEQgxjhTbLQY/rmA1xVUHUY5VmYs9zcUPURlPdY4J1AVUBQhzEjUuTcUnya6TT6mpcjMoT
 Tvsh9NxqJAMuhv7b6dgk6srf86w8Lq+pFqS8LdptYIgsd42AWmbbAzDprCkfakOZ+cg==
X-Gm-Gg: AR+sD13IbTqZjeNJ3G/3dGJb0Izz0Lb4ge1if7+df9/O4Ds7doOExT/ycbFqyG1n3fg
 9Gjxkv/f6QheezBFQmi7zKWr+cAwG6ZDEfKpMLbXZBEknk39oUvVCp0dNXymmL5ZW6kHLIrqVIY
 +bvVmnlQyinBYxR2ZYLw6/VJ+n86LPqHL0VKKtaJds0Be4AOp3iMo6vymmg7n6aG/lCWg9eHQQj
 8Kx55bB/PyhFxkHYYYV0v26JCTqsB3tw/Vs8CnmSXYyw6dOLTUar+sLkiKpOsIGFQbz5pbp0veX
 56ibgaS7nmLRTpPam0N5ZAWQQWLHR8JbDhwBFLGVAlLHRJvWcnB/XeQvHlBYva7uC3XRA6BuWEb
 3CR6svKMabi0TgDbXcyN4v2+/E14cdjCpqvLn/Ngp4hc2izFToKSwFvBixgB0WDLJhhozDRA=
X-Received: by 2002:a05:6a20:7287:b0:3bf:ecf8:abe with SMTP id
 adf61e73a8af0-3c89cafb38bmr1327881637.0.1785214079638; 
 Mon, 27 Jul 2026 21:47:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:7287:b0:3bf:ecf8:abe with SMTP id
 adf61e73a8af0-3c89cafb38bmr1327861637.0.1785214079228; 
 Mon, 27 Jul 2026 21:47:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:58 -0700 (PDT)
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
Subject: [PATCH v6 059/103] tests/tcg/m68k: user tests
Date: Mon, 27 Jul 2026 21:42:03 -0700
Message-ID: <20260728044248.137626-60-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qn1DkFqMJiaO8nOzVOAmfYGp3vZJdgnZ
X-Proofpoint-GUID: qn1DkFqMJiaO8nOzVOAmfYGp3vZJdgnZ
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a683480 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oeoYDfJPrL2azRNJ8Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX4czEIgPukULu
 n9+FhrJSz9cem7Las4RF5QjPZpgr62IYmDDk3m05UxVCE73WUuAVruTqcoEKch72D8dd6gHUgPJ
 xCmQ71PdxbZZBRY61pJsxU1fkVFjNNxInOcpcOlNY6W6mUoUTH9Edc1Bg2RSLXpy/aGZP5+kGPM
 M4LEqlAOEv+a/ZmjPkkGha+Ke+jkuD3cj6HojYnW4Q1tgfwm6YcZe1z4R6OfWEApBjcukO0pPjY
 Q8/W0FD0GlYOw5sv5aO3fc+ZBNW3nlfZRzSQM1+6Wdg1uT+3HiVFRQxuxu7b9xZYbv/XVHDE3ZX
 /WHzIWLphni0POeU9itpJj42mt2Jtunjf1ibsVrFjW5JwVGZruuCixTNGEa367rsKmsCQvmzDFJ
 snN9ToIXeG5mpSQiAKFS1D/2WMCs2cABsrv/CVUxiSkM6LsjyxJergJiaa/uwhFVmv+qpxcgnfM
 VRRx5LbKTpayBWGNRug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX/+F4GMDoFXz4
 jRjo4M6N8JR4ymupXeEG0OeKhuY6MYujcJvCbT8YffYz+HkgFCyQ2l5EVDFcFDfI7uQCv77syHY
 d2xvtkhzNm6TlCA7NKsuhz5leMZlkw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/m68k/Makefile.target |  7 -------
 tests/tcg/m68k/meson.build     | 23 +++++++++++++++++++++++
 tests/tcg/meson.build          |  1 +
 3 files changed, 24 insertions(+), 7 deletions(-)
 delete mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/m68k/meson.build

diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
deleted file mode 100644
index 33f7b1b1275..00000000000
--- a/tests/tcg/m68k/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# m68k specific tweaks - specifically masking out broken tests
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap denormal
diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
new file mode 100644
index 00000000000..8ecf450ac68
--- /dev/null
+++ b/tests/tcg/m68k/meson.build
@@ -0,0 +1,23 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'denormal.c': {},
+  'trap.c': {},
+}
+
+if 'qemu-m68k' in emulators
+  tcg_tests += {
+    'm68k-linux-user': {
+      'cc': 'm68k-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'm68k',
+      'gdb_arch': 'm68k',
+      'qemu': emulators['qemu-m68k'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 30d7f1a7344..10c7b21e308 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -144,6 +144,7 @@ subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


