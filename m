Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C0C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRo-0004Ja-EW; Thu, 27 Aug 2026 18:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRa-0002uq-2w
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRY-00079b-5n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:33 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLvuG795155
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E0J6Fg3o3Ds
 ip/dW2/ZtguYupoqqa9K22JGMSQmFkPU=; b=f7dAJh1g2/WUYDLfDsTHIu5kS4I
 FiLqJud1yuU5KTuloNYDHhL1xuDCJgzdoIZPL8PG+JmaT/R3H2iz/SK/lRva8ig1
 JLaHesJyw0REYR9KQxfgxrrJtUO15dR0keNBAp835YmcOnVjDZuasNc93Az6T042
 X1R3elfnuvhMUl4MufiarTKzL7w4Lmo3JsJOohPnfN7vNu1CjeX/NgAgVeJ8Pcr6
 dmtIhn+8p5Vcs2E8SMIAyBxxn9Q7+MTyuIJZyjkyIEarvZcCfx8w9v0wnl2HTT0/
 6+V92bZH1dFZpf7oNUueJD3EBAlUD4QiQaBH0NS8C27A72H+jd87jhlqaGA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjngk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396638f9a18so347254a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869160; x=1788473960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E0J6Fg3o3Dsip/dW2/ZtguYupoqqa9K22JGMSQmFkPU=;
 b=N8sJqIaEGyf0Txlo6MBkgz8oDSw9eEwOfMkuPL1J+zFYhmGP+elij9LwcnvUnuWtQU
 xLojMQ1Kao2pvCtw0u/eutIRNLMMVsGZGZsrk4fXmsqNuHdKwD5qtoMSBRqzMAFEazF+
 0KwC9LT6YWqwnf0yTbCrZ2WUjJtijkNU1lXLlcI+ZjO2MklgVvUJ0g7/FenZcRkuJ7J/
 0N2yhLYUUEC0hWay93WWmuoGtwUtSPKIDaVxtToS/ROOe9ytccL7bvxGg7uLPFXIB8Bg
 Cs2/DZNNyYOVbA/5T08ZfcmW2itKqz75VhtzFjv7klLjzhnfo6QP9cYSR32cor4tqrYb
 B/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869160; x=1788473960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E0J6Fg3o3Dsip/dW2/ZtguYupoqqa9K22JGMSQmFkPU=;
 b=ZXqJmfrkp2QQEpo2mTCHnf9mX/NupaQCUgqpTQY74ku66tFfOPnx/z4HNqCkzWmEun
 YVheIj3X7GXjlFxzYE8+EBUtK5gDqYZp6mt3mhfcSwuhpaaKoAX+U7AzkI+K5hfLumcQ
 nnglkrZTCFCI+TyhpdXp9zDHimPaQCeVymOx6w93p6guANx0JFdFVt5S4P0vP77h/Lin
 O6JC6olWLcGiEk+veWwpxZ/v78MqEegEqozbwnygo7YDt2qQL57HArA8cfauBdAjaupx
 OuFqubpOCs5vqldWz1mzv5NBbLEwmMxA4zPcsCghmt0Iws112tDPH/W+6ICwueVS+htU
 FDOw==
X-Gm-Message-State: AFuF++n+dkgH2uq0OL1CSm21YVQiozMFNOAbpjTRAbdYittPf0cuqhp1
 G2k4hjwAcrA0lASKZeEcrPscH6cFuwl9y4Yc/O1bTmyk94qGYoAUK+6Do8JeQC0zb7KzeJDdDwr
 SC8FFv9YbM8dvBC1qAzTm4sSjf0kD3dVxPdfR7q7bgBvmVaS1oDwKsg6NgZNrUUnvmA==
X-Gm-Gg: AR+sD12oTagNxtWVMx8sUlrjfdMbYgoR0fIgn5MzFFiIwjXhVTWT0roRRjX5ym/DbEs
 me57bowWIlaMhiQapPo/ZFRHMYIcZIACAm7hK92gVrklonSn6qgDAfH7W+IvDxB7L2/6xyGtM/2
 urhOiMoOKQIShJXbZgMR+qEEHz+WUgfaox6Qu6qPywb1XQ8ueud5hTfOklC+MZDHnqcMc8TQ1jD
 UYWFVshq5CXCFEqXt64d5DC95uslMeJJnbJV/8Ho/3JOCBU47ZIcBshcuScmPQZoG0iNMKGJohG
 K5W2lZeoO3Ke4ig9dlTdGfY34Tzq4sx9sZD7zoF5CPSOdl5glEtRyjvb2A02tDhEhtm5QLYwBeg
 YNG75VWgsL5bL1w00CUny6g7Pt/h3LYJAI7O1W7I0geJemjWDnpEbzE0mO2o=
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-396d0fccf78mr4738492a91.13.1787869160084; 
 Thu, 27 Aug 2026 15:19:20 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-396d0fccf78mr4738396a91.13.1787869159660; 
 Thu, 27 Aug 2026 15:19:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:19 -0700 (PDT)
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
Subject: [PATCH v8 053/105] tests/tcg/hppa: user tests
Date: Thu, 27 Aug 2026 22:14:14 +0000
Message-ID: <20260827221506.91574-54-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX840wEC9ReTmf
 bmfXpa1Z2mS6hbDNoMAjnsN6H9VOHta2sUD91LJjZD58MzphAnYs5ce/T3TfXk7NV8K1LPGyg4M
 CWMC2hFDA9+WJzGy6Z6J6MasoSJxUSI=
X-Proofpoint-GUID: 3WEmxdZh62Y6pvUjB2cl76FVOyktrvnp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXxDOP8abCwelu
 5Gqhh8o7Jsksc1gBRpT4o2IRAR1DtEYeOPvdCCAXUziqjBrN/Cw9E3xhodzPKLUbuCOXtzP8roC
 iUzIw/R94tHxFAUhWA19q69ljgSy8R8/Z0YnDYsAThHp6u/jEysOPUMqKxUpQDfp92evL5GznLi
 JWDyLyA970tR7jEWpd0Cd34UzVCK2nb7pCxaLskQ34ZdIl8VwgScFXaqmLW17plAoJsUr3vn4LA
 hQVnfycVzGkZStAN8CEMBEpd+oALR1nZYaASsKq+m97Bji0v3Syr+TbAffWTgUrNqYCppXgY+BG
 UB+QtSYBsNq3qzCMUFYCQ9JNtelP05w4Zr6pH1GYYxJjDz1wIWoGGRSW2WN9s80LS6R0OPHdEmD
 hOFBCCE9odQgob8LREqvD66EseYmNlpfbe1U/Jyz70DHP8V6XMGOkCfPXJTeT1WMqj+rwsK6gxX
 eaGo+QqoEktLyU2mGug==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b7e9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Wtfs_aKp8OXI5K8l3bAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 3WEmxdZh62Y6pvUjB2cl76FVOyktrvnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hppa/Makefile.target | 14 --------------
 tests/tcg/hppa/meson.build     | 22 ++++++++++++++++++++++
 tests/tcg/meson.build          |  1 +
 3 files changed, 23 insertions(+), 14 deletions(-)
 delete mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/hppa/meson.build

diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
deleted file mode 100644
index ea5ae2186df..00000000000
--- a/tests/tcg/hppa/Makefile.target
+++ /dev/null
@@ -1,14 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# HPPA specific tweaks - specifically masking out broken tests
-
-# This triggers failures for hppa-linux about 1% of the time
-# HPPA is the odd target that can't use the sigtramp page;
-# it requires the full vdso with dwarf2 unwind info.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN awaiting vdso support")
-
-VPATH += $(SRC_PATH)/tests/tcg/hppa
-TESTS += stby
-
-stby: CFLAGS += -pthread
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
new file mode 100644
index 00000000000..9ca8f29fa93
--- /dev/null
+++ b/tests/tcg/hppa/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'stby.c': {'cflags': ['-pthread']},
+}
+
+if 'qemu-hppa' in emulators
+  tcg_tests += {
+    'hppa-linux-user': {
+      'cc': 'hppa-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'hppa',
+      'gdb_arch': 'hppa',
+      'qemu': emulators['qemu-hppa'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 27d7aedb8b8..878a391d8fd 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


