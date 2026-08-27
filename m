Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0AC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRE-0002HD-Nu; Thu, 27 Aug 2026 18:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRA-000233-MH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziR6-00073h-W7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM4lv849150
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HEbYDwPCKdAYcklKxGLC6pOCukyrw7zwtghUF8gq4W8=; b=XAVLNO0upFe7nnA4
 DS2Qbk37rZ/70Pr81Q5aIsyp1yQiUQqIu04+uFDyqkNHP5Nu7Gqtp+FXJHjECKIt
 Xx0oeToDNSdVJiFX0IuyX8pzUtB/1fyIT4z/KPyeVqeB3w8WXoZB5yk8fQUEomse
 dhlLZ4dB1NmTRLS9bIzP+S8Ff9KJc3ZSdGZwG/N3KumTzLjYqhoM5OtIVWM37gtd
 VU3IDeUejz2OU4TyPgqJZocWbYZl8R01n1YIUYh4pqb0NJ5sBQytjGXZ39YWGhlU
 eO2A7zHqnJKGPFbA45iruXa7DeMgFWKgm1Bo8CPUppnlsUEj2URCO+nWa0vwM960
 xsnU/A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a7db-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso452511a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869143; x=1788473943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HEbYDwPCKdAYcklKxGLC6pOCukyrw7zwtghUF8gq4W8=;
 b=TfP4nz6sVx1LDXO92HQ1Y9iAYflQkIG9Es062jzo7IyFLr47jHET7JtT70tZVYsRVV
 AMxpgWS5FXYvjhcdiiJwt6uPoLNaQzj3zU80LEqIO7z6DhPKmOheTMVs9qMyKrqmV+nN
 FYi0bdjfcGDUcUAZgxcdYhdv8gqFoi/gT8ucoWPmE7rysb3Tw/nRzmqp86k2t767kSDm
 eXGZfdWrS+VYOBLUerCMqNo1l+uGwX6v8uBkx06baXJuNxvqAnQGK8cKDCm3qDrxcIQC
 IefDy6lUr8g31gCdbAyQUup3n8qcAvg0PafhUm8tq41+JYniE+uXrxlwxWPtHjuXZ0AB
 LYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869143; x=1788473943;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEbYDwPCKdAYcklKxGLC6pOCukyrw7zwtghUF8gq4W8=;
 b=YXcf2VysJSRV7b7Q+tXa+k0U6LrurXKQMNs8yW/M5sUK/2aUzoDzprJmoIdLyXpI37
 IEABmCM4QBCcUbq00mYQvI6rNs3pnA+4hoXOnWnArp/OiG6fbJtqPVlZnPOKKh/cXNWh
 OA+y3uUFzxvu0dqJydlOOiJakp+lp6RD6nPG+qecWVZjTDyazoJQmX2gIQtSJ9wks1OD
 ROTHzAhfIgcHpQq0zv3xvsQmm7lmjixVdQ5p5k1L3w/1J4kQUqwAdyABeF60xHmaCgqs
 miPmQXSYfR4wbILHzKjMI31Oiagm3gt45zEpGraEpSMynzlnf7zH9L2YmXRgf26qfCLq
 wcbw==
X-Gm-Message-State: AFuF++ke2cngxRbMMxZCcNCuQ851Jp9NRhW2aDeovMy06X80fz3cjF9J
 oT7GVRvB6DBvR046WcBRjauW3OmYGhbOBz3J7DDk/JbevfMy6G5LXRANUU4c/uQ+dJScPy+tvx3
 TyMDhXEtepzKzwWdTKnx9sk8oZXMZE0H/Yc/DnYha5udVYtITQ/JtmH/r5Zk/8Jj8iw==
X-Gm-Gg: AR+sD12RO8u9b1ELClUERQv9ArNIGTgCj0ba4nSB5SkZaFhlA7z+JmCTPTAQrTxSE08
 /IuKDERnuogIdUnbbci1Cpd6gYzwg1/q5OQEHSe0fNyvrd0u3fh08WH3Rzx7GHOMnLFyoNC4CmB
 bu3J2VbOOi7MC5Z60tmoWfHZWbq0MzZrlna7ESXjXrDzPSydup5aakt1fz5gaY+HwXN86a+1a6N
 g8fbteqCRrKRlIpJOBOu0y6T7oCtvjW72JTzRd0s8g0HlFPWGUGCcUOkkk4oZZzhvTu2MzzGwht
 NQMr6cKlxWeYCjiS/yqt8ZDZ93FeeRTF+pcsiJwzjTio+u21J6lB7bQsWB0Ndi43Anv/qvSFaZz
 4C2dThxuJMSaPFPfzUNE0Iwi1pQZP7fxV3Gs0TNBz6IL1PvWBPOxaQ2a2Iys=
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-396d0e27e11mr4699952a91.1.1787869142792; 
 Thu, 27 Aug 2026 15:19:02 -0700 (PDT)
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-396d0e27e11mr4699841a91.1.1787869142234; 
 Thu, 27 Aug 2026 15:19:02 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:01 -0700 (PDT)
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
Subject: [PATCH v8 042/105] tests/tcg/aarch64: system tests
Date: Thu, 27 Aug 2026 22:14:03 +0000
Message-ID: <20260827221506.91574-43-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXwpIp9GYnKZ5T
 qYO1ZOxlDm8OpBgMeFyRgCBQofto6J17erDKas/Hvwsi5e3luFfQ7IwTA2pWbBu+ZqY34y35ATX
 EupFv6xHzJDBOohJpTWgnCWpXSmmjTESIqe9e2WJvNl1LISzhDFVtKrKGOzmn0QreFjQUCcTpwu
 QvN5s5eyOmwoTJ7r4al2Namta1wgVoFUOOtQde3kGOVZYqAxGT1f9jelke5khwOyaesQJoEUokN
 /QYlD7BIIsX+/5hqoRv+ikM6j9x4r22D4o9KPSX0MtX6S4/ctaEhfZ1VVJgGUyVgGwq6zvUTAls
 2kIYTQCu1uln7GgG6PkX5svvmcoDWCsmnRpd4VlqYhkzQRJnYWo1DefSYXvkjlvNBfowqDGw5ZK
 VrdbfIUPUDkcvjg83J6nwSm7n16FVm20bujNgQJhU2mdLffLV2ByU/CZr2JxlFypQLGRC/25pYQ
 cIVes9F+EIXJJzkaYGQ==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b7d7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lKJin8fYq-Jz0iZqabkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Wev8IFIk_YvVORHxltFsyYjTg11rK1hv
X-Proofpoint-ORIG-GUID: Wev8IFIk_YvVORHxltFsyYjTg11rK1hv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXyX3jHYnQp5R2
 WSuJyEYLzxobPnD+r8Hcsa7WjtvwardOQ1exgqD4Rh8bPYpWaebxAlWrw705upJhmTzytMROwlL
 Yve56sKqiT4dbsLueFndK4EhiSsvaf8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 147 ----------------------
 tests/tcg/aarch64/meson.build             |   2 +
 tests/tcg/aarch64/system/meson.build      | 109 ++++++++++++++++
 3 files changed, 111 insertions(+), 147 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/meson.build

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
deleted file mode 100644
index 3f30be6c5d6..00000000000
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,147 +0,0 @@
-#
-# Aarch64 system tests
-#
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
-
-VPATH+=$(AARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
-AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
-
-AARCH64_C_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_C_SRCS))
-AARCH64_S_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.S, %, $(AARCH64_TEST_S_SRCS))
-
-AARCH64_TESTS = $(AARCH64_C_TESTS)
-AARCH64_TESTS += $(AARCH64_S_TESTS)
-
-CRT_PATH=$(AARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(MINILIB_OBJS) -lgcc
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
--include config-cc.mak
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-vector_log_boot.o: $(CRT_PATH)/boot.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DLOGGING_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
-
-gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
-
-TESTS+=memory-sve gpc-test
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST) -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# vtimer test needs EL2
-QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
-
-# gpc tests need EL3 and RME
-QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
-QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
-run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
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
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-# This test explicitly checks the output of the pauth operation so we
-# must force the use of the QARMA5 algorithm for it.
-run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
-else
-pauth-3:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-pauth-3:
-	$(call skip-test, "RUN of pauth-3", "not built")
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
-QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-mte: CFLAGS+=-march=armv8.5-a+memtag
-mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-mte: mte
-
-ifeq ($(GDB_SUPPORTS_MTE_IN_BAREMETAL),y)
-run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-gdbstub-mte: mte
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--output run-gdbstub-mte.out \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "-chardev null$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py -- --mode=system, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-else # !GDB_SUPPORTS_MTE_IN_BAREMETAL
-run-gdbstub-mte:
-	$(call skip-test "RUN of gdbstub-mte", "GDB does not support MTE in baremetal!")
-endif
-else # !CROSS_CC_HAS_ARMV8_MTE
-mte:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-mte:
-	$(call skip-test, "RUN of mte", "not build")
-endif
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 9ec8df169d5..28498e82cba 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -21,6 +21,8 @@ gdb_feat_version = {
   'mte-baremetal': '16.0',
 }
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
new file mode 100644
index 00000000000..94e16ba3300
--- /dev/null
+++ b/tests/tcg/aarch64/system/meson.build
@@ -0,0 +1,109 @@
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
+          '-Wl,-T', link_script]
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests - add cflags only once per src
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
+  '../../multiarch/system/memory.c': {
+    'exe_name': 'memory-sve',
+    'cc_feat': 'sve',
+    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
+    'qemu_args': qemu_def_args,
+  },
+}
+
+tests += {
+  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'gpc-test.c': {
+    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
+               '-Wno-main', '-Wno-unused-but-set-variable'],
+    'qemu_args': ['-M', 'virt,secure=on,virtualization=on,gic-version=3',
+                  '-cpu', 'max,x-rme=on',
+                  '-semihosting-config', 'enable=on,arg=3',
+                  qemu_base_args],
+  },
+  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
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
+  'vtimer.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'cortex-a57', '-smp', '4',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
+}
+
+tests += {
+  'pauth-3.c': {
+    'cc_feat': 'v8.3',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
+  }
+}
+
+tests += {
+  'mte.S': {
+    'cc_feat': 'mte',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    'gdb_feat': 'mte-baremetal',
+  }
+}
+
+if 'qemu-system-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64/system',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-system-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


