Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCF6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ9y-0002Ax-5L; Fri, 10 Jul 2026 17:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9w-0001tn-6R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9r-0006Rj-Q5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ejX1846381
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qXD82NLqOE4
 PS4Ks7qdSpVcBCXiJTFPIXXsxEE3Xkks=; b=geqgmVe9vGA6qqQP4UC1I6odxs7
 79Msvvi15eKHY0yCwnI9TZsDohWmzPNXqGkU6Gd1DP2f/MUqNyKnUybn2oAsUvAl
 Yz3Hp3K7k57VjsT7Nmk5BqzhrC9zo0w8ObqVh+8EqaJDcJ+lAma9ZMQCW+VvytGC
 EVTuVy2Tc/C0kvcqqT5ynun4NE7KcvHbGTfwDwhYWud29zrg0eRkGhzOYASx0av5
 OS7tqku6M/SVi6atya01vmCuS/8Z73aBBqTFpMbUOJXIJO0CEfg6AMOO/I2zhLKO
 +rlM9DkhX09w4j+FPmcz/LCMO1gdhGPiSe2fZGyx1ArBub10LX3WPhe8BYw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rk4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so2356158a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720397; x=1784325197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qXD82NLqOE4PS4Ks7qdSpVcBCXiJTFPIXXsxEE3Xkks=;
 b=fw7H9NypiFx0UNfyqdkbm+B1OQt25WlK87OyQUodrjFZnn0/PdXVwXY/1RLkVrpbRN
 n41cUx/3DMveeO99HBKnXR0qwDTMvTn6NsOeWnK/dufWU1faLH+UKg63LsqZlDPXjmmX
 HeElgYp5KJ7xBpEYS0vFIidS7uv5sI1XrL+0UG79DZ1ML0040rggnEamPOSQUOk9GifJ
 g/H0gQflffqxGAwmhsdWe/tgEQR2eaKPkc/wBn8TcxfpoYJ0Ew9uPqwMgiZq4F+Au+YB
 GFDi9S7OIzIxNehmwFm2fPwDRnp32AI+CKN10nJLy7mvq8wDbILL9z5WsM0zmlZ5cpp4
 lmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720397; x=1784325197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qXD82NLqOE4PS4Ks7qdSpVcBCXiJTFPIXXsxEE3Xkks=;
 b=YSxMGlvfk70SuEOEzuRXXs5jeGyvSMBGine08qQ775ju8ZSveL195rcOFeQuZSZNYB
 oeLrotNT+kj9EpmVgq2Y9GrI/rfazmxtwvVWJsoATKVEPawjX4yi+gwewkMQ9408Pcsh
 DU5781SLP7x54XWcKoFqUZpVrulDQccrSFTJX5Nsixck/XlMC1OXga5c71zCfPlCCstU
 J4/KGWGcVeVEBYz3n7kC+OUbU54Gm2oXKaoOIamH8OIgMgtdnhzL68zV9xl+qUfvxStc
 IPl88fzUogDcmWamBh1VnSHJ+uc158VD88B3b60ZdosImrVCoiA8t4EfmWz07/ncoVyl
 GoeA==
X-Gm-Message-State: AOJu0Yx7+E0L0FGYZWpnUhaXXwcnYtwJcPBNsIUeUdH65vLtqbqiajsw
 ltxdK7dR/k8wQmRfxZsBpz1cP6eUuwuZ4L9wAhZ8JKJ4SMivvRUGP2Dfhh9jb+9pvxwQtVRjRlF
 I4FHL9dbHkeDvku47tsaquXm5dF2Zlcq48fBqhBLc3yEJJBIeLhcNPdvHPwVHQwBYUw==
X-Gm-Gg: AfdE7clDCWPLDqoBvOeclt7Ky/1vkP2IxsmJDi6zLJDNam5xdPOhEG+c3dI+oWyq7GQ
 mPb3eUX4Yv2Ap/OQxpZMV9BY3cnQqrVEQFinbbd0BfBceW9cJw05IB1EvEaU69p6Y0+V8hfURQZ
 7dhq7iHBG2pY40XISWfobouOjhhxGmR+KL3F3T+EaPoSQGXQOMtkcunU6LESMJW8SyfpkWDhEcc
 Kr5NaEQIUkApC9/spH/jkxuJMeTV5f5Mi+Nskhh6ziqBwVGGphiOMxx3fkSbsb9kMZcXKzGsDpp
 bGjk3H/Kit0JLp8fD2bfIE3FkiDiuTep1YNgYTlc9WoiBVAcMIiQ3VUPuwno4XdiJ41F+Do07ha
 7/IquBz9K2B9w9q63MF+YxQ2fFZYpo0l9Z/cQ5yTqFBSRBTXT804RX6ld8QM7ST28crg5/UohcC
 N/RdLt5g==
X-Received: by 2002:a05:6a20:6a0d:b0:3bf:a624:deb5 with SMTP id
 adf61e73a8af0-3c1100308femr827904637.6.1783720397529; 
 Fri, 10 Jul 2026 14:53:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0d:b0:3bf:a624:deb5 with SMTP id
 adf61e73a8af0-3c1100308femr827885637.6.1783720397083; 
 Fri, 10 Jul 2026 14:53:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 90/98] tests/tcg/x86_64: system tests
Date: Fri, 10 Jul 2026 14:43:34 -0700
Message-ID: <20260710214343.2065491-91-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bNr89iSobLKy_dE8b-fTCs-rF55-Nvqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX+HVjUTH1Inhn
 5ADEcKHcnCXa1etck3JHYjZMrc5Y8usOzAQoVM+208NigPDsZkGpKlIXgQT4MAEskLh+461tOff
 jPZpS3m87jQsvlWifgTTNq8iddWYhSI6zzRviH8CPM2j9bg20dWEgGdIhC/7T1gIUIY2qMaoh/J
 70oTG4nIe34uKwYP81whtxOBTrTXS1MBnasnjCVZQM6QxS/xRHvV+F4bty5GAQfZnylQsCqgq49
 kkeoapcB5AchjjFEcHKZFPtmoaEz0Ei8gCqEEV8YuuyvWUb1q4ScOwPAMZQJLVqM3AcWbdO74hP
 op+yoqqRx9FPJVwo7Nrm4VLR6HBh8GW/j1KJC+a3KDpxU9lOsHJLSekHZvR76LYgCe54FW3hNfv
 F5WIO2Z3l2vJ9WMTPrQeZqVMMg6oBwKUV4LJr75AKl/h97inIQN5ThU3aTr/WV0WRnMtw4bRc/d
 DerCQIbEMqdxCasFgeQ==
X-Proofpoint-GUID: bNr89iSobLKy_dE8b-fTCs-rF55-Nvqj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX20W9SaBFpzce
 d4266avUjjjP83Kvrkdt1LhQ9sN6THephHwBQo8hNbCcscnuOh7J6iYkuypSl1Sbe+BZfkKh0qF
 rb4gAVI9E5CBQboClaotVVKByd2GxPI=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5169ce cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=UwNeOaObgM9tbxZIesUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100220
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
 tests/tcg/x86_64/Makefile.softmmu-target | 44 -----------------
 tests/tcg/x86_64/meson.build             |  2 +
 tests/tcg/x86_64/system/meson.build      | 62 ++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 44 deletions(-)
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
index 00000000000..c5348102e8f
--- /dev/null
+++ b/tests/tcg/x86_64/system/meson.build
@@ -0,0 +1,62 @@
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
2.47.3


