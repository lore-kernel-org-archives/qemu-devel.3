Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B224C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRf-0003TH-Ac; Thu, 27 Aug 2026 18:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRK-0002Po-E0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRI-00077a-F1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLsv8653850
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HYixEbMMLPU
 Ie1lzx2vQTub35XR73cHCNICyiiHQKcU=; b=XvJ2Rw5LhT0xP3HR/Gpb0pWdnLY
 GgmK4htlDeGeFAfhx+3rZECiaxmo5Yjvqy3gahbNOZQ2kTGEe0jP9qU55fwzcHdF
 Yltrbh/Nk5f/h5iE61uJHvq+F2SMxRG6r3zWK3kBuV8R1hifdDwaEtDF3youkj+8
 05olwrubtjhCC8np80QLah1J2g3CXKyT7O00qVi7JxMxskv5DFpAFtHojkmV1EDe
 2BOMUQl/j1BZs5zwGJ147XOvF0P+VuuziC+fQ1JH9NjVeNNuquNOovNycwXZV9Vo
 CTZH7BunTG6E3koSM5cYoAE4U7gkoSbJQhgWAGY51/butcYQCzOPVSX5THQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuke7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so416442a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869154; x=1788473954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYixEbMMLPUIe1lzx2vQTub35XR73cHCNICyiiHQKcU=;
 b=DA06Coq/1pBRveV8RCj3YeaQ+868madGTTjtYV4YVZ8hSgFsg9Nw1cxxP8REr2NVLL
 eDBxnNn5hsMa1sQG1F0TuSF1b/RXZ1aBRyHaEQJCVSxJvsBe3LIZ5abZK4JGVfo0duIJ
 M8ix8vlI3BUS7fyke4/g3psehRppfUYr5kRHklgSoUHYO3QYPtvagCoAmmku8WJZsykP
 TypK2KF7OBARPRhPl8L+OuSV1So5QOcOh1+KXHIw5Cp06W3BUFiSZMDlQzKykLsXiPeg
 itH4gYL9OPlTXl7JwWsSRlQ45trInHGHxioxYsQhkB2DhBmKuSGcmqyrVCDhFmsBdNyr
 WPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869154; x=1788473954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HYixEbMMLPUIe1lzx2vQTub35XR73cHCNICyiiHQKcU=;
 b=MOfc+A6+UcnvVOizZAkRXrm5DGRhPeT08GP1jUWoWDQ84WUjg+fuNjCkoCKONQlu7S
 HWWBViB7BoxYSIYc+/VeA43wvlTzPLW5SVbxmuoEr0P06FCO7TEcFiGv2PBodsBFT+gq
 7hcKb88EK5YdQTWaljUAEcOVBXc/PdHgBHtabQykxaCAf1E0uIsGjqXT/mklPRjE825h
 mWDS/zse997cTmdyUs5LY33SD3zE0sZjEXaffW8QjG4kC4hJRIpO/0F+sE1sErLJcmMF
 DBHjLWhzrpyfqj7TyRd02Ju3sL4HvD+3WwUjuAoB5BmBS8rATZTiDZe6W7beRsjTM9NN
 uS+Q==
X-Gm-Message-State: AFuF++nzwVK/HRMpb+MFsO9Ht0eoMIVtXKau9aIqshR/pGOtIqdLpzER
 bKOliBqGW9q1aHAvWk197/nsboaODR1s8q0E//8UCXfNblfXZU9AYNydM3UgkfagyY9isAeZ19A
 gmkld+3i26GlTweBWdbD5HlIhjVSzFLZB+Bnv3WkKwjXk8EUYlI9bpOhq1wdyzWzCOw==
X-Gm-Gg: AR+sD130JqqVer++uNy9zUPmgK7OgcDzXoHBCFRoeiKeMteI2gaQNZ12gPTCRbnry2F
 ON+3WMAJAkhTrdCWlOzzliaUD1phLmAE7aobAHklrBI85BaMXOOapGKeKbFdmQPsBDzOPoGR/v1
 NQQgUGwefJJTL/BFS79VjOJzppvlVxUpIdr2/uVXgISmz7kxA2fwbhSVqX0SROFVmnnwlDgbZB3
 4eWn9fmNazTBzYOKu5ctAmyLqi62DkxrlW8zsZ1vweOYUi3aob/fqWQZxfO2unHAuukPIOr5S+Y
 TFhEZP70Car7qVBoResogaEP38ONbSnlfgiboPtzkRVPnnzYFdzwie0Mu8o7uV1orwy2KOIFyR/
 46R54fAWvLajOrF4eoOtiXmzEqWZMpkvCPwWp71WUrU6uVn7lJGTq6d9kwMM=
X-Received: by 2002:a17:90b:530c:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-396d0d4c43amr4858869a91.3.1787869153928; 
 Thu, 27 Aug 2026 15:19:13 -0700 (PDT)
X-Received: by 2002:a17:90b:530c:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-396d0d4c43amr4858788a91.3.1787869153472; 
 Thu, 27 Aug 2026 15:19:13 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:09 -0700 (PDT)
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
Subject: [PATCH v8 048/105] tests/tcg/arm: system tests
Date: Thu, 27 Aug 2026 22:14:09 +0000
Message-ID: <20260827221506.91574-49-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W3CnOrFmszM7ig-GPqbrBje696hwvjiv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXyQUTFm/3JO9U
 fiOJFAq62EUt9mWCsB9HvfNklW6nrmK7qEP7Pg6kOozl8mAzwQAbIJImWNtVAsjFCobJ84pjTB6
 TaqBqvN7q3MF2KQ5rcd3WRSG26+GVQ3LKKo1GFYSxSuFF8mM/McE5J9WpQ9pBTJbi5xjK/4svC6
 KLOm8XO+YFXAceanY+kbTRbFqsPL2U8MP6xf3VQEyPv+BY+p+ohF4tva+1bdeZtfngA6Bh2XgiE
 BgDE6hcrPyU4wZCr1kH29W1v2Z4z2b5l8hsi0703UD9dNQ/a5lSkLwtn5D1KxVeGgwEoIZMuvq+
 K6sudLHpw/tqZ1E7V1KCgun9iZF4lRWXsuDNb86yiH6HDfVjGnUYSw9LyPk7ty/AFWystadgseZ
 hLRiykqzYF+LScjpdYMclbUwDzNFz5wdpQNTzx0QobpQdPvksqkMdAHSA1t375bEl8XQCt+mmhc
 we6TgAyLowGOisjC5Zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXydxlUi4NSI7F
 9J9iih+IAibBU+uiQ7yL5dt82tBLQ0y5Y5NgODZwH087ukpppGF56RVyB+OCUEJJlu1mGbJfDsG
 4IulZvDslfsosZsIO4zao9CB3fLimJI=
X-Proofpoint-GUID: W3CnOrFmszM7ig-GPqbrBje696hwvjiv
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b7e3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Y8YNHK5ebSjiydjNMO8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
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
 tests/tcg/arm/Makefile.softmmu-target | 80 ---------------------------
 tests/tcg/arm/meson.build             |  2 +
 tests/tcg/arm/system/meson.build      | 69 +++++++++++++++++++++++
 3 files changed, 71 insertions(+), 80 deletions(-)
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
index 00000000000..4c77b9c3d62
--- /dev/null
+++ b/tests/tcg/arm/system/meson.build
@@ -0,0 +1,69 @@
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
+          '-march=armv7-a+fp',
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
+               '-Wl,--build-id=none',
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
2.43.0


