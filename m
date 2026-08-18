Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B41BC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYC-0003l8-Ut; Tue, 18 Aug 2026 15:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY9-0003X8-Ck
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY7-0000K3-G0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHJGs1735638
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iBZTIb9ppMD
 QT58YGjCU26pinCPPkqKG/04UVlGgQ6o=; b=gOhXrbtf02B85bsW5T6Ug/7jrdO
 AdbInU3YPqy3iQ4zgE4AhG9dgSGn+41KQAqcFNj1jpi7YZCY8Y0mRzmOIiKTtR5r
 uRjBDOI2T60veLoUOnoOfKzKKPEySQhdkd4tra06q+LojLPgKfi2VDdNlX38rfKk
 8DU95QTudvV/qspSHGqBb0RKgOGfFrP9ZoWMvK5+Gw9Y98ZVBsHGCcxrRBmlX3dT
 6Ms3MAE8G85XtxLXEMnSWMKNaYHzroNKAD46Iw4eeWHwF4bwHIocsR9l5x4RvL0f
 1VDEFOvEEJgOyj5cAwIHOBPRRUb4TgMVIhGMl/LsTwju9S/LEl//m69tFFQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4reshmwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3931cd2e4cbso311441a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081557; x=1787686357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iBZTIb9ppMDQT58YGjCU26pinCPPkqKG/04UVlGgQ6o=;
 b=M4HrZkOl/0WkGlSp/zIYI9fW270mkqv1JaujI3Qjons014zsBnOFRT3RgfK277ASg1
 8s/NSjM1n7cZtBqX79DBzWVi5aEHZsjU9AK1JbRW294alCMAHuU9tM4gEWfwGdC64m9O
 9EICOQ85D52izqZI1+eDf9cMGj/9OzqlEigpkvMNozwwtkRk8yURGsGYtmSrV3fLfXlA
 Q9Eeow9P41ZeQNZ4+oUaLQpCyomTnP2b8ebtoQMqAPhOhSqJUaafrfO1IwRb/cPiILye
 nkZVwdNt8WHGysfWI9zk3qkSf2FrAZVfMeIpF1ongALR4r4UzzPoZrZJhnfqRrAakEpQ
 cCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081557; x=1787686357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iBZTIb9ppMDQT58YGjCU26pinCPPkqKG/04UVlGgQ6o=;
 b=S64WyWcbzfNC5D/3l9VougqWRHGv3aG+5MFi6ejkkN2TABvqx0JtjYNC+JKs6mHwMv
 9azg0X9SSjX5Zt4ToLt1HFGrKPDqhUovsP1zRez/DWmgss59b4bySNSEHS9Y5J6IG1ci
 2cLOT0V8D38hh2Q9lLEQ6ZZMIPYZm0n+da9U8IEluGMTdFc72jwSyVh63og7b5Y7KeDu
 E13XjNRQY0EbH/0L8+HRMGjxLuq8zuhYgv/6scxjOPuTT4lYW463LPkC+W3ill8SkEMs
 Q7tf7ZYLH3bJJxguq2Pq1dzkqIIQFi8Kr5Uyhq6P5k7cv6wXNKEatlMzdRUa9RN14l4u
 VoBg==
X-Gm-Message-State: AOJu0YzEN7j/UI9tp51bm5lniUuVxAUa0frK9DKhDW7L6nLvzomBXZMl
 BWlKeRRZaVE0E08hcVGvN+U34OXESvcWII5nDhGKlqq3NrImVsoi2oYNfiS3TrXVzHEU5Wyw0H1
 kI9/mTvfp+iNgTLBaYgV5nJSVKFqCGqicK74cTXsfGXGwm/faxNLnenFdeZitGCCIJg==
X-Gm-Gg: AR+sD11UnRvy2gZojmrTrGm4Ix07qHh4acCZMDUYuyQ0rBLEEdICUs/eGfboGx3ti8+
 Expyt/k41q4aXs2pivIo4SmLhlM5qukXgXPlrgELcee+3jEljENr8jYPIV5Sdz5hqLEvNA9OPsB
 nex9xo6QDRB/JHsCKIWOD/ont3PYmpKSjCigvhySeZmEb9wYlMjD/QSBL6FybUxvKMzUJQ7400Y
 081WM+Ge756p0Yy9nE83BkECxBh69Xd0942dKyvUl1C3QfOxyaVOo+smX9DZsbPdIof6PiemoUf
 XdAuXZtxMf29FHJNzqHjMKOdI40ZLrPegEaPrj474I8ScdlPEu5ls2SVFAtFEvpT6bWMGUV1YzP
 i3jmAdLMYR2Xct+m9BT8aYLL2iiRwQ0MKvQ2v77bAL+gvkK1gBnKf4OusErk=
X-Received: by 2002:a17:90b:3c4d:b0:38d:f94d:4c6e with SMTP id
 98e67ed59e1d1-3957baf979dmr49424a91.17.1787081557401; 
 Tue, 18 Aug 2026 12:32:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4d:b0:38d:f94d:4c6e with SMTP id
 98e67ed59e1d1-3957baf979dmr49356a91.17.1787081556982; 
 Tue, 18 Aug 2026 12:32:36 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:36 -0700 (PDT)
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
Subject: [PATCH v7 092/104] tests/tcg/x86_64: system tests
Date: Tue, 18 Aug 2026 19:22:56 +0000
Message-ID: <20260818192309.22169-93-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a84b356 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=UwNeOaObgM9tbxZIesUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: kXzGPHa1eg4BLVDdB51tDjzt6v5FIxtL
X-Proofpoint-ORIG-GUID: kXzGPHa1eg4BLVDdB51tDjzt6v5FIxtL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1+CI2wFomSyJ
 hG6XlAg4JvdjsDCcyI0/4sQTpmNfIwDb948jmRboUJM0oAMh/XkV2IWgSLYY9PHJ32pEoZA3gxA
 DvRgbZGpfTlZeWNJGI68ZCrCbwNfOkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXykUFYg3Vcwgm
 3SJ2vdgPhS3yh6k9r/UCqfzqp/LGtOGdSaODnmCkgOhv8CWmAXfus1o7IuOyLPPN6N1eEAvoV5X
 ZZFcMesmFJgzZS0GHRgluNWt15IVS1W2MtUWjtm1ZULAV/Du0zdvW8E6A+rIo6+bnnWOdGJMMOV
 MYrs/tLNrTd5IDcr2tJaV0goawKiOXRp2U349lwzpBQFYo/vpZEclK7uDbXFD4Gy6/kN2O2YGj3
 pPrix1dCOvCe1q2WgDOvjo+Xq4TAZqiVic4U8UfoPvMl4pmy7nPxKMJDhp5+3dZwKfTvkVQ849m
 LJRFc30mMLKyO4EO+JXkWbEjSym9n8acVwypSUcLplair49qiaPZooLPdyhxFauFSocWfyU9hlV
 8dclZV+mxEqNxqKwackZ6/iUutEWuNnn6eDIFl4EVxvg6PO+9UgwSqeWpJgHe65AaF6rj9i7UMP
 tAiXf/alDEH8wu73icw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
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
 tests/tcg/x86_64/Makefile.softmmu-target | 44 -----------------
 tests/tcg/x86_64/meson.build             |  2 +
 tests/tcg/x86_64/system/meson.build      | 63 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 44 deletions(-)
 delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
 create mode 100644 tests/tcg/x86_64/system/meson.build

diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
deleted file mode 100644
index 4e65f58b570..00000000000
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ /dev/null
@@ -1,44 +0,0 @@
-#
-# x86_64 system tests
-#
-
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
-
-VPATH+=$(X64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(X64_SYSTEM_SRC)
-LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-# Running
-QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
-
-ifeq ($(CONFIG_PLUGIN),y)
-run-plugin-patch-target-with-libpatch.so:		\
-	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
-run-plugin-patch-target-with-libpatch.so:		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
-run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
-EXTRA_RUNS_WITH_PLUGIN+=run-plugin-patch-target-with-libpatch.so
-endif
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 9d655a466d4..928fc297232 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -2,6 +2,8 @@ cc = 'x86_64-linux-gnu-gcc'
 cc_dockerfile = 'debian-amd64-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
new file mode 100644
index 00000000000..80110d0ae57
--- /dev/null
+++ b/tests/tcg/x86_64/system/meson.build
@@ -0,0 +1,63 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-Wl,-melf_x86_64',
+          '-Wl,--no-warn-rwx-segments',
+          '-Wl,--build-id=none',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+tests += {
+  'patch-target.c': {
+    'cflags': cflags,
+    'qemu_args': qemu_def_args,
+    'plugin_test': {
+      'plugin': 'patch',
+      'args': ['target=ffc0', 'patch=9090', 'use_hwaddr=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-patch.py')]
+  }
+}
+
+if 'qemu-system-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'x86_64/system',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-system-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


