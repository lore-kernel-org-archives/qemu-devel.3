Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DD6C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY7-0003Mt-PP; Tue, 18 Aug 2026 15:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY3-0003EL-Ts
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY0-0000IB-Tw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaifE1940701
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+bvhWdkebx3
 eMmgv9UTgjx8WC3xGIg7vDT+DzHJURLM=; b=gDpRko9ZY7jfSePqHD/flUazXlu
 L2Se0lwZZmPmn9AbZMkRmhzdIF8rEFLeD458PUokNkAHjBSqP4/uLh5C2iWj154P
 b5sxmsIXgD9ToOU7+8xH2xlcBmMkm7XKPWuqmz8cgy0odThTKWhFSdMHfxNtU6ap
 SQkvlsN0sJEWYiF6pA0mS0ZsGcI4HoLYkLf39tNJ7iUaIbL8l3fgD9zCl5EcjnVb
 iaomKlFfOEl2wb0cr20mldjrkdyV3BR4OQ2fQpBIfJQCHgCFMShfhLgOkt3AykWn
 WL4XoB/0/jQ8Cv+S+vNVIHUcKWPVrenn0qIXkLDxseZ0Syg/TZ6Na4xpL1A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu06pq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso1691847b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081551; x=1787686351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+bvhWdkebx3eMmgv9UTgjx8WC3xGIg7vDT+DzHJURLM=;
 b=jzI5jo3k3PQzfZQ+hwKMtMiMHAO7VR64PLVx3EJ1Pc9OHLaeZZ5TUkkio6LHSD96xm
 NK+Y4DCcrOXWSfxTJJka1eRFuCp3E/XOzpsApHTJHJ6rC1veluwGWZfnB6HBgUk58S8l
 9OOaCb0q0K41gZprLiySAlcno8Vrant9js/bjJMsoKz5uoI4rE4ISHplB3sqnD2m0uIV
 90lPA3W05bZ9gconifOxRcV8KS0dA3nyCozWEMBBvHvw/Evu/UK4EJJxv1VkhGji+RNe
 /8G/kvsKve6GEgMepJqfAyoAlAAFEpx3nsGl9s4ksa2IDPHxZdq8YZ7YECvQxfmaOCwe
 EA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081551; x=1787686351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+bvhWdkebx3eMmgv9UTgjx8WC3xGIg7vDT+DzHJURLM=;
 b=E3dKAScflYfBT9koo8QFzShbVMxQyH24gmcQRO0e1ccNjJEFAUpRepX14WmApp4yvn
 TdeZoFXp0fLMMfBXeJ9HDfg4jWJsrgoyDpubb6jzhKHU35Kh0AWRCx8Zz5fX/Tre6SnW
 leAJ7wtXyycLZ+pL5cXDSR/AI7TPtDNDbLycklNdSKT2zMYeYrSRxD7N5kjETSvPjNmu
 015iVQPG0RR1G9Cl7GJbf1HlXuK5sJe4KNRPmHjvtv+mmEtdljzutsvu7HbYOwSR29qx
 VTU5bapD4TjraE2RrdjGjwr3TGqy0yi9JTMtA4ehfPBqyoBf25RIpo7vXmOHQRcMFfHx
 s7hw==
X-Gm-Message-State: AOJu0Yyg0ThhvOhCBOjPbCqeedwfx5cR7h7DXtp/PAe6kk5VLJsasdd3
 xy3Zrw4UvND5NF/VXMPFOwmXUyrR7vPyQlQAHUcewgKYkAOCXZvHpnGroq4jRmkgkS+6Ql9BxqT
 BoekFAA7/ewlgtWfr1W3qMDPGcNwKbKQbGA5w99K5AaG71TLf+YrK6+TtgY8Ce7uHUA==
X-Gm-Gg: AR+sD10DQ4+1gxCa3nuflcXUMw6MxUVGYxbWiqxJZ4iIt12/skr1FuIFFFZ6E+FqFBa
 AbqEbDfcBeqqzQmTtIqMRvfKUnFsdVXOWaoo4exyzZFKPOtcbVHvLzDh8viYJe7ftugoAJPCOTY
 Fy/RAqd6O1z49TjvBuBJIk5YtHIkafojCjHTWB+tHTC2BVTmkUcED1auBOLQaVyv5mFRuFEhsXx
 HDqQhVt6yRF1xFllJH/E63enIq/j3ChhVjmgbSvAvlkNUadBEV92ItUa7Z2iqmZed3ApRqIzPNB
 SmmGYbsSM+dNpe4ctO/dRsNFthsSUSAKW9fgKUtg6oEXuyAEhtD60fgJPbqq82dbp7KBmgrHYGt
 L0ktyM/VDHxRJbpi3AzEJo0GjgIrF5uACzvGk3xeTfJOFQMMDYzmGOpywvOY=
X-Received: by 2002:a05:6a20:a122:b0:3b4:7459:85a0 with SMTP id
 adf61e73a8af0-3ccdee2cab7mr9030201637.18.1787081550942; 
 Tue, 18 Aug 2026 12:32:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:a122:b0:3b4:7459:85a0 with SMTP id
 adf61e73a8af0-3ccdee2cab7mr9030157637.18.1787081550457; 
 Tue, 18 Aug 2026 12:32:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 089/104] tests/tcg/tricore: system tests
Date: Tue, 18 Aug 2026 19:22:53 +0000
Message-ID: <20260818192309.22169-90-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1w_6V1TiPC5uKlxkukLY3tXppFlQZf1J
X-Proofpoint-GUID: 1w_6V1TiPC5uKlxkukLY3tXppFlQZf1J
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b34f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=4feyZHKGdxcD__gy_rYA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXz/OR7D5RCxTb
 +zAZCnFGtO+CYXouE3I+RbU2ldHawOoGH4YCwlfXwNRuYcthDpx3uL75q+0U2IEF49Ag1Yqqp/O
 W8XC+ilA7ozyGS0K0BqPtIFeVI/njL3qm0K0N+lMqCKrZ6C4chb7ua9uJ9B2T0vzGE2VmKFc5qj
 9q+RW1cjVyHhq5nnhgPho6fQDTYBFMCfvWXBeMTkzEFpVPTJT1eQsz+wB6NYbvZY+fz6Oqr5J1K
 +2JpVoNZWJZrVNR2bnjSoVBHoPoqRKiwnKx2TrFxxoJTQlFmLueqrlraYnMrDTQanJsXYH37KEq
 WZLRgYRf8sIH+1+OxAsgiNpA+nzzPLoofvelp5WWZHS6gFyS3eoSLuVAdz9tefXTCI+stg0VMtL
 Qlk66VGTeTpvyBMvMcPWkZtEf9hUeVTmmWpaFiBg6dzJx3EKafMiyfILZGpEyv6x2zwbgf1yypC
 SvAefiQXa3inEJfbFtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyys9Oo1hPrZi
 RnPGZd79VT829OFa9oVQtBUucakCHU9w/ZCU+7qnyWRzhWm3vTyWzG+oRFmSHcQu/T7xWUK3hiq
 iKnAeyyfl825gIrI+J+T/Swyxb3q41s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                     |  1 +
 tests/tcg/tricore/Makefile.softmmu-target | 53 ---------------------
 tests/tcg/tricore/meson.build             | 57 +++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1c34b8e63c6..4903947a636 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -154,6 +154,7 @@ subdir('ppc64le')
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
2.43.0


