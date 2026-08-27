Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3374CC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVW-0003BJ-IC; Thu, 27 Aug 2026 18:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVP-00031j-5h
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVM-0000A6-VR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMLDM1804178
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/3x+Gt3MXvG
 Gt+7TZ8fR99uKrvatIZt2IHGp2bF1qhM=; b=khl3l1+5vaFY+H4XxPf57tGb/Vo
 oPr8UKgZ3uMCUN9uLvv4X4lsOBPAM1wgvEOWKld5qDzacuKNXAfErTNDKBCFw7AQ
 sPZJgvPXdmdImDt5+LJL1hcfPvfnddGGWlwDQPsuBgyQapme6B7k0mMvThZ8BMs+
 Ap0RRbfXibC1avigFve9IE3nGGayrF8oV2nzT9trXc3MzRPG4nF6OM7dxEwWFaxn
 Bf/ljNlvmTZBW+0b8YJoQNUE52rK3/Fk+vD44cp65NVpMrXayTwdh0bYyBLzHtcQ
 5ip3ZfJTa0rPaFDZTy32tfog5LU/Xkd/U9T+gQl4z2EIX5j12OrV9ARuPAw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvx8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d70d8839f0so4172965ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869407; x=1788474207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/3x+Gt3MXvGGt+7TZ8fR99uKrvatIZt2IHGp2bF1qhM=;
 b=UEN0s+6TTJ4MmWra6uG1SS3G+jTKfKlV0aMeI0FfW+veondq5mOUQcW5VvqxR+vL8q
 jBBiluRe/wT0z8WE6PBn8r/6wYL6cmFOBzUPTcGrEbLW63UjJV4IossFUuFd5UJEoZb4
 xKfYogw0Ftb7tWvnPTfiyVYpjm7tKK5nZfjqYWXFFGSLrSkYvv4zFQUm9t7dFjxPeeXN
 FFHa9G/2xpZ+qc1bzLXmw6BvjVfeAYcUGrsQ7LKTjX1jO4T6RXIp/lFnhRwJsaZIGTvG
 ZfVRlJAQOqhJ0kO1mLTI8SsNZJNQfLGaSKHgEpX1dJDE/sRMn8z0/Q2onDqy5OVakc02
 NytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869407; x=1788474207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/3x+Gt3MXvGGt+7TZ8fR99uKrvatIZt2IHGp2bF1qhM=;
 b=KKJ+SVcvgChKDpYWqx0CJJHfuPXUAYZCusjCfD16yKIsK38T6VRKjPGcuF2sLtQQvq
 RpFG9uuU9zWaFwlZWxviJD2z+luavOTLQXNCtoLkgmkSrEQUivkD3rMTkK0Ex5E9y2OI
 DE4Dt3nRlappz5InzgA8Jpw6TovAr5VIIeGuWCNTqQvSL9YgBnQJ3p78AjW+xQ2P7Fze
 xMzz3YMgP2iaicdsOB0WBOlk/AatjRDZ5rU9XvLtuMiHZ6BYYuUnv8WmkAYK6U4Zwn+A
 fo2lPsz8RTkDv4/JOEO1/l3Mo2k5/PRB1RXWJ3k6TJEdjGWGX4Ec1n76jIVMjfFO8axw
 2scw==
X-Gm-Message-State: AFuF++njBlvV9unSKuTUeYCTVWJfANkDIB4y+0/FkfLSAZfrfD8V2txR
 GOIbHCVPr/vzNhr+8qJTVODerEcy1XmZvLOzmv317KoT9fXwGBCi2on2HPrgfXLSUMWTAO3WIDl
 Ne8RML58WeiHxF3S/pdDFTVnGSV+x0LKEh2+Yh+feL/I2/XzdjBJ5DrQlwy8I3OiHSA==
X-Gm-Gg: AR+sD13tBE99NmLOe70tgQSJPNmEaMwD1IsF529P8t1QHaK4w0YwXvlj9X4XFa+NExG
 LhG9/yLBjlBM9DM9e1tE19JeBGpYYvUCi0GXYGGWTC4k5wIWUCls78Vo6tdls3Dvomx/rjgHve6
 v6Q9ZEpAclAcA1NJJHCru4x8+XlfCBW/xZ8Z8PKk2UT3cI7vXaPwrzpsSzwDTT7/Si7xpg5LdYn
 32m3GDQZ9FXDVf0Fx5RD/krM5teHJ71Esrx+k7dPNr098bJGoh/fAR16284WGsmDSmcBRNu+0gV
 THV2n41KMI3xu17eZtFLBfiz6q97TxM3xXVXXqse0Uds78mAkURdnZ6ARff2J9Ig0p3Yv//dfQc
 QpXAHs4dpbFLsrfXmN/rF6f7KypOACk9hkLI5apoufCKpSBa6V7IQiJhQlXE=
X-Received: by 2002:a17:903:2385:b0:2d1:1d3d:97b2 with SMTP id
 d9443c01a7336-2d74e09e781mr42686585ad.11.1787869406961; 
 Thu, 27 Aug 2026 15:23:26 -0700 (PDT)
X-Received: by 2002:a17:903:2385:b0:2d1:1d3d:97b2 with SMTP id
 d9443c01a7336-2d74e09e781mr42685845ad.11.1787869406549; 
 Thu, 27 Aug 2026 15:23:26 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:25 -0700 (PDT)
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
Subject: [PATCH v8 086/105] tests/tcg/s390x: system tests
Date: Thu, 27 Aug 2026 22:14:47 +0000
Message-ID: <20260827221506.91574-87-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b8df cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=SUcGKMR0j6ugdtI7A98A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cK9-EEx7vOdFoiUl3j8Wijv6mF3r-zLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXxlkpJiPqhqxe
 KNG5BWzgz9CilQM0yXIzTE8XUFqI7NSmb9Gp9RdNA5zIw4NkjoCrF06Su7CEx5CSbXJ5XcSg89m
 fGut5b+zXtQCa466M+o0Uy111xZ5AhbbxguUVVILZaW2eT9UBUBayI4+Jm0EODMnzSN+rR4ff/i
 O2P08i70DbWUlN5m5rHzE5uUyXA59RiudCasaaFRAmEmLoc0uP923Zaao/gjA6lBkhaTU6S1gIs
 LWzRigdyFvrQWHO59fVmaFXvndDnhibO+fDArFyRseG+p84evf/IaMsfvhVOSqmWRG3y/GHcjpz
 8ayL0EFZPSYL26y+gxbEIVpI4YqAm0oA1fIH97f8LxU7zTPfGDBdQ2B7MTDBfn+yBReyTnpiHFv
 iz73IduBNyUfGBlIFRcpeDQeaqfd9ZRJ5VaEKqPSWItkQkSjDngFVQpotOSYxeAN4N0beVmEsJ/
 nHnRx73L4K8mdPlKSLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX8IZmvoiw0HoK
 PzA7smO9wiUdGFrK2c+J4jMP7H0RoBeHF8bSKZqdZ2Jd5C9DPoV2HUxaIhZd3haTrRdZvp14eLg
 f7uZqpXPN5BVDLyBiFNLyQJeM3JksIs=
X-Proofpoint-ORIG-GUID: cK9-EEx7vOdFoiUl3j8Wijv6mF3r-zLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target | 57 ---------------
 tests/tcg/s390x/meson.build             |  2 +
 tests/tcg/s390x/pgm-specification.mak   | 15 ----
 tests/tcg/s390x/system/meson.build      | 92 +++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 72 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
 delete mode 100644 tests/tcg/s390x/pgm-specification.mak
 create mode 100644 tests/tcg/s390x/system/meson.build

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
deleted file mode 100644
index a4425d3184a..00000000000
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ /dev/null
@@ -1,57 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-# EXTFLAGS can be passed by the user, e.g. to override the --accel
-QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
-LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
-CFLAGS+=-ggdb -O0 -I$(SRC_PATH)/include/hw/s390x/ipl/
-LDFLAGS=-nostdlib -static
-
-%.o: %.S
-	$(CC) -march=z13 -m64 -Wa,--noexecstack -c $< -o $@
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -march=z13 -m64 -c $< -o $@
-
-%: %.o
-	$(CC) $< -o $@ $(LDFLAGS)
-
-ASM_TESTS =                                                                    \
-    bal                                                                        \
-    cksm                                                                       \
-    clm                                                                        \
-    exrl-ssm-early                                                             \
-    icm                                                                        \
-    sam                                                                        \
-    lpsw                                                                       \
-    lpswe-early                                                                \
-    lra                                                                        \
-    mc                                                                         \
-    per                                                                        \
-    precise-smc-softmmu                                                        \
-    sckc                                                                       \
-    ssm-early                                                                  \
-    stosm-early                                                                \
-    stpq                                                                       \
-    unaligned-lowcore
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-softmmu.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-softmmu.o
-ASM_TESTS += $(PGM_SPECIFICATION_TESTS)
-
-$(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
-$(ASM_TESTS): $(LINK_SCRIPT)
-TESTS += $(ASM_TESTS)
-
-MULTIARCH_TESTS += mvc-smc
-S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
-$(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): CFLAGS += $(MINILIB_INC) \
-			      -I$(SRC_PATH)/roms/SLOF/lib/libc/include/
-memory: CFLAGS += -DCHECK_UNALIGNED=0
-
-# s390x clears the BSS section so we need to account for that
-run-plugin-memory-with-libmem.so: 		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py \
-		--bss-cleared $@.out
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index dcbbb463c43..dc6271c7c73 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/pgm-specification.mak b/tests/tcg/s390x/pgm-specification.mak
deleted file mode 100644
index 73dc47af0d2..00000000000
--- a/tests/tcg/s390x/pgm-specification.mak
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# List of specification exception tests.
-# Shared between the system and the user makefiles.
-PGM_SPECIFICATION_TESTS = \
-	br-odd \
-	cgrl-unaligned \
-	clrl-unaligned \
-	crl-unaligned \
-	ex-odd \
-	lgrl-unaligned \
-	llgfrl-unaligned \
-	lpswe-unaligned \
-	lrl-unaligned \
-	stgrl-unaligned \
-	strl-unaligned
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..ca07f503058
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,92 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf,
+          '-I', ipl_inc,
+          '-march=z13',
+          head64, console]
+asmflags = ['-nostdlib',
+            '-Wl,-T', link_script, '-Wl,--build-id=none',
+            '-march=z13', '-Wa,--noexecstack']
+qemu_args = ['-display', 'none',
+             '-action', 'panic=exit-failure',
+             '-serial', 'stdio',
+             '-kernel']
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if 'test_name' in setup and setup['test_name'] == 'memory-access'
+      # s390x clears the BSS section so we need to account for that
+      # ./validate-memory-counts.py --bss-cleared
+      setup += {'wrapper': setup['wrapper'] + '--bss-cleared'}
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_args}}
+  endforeach
+endforeach
+
+tests += {
+  'mvc-smc.c': {'cflags': [cflags], 'qemu_args': qemu_args},
+}
+
+setup_asm = {'cflags': [asmflags], 'qemu_args': qemu_args}
+tests += {
+  'bal.S': setup_asm,
+  'cksm.S': setup_asm,
+  'clm.S': setup_asm,
+  'exrl-ssm-early.S': setup_asm,
+  'icm.S': setup_asm,
+  'sam.S': setup_asm,
+  'lpsw.S': setup_asm,
+  'lpswe-early.S': setup_asm,
+  'lra.S': setup_asm,
+  'mc.S': setup_asm,
+  'per.S': setup_asm,
+  'precise-smc-softmmu.S': setup_asm,
+  'sckc.S': setup_asm,
+  'ssm-early.S': setup_asm,
+  'stosm-early.S': setup_asm,
+  'stpq.S': setup_asm,
+  'unaligned-lowcore.S': setup_asm,
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {
+      'cflags': [asmflags, files('../pgm-specification-softmmu.S')],
+      'qemu_args': qemu_args,
+    }
+  }
+endforeach
+
+if 'qemu-system-s390x' in emulators
+  tcg_tests += {
+    's390x-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'qemu': emulators['qemu-system-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


