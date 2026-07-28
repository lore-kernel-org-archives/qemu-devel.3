Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D7DC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZod-0006bL-JE; Tue, 28 Jul 2026 00:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZno-0005if-AT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnm-0002WD-E1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46XqV1821222
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6Dljnp4i7TL
 DsQpxCXFHIhcEcxEBQtHCiDKgUakVFps=; b=StEXohWrF2h4O84TRVG4qtw25yj
 /Du+DBzFiMTfAzlkyemj0UNzcPY7JfxEgY+DG1ue8obp5BXU0xkmmVN3g/SNSInn
 ErECAD2JMxUhkT/rHeg0Gc2ii2tKG+EcdtkIW/3yCzGcrOjcg+ehYuJpeKrkl41J
 QEYl/bCE0n/0/Eb4uhqAG/N/4tjOqQvW9E2EUe8DGCHmi7ckNoaj+NguDRtr5wQg
 6i7d2axLLd3d56RM216CKSJkmMfB00dl77WzMd5wBbr9akB4kbc9rZ9skHv8FXeO
 6C1vZIVpHlaak3//jDsRJwzgVu/lXcWRL0CzsAGZ7fE1cIYxzPbvMp6GXXw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y04ex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so5517018a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214344; x=1785819144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Dljnp4i7TLDsQpxCXFHIhcEcxEBQtHCiDKgUakVFps=;
 b=DCX0rZAV9m89iuSpcCeoCWTS0TkGOdE8Z88f6dmv13ZaLyfFVnTcAuyQLvmue7LIjX
 u6hT4qyf6L9kIpdyMOxuL0/Pq2V5cYyqlc+RVYeqMBpEOApWzhVv/ecJ2tcf8hu+HIS7
 3IYl6I1Hq4pXmhFWxBguEgmZBhcBLZqWhoxhdB/dynMUn7HVWWzJGTUqnCrvlk1ylZNN
 ta+7k+u/DXbWeuDGV7Lfx8NXKJojdQxW01N0ze78E5uMii0VczMMI2ShP298Usn48CUk
 t9TtESIUGMZGeg7ZSGQoEC2Gu13BFaJl+s1IA7+gk1LpyuJ/DsbjcYKTE2E0BY7jzUCU
 KUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214344; x=1785819144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Dljnp4i7TLDsQpxCXFHIhcEcxEBQtHCiDKgUakVFps=;
 b=YAxQl7jFpt8OhFTmMlcrlazfMMKVer60z4wfZ1hh5AdSfgBenPz2HYV/8NFlnGH55H
 mBDuMwJZIUWPdCJPGmFz8ykuuklSTvclb6Mhu0CR61dUNAZXL1pnyYul5a98obWGx6Ls
 p2VAc2zzoOF+vp2FQimhzr/Usd6hnqevzRr1AwB8G/cwsEaZ8hWBTGT7xHx4vp7wgQ6B
 dsmz+kbvZoR6Up0JGYAaSjkmNED55T0pP6WMxlAXzTdhto7TIhYewPw96ILMd4u6XoHl
 6sEIwAvI7DMjFc5Kr/NrCrJJCF33TP+tLJpXqsGEh5RLum8x8tbz9vTg2dq4Wwh/mcZH
 9YEw==
X-Gm-Message-State: AOJu0YwzdOXfbhnSNKT/FXZKiYeCmLLeEVp6oV9h61Gh4PZNwy/lyDel
 TECEwhbdrN7TRjVCVZ7HIq7izNCQZkWlk8uebYK7HuW8ArQuo1MNzr/citIL6HRCwsbLxTJfCvr
 T+PyoaJIgmSxLhNcHp9FRWamuwPVgfS9cMWvu/6WMRB9l1JGyi//ZlxoNJNgLjdasfg==
X-Gm-Gg: AR+sD10nQ2ImPl2my6P+XcDIDkdvBkIU5cDiwGLi/MDEQX44P1/Zr3bZQzXECX8uttZ
 +EXGXbxkMbLLAPZViSRD4UhJEnMmGLEkJszEQrIzIYWxY2eXYcrdDdRRHzf7aXohf31hUwegclE
 d4eDot6Co3k8gjmqzG9Dg1S2m069ERZtyZ6YgQhoJEd1Hyeqt3Y8udvbEBV9JFrlSMM07PG/vsr
 /g/0WcfG9xPwBDsn+ltlr8DGozhsdYHcLf/pd20v1h5wbhghMjaPoW/fObbwArgI+KdBa7MTN1u
 236RQjDetpMn68DKyoYEWBq0ppwPoUCFm7XebI4OAorQsMv4tmA3JpsjM7pSy1iuEidhGqQ9JGj
 +7ACpUGH7MhddmXXQ5S5yPmDhzb0KJRq7MZaS3MuNf2ldfsu7ZB2nZvi32axoFYM9lAG9g2g=
X-Received: by 2002:a05:6a21:398d:b0:3c0:9c19:65a7 with SMTP id
 adf61e73a8af0-3c8ba61b489mr1055160637.63.1785214344305; 
 Mon, 27 Jul 2026 21:52:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:398d:b0:3c0:9c19:65a7 with SMTP id
 adf61e73a8af0-3c8ba61b489mr1055126637.63.1785214343825; 
 Mon, 27 Jul 2026 21:52:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 083/103] tests/tcg/s390x: user tests
Date: Mon, 27 Jul 2026 21:42:27 -0700
Message-ID: <20260728044248.137626-84-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a683589 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=U997BogEOwLcalXFwzwA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX0iUak3BW83YG
 pjTEhPrjLGMWFJyGM2TaRZZjZ+YFtDIn6sQ/RuRYAE1aK/mmRAwFeK0EuvC32bhO54rOXqXWa2V
 hpoKMXL9DeCw1kC9XuzCglw78V7yB0Y=
X-Proofpoint-ORIG-GUID: BcvxVmQNQ_gxcosYkadOm1Gj9c-ajOCl
X-Proofpoint-GUID: BcvxVmQNQ_gxcosYkadOm1Gj9c-ajOCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX5AkGlOCiv2eA
 3NVoqB7XjldwPF3z2NTJN24qGjjlETuwT+hfXRXAvaXjzBO3tq2ukGi0I+Jdoephytru36UWMys
 6nIthWRnh+aMFq1AHV8y8WVabj5Nhgs0L3EhfVSxCejMb83DINTxp+LEigKN9BDN0/PZ6L788CP
 EV4Wh/jhGk3cVrh4IW02l8LX1Mu0i5rx/r6RbrQ0YLvXWeeF7RBAjPKLkqoR36pRtlK/dfQ8OrN
 dKPjsrca58k75rb9UFPct4KJmGSNOpD5+nWiZX4Pw7CoUhlSxvSBqcw9HC/HZNHysSMJTBCvlaE
 J5xa65buw8B6KQrJTCdKke0NL2QFarT7ajFXuIP567YMNROyoAgRNXYChD0GCiOPPtCDs918Gq7
 6m5cPhJrgErsB5y4ImSfQw+5XY72mCbCy2psdy1HQpJ/0o40/6ExKXQ8jG0Jz9gUBZ9culO5dwI
 CnHw8CU9Iqwk2FDGxOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build           |   1 +
 tests/tcg/s390x/Makefile.target | 127 -----------------------------
 tests/tcg/s390x/meson.build     | 138 ++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 127 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8bceaf7c000..16fab0e2c61 100644
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
index 0ca030ded01..00000000000
--- a/tests/tcg/s390x/Makefile.target
+++ /dev/null
@@ -1,127 +0,0 @@
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
index 00000000000..3adb7dc464c
--- /dev/null
+++ b/tests/tcg/s390x/meson.build
@@ -0,0 +1,138 @@
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
+  'ts.c': {},
+  'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {'cflags': [files('pgm-specification-user.c')]}
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
2.47.3


