Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB969C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HLy-0004Rd-G1; Mon, 14 Sep 2026 20:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLk-0004Oi-4B
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLZ-0004BE-1Q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN0Y541986116
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rWcRg0KX+wt
 ewjZxJdgqp2eBhLZztknRh49JUnI1SrY=; b=pmNdn00cOxV1i7lqn6XFGMrmJ86
 HneyNpU8QQi1INiExfQ1FyagUQM7d0n6n/r49r0ZDtR8NQRxLoMB5tzRu5Tw+nit
 4hQZo96dAExQ2sFnS41nGnJZFFvFwT4e1utMuUsn6rpiFM451juegZAhm1/WT/iK
 e72hAMK8N7yhudItTcXCh36KSYJmkk3DRJa69KDMy2f5fXfNFIMA3PYxVuoyTeqd
 RJXqXS8pDaiUu43e7apP5Xw2tK0Sa0vCcBcgbWoHMZyAbsd5F8ZqyrFCcVg4rPG+
 Phk+6uCT2Lh/D0jl04Xgt0sI/L5yQQKYiOWc3MwEX2H/v5ae7HijXQKM81w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet1b93-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so3711735ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433295; x=1790038095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWcRg0KX+wtewjZxJdgqp2eBhLZztknRh49JUnI1SrY=;
 b=CjzRXRS0ftfpCGsB3+5tIp68uagC08g7QO3TYK3+PCc81sUqTwQoCxsKApg3rUrIqN
 Xc6Jq4HaddoMVlkTqBMReoz6UzKb79LNpdrIo4q1je9i4TG7cBFXe4YYRN2lMtS7Rv6H
 vq5nHZOzncn0J5+ysy8FKnjwKVj8HY67H9tVYjf/3moMemXk1pf7Azqkiqy4rLXh4KHY
 VDESqvz5aoAjLVZy9pkNtF7vmHJh2m3SMJMAbYCXiK75XZ/Fv/BXUT4zxD/d8BXwsbZ+
 zohusHLPRd8gdBq2H+V0QC0/l2DO3XM4ybZdRx/VMiUY8r8eUaPrudbOKYXtP1jlu7Lr
 VXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433295; x=1790038095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWcRg0KX+wtewjZxJdgqp2eBhLZztknRh49JUnI1SrY=;
 b=TnTEG/aEMzvJOT6hYyzn9JDvbjirLIswxIIW+UKXc087C1revK5gdRCoLENq9NBZY+
 9OSIWBejgjfM1V3rxIstufCX1yO4AtPj3eH7ANA80RBBNBVTLwRuQau0CZOD+kciyji1
 tHTzE0Y55XzsegIcdGnc31OT8d28bcBKROGmZWFzcOFxE2yYvzHDm+qNsefdUs4EfaAl
 GgHHefEruLETVKKJOHnwQynIVBTQq8JuHCUS/l2Pv1hyewnVO7YVtAfCsi2zFat31jnH
 3/mYFehKm+s2I51zBJZUzDAYkJ1tZmWX++yKcNVecJBlWXgiQyY08EyuRZqk1yV/jaQ7
 O3VQ==
X-Gm-Message-State: AFuF++mrUpg8Pr3iMpUd0SjvWBq5LsiHPyjA+NAGI8gEp/rXTk9CI+lK
 VHfeubuYZ5Vf6cbMAZYdyg2gaLIIypUZaB4TYacbrt1QIv9GD/Ic4CsRhnzNp7ygQc4IYxdlS+A
 rLamH1MXW6LgK2Pr5ewKPElTXvtyL5umE0Clk+OYBRnS9USY++wYmpgQuI3jOumvbVg==
X-Gm-Gg: AYBFou1eVeGg6uTzVWsq0aavIGJY8owr28rzruwevj0T1ErJEkFUvEvxWYvoq1a1KTT
 rvIxag29O35DIixfYgdvq1lV+wbRXwbzHT3SpgXOGfVy/pqiQSzwIMEmhusW3YDpLcixE06V+Rm
 wXGCySrQnM3NoWJXh+4IrfHKP2F4i9QMsX3mZFt1Vh1ocNEoc3dKKeNVcnRj9Tq+YVRUDTZhIvj
 vSSf4k2eb7Z5qhFyzaZAjFjbQfbKlH2B+L8tJ4TZl1YHb2u+1gI+t8lbvYy6ZwYWAvDR9Nl0dR2
 g9FIVSRS7+WNisbqmMnHOBuEMd0ZKvm/4u2d4+9JBr2cbMmwuai3yD0yWwA3R4BPyH4Sk3Tup0r
 hkWcQUkjAxEHh29un+Dl8q87mm2JYazK2Z0kDL6VRGQDINUrlLPjGJrZEPSA=
X-Received: by 2002:a17:903:120a:b0:2d8:d4d2:d139 with SMTP id
 d9443c01a7336-2dd7655bb26mr22257415ad.21.1789433295336; 
 Mon, 14 Sep 2026 17:48:15 -0700 (PDT)
X-Received: by 2002:a17:903:120a:b0:2d8:d4d2:d139 with SMTP id
 d9443c01a7336-2dd7655bb26mr22256885ad.21.1789433294904; 
 Mon, 14 Sep 2026 17:48:14 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:14 -0700 (PDT)
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
Subject: [PATCH v2 4/6] roms/Makefile: add optionrom-bin
Date: Tue, 15 Sep 2026 00:48:00 +0000
Message-ID: <20260915004802.5749-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX+n8W8VAwN9HB
 g/DqJ5KOu2OTlpGaphQry5rncdqkH8w2iplW/YrhTJntzlR2xcxCgZ+/E/syWUBA6BD2UiARXIs
 iUz8//SV+4fMwZFDWSLFfo2JSnoQsbA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX+KgyEfWjAL0G
 hhvVd+gjarGhUc4jqBvgwGbqapP/AWSJNBjiinf+gSTk88QT2iRoxVxjfzv3dBFxcXQIL9S0sd2
 16gRCNEs4NoOuPzJC8lJA5OTzIbrizUbr/HmMPwIH+xfOSNaPB1roQTpOYPds4tGtdnKPjShZip
 HiLHg0MPrnxd41/T8Y6+HT+WoWlT2H5e1sPaJVn7kVel0e+5Hz2FSN39YI7E/tvZuZA8ekJSifg
 yV3Vq19BWBxBZE1JjvE6MfIhs4fFVhjFaPc2g1ywMDwAmd3yBp3a4f+MtwTFjQAh4+U2ykGGbGO
 1b4YnOVdp2Kudtw3xtCGi7oxMwId8Z+3zs01lp5JWL42xLmE19ILUqEIqt+8JvcT7SI677QUf8R
 buBurGVp96hCtHXlfusYpailkNnWUYFZLed1jNHL/x24oerm0jKZXxiZEizfLKuBVzlCJr7oy9m
 VIL1oNOO95ymQyuuoog==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa895d0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4rAdK4PdC6YBIYm_0AkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: SiKxKVK4o5tNn0MuQEyi-_pDhfCT52OD
X-Proofpoint-ORIG-GUID: SiKxKVK4o5tNn0MuQEyi-_pDhfCT52OD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
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
 roms/Makefile           | 10 ++++++++++
 roms/optionrom/Makefile | 39 +++++++++++++--------------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 84f22943d35..57a53944b9b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -75,6 +75,7 @@ default help:
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
 	@echo "  qboot              -- update qboot"
 	@echo "  hppa-firmware      -- update 32- and 64-bit hppa firmware"
+	@echo "  optionrom-bin      -- update optionrom binaries"
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
 
@@ -216,6 +217,14 @@ hppa-firmware:
 	cp seabios-hppa/out/hppa-firmware.img      ../pc-bios/
 	cp seabios-hppa/out-64/hppa-firmware64.img ../pc-bios/
 
+optionrom-bin:
+	$(MAKE) -C optionrom
+	cp optionrom/kvmvapic.bin \
+        optionrom/linuxboot_dma.bin \
+        optionrom/multiboot_dma.bin \
+        optionrom/pvh.bin \
+	../pc-bios/
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C ipxe/src veryclean
@@ -226,6 +235,7 @@ clean:
 	rm -rf u-boot/build-e500
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
+	$(MAKE) -C optionrom distclean
 	rm -rf Build
 	$(MAKE) -C opensbi clean
 	$(MAKE) -C qboot clean
diff --git a/roms/optionrom/Makefile b/roms/optionrom/Makefile
index f1c1b9efc21..ba4a26ad390 100644
--- a/roms/optionrom/Makefile
+++ b/roms/optionrom/Makefile
@@ -1,30 +1,20 @@
-include config.mak
-SRC_DIR := $(TOPSRC_DIR)/pc-bios/optionrom
-VPATH = $(SRC_DIR)
-
 all: multiboot_dma.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
-# Dummy command so that make thinks it has done something
-	@true
 
-CFLAGS = -O2 -g
+CROSS := $(or $(CROSS),i686-linux-gnu-)
+CC := $(CROSS)gcc
+OBJCOPY := $(CROSS)objcopy
 
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
-
-quiet-@ = $(if $(V),,@$(if $1,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
-quiet-command = $(call quiet-@,$2 $@)$1
+CFLAGS = -O2 -g -I ../../include
 
 # Flags for dependency generation
 override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
-
 override CFLAGS += -march=i486 -Wall $(EXTRA_CFLAGS) -m16
 override CFLAGS += -ffreestanding -I$(TOPSRC_DIR)/include
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "override CFLAGS += $1" >&3; else \
-    echo "$(TARGET_PREFIX)$1 not detected" $(if $2,&& echo "override CFLAGS += $2" >&3); fi
+    echo "$1 detected" && echo "override CFLAGS += $1" >&3; else \
+    echo "$1 not detected" $(if $2,&& echo "override CFLAGS += $2" >&3); fi
 
 # If -fcf-protection is enabled in flags or compiler defaults that will
 # conflict with -march=i486
@@ -36,34 +26,31 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds,-m,elf_i386
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,flat.lds,-m,elf_i386
 
 pvh.img: pvh.o pvh_main.o
 
 %.o: %.S
-	$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<,Assembling)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 
 %.o: %.c
-	$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@,Compiling)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
 
 %.img: %.o
-	$(call quiet-command,$(CC) $(CFLAGS) $(LDFLAGS) -s -o $@ $^,Linking)
+	$(CC) $(CFLAGS) $(LDFLAGS) -s -o $@ $^
 
 %.raw: %.img
-	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,Extracting raw object)
+	$(OBJCOPY) -O binary -j .text $< $@
 
 %.bin: %.raw
-	$(call quiet-command,$(PYTHON) $(TOPSRC_DIR)/scripts/signrom.py $< $@,Computing checksum into)
+	$(PYTHON) ../../scripts/signrom.py $< $@
 
 include $(wildcard *.d)
 
 clean:
 	rm -f *.o *.d *.raw *.img *.bin *~
 
-distclean:
+distclean: clean
 	rm -f config-cc.mak
 
-# suppress auto-removal of intermediate files
-.SECONDARY:
-
 .PHONY: all clean distclean
-- 
2.43.0


