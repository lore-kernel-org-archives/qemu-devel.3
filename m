Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B825C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRY-0002YV-8f; Thu, 27 Aug 2026 18:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRD-0002Fm-Uo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRB-00075l-Vv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLolm547115
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=axI5H3viwyp
 KqShaClwyTp9eSf8a0FQnfv3nw6FzysE=; b=WzTE+2u6VFX4pOzQXvcMMWpZ4Na
 nCzIM7fyFxH1NntEVrlFIaTHAT9vm6r8L+QHm3mjcK7AVyv8jMdVUwe7wGHvisIg
 eB3zkHv0OYuVRQQ0MKvxgcC5O9Ede4PedlMKdwyS24743tuXsey4VV5set5nUzbV
 rBX4sDE9dcHi30zmX0ugGxl1VnbQpepVxMC7gGJuT5f5JhR5wBsFwGMJSDU/kVN6
 W0GjcpDZHko2ushDuXsOas+PFZqDDZCZFQnoewggUNxdSsD7EzAjUuKZyevQoN/e
 bYU3N2urR666qcHfbr67yiGla2zFTxN16FEYmVRFLZTUaWIe45GYSmCyEsw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562u1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so921561a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869148; x=1788473948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=axI5H3viwypKqShaClwyTp9eSf8a0FQnfv3nw6FzysE=;
 b=QJD/xySorhWuuOghAq5sBHZ/DGJ3FbCbJULXwmn7aZ0pkK9S8qOPsE6SSHXou5rX39
 zf0qgitZsIo7Yc/ih5LtrkGVIAI6WVSf479M+XASzYD5Ar+SObY4YfMjc8WOmJxGbjRI
 diwhfAPCAQTH5iuzGeCeVRwON5juhZSXpx/16dqtrOJg1sXle1xemm5YoQdtw3+SexW+
 ZO421Ymy9zvTEalpcemBvStMOGTJEOyRynNEjGsYZNYD8+7Lyx+zHvWOP+8UtKmgfpY1
 Jl8wLfsDPOJg6PcNkRf/HBG4PnDYAgUrkVwn4GbXJFtQauBiej/z1/SGZ1THb/1pp1Qu
 OO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869148; x=1788473948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=axI5H3viwypKqShaClwyTp9eSf8a0FQnfv3nw6FzysE=;
 b=kCfdCxMqFMCHO8fHqPQevKvaH5kmSE4KW+hG4Gr2Q5TUxj2cux6D0FhUCg5ZoYuvO/
 qwx/BMT5rCArN+mpGwyLQ+nBagD8dBfqGC7zqRfWtEwnRsWnQ59ti+gum5N3op3G253O
 E0uUazKCzZJHTvAH7+nFANG5FP4jMXBLKSNJ78PDvn68wdTACqSICiySdaWCIeFcS8JY
 OUJpLW1mxQ+j81LEVFXgB98C2VgTc8ICUO+gYq2P8J52GcSzxOYVkuVDyNQl2SvL8msE
 Z7uEhjKPFHmWcfbkMeIOPISHVrvh3bEQVl7jxdPo7BZzbGTGzomkxvjb4ZVLSuNzaab2
 aU9Q==
X-Gm-Message-State: AFuF++kBfIosiUmF8tAvhSXIpR8yhA6gu9vpacXgkK7NJ+JqgQs/T2Yq
 Yuf71lbhT7bhhZuXXfuTkXaRmi7uEj2E5qI+iAi17T06KJJscTjSNs6hYxDB94LbyvArC7NWrHM
 SuuJCUO4lgr2cVGbOVkJ0cjzsHUPS8jTkaSq67KCWFR3k7ImD/7JMqUBFWBw3D5s8Vg==
X-Gm-Gg: AR+sD116S3T+J+5Co4qa29VIARLr8zPqkbuc+tTLrTjNXxZn/o7qDsqaI87TlLEUYuO
 I8r67FZafSF9mL3QTlECvKMKOk8KcTW/7v4yT2mCnI08N/bflVGpgczgzJH+qUx8Ee7f27rIi3T
 K/bJUTOVx7cYG9AH4v9p/eVSMUp+LNZI7o2KO4GDTfetV7NbqaBSg1WzvlhjFrvjIc5qjcR9Abc
 3nG6M18k2xKI4kaCc+zrYUpxgtZmTVqfagplUFA1s8aqANo55UEE0rgITaqc0E2LjBhAERJ5y2W
 bcgYUvp/ix9pF8Kk1xFA1xIHcpyqPMVy44eZ5ADvunPQox+Sq+qYftaNL46XDg7Qs0+F4TneS6T
 eJVv0JUbSaQTO76Cu0DOeN3LSQGRvzTZeMO97dKOCVm5+/Y8cshZTyGH0ARU=
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-396d0e25905mr4418502a91.2.1787869147774; 
 Thu, 27 Aug 2026 15:19:07 -0700 (PDT)
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-396d0e25905mr4418401a91.2.1787869147316; 
 Thu, 27 Aug 2026 15:19:07 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:06 -0700 (PDT)
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
Subject: [PATCH v8 046/105] tests/tcg/alpha: system tests
Date: Thu, 27 Aug 2026 22:14:07 +0000
Message-ID: <20260827221506.91574-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXwMEwgyPLZziS
 NIz6JiPMCcQwBOmGs9kIbOExk8ZMLOGz+Z3loWa64PItVkCDhpNiAA9RxXCMZfNr+8y1Uth6gS+
 otPYtByeZfg/rKb/MUxc+FfRybrSS+4=
X-Proofpoint-ORIG-GUID: EYhDskv_mebMSae5_0gg2cWEzHQ6OC1b
X-Proofpoint-GUID: EYhDskv_mebMSae5_0gg2cWEzHQ6OC1b
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b7dc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=04VGBHJcbsNav9IjXu4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX5ploH2XMHFVk
 tCrVDJ6gM8UZkaJq0nzF+k8NFXiy2OD//QdWBa+9gxOZDwZtHSOo/XnoNGVZ1gTCWIchpRUqVm9
 eyctY3MG/qzCZ7wCYOx7tfoganjXKAefiaDIDltbFbw3wKY6xEsSVsSHsBdQ23iWuxrx1iOLkLz
 lLzA8P4xzitlRLHfGIQ3fE0m/nTsvTZVm9ob6esTwMdM12GIfqU/TONCnXDWCHPScj6IIjeQXua
 k7iSpO15QesZaLcc+qwhYoq9UALqnli3XOJi/XmRiQSB+DWHpQqTdtgXoofwWlNWe0I8Iy6OZ7H
 De+VidtwMEzOmZJlbQMxBLdhRBY0HBS3HP6Qvf63Mii244f61U9E+/O5EDYsr9kcgHLrvZ5vBRB
 6t5xe8dqZu/hYyLPyvW1JdzK8T017E1ZMBqPMJFL6knZV4mQE7jJv2DwReG4u77f2fYPnTTaQl/
 nWnI/Uc2QoGpaXLK1qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/Makefile.softmmu-target | 34 ------------------
 tests/tcg/alpha/meson.build             |  2 ++
 tests/tcg/alpha/system/meson.build      | 47 +++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 34 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 create mode 100644 tests/tcg/alpha/system/meson.build

diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
deleted file mode 100644
index a944102a3ce..00000000000
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Alpha system tests
-#
-
-ALPHA_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/alpha/system
-VPATH+=$(ALPHA_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ALPHA_TEST_SRCS=$(wildcard $(ALPHA_SYSTEM_SRC)/*.c)
-ALPHA_TESTS = $(patsubst $(ALPHA_SYSTEM_SRC)/%.c, %, $(ALPHA_TEST_SRCS))
-
-CRT_PATH=$(ALPHA_SYSTEM_SRC)
-LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0 -mbwx
-
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index 08e371116c3..fe60ce2496a 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -2,6 +2,8 @@ cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
new file mode 100644
index 00000000000..b10f2c3e28d
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,47 @@
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
+          '-mcpu=ev6',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += ['-DCHECK_UNALIGNED=0', '-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-alpha' in emulators
+  tcg_tests += {
+    'alpha-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha/system',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-system-alpha'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


