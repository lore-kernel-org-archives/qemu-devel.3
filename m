Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCEC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H1E-000648-Rz; Mon, 14 Sep 2026 20:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H17-000619-8w
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H15-0000yn-IG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN04TZ2134017
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/X0cmuzPBsN
 yNewKfNMraJHy0a4o+TtZ/F93K/SAZ5Y=; b=b72eAycBC+smUwX8GqWoI3nH75N
 /LE6/T++uXNNmIaaCL2Jolx7/S5ZhUgH8hfd3+PQcUDYIFYUaCXJ1TpC2m3TM8iH
 FhSmtLZvY5AUsHAF1OXMH0pPp1aRsmHhcwCddIbGGdZFXW5tXfmwl0hAiG7OEMLV
 Yne2xcQevAVbHMkj4ytGtwC5cCdPJozI1mFXwac9+70QFP+2H2IQ8jzSeVpyHk7I
 il6a04+zEYaItFnrZsOLFWVuud9WZfz6R/nam396jzYmnS6blvRQ493iDMTUs2rT
 G05oyOMejh0TzoIMs4Ot33ruGm6Oiqd9EBs+mCyO66STo8RRcc5qJQY7otQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9se67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so9155019a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432038; x=1790036838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/X0cmuzPBsNyNewKfNMraJHy0a4o+TtZ/F93K/SAZ5Y=;
 b=BQG/4Vx+ECSq9AEz8NeqZXaLYDa78BMIFwKkg0VYbYT/vu1Set0xg57fAyAGB0ojZD
 zTMIDjDYzJOdaM1/6+xAvT0CiIjJiHCs+3diB+dSsKVrQaqGLHpFPqxr4PPj2E909RLK
 jlrf0s90jYqb8AWTv7/46Y2pTwvWnOd38jMP3W/KHP6/2ySiICTyX21tMfMi+owvKQOF
 hT5AQffuRcNmsUuxdvuFqUbk+6TeVtjq5wicVLsX+yWwd1zyMosyYPEl+g3xJnsgHD/X
 2gMXvTFPXtLbO1HLid3KUOsY/1mBQEaT2HJVE5cpglsPRokUMCukUNPPiu4R2M5oVv68
 pAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432038; x=1790036838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/X0cmuzPBsNyNewKfNMraJHy0a4o+TtZ/F93K/SAZ5Y=;
 b=coZ1/HSImVJVAfodH19h0CnHC4x4VHc+K6cJpM6F/DbZkDyxex4obGIEF+K+x9m4Kp
 9Eu0abf5lUBzUYxspWFMcx2lQ5ogvtg37KXFWW1Y5iv/ybaEFRUuDuW9TwdimuJKM2JV
 nLge35W6NKfwiLJK9uIetWdNQvK8LEWUhCgi5csIi1BdZolsnUtyHFGUzroVPxdTmohH
 JiYAyKkf6APxSZltg/rY4pQHsf7aAtQPAfWOXw7t199s98FfIVMiqne1Glck3uSqdILI
 07qA9FaqsvdujyLtwEBhkp6th7/33v3yyBuTWaBHy9OU+5WGr2jZOTMNpkdtAkUdGpCH
 eMRQ==
X-Gm-Message-State: AFuF++kjpA8Syl6j0TXhE+oHXc0QHlQKorOOaY7Xg+J9pVEJCsFRteG9
 L3kpnD7qnTP0ujrtPbh493xk3mMeLka9Vxzhu+zhVx+TxBRtgB/3qv4+MNWOgr9hrkZK2q9B4BW
 cW6vlb/ryqBxAM0AtU3PokbAYrSpZ3tzZ6bpm9Q4EzJnTbbGlmmELQPp/L4TJCrpSVQ==
X-Gm-Gg: AYBFou2wNQuobjXIlj4pEbotclyTkbijiibzYKahOZqidkVP3bUHhzxar3607Nbytgr
 SR4FqC2lR+N+3+Ochv+m4Q4Udphhihnoh1Tn+iGHnQiAZUsQiKffKxdWZRoci/ahjPd233TLAcO
 zjuCW2XnCHC3iwSt2THLdSiPS94ztasrdXT3redD3zEQHoFvTvDxycL/S+d71qLJukUJOVWBWkJ
 WDDuwLemOqbOP9+i4ZTBaEJCGWokfWkZ5bBnYg6Q0Vj4brAVdCoXadORiulFrYSSYaCNFpDvoN1
 1rLN1wsfATnONciWgnli1YDEDDGe44c5SrvZYdg2RGvw8VecQEdTy6w9Uu/mkNC/YwKFZZ26NA7
 G+lGFqCVZpBvoxsZ+NdpOesJDgfGT3Ewzzu09B+j+XIujYsceVsj6Wz82nd8=
X-Received: by 2002:a17:90a:d888:b0:39d:f5b1:e365 with SMTP id
 98e67ed59e1d1-39df5b1e47amr6917035a91.25.1789432037618; 
 Mon, 14 Sep 2026 17:27:17 -0700 (PDT)
X-Received: by 2002:a17:90a:d888:b0:39d:f5b1:e365 with SMTP id
 98e67ed59e1d1-39df5b1e47amr6916981a91.25.1789432037233; 
 Mon, 14 Sep 2026 17:27:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:16 -0700 (PDT)
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
Subject: [PATCH 2/6] roms/Makefile: add vofrom
Date: Tue, 15 Sep 2026 00:27:02 +0000
Message-ID: <20260915002706.36318-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa890e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0g6KD0rpRfIU_7JGXwsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX0DFOy+gAU2D7
 PlV5u/dpG7BumpB/14kbDvN3UAQ10KZDH0ooWcfK2TNR6F++QOv57uxnprQrI496f2+cNyPTIuY
 nXOkYynk2nT1fSB5WrA03lfII+Y8HtmDlaGP7u8pO3XYYXqV1fdiYIts1436KSDladXD5gPKxKF
 urCQYSlVC/AjqAgZV8GO60/C0MCwf/PrT+rmVtceUS7besLSTnN8my4eLJG+6PBzahJhDnLaNu9
 DD9WiYOe41/ohhODPIsbWnXwxa2OZ5RCzSAFWLhIR1Voqy3CPgsATSiiJ3ZLnTg/Yxg0mvS9J1n
 9yXmbUqJh2O+U8GiHUN8zu1zPczAA6SOLK+v+doSYaW6wt4p4HWP+aQ3mCMkHxNfjTknPFmbkVP
 KJOA5sBxpsTRGARQNBvSELQbiQuLozeSjbcrqFIsZF06H7LS+ozuFZskAK6ScA0VPBCrR3wuyG7
 r5y/ST7xuN4OC9tQ5Nw==
X-Proofpoint-GUID: o9N8Z-iFc0haTDlrP6UBxHZKgajoj3YD
X-Proofpoint-ORIG-GUID: o9N8Z-iFc0haTDlrP6UBxHZKgajoj3YD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfXwbjVAyp4K+zH
 5bIW4rsIyql4MmX0d3ke0xoUrVXYj6JYUyvDMFWazJkqFaX5N3RGh/6eOAO/xYWU6doYm8AXyNJ
 nvrAYdJHJneayk9pNLTqTH0G17ycCO0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
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
 roms/Makefile     |  6 ++++++
 roms/vof/Makefile | 21 ++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index f15189a5409..84f22943d35 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -63,6 +63,7 @@ default help:
 	@echo "  pxerom             -- update nic roms (bios only)"
 	@echo "  efirom             -- update nic roms (bios+efi)"
 	@echo "  slof               -- update slof.bin"
+	@echo "  vofrom             -- update vof.bin"
 	@echo "  skiboot            -- update skiboot.lid"
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
@@ -136,6 +137,10 @@ slof:
 	$(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
 	cp SLOF/boot_rom.bin ../pc-bios/slof.bin
 
+vofrom:
+	$(MAKE) -C vof
+	cp vof/vof.bin ../pc-bios/vof.bin
+
 u-boot.e500:
 	$(MAKE) -C u-boot O=build-e500 qemu-ppce500_config
 	$(MAKE) -C u-boot CROSS_COMPILE=$(powerpc_cross_prefix) \
@@ -217,6 +222,7 @@ clean:
 	$(MAKE) -C edk2/BaseTools clean
 	rm -rf edk2/Conf/{.cache,BuildEnv.sh,build_rule.txt,target.txt,tools_def.txt}
 	$(MAKE) -C SLOF clean
+	$(MAKE) -C vof clean
 	rm -rf u-boot/build-e500
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
diff --git a/roms/vof/Makefile b/roms/vof/Makefile
index d1eb6ced7ec..d5dbb374356 100644
--- a/roms/vof/Makefile
+++ b/roms/vof/Makefile
@@ -1,27 +1,22 @@
-include config.mak
-VPATH=$(SRC_DIR)
 all: vof.bin
 
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
-
-quiet-@ = $(if $(V),,@$(if $1,,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
-quiet-command = $(call quiet-@,$2 $@)$1
-
+CROSS := $(or $(CROSS),powerpc-linux-gnu-)
+CC := $(CROSS)gcc
+LD := $(CROSS)ld
+OBJCOPY := $(CROSS)objcopy
 EXTRA_CFLAGS += -mcpu=power4
 
 %.o: %.S
-	$(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -o $@ $<,Assembling)
+	$(CC) $(EXTRA_CFLAGS) -c -o $@ $<
 
 %.o: %.c
-	$(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<,Compiling)
+	$(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<
 
 vof.elf: entry.o main.o ci.o bootmem.o libc.o
-	$(call quiet-command, $(LD) -nostdlib -e_start -T$(SRC_DIR)/vof.lds -EB -o $@ $^,Linking)
+	$(LD) -nostdlib -e_start -Tvof.lds -EB -o $@ $^
 
 %.bin: %.elf
-	$(call quiet-command, $(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@,Extracting raw object)
+	$(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@
 
 clean:
 	rm -f *.o vof.bin vof.elf *~
-- 
2.43.0


