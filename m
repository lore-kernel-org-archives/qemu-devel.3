Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EDEC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjC-0000fj-SE; Tue, 28 Jul 2026 00:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj6-0000US-Nt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj5-000243-00
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bAxC1062981
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o0R4hv5/zKp
 gL9fcw1LgUfWeYGP7sRAI0Ua+7Q7lPdg=; b=Sn5Xi0nB2Ha1TQQvblDQ+8SoCQe
 pJ9v1ua0DKwO3AWUpg6iICEmKBPbFwIfs0uE+09WsaQSKk3mFy/Ubzh558e9sSBv
 e6xKwUJf8K6BO0uP+qF8BXGC1D3jcKCXmP/ZoG/QLxgVCuTBGf50mxOa0YcPZHfL
 d3NVUV6aOxYetywk5iXMKOtloAn7m+AwuIP7CK5OaLruLcnRpWdQ8BnxvSO4fFiq
 JQuioLcnvUxOofmqfNiP020JH2JW4GSD2kiz39BXZ1LgjL1m2+vGsIc1bMITEGe0
 1uS0PbAgi+jGTulx8uzl4yj4y7j8LkEra5rX/B7UP4ND20K9NQG0ofyO7UQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6ch7p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so5634424a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214053; x=1785818853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o0R4hv5/zKpgL9fcw1LgUfWeYGP7sRAI0Ua+7Q7lPdg=;
 b=XK28TmlYAdRQuTiCDBKXi91e6G8vqZPRA6Ie/kVQZFdLL7cVFl4C7QQtSZdHR6K0fa
 Z8j1saog4Q3Tc4M05LaMBTra4m2aCNEAAuPhHJNgGA0+HinT0EXJl82JTnv35mRvVnnR
 OYaodJYRG2+2rszcE5PVgEzclrSC8+9nmVoC1+j7cpZaRxSioYMqv5vbiuOyAdecjF1t
 ofVIfdQ9GZQZY/2XpOGzU6IOwZyUabcNZ8vCXlAT6DpIuUQx1fKRmljc8qHsGchOqF3l
 XRQe1YxiHbpyrMXLtnFTYp2+a2PNPg8wJkhDTr/Cp73fLAYk6VIhss+pSlfmHHLI85w2
 4lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214053; x=1785818853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o0R4hv5/zKpgL9fcw1LgUfWeYGP7sRAI0Ua+7Q7lPdg=;
 b=UtS09AwELVLbMjCdWT81Z65MPqVNmOicTvQ1UfTxAGBWCi5xXPbZlfk5LTfgJsxN8p
 5/FI4+r4VIMIysjtcoHTNfXxWRKKBabbpo2h2/0cd1ohvVmCj5JaSa2+Yz3SpI3hWzzS
 nwk6e0/fLxJmjXgboNSJACJsf9KLJKYyhBcKM3SDKudKJ63XTXPkVVOu4wIrZ6sFHuwF
 mgZg6Etg4zbY+VqZIS9d4OnGaKqIxyQCUIP0+29FQz+8LS4aDWkMTSQwwKcL8T1emKl5
 02FIjSwFBJNss6vdt1oZ5CMQq0wGZeEVurIYlMpm39bD/JMBioDyAyjloeoTNyL1U/3W
 6qoA==
X-Gm-Message-State: AOJu0YxhnoWWUWpsmXjG8MqMk1pvb53EYY6gygf7nmxStiv4p1hjZGly
 k0XPXPT6KdjopkmaCEVfFOrSt3f4C9GmYoRFk6Br08IfanEjFZOLS+JzDsxz2uAbM+5BIo1kJbf
 3IkMq7oAC/f+VyO1SQKfdnr0yeaLp5kQ2OsVNbQDqwngl/xn02CE07D0i6uPW8YPiAQ==
X-Gm-Gg: AR+sD114inajbNezacdkd0urgBaKE5sDBCWw29i89PD+NNXYj3HwHui+onvOFgavQaQ
 SU7s4+5HHqej9XdMYeZ/l4OzzBhDhmjXIodv+FN9oUF6mrDUwGNm9/WtzFuudD3z3QeGoVIyf5K
 J0XO0BJMrGZGwV2IWfRiz8///pILOll/ITlrT6EgHq1RiajUZarIijuMXrTn8DaaDzqyQSR9qgm
 ZZKFQ+iqzPwKuNMgQCWfhOprB8UfdlZ+7J/nBgV6mGPsuNvquaT2BcORPsVp2sTsSdMM/te5/89
 Gb+XyGIgMQP9PmNi/jGauIucM3+vkkcwhlULALXhHMaA3d4w7BS+pLlIfnAqUqCrCYbCDQu0dpD
 gdEP1y1J05vwbtNalMkX6txmPslK9OQvIGelmSUdJAqH8AO9n2lfxNpNmBMToLByscunCUPU=
X-Received: by 2002:a17:90b:2d0b:b0:387:e0bb:57f9 with SMTP id
 98e67ed59e1d1-38f6a4d6eacmr770356a91.42.1785214052575; 
 Mon, 27 Jul 2026 21:47:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0b:b0:387:e0bb:57f9 with SMTP id
 98e67ed59e1d1-38f6a4d6eacmr770327a91.42.1785214052103; 
 Mon, 27 Jul 2026 21:47:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:31 -0700 (PDT)
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
Subject: [PATCH v6 045/103] tests/tcg/alpha: system tests
Date: Mon, 27 Jul 2026 21:41:49 -0700
Message-ID: <20260728044248.137626-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXw5HyyA+BCzqY
 nLl8vcW5iZeuwhk4UTqJMnHZ9KblrAd7IBFhNFiJx6QZGwtquwuUQ/R4zPtyMBqF9DGyAYJB3+c
 SWiqhKqW+RUlNTiriSoT/K66ChDEtuQ=
X-Proofpoint-GUID: TNq9SvjVy8LnP-Nn-rGk7yOpLcoH1M_7
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a683465 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=04VGBHJcbsNav9IjXu4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: TNq9SvjVy8LnP-Nn-rGk7yOpLcoH1M_7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX/QY9WOVnO4lt
 W+654BMhbT9pPbg7+83n/xDOyXiFvv9gfi68TeKJ65QWCA7VKjrom/DW//8fQKVR1le9Wr8DrCf
 BGZUnShbkqR/D1S6/TUaNQkAtU6TwVtxmBmp8np24MkYaxRHqpPIaM/0L55Yn4o79jPRD6i+aet
 DpuCcNxSpAWdeTEdvw9J07HnpgJ+bYcDs43d4bA9mVFyKHxBSiUsdTdQr5bIiv2coTNCC1IhKj+
 wdo8gUZ3+P7DDgLpDuMPbEiBW7pItHrZY4ZPsgA8LpvoV5M+MNmGVyu19Ybn0f1YiTzgJp+FVGh
 QGE9P4V6zvr2pb6D1s9OZodu6kAwIullKAkvUVCLhlGV8PZ8CznxyAWVOKINHbPFr4TvVXw751I
 dPTE3d4+e97dnleBERQdtmEVPc9rVkFBQbmUprv+EHg0vwshjWiPWRogt/EUQphxNd9YIdmr8TN
 pmV22q3VNgaHZF8Zskw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041
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
 tests/tcg/alpha/Makefile.softmmu-target | 34 ------------------
 tests/tcg/alpha/meson.build             |  2 ++
 tests/tcg/alpha/system/meson.build      | 46 +++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 34 deletions(-)
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
index 00000000000..06558e4a9f6
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,46 @@
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
2.47.3


