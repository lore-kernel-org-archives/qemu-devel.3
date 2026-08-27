Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68437C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVz-0004nD-QQ; Thu, 27 Aug 2026 18:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVx-0004iP-Jj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVt-0000Gj-Uf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLfoo124906
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bl0MRKYJtU/v7O45KFA9Bk+B/GpFx86QHkye1lBu5d0=; b=nYQpJnDXbUsrhzif
 Hb948lN/Z0mkTrokdFYGoBbd17Z+PYdTgFNfvnn5eHDGVUl2HtBKiJ/vwvzxbVzs
 y6oWJkTO4Viq1ZVQ37I+sH1rMXibks8M2XxhGIo+AG1XZRSpLn/K9bs4Xjgu9xI7
 H2Pjmg1OrRWiTga8uvV8yeIZ3i3CqBjRO5aA6R3eTbb/yKteNwtsHXEh2LkGB23S
 j/R2EPFW4aCq7HoaGmQwAbXMW4UpDKBjJCRMq7QiMCIsU2DtwF1O+nXKlWPtqcc6
 9aBZD96vYqqDPkctWEp5CxnftIw2H33HJ0BK2xhX31ggOBv0/YU/kOBdRy061YbA
 0jHuCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7twn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so3649715ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869430; x=1788474230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bl0MRKYJtU/v7O45KFA9Bk+B/GpFx86QHkye1lBu5d0=;
 b=RZ9viBG+Pt2aUrEstyVWpbzKoxIa+PuI3VAAKEgLi0ni2ao2p6JhsY/JXCDLf+hzzq
 NKDDMjbgRbNKUCfPn0MG2hNDMvCm1GOtw2jy77JHBwj/9i+aeye+orphbth3avFAUATx
 EHMaZA7hZ/WWeZvLu8X70SAWAW3dZ8MnLVaDb2GU55M5T2kNBTVdzth323gCLy8j6gl7
 gYfDNfuok9d7qVH6K0OCgU4NE8aoAW8tVMTXMYVkz0S9hOSPiZJxngEfvXaVknFbOgI4
 u2qjtvF5dn8EA6thmujpIPl7F5cfVyXQt9++mYyuSFMfnVW0sRVl2ye7Zwcpu0p02GRx
 o8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869430; x=1788474230;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bl0MRKYJtU/v7O45KFA9Bk+B/GpFx86QHkye1lBu5d0=;
 b=RRKIG3LT0QZXMbQeITXgJ1MJ3aY70LVhZ59SJ5ft35hPa2rgtHUmBDLa7YVsT0Ez0a
 FZzor1xqEtBwz9Ps+oYNk6MSiNj1khBUcN4XOw9JJsSkwGU+SJU5jawR9qQg2kx2Tjiz
 gst4bJWF7P4SbUjYRqa867yMPW6fv5mXOzPeuauGzVat89qynyJHCQCNZVWXhGr17okW
 JcsPumkuyz71EKZHMeU7s2N1AOMeSyQsvqWZxooMqkUOBgd4PQmkxnNy0c3rwEtTl4mI
 veOV04MDisxWJSVLrPFRaWqChgUSRrOVBpFXCFLF7edO6S/B6D6LM5vAmW+NasiH/QLP
 CfVQ==
X-Gm-Message-State: AFuF++m0pxR4/LOEjsps/kiqPJLXOsW9wQo8jolJ1S+ktfyswOA0W+Bt
 AzVtRAzHSnekENIoCjkXLuS+BOJe6pIycniF22mi88zmS2qN3ZUWyZzXbfy0sIjAU2IUsDRiaUE
 lhsGKqeYg4f6agD/zme+E0rA/362dJzIqI42mKOO5doFPnBxKiKxH/n9kyYLMrNjoNw==
X-Gm-Gg: AR+sD10M049hbYCdJo4ZtIHZ0IDHe8SuN17Pg6k/E8bqUnNk0HF6YTauQwcB9E7idWx
 /oeW4Bbjm5bnjS/7w4QgNCFV0/H7hre91n2THdT/QMKnMEmpTVr8IwS41voD6OnGC8K+DtOAdaQ
 8+zAUnJRLxa77q7aZ9ghFwUqcgAF9lwbLecNMd2lmw8snYtMg7OWGfU5ILgx1ThqQMjG2dIesav
 Bp1QFLEaOUgmeDLNpdaO43FKvmcEjBesWYy1xXZtxkqtSc9R6X9pD4xihN/lGuXPJavcGW648EA
 uUSZGP0zojlIwdjpyDgZmbEzk/dp48/3V/IpY5/PtyMEr4bJrzJUSXeoMq9qut+Eo6gfefu4eIr
 fD1LTcsbvkGXJ/aKgBWKlSY29iV/bve4BpA08w8vKMnHDYjcQB8EsXZNj5BU=
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2d74dca2281mr35757565ad.2.1787869429401; 
 Thu, 27 Aug 2026 15:23:49 -0700 (PDT)
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2d74dca2281mr35756405ad.2.1787869428706; 
 Thu, 27 Aug 2026 15:23:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:47 -0700 (PDT)
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
Subject: [PATCH v8 098/105] tests/tcg: remove remaining Makefiles
Date: Thu, 27 Aug 2026 22:14:59 +0000
Message-ID: <20260827221506.91574-99-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX79u6srMBwm+E
 SERw4XkGZfvqOyjW7S9ljqeVF7ftmpVgJreWEJmrEcGVtAeG8hfsY4tbM3YlCjFi0h9EyHio2ro
 SxOX5It97yRNRYkLDjEwt4z24UBDq72fJ3O6P0QapXjZke33SU9/5jJHaPD/2y8twYt/8BUYCZ4
 EVc5n+jrrvidgkuYKSEW3hJl2foYLGXwFTYsi+YINMlfg4jn8UA0sQ/nnTEntJb/qgWs1RLxdfr
 Qp+IZivTBF+CICOgIrCSh5XaGTCYf+lNRu3ck2vdUyHPF7pKHwHCH62mOZmQWcLCw6Z4ZFrxRHf
 YCSh1lXa9F804GWZfLkILq+QkbAbDut5OfLELRty+gl5q7YnF11NM6UJ3crRWnZs8BjlyY6/LTo
 25QTicisctlHqHF/nv37qvppQglOt12FbONSdqsMQnzv8H/A66aFUxv7ssUep2gmLPZSFPC/LFB
 VCz4o63Uu59EsMc34Bw==
X-Proofpoint-GUID: yGCfE7cd7ihOR7TlQ8ScRPu5ZF6jM_Gf
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b8f6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=mDV3o1hIAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=EjJ-HZw9IJny81YvC_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yGCfE7cd7ihOR7TlQ8ScRPu5ZF6jM_Gf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX322VRvZtggcK
 0s6mqGVqSU6v+EN8JniCBEQd+LvBnYsH/qZzO+016I8zKcwKnjljlYSC4eNiaMW7XzXA691D0JV
 OQLgcMSt6ihkC0DC6GYmLS9pr0FQA+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

tests/tcg/mips/user/ has extra tests that are not currently run at the
moment. Keep their Makefiles until they are implemented.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure                                     |   9 -
 tests/tcg/Makefile.target                     | 287 ------------------
 tests/tcg/minilib/Makefile.target             |  21 --
 tests/tcg/multiarch/Makefile.target           | 223 --------------
 .../multiarch/system/Makefile.softmmu-target  |  81 -----
 5 files changed, 621 deletions(-)
 delete mode 100644 tests/tcg/Makefile.target
 delete mode 100644 tests/tcg/minilib/Makefile.target
 delete mode 100644 tests/tcg/multiarch/Makefile.target
 delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target

diff --git a/configure b/configure
index 56158cd95f7..259a3ca3662 100755
--- a/configure
+++ b/configure
@@ -1750,15 +1750,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-# tests/tcg configuration
-mkdir -p tests/tcg
-echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
-echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
-if test "$plugins" = "yes" ; then
-    echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
-fi
-echo "PYTHON=$python" >> tests/tcg/$config_host_mak
-
 tcg_tests_with_compilers=
 for target in $target_list; do
   arch=${target%%-*}
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
deleted file mode 100644
index 836fccaca23..00000000000
--- a/tests/tcg/Makefile.target
+++ /dev/null
@@ -1,287 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# TCG tests
-#
-# These are complicated by the fact we want to build them for guest
-# systems. This requires knowing what guests we are building and which
-# ones we have cross-compilers for or docker images with
-# cross-compilers.
-#
-# The tests themselves should be as minimal as possible as
-# cross-compilers don't always have a large amount of libraries
-# available.
-#
-# We only include the host build system for SRC_PATH and we don't
-# bother with the common rules.mk. We expect the following:
-#
-#   CC - the C compiler command
-#   EXTRA_CFLAGS - any extra CFLAGS
-#   BUILD_STATIC - are we building static binaries
-#
-# By default all tests are statically compiled but some host systems
-# may not package static libraries by default. If an external
-# cross-compiler can only build dynamic libraries the user might need
-# to make extra efforts to ensure ld.so can link at runtime when the
-# tests are run.
-#
-# We also accept SPEED=slow to enable slower running tests
-#
-# We also expect to be in the tests build dir for the FOO-(linux-user|softmmu).
-#
-
-all:
--include ../config-host.mak
--include config-target.mak
-
-# Get semihosting definitions for user-mode emulation
-ifeq ($(filter %-softmmu, $(TARGET)),)
--include $(SRC_PATH)/configs/targets/$(TARGET).mak
-endif
-
-# for including , in command strings
-COMMA := ,
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX=tests/tcg/$(TARGET):$(SPACE)
-
-quiet-@ = $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(strip $2)" && ))
-quiet-command = $(call quiet-@,$2,$3)$1
-
-cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>&1
-cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "$(strip $2)=$(strip $1)" >&3; else \
-    echo "$(TARGET_PREFIX)$1 not detected"; fi
-
-# $1 = test name, $2 = cmd, $3 = desc
-ifeq ($(filter %-softmmu, $(TARGET)),)
-run-test = $(call quiet-command, timeout -s KILL --foreground $(TIMEOUT) $2 > $1.out, \
-	TEST,$(or $3, $*, $<) on $(TARGET_NAME))
-else
-run-test = $(call quiet-command, timeout -s KILL --foreground $(TIMEOUT) $2, \
-        TEST,$(or $3, $*, $<) on $(TARGET_NAME))
-endif
-
-# $1 = test name, $2 = reference
-# to work around the pipe squashing the status we only pipe the result if
-# we know it failed and then force failure at the end.
-diff-out = $(call quiet-command, diff -q $1.out $2 || \
-                                 (diff -u $1.out $2 | head -n 10 && false), \
-                                 DIFF,$1.out with $2)
-
-# $1 = test name, $2 = reason
-skip-test = @printf "  SKIPPED %s on $(TARGET_NAME) because %s\n" $1 $2
-
-# $1 = test name, $2 = reference
-# As above but only diff if reference file exists, otherwise the test
-# passes if it managed to complete with a status of zero
-conditional-diff-out = 							\
-	$(if $(wildcard $2), 						\
-		$(call diff-out,$1,$2), 				\
-		$(call skip-test,"$1 check","no reference"))
-
-
-# Tests we are building
-TESTS=
-# additional tests which may re-use existing binaries
-EXTRA_TESTS=
-
-# Start with a blank slate, the build targets get to add stuff first
-CFLAGS=
-LDFLAGS=
-
-QEMU_OPTS=
-CHECK_PLUGIN_OUTPUT_COMMAND=
-
-
-# If TCG debugging, or TCI is enabled things are a lot slower
-# so we have to set our timeout for that. The current worst case
-# offender is the system memory test running under TCI.
-TIMEOUT=120
-
-ifeq ($(filter %-softmmu, $(TARGET)),)
-# The order we include is important. We include multiarch first and
-# then the target. If there are common tests shared between
-# sub-targets (e.g. ARM & AArch64) then it is up to
-# $(TARGET_NAME)/Makefile.target to include the common parent
-# architecture in its VPATH. However some targets are so minimal we
-# can't even build the multiarch tests.
-ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target),)
-# skip user tests if Makefile.target is not present
-else ifneq ($(filter $(TARGET_NAME),aarch64_be),)
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
-else
--include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
-endif
-
-# Add the common build options
-CFLAGS+=-Wall -Werror -O0 -g -fno-strict-aliasing
-ifeq ($(BUILD_STATIC),y)
-LDFLAGS+=-static
-endif
-
-%: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-%: %.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack $< -o $@ $(LDFLAGS)
-else
-# For system targets we include a different Makefile fragment as the
-# build options for bare programs are usually pretty different. They
-# are expected to provide their own build recipes.
-EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
-
-# We skip the multiarch tests if the target hasn't provided a boot.S
-MULTIARCH_SOFTMMU_TARGETS = i386 alpha aarch64 arm loongarch64 s390x x86_64
-
-ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
--include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
--include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
-endif
-ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target),)
-# skip system tests if Makefile.target is not present
-else
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
-endif
-
-endif
-
-all: $(TESTS) $(EXTRA_TESTS)
-
-#
-# Test Runners
-#
-# By default we just run the test with the appropriate QEMU for the
-# target. More advanced tests may want to override the runner in their
-# specific make rules. Additional runners for the same binary should
-# be added to EXTRA_RUNS.
-#
-
-RUN_TESTS=$(patsubst %,run-%, $(TESTS))
-
-# If plugins exist also include those in the tests
-ifeq ($(CONFIG_PLUGIN),y)
-PLUGIN_SRC=$(SRC_PATH)/tests/tcg/plugins
-PLUGIN_LIB=../plugins
-VPATH+=$(PLUGIN_LIB)
-# Some plugins need to be disabled for all tests to avoid exponential explosion.
-# For example, libpatch.so only needs to run against the arch-specific patch
-# target test, so we explicitly run it in the arch-specific Makefile.
-DISABLE_PLUGINS=libpatch.so
-
-# Likewise don't bother with the syscall plugin for softmmu
-ifneq ($(filter %-softmmu, $(TARGET)),)
-DISABLE_PLUGINS += libsyscall.so
-endif
-
-PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
-	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
-
-strip-plugin = $(wordlist 1, 1, $(subst -with-, ,$1))
-extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
-extract-test = $(subst run-plugin-,,$(wordlist 1, 1, $(subst -with-, ,$1)))
-
-# We need to ensure expand the run-plugin-TEST-with-PLUGIN
-# pre-requistes manually here as we can't use stems to handle it. We
-# only expand MULTIARCH_TESTS which are common on most of our targets
-# and rotate the plugins so we don't grow too out of control as new
-# tests are added. Plugins that need to run with a specific test
-# should ensure they add their combination to EXTRA_RUNS.
-
-ifneq ($(MULTIARCH_TESTS),)
-
-# Extract extra tests from the extra test+plugin combination.
-EXTRA_TESTS_WITH_PLUGIN=$(foreach test, \
-                        $(EXTRA_RUNS_WITH_PLUGIN),$(call extract-test,$(test)))
-# Exclude tests that were specified to run with specific plugins from the tests
-# which can run with any plugin combination, so we don't run it twice.
-MULTIARCH_TESTS:=$(filter-out $(EXTRA_TESTS_WITH_PLUGIN), $(MULTIARCH_TESTS))
-
-NUM_PLUGINS := $(words $(PLUGINS))
-NUM_TESTS := $(words $(MULTIARCH_TESTS))
-
-define mod_plus_one
-  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
-endef
-
-# Rules for running tests with any plugin combination, i.e., no specific plugin.
-$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
-	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
-	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
-	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
-	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
-
-# Rules for running extra tests with specific plugins.
-$(foreach f,$(EXTRA_RUNS_WITH_PLUGIN), \
-    $(eval $(f): $(call extract-test,$(f)) $(call extract-plugin,$(f))))
-
-endif # MULTIARCH_TESTS
-endif # CONFIG_PLUGIN
-
-RUN_TESTS+=$(EXTRA_RUNS)
-RUN_TESTS+=$(EXTRA_RUNS_WITH_PLUGIN)
-
-# Some plugins need additional arguments above the default to fully
-# exercise things. We can define them on a per-test basis here.
-run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
-
-ifeq ($(filter %-softmmu, $(TARGET)),)
-run-%: %
-	$(call run-test, $<, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) $<)
-
-run-plugin-%:
-	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
-		-d plugin -D $*.pout \
-		 $(call strip-plugin,$<))
-	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
-		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
-		       TEST, check plugin $(call extract-plugin,$@) output    \
-		       with $(call strip-plugin,$<)))
-else
-run-%: %
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  $(QEMU_OPTS) $<)
-
-run-plugin-%:
-	$(call run-test, $@, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
-	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
-	    	  -d plugin -D $*.pout \
-		  $(QEMU_OPTS) $(call strip-plugin,$<))
-	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
-		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
-		       TEST, check plugin $(call extract-plugin,$@) output    \
-		       with $(call strip-plugin,$<)))
-endif
-
-gdb-%: %
-	gdb --args $(QEMU) $(QEMU_OPTS) $<
-
-# Filter tests based on TCG_TEST_FILTER if set
-ifdef TCG_TEST_FILTER
-FILTERED_RUN_TESTS=$(foreach test,$(RUN_TESTS),$(if $(findstring $(TCG_TEST_FILTER),$(test)),$(test)))
-else
-FILTERED_RUN_TESTS=$(RUN_TESTS)
-endif
-
-.PHONY: run
-run: $(FILTERED_RUN_TESTS)
-
-clean:
-	rm -f $(TESTS) *.o $(CLEANFILES)
-
-distclean:
-	rm -f config-cc.mak config-target.mak ../config-$(TARGET).mak
-
-.PHONY: help
-help:
-	@echo "TCG tests help $(TARGET_NAME)"
-	@echo "Built with $(CC)"
-	@echo "Available tests:"
-	@$(foreach t,$(RUN_TESTS),echo "  $t";)
-	@echo ""
-	@echo "Environment variables:"
-	@echo "  TCG_TEST_FILTER=<pattern>  Filter tests matching pattern"
diff --git a/tests/tcg/minilib/Makefile.target b/tests/tcg/minilib/Makefile.target
deleted file mode 100644
index af0bf54be98..00000000000
--- a/tests/tcg/minilib/Makefile.target
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# System test minilib objects
-#
-# The system tests are very constrained in terms of the library they
-# support but we are not savages. We provide a few helpful routines
-# that can be shared with the tests for basic I/O.
-#
-# They assume each arch has provided a putc function.
-#
-
-SYSTEM_MINILIB_SRC=$(SRC_PATH)/tests/tcg/minilib
-MINILIB_SRCS=$(wildcard $(SYSTEM_MINILIB_SRC)/*.c)
-MINILIB_OBJS=$(patsubst $(SYSTEM_MINILIB_SRC)/%.c, %.o, $(MINILIB_SRCS))
-
-MINILIB_CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0
-MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
-
-.PRECIOUS: $(MINILIB_OBJS)
-
-%.o: $(SYSTEM_MINILIB_SRC)/%.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
deleted file mode 100644
index 35050acedc9..00000000000
--- a/tests/tcg/multiarch/Makefile.target
+++ /dev/null
@@ -1,223 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Multiarch Tests - included from tests/tcg/Makefile.target
-#
-# These tests are plain C and built without any architecture specific code.
-#
-
-MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
-
-# Set search path for all sources
-VPATH 	       += $(MULTIARCH_SRC)
-MULTIARCH_SRCS =  $(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
-ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
-VPATH 	       += $(MULTIARCH_SRC)/linux
-MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
-endif
-ifeq ($(CONFIG_PLUGIN),y)
-VPATH 	       += $(MULTIARCH_SRC)/plugin
-MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
-endif
-MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-#
-# The following are any additional rules needed to build things
-#
-
-
-float_%: LDFLAGS+=-lm
-float_%: float_%.c libs/float_helpers.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< $(MULTIARCH_SRC)/libs/float_helpers.c -o $@ $(LDFLAGS)
-
-run-float_%: float_%
-	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) $<)
-	$(call conditional-diff-out,$<,$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/$<.ref)
-
-fnmsub: LDFLAGS+=-lm
-
-testthread: LDFLAGS+=-lpthread
-
-threadcount: LDFLAGS+=-lpthread
-
-signals: LDFLAGS+=-lrt -lpthread
-
-munmap-pthread: CFLAGS+=-pthread
-munmap-pthread: LDFLAGS+=-pthread
-
-vma-pthread: CFLAGS+=-pthread
-vma-pthread: LDFLAGS+=-pthread
-
-sigreturn-sigmask: CFLAGS+=-pthread
-sigreturn-sigmask: LDFLAGS+=-pthread
-
-tb-link: LDFLAGS+=-lpthread
-
-# GCC versions 12/13/14/15 at least incorrectly complain about
-# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
-# Since this is just a standard piece of library code we've borrowed for a
-# TCG test case, suppress the warning rather than trying to modify the
-# code to work around the compiler.
-sha1: CFLAGS+=-Wno-stringop-overread -Wno-unknown-warning-option
-
-run-test-mmap: test-mmap
-	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-sha1: sha1
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
-	basic gdbstub support)
-
-run-gdbstub-qxfer-auxv-read: sha1
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
-	basic gdbstub qXfer:auxv:read support)
-
-run-gdbstub-qxfer-siginfo-read: segfault
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin "$< -s" --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-siginfo-read.py, \
-	basic gdbstub qXfer:siginfo:read support)
-
-run-gdbstub-proc-mappings: sha1
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-mappings.py, \
-	proc mappings support)
-
-run-gdbstub-thread-breakpoint: testthread
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
-	hitting a breakpoint on non-main thread)
-
-run-gdbstub-registers: sha512
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
-	checking register enumeration)
-
-# The prot-none test was skipped on gitlab due to missing gdb-multiarch,
-# however it seems to have bitrotten. Disable, it is tracked as
-# https://gitlab.com/qemu-project/qemu/-/issues/3329
-run-gdbstub-prot-none: prot-none
-ifneq ($(GITLAB_CI),)
-	$(call skip-test, $<, "Broken on GitLab")
-else
-	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
-	accessing PROT_NONE memory)
-endif
-
-run-gdbstub-catch-syscalls: catch-syscalls
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/catch-syscalls.py, \
-	hitting a syscall catchpoint)
-
-run-gdbstub-follow-fork-mode-child: follow-fork-mode
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-child.py, \
-	following children on fork)
-
-run-gdbstub-follow-fork-mode-parent: follow-fork-mode
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
-	following parents on fork)
-
-run-gdbstub-late-attach: late-attach
-	$(call run-test, $@, env LATE_ATTACH_PY=1 $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" --no-suspend \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/late-attach.py, \
-	attaching to a running process)
-
-else
-run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
-endif
-EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
-	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers run-gdbstub-prot-none \
-	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
-	      run-gdbstub-follow-fork-mode-parent \
-	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
-
-# ARM Compatible Semi Hosting Tests
-#
-# Despite having ARM in the name we actually have several
-# architectures that implement it. We gate the tests on the feature
-# appearing in config.
-#
-ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
-VPATH += $(MULTIARCH_SRC)/arm-compat-semi
-
-# Add -I path back to TARGET_NAME for semicall.h
-semihosting: CFLAGS+=-I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-
-run-semihosting: semihosting
-	$(call run-test,$<,$(QEMU) $< 2> $<.err)
-
-run-plugin-semihosting-with-%:
-	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
-		 $(call strip-plugin,$<) 2> $<.err, \
-		$< with $*)
-
-semiconsole: CFLAGS+=-I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-run-plugin-semiconsole-with-%:
-	$(call skip-test, $<, "MANUAL ONLY")
-
-TESTS += semihosting semiconsole
-endif
-
-test-plugin-mem-access: CFLAGS+=-pthread -O0
-test-plugin-mem-access: LDFLAGS+=-pthread -O0
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Test plugin memory access instrumentation
-run-plugin-test-plugin-mem-access-with-libmem.so: \
-	PLUGIN_ARGS=$(COMMA)print-accesses=true
-run-plugin-test-plugin-mem-access-with-libmem.so: \
-	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
-run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
-run-plugin-test-plugin-set-pc-with-libsetpc.so:
-
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
-			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
-			  run-plugin-test-plugin-set-pc-with-libsetpc.so
-
-else # CONFIG_PLUGIN=n
-# Do not build the syscall skipping test if it's not tested with the setpc
-# plugin because it will simply fail the test.
-MULTIARCH_TESTS := $(filter-out test-plugin-set-pc, $(MULTIARCH_TESTS))
-
-# test-plugin-syscall-filter needs syscall plugin to succeed
-test-plugin-syscall-filter: CFLAGS+=-DSKIP
-endif
-
-# Update TESTS
-TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
deleted file mode 100644
index 98c4eda5e00..00000000000
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ /dev/null
@@ -1,81 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Multiarch system tests
-#
-# We just collect the tests together here and rely on the actual guest
-# architecture to add to the test dependencies and deal with the
-# complications of building.
-#
-# To support the multiarch guests the target arch needs to provide a
-# boot.S that jumps to main and provides a __sys_outc functions.
-# Remember to update MULTIARCH_SOFTMMU_TARGETS in the tcg test
-# Makefile.target when this is done.
-#
-
-MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
-MULTIARCH_SYSTEM_SRC=$(MULTIARCH_SRC)/system
-VPATH+=$(MULTIARCH_SYSTEM_SRC)
-
-MULTIARCH_TEST_SRCS=$(wildcard $(MULTIARCH_SYSTEM_SRC)/*.c)
-MULTIARCH_TESTS = $(patsubst $(MULTIARCH_SYSTEM_SRC)/%.c, %, $(MULTIARCH_TEST_SRCS))
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-memory: memory
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) \
-		--output $<.gdb.out \
-		--qargs \
-		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/memory.py, \
-	softmmu gdbstub support)
-run-gdbstub-interrupt: interrupt
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) \
-		--output $<.gdb.out \
-		--qargs \
-		"-smp 2 -monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/interrupt.py, \
-	softmmu gdbstub support)
-run-gdbstub-untimely-packet: hello
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--gdb-args "-ex 'set debug remote 1'" \
-		--output untimely-packet.gdb.out \
-		--stderr untimely-packet.gdb.err \
-		--qemu $(QEMU) \
-		--bin $< --qargs \
-		"-monitor none -display none -chardev file$(COMMA)path=untimely-packet.out$(COMMA)id=output $(QEMU_OPTS)", \
-	softmmu gdbstub untimely packets)
-	$(call quiet-command, \
-		(! grep -Fq 'Packet instead of Ack, ignoring it' untimely-packet.gdb.err), \
-		"GREP", file untimely-packet.gdb.err)
-
-run-gdbstub-registers: memory
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) \
-		--output $<.registers.gdb.out \
-		--qargs \
-		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
-	softmmu gdbstub support)
-else
-run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
-endif
-
-MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
-	run-gdbstub-untimely-packet run-gdbstub-registers
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Test plugin memory access instrumentation
-run-plugin-memory-with-libmem.so: memory libmem.so
-run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
-run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
-
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-memory-with-libmem.so
-endif
-- 
2.43.0


