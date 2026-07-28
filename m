Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0C7C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp7-0007ge-5u; Tue, 28 Jul 2026 00:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoZ-0006dg-Cy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoU-0002b7-7p
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aXT51714754
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wA6SVL1jEnrYMkjlxMgyaKGyMI0ytUyN8YKu6Wo6XtI=; b=G2/IYLc25OZbXXZF
 cX02SzYM5sm2bdIcxIpP5IeVoNm11saZIX0zzmHvN8hJ4mwwdfelJUNDlLd2s9k5
 GFmrH8JQ2wtEcPIG8RzVk15wzEFx3K7Go9HmoD8lN9VwzYCAbCELeyFrNcZDZlbv
 cWuu97SIpdnA0Wx5HEDTmyLX1lW1GoBHYujxUnONwMnA6wBfcwXXYUBWNndtSAWj
 aBoz/234Jx1y8AlmlKJgxTMAOhqJ+8ofEh9kZEDs0iecMRiAC0xJly/IvI9CB+Iu
 5nhDYH+oUtPkDtspIoainoeEbmrhGHnl34RSFJcwnNW54SE/PrDYga6HGxnE3HE+
 5DCVHg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkk03g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab041eced3so4592107a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214378; x=1785819178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wA6SVL1jEnrYMkjlxMgyaKGyMI0ytUyN8YKu6Wo6XtI=;
 b=AQH1rtWXvocjtECsxnuUtVFknWEQirsqpry1ZtcoUzaM7ItyZ8TSLlrYx7uAsq0+wh
 s8oZB4+vVgT6dUCHJe6Z2bPvlhuHR+Zbo4sB6xFFe/2sgOqf14wd3CadxvLvUrfwctIt
 Ex2frBg3T7QqlmbpJ6dGjqZnVkcIX1mBCuxUuQJUoRrgmG4NMqCcoHj5mMXwJAJqGKGH
 nsWrXvHPLH5i4ZHKQVIYLHiQdShIMBfg8S29dpsEDixtkd85NklZ1MQ+a6Sap3fFwiZ6
 znrX9RTmkJzAxtErEYooUdSYegdvxSNK0y9Z4Do1DSJa6lLJAoaQP8KE+p/29jQfMqbz
 UXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214378; x=1785819178;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wA6SVL1jEnrYMkjlxMgyaKGyMI0ytUyN8YKu6Wo6XtI=;
 b=MADmcVVuBPUMnq5AGzs8ZfHfCVKZxNi7I7w/cjrVZw/FUzTUv+MNg79EpA8ehDwmQI
 +iLj1w2zY6DT1sVOtpyO1g41Y4lvXNhvEJI5dWyCncDZ71kmFM9eFSsLwW/axFzdbxZ0
 RWe1F1nA1hOiLt7esPK1fao1CrCRFazgIeuSSJSRKjT92JhGDRANf+dA3r0byvGxhB4F
 jD1BRmf2MK/BqWmz1iW/Z3RyarKPPnBz2yI5JqI35AfLGBq7vjD0pTVc7ZWPbespts49
 4ImV0wXF3fYgML7o8Ne97TeDgYplvsqaZa+Lz6+pkcSYHdn/FtWeIdzqLDBWyRWB7vAj
 CUSA==
X-Gm-Message-State: AOJu0Yy5/QW93QB9X+s3/LhuUJESuv/DO1saQcsSjXhyWS1riq0pRP6C
 3mlZTVFPr4PY4pqMKdMmOw0xc5WseYJMx/04Od/AtAZyBjIKiwOjiRuYKHJQqgcEwXQea4H/agL
 /b7LovM8fa+75GVzDBGMAFx1pVV6Ss+UF4Z9UZU9rlB1wXp/rGvc3j/XyJbxo9qkhCg==
X-Gm-Gg: AR+sD11auuncsjtJgs6q6/LP6b4Zi3ylGWhWhI2AcXoJ1OZcbyML81DQkzdQ2J5gjpT
 p1YNEj8KtGov/RVZgV7YSW+f6+qgEDVKjQ+Va2JED1xZ+iGjdsm5fXk+dcUri4xFQ60Lh2q6r48
 iiZIc1Pk9VTVU4Dh2nYZ1G7ikxnaX8n0IIG1E6AdWp4BvhdoSVZxBUWuj5NAmeJmRA3jAR3t+Nl
 7ydYRKedSrN643O2oupG339qKsMLL7eN1yks3QI+NYxBm6ieQjZOQfS5kVqvdtX8ICYofik2Z06
 mluQSqi72J7ujwq5pMtIbC+pmdtCZ8yll9yr7/z8eNidQkNM6Yb90DoOMu3wjP9fqVCtn0i5x6K
 5gH8eHLIkEZe2DyZK6f/DjZlduHRCTE74jlLDYaiA/v2ZzA+e8Hi6dS5LYVCvxQncZe0qqao=
X-Received: by 2002:a05:6a21:e0a7:b0:3bf:6c08:fba2 with SMTP id
 adf61e73a8af0-3c8ba5ae742mr1287266637.54.1785214378210; 
 Mon, 27 Jul 2026 21:52:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:e0a7:b0:3bf:6c08:fba2 with SMTP id
 adf61e73a8af0-3c8ba5ae742mr1287234637.54.1785214377734; 
 Mon, 27 Jul 2026 21:52:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:57 -0700 (PDT)
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
Subject: [PATCH v6 103/103] docs/devel/testing/: update documentation
Date: Mon, 27 Jul 2026 21:42:47 -0700
Message-ID: <20260728044248.137626-104-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vWoNPwNA0qzTq3_ldELeZvZKqj5S_hmK
X-Proofpoint-GUID: vWoNPwNA0qzTq3_ldELeZvZKqj5S_hmK
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a6835aa cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ka6hOPz7-XPfh0ZDgTkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX9OBidFYe+yfI
 v4/izXgl8XWfbQmdu2h2ezyYrwqIN5ds/AR6r+GYzXnSkh3HcqfAkJoDLZ8rL1bj0LPMtx2uTlH
 1SddT3t1RaAbbjxO+wXoBwRo9dDLKvWasoj0KQdyE0eMKpuECnVZ6nZrUuft9m4I6x+EENIaMPY
 5Et9f7rGCyRYJGrog+gumISJhed8hswvtvuFGotDEznhMhfuH6D7KbcCIQ6DXoNVi3hzfZ3Rpu3
 YbUG+oj/4bM+QC9pEooR6XComlPQyZrb5fejvNj/1EsQeDYUjfdvwNXyL2Rq7KIRVGO0l/hBuUa
 xkBSssudtyy0r9GpXqCpYF530xFsbrdJPRKNzqjKDQz1yPN0ZWUxr+qkN9qOup3TR0pKVIXUkxt
 AQiTm2V+pJ0zX+G+F6SaTNdRIq8/2Q6Y5VIpGGLOh6jJfi9BMp9p89G6q+ELnPCe1ubyOrj1Ndt
 bFbpTrHEp3wKlnOSmsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX0FC+EMMMBC1H
 TtzB8G77frDDSKGSV+5OXJ7qgRLph9IFm5CbKKUYc0Vqe2OvQ5P/0Vm5GXohxuoUKRrg6uePliH
 T8+ZCaFwsuLJZ3Urqq9tCjb7Lw4QBXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/build-system.rst |  4 ++--
 docs/devel/testing/main.rst | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

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
index c6821a36d99..9cbac144fdd 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
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


