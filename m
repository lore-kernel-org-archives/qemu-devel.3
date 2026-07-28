Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E17C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp4-000786-BM; Tue, 28 Jul 2026 00:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo3-0006DX-JK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo1-0002XZ-Gk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3apHc1673508
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7HMezCuaGzo
 rLtKxvwW5koWn22u+AMkpCEFzXTMYWUU=; b=GSJ7LqyeGiLNF2ZYj1Pzh+wWB69
 m7lzaylrZMkFh9iJKktB+ZYnmoGJ+CzyMXw3fxC/uKHXHvTX7q2jqwaHCGDjXtos
 ltmaxISCeoVp8R+uGHQNukM5vGaNjk3VxL0ER2gYtyV5YGu8VN3vxVb60TCZGkUP
 NTh1RNewUoD+EBIiuzGOVLUndKj0gn+fr1FCJx1ETuCVNTj8E0Co7uV2CVUxG+Tv
 Nn53Yx7OSui1yvvkkFk1yn0IHV6hloWGLalTqW6t5YCEKosN51je2Bf+G0PYBqwY
 2659Usa6m7Qi0rgnHNnNxDQThmSL/xS+r8jxPgCCdWysntAdjd+bD9XLMLQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstd2d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7621655eso6469919a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214359; x=1785819159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7HMezCuaGzorLtKxvwW5koWn22u+AMkpCEFzXTMYWUU=;
 b=C8bhnntUFSFTF5l9t7eXXp0FjWVnldGMWlIxXiC/SHwnwmmkrJEZ/38BoZ/JqxPDx0
 FHRj2mBUzkyezF/0rDq8JTacD2CEr9GXjOwajZpVBdAiQ6Zpt9bp1ZL7EhbRCw3QeBwJ
 5esW9KXPWWcRllJJsGCIBTKNvnORxqwvTHRHuxn5ScbZoYTRzj/ypRTCGzKNWBBD8F6d
 /jsIdnymvvWCPkTj714REMjVotMrju9gstBluIex2Qcna7qWuxrrnxQkCvHXtRm25vaS
 uvCrG4geHlyKZyi4Nsidr2W/nx8hwx/R3C7fnzpr6OIura5tIuqwy79wMprJlTHSye0W
 m+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214359; x=1785819159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7HMezCuaGzorLtKxvwW5koWn22u+AMkpCEFzXTMYWUU=;
 b=My52axKSThITjBhom0i6u1K/ICfDanpSx/qzlrP2Xv3dL0WlCV5ZkiuFailm73kmVQ
 2helXs93uK6X6J1+qFRone2on2GJzDg93ELB8pg3R8eOZsTPJimP3eufvslWfT2YqpSZ
 N3WKPG0ybr1Oz9Yd49ZHeGA2b5tIXckXqWJuwEfkxAfQ8rjqR4o40HXkXn9dRICIIvOA
 dQyoRQhugGMvskqiv68ICBw6ZXdiKsBlS9z6/ORNwXvfIWq4H2pg7rEXURRQ+CY6Q2NF
 8y6RPVhW9CEJ68YVEg42Tl3EKg1H6kITCZyoC5SnaYAFYT6MCEF/J3M1L0dE7Z5M83Bj
 8wNg==
X-Gm-Message-State: AOJu0YxxLAoiJ6Z07odgqFbFM85ewOGZdOpxROBA0js0heNVEH/iuHOn
 bw7GwjAC0UK+hpwBcOfGo70plau25lrzs82FB0SoTK1JNfrGcLDtrLKvtQ/pLWKcZAeONroqbwW
 kxTNcfzXSRLhe8EO8fzqx3L3GlPNwL0fd9hPaSBhtvWXCc5qBB2BPf3ljC+0AHiiW2w==
X-Gm-Gg: AR+sD117tE7xMOpS6sc49jtJi9+45Jji4py2kJDECKBN/IKtEGaKU3IrSSWmLS32mxw
 fhhntH7+6nT82Qu7dZ/O8oB4IaTkcOE7yGwv9B7J/Pun3AhBXIcDGY/4DEbbUe/Gn2CGGJbweFH
 F3/JoH1eiYHWWxuPr/VfPOvO5FuMUlkPw1B5yEu5RRkFPQv9zJW8lGO73wJJALFDxYtUbSSN8t3
 4d1273IUX+goRVt3DdTemPxGLvfxCMYvjLdtfnCNCnXtHV+XuDLaVyyyYgXn11cogi91iN74dZc
 QeIdkjM7yODDtfsns29TRQLzW6F4P6LA4LjRWsXgL/MqFO8Ad+HYgiG85D9DcziumncIiE02hoo
 Yl3cCgNDOu70Bz1xRK5XGfD9B2lDmaJr/Q6RpZCkxTPLKrfk1K/V58WF5XZOiCH9EedJfTkM=
X-Received: by 2002:a17:90b:6cb:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-38f6a33de8bmr863116a91.6.1785214359528; 
 Mon, 27 Jul 2026 21:52:39 -0700 (PDT)
X-Received: by 2002:a17:90b:6cb:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-38f6a33de8bmr863092a91.6.1785214359074; 
 Mon, 27 Jul 2026 21:52:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:38 -0700 (PDT)
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
Subject: [PATCH v6 090/103] tests/tcg/x86_64: user tests
Date: Mon, 27 Jul 2026 21:42:34 -0700
Message-ID: <20260728044248.137626-91-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX/VePm2N/wCOl
 mgme64yLeZq8P8inyw4CknDKVsgKSJziegXFGDolI7iRx/DjH/LCQSI39rUkCvZFGzqoOIT5jPg
 v0ZAQLwrQOlC9CjoEKVbvZvM0LoiI5oIysCCEm6/1uJ06cDQ5TYH1znZI00JvlWBSWrxdnhSrlv
 SIFU0taDGLUwlkdDPPUTidTxIVMwMPzPDkasrY9VeNd5J8jUq+gJgK2CvcPkvFlcEb8FxMAT2RY
 pasClmNFd7MK3IS7xgAGyF+dceC9o4WbtpCUyxkuCL6DcoEghxGWbRbQlMN2whrX+zxuVPOulVc
 KklrJVaKIfryY7G3Z3A1AOISkIS1IQ7N4Hwa5ssfdIa2IW2oJQTi0lJuWfu4RWX4MaX990aCzQU
 qzYZpJCQ9fp1IXbDFjvkXD8dQqHN3/ZcRV44OBM8/vdoPXNcUC1Y4C4+kwhsDjFAERSsfchTSf3
 Tt8LtEh8ic6MrBRzwxA==
X-Proofpoint-ORIG-GUID: 6dNWHLKvZviAirpsQd9lOTObPC5gxdky
X-Proofpoint-GUID: 6dNWHLKvZviAirpsQd9lOTObPC5gxdky
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a683598 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=oGEJZpW7i04CVDWleowA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX1Y9ySm7z0GS/
 r1i9ebXCPVDC01R5ogMGnA1Rj6sEm1SWpmFlge8uhhk6lYf7qpYnkapJAaX6MhrhsQcOwChdzAo
 ZW0jaBS8a+4B/Ic6ZeiRWOlhX8U3K8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280042
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build            |  1 +
 tests/tcg/x86_64/Makefile.target | 40 ----------------
 tests/tcg/x86_64/meson.build     | 81 ++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 40 deletions(-)
 delete mode 100644 tests/tcg/x86_64/Makefile.target
 create mode 100644 tests/tcg/x86_64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 992913fa21c..ba79c015557 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -155,6 +155,7 @@ subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
 subdir('tricore')
+subdir('x86_64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
deleted file mode 100644
index 8ed44b08793..00000000000
--- a/tests/tcg/x86_64/Makefile.target
+++ /dev/null
@@ -1,40 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# x86_64 tests - included from tests/tcg/Makefile.target
-#
-# Currently we only build test-x86_64 and test-i386-ssse3 from
-# $(SRC_PATH)/tests/tcg/i386/
-#
-
-#include $(SRC_PATH)/tests/tcg/i386/Makefile.target
-
-X86_64_TESTS += test-2413
-
-ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
-X86_64_TESTS += vsyscall
-X86_64_TESTS += noexec
-X86_64_TESTS += cmpxchg
-X86_64_TESTS += adox
-X86_64_TESTS += test-1648
-X86_64_TESTS += test-2175
-X86_64_TESTS += cross-modifying-code
-X86_64_TESTS += fma
-TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) #test-x86_64
-else
-TESTS=$(MULTIARCH_TESTS)
-endif
-
-adox: CFLAGS=-O2
-
-run-test-i386-ssse3: QEMU_OPTS += -cpu max
-run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
-
-cross-modifying-code: CFLAGS+=-pthread
-cross-modifying-code: LDFLAGS+=-pthread
-
-#test-x86_64: LDFLAGS+=-lm -lc
-#test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
-#	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
-
-%: $(SRC_PATH)/tests/tcg/x86_64/%.c
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
new file mode 100644
index 00000000000..9d655a466d4
--- /dev/null
+++ b/tests/tcg/x86_64/meson.build
@@ -0,0 +1,81 @@
+cc = 'x86_64-linux-gnu-gcc'
+cc_dockerfile = 'debian-amd64-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+test_3dnow_h = custom_target('test_3dnow_h',
+                             command: [files('../i386/test-mmx.py'),
+                                       files('../i386/x86.csv'),
+                                       '@OUTPUT@',
+                                       '3DNOW'],
+                             output: 'test-3dnow.h')
+
+test_avx_h = custom_target('test_avx_h',
+                           command: [files('../i386/test-avx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@'],
+                           output: 'test-avx.h')
+
+test_mmx_h = custom_target('test_mmx_h',
+                           command: [files('../i386/test-mmx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@',
+                                     'MMX', 'SSE', 'SSE2', 'SSE3', 'SSSE3'],
+                           output: 'test-mmx.h')
+
+tests += {
+  '../i386/test-i386-ssse3.c': {},
+  '../i386/test-3dnow.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_3dnow_h],
+  },
+  '../i386/test-avx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-mavx', '-masm=intel', '-O'],
+    'depends': [test_avx_h],
+  },
+  '../i386/test-flags.c': {},
+  '../i386/test-mmx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_mmx_h],
+  },
+  '../i386/test-i386.c': {
+    'cflags': ['-lm', '-lc'],
+    'exe_name': 'test-x86_64'
+  },
+  '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
+  '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+}
+
+tests += {
+  'adox.c': {'cflags': ['-O2']},
+  'cmpxchg.c': {},
+  'cross-modifying-code.c': {
+    'cflags': ['-pthread', '-Wl,--no-warn-rwx-segments']
+  },
+  'fma.c': {},
+  'noexec.c': {},
+  'test-1648.c': {},
+  'test-2175.c': {},
+  'test-2413.c': {},
+  'vsyscall.c': {},
+}
+
+if 'qemu-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'x86_64',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


