Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F85C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H1e-0006EU-In; Mon, 14 Sep 2026 20:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H1O-00067w-Tv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H1M-00013u-RM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN05gx1813331
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OUSwIejwnq0
 Khr0M43oXLgaMUXN+1LozK9e91bcKNHc=; b=HpmWLmaW3XCpsk1hHEZHtcwt5MR
 XifZhSAxPGhSQWUC7ALDoD7Dy3cW7pRfA09cLKzQjG3ZmiouK1jEmFvM5cjU+eQy
 udKkXd5SKHzXKcwF5BuR7eMwBUrDRyy1kBeh0nUR2VWFmiU3XEjVfUf+h9xxktfQ
 oPSabQyOC+yItyt+J3BDF+UEbwHv7rDQ5yBr1IzOBQbijqBUdL0WXb2TmSQg4Cmr
 +8ozqVai/JXdmUpe0UpJAboJ6PK9rk4eItUCK6vYshgsRhLLit4f6RG/wiG20bWf
 FIrBdXa1hB6OWgQSfvwrppW6gtdc3PYKxan5EooVEYX7oIXu/iRAaTONWNA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtjpfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2dc7337e2a7so47616695ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432044; x=1790036844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OUSwIejwnq0Khr0M43oXLgaMUXN+1LozK9e91bcKNHc=;
 b=H0fmsU2U/zZese2CBRsRmMa/5/lc2fzdQVcv6Mlsffuw3xBC4OxnyxOq5FndkVchZb
 2E+EcZyF4YRQzZJADkqQ+mpnOy7P3p3AhQ8/GFQ5idxrveVSojoSChqf3fnAtZ3+eUua
 Q+q4Wa8R3pzAp2k7T6SsOcJj3HH3CQE5VVsK0A/lj076kSGiIX9cbcCTaPHoXnyPC7fM
 eGjte0T4iIIKZ7XTozL5B2NeDpERo1NxqgXJXxzIK06aFMF1owccuPsewYdd33qqklyT
 9n71YSj5ZshL9aSsK1ZhZOPvPM9jyIDzti81o66tEyUkT8zwKq6ZN9uvObUiqFpNEg43
 1Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432044; x=1790036844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OUSwIejwnq0Khr0M43oXLgaMUXN+1LozK9e91bcKNHc=;
 b=G4KOm8CTRR1hZy4CQS3Juun981sZJ4e4LUFb4qihBej7i8F1dverYBYT4oE/1VQ/cW
 8S3jrQQ8gZ/EdrPM9/GQCm9o2MgJ8evIUj6pQEJtlA/Kw33nW0aWM7QlInCLfl85KKcg
 tEvw7nFzQbiT28ZVN4jF+p993W7/2Y3bu1KYngSDLCGWM4bvCWSgLAgNdYqpPI67Zmvg
 9mR7FxnTsRz5OCjlatPECJEev/WO+XM06cBwmBDNuynNXZ+s9bdckSbK2F05MpNkGn3j
 ySgzHnkNEDeSLJCEEahkPdV9O9uhCjEhk3mbsiIONlHnqIToTPDp8orlRkHZoQ0fQeQq
 ilSA==
X-Gm-Message-State: AFuF++lcTspDfUwk/VTWuIMOGMJFRcqNhDQGDLPNdMLBdSLDW2vKGhVJ
 G3QC2aQZB1H4LVWJCz/IEhptGH936QQPxTXWMMNOckMn2VUvUTHdJ1CUs6S++kwaDr9fV/sZOzD
 sACOPJ4Hf6xwyrPsxMEm0gXs1KZhmN+JexCP67GvtQEQ2lKJmA/7m5/pVDkByjxlLMA==
X-Gm-Gg: AYBFou3Ck6zSLx3VYKdB8WgxMFx5SeuyaAmmZUcHUcAqRyhjdL456AnYIOZkF7fCRdO
 0HB46OHYvOQqEEqrHfk7CQrx6tbeGEpf/0Cr61sJWyGiqGv2bQjuF1lrsmRcFanRJ5wt+CZra58
 INqhXqcgzcIVIZDGjX5erfmCNYQrC0fzFYRydjwsAP+sClSMMH8w+xtTCNbd9U6usDVgJ9Z8UvL
 T/xikdN4jJG19ZG8BBI4JVKZ7FKUZ3gsGWMubozI6NjzBEfYTysylOLe5vezRZI2zHIB/TzKFiW
 dcQFLBtrHGu1j8kf8JaPc3dEDhQ2X6r3vxPrBMmzkqJnJMukyw95sUpIEosB49z/vcxzTvsYWcR
 XZdzGQgxUXoi4mgRiYH3or13DrUY/ctQb+urS87PW3Zl/HXFfzjo4Z5p4drs=
X-Received: by 2002:a17:90b:3bc5:b0:39d:f259:3363 with SMTP id
 98e67ed59e1d1-39df25936c1mr8062033a91.12.1789432044043; 
 Mon, 14 Sep 2026 17:27:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc5:b0:39d:f259:3363 with SMTP id
 98e67ed59e1d1-39df25936c1mr8061969a91.12.1789432043541; 
 Mon, 14 Sep 2026 17:27:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/6] roms/Makefile: add s390-ccw-rom
Date: Tue, 15 Sep 2026 00:27:06 +0000
Message-ID: <20260915002706.36318-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa890ed cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=S8F17m9pLibwSvgH3oIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX8HfWDbcIRYz1
 sOhFfDIr1TY9TcQu329wQnS7sCWYxjNEO4fYVTFRnKFfShg9Y9aiwcCrO2XlFhHY45vwy1p90/i
 696JZqrgUFkHRfUBHZ6kUo6SOp5I5zAN0PhJKdjkn6VNQtPsVAnBvgoE8nXwhkx+vNxTrF0LbJL
 iaApHcOSpzLfiafi3Trfajm+zExdaDRP8weE33dMrTE6lZHfymPJhKPRWG5VBK/sgSb8Eec+Vgk
 UG3rkJaRTUM0ivE+cs0mGQDbuP/LNdx8Y45ySKJW0UkA17EITH84y+fk7X0YeIc1wcx29EeXVZ5
 385VYXC3Cldx7ogzsNTWD/cM4rjUBGg7qilgYg5qHsD5S4FQgV8GxnhRVvgG2LQDPKcWXpoL+g+
 Ue4/TGK/7+3x+QLf9HxtcrjmAmO6Ia92U1hKaPkjZMHH9eB07pcwCsAzFQCtkwbvki5gZdfeMcO
 v44b5sBkaPJGOE9t45Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX62JsZekzlIGG
 lfvFZrvNpfGuhFMDbo6aF3oruEYtfeTbL/pGJmoCKEtHK3HE2kBr9t/PkiO4AYoGWaZ4PQAutBy
 Tea1Gm06zXu2Wbotp8R2J69AoVrffgs=
X-Proofpoint-ORIG-GUID: kPiYl_vl6odbB4jsSVo1ytDCUhE-fmp6
X-Proofpoint-GUID: kPiYl_vl6odbB4jsSVo1ytDCUhE-fmp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150004
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

Remove dependency on config.mak and simplify Makefile.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 roms/Makefile          |  6 ++++
 roms/s390-ccw/Makefile | 67 ++++++++++++++++--------------------------
 2 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 57a53944b9b..73d0277defd 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -76,6 +76,7 @@ default help:
 	@echo "  qboot              -- update qboot"
 	@echo "  hppa-firmware      -- update 32- and 64-bit hppa firmware"
 	@echo "  optionrom-bin      -- update optionrom binaries"
+	@echo "  s390-ccw-rom       -- update s390-ccw.img"
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
 
@@ -225,6 +226,10 @@ optionrom-bin:
         optionrom/pvh.bin \
 	../pc-bios/
 
+s390-ccw-rom:
+	$(MAKE) -C s390-ccw
+	cp s390-ccw/s390-ccw.img ../pc-bios/
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C ipxe/src veryclean
@@ -236,6 +241,7 @@ clean:
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
 	$(MAKE) -C optionrom distclean
+	$(MAKE) -C s390-ccw distclean
 	rm -rf Build
 	$(MAKE) -C opensbi clean
 	$(MAKE) -C qboot clean
diff --git a/roms/s390-ccw/Makefile b/roms/s390-ccw/Makefile
index 2109d167813..74078ce07eb 100644
--- a/roms/s390-ccw/Makefile
+++ b/roms/s390-ccw/Makefile
@@ -1,43 +1,32 @@
-all: build-all
-# Dummy command so that make thinks it has done something
-	@true
+all: s390-ccw.img
 
-include config-host.mak
-CFLAGS = -O2 -g -I $(SRC_PATH)/../../include/hw/s390x/ipl
+CROSS := $(or $(CROSS),s390x-linux-gnu-)
+AR := $(CROSS)ar
+CC := $(CROSS)gcc
+STRIP := $(CROSS)strip
+
+CFLAGS = -O2 -g -I ../../include/hw/s390x/ipl
 LDFLAGS ?=
 MAKEFLAGS += -rR
 
 GIT_SUBMODULES = roms/SLOF
 
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
-
-quiet-@ = $(if $(V),,@$(if $1,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
-quiet-command = $(call quiet-@,$2 $@)$1
-
-VPATH_SUFFIXES = %.c %.h %.S %.m %.mak %.sh %.rc Kconfig% %.json.in
-set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath $(PATTERN) $1)))
-$(call set-vpath, $(SRC_PATH))
-
 # Flags for dependency generation
 QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 %.o: %.c
-	$(call quiet-command,$(CC) $(EXTRA_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
-	       -c -o $@ $<,Compiling)
+	$(CC) $(EXTRA_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) -c -o $@ $<
 
 %.o: %.S
-	$(call quiet-command,$(CCAS) $(EXTRA_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
-	       -c -o $@ $<,Assembling)
+	$(CC) $(EXTRA_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) -c -o $@ $<
 
-.PHONY : all clean build-all distclean
+.PHONY : all clean distclean
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
 	  virtio-ccw.o clp.o pci.o virtio-pci.o secure-ipl.o
 
-SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
+SLOF_DIR := ../../roms/SLOF
 
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
@@ -52,8 +41,8 @@ EXTRA_LDFLAGS += -static-pie -nostdlib -z noexecstack -z text
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "EXTRA_CFLAGS += $1" >&3; else \
-    echo "$(TARGET_PREFIX)$1 not detected" $(if $2,&& echo "EXTRA_CFLAGS += $2" >&3); fi
+    echo "$1 detected" && echo "EXTRA_CFLAGS += $1" >&3; else \
+    echo "$1 not detected" $(if $2,&& echo "EXTRA_CFLAGS += $2" >&3); fi
 
 config-cc.mak: Makefile
 	$(quiet-@)($(call cc-option,-Wno-stringop-overflow); \
@@ -70,30 +59,30 @@ LIBC_CFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
 
 CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
 %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+	$(CC) $(LIBC_CFLAGS) -c -o $@ $<
 
 STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
 	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
 	      memset.o memcpy.o memmove.o memcmp.o
 %.o : $(SLOF_DIR)/lib/libc/string/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+	$(CC) $(LIBC_CFLAGS) -c -o $@ $<
 
 STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
 %.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+	$(CC) $(LIBC_CFLAGS) -c -o $@ $<
 
 STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
 	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
 %.o : $(SLOF_DIR)/lib/libc/stdio/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+	$(CC) $(LIBC_CFLAGS) -c -o $@ $<
 
 sbrk.o: $(SLOF_DIR)/slof/sbrk.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+	$(CC) $(LIBC_CFLAGS) -c -o $@ $<
 
 LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
 
 libc.a: $(LIBCOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,Creating static library)
+	$(AR) -rc $@ $^
 
 # libnet files:
 
@@ -103,20 +92,16 @@ LIBNETCFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
 	       -DDHCPARCH=0x1F -MMD -MP -MT $@ -MF $(@:%.o=%.d)
 
 %.o : $(SLOF_DIR)/lib/libnet/%.c
-	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,Compiling)
+	$(CC) $(LIBNETCFLAGS) -c -o $@ $<
 
 libnet.a: $(LIBNETOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,Creating static library)
-
-# Main targets:
-
-build-all: s390-ccw.img
+	$(AR) -rc $@ $^
 
 s390-ccw.elf: $(OBJECTS) libnet.a libc.a
-	$(call quiet-command,$(CC) $(EXTRA_LDFLAGS) $(LDFLAGS) -o $@ $^,Linking)
+	$(CC) $(EXTRA_LDFLAGS) $(LDFLAGS) -o $@ $^
 
 s390-ccw.img: s390-ccw.elf
-	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,Stripping $< into)
+	$(STRIP) --strip-unneeded $< -o $@
 
 $(OBJECTS): Makefile
 
@@ -126,14 +111,14 @@ ALL_OBJS = $(sort $(OBJECTS) $(LIBCOBJS) $(LIBNETOBJS))
 clean:
 	rm -f *.o *.d *.img *.elf *~ *.a
 
-distclean:
+distclean: clean
 	rm -f config-cc.mak
 
 .PHONY: git-submodule-update
-$(SRC_PATH)/../../.git-submodule-status: git-submodule-update config-host.mak
+$(SRC_PATH)/../../.git-submodule-status: git-submodule-update
 Makefile: $(SRC_PATH)/../../.git-submodule-status
 
 git-submodule-update:
 ifneq ($(GIT_SUBMODULES_ACTION),ignore)
-	$(quiet-@)GIT=git "$(SRC_PATH)/../../scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)
+	$(quiet-@)GIT=git "../../scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)
 endif
-- 
2.43.0


