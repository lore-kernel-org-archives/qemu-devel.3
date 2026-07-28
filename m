Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2F1C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZje-0002Ht-U6; Tue, 28 Jul 2026 00:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjR-0001em-RT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjP-00026Q-Th
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3acPi1527520
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bYJ66kOwk4x
 N1+kKUGmP9nipc3lUtDEo+WT3XpRtnMc=; b=ToN7tJOeVOs9Gpy31TpPgUPsklY
 N6mrsCx7wqtpcF08IZPnaFWXZwkizr2LYEUqy0F5cK04ryt9XvhUTPQk09Kevitv
 QzldxCUKz92nbxrFliKh5xH4kFw/6XD1tdGEWGVff5TYLGKbnMl6Jq8Ltudw5l19
 JfqzsLp8ZXqTCytw0s9Xegcztwd5qkgBJnZpdGZ4g5NZ/ic4FdF9AE8ag/4towYd
 9jetR1eJjBfPwEFj0V/ocDcY161imuSMpKDC3O+uZicYVDaXB7jhXMAwcQC03cL/
 /ykw+oF6BhspaINa2wOkZbTbWCJDaNadc308OGODtPmX6R+e7GiuAF/LwHQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8ada9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb92868263so4289709a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214074; x=1785818874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYJ66kOwk4xN1+kKUGmP9nipc3lUtDEo+WT3XpRtnMc=;
 b=Pm9iI3Wef5DQ/Zq6iI+2WY2HhhTtIMhd5o1mXI66o1GnsrpVbUiM25h6gYv5AD/uBA
 oixDftC5aaoiHflwgslXUUR+Hu1SSa6ajqwosrX8+Z9QLI9LqCoPTFh8rmxK3xlPUD0x
 /qCKWzLzfhZ+2Cachb6xqUQrceCreng9gMIwnOFvXW0miZXdEC8P/hWtVC68SQn5Yfri
 uohlfLT2z74xbAQ8lhfYvwJE7AEMPg1uHCok91DQHstzFHiEcjyi/6yugsKJUeao5Wj0
 CZxocXR1pTDggTwNYDmhNIZrmDoOVplBtebigeGO1xuoYzK1PS2xgSS0w9iMTmMm3R+j
 BFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214074; x=1785818874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bYJ66kOwk4xN1+kKUGmP9nipc3lUtDEo+WT3XpRtnMc=;
 b=IgCjfyl2ZRqQCA+uXZSZqukQrDadBFGwjP0o+rGzJmv+bcu1CoXcvn4ZEOAJtDYcFF
 /Gb7ivfRPpWBQTmrN4dXcdRe5aDZauHHJW8D3QwxRhRY0aQwvKkSaQsNPrQamu4Ll1c9
 U7x1hURvqwO2Vyq3VgELS7lyjFboaYzKUZcUErfKXVz5TwO5zsPBSOZbVodWEtKaBv57
 2zyYQnSGns9DLyF8EtAayG2r+tsFvE8RboaXaScMs0jnjDuSsXg99iik7SvqFW6+gfyX
 QnCIiKixYmGqFlKCyS4+0u70e0d8X3qI/BtBSIAREwEKU6WUuVGo08AalmLjneqLFYsv
 qCpA==
X-Gm-Message-State: AOJu0Yy8wsDFv/Pqr/dKvzOxw7f7PNJcAhljyk8CGQAr+fuW2g6adzX/
 5TDku8A2dX8ia/RGFoE6tOJ/cDJ6CWQjSeYZNwB7lChi/x7U3t4r6YuMrXtLFmTxRjb0aBoTag7
 U+AYsZtH/2tZ7wsm56O8EgpfcHCzCvEfG/QrxoU5N+KkDi79mKwyuKOMgAkxzcB+p/Q==
X-Gm-Gg: AR+sD12Z5cTBRAR6N2OD1Blp0zcq4/FXjRjaF57xHlOoExnUCrzoTHOGBLTAgdjEVrz
 YNyPdTi/TFIke/3LX+IKZhI8HXuHIWLN7x83h9veDkjWV9sGpNafjHSLkjVMScGpYgB553hbHOA
 /kmEBWzp6WVjIYIl8UZtWsDAlfLosnNyLiu0plj0ppGEhvaa5i6unDP1YAFrWiY1sYHND+w4ejg
 eSKwtrxDw5gqvOo89DonsqA5oXWrRTf16oGDfJXpLpmUl2sucFu56Fkt6daYfQteYzWElSV79m9
 /ImTnLyMQXCNT9nVhKxsTRf9/NNsQ/NKcwplinkDQoGMqxhWq2Oe552gDivuibQ+ORSs3siY4xx
 4JWTJSSsGuSzEJfzcEXawZhLqHlBVAdy0iJ9OdZKhE/oQa98gPP15L5gT2H5+awJiVB9SKOY=
X-Received: by 2002:a05:6a20:7f81:b0:3b3:f46:1efa with SMTP id
 adf61e73a8af0-3c8ba60ee61mr1146913637.42.1785214073816; 
 Mon, 27 Jul 2026 21:47:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f81:b0:3b3:f46:1efa with SMTP id
 adf61e73a8af0-3c8ba60ee61mr1146874637.42.1785214073257; 
 Mon, 27 Jul 2026 21:47:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:50 -0700 (PDT)
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
Subject: [PATCH v6 055/103] tests/tcg/i386: system tests
Date: Mon, 27 Jul 2026 21:41:59 -0700
Message-ID: <20260728044248.137626-56-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX3iMJxkpqZx4Q
 E9dpR844OYGchhNn1HRGQpd0X8xqjIg5A7qqcBEMw+ibjPSVt84NFhtovfI8nP5jpieWXaFgOUN
 HSc0z/TwMCQxep/nDiYp5xcg0xmVeXR/1eNtyiILtCctwmY3oxS8jkmdDLd4m7KAyNRxnEa4s++
 9P2aXoHabeFjLcO2WFxEfUW9nWatH39k2A2aIAYew9s7Edy6Iaz3idbXAqkifgJbLoE7jlIW5gk
 ea6chBL1w04Nsk+KeGSVUMjHh0IyHUggFeyoW3YVyg9uXn6Mz4CJKbGYldaN3QNpA4SwOeoZmaR
 l1Hp5KeNLTwOpPS25wB94/ixjK+QzeYsEJerYJfdg45JuJcrznPu2+vHEMT4Ee+KbEr4U+FmBVI
 niF2zypqlXSKBDDmkk19llb3ArjTNK38DjRfZAiaWPFu8tMFZDICdG82NfC1h0YNquzBSURa4qr
 RTR7EFsy6xYzGzmcJUw==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a68347a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=YfLzPEwJW_iPccEctz8A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: kO2gzWmQvIGEr2fbfrLRDwbV8NigwFoP
X-Proofpoint-GUID: kO2gzWmQvIGEr2fbfrLRDwbV8NigwFoP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX9Mp/riGJ3v9l
 JD50r7aJ4vqdrPHN2c0IztwscC69gwTqDYj+adm/+z9J1pGp0jQCS8OHyY3hVt25ttET61bU5nt
 +zDGvd/01z317txm7JMxdjCrALJ6KzE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
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
 tests/tcg/i386/Makefile.softmmu-target | 37 --------------------
 tests/tcg/i386/meson.build             |  2 ++
 tests/tcg/i386/system/meson.build      | 48 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 37 deletions(-)
 delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
 create mode 100644 tests/tcg/i386/system/meson.build

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
deleted file mode 100644
index 4096a1cf31f..00000000000
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
-#
-
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(I386_SYSTEM_SRC)
-LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS)
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
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 62074b86c9e..5cda03655fa 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -2,6 +2,8 @@ cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
new file mode 100644
index 00000000000..482a400555e
--- /dev/null
+++ b/tests/tcg/i386/system/meson.build
@@ -0,0 +1,48 @@
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
+          '-Wl,-melf_i386',
+          '-Wl,--no-warn-rwx-segments',
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
+if 'qemu-system-i386' in emulators
+  tcg_tests += {
+    'i386-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'i386/system',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-system-i386'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


