Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D088C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAA-0003Dh-LT; Fri, 10 Jul 2026 17:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9z-0002Po-N3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9s-0006Lf-Ei
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3RY61697276
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tAEmOwTjiYF
 I2fHVjKsEic1v78ZawPb5T21+qhrLc1s=; b=D6OXZEHvaO78Tqc4IJ8iRkasagU
 DnDn6FrUBfYbJceOw4QDy/CQA9Qi/r6oPOoBXPUw98ovgyBpF0RzN7HZMmndIG0+
 QMF4T1GNHLvrR2XLuFBmShZk0YYwWlFX9D/n7B0DiJ2WQyfoUBCehRLhQJY7Q5uC
 fiwU9hymCOhsO9s6+j34gurYtc3NRGNASkZyjRzlZcm7TWnKID//Maa2WEep+Rpi
 S9ne2M4buADvg79gRLcrwpgN/55kP4BNZ16/iNflsI5HUD+0VGAUi+yX0at0V+ss
 fK9dswi3H93vjNcXU52YwXWBlQ5C6OFBAz8TUY5lNARUgLDczH7l0ikZnnA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5djhgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8478423e020so2337007b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720382; x=1784325182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tAEmOwTjiYFI2fHVjKsEic1v78ZawPb5T21+qhrLc1s=;
 b=RX8LIdcBdGLNS/9A2qq0VV5ePIQU5Ljgxu7/g+pwS2kjM7NHDvHr4hqSXpc0hF5WqY
 HXiI3FFXV24dsf8hJtg6j0c2tRXGxNQ9mm8rSyyT1UxQ/HdYrD961ZE+nr+f13x+kpQX
 rqaZ7BiKvvT1lJAfMBda0iMTkU8LBzJHRh+Oe1Auc5SDib0DeqccnoZFH9D122wl2isp
 0qUjEi4LLDZVv8JsboI8CEyEofCsyV4rQYWPsTsNVLEB6uuQPk8XTyXZQpooM/D0y1kt
 /55zA6g5MRE6+d7fTfaHsQf5rj4/u/xRncmxeC3cacpwmYLY9PoSdDMoDA/dfmG8AKeN
 Lf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720382; x=1784325182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tAEmOwTjiYFI2fHVjKsEic1v78ZawPb5T21+qhrLc1s=;
 b=GjG+Hyhe7+MjZX0PWdCZMLyjsBGMKNbQ3mz5RnRfHEWxuyhz2A6Kty8icw2jFq0Wfm
 ugNbKYfa/clk1S3wUFtDcD2DsDEtTpySrHj6CIUMAy4qnnL/LOaaqQ4f3I+Wo64DcS0m
 Y02G1Oh0YLvGOBW8qSuqYYsYyZBJgHpWOwsulhFib57BpFhnj6MxnQTyFlm+2oJpno0h
 N2v8aPafIaxgV9Np6q4OZh3sYIzQSpjWjtHURhifeToPiI3o988vhA5wGW9uDUOBy+hJ
 3cwLCf0pHsmI3WvBIR2AT1n0W/z0iNzERmZlMLzWnqO9LHp/DYWUvlBOk2IpEO2XKk9G
 uh2Q==
X-Gm-Message-State: AOJu0Yx4wfN255Bjvk7Vqs7yPikJtyfInpfx/EykJnWpf+hfDSz7cLbF
 QHFo7/iMXJuUP7zhQBVaR47CcyOUw/opotwcBE8i8Y2yYs6HthFoN8IPsxWX14C/M+cwq+1Plpc
 JGVPQ6TuLhLzg6AVvbP9R/cZoHnwCbevSyC8u2zyy5lj1DTK82NORlB1hIVVvrAYjRQ==
X-Gm-Gg: AfdE7cm/z5+GTOJ5wrA6ld03GekbUMPq3u5qECIYzn/pCqTnJXA37zzslVWcCuJ54UG
 cGiDwqxedWQQzhpP4s/YQvQrAcF6lIDyjTACNkSfcpkYI+jouFiMZZLvw2PowuLxFnM+6Y0HFKp
 w/aTSnycRIFx065RuGLx3bQylDEoohxBSz8+Dv16otJHrOjLO1pBb+Pa3sSWKfKaS7Cnv7HUXzU
 sMn0ZA3Ctz9zrjPwluT5SvP4D/x0ulI+Kf0Rlyv3DP6DEgKE6lttbzNSvsJfNiRglSk4Feu7L2B
 ozK6Je8hpkzZ4e6ZS1QLG9JLUG5IXj1GWhgpFSTXFsuZhPyLwotaVuhYlntEqp56rS2KS8ZlaMu
 nY7eC7afEKGZmFr8iA/IYkYiutQcSFuZooD4aTb0IhM9Rh3wPauIcbvcNJN5QuTkKYee+FQavek
 9efcCYjA==
X-Received: by 2002:a05:6a21:10b:b0:3c0:9c19:6589 with SMTP id
 adf61e73a8af0-3c110cea187mr785589637.67.1783720381880; 
 Fri, 10 Jul 2026 14:53:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:10b:b0:3c0:9c19:6589 with SMTP id
 adf61e73a8af0-3c110cea187mr785573637.67.1783720381407; 
 Fri, 10 Jul 2026 14:53:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:52:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 84/98] tests/tcg/s390x: system tests
Date: Fri, 10 Jul 2026 14:43:28 -0700
Message-ID: <20260710214343.2065491-85-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX/Swkww9RtEtH
 hbRYQbL95MNtWc2Et+7kPJ62IA1lCKXdA1EPW6IKS+iAPuepMACc/GV73Cfy6m5E3dxMPRTIge+
 q6kAeE14IqbtO6OBg8mfPfNQ8DA3/+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX/6+6WmFKIUmm
 JCFL2XVkumaUyvxW8xzxiGRpV+K772jRKDfpgi2WcYq8563UVwr/ywb/d5mtBDModjaQ4nHVaGQ
 tZAoJrg5s5lD2+LTKbPEMULnsrTIbtwUSQ9OIPo6fqgQO4lJcQaiUUXVTcchIW7Ha1zj7U3jTUo
 dkZGejTm5w7FY0mYVpOne/bCiyl8G6kZkFs+5pFZT0KLZXYPngRHFsaRchWlDWiUbH/0CitKJWB
 0wOHCuhWdN7pYTpVPQPIvKVVh7/JGpfSaBh86QHVo5PVTRI2IQorz84mVrcssGwIooV7nr18qUl
 c7LdhILRspgUAkaytaMN3G+KaMg6C2qxpMpUpkxGYqX2t+xy3D/I8u8DA4YLmostFOdKWl0c2HJ
 XdUTR3I9hC4YqVUQedn6rt6wC3TMFpx+hyjOj5UM83edx+yQz1E6nfot4HGt8V1zCTjjHPav+k4
 VKK63GnlrRpzCQ8+W8A==
X-Proofpoint-GUID: qViLe6wAOpSmSJHGPU9YfOsIuMuR611p
X-Proofpoint-ORIG-GUID: qViLe6wAOpSmSJHGPU9YfOsIuMuR611p
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a5169be cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=_v66U6LDWMuBVSOQVNIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
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
 tests/tcg/s390x/Makefile.softmmu-target | 57 ----------------
 tests/tcg/s390x/meson.build             |  2 +
 tests/tcg/s390x/system/meson.build      | 90 +++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 57 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
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
index 3adb7dc464c..d614531ca61 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..041fe83e382
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,90 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+cflags = ['-nostdlib',
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
2.47.3


