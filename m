Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AC1C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVd-0003U9-HG; Thu, 27 Aug 2026 18:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVc-0003Qz-2N
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVa-0000E7-3y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLp6E125185
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zAgud4BN5DE
 9ZfYcKbjlKQgEsnTfea+SaJ8sSESmEU0=; b=iNwsO+D+ZvU5jCzLZl3D7zWcZdk
 jdf4evOd1j+giOrym4O7C3LCWia1sw0Edbl7ywY+kx0t0oS4nC3o0n3E3T5gRETe
 4uFV75eLtspvRWjCIVoUpYTATusucSTxaBL2EAFoLSbuTuu5TR5o7eYvVRhPgy2T
 /TjzAPpeCH+SNIS7dzzvEII0WKZfP52Gj1XG6SbxqvDNXRoMKLnmAUXMUgJEuvKc
 ElUECP9YYdMUd9/UUgA2QacP5XGI/ZH88V7/dYWkyOH7IwbBYi1JcMqwAr18XfuQ
 D3gxZahcpaJR4fvNVojyJLKvM0SL4JozfJ4LWDx6wRdBDqsNiJUcrtSAz5A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7twku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso2233075ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869420; x=1788474220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAgud4BN5DE9ZfYcKbjlKQgEsnTfea+SaJ8sSESmEU0=;
 b=f7eIAOND0bGjBIo22nCeEs/VvLsoL9sO+fyoT8Sa99UWA/1pXJJnlpYobFuFaX+vQn
 SXvmZy8XD5vpmB3WOLANS3eWBIt506VElS5UyxxVXSwg5cTbm0pAzTr6bBD8CXhrxl92
 fpTIhXWQM6aYaDTiI+dqF/0pF2vFNnevb9vNGMEKjpGN0dCyjaWF7bjx1NVXcTqSDw5F
 W88VdXTbDQ1I6fJ0pvpSJRsUyM5STzqTFafBjxYwk1dOVBWbtU+7FbTFxnd5f2QAOrzk
 uuptSBhUZZc7DB3lDYbjnZ4tOVEuOr2q1gjyVbq47L2lbjYj4QWJBzIje2b810iGBbOM
 BtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869420; x=1788474220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zAgud4BN5DE9ZfYcKbjlKQgEsnTfea+SaJ8sSESmEU0=;
 b=OqEwhaVZzO1hGYb357ISSzHV0hu/y9tbBejCq8yw8HESF8GuWFZ50qUlbBc7MoHzfu
 OEMLnYAUBTTy8Hn/bG+zjgApYrL7oTJAXWSa+Aoffvs6tDcbZFFFvcQuHTDIuhBDMGzT
 mwAnsUpcrjfOGoT5TEuoaTV7JKyxOCzQg00Yy9NyoXqEG63vxnScsbLjwk7i9u8O8sBs
 dzSwPAcfxJMcfnEe8tVX1K/J5aU9Cpep+6TmgvkdRuslzbFbg/XvyAtxqlxWErq1ba/7
 dgpXGj3pWgdpNm1cORy8Rq+GegzGvQEfSU31ImNBDoE6c288jXwK/0qpeHIFKMnH62i8
 HXXg==
X-Gm-Message-State: AFuF++mZkTI2TexnzKFRiid4aRwW0yh+MYZdeKBI2CkA/eT73rKc4QHC
 /vzKAfApZiSslMFgFuPtQzakXFAmSDWvPN8Y1UxVPMaI/19/9bZQFTJhKtzcXGIRLhYONIfoYZ8
 2yg8eYbOptclqNz3jhz04ZFXe6wK1Ec7TBaq050QXCknnD4HZCXTr9p5FVo+kf8I1EA==
X-Gm-Gg: AR+sD113c4WGprniT6N9jqQTi3dXRnJLhPC38zsNOEm1Edio29dsyv8oSJIOM1rvapq
 bRYYn6pmu5dUgBG5FzLn0KcffJiIRqPl82Sm66IPFcnk7fKsaRYOBlJYF28OM5alW4aevLhXBnj
 Agy5rLbQfBfLVLV+milfG51nAtOphWTkXTZqwYjieWEN8zSPnAIPV+cDZnaOkxXsieKGuWOlun3
 Hk7yL0uJfcm1LJrXYf/hIKSy0jQpvHNfI/Xcx8kMPunDUtBplXjbg8HCfmKYmSQNLW8BAcVowB1
 xc2ME8QOdDX1VdWlPtuKDskJH2MpyHROh1dHLS7Ibor7VebdVNsEEhHx+DBuzDZe7uOVidguPiL
 UJP7SOAtGA3iGJyFOXWFQ90u/YGsr08Lu21cNUrPxli3ZTfK2s1rZn8NwhdU=
X-Received: by 2002:a17:902:f78b:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d74dc78debmr37764915ad.4.1787869420059; 
 Thu, 27 Aug 2026 15:23:40 -0700 (PDT)
X-Received: by 2002:a17:902:f78b:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d74dc78debmr37764065ad.4.1787869419599; 
 Thu, 27 Aug 2026 15:23:39 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:39 -0700 (PDT)
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
Subject: [PATCH v8 091/105] tests/tcg/x86_64: user tests
Date: Thu, 27 Aug 2026 22:14:52 +0000
Message-ID: <20260827221506.91574-92-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXxOivKF6Nvvxi
 ABBh8KUqL57fACIB1F22nEDVNdsITF2fqY+1FcXz0LfNpyW2CVNvNCERRemEupOyAbpA7uIGqxu
 nLY0wv2mHsMUCji+tUBwOOkj4WbHKl+A6vAbOD5ENJegOZGap+0auZ6Aorby9LeEr/S4KIg/a5y
 YUNF8z8iUmUxPpVEAVCSxY0EwePkxXcD4hzN5dAu19fEFeG5xEJSpuiJMLAKsWlm52zuArPNMSs
 T+dnaP7KDVDD//ui/r1R6mcmBGFIBc7yQliGLoIuQHbMK6rdC9XjJWwLWINLmGNMowjz/ZUVtcu
 e8vD1GgvNnlRL6aI+svahoqLuOX1EuaidLomcIp6O073iJrUiMotcwOTwVmzMXHFAWstxu59wb/
 jsOXtpMANENvHZDK3x6YWIrHfUvl18rq/+0cNIoTUocofwuScBvyRddCDj0ronHqy7LLpc9RNYv
 zLsrBDu7wpOGJs8354g==
X-Proofpoint-GUID: VYKT4MsjRT8uVfd05XqKnjfaAq687VZa
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b8ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=oGEJZpW7i04CVDWleowA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: VYKT4MsjRT8uVfd05XqKnjfaAq687VZa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX+vEaafn/SuNM
 pzW89okwaNIDv5CqvfXc1FePzk+ToDI8xPdjChcB9ynMINyvXJ+mQWgeStRAlvXAJSvVZI+rxz9
 KQsUnqobrE8rCbiYTMoDRmZODIshhR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build            |  1 +
 tests/tcg/x86_64/Makefile.target | 41 ----------------
 tests/tcg/x86_64/meson.build     | 82 ++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 41 deletions(-)
 delete mode 100644 tests/tcg/x86_64/Makefile.target
 create mode 100644 tests/tcg/x86_64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4903947a636..163e0a96753 100644
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
index 9994dff4c44..00000000000
--- a/tests/tcg/x86_64/Makefile.target
+++ /dev/null
@@ -1,41 +0,0 @@
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
-X86_64_TESTS += segment-prefixes
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
index 00000000000..2607a1cbcf4
--- /dev/null
+++ b/tests/tcg/x86_64/meson.build
@@ -0,0 +1,82 @@
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
+  'segment-prefixes.c': {},
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
2.43.0


