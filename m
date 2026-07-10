Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFEAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4ly-0006kI-G0; Fri, 10 Jul 2026 02:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4li-0006WV-2k
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lf-00076A-7N
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mshq3707439
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RI1vDf0kemO
 DI8SjYbEKAOzATmKjoLm05guA8wuVLqE=; b=ejzytkQOlQXBqmQ52xJkVoTeWd2
 y5OmHl5691sfI4PH5tQT+Elmcr3HPCao+iF9z2ekbmUqm0rXrLw8TDzzy8Yo7+05
 paCV9pNFvV2Fu+SSDqDf2NqpLc3qckvyGTUKPBPiSbJJzQIraxS6jUyRDsi0I0mI
 Ee1sYOg18M9fdNZgLFOxUTlv8Xg4GuP8rREfQW5QUIbyyBH7DwCez+fNfM64ktjq
 6UToaljXCg01Mi3/maG8F1DQzZbRpNfKX0ncCKL3GktxFvdYzoUDYI9ISKWhPi0f
 Q8PezIzwMFWAp1WnnLAF+Xyczb2Dz8KIqmwTAc37QDamNLDIND7li7y/xqg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5k4ju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3810960140eso1244881a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665081; x=1784269881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RI1vDf0kemODI8SjYbEKAOzATmKjoLm05guA8wuVLqE=;
 b=XyLvo8HznEjFxzELkpLMwYUJdBRc6T8K93glr1ggG5WdYXKrjzAzUMv0vtuZg5B4HS
 ebnAZcSGCtliCH0alIRQKNPXLMGHQbtbEGeGXQTumfX7J9DqlEt8I64eDu7ZFcz00Pf4
 F0p5b4txjdaNmS/+bdgbmyCyCYmVKPKaVnwtc9NEn8cc++P4HwyhqMD30/VCuJynvnoG
 2/yrQ5uYQ0Z2SNY1qNrGPmeMEqifRaTTQI1cw9HFXSbTd1fEBbHsQpryEYkIXqkuhrHL
 uydhxtmsqVgW+x0oEXxCiN3dQn4s38P5b55sEufySkZUGxWQ8N0aQOR5uSA7qrSe9onz
 vdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665081; x=1784269881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RI1vDf0kemODI8SjYbEKAOzATmKjoLm05guA8wuVLqE=;
 b=LfynqxVUl6EPLzmhwgZOKZhhj8rvZ3zi7mSNiqM+j6Oj+0SECSDdKrI2EF/3NvswXn
 iEwcREAvy5gIkFNxO539BK3a6qHgwiuGF50/CU0KddFYS8DCk/PUTbAbZqsKAEasFtOC
 /tHhiOCs5t5MbTrpBdizVEKvjnXOKLyti0KYR5fwyrF7uQEdXG8DnEgQJlyXZNEbvhoM
 tSMYUtiymX2LCH5pkPkxnRaQr1QpFoJOIZEMNeK6iUqwewfNmbRdxib7rootrMnB6hTY
 6mKpwmkGV1VDG1Lx8VMe5bYU+ML3wevPt+YXx3fLCdou10fSr7Q35MbIEhM4cT3A5t7y
 EAxg==
X-Gm-Message-State: AOJu0Yy2jZviDQyMbf4QDgfLjm1zsEFhJbtCPjsx0s3nD0Li61WqZ5ZK
 fzzackROtr9TCQmpXFyRX8FcwxrF21ATxjjO8iSVyboFkNzNXO2YwlCWznsa3MH9XYtDqk/Tz6m
 trvbE/i6wFbw78L9uGn/MjNvxgFgc0QfaXi/C0qP4uhcTAm9Ta4a29Og4lzIxTSCksg==
X-Gm-Gg: AfdE7cm3dxQdJIH0zbrU/WIeHqcrxo/4dfMCCGrJDfmGxNsyblj9LeNo0HvRC+41SO6
 dERdrK4w5rHmdZgqmeFhACoUOcz6bk7V7S2N4DDSe4vRHSx0ldwQ6EJAA4poKo9H+h8wLe+Sgqo
 EAqiQVtxLZ7bq1FeDyTxVtqECdk42mniCkFLnBlUzNhAnqroyz9cPwYre1LKx3nHG5dSdc/tLMQ
 7fnnTjKkErmnTE9LESYlQV2CodegSDUU02Dl9vCid8We91TdDm+zJf0qKHIsBtmrNKAYWdE1jgL
 KkfHiG6awEHV94dqcZO4czqR6s3YkoaKVsG+spuo1MaYKnVws6bGZRqQ2+HrRhTPiBiZ+5i7bX6
 t4laNbFTKojQlyzv/fNTHPCEbpRqRwAvvtPMMYYP4Yjcr+lFFm3OaPZRnz7BDuu1K+oOK18CT8R
 j7wbRgPQ==
X-Received: by 2002:a17:90b:5845:b0:37d:f0dd:e715 with SMTP id
 98e67ed59e1d1-3894024d8e6mr10789698a91.10.1783665080695; 
 Thu, 09 Jul 2026 23:31:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5845:b0:37d:f0dd:e715 with SMTP id
 98e67ed59e1d1-3894024d8e6mr10789665a91.10.1783665080111; 
 Thu, 09 Jul 2026 23:31:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 97/97] docs/devel/testing/: update documentation
Date: Thu,  9 Jul 2026 23:20:15 -0700
Message-ID: <20260710062016.1818125-98-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a5091b9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=YpncbH2Uo8ONTwpeAikA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX1908mRmv320A
 LWy99s8357bq3xQ7fnE+W1jguUYPr6+Jea3kuJ+CfCLQLhlzI5F4Uhk/xwMBcPlld3il/IpO48J
 JMXLRDJAtfY1qgoL+UTp6gFgwQVtl60=
X-Proofpoint-ORIG-GUID: 5gGrETOZcF3oXbCrG-WXWFFe8oBgiDL9
X-Proofpoint-GUID: 5gGrETOZcF3oXbCrG-WXWFFe8oBgiDL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX688WO+Sy/c2/
 ZtLzNsHUWocMwPHTPZXQQXnw2yxhy+eYfkfUgGKjyWE9zhsNC0pXZIieYXJ/FR68EJG3Sb8Y9j/
 fD86VYaw3f5TiOcN1wWiVeUPLyG48tBfDpn/DjJPvQxd1jeqbiZHiGUt9zFuwQsUgluJJpcZpB5
 cgOnqdlNjTv3iG0bTS+w6QrvdQUY1P+oYVO3c4exmp558/sPofJJDaUMsL+7uPH+5yELugUtMnh
 NSFhQnsz9NnXuOXzde+qatJzUdNnSBNFByguT+Cv9XrK11AjzvQ9TGX2m3+Z1AwS78tq4y2NAux
 08DbWzP4/xGw9/PBGgdcDZNUyyJ6ApuZXkjvLDZilyyrCzYtC+QlddjqOPTFXrWrDLsKw988RMn
 qJHAMR32GB0OVIjUlWpgTQjyEqZ54RkQU5QqmbnKGnXmzLqJa3JfgVvxoLBt0J0ix7r8P+8mXfG
 U9OkVEnXwl6zsC/gsXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060
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


