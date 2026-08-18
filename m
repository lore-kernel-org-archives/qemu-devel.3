Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824A8C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTY-0003WF-H9; Tue, 18 Aug 2026 15:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTV-0003G7-Vs
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTU-0007QV-3F
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGmtV1518082
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kqEvKRUw09P
 NYcNEEF6PV4GEXuCCFIUdNeWt2KKiDhw=; b=mcigRuZ84SEuEeKMmmiZpC9xvY2
 twmFdw6khZGQoB571Ffh3bR25Z+upOncko3Vot0HfFFcTBNhDbVZjMGWJxHBF3dq
 SESZcukYGvHSYTKOWws8MMk311rp8mLdoQlrX3pXSaLlYbzszATID90hc6AWvaRx
 zZKhJA/TZhA29xFwJrXw1ZS7ckPzSK/adtYp+QuqynJ4cwkgA5sX+L7jpQY2PJgF
 tNar1m1R2WlxebssKbNkbADsMWY/baAyotQuCozdf8CqdTX+b+z7yUbF0hGOLXdK
 Sv5wfUijz7+sh50aLY3Np3HmuDNdMhgm3Uv/xY6/4z67OvQ1AafpL3HH/lA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0nx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso1126816a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081270; x=1787686070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqEvKRUw09PNYcNEEF6PV4GEXuCCFIUdNeWt2KKiDhw=;
 b=PsnWsVigqVqGCdsCfa0FOx68W6ik6RJ8xhUxLT+Fc8bEk9ing7hvfjSMJOIFf6QIk9
 DQukYJuiZifNuQl5zxFW3CPAKnzTJxcSEwztbfMllHcTmm9gmccFB8cfQ0rBNufHMvKV
 JarDHIcC6EbZl7ewblw+VfuytOLgFpUZXlgOAFvVzHArnKBg/NX7Mv7s3RDLMFhzzZiU
 wO+a3MQSvRQ2jhfXnbVMx2yz/gKn+JmL95LVu2WgB0dJRwSUmNrxkzxIq9NNduzHUMXG
 wE90y/aC5UOvBSGyfo/oPH/hfHHQRwRRDVHOWesZSyCwzthpxQgDy383UQly6KDMgiTx
 Z9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081270; x=1787686070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kqEvKRUw09PNYcNEEF6PV4GEXuCCFIUdNeWt2KKiDhw=;
 b=gkArh+Irj2aPebXTgncODoHl5SesMTbG9UmAWAxvB157Qyk+/gRM2PcEzi13rOaR9K
 iX6EGGjbVkribpyz4hYHysI+pDJqeTe/ijNwkNkZcJC9zGb2XeViMTRlvyHWiUlvCHma
 KLpQW6xLVpPzul3RBy2E/yEEdfwMnTP9teldm29rbToG5NiN/ylm4y+Kqr7/pqsc6UEL
 dkHlrTVvSZvuUPXWdvj8mhw7Pq4+6mnNluTrWFMoOAteQK6qE5VN4h06p3GJpUP34vpR
 u4po11Mi0sMU/6ANCKmxpUZq0BaLBJqXjH1bhOKzh11cRUrooczK96nTMzCpLxDO1RIL
 qgGQ==
X-Gm-Message-State: AOJu0YxmXeFORGEGSkXfUeuBPE77zAE7E8jL4DQ97dboRCXYrjiqYcrN
 gDd0Jt3NWvO/KrWGxmnvURdSDFqmJmmuS4rJ7wiQ3H+0REYF+q2CVwj/wmKM7FjOFirgXbtUmSY
 zR9cZs03VXpltiX08Dg/8tW3yri/5WPXCL0uUh+HZq/srCSTa4oHr0cPgi793g9WHog==
X-Gm-Gg: AR+sD11l8QunVqfN+Qxnk1+lt6ZetuFH991w0+gBi+1DT6oOLKeADkNZFCLzl4p+gPK
 JBYXbWRNLv2PKf35lSJcP5/g0zP9yT3+MUx6ocAK+3EqHrZ05CfbeXB7KoY/6qBBlgSlvZ1DIIB
 VtFiwS5c8PtYBLxWKteuvvbLbHok74h/tioJa8VmPYd80VkglfsBygbO3BOZdhWyGHkyY/oYLkO
 dK4+E1BF11x0p7yxAaqzmEDKDoFfqrk+7SloCqXLz73R/TyNzpmCcUd7v0zzPGD50TpKLYcxtlx
 xONo1WfscWSx3l1C0fWUjG7FBhEvIFegq5XW0uF+GW6rNrwf82w8GzKrxuFKCmcLM2dx0JI3M2z
 h0ZRPpT3sB2kUi298/FZUjLcvMHfWRhhevl6zSUtPiPEPH6xZL96mwfdyMZo=
X-Received: by 2002:a05:6a20:3d82:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3ccdee64abcmr8772138637.19.1787081269464; 
 Tue, 18 Aug 2026 12:27:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d82:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3ccdee64abcmr8772105637.19.1787081269025; 
 Tue, 18 Aug 2026 12:27:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:48 -0700 (PDT)
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
Subject: [PATCH v7 045/104] tests/tcg/alpha: user tests
Date: Tue, 18 Aug 2026 19:22:09 +0000
Message-ID: <20260818192309.22169-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXwAFXcn0eC7i9
 dpDkT1FQfxxk+G8PDt/efpelusjiyu3+CxYN1k+woc1Pko8H+dey12nI8m/QVKFoY7DDaDe0nz3
 +0oAU2qAowRGjDbEqTII9kFItYIacJYZOKlsp1/QV63l9KIYcA++mlAo2+TthlAiVZgnMlqQZaw
 pIAt+W8BurPOMyKQQ8BTolRMxaWzStYrzo77Dp8hvApM+x6c2Q+acFtJ4C4LrOtsyUVZXjMAq9p
 ts+jdFkAU6XYPmMvtgS2WeaD2bYsmPZrmVWy3kjIEkTEywY5zjdIVEobD9HfcbJFWT33THe6aTi
 4nn22KF27Dq0eKoi+SMvyPvFnVxW4u/sMdQ2hZFKpoFNHPJMHeiO7b9RPcXJgQfjoCmV9MWqudO
 xolWzMzsrTTBiTxB9U6YgvOL1wQk2JOw1x8/RXMok1jYkvDUVlG4AaO5pURnjON3sp4GeFvL7Zx
 57bWnMn0qabzoO6b7xQ==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b236 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=HlkHknZ0qViDtorXcHIA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: _lY8D-m9kSt7soQ5JpSWQp5ci1a1Rvtw
X-Proofpoint-GUID: _lY8D-m9kSt7soQ5JpSWQp5ci1a1Rvtw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0ZSD+mPS5eU5
 DI7v5mqypkLN2Ix/WIM1HDlR77Dsvl75kk0dAh/LQfWl/kr64pY4zIXcgGHlt2qWyxf96ZyjD8/
 HTdzfxgVP15Cl8xzWn3yKwCEe/TNJ0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/Makefile.target | 18 -----------
 tests/tcg/alpha/meson.build     | 53 +++++++++++++++++++++++++++++++++
 tests/tcg/meson.build           |  1 +
 3 files changed, 54 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.target
 create mode 100644 tests/tcg/alpha/meson.build

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
deleted file mode 100644
index 36d8ed1eaea..00000000000
--- a/tests/tcg/alpha/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Alpha specific tweaks
-
-ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
-VPATH+=$(ALPHA_SRC)
-
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
-TESTS+=$(ALPHA_TESTS)
-
-test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-test-cmov: test-cond.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-# Force generation of byte read/write
-test-plugin-mem-access: CFLAGS+=-mbwx
-
-run-test-cmov: test-cmov
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..08e371116c3
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    # Force generation of byte read/write
+    if fs.stem(src) == 'test-plugin-mem-access'
+      new_cflags += ['-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'hello-alpha.c': {},
+  'test-cond.c': {},
+  'test-cvttq.c': {},
+  'test-ovf.c': {},
+}
+
+tests += {
+  'test-cond.c': {
+    'cflags': ['-DTEST_CMOV'],
+    'exe_name': 'test-cmov'
+  },
+}
+
+if 'qemu-alpha' in emulators
+  tcg_tests += {
+    'alpha-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d878581b660..e0789d9c1eb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


