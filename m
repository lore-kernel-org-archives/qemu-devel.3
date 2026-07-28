Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0560C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjP-0001Oz-SE; Tue, 28 Jul 2026 00:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjB-0000fi-Ev
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj9-00024j-KB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3b1X61424053
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tYS0fZgWmgz
 tQvmIm9OtOuz/QoJLkOPveogaShtfVCA=; b=j6O67m5kOwuPFOhxWRCKHCtZR+I
 BB+mOwcn9OHktIizI3YA0JTDIgJR/9sGo80TIp4KPXfLAH7NzmuPxShTzv9h8XXh
 SvOOwKWUScp4Urweeb0WgbJXBt3s+cZGk34mWypGB6hjy837FnnIdD3DWgE2yF8N
 PrWIEcjhEZ46yc8B9NvXsnuyPpXH/ze3tJGhzJEfBV9a3FqvTZ45tESAKg5Hn7Jv
 rv41BQ+/2hHFoTrq1RhTq6VtBNVqEjzhS6d8toFKmVHX9jJAYlWzKrfRRQmOxcqJ
 qG9lOBfjdjKAbbUl3l3iwfBj+cIA3t2UaRd6HUgmrJ4KLB0sfadF60J5tTg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mpt2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so4349739a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214057; x=1785818857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYS0fZgWmgztQvmIm9OtOuz/QoJLkOPveogaShtfVCA=;
 b=anKoD/w543kSIvsgD7ZfPJW6ZKHnzZLcoXjMTiAMNZJikFx+QSJekwzsMoz6+Ck1So
 2171k+/6aNWzLs6jF3LChaV9fx/RWmhmVICOL5tdYyzQ2wgOY05ZpuHGex/Cf2OQ9lMx
 rIK5KX8MLpKWxI3vw50NGaBk8DPFlEGzEs4ZFEgHgBB6Fpz7lPv4LIEjkPf2aGL8sL1o
 pSPmWHEqf6scbr3c1cTiEyFE1BLRKh1CjMJkUiqTSreAGxABhRHFH+sM4EcEIs8yi+di
 /LPPhSh0Nvq54agocNj5OuoXVrGQ1rhsKtiZTIgfBhbuC3vMjjI5pliwGFH6nl1Ds4Es
 lpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214057; x=1785818857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYS0fZgWmgztQvmIm9OtOuz/QoJLkOPveogaShtfVCA=;
 b=hsbTIWYd3EfEmeoJzCcbq1qdsk7jnagtWj6z6nj80aMRI8kk0ijI41U6c9J25ugnUK
 T8ZYKeYN3CcmFpWDzM6i22oWCRA+qiEdUw8fICJdLxNHAnwUm40aHHbxUbRxGsXv5FRL
 OxVs9VTwPM2d/86A5r3XUx+4+mtmuY5BkEvdcf0DBeRAVzJ/+MMQmnoWmRrFPN+S3X6L
 Rpg1lWvOhlWxo/c42BMQIcIdMIPq9khrsICuz3ObcFmQvpNh7a3g/5Sk6QmZMoc2CBVG
 DPlyH7WESIAK02VFTOHELIolxSsCR0KOJUdH+fAyGyEXCXH2Of4ez0Cv+WvSg8IxNht6
 DgjQ==
X-Gm-Message-State: AOJu0YyuD8YVKtz55qPuQbVhzlohzob4I4KKzCBFjiC7pE/Mo71UDADC
 OsjZdM8K3BtHqN39LiJBIFo1x7VpUvTU+15D7GQ20WVDyF4KjLUkwsP8UV5V2Tenaks4rJgoF0L
 ovmJhYD0UFhkQZI4QhpH7CQtFRiVQPA9w1YjP1d2lX+mOgIhLC5n8618QWrBJPt/Vfg==
X-Gm-Gg: AR+sD128EiSo4FimYwQcmR7MNkWHOu6vO350CklaLeQOUGf1nVm94UNVJP/ZOWi7f34
 /pU5rze5upj4rOuzKeQYYYMj12Csg7gmPM4pBuoJ2E7B+u+OHKbLFPJcnyYv8MCmDN6mUUTDSQ+
 le5VunQ4eNdXRqYoQz+tE6YucBkYkTRT3KeUWiU7TyCyVPjn2nGgETXXNBu6jX67jLXnlI0RhAs
 stXveWUseRgSGexk58M/YuwCuc4lfAXpb7KdUAaVSZk7B14g+fZ0NmYszMd7tmdqGJivqwSyemo
 yUUZUPVvHkwwkNmCa3rp0IE3HfEPDCQ8G898BsERn9qKMUTUqbBbhr+7U6U39CLOTcErbm8B3vy
 vQThtT9VJ7X/U8h/QBGAUIqavXGfSByFgObq6Co3y2Qyk/pHHyIz67DhMdI+c2A+B3uWDfwg=
X-Received: by 2002:a05:6a20:9e48:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3c8aaf8d68emr1258901637.26.1785214057472; 
 Mon, 27 Jul 2026 21:47:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e48:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3c8aaf8d68emr1258874637.26.1785214056987; 
 Mon, 27 Jul 2026 21:47:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:34 -0700 (PDT)
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
Subject: [PATCH v6 047/103] tests/tcg/arm: system tests
Date: Mon, 27 Jul 2026 21:41:51 -0700
Message-ID: <20260728044248.137626-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX1hmyNcTkRFIG
 E+CpCYNJnPPH7ykoBi/d4sMP76K17Z2b5rsP4IBZ97Ij80McEhNghhn8HSmu8qDtHC1+WWjED4X
 fL6KGIn/gWgkcwGc6MjSvilRp+O8EHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX+RKlTtk6ocQv
 AyKnrqQ2FHSDf9Pxeq/DSVDFz57yp5GWOm/7I4Z+Je1V5WB5Yx+8LQ2+MCqm58OAyue3UhfKiWR
 4/V+olizRHCOEgaCIku35ujHZDpq7kD9D9KQyeGRJrbd+dzZh/nuR7equ+PvTWYd6v6fiVm2C1r
 134xQwN5Gv50BGDsy+mm3vn6eVSLSe0NgT6GNuyeZx2ax3dA4rgDJbo709bVAS53Qr2tjhHGmnn
 qMrLVyYql0IwVhZQSkf/oMwwyPQMS3WpjMrvpOGNt6dIevWTuORbxdYFVhdYcEZzUcIxJpYURIE
 4mjAndqJ1E629gTm6cK/NODDF9Omjtg5OSEJiv1KVSNS7yxQSAfcXUJwS0su//kHGiPHV2VTUx6
 UksUBL+PRQQJsHwIKlLfif2v49NuC4IH7SFR9AspxpRCSrLPFSoKHptRnH6VWgOar7maVxrslEl
 QQ7CEo2qoCvGB4ljjGw==
X-Proofpoint-GUID: Z2ssH8ynGsegqT91GZpILoPHXc56aVxe
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a68346a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7m_YixJVTNSDrcG_JfQA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Z2ssH8ynGsegqT91GZpILoPHXc56aVxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/arm/Makefile.softmmu-target | 80 ---------------------------
 tests/tcg/arm/meson.build             |  2 +
 tests/tcg/arm/system/meson.build      | 66 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 80 deletions(-)
 delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
 create mode 100644 tests/tcg/arm/system/meson.build

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
deleted file mode 100644
index b66074b0b43..00000000000
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ /dev/null
@@ -1,80 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM SoftMMU tests - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-# Specific Test Rules
-
-test-armv6m-undef: test-armv6m-undef.S
-	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
-		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -static \
-		-T $(ARM_SRC)/$@.ld
-
-run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
-
-ARM_TESTS+=test-armv6m-undef
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
-ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
-
-CRT_PATH=$(ARM_SRC)
-LINK_SCRIPT=$(ARM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(ARM_SRC)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-TESTS += $(ARM_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 08a863699fb..1b491cea026 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -2,6 +2,8 @@ cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
new file mode 100644
index 00000000000..d507cf980f6
--- /dev/null
+++ b/tests/tcg/arm/system/meson.build
@@ -0,0 +1,66 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-lgcc']
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
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
+  'test-armv6m-undef.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+}
+
+if 'qemu-system-arm' in emulators
+  tcg_tests += {
+    'arm-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm/system',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-system-arm'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


