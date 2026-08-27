Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B86BC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVY-0003LE-Gj; Thu, 27 Aug 2026 18:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVU-00039w-3V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVS-0000Ba-74
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLp6B125185
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ZJ6beGopJuhtp2BrCuwv4CRH34ByzTLU4wtxP3A11c=; b=b9KnMA0de7Y0K1tc
 qINh9o+mzx4RPGrbVRHgv/YbxsrvKuXFqGioXwgzdLYmAmzVkViF4JXCFoIYoJw5
 cZzGG8FV9fkB6fJskg66AFSvuVoneFyB/NGkUkBIg5NGt3ZN5x414EwJtE3cjUpn
 tWsJZsdDoA22EHZrtumoahiCdCuncahEaalv8ZhDGR3ptPmghTlIUjwcMc/LbE1i
 6InL0mUsuGdzbFEvNBd/pVbgTfMHPgOHx3GeSNyM203mjbG23JA8rP8gBj1xI0c5
 SHTP0WW2094LefNSDV7BV8qJtBTGt/oYlIbAs1GFgPU4cQC1ei9+7IY0gvKUfYfM
 gT0tPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7twk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so2717915ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869412; x=1788474212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ZJ6beGopJuhtp2BrCuwv4CRH34ByzTLU4wtxP3A11c=;
 b=TwTCA30UkUWIiJVC3MLgOYrZseIm0qD8x/PqUoPfUShdhGhGh1v7Fa1aVj3aCqE3vI
 lgp/muuFZdRBX7D33ZtvPSnY7Eb855HvCaE3uxAfR/t5l0pwV2z+mQp6oQRzGKGUgE9W
 HsZBEu8tP4hVcQi/D8CElxyq0+E2J1rm9lrbypeseZ0vRYPH3EvEuqdY/zfHE4UhTET7
 rO6tPBK//+bADP+sjRH2u37nw50mmrhKBiC4VBsQ5s/AbsfRUC0CvthsD3jB7SRnxK5k
 yFg2w8ULTGMKKR4ENI8kZLe/eImqCE9r+VIeEesJ2LcBqrSWVobJOGMVnYUPiDRs4/aV
 kG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869412; x=1788474212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ZJ6beGopJuhtp2BrCuwv4CRH34ByzTLU4wtxP3A11c=;
 b=sPHTtLBEOmZZmCA2PdmhuEBM0xb90dY0IKTaSXSmgr/RdHgLQ2ngv3noY44AQvwpDC
 g4mzxzYgW54V0Grdb1kn/d8im04YKqM3rGwfiJHyn6gz8ag1zhmuOlnfRiwIQXNM5ekO
 EsIKAsPJvRY8X7ng5NzR5twwOFKO8D2i+U6WC9Sgb//wTxw263QdCOOybx4ScWRUdvqc
 Ds3do5xeC3BlloKgG4wtSymi1nl4r4/ci8uRpiz/LQtp2+rwO44HGtFl8pDpMQfV7Sui
 kHZCj7zgfwxKED7ikp41HDic3CEA8Wl471K+FBPHCnTJkzpUrs3UR7raxDC2NePpsksx
 T09w==
X-Gm-Message-State: AFuF++kAWxU8fv4/X6w6WXwZpd/g6JBjEweNlyfZjJ/sN4ZS9TeBQn4u
 eYEh7Y/GO97S+gPZ9z+NL1NKhojbKr9a4fH7DdGBv+zS9z8rAKR3KOK7Y06HwRqUpgICmsrgNJS
 p34OrhpRCvU2vEv/quVZuApIIRYXgtHbXy5nJ5mmZ4k1MlAj9CP/mLAiN40x5+4hQfQ==
X-Gm-Gg: AR+sD11pMz11p9UMANP6yBcMBgVYYyPgStKxXrGwNOoBL/ZtScWi4c+OSEYer/IarkN
 MXMKfn366bwa7ppZMAEOC5P9rHnD+mbtP2fWiOZWTUbLoy+76jstj8x7ZWOC6wKsY6Lz6d3XxDd
 /eS+GGPfMDo9kALqEORnnjgnRmpV/IYWLjvQk5pkU+1xsaJnNgomqfgg8fyLij+kD0yTNxiiDS4
 7pTjIUtaxxRhlIoYjecmC2/GjRutrvRO0f0uwZVS09DcEZ0E8pIb7LaOpOeyMISmMmK4XPnKdHh
 5p05+RxFO3KRIjRAJmP79uAzUl+u9Tj96BcBKasZHv0ulckYAuHOvJFPqJF+QS9DyMx2YwpAOiZ
 ra+4003F0OP1dDBq5zNiNR5EQuk7eIbjZfFpF3JpBe6bdQMOHFD9LADePRow=
X-Received: by 2002:a17:902:efd1:b0:2d6:f988:398f with SMTP id
 d9443c01a7336-2d74df00b5amr28784395ad.12.1787869412222; 
 Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
X-Received: by 2002:a17:902:efd1:b0:2d6:f988:398f with SMTP id
 d9443c01a7336-2d74df00b5amr28783815ad.12.1787869411814; 
 Thu, 27 Aug 2026 15:23:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:31 -0700 (PDT)
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
Subject: [PATCH v8 088/105] tests/tcg/sh4: user tests
Date: Thu, 27 Aug 2026 22:14:49 +0000
Message-ID: <20260827221506.91574-89-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX7QFVLYv4aOBe
 2jGPpt2JzRCYzSziLeeQenMahu8M6SYyxMaPvrU/cFDhkpPt8izvpOGHuWrm3xZys+oaDOi16xJ
 cdIoEwn1Uuq4B5CwsymSDQAb7oXFcJNyc+hLRdbeAn420x2dhKcNjKsrJ5nHAyFkrvDZNTOfC4W
 f3vFcKZGswy3YoJPT3NBHSQFUNphohy575h/BkvTWrrn8voQdTjCZR5/baoQ4rgYHRSWxILjRB8
 lFcRq3Y+YRqwuAxYSc1OaskTbfEzkqTKLsDxWXlHEp2ZWLdfjhg7z3S4jIHgJJXaZUsHyh6WDwF
 guMaraEO5xxS2IWVTHGUNynacwu9MTG0KNJafTi0eoI2rrUrdOaDGjJU5V4o5lDoLyS85jRmK92
 Lpp3Ety2TRqsEBpMtqKyu9MyUkE7o/mVmYk2znQ3tbqHKyta7cYGkT9Pel3mfVXoSlWIKi58i9t
 Sn6F/yLufiygiVhuVjw==
X-Proofpoint-GUID: d34lj-ROQMQHotPsWCafZi9IJihUkwEW
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b8e4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=2nRveiBTxYvp2EUq1skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: d34lj-ROQMQHotPsWCafZi9IJihUkwEW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX4fQWavT2ikMS
 toyMuq2x2Ape7f3ovf56J9mMJq0e/KzplUkxfveGEyU9sYhXQHIFBmG1cNVIBkG1dhg4AYdq4xE
 O7FN8OZJaqLGLk4O/Ndw4ZktKyuMcQs=
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/sh4/Makefile.target | 18 ------------------
 tests/tcg/sh4/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sh4/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 6bc2829ba92..1c34b8e63c6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -153,6 +153,7 @@ subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
+subdir('sh4')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
deleted file mode 100644
index b7a8737be0f..00000000000
--- a/tests/tcg/sh4/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SuperH specific tweaks
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/sh4
-
-test-macl: CFLAGS += -O -g
-TESTS += test-macl
-
-test-macw: CFLAGS += -O -g
-TESTS += test-macw
-
-test-addv: CFLAGS += -O -g
-TESTS += test-addv
-
-test-subv: CFLAGS += -O -g
-TESTS += test-subv
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
new file mode 100644
index 00000000000..d73df074497
--- /dev/null
+++ b/tests/tcg/sh4/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test-addv.c': {},
+  'test-macl.c': {},
+  'test-macw.c': {},
+  'test-subv.c': {},
+}
+
+if 'qemu-sh4' in emulators
+  tcg_tests += {
+    'sh4-linux-user': {
+      'cc': 'sh4-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'sh4',
+      'gdb_arch': 'sh4',
+      'qemu': emulators['qemu-sh4'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


