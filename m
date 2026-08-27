Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD38C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVf-0003Ux-3x; Thu, 27 Aug 2026 18:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVd-0003Tt-2A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVb-0000EL-4i
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM4ED1803755
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HEfXFTbQYel
 dGLhUHBkz3GIrZobrdhlj8Nriv85kFws=; b=oQygY5pP0q2cn1yuizhZs/2uCWG
 B7iOBEs22O2d4ZJhkZCAeKVi+maUoVhgPi8L10Qt5nu7D5oByWEyI75PRNY1SnrO
 ppGsJwy9G/8w43gInhn2JDUr+65e5i5GwFme8fzxxwmVmNvg9C/LOCfyhKCg/4nQ
 JZeYIjmLAP0BE447/wHCDQ2EucD1yd1UgOFCmsRG8giAYjlQ9uzt455wHo/oyb4r
 sSabStXXcveG9gsa4EnzRsiPi+7gZ/VjwLX7DuOEUGcnPw9NY3VvRY1FWl9eJ6iu
 awdVJ4TSXkQyCUm0zyc3VUMPGlgCBN49fhZhvuOWTZSjepkr1pAWhqhTE8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d54187d8b0so7309315ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869421; x=1788474221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEfXFTbQYeldGLhUHBkz3GIrZobrdhlj8Nriv85kFws=;
 b=jaNEMoAMkXn8MEPxM2Rv9MhFq+Y/erA7lP9CY5AtwvT2o3wgBt9dvFwQg4ImENw7Vb
 v0fx6iIaYqmYNTBBw5TCrD4GSYrTjPZid6P78a8DzstyC4MTzt4fxtGQDp+svfGnni/u
 ujTxpsrHVx56aKfwv20FvVYhZ/8OJ9AZyGe8RaVCl4Dd14D7cU3yDjck6rHsxhCEM7OM
 jWmTIWGcNZplFQyTUfEs+3/KLDptpcHG2ktR+VTgYj+yMi+hQYHeR7jOkJphbwhcaKTI
 EsG6VMZk1mYfhNzYdqilHIHcxzAGZIeN5/mYCqNJHPrvuBSoVq/z++P/CnGEGX6spKR8
 G3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869421; x=1788474221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HEfXFTbQYeldGLhUHBkz3GIrZobrdhlj8Nriv85kFws=;
 b=epQyQvChzfgF6M+X590lM7vpTFRFYniXq/4vP0fPbaV0iR23YjfiR8/2gtni7D+KTR
 zm3Yrv86rpoj+Iv6yxJ7+Hh58qwPRpDO+Chfcst1J2ODbmgOmvnpUGN3YJNSs8B8Y7mA
 IlD29C+KnayaC60wkAkoXFpNtxVp4hD0vZpOm6O1MXUTMdwcw8A8t9N5O42xMmWAwZFA
 Uop856XsM38vbwwk7gtFlXcC6RedQZL3DHfSKjMkFa/S0Fdgks9tlnquph8PE+qFRWey
 tpyUFW+f1TObLd9nyULQr/TbkuG0f1NnOwKuR4I7ViZHzzx1701h7/8FFPErU1VHw8l+
 MqeQ==
X-Gm-Message-State: AFuF++mrJku6eLIZZjLk4X7pfpOh9APPRPx01EivZJle5LrZ6IPbtpa3
 KapHxuZ9tTSOh8R6A0t5Sxluz6tZZKBRNU8fU6vO16bz3tifHRVcF7RGn3LuRzQaRtH70BkP/gn
 4idQ7/me+2MVFxv4fQmmxxCtWSdwWKGBjKzSdUK6AM9AH9OMxIV9QxD3uTgoM6hjycA==
X-Gm-Gg: AR+sD109KJs2T6thjOgsHuyldGB4AWTBl35A2zMqaLr1BieYDgYtwDzbjSQtpBVOxq7
 t32BFGI6VfxGwYfh6mSk8ehA6514yWBvJ8Dkmr7HqPQppvguvOxQ5bs0C9bck/8pICf03g8+gtO
 8J92NieObtCDnyA3i/tbrfPgv/7kPiMI2TipW7M9Uw5/AdnTutCFkSWt2cFjD2OlTydlMFHuwug
 COwqBMiE7RoWPCZV6xchLsYK9gzeqFi+hR0QiJSTkdBXDjSPMqg3ORUCOcNqIl/pE2n27jtFjDu
 bppPmFO6kpWBKf8RnhE9U3AYNY2nV7xynfK1XYcnvO4ORyd3Z9vAl9p6HCGwN/habmYVTI1Zy2/
 nyat0qjKxTt8JN65dYVoynHOUoaW1U/G28oITiHVn2Kiz/kG7uX0KuSBCv/c=
X-Received: by 2002:a17:903:2c0c:b0:2d3:14c6:2372 with SMTP id
 d9443c01a7336-2d74dbe3e67mr44775045ad.1.1787869421179; 
 Thu, 27 Aug 2026 15:23:41 -0700 (PDT)
X-Received: by 2002:a17:903:2c0c:b0:2d3:14c6:2372 with SMTP id
 d9443c01a7336-2d74dbe3e67mr44774105ad.1.1787869420710; 
 Thu, 27 Aug 2026 15:23:40 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:40 -0700 (PDT)
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
Subject: [PATCH v8 092/105] tests/tcg/x86_64: system tests
Date: Thu, 27 Aug 2026 22:14:53 +0000
Message-ID: <20260827221506.91574-93-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b8ed cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=UwNeOaObgM9tbxZIesUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: nFtZZjEurKRO4rNRvGLcBR_mVEad5fNc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX581jWx8UhhvG
 Ziy7Hi9sJ8L3tBHHmdWabMnsMB8R+ENFiaiqQMUPvekGkSpmziQ0ucgOjNa4CYniOGCqu3EuQ8I
 v1VbXm+XFtfzYRSqqEC/0hFNFy/wxAJC7uDTaNzVJZBt8VV0RLAc62Esl8f5nIlOsaEVmdyTtDC
 YpuZwS6snlPYmgg/1CjXGojcpBol+JlZPNAGS+p0FBDxNGWh83ddAedH2LIboog5w7hc07fO4MJ
 ym/XzQyXwGwcIrkMwNkzdCdaXHGXRjNJfR0UyCu+Uuxyn2eM3YuE1hg5yZL1OhjKN0756HBE5EN
 394v2GmSgNe/Ezawaxl4IDpLzAS/UCuBESTLV12MAtqKTP+LAcq6Biabg5Zr0a57Xi+Wpu9b8TZ
 HVnUhl41+j8eAyK6ZQEAo+HgcqaVANTOuqvPecUxHXTJRZcFMQ/QLFzHS4IblLqcpnKTGB2/ezJ
 7UNTYVUVC+6KV181mlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXzrbDfzE+zoHI
 3HfsSNghfr0hlqn5RxG5USphnxFq6uZ+sxkca0B7ARQXicBHSIiSfuIlkHfsevAMVitym4c4Vva
 v4RNr05OMqnF/isayMrflosM2o9725Y=
X-Proofpoint-ORIG-GUID: nFtZZjEurKRO4rNRvGLcBR_mVEad5fNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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
index 2607a1cbcf4..ab336eca9b2 100644
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


