Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C419BC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZkz-0003bc-Mg; Tue, 28 Jul 2026 00:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjn-0002g6-OF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjj-00028U-1Z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ajXK2692932
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PIVeoXjbzXEy/AQprnLP2ec7dPPdjrDbjCjaVaWwcvQ=; b=cpbZBEcAAavxxSRG
 u5n5W7WOg6IVSmHV/5G/XuWJIRkoy58duNxhZqsVQlD/rsq4kobem1oTHb3AnUUH
 5rBKpC+ivQAbhDBfdRWfyel4Ic8cBx+v9XLV8fj56lkEWsvT+g9/yeo7I3yk2Tx0
 dt70WfNA83kDxhRsI1rDQtrnN3PxEXl85EWWbOHzf+5qBPncXBRZIHaLGFWgZ8N+
 3ollecwV5zTOOLyCPT1+Mw2spgmcesm0SJana+0Ap8wWlWOULVdGcxLqF6dmPO4q
 U2T6fuVLkipVSI2IuqATzn5TxxTbmifk4FTfZxh0dxul0V3eQY6c7a4G82ymNxWZ
 vJ8VQQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jf2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so75101735ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214093; x=1785818893; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PIVeoXjbzXEy/AQprnLP2ec7dPPdjrDbjCjaVaWwcvQ=;
 b=V6iDZOqReHCdaoPK7ErktLKII9Am5b6jnq12jvJhd3AiRte/UridhOM4mxnKNe6mjW
 Dk2EwzsxJmLIRjqnkp5ks1IoYi1hhlslOR1IPh/zdSL0//COrrhGcaYoj873HCoJdjD6
 iblerlbC7rhGd1xJaUf/4erPMXGeweaB+k9M5xd1GfXu2BrsuY8M4V/1DLEGR7u8flkv
 OtAIC0aJQmkOPvE08V/yCDX56A1n06mO76dlcd+dVAMN+zQwkL7kLIvaXBUotIM9n+yo
 2yBLkjd2XxYYota1gkyFAQgos++9elfBZ+rU7E4m/btAdnW2wR/yKoXuHptaWCuy6mJY
 fbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214093; x=1785818893;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PIVeoXjbzXEy/AQprnLP2ec7dPPdjrDbjCjaVaWwcvQ=;
 b=UH/DUS+NfcxDoh8xZ6s9KAlLxSrCRTg8mjShSMQGadzf7LkO2NyhiawuY41sFWhub3
 fJLk4y7+5o8ZEg/pK2krnn5iIc2X9vujAMsSYUvjQ7X9/ZuoaT1/FqmRTnfWI26pRcwB
 lTHmJjc4M2i7/ZqYaxljfqG7lLpZkQn9zHQ9PuPnwcjLJonSMbolp+dPFoZpXWykHsB8
 MFNlaYeVmbrXS8lCDZQcvxpsv20WKySypIR6ELxdVvVoBIIMiLS1VPlHt3HtyFEqoxnQ
 V7iyMR2PL7wvyUwz5MItxmjPWagHlCJqyr3wcyvFDiQtVsh4c/xGkc0c7LAttWjl2p1/
 mXtQ==
X-Gm-Message-State: AOJu0YzXW2RR/V3sSLgj1jqYPYFnhstx+06Iht4U1Mbb0DGiDNM56KWE
 0X2CNLaF9dSowEiKolOBqxCb2uysVaN6tlThh92RHkks2kc0KN5hcvBoeojqxPOHjTUhLJVnNdT
 a1SuR9rRVRWLei+oOvi3DYP5JcFIj3+a6wwmtQSTA8sQXRF9FO6qzxbySNSaVKnftjA==
X-Gm-Gg: AR+sD10cZS84v5Eyn53TllHA+N5nFjQYknHM3SFRuHF9pcV+ykbYsHdvcniYYXAihOB
 IKZ4zjp33nrTl0HOuoYiC0bBpb1fDLOsMT0+AgfRoa0eIlPKH9BYa3CCFSYELtOGD7p1Kqq4mVv
 sULkvlwa442TZ9BMVIcHNKFGJpejLt0vTRTqVpCqvD3yQuExu0bFFcSJnkrT/VO427Yp05fbA5/
 r39SrKn1hLWd4H47n0t5Ol0OT9FTF3fNOhDhI+JkkwPrlEWE+ETkpuollVYJMPepzGnrIG4NGDq
 UT4oCU4a1NM95xTm8Y62rHYUjijm3X5fxLjE2UI1xIgh5A/VYcvmOCJArZxz7l/Q9RoJQZ9SNsk
 AV2fITpbFOUtFOgkEFWM5QnXrLgUcLXx4KgJB2wtF2Rzn0O4iHxuBgI13y/SU0Lp9ye/ikRQ=
X-Received: by 2002:a05:6a20:a11a:b0:3c4:397a:69be with SMTP id
 adf61e73a8af0-3c8aafd66a5mr1092633637.19.1785214092660; 
 Mon, 27 Jul 2026 21:48:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11a:b0:3c4:397a:69be with SMTP id
 adf61e73a8af0-3c8aafd66a5mr1092600637.19.1785214092266; 
 Mon, 27 Jul 2026 21:48:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:09 -0700 (PDT)
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
Subject: [PATCH v6 064/103] tests/tcg/mips64: user tests
Date: Mon, 27 Jul 2026 21:42:08 -0700
Message-ID: <20260728044248.137626-65-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX+Oiz+YqRzD7h
 bgwZsMcfIKD0EiB4S3sMcl1nccEkhtaMJWo3DLyiwzW27GkPwpYKpOuRcQA20Q/nQMqSwaR6m2z
 LSwpQmCfy/13l94LxcQRQ4ZKno8yRSM=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a68348d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=d1guRcTfha0oDln5RU8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX6nNM/r7iV+1m
 0zgXA9mP0EEBeLCCI45i5zQYmW1DgQNPUPfqUtcuVfuPwt2TNcJd3F+sI5WzUoU+AAVxAyA4ATf
 3J2pLKFGg5lisayJEXJZ7ripQkm2CI5suzEz2A7k7n1qhVtEt52kAIrYldV2xcbbHnAneUBfr2I
 /HHTjzMP9jczFdfW3bx8qKtcEMpuqES6uPIT+GWXZ2sKc6fMtqdDgKzhNaVsYBder1xepylLMhu
 1TmhRj3NQLSu59ns4AhKyP2uCRCez7ItuGv91AfqG8xikVmkfCoA2Kxq24BWZvr6XV1nao7oMvZ
 EMMlCaX+Q1cgBES9eqmKgUuYqyuWIo0a/CPOvI42ftkoTe/5ECdmoRckPJOWPP7FhkGqvrZZjAu
 4jJNZOi2KJ4I4KuSPsRZa6OcvfIsh+xEFs1436d0SfW+oYUoypMKM4KsG5H9c9ND3am9WrNygRO
 uIXCVqg1lUgpFy2QJvw==
X-Proofpoint-ORIG-GUID: ACOVrq4Y9dj_40HlnuRA1Bs3Pk4SKjak
X-Proofpoint-GUID: ACOVrq4Y9dj_40HlnuRA1Bs3Pk4SKjak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64/Makefile.target   | 20 --------------------
 tests/tcg/mips64/meson.build       | 27 +++++++++++++++++++++++++++
 tests/tcg/mips64el/Makefile.target |  2 +-
 4 files changed, 29 insertions(+), 21 deletions(-)
 delete mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 57532e2faa6..0c3e8b05156 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mips64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
deleted file mode 100644
index 042855844a8..00000000000
--- a/tests/tcg/mips64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 - included from tests/tcg/Makefile.target
-#
-
-MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
-MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
-
-# Set search path for all sources
-VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
-
-MIPS64_TESTS=octeon-insns
-
-TESTS += $(MIPS64_TESTS)
-
-$(MIPS64_TESTS): CFLAGS+=-mabi=64
-
-run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
new file mode 100644
index 00000000000..69391c23187
--- /dev/null
+++ b/tests/tcg/mips64/meson.build
@@ -0,0 +1,27 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  '../mips/user/isa/octeon/octeon-insns.c': {
+    'qemu_args': ['-cpu', 'Octeon68XX'],
+  },
+}
+
+# export tests for mips64el
+tcg_tests_mips64 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64-linux-user': {
+      'cc': 'mips64-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
index dbc5f8dc5fe..78c722a583d 100644
--- a/tests/tcg/mips64el/Makefile.target
+++ b/tests/tcg/mips64el/Makefile.target
@@ -5,4 +5,4 @@
 # MIPS64 little-endian - included from tests/tcg/Makefile.target
 #
 
-include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
+#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
-- 
2.47.3


