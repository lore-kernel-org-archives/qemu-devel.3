Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB86DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAC-0003Si-A7; Fri, 10 Jul 2026 17:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA1-0002bt-24
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9v-0006QK-Oq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3HlH1841696
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5qFDwX3n5Xy
 ZCkghsNm1/MDcdE0fn5t7L3waN24Ux5k=; b=gSC5YIJJ1HzspjqJrQTk8p/Jkeg
 +LKLPZMOCG3HthMdFESwUYZEXBqIbDzO1qAh6xzt4CG/3m0SrwVivlwafLoEpCXF
 s52Dgp3agwcTHOGrHPB5qlhcGXX9AfaNv8S0XxqrC7vg/0UgYxQVTNYmBTUDIsxj
 VhtKFzdsLv8ftq7Y03xC1A3vzfbjxSjMtrvOLXvbhKZ1KnnwrEdpprx9Iw8+hbbA
 eF+p2XSkIWyJUba2oVJMqUbvh2ygXgz0g1jT7uuleBmomXdZomI1Pm/mQbeKyL8B
 rEuytNN+aInsK2ONJ7/r8AHCTOh2iBsIoHIsWnAf/RINoK1+Zr+aGHK0N6Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn13r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso2030571a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720391; x=1784325191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5qFDwX3n5XyZCkghsNm1/MDcdE0fn5t7L3waN24Ux5k=;
 b=a0k3XzGcPZzdCV9GZWtWfaEs4CsOA5Q07fJBA3NzxcF4A2iOpqQV/3Tdfk9gYpKtiL
 MLznIhGHxB8Mp3UDPBbZwxgghcvpSqmj58WunT8JsEWK+oURk1IA/5sNHggCaY8tseog
 8+QTVWVY2Bhqt13YSEA5hFNCWxCA59iBu3kixEa7VKrnmIhSxH3cJATbbALCbZ5nCAGe
 FApg6Fg9MygkwPiMrrlF87hl3GmA7XVTO/v5paCe3XSHBSzvon/d7FimnDDT325uq50B
 zwP86hjfwz5N3J6yktp1xsTRDv+NFhP3ntc6W519HvByAwcX5uamfD/50yJvBvmE6ZrC
 tnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720391; x=1784325191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5qFDwX3n5XyZCkghsNm1/MDcdE0fn5t7L3waN24Ux5k=;
 b=r4HDdBxoU8LJWbGYAIZAwsDBxFQYNxeDdoFtiOptP+bFexw+gL5jBBfb/+b7FAOnbP
 hFtwlyPVDnIUZqz0rNxE4vQVF7RberQhAm5CSn0vsF5vJeAKzjEJM0LrKN9tJsc1nhd/
 Kqq0kbhppxJstUpq2zf1Kq6fRFfhXnaqYajlACRYR5qW0Gwg2Yu8czKuicp0eNX7ISiv
 n4h5YGEeZ/w+lGm5lQl82Pz3xJ3MIxLGlcSuvFwnw4E+93x+o6ousvFSefgj4vK+2K2E
 PEHR2kRf2qM+BlM7mbdCzTCDMVYvTUXYXM33UiibOJ2aIcCnbVejx0qodesL4dZz0AV0
 klKQ==
X-Gm-Message-State: AOJu0Yy9fws9CHPDa59g6//q9VrjTW9V1Z4Zm6Ne6q4LC73vL8JwGVXz
 +gMl6kYMyyLZManVtZMD001AuZJ2GkmwgH+1XqAh2itXv5tejwMVqtGsBqT2mu8svBJu3l+jkI0
 IRw6hxZNcjn9xhzQzg1SpAudxkmKU56X3493/8YrtO7+EcocF2FXLv8/3pi1nkjhdUw==
X-Gm-Gg: AfdE7cn/jPYC1peBZ+k59B1jdiTMBV4gL9KZgvqSEd0FUtmZ/ZCGQE1qAg90qHF8/rB
 LJKDD47C2kWzClOQinzvpkAzlXs+/sDHhRdGfWA1fA5HyR1U1lqI8Z+9ZaGQ7P+a8guX4+CzlbR
 um5WfuWzHNEa5+x+U3T+9zdk+CdT/F18dmV2t9qKx4/gP/SHuOAmhClCs8q1EaJO73SH7gH9vJz
 aL7sxYZ/j9iNv5tynfccUJJE5KYFtfRM0JakSKF+rwAwFp5odBD6VGf+9QnraE8OXUojgcRhQ6j
 AJtLuTN6UNhgLYJBkKF0LH2k0YnSNPV5MU9Gc/XTKPKLwt4rucNRfjx4JtIKTtkRZJoBefQzwa8
 ki5LkHtENlmypHYAcBQVciR3ZxcmTxrwqsuAe2xJuctWkGpMppXL33m248Vy2KTtg14HHJWWxah
 mf6ysIuw==
X-Received: by 2002:a05:6a21:b8c:b0:3b4:81b4:9b79 with SMTP id
 adf61e73a8af0-3c110896f5fmr736028637.40.1783720391475; 
 Fri, 10 Jul 2026 14:53:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8c:b0:3b4:81b4:9b79 with SMTP id
 adf61e73a8af0-3c110896f5fmr735999637.40.1783720390982; 
 Fri, 10 Jul 2026 14:53:10 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:07 -0700 (PDT)
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
Subject: [PATCH v5 87/98] tests/tcg/tricore: system tests
Date: Fri, 10 Jul 2026 14:43:31 -0700
Message-ID: <20260710214343.2065491-88-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a5169c8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4feyZHKGdxcD__gy_rYA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: o6JFd-4LyYx-7xDcyzjpSW6kWRtT1Xrx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX7KLr2+dCnfju
 iYS/MvDEhc5SQadDC1fl5l6utjM8pN05bBzfWm39xXmH9k47a3w7jvwAo9vuNNOvlMnrcrhzh0b
 Dc39c93VSN96OIUY+CJCI1G2BSHSh10=
X-Proofpoint-GUID: o6JFd-4LyYx-7xDcyzjpSW6kWRtT1Xrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX/dOkaepl3g0p
 Yu2gWz0MuJ4WhAiwBCXa7VHN3ApeADHbNjHr5Z0iihGrxDnwXsC73aEdAW/elGaV2G3COv2ANwi
 66yC79058PmackWsjw0Awznp/rG8mCyob/FV+T0esBJ4skLfKglQ8zZWdgnWSp/bt7Qz6wqXaTb
 hQjUxJNY2+dEqpo03VVnLDB+tjrUveAOmEZ51zJ0hR98jvEzk2q/cMA2rjQBhQxCcHs/pN8O2GE
 nj9+AceChSzwBHkV97MKzCm+8nEEzhb0HlyHrAxCz7GdaJhtAdOsbRr5jSb3kUkWoNMX/HQZiV5
 eoxdAwCKHsBJ2x8h8vQynMSUPxFfWKURPp3Qit4RhtmoRPBE5KkuMsLrCq6eCyUqfu2GvTz6Yy/
 dveJZWoX2WPQvdwvUjAXYSIjxqhVuvl5YjoAyYopCC4tADRn4DjjbgMSN6HHJGrk/LcLj14wfgt
 IqXCFKdjkGhmspcKNrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
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
 tests/tcg/meson.build                     |  1 +
 tests/tcg/tricore/Makefile.softmmu-target | 53 ---------------------
 tests/tcg/tricore/meson.build             | 57 +++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 07e03048d18..a0d629f40a1 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -151,6 +151,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
deleted file mode 100644
index 258aeb40ae8..00000000000
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ /dev/null
@@ -1,53 +0,0 @@
-TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
-ASM_TESTS_PATH = $(TESTS_PATH)/asm
-C_TESTS_PATH = $(TESTS_PATH)/c
-
-LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
-ASFLAGS = -mtc162
-CFLAGS = -mtc162 -c -I$(TESTS_PATH)
-
-TESTS += test_abs.asm.tst
-TESTS += test_bmerge.asm.tst
-TESTS += test_clz.asm.tst
-TESTS += test_crcn.asm.tst
-TESTS += test_dextr.asm.tst
-TESTS += test_dvstep.asm.tst
-TESTS += test_fadd.asm.tst
-TESTS += test_fmul.asm.tst
-TESTS += test_ftohp.asm.tst
-TESTS += test_ftoi.asm.tst
-TESTS += test_ftou.asm.tst
-TESTS += test_hptof.asm.tst
-TESTS += test_imask.asm.tst
-TESTS += test_insert.asm.tst
-TESTS += test_ld_bu.asm.tst
-TESTS += test_ld_h.asm.tst
-TESTS += test_madd.asm.tst
-TESTS += test_msub.asm.tst
-TESTS += test_muls.asm.tst
-
-TESTS += test_boot_to_main.c.tst
-TESTS += test_context_save_areas.c.tst
-
-QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
-
-%.pS: $(ASM_TESTS_PATH)/%.S
-	$(CC) -E -o $@ $<
-
-%.o: %.pS
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.asm.tst: %.o
-	$(LD) $(LDFLAGS) $< -o $@
-
-crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.o: $(C_TESTS_PATH)/%.c
-	$(CC) $(CFLAGS) -o $@ $<
-
-%.c.tst: %.o crt0-tc2x.o
-	$(LD) $(LDFLAGS) -o $@ $^
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
new file mode 100644
index 00000000000..d0bf55dedce
--- /dev/null
+++ b/tests/tcg/tricore/meson.build
@@ -0,0 +1,57 @@
+tests = []
+
+link_script = files('link.ld')[0]
+crt0 = files('c'/'crt0-tc2x.S')
+asmflags = ['-Wl,--mcpu=tc162',
+            '-Wl,-T', link_script,
+            '-mtc162',
+            '-nostartfiles']
+cflags = [asmflags, crt0]
+qemu_args = ['-display', 'none',
+             '-M', 'tricore_testboard',
+             '-cpu', 'tc37x',
+             '-kernel']
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
+setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'asm/test_abs.S': setup_asm,
+  'asm/test_bmerge.S': setup_asm,
+  'asm/test_clz.S': setup_asm,
+  'asm/test_crcn.S': setup_asm,
+  'asm/test_dextr.S': setup_asm,
+  'asm/test_dvstep.S': setup_asm,
+  'asm/test_fadd.S': setup_asm,
+  'asm/test_fmul.S': setup_asm,
+  'asm/test_ftohp.S': setup_asm,
+  'asm/test_ftoi.S': setup_asm,
+  'asm/test_ftou.S': setup_asm,
+  'asm/test_hptof.S': setup_asm,
+  'asm/test_imask.S': setup_asm,
+  'asm/test_insert.S': setup_asm,
+  'asm/test_ld_bu.S': setup_asm,
+  'asm/test_ld_h.S': setup_asm,
+  'asm/test_madd.S': setup_asm,
+  'asm/test_msub.S': setup_asm,
+  'asm/test_muls.S': setup_asm,
+  'c/test_boot_to_main.c': setup_c,
+  'c/test_context_save_areas.c': setup_c,
+}
+
+if 'qemu-system-tricore' in emulators
+  tcg_tests += {
+    'tricore-softmmu': {
+      'cc': 'tricore-gcc',
+      'cc_dockerfile': 'debian-tricore-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'tricore',
+      'gdb_arch': 'tricore',
+      'qemu': emulators['qemu-system-tricore'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


