Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72222C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6C-0006a0-HQ; Fri, 10 Jul 2026 17:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5x-0004jQ-5C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5t-000502-UF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3iYE1846459
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l3XcX8saAbc
 VONfhp26bthMI6Ncs64PXdsAkgkiMVbc=; b=Ndh4EWVlhkl+rPGPajL28EkURYN
 94mv7SZo8outtUg13luZJ5/hWIhk06I5KZqcXFDhPP3IV+UlMCCOHimJbErKDt4K
 h8O3X3Fg+A/T2WlEFv5oZwUB42Q0eCQb46P/7kgwktyHd9sFoYtbMsmaquX/sqNa
 qcaywB4etNyneIr3VnxUK8Rm8PmfKHDGxLctMSLcnoqpuGJdOFi94iQ2HjZEaQQR
 kXsBAAXw9K/lskxpQBNoJh52Zt3pOcfS+oRjSpwtDXPbA4GW07WR/HFuG6nMLeEw
 Hwjk5G80l7INuJeusrQqjgBVtv4Kve+xgdjxPEhLvdFvrFKWEuudm4+dyrg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rjqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc4401dc7so344986a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720142; x=1784324942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3XcX8saAbcVONfhp26bthMI6Ncs64PXdsAkgkiMVbc=;
 b=hZpFGtwmW85csiBMHDH/CIHlTTa55AiEMKjjICBXy1tUg5UdI06Awl1XZHNr+Usc5V
 xLtUsLIl/AagLBnitZytoIwr0rZ9nmI58PVqyLWoDl3HOTTJ3VYZpkwpSZ//sUKZAMnE
 Zv6QTXwdWmmM2iFDHnHHhF2p4LroxsBVS3x8aSZyjbnYUKj+gKXdZHuOvJhZlTSx113V
 D+XveVT2mxsAKJ7kohyCSesRaN+TdInnk1hwSxT+GQ/xp0ElECvARGFWM6n/EUbBXpmH
 ozFpZhTLOiJOMP0d6xjWZrtOvFVml8BkesvNn/PFxr6KIrPSpgi4TRGA3O4UGpMl2974
 PHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720142; x=1784324942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l3XcX8saAbcVONfhp26bthMI6Ncs64PXdsAkgkiMVbc=;
 b=II6MFESPZ+fnL5mMkZMnHrq/NiU1BSTpMZTUuOf2zCEbxXDv8s9O8lly+QExRmXglE
 g3zE6ZuhSXxqKZWhX5/FS/XWbrA6FlRfg9lywa3cv+l27/QRSvTfAh92FXrHKHc7dZg0
 VKBQc1YgfRr4liGUUnkjttvmfUEX71fp4ODoy02WI7453jEESJo17+9OtYiqr2vsGn5T
 44ltXgByWgzMG35Ou5cMlQ5yJ0j9yUwXVkjiU3bqC0Qx+hbgOQAnlhqq2rvEReLkM8WM
 Pn4zDU4+GdCMyG2dhZgBFpDN8lwL8yI7Sd2eYENhH/yQkI9HyuDImlW7OKTjUoLS2qhh
 IoXw==
X-Gm-Message-State: AOJu0YzadGu3itR+aNBE/m5aBzg4G6BoMdBo0WW8+QE6+O8gGY6T75ZJ
 mrS5x9WFBenuVQzW9xkrT+5qIIYmelEpx8rBaYLSP4QEJ0S9dmUEoDR1K39Yxb1gVavew/+cRmA
 1Mx06gWPakA60D3ArHQRVE+Dy0tQPpQspBPWJglZZovVZkGTnKzInsEysACKlTTrIYQ==
X-Gm-Gg: AfdE7ckP64DxWENF4okgi+xXVCHyb0FQ4pxl20opFucUeEQ7rzG4zZTM3ow/6MKBs/k
 kXwWaTEdAE7A9LXXQXeS9AsUjHgP04FFWlvCImONjLdhX1VtLkqp8B3uDDBLfGNJLEfDucl7Cio
 hT1HmKwMSVWavaRPVna4ojPzXz46nRSPGfSdiGKikPdYXwV8ziOPreEpc7lu9Fwhi/P/yy0RxCO
 VgwK+XFY3fOvg1G7/xKHDQeoT9LomwYirS3zKOLR3AZYMjVqhnVCuRkxs6hDLGedKLuPK7hEWzu
 as9DaJ1BM+JHEmoa3sDcK9SnKIyls1KeaS0N6KNCtBieH5V8j4vK6ukRmwdRQKY17qXAjxB54Kn
 fj9v93Yses224e4SzHULYd3c9Wmrooc9Q3Zhy86CRp68RAOx5XM5285gRlEaByKknD6x7sb9vgU
 L0/L5+2w==
X-Received: by 2002:a17:90b:3a81:b0:36d:5d1c:c4ad with SMTP id
 98e67ed59e1d1-38dc782cc59mr525466a91.9.1783720141735; 
 Fri, 10 Jul 2026 14:49:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3a81:b0:36d:5d1c:c4ad with SMTP id
 98e67ed59e1d1-38dc782cc59mr525451a91.9.1783720141291; 
 Fri, 10 Jul 2026 14:49:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:59 -0700 (PDT)
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
Subject: [PATCH v5 61/98] test/tcg/mips: user tests
Date: Fri, 10 Jul 2026 14:43:05 -0700
Message-ID: <20260710214343.2065491-62-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q8GU8LyRqjOMoVv-EaiCQslLg0rzG1Dc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX9SYhBopA1PyD
 8My2KoCbg7n5CswIvBIWHwV20frcbne+N+Uz1xPW0tYzKBxhP2+CvXXlTq4lq2dwJnewHGupwxB
 p6MELcjL5qMPDylXu5C4lX/bdryBfa+hlWDq7J47gUwUE+uWCMShfb+n/dNYbAPCfRxzwV6ZiTi
 U4gyVhdTLJVz/f98K7ahJ6CkkcEZCVpBOMV1zKqBXrFIw+3s6EDmRNniDJyEZgpaTCt+ODakGl9
 0hwhNmT8LbGxkhM0WM8+OHBB62qqBb3Z594JoRqgyIs503SrgHfgSZAfm02QaLkqCdleYyZVAG9
 Guoh7RPY8TRLbg9GqcUKD/KPdUE8aKQWG4cJimCRPs6JI4NIFPX02Ab6TG6MqhwLSnhxQ1cNRbk
 P3XuuzRlpl0IXoS23yGivz7Q5QHTxzxKmulkyE+04Lp8BNrGVKofu7fG6A3arLTFvNbdZ0Zk5Pm
 Y7CXk8IJ8Bs4t5QwPVQ==
X-Proofpoint-GUID: Q8GU8LyRqjOMoVv-EaiCQslLg0rzG1Dc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2N93g7EynZ6B
 U0gg/2XoMUqjHoLj6GgvVrCeH/O+GA8a88/EqyW2OSOAUUk1A+jG52YdCz6Da5wakmnQg2rbSEP
 c9ab6zvJSpS+TmCdYw0Zjh93BKZYNDM=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5168ce cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=stLDFHwS15Zl94BXwzUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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
 tests/tcg/meson.build          |  1 +
 tests/tcg/mips/Makefile.target | 19 -------------------
 tests/tcg/mips/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 19 deletions(-)
 delete mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 48895c7619c..d8a96802d57 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -142,6 +142,7 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('mips')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
deleted file mode 100644
index 5d17c1706e4..00000000000
--- a/tests/tcg/mips/Makefile.target
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# MIPS - included from tests/tcg/Makefile.target
-#
-
-MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
-
-# Set search path for all sources
-VPATH 		+= $(MIPS_SRC)
-
-# hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
-MIPS_TESTS=hello-mips
-
-TESTS += $(MIPS_TESTS)
-
-hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
-hello-mips: LDFLAGS+=-nostdlib
-endif
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
new file mode 100644
index 00000000000..3c4f6ec482d
--- /dev/null
+++ b/tests/tcg/mips/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-mips.c': {
+    'cflags': ['-mno-abicalls', '-fno-PIC', '-fno-stack-protector', '-mabi=32',
+               '-nostdlib']
+  }
+}
+
+if 'qemu-mips' in emulators
+  tcg_tests += {
+    'mips-linux-user': {
+      'cc': 'mips-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips',
+      'gdb_arch': 'mips',
+      'qemu': emulators['qemu-mips'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


