Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40260C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYA-0003dz-N9; Tue, 18 Aug 2026 15:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY8-0003QW-IH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY6-0000Jf-1x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIlbW1971895
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Sq+IOgWuaoC
 l6KSnTy22CR89ROnCbHUaAa57pqTeeM4=; b=Ca4V/Vom2m+pgCjrT1c2/Ir1h7+
 +3ICwDB2cD11EmO6XPmxGiyItonQYBgq+hH65ZzE/vfUduGyLgxFYHjDahDVz855
 RPn/UMk/9obS2ulI0GPwEi7Ypy4FaILNZSq0qR6+FM53gZ7pojMq/NNdEmf9wPfM
 oAFUQwqEWZwwjyNbyzY+4mJf6MRCY+6bK4maDi1dhD0vfheBeCLvKo9rWt4kLndz
 31KNnGkHYh1z6SQBwnftUsym3LImw32/6FKw4aKFIyD3HdBeEFIKCOyAGD85nVf/
 Ywook1R6tzo4w9tvaLhBbyTpey9yRPfSVrQTGarPoZ06TANqwV+8r5KUeFA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1tea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so573928a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081556; x=1787686356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sq+IOgWuaoCl6KSnTy22CR89ROnCbHUaAa57pqTeeM4=;
 b=eW+tz/AYMVIp21JGE1kzkrqrcTH2ZE3bcUBJdKs0xAnjhYlhT25pyY1TaAZ1TdOqOP
 8Irqwy+AAwHoNLRxfztipTtl3y2twOeIcUkNoLf4HyQisWyOCIZQHO6VgBIm8JGv7Vhn
 Am3m4tVd/42A/doEFTTwbZ5bJ0vcewK3nzEDj60XQTDubAoSGhRvXvPA2xcoE6NEJ3qu
 mdCXQOjy8h4hGXW9Wbnl54CuBztY8KOMwl/nLMOP6ZN1QDOumDse27NNvChTlXE/AWJ5
 Vu592noNk2FOwh7NT1/GfiF1Ddjs3tfsbR8jNjYqzXY3m8P9J/C9dMVqPI/WxprSpDfR
 Ixyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081556; x=1787686356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sq+IOgWuaoCl6KSnTy22CR89ROnCbHUaAa57pqTeeM4=;
 b=m8Vhjg3L9uTxhYIsMiRlNZX2Qy6X9jLLH0Jus2/mQlLb7ksUfq15hfBVJ7yhxxPvrF
 ahyHfPpAyfBM6LCr6kba9Gdu4kvvPSk4kUqFYYWO8bsmgFKx5kh/OJS6q3zKftq2mIyM
 Vr6z/m/VHlveGDIi4fKToYmwLiUSDtIEqY4XqSW7ruyXAGiVayekBSk5Jg8motrp4qnD
 kM0wwlRH6NSd7XEkpt18qg2XvmGyBNR+oLKSMPpqOa1paVvRJjxvQmov+7HqOwvrCoX6
 2lzANIw0qCVI10eTDVrvIPyycG5WR1Ex+P3DGrXdAh1Dzy+eQKvGwhNKKGetglTrvRnV
 m9Zw==
X-Gm-Message-State: AOJu0YxXFKxYB0aIRNjuF7EIVAmdxaMNv5B4Db+ClQOWmw+ljytQ1IP1
 j2PnuZVooCpve84ZqBx9eRBWaKZpIkh66G7Y2as0lI+uI89lpWCJGWuskAtnGslHDrsNCovqF00
 8LMLcv4qB8Ela3wZxFg+8ZctzxO6gFOpZXrBzd+qScneIoEH9NeLPvSSCYrak0lbyhA==
X-Gm-Gg: AR+sD11VBtavVAAGumzUvFqj9OWkbE6mjfJjkRm4c7JCEmtZCnu/4HIBgOsDwiC7cFG
 EiazFwBPwfaGAEVFMlfl869ninsltMfq0QQefAYQa5w+aY/dCeBJS905v+JvBd9L1vzd+N2pBI+
 rbjs/qsKiBgtinYqWkE/mE5Rp18+pyp6ITiK1RtmDGgftgh3s+oQnaYIXifj6CW6Q/4IKcLZ9D1
 9LmcpvD4MVrQoGkrfsZZsBviH1PO1akZ5/O/XFdDgSeDUIyj8nYJSreiB4eg3d9lw3u8/5D5W0O
 RZNf/9RdfsgFQdiHOEvy5lmxA3+pW6gpVHos7w9jBBdcy9KEW4Hsv7y9WkgIUIASUu9Wi+ABb2w
 20U7yh21IwIaZ2VYge/v1i3Dv6wmkDCgOxVKB9K0uNdfezp0k+yCxL20N4Xg=
X-Received: by 2002:a17:903:b47:b0:2ca:4f33:e86f with SMTP id
 d9443c01a7336-2d5f6b4ab9dmr2525935ad.12.1787081556058; 
 Tue, 18 Aug 2026 12:32:36 -0700 (PDT)
X-Received: by 2002:a17:903:b47:b0:2ca:4f33:e86f with SMTP id
 d9443c01a7336-2d5f6b4ab9dmr2525075ad.12.1787081555634; 
 Tue, 18 Aug 2026 12:32:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:35 -0700 (PDT)
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
Subject: [PATCH v7 091/104] tests/tcg/x86_64: user tests
Date: Tue, 18 Aug 2026 19:22:55 +0000
Message-ID: <20260818192309.22169-92-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9R8t8XSi4UAc
 eO0KwxwTfVX4O34kN7f5B/omIi13SrQZpYnbMMuLVhpgDhY1s24UTZCPdSdW3wgYZ/0WBC5Wz+A
 ZxorPI0b7Lf+UVBgMyH4y+lntJyUDGA=
X-Proofpoint-GUID: bBZYbq9oTYoLK8LypOnYkgM4mtcCI3uu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX4va3piDF99Ae
 aXJ1YWF7nuzGzND9eGjPPHqlngDFbQpfP9UZlppV716QQWmOKGtpDTjO2V7zlqPPrXBG2eqMM6L
 7BTEMKJPciv2Fy4VNiah8SUUV5Jtl9X2O1H3OzdiapfwIWDNv9e4QPwR+wQFyw0KOoqlPldPPX5
 F9fwNgQkNifDfMnAn7cOHcZQ2WtjJeunNfWAq7OhzboKVFtLA+A7Rb3RTAYA7yO0C7kbZo2ejER
 4Z2dwU1gyq64VyHY80pJMzG3BBpusBhCaFsHZNPXw7r6uYBagmCXNc6PvG9eGo8ZXx8mufOXzct
 lAnHEB4C8pdKbcF4pGHEzrjMcxbGBhPAc3r0V5Z6UCMZgJfVs2tLJ8ypn+QKSZnOSlSLElvboHP
 LnP0aV+fQnyEN+1KWyEEmFNSzQ69OJpo7hkd+GMYE8UHnTaHjtQofsOujT2mMFPBXVkZIOJh3Ku
 qNwOUjD5vk+mFf+2Jxg==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b355 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=oGEJZpW7i04CVDWleowA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: bBZYbq9oTYoLK8LypOnYkgM4mtcCI3uu
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build            |  1 +
 tests/tcg/x86_64/Makefile.target | 40 ----------------
 tests/tcg/x86_64/meson.build     | 81 ++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 40 deletions(-)
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
2.43.0


