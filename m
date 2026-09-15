Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A776CC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HM7-0004eD-Nw; Mon, 14 Sep 2026 20:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLo-0004Qd-Hb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLa-0004CK-JN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN06OW3071352
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OUSwIejwnq0
 Khr0M43oXLgaMUXN+1LozK9e91bcKNHc=; b=OABesiGUa0sKnXbHt833m3UQ3Mp
 tcKxAivIb8RwF3MDu2HysYdz8cVnU6h+BnrGEk7dbEwXw7LQDUKtSW+wTWwjvW2r
 V22BPWWCx6VNCbJiof+PXhh0PCrqMD5656nG9bC+0O3wgH+QvesPduWFMcfkSfW0
 +igFAXHuXXKVaD66utPlwPi9LCpGEWUSJXURqhbiU8te8vule1VkLBd3j5jsh382
 40/LyjmLpjnpTiSY77dHYMTPX+jXY3zPGibnRwh9oyPUYCceJGBc94dkl/KEyIk5
 QwpSpxtu+7Qw3Pt147qcXuY1RSWqgUF0speole1s3cQW+u8Zs6hWUppxfOw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeexb931-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso70994365ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433298; x=1790038098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OUSwIejwnq0Khr0M43oXLgaMUXN+1LozK9e91bcKNHc=;
 b=IfZAOpsOJMJd1P0KA8gbTTTRPgQkohB92eBpgCPwTshP8mIU/tKSCy3riUJ4QzU7Ul
 8H1jNVSYPfY8HFhIGrOtw72T+sX8TrordHxRsKlXIUNbRmx7X+t0mcl8LWQTks/Cz1JG
 ez0wxGeYHZUz/X598PXeTBE/CQ5OUm9SKFOcRIn6xnAv0eDGxHevlmkGaW9QvJ1rmGM4
 3cHS88SMjXdARAUb8bhJ9QyP7mwqQT7VO0+iKexqNpH34CGCum/1gb+6GoX6bxz1Pu4+
 xglSjiFrYGJYsVBGk5heeyHeO0i1vQJhijMLa2TF+Ge8lkwawN/z/yOqaiSORs0//3w5
 A91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433298; x=1790038098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OUSwIejwnq0Khr0M43oXLgaMUXN+1LozK9e91bcKNHc=;
 b=27K8EJlOgpPMyCFPbgZEor3SRHHlZsDU+64TtTBEik+/kNmQbrGo69yZfTOHzVTgXA
 wfBwLuQEyNZT/AmH7+ryuus9fL9sUDxGF3P3goJXJqK3kSTlDThofBL9TGusHDph0gED
 7ZbRbwW3PGAfDjFSuja20N+Z1jS9JyfXpsNumynoplS4RvDC3CogSL1fITdrRnakSAa2
 yCyOm3JTuDFuHJEvZCxsOsqIj51NUaNufYct3Z6nOnzACTBTHeLSSNtyBFHB9dg6Jvv7
 C9KP29RmXvtRn8OICGect5ELvk2Seru4coV4xbC1oS5EmWET3JT5yFDiYDU+Y6xL3Mc4
 ztOg==
X-Gm-Message-State: AFuF++k9C2Xpg1WpdeEvOnP/qI4Zk+HW/S/rBxkJrbVHSqqdpNOYP0aN
 F+vuW1mZifhZ4JbiVkjGwrzwQ0A5y18mJsL2v94aYhgnVfUwmynzIfiHR471tYqYri/hMEYNg/m
 eTvBny3T00ac4qmVKuW00RVOhlouV9QG1m7uzJGf4QLteNDVbAgJ+3rTxbn3QF++IoA==
X-Gm-Gg: AYBFou3hu/ANMpx7th6jEsxpg5VFsqgeQOFVZDYY705U7lubEdjK/J4Ahe9pdlM/JdU
 vrT/38FnK/mJExPSESQTb1HRmQtuKzFjji6Bi68F+6MAx2/y7pk+5TnZ5ZEfqMUgHty5jTR9mnr
 0DuNAgqqWdli1P8971bnBEQcmMY0R0U2FIui+VI76gnTfJe36wcSAV4TABUInzq/jfONnI+/Lcs
 VI3MoZCZShizHQQx08fWYCgeN8bFCuoEuST+2ijndXiVS84DBAsDhZPWPcpAo54RxbBPF4L3TS0
 XZ/FXG8FYMhKpxSjxWwgojn0ayKgjlzkDKwjHyhkfgVQpg01cRueHZ6X6Q2rNlFUve3jTfQ6PJH
 f0N7YJYgXPDNNEbKDxOwum5b7YQ8bHSjWYzUdxrEjMxELomA48e+7NzoOvZY=
X-Received: by 2002:a17:903:1a6f:b0:2d9:2fc9:5706 with SMTP id
 d9443c01a7336-2dd6c5b17bdmr99006815ad.2.1789433298435; 
 Mon, 14 Sep 2026 17:48:18 -0700 (PDT)
X-Received: by 2002:a17:903:1a6f:b0:2d9:2fc9:5706 with SMTP id
 d9443c01a7336-2dd6c5b17bdmr99006275ad.2.1789433298028; 
 Mon, 14 Sep 2026 17:48:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 6/6] roms/Makefile: add s390-ccw-rom
Date: Tue, 15 Sep 2026 00:48:02 +0000
Message-ID: <20260915004802.5749-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX4d2mRcZZrD7t
 pUl2vz4LDJEPTnQVkMPBeYYHhrvNfoLh5Q4NNe17sdBRKff2KSNT+1Xbzi1gwn5BdOO7DgNf85X
 PgmLmJv9yoCS0hldFqHD6hf2L+wgyg7v6j2m5O5O1XjkHwm8il3gF7PPuvDX32Xd1W7YrBPJeU+
 ddO6Epd8UEadxY9CJpkQ3XVI5ssyCpbF4tcfx21PIYbVmkVV6jORLHBWREHPMKAjqIVymdL1YXi
 2cDyFRC0xptZlg3RS27FqMuWmQUdxOnNIFYLF/JSdA5uxzBahJJF3Mstrj3Ioxyj7gociHEC+Vq
 9QFPvI8Fo3Isi8fyVpJUwN8zoFsxZHDoN3ENeB8Uqekn7ZKxyv+gAGJqR8SE9Kxe8Tnribw4o4D
 LwFuilewdtNgRIRXKj730P1kk4bdjerO9TDgWBtsvxoHQetimjdjliQfxKxX/YGK+kIpqu1gegq
 RipvE8moV8p2ZO2LADA==
X-Proofpoint-GUID: -ESOdqvfb9-pfqfF9mW7J9bKVoXnmwtX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX+6XNGDhCh6Dv
 6IBBiI8uKcSWvyQ/8rP4RWe108DAtyshYOdBOOwDO2Q+bhpg4VC3ppAm/qIJBb+1Layqx6lx9v0
 cL3c157MvsgZdDc8h0BibYS8RAf/res=
X-Proofpoint-ORIG-GUID: -ESOdqvfb9-pfqfF9mW7J9bKVoXnmwtX
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa895d3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=S8F17m9pLibwSvgH3oIA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


