Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD4FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAS-0005Qb-9J; Fri, 10 Jul 2026 17:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJAO-000563-08
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJAL-0006Xl-Ml
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3DGj1830722
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U9QzBSb/K96
 NrPSOIb4UqraG+6ddoCjdXX+eTqw+Hf0=; b=pJEXFJS0Ahqabwq3VQBI0mkLLWe
 2i/n38Lgg1TxU7iDaMjjsBt9GTlOyKTxVLiqXPjhwqLDp1zCb6Yzrvrzm05JqPeE
 C1r2IHV40a37LXi7SPKlfJqZuPc4b5L5BXvamh7JLrpwZsWRZF9n5OBwd5uigAhj
 ofWkRkkJ2Kc+V7GhdfVl4Ypjr466e2vjKF2hczWyxisodkGO2ItbNlBPoQPQtLjy
 QFU7CMvx41G8l3I30mrWau4IUDE5dvl99qYHWJdxBqj2N+iqou/a0zzDmdbSgbPa
 dPZA3ngui2MTxQFTC4BWqNJygvEKGxd8AJcys1QSaPQYldfoj6SZMGpn/Jg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwecegu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso1619429a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720416; x=1784325216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U9QzBSb/K96NrPSOIb4UqraG+6ddoCjdXX+eTqw+Hf0=;
 b=VZhnhxkJm0ngZWlMO1lWZ8CL1dFXxNH64ujC7MCaMKU+Tcrf8D4CvFwsqHkLPeFWxB
 l2RdvaK3332mISUUvxHckVuJcW0s/TmNCfPVr+N8gZyZ6Hcvw2eUk3qcki/jI8NxEIKY
 izUUk6bae7Xzi/0hGX2unaOneYuObiBhLpvCft/nrwB3yhGPH7Zo7H3etWe9QzoTCPtK
 t/NGWlure7Jwt5lhHcAid/mg7Um7AVI6i4qLP+WXtV0UkRd/NojtSKbmu9Ikavp7ev00
 qK2ClNtZVQO3KapvbvuJKMrRKnwdzYxv6e8CpxlNalezg/HlNAo0jFEbn/2+KLPR9co5
 uNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720416; x=1784325216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U9QzBSb/K96NrPSOIb4UqraG+6ddoCjdXX+eTqw+Hf0=;
 b=h6oW5nrgQicKoHjnE8o38/F8zDUI5b+faJ59Im0lDau9rDtDvsfyPAcJM3vKArse+v
 GdvUHVbkRQe2nwnpowsOacrJmLls0Nwcz/6fYKDpVspBNDNKY6v4Q9d2lVTU9oT9nj6q
 mFHQESovI6NsbmeD2eWbIrqcvz6MwndCbk4o3vS1bGfnWkhISlXpfzz2u5kn1aeyC84V
 hZqaUX3k+b5nPu6FPqMyv27MLDMMoJmeVz0HONM1tCBGyTlC41k4Wv/jb6UxlfgF9UsW
 rQLx91gVYie55SFhy4QY5LSb6WvwG9CJ12XLoavGN6jTAE3a3S/gbpHfj1Wc4vB6CvpN
 U3UQ==
X-Gm-Message-State: AOJu0YwB58RbJ3Mimjq5t2nFhTbdHoo3vl1M6sqbAlgR9kSmk/MQdTBh
 f9ck2Fl+T/l6Ieiyz9/aoGLmrhVlvYs78JJ5mgpSSvU7276j1VMNskjB1+2NO1U58k1wl/wH5ba
 UGPvNDEFv7nvldkjTQZuM6D1dcFzdDqQ5oviOsaOLxG+6OW7nJbvuTwmYhJVQfZiRuw==
X-Gm-Gg: AfdE7cmXpD8lUPl+YRgw7TOzQDXNU1AKzNzD99vt1j6Q5dFlVxrz/HVSqc7xaGRwbZ8
 mthuuCjBAdiYa99kRLUtHK9uIn93t6ufjyjRvwPRqDsEqo0ccBKg11ewpCkiu2agHBHeMqf/OTI
 CiaEIExITqDwlNdPiYyFCZuIYTAVUO9CaWoR5mjTL/POhYp3PYgSSQVLjaTTHphG6s9nFqHRe+E
 fV/DVbweOTFNi2Z/wULoi/Yy9kHwallMoCXaewxdu0mlr4Dyilir/dB0n/NfE/iYXd5vFIH8S+L
 nHe+cI5zd6VmaOgBqfKuqCiMmy6fkYHxzXnNIEtLQO+AEggTZbIS/vKjykdCJXSTRW9wsjaiA78
 GtqwOJgxIirVdZH5tn6OA4j8hIsjTmsKAl6WBR0K/kynaT3RNQX3yl4dYeeVF9cz03NGuvMSesK
 4ba/vcOg==
X-Received: by 2002:a17:90b:3c10:b0:381:cef1:11bb with SMTP id
 98e67ed59e1d1-38dc774d03fmr643150a91.22.1783720415858; 
 Fri, 10 Jul 2026 14:53:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3c10:b0:381:cef1:11bb with SMTP id
 98e67ed59e1d1-38dc774d03fmr643130a91.22.1783720415393; 
 Fri, 10 Jul 2026 14:53:35 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:33 -0700 (PDT)
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
Subject: [PATCH v5 98/98] docs/devel/testing/: update documentation
Date: Fri, 10 Jul 2026 14:43:42 -0700
Message-ID: <20260710214343.2065491-99-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5169e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=7X0MqbEmdTiQuUxmL9kA:9 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXyKxTocQRLiTD
 XEO/I9hB4u0A2W/oZn4gFwcM1PLTjqlfsWC262iiquLJ7rOMS2oZ3fk/uLdu/uPGsSfoJonAw6o
 JPpu65LO3AntFjRICUwPNOjr9cV2AhbPVaGZKrYf+zdn6L+zRq3rlDyjkeMrA02Eve6O/EdEofT
 7j0+PeCoLA2Ykeu6az2HnqSxeME9seAi5Jv2sC2BGGnBDDaB5LyGu5SMfIkt4p/RqUBNlvKpOmz
 TkZkVXE/H5g4jzj6l+bB7r6qFNiPXWcbduCeNBPZd8BjxE95LdSglEPMCZJ+r0vv5sO8VDcFdqm
 mcbMutmHxDHK5P0p4HP6NHGET0vwa4X/ufZ01Pase8oHDVKbWGMx/sX1032fvTkHW+TfkzVjUMc
 wLr/uVHIlV4hSh6aEY+GVwq9PhF6P7RCrUZv9Lekza3K0XBBPaaA3NzTgvOMkC7oZ9iyo1/A7I0
 lLNW9MgRUxwFH5ShxCg==
X-Proofpoint-ORIG-GUID: 0_vEtOmdNeJqOiLQxqzz68Fwff8X2sNI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXx5ZCGWTgzyve
 pB+HBLoEIoNmvQn7tsfkCfwYTv33R/Mmtn4WyPgHGOa5Fmv1JjpYUZEbdSjztNPQ6ipscq6sJov
 SFFnZX1fw9S5wEXC7tgFPIwFhKLoAHI=
X-Proofpoint-GUID: 0_vEtOmdNeJqOiLQxqzz68Fwff8X2sNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
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

We document how to build and run tcg tests with new framework.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/build-system.rst |  4 +--
 docs/devel/testing/main.rst | 55 +++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 32 deletions(-)

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
index c6821a36d99..5a8f9386661 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -1010,54 +1010,49 @@ simple as::
 
   apt install gcc-aarch64-linux-gnu
 
-The configure script will automatically pick up their presence.
-Sometimes compilers have slightly odd names so the availability of
-them can be prompted by passing in the appropriate configure option
-for the architecture in question, for example::
-
-  $(configure) --cross-cc-aarch64=aarch64-cc
-
-There is also a ``--cross-cc-cflags-ARCH`` flag in case additional
-compiler flags are needed to build for a given target.
-
-If you have the ability to run containers as the user the build system
-will automatically use them where no system compiler is available. For
-architectures where we also support building QEMU we will generally
-use the same container to build tests. However there are a number of
-additional containers defined that have a minimal cross-build
-environment that is only suitable for building test cases. Sometimes
-we may use a bleeding edge distribution for compiler features needed
-for test cases that aren't yet in the LTS distros we support for QEMU
-itself.
+Meson will automatically pick up their presence. In case a cross compiler is
+missing, if podman or docker are available, we'll automatically build
+images containing cross compilers and execute those.
 
 See :ref:`container-ref` for more details.
 
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
+  ./pyvenv/bin/meson test --suite tcg
+  ./pyvenv/bin/meson test --suite tcg-$TARGET
+
+Tests can be listed using::
+
+  ./pyvenv/bin/meson test --suite tcg --list
+
 Running individual tests
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Tests can also be run directly from the test build directory. If you
-run ``make help`` from the test build directory you will get a list of
-all the tests that can be run. Please note that same binaries are used
-in multiple tests, for example::
+Tests can also be run using directly meson test::
 
-  make run-plugin-test-mmap-with-libinline.so
+  ./pyvenv/bin/meson test $TARGET-$TEST
 
-will run the mmap test with the ``libinline.so`` TCG plugin. The
-gdbstub tests also re-use the test binaries but while exercising gdb.
+For instance::
+
+  ./pyvenv/bin/meson test aarch64-softmmu-hello
+
+Test command and output can be accessed by using verbose flag::
+
+  ./pyvenv/bin/meson test aarch64-softmmu-hello --verbose
 
 TCG test dependencies
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.3


