Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4845C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVV-0003AN-V9; Thu, 27 Aug 2026 18:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVM-0002z0-T4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVK-00009d-Rv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM6Gu1803764
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vKQsF91/SmX
 gLZpHhfYNxavZhJipHZDXWtiJpZrxATQ=; b=jQfbkvJFNFS0Oj83Eis5ily14pP
 26L7KtIi3ra+lE2p7D+ooq3Gx6i+qs8Jyu58PSe/k1tosXd22GVgbdcCJpkp4Arg
 V6Cm3A/Ys2rh9+FqH07uJ+cwELpVMWvLVRl6xTPz5V9AK0ZOhWMs1711bQQKDpyR
 1VXxFG5iRmyoJDaxHzExHdeFQ2eZSS95wvGHWXK2Y5JtitrTn+d7aqQHu4c6EcMo
 ITUSbBcf63nGfI1HEJpT7vxFLkNARQ3bIuI0wOUiCV1LAW9SlM6kirWWF8hQ/tjD
 iDK4tfyEIvh8YC/VNi4oyUWNj/sqWVpxZyWA8kk6ao0fsu89B0R5O7plKMg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce8a76df2dso5051545ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869405; x=1788474205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vKQsF91/SmXgLZpHhfYNxavZhJipHZDXWtiJpZrxATQ=;
 b=b6SI+C0b4j/8ehLEVibI8Ka9w+9BpHDFYvrrXSmzFqgImrzfhZNcIjO2g5yjhxfWiB
 a544CA/8uAmqylfFPj7YM9rmRVNwJFFjUEs3V1qyehY30rL6kcOSo5Bf1lIjB0sYYtgB
 u0ae9GPZEeoKFdorcmhNihBK7yZe/OcHp8qYzgcxI77GgDbXGl6q7HezUDNSuiLCmrp0
 Vm29h9cBa7xh/bKpW34iKPWNWt10rJA3OO7dI32nat3ErcZCmtykABnXLp0cTgP0Y9gU
 N7ZgMDE+27QVmnjZ38FD5O1gbb0simc8qNayp/qfPBovFgaha3Ne6IFCCYRKYycIFX+P
 wGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869405; x=1788474205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vKQsF91/SmXgLZpHhfYNxavZhJipHZDXWtiJpZrxATQ=;
 b=WV3Ym+b4sgUhKn3xKaz+PdHcAkIETP7JKWHuWV6qbaAKFqbgBc0BtNv4J7KtXm9fxx
 /Lbuo9uamhv1ry3wQE9Kw/Ywb+kWhss0CBOLwlnvskWtMhhi2q7g3LFagHrt+hlsd1Nl
 KMsg0E9+LCGoy3Kk5kNh+sshV2fSy0hsUoos63/taFYtgy7F1IpjWFE4LWXMkphfG4QJ
 j32hmOalGK+YfB6b186bDni+eKe5XLxr/QUWJ+uDFi342xx5pB6rt4wl2QixHQj4znwb
 C7Z54XgHweVYBBZq9w69ndeo1oO92y1U3vbMiTrDil8KC54Hv6UKNuLJGMPrN1LlD9Tf
 OCag==
X-Gm-Message-State: AFuF++khefGg8XqxSFhjeC4WbkQXS90A4I5xKkcMWkusYE+pj9mOr8sj
 XLFg2RpjNUX6+e6nUrKZc3TeLe1vyvFvW44L1NbmvN3yFPqfOhA9EByoyL2vjrS7VilhcPitxUh
 5O1hWSmAsag48Q6acMbPlQvhDlrvlDpOeTRVgazVuLV9i9TeRNV9BsBdRmuB2XME6yQ==
X-Gm-Gg: AR+sD11KiiavBFp1+TgPxEZTPsqePgX6/ggVp2Ycgr+S/jjGbOKfH6mub/rsl7dCob3
 +BiX2liWXKYpFHmJoEfwCnc8AcYqQsn+Pb884vo3Io6cW+F2/xa1LEBkWTd+/53uZZGW2ciuv2o
 g+2yylzGaFQI0TcBYM1yYHAuvfsZkMCu0ixdl3yr01tdMUmJrY4pcY7/Zq/Dl9yk+oE7jG6ioV8
 YsDW83faL1tIKm4NU4dd3s9Fbcpl9E/wuBKvn+wJV0IOMasUZ8NtwwLVRloYYokHoWoR+nol2Gf
 COc22Epse6XHxD2HXrbaNO9nY5578DrhHGjQOQsSPkE255y+9nwzHxHRIsQcbRVhfdFqxkRZ0vm
 dQHAJqgRxGxOSgXVXHzsmPyM3uR+Xpacebe/i66YwZMXmfDZR+/nGff0QOG8=
X-Received: by 2002:a17:902:fc4d:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2d74dc6e805mr44211455ad.2.1787869404847; 
 Thu, 27 Aug 2026 15:23:24 -0700 (PDT)
X-Received: by 2002:a17:902:fc4d:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2d74dc6e805mr44210265ad.2.1787869404252; 
 Thu, 27 Aug 2026 15:23:24 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:23 -0700 (PDT)
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
Subject: [PATCH v8 084/105] tests/tcg/s390x: user tests
Date: Thu, 27 Aug 2026 22:14:45 +0000
Message-ID: <20260827221506.91574-85-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b8dd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=U997BogEOwLcalXFwzwA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: mOPnkliRPQNzxttnq9aui8bOpA0N9O3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX8JrXuSSFVwIp
 h+OMQHjWt0UMaAaVrmtdToN2M1WfHWhEJCJAMmuhKMhEYo62j5jsYz+cKOL4XltA99ZTuHAP0PA
 Jn6+WhAiwJWbQohkF9PtD2kpje/E1EOy0383p7bCM6Osb3Zxuayt4vXJVSbPbxTfC1ibvYCAQ46
 U3fq51I/9pSedYDNLTSKtosTZfjePa4mft/8QEi64fanzfNFsxL8ld8H/XXDaB72WQxmO6I/kTN
 wkyzH8OnaZmTEayy/pTBJpcnUMxcdJBbsmMqmOoZ/O/xrFOU1EAmYBEAjSeIENEf8YmZaATXFV1
 psFL6S5qpBePhozhIUpl2YHY6u+0jgAZv0rHVkn8kM67cBR7N/Le8DiT2igSj+yzRZt9wr2wfVF
 aYxF0Y8r3ygE47XBFbCtWG7RImB2wxDLamRbvgZURuaqWE0D5SSp8sOVosNMBPtCHiVGZONAUN4
 qxed30HTP01PRG2hwBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX+MTkZTlDmCFJ
 Z13nWdz8CNEec4h5XGI/3jdiwq5QUe8uDvpPXHeuW2TOdd8SvZoG39MjxfocDhJ4Q41lsP0G7PT
 3llmfNyLyt0sSgayYRdwF/XDAII/fXQ=
X-Proofpoint-ORIG-GUID: mOPnkliRPQNzxttnq9aui8bOpA0N9O3Z
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
 tests/tcg/meson.build           |   1 +
 tests/tcg/s390x/Makefile.target | 129 -----------------------------
 tests/tcg/s390x/meson.build     | 140 ++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 129 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1a48b37f75c..6bc2829ba92 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
+subdir('s390x')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
deleted file mode 100644
index 97c0f021902..00000000000
--- a/tests/tcg/s390x/Makefile.target
+++ /dev/null
@@ -1,129 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-CFLAGS+=-march=zEC12 -m64
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=z14, CROSS_CC_HAS_Z14); \
-	    $(call cc-option,-march=z15, CROSS_CC_HAS_Z15)) 3> config-cc.mak
--include config-cc.mak
-
-TESTS+=hello-s390x
-TESTS+=csst
-TESTS+=ipm
-TESTS+=exrl-trt
-TESTS+=exrl-trtr
-TESTS+=pack
-TESTS+=mie3-compl
-TESTS+=mie3-mvcrl
-TESTS+=mie3-sel
-TESTS+=mvo
-TESTS+=mvc
-TESTS+=shift
-TESTS+=trap
-TESTS+=signals-s390x
-TESTS+=branch-relative-long
-TESTS+=noexec
-TESTS+=div
-TESTS+=clst
-TESTS+=long-double
-TESTS+=cdsg
-TESTS+=chrl
-TESTS+=rxsbg
-TESTS+=ex-relative-long
-TESTS+=ex-branch
-TESTS+=mxdb
-TESTS+=epsw
-TESTS+=larl
-TESTS+=mdeb
-TESTS+=cgebra
-TESTS+=clgebr
-TESTS+=clc
-TESTS+=laalg
-TESTS+=add-logical-with-carry
-TESTS+=lae
-TESTS+=cvd
-TESTS+=cvb
-TESTS+=ts
-TESTS+=ex-smc
-TESTS+=divide-to-integer
-TESTS+=stckf
-
-cdsg: CFLAGS+=-pthread
-cdsg: LDFLAGS+=-pthread
-
-# The following tests contain inline assembly that requires inlining,
-# and thus cannot be built with -O0.
-rxsbg: CFLAGS+=-O2
-divide-to-integer: CFLAGS+=-O2
-
-cgebra: LDFLAGS+=-lm
-clgebr: LDFLAGS+=-lm
-divide-to-integer: LDFLAGS+=-lm
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
-TESTS += $(PGM_SPECIFICATION_TESTS)
-
-Z13_TESTS=vistr
-Z13_TESTS+=lcbb
-Z13_TESTS+=locfhr
-Z13_TESTS+=vcksm
-Z13_TESTS+=vstl
-Z13_TESTS+=vrep
-Z13_TESTS+=precise-smc-user
-Z13_TESTS+=prno-trng
-$(Z13_TESTS): CFLAGS+=-march=z13 -O2
-TESTS+=$(Z13_TESTS)
-
-ifneq ($(CROSS_CC_HAS_Z14),)
-Z14_TESTS=fma vfminmax
-fma: float.h
-fma: LDFLAGS+=-lm
-vfminmax: LDFLAGS+=-lm
-vfminmax: float.h
-$(Z14_TESTS): CFLAGS+=-march=z14 -O2
-TESTS+=$(Z14_TESTS)
-endif
-
-ifneq ($(CROSS_CC_HAS_Z15),)
-Z15_TESTS=vxeh2_vs
-Z15_TESTS+=vxeh2_vcvt
-Z15_TESTS+=vxeh2_vlstr
-Z15_TESTS+=vxeh2_vstrs
-$(Z15_TESTS): CFLAGS+=-march=z15 -O2
-TESTS+=$(Z15_TESTS)
-endif
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-signals-s390x: signals-s390x
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
-	mixing signals and debugging)
-
-hello-s390x-asm: CFLAGS+=-nostdlib
-
-run-gdbstub-svc: hello-s390x-asm
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
-	single-stepping svc)
-
-EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
-endif
-
-# MVX versions of sha512
-sha512-mvx: CFLAGS=-march=z13 -mvx -O3
-sha512-mvx: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS+=sha512-mvx
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
new file mode 100644
index 00000000000..dcbbb463c43
--- /dev/null
+++ b/tests/tcg/s390x/meson.build
@@ -0,0 +1,140 @@
+cc = 's390x-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'z14': '-march=z14',
+  'z15': '-march=z15',
+}
+
+tests_s390x_pgm = [
+  'br-odd.S',
+  'cgrl-unaligned.S',
+  'clrl-unaligned.S',
+  'crl-unaligned.S',
+  'ex-odd.S',
+  'lgrl-unaligned.S',
+  'llgfrl-unaligned.S',
+  'lpswe-unaligned.S',
+  'lrl-unaligned.S',
+  'stgrl-unaligned.S',
+  'strl-unaligned.S',
+]
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  # The following tests contain inline assembly that requires inlining,
+  # and thus cannot be built with -O0.
+  'rxsbg.c': {'cflags': ['-O2']},
+  'divide-to-integer.c': {'cflags': ['-O2', '-lm']},
+
+  'hello-s390x.c': {},
+  'hello-s390x-asm.S': {'cflags': ['-nostdlib']},
+  'csst.c': {},
+  'ipm.c': {},
+  'exrl-trt.c': {},
+  'exrl-trtr.c': {},
+  'pack.c': {},
+  'mie3-compl.c': {},
+  'mie3-mvcrl.c': {},
+  'mie3-sel.c': {},
+  'mvo.c': {},
+  'mvc.c': {},
+  'shift.c': {},
+  'trap.c': {},
+  'signals-s390x.c': {},
+  'branch-relative-long.c': {},
+  'noexec.c': {},
+  'div.c': {},
+  'clst.c': {},
+  'long-double.c': {},
+  'cdsg.c': {},
+  'chrl.c': {},
+  'ex-relative-long.c': {},
+  'ex-branch.c': {},
+  'mxdb.c': {},
+  'epsw.c': {},
+  'larl.c': {},
+  'mdeb.c': {},
+  'cgebra.c': {'cflags': ['-lm']},
+  'clgebr.c': {'cflags': ['-lm']},
+  'clc.c': {},
+  'laalg.c': {},
+  'add-logical-with-carry.c': {},
+  'lae.c': {},
+  'cvd.c': {},
+  'cvb.c': {},
+  'stckf.c': {},
+  'ts.c': {},
+  'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {'cflags': [files('pgm-specification-user.c'), '-Wa,--noexecstack']}
+  }
+endforeach
+
+setup_z13 = {'cflags': ['-O2', '-march=z13']}
+tests += {
+  'vistr.c': setup_z13,
+  'lcbb.c': setup_z13,
+  'locfhr.c': setup_z13,
+  'vcksm.c': setup_z13,
+  'vstl.c': setup_z13,
+  'vrep.c': setup_z13,
+  'precise-smc-user.c': setup_z13,
+  'prno-trng.c': setup_z13,
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-mvx',
+    'cflags': setup_z13['cflags'] + ['-mvx', '-O3'],
+  }
+}
+
+setup_z14 = {
+  'cc_feat': 'z14',
+  'cflags': ['-O2', '-lm', '-Wl,--no-warn-rwx-segments']
+}
+tests += {
+  'fma.c': setup_z14,
+  'vfminmax.c': setup_z14,
+}
+
+setup_z15 = {'cc_feat': 'z15', 'cflags': ['-O2']}
+tests += {
+  'vxeh2_vs.c': setup_z15,
+  'vxeh2_vcvt.c': setup_z15,
+  'vxeh2_vlstr.c': setup_z15,
+  'vxeh2_vstrs.c': setup_z15,
+}
+
+tests += {
+  'signals-s390x.c': {
+    'test_name': 'signals',
+    'gdb_test': ['--test', files('gdbstub/test-signals-s390x.py')],
+  },
+  'hello-s390x-asm.S': {
+    'test_name': 'svc',
+    'gdb_test': ['--test', files('gdbstub/test-svc.py')],
+  },
+}
+
+if 'qemu-s390x' in emulators
+  tcg_tests += {
+    's390x-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


