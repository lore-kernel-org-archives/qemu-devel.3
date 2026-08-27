Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53982C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVw-0004eh-Ak; Thu, 27 Aug 2026 18:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVt-0004Po-9B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVr-0000JR-6R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLumO795150
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a/Umr6Amlx4r27qyzkKADzrOX2Ol3TxCrFerGCo/lPE=; b=S847bdBdbGnzjrvT
 xgbKU+VxBAm4gox1/r2RveuBt5vA+TTAGmViX2ny7iHqXSMIgTp7tUlUYgfoai6c
 suXTUqbcHIbGRnnMv56+Zge0XYwNKn2HlWiERpRseCqpiAvxokwOArV5panF3p2Y
 5qcKnDcfufYsO6aJtRut4gM3K7EOgn49RvXWzdeebksbk/0h54sWxYHloLapMOWN
 4vVEG0OViaVN/I0bxNgDoqZXANvlQTvI6bPiar4e2HB+aL6J+EmTp5PtZDy5Jgd/
 eh5k/jwnwN5naQTxs8eydcIhNV78bcsiuizLguED+qLCbrGaRot4Ewc274dbdPud
 aj+qiQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjnwm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso5715965ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869437; x=1788474237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a/Umr6Amlx4r27qyzkKADzrOX2Ol3TxCrFerGCo/lPE=;
 b=VE0ktGCxIrjMjrxIdrruWBMDX6t53gWkz9cprY8ZqO7KbOC3KHDtBncI8J3TVODKdh
 R3bnI6jdjc0bu6mPwKT1KadpVMooitNLnG5BEkwP8v45jweMnlKhlUhguHpmYbmZyJUm
 yKa6j9D9OzPtzcsyzLHvdNQP6LpApK5DTIPxrmq07DbncdAR/nHol/Rqfp7ye/jELOoG
 QTdU/bGBZFlS856s/1+tlV74ooYlJamOhzSrT7ZIo6DftPAeEf3o6tmWhD2eWRzx4Om8
 hZZlSsaNlZxcWcBhTytP1ycU5oDKaK75L2ZxN8bUheLogSFm0xwV4Mo9YDb8RYQYnkBw
 69lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869437; x=1788474237;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a/Umr6Amlx4r27qyzkKADzrOX2Ol3TxCrFerGCo/lPE=;
 b=L5Xu1jEVZN2UxJsM4Np+6HxqdYfTlXc400QxNvuZUCGTWkhwMKYj7gk9ELX45HIw6N
 AJFmzC2q8QDJGXFzIiCo8SmAazA5ZW7sIaVQarXvgeNR3bjvQcrycvWCinQM6fpVWvQ9
 veQuZkYM2zTsH/b8Tye6ZBynufTuTNMrxPBDCP22KHJwufX1VovyOY+dmr1Zu3kjmJfY
 BwIWW+5ER/WzMjuzG8UFav27zqK1GmxD3nxhDYEJK5lgTInGe8rK16306im9t3GcmSH1
 H9yBcoCRf4HxQUUDJ1geRuPDL4Sn9TAQ1GJpT8tgVLEvDxrbDues7XANbvJjOUZ7hhr4
 skLg==
X-Gm-Message-State: AFuF++kaTQWtdoffzOyeOgbkTVSMlPqG6mVmj9YZQCycIgfOrsX4uPTA
 n3UkF+EIcEZb5OS+44c1vf/xMGs1ZZ+If4/rq5sZb4Z+ru5pj5HkxqRQ/JE1fsCCoBczn3raUrU
 wwPerBM4+8bnL3/w2gBQMRLQ7dtvh717jR5HOUIB6UsFkjASjlgwHtoOLqyquqqYSOg==
X-Gm-Gg: AR+sD11907QAiMStObTePLsySd455eTPaqrT9+xwPAeuRKS43F0BNypZvoawteZZnuF
 GUdk//hcbqDKl855FAtZfInCdZETOsA1+VykyFjTnidCcAV3JDKKdPEWPrV8e8roVq6YnYbfd1w
 4mvk9HXYkXHIofNIKmFqhxntDF4ef9rQIBhDob216ZW6lAaHPtLHow2vZrzDVfebiV0saEnLfeI
 gCyKIGUZepFklJwjBHTqcDZkBGAj6EYzBbGfxJz9TXn3cgw08hT9HchVzQM5J6XTYr4h2G+wYvA
 bNN4/pIy6UYa4P5Rexx6ZLaOFpHyMPniUBNMSFFKstk2pLbAc/GteMy95L3K2WMbU57GUCSFPEx
 knUTIMlmBjdK1TDHmBSHT/wuJS8FrjQ643wRkr0am95IkNv/7T3tucPzPDOA=
X-Received: by 2002:a17:903:1aec:b0:2d7:203b:9863 with SMTP id
 d9443c01a7336-2d74dc6e97fmr40500905ad.1.1787869437124; 
 Thu, 27 Aug 2026 15:23:57 -0700 (PDT)
X-Received: by 2002:a17:903:1aec:b0:2d7:203b:9863 with SMTP id
 d9443c01a7336-2d74dc6e97fmr40500055ad.1.1787869436661; 
 Thu, 27 Aug 2026 15:23:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:55 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 104/105] docs/devel/testing/: update documentation
Date: Thu, 27 Aug 2026 22:15:05 +0000
Message-ID: <20260827221506.91574-105-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX21GEJWhOZEIL
 lBP9pmSjr2IV+B28gcJQ4136bc7VUEIXxImPs+WjTcxaQUGAbWtQ7mbQhdsCPDu7VicX96sG55n
 NJ0WONzFdIa565lgo60VebdgxwDrktY=
X-Proofpoint-GUID: r9_WX_eQMmiLT2bM4wSguH3fXxLuqMh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX6NQOWTPPMYPu
 W1tLMEpAsSG1vMZm4qxfyoyU6NU3JVZs7u3fHW6SCHmI1TrSaaIm5zmGMySWNbXx+YYy+eZxPNE
 r6gxFirtZzmLheBZovst/JPU7FAhEOHgwy4PtOxNpE6dBE3ElR8BAHV/6G9CUvgwI6+TVCQ+qMD
 RsrOhF3iA5cHtUu2mP+8BxPf5UjsoqiWFjruT5pc5myEr8nV3LL4hn0yBggTqOAJL8If15fEuSi
 C8rQx3ARjlOi565tzKCanPMVfpSC/q/E+KPbjpJkLhCpsquHEImUzivFVMexuntGY1BFTi91XZo
 +t1/dCCHpqoktPMlf6dydbY2l2AsKKU7AIPMJKRVinBQE7mr14LoJTNDN9lA+nfyhxGV2VnN0vP
 8APU8LGId5dxrVZ2OA6eEdKsQmOC7f/NxjsqzXRwWcMxhtC7fcUxTlX1iHLa8SzeaovzkDwwr4e
 A8yKM3hXvS9cRKiWJKA==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b8fe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=3DIi4xK0j6yb_UwI1AYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: r9_WX_eQMmiLT2bM4wSguH3fXxLuqMh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

We document how to build and run tcg tests with new framework.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/build-system.rst |  4 ++--
 docs/devel/testing/main.rst | 35 +++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 71331e64ac8..c64d40b42af 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -447,8 +447,8 @@ these sub-Makefiles, the resulting build is largely non-recursive.
 Tests, whether defined in ``meson.build`` or not, are also ran by the
 Makefile with the traditional ``make check`` phony target, while benchmarks
 are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
-with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
-tests for all targets.
+with ``make check-unit``, and ``make check-tcg`` builds and runs tcg tests
+for all targets.
 
 If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
 respectively to build emulators and run tests defined in meson.build.
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index c6821a36d99..fadb376eaf0 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -13,7 +13,7 @@ Most (but not all) tests are also integrated as an automated test into
 the meson build system so can be run directly from the build tree,
 for example::
 
-  [./pyvenv/bin/]meson test --suite qemu:softfloat
+  ./run meson test --suite qemu:softfloat
 
 will run just the softfloat tests.
 
@@ -1035,29 +1035,40 @@ See :ref:`container-ref` for more details.
 Running subset of tests
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-You can build the tests for one architecture::
+You can build the tcg tests using::
 
-  make build-tcg-tests-$TARGET
+  make tcg-tests
 
-And run with::
+And run them for one target with::
 
-  make run-tcg-tests-$TARGET
+  make check-tcg-$TARGET
 
 Adding ``V=1`` to the invocation will show the details of how to
 invoke QEMU for the test which is useful for debugging tests.
 
+Tests can also be run using directly meson test::
+
+  ./run meson test --suite tcg
+  ./run meson test --suite tcg-$TARGET
+
+Tests can be listed using::
+
+  ./run meson test --suite tcg --list
+
 Running individual tests
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Tests can also be run directly from the test build directory. If you
-run ``make help`` from the test build directory you will get a list of
-all the tests that can be run. Please note that same binaries are used
-in multiple tests, for example::
+Tests can also be run using directly meson test::
 
-  make run-plugin-test-mmap-with-libinline.so
+  ./run meson test $TARGET-$TEST
 
-will run the mmap test with the ``libinline.so`` TCG plugin. The
-gdbstub tests also re-use the test binaries but while exercising gdb.
+For instance::
+
+  ./run meson test aarch64-softmmu-hello
+
+Test command and output can be accessed by using verbose flag::
+
+  ./run meson test aarch64-softmmu-hello --verbose
 
 TCG test dependencies
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0


