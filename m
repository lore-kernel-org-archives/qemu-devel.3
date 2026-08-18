Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2660C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYZ-0004g0-KT; Tue, 18 Aug 2026 15:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYQ-00042U-04
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYO-0000OB-3W
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIl1h1971883
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a/Umr6Amlx4r27qyzkKADzrOX2Ol3TxCrFerGCo/lPE=; b=d2Vm/SsyGvzWhf+5
 tpvuY72IIKY/Y0AxwMulhS5lNOOpoykRRzU4e9ez4YUGJJHh9kART2Cyunq+626X
 2E7St7mMlF/tdWTdm/ei3xG2nzulSVXtNCY2jlgRhEirURYQ7f4qEE//T0YQJm1J
 N5+lSwEZWi544sMT/gXlas+8M1W4McDs2sjtrnBatvw3OvV8hkGd4BNiHoO4GN9f
 KwqPAZHhexkH2ulZyWE0rpExqUSw2Bpvipq0tbugcjpbMV5sO2yaCf0hbTyQ1EGy
 TVUKeLTnYdXKL9SqdT3/qoeO1j3gYXSUJ0Rs8/wkIKg1YwrzToY4ZG+R4SjtUBDZ
 XXpBdQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1tg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-395543dc382so328254a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081574; x=1787686374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a/Umr6Amlx4r27qyzkKADzrOX2Ol3TxCrFerGCo/lPE=;
 b=OYadh++tSHrRqsA+6KvpxORy6hNMAC87E0Ippp57NNAEA1WBTOov8g09I9LJ61oS9d
 F72PGYlTabTav3SaWdOPhpF8T5LPrIbv123N9/+6o/YvNkdHMRzHYk+MjVbWstzB21um
 ccFIjKrlVMvfH1cHOJmvG5sIdQ8aAgH52Ny5Dz/KZjn8u2xiqyQ1B+knO4sOU5nv8mHt
 x9e8DJuT88LyFgZTCRJ2Ofx4l7jEDqlLQfc8ayHGOX3RHZ60cVblBckP2YwF8bMudmwY
 n6MnLB/gACvdSnXjnJc4icU33fHMxBnJbsS9Ptu/V9HQARtVsMvtAcaW4s0Kmlua5axB
 7mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081574; x=1787686374;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a/Umr6Amlx4r27qyzkKADzrOX2Ol3TxCrFerGCo/lPE=;
 b=VBDrd6xjdpyvYe1n6NGtL1e2jzI14vWLtUjtKhiLHb0bySaTD4a9D5IkD4eg5t0Ccy
 A9xsuBseqAaPMDOvjv+Rt8xyTyT+yU6TnS09dOYUepO6Rn0GDtlyJVxy+8PwADNuK7gi
 c6Kt05/CDvDwyn72KbmtwxpMPVhV/D4OKQyf3l/ydWJ7sZG7N1958reRue1WY3zadaDK
 7qRsIdbeGpSJTRSVMBejDv3Lx7f876bWyJ5gA72h9VP7ykJuB27DgcF7tFSLjgAqfazt
 IrOcB2ISMvvbubrIq3KqAomezu3QBvbzPupTZaqFxrpZJk3mlJm2R9KbxFOt8q/WheFd
 nJbQ==
X-Gm-Message-State: AOJu0YzR4TktX49Cy40OaIc+SL8trCqlovMBubzbu3wsm9hful10u3Bv
 chCxt6y0DpvIq4fibYEBp4WFGlapKi6JrW9w1bVg/kXqSoca7VQhyxPutctgcDZkPobYrM2AgDr
 f5UWyBD+g1vCglNmkxIh2MQVapah6eLZgvEjAQ4yf4AmCzpbxGPSqvgDGgQGgzrXQ9g==
X-Gm-Gg: AR+sD11RXf9veEDYMKsJUNq4U5towJndQoGPb2KtmBa+2OrIwqgi1CjLHNiaPg/BHxU
 pXsOjENekWD21xSeMCvmnCEd/Z0mnS05AFJhW1QZlCT0BZD+QUlXgaovwwIie/cqy55hCPX1T24
 fpauULpqrlFpQ8LOMqpKeaXPF/rSaKKnyzHGU3lu2JeEusa+6zawT0h+Y7PjFYI55KFKrVuiYqg
 zKg25WoA/1Cr3lWZ5eTivIlB8J31SskCqUbZ606JVeWZOU71jkTjEtANTCMhqUJNZJfvVCxY9fg
 0D1NmQWP732btowlrzfYhPqn04dr9/Dj5bM/NYoN345VCDTJndh/Gqe/LLyU7pAgSFOk5ewWtBR
 pj81JN3Fur5Zfmt2NsvxCw4wZPZ4zVKO524FF5lStYES4fNJDxK4Qa9opaf0=
X-Received: by 2002:a17:90b:280a:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-3957b2c932fmr142691a91.6.1787081573997; 
 Tue, 18 Aug 2026 12:32:53 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-3957b2c932fmr142619a91.6.1787081573567; 
 Tue, 18 Aug 2026 12:32:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:53 -0700 (PDT)
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
Subject: [PATCH v7 104/104] docs/devel/testing/: update documentation
Date: Tue, 18 Aug 2026 19:23:08 +0000
Message-ID: <20260818192309.22169-105-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0ceJiWogdXLZ
 J2IYAw8Dl/Jp9LJWw3ThE8yC0a3lwsY0zZJOej+anbtopoECXjVeB3tmVgdnQ3k6NeY7caPmFG+
 JVIgGaY+K1CWQOqKqQ2LqWd+JIXI9UM=
X-Proofpoint-GUID: G6Ir00I8xy2VaILMOqFityohmeKM_NnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+Y6lC0UEWvIf
 TdHsqzmN62Lh2i8So3ZNbL77j7MSQbA8NZA/fQJWIlrXW4CPz3GUIf2Ftvvzj8tDwQ9llBLFh+6
 vpHRn759hv91qU0bAAMDaDXsyn7PYWZuIK7cdNI7W4mj82qxU5Wxd4eqHyXPdeer89RR2oXwidk
 5Wt5xU7GM4TI+bTltOw1jtsypw7GZaUL+nav4t3cVxxCvuITe0E1wbvDZ6HTzeM9e8z5NG+KVNH
 VgGhMLuHFbyVTP0KJ9tQmi6Fxt9jHXEbUk5uDUdwkWFHJTRhmY0uKSlSsLUuH0Nm9o8SgQGMWSU
 zhZDPkeH3lcedXsBleeYgU9o4eHK/wnfbWYxcrWM8VDZjgglEUdVVSY4FkpTJtdSC48roJ+PrAv
 v6/8Wr8u1Er942WALoSga0AtpQJwzFc3xokiGrPXTk1+0Eqy0N8XjBIQ8LfZcVewK1/bDGd0AeO
 Re5jB08HILeXKM1r2/w==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b366 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=3DIi4xK0j6yb_UwI1AYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: G6Ir00I8xy2VaILMOqFityohmeKM_NnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
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


