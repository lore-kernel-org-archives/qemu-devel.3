Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B7CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp3-0006x2-1D; Tue, 28 Jul 2026 00:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo5-0006F6-Hc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo3-0002Xv-A9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3afSW1303627
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qXD82NLqOE4
 PS4Ks7qdSpVcBCXiJTFPIXXsxEE3Xkks=; b=fwE+RsXZQdDUs0p5NtDrpZegV9j
 WvRlWQk2lTsBYEbe17zg2qHc4zrpubf5eUJu+7IfcurDKN4q1d1K81jlZQWydBKl
 IOFGhcCZdkKJIn9B8yf2xQr3SUn+MpQ2EiRzkfQ63huZmLlt2+0rPcdzvi18akfd
 Nt2uTexkDe5ICVA3g9C02P7MHhTvPtLbBylA65+styE8t9Gvv8AAWJCjxBETCJdm
 WvMO+CHyLb2WuWnqWRcnYZhzpVZeKPXZ/X/JYldX4dVuNQTGf3pu+/NzBYQHEK3/
 HnYRGO7w48ryg7e1dHhixgpxl0nNmYmlxVkQtUbnpiHLGDFGBq7cyq/xoNw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8agx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so5517393a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214361; x=1785819161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qXD82NLqOE4PS4Ks7qdSpVcBCXiJTFPIXXsxEE3Xkks=;
 b=gcNIJkWdcXxSFgTEmK0i5x88DXhPTJd0VoCDuDhNS3AFMfKqr4S+QtDoL+2mzri2pk
 Jrz11Ef/AlgFlRxfG5yMjfqM+AdxhlpokggSW+wVBmtYQMsXPHpC0Q+RbkNh0rDwJW99
 iA2d5GZFSSboO0kF6UsTEWMJpEwUYGpoYhv8dYXe4h/YYvqUJXowmVgW7uENK/0fScek
 V8X3/WtzkSu6Ofz0uUL0xpuwEg37lEDssEXSE6Aq7Diq2vEh42iTNEk9eo+89y220cmQ
 o/TxiIDL5d0U09t7YaWWWlrlZY8s90htNL3TY9ygm1e28X2db3g3gx6EeC2qT6j3KE6o
 RwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214361; x=1785819161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qXD82NLqOE4PS4Ks7qdSpVcBCXiJTFPIXXsxEE3Xkks=;
 b=f/HBrJd6jaJJ3A1yMepykDpz9a3XKossfR679IakFiT1Dqr7+Em8suXgZ1yFAW3FqI
 4BmIwiG2nSBL+k2TP9epzZr5S/heEe4iF5ipSi9TGV5IH61P7d0J39GjkgCbtncCTBml
 3IvPVAnDeEYDUTO/vL7PdJlLOoI1ZYYOi8f0eBr01yQg+goB16Bj9R9beiShkW6dFPwr
 dsnr9ezJaOJN6etRob7EF900XTOJQM3I5Rj3xDUKtYjIaICZcoUUS4aXab9YzWZ+f6G2
 3OV2hrhDbhdCyDmYFeFNRJaMacH7gK25ly9iG48iRAtNWCfLnXliGBfH7p2nLCo9VJVh
 ZOrg==
X-Gm-Message-State: AOJu0Ywmqy5VrdC8E6mo9+0hB13CqH6ZuqyBbHdIrTM52nQ6pQvmS12+
 1nv9g9gpVPNy0n6vZWnQk/zvJjt8Fo91X0y2BF/u14vUrhFkaVvbrNjG7bIgb/iq9HIHg54axBQ
 sg37OvhSuqzDll8VtzbRfjIMuuG9JQ39Q70VSat2GQUA+DnfdFNxCKrc2o+1mQFsapw==
X-Gm-Gg: AR+sD10RsGNk8ktqr2gmn6Cz0+kMCeOJ+6J+5zz7HoWpuT6g7sK1SHRsQAcROnon615
 ROrl55elO22TbSfCow6mmw1DO62Hnh+MuV7ilglau52KgqtXabe1lfYgM28reTuKMqsbWdx78xn
 jfqrg3RDo7/jGLgC04LZh4RVHIsirhNMTiXPfAAPYgwsBp4FtG1PWndXDttZs/8qSSDEgauKnHw
 8MHf2CYZSg2WR6RNmjjcNlX14uxpE/w6Jvp7s9USV+hcSfQ6uqSJotmYHpZaxLSMxyPsudj1DhI
 4etGZVY3SZsvYzfAPkxVatFm7OSUe3/B+l0k97fAvrxjaa23i/tsGgJlh8X25awGXNYexq1jUWJ
 VazHrKy8Vvn1IjoTofXGxA8pWYIrmb3xPiRaZsTRVKPvzbBfFxYGw35nA3j5Q6X38/qNE1dU=
X-Received: by 2002:a05:6a21:4cc7:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3c8aaf7afcemr1214241637.6.1785214360856; 
 Mon, 27 Jul 2026 21:52:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc7:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3c8aaf7afcemr1214207637.6.1785214360470; 
 Mon, 27 Jul 2026 21:52:40 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:40 -0700 (PDT)
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
Subject: [PATCH v6 091/103] tests/tcg/x86_64: system tests
Date: Mon, 27 Jul 2026 21:42:35 -0700
Message-ID: <20260728044248.137626-92-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX+al67m7F5rK+
 qdGa1vRiT77LImOuI1bqsOiq83pEZI0oo3+LEZrrJuEhoElOpZ8ZjuuDqb79IEoxr+aIgtVqZkr
 25sk477VV1TpmR3V6wYgRgD5+wbW1QY=
X-Proofpoint-GUID: r3RARnzozw8uAOcks_Cg2poHcgPxrg2L
X-Proofpoint-ORIG-GUID: r3RARnzozw8uAOcks_Cg2poHcgPxrg2L
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a683599 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=UwNeOaObgM9tbxZIesUA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX68Owwe42wGb4
 iWWrzUdxXlzhttpYBBf9N5yKyt2rwP6ZOTDBNbTQQ6ThB5rngjLKpKoNXxGQOI+S710+xvfgLNQ
 U37T+ZCZgegRhQN7PLKLnBEO0QFKTWtWl9roGTFxU1mQIiUYadkglNmCPoniZLMMwF8B/gTdPq6
 BSkZJ5Xqlkk3PXPy74fUAQ1lJbedC0BNoZsdliScbG/qt69gXMwIJWVUw15+eGjcvAHgGSvqxZl
 laHaszHrm4IEF6SCkR2MlBCM/ZALXEqm2uWtXjupPEDlJlm5+gcuFcZ4h1TerTHwLHIVHBRqQMr
 eLAIs4Z7xwYNgZyL3LWH9RKJcg27ecC2ay/uGONrHbaAJtXOaJVEx603aTBnEGpONC0R6y+352T
 /B6CvxzKLrpX2vVF5ewySkvPRFsq1RpLREB/HoXJO1D2bTTWqdMqeBZq6QmNaMRhIHG6U35hv07
 +VXw610Sd4bGsDCxN0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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


