Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DBDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5fT-0006na-OL; Fri, 10 Jul 2026 03:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5fR-0006n4-Hc
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:29:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5fP-00068O-KW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:29:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so723586f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783668538; x=1784273338; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e1Uelp51FK0IoYf8lsOFxMV3daGsxrmMJ24Ougs6BK4=;
 b=Sufgpc84v/Eaokg+Z5NF7Y+TjsHRsYjjkV4Dln+RKXBYzYKg/GZ3+aXBnYzxDmMfhr
 F44ovcaJr+YtKhoFblDYfFFeVF5f+8aHozjrRqAoMK0efCU3YSVxGtb7WxsnJdO2SNDw
 XT/tjvV+ZY9JNMsyyQJZamiu3D203QK1bEUJVr2R2nAPt7QE+da7Lzk0gjyIzc3lz4Lw
 gZfDj6hAiZKVV1qwLuBCKm1pfUjZwCmFDzhv0QaXWgOiLniwYWCjK9cR3tFzxhgr3CUZ
 l1f4P8eJLEvuVZz2VOKlxmkjRk/ERQZmxjPITmgrHRRd+8V1gLpH5NHWFjPf9th2aa8j
 SJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668538; x=1784273338;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e1Uelp51FK0IoYf8lsOFxMV3daGsxrmMJ24Ougs6BK4=;
 b=psSNv2dY6o5s6AtSF127svLynz+ocweaqu4zxvoDqExlMIUcgmu3eomjrSbZ3LCj2L
 50F9y3VaBxS4NMNvuDOH0F4k35pfMpFwNQGXaSMVxxrvmRWvfJNSKsC1kAKE/6DVotVX
 GCdc4WPoj8mgAztNTC6HUGrizI99txGYFtcEjqR7DNZedSsJ6ZJWISYzbuuZwh8VfiJE
 2PrU5Eio0Q1OBx9t1YOm/zP4gRHDKNKhy1H2mzp614NMKKQRtExis/mO0rS7ws0zQsOD
 u3qRlxzbCh22JtOApg+qkOBfaEe49jD/vt4sBg798M9dlEsSEUv2jWZk/9gHQuu3M7Mn
 bGig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1qTcoygZ0qlOQTqWpqDcYUqCy/ewV+UtiXWJdk0Fe0SIGSGjuFSQLL3Oygh7HxWprLI7K4znueJ3R@nongnu.org
X-Gm-Message-State: AOJu0YzgXCHgXw5IHT8Ki3+TerDE7qwQXmUcHuCual3+cnHIObAyHCo0
 IHmOKsKMSOKFBdYSCYKOWHg2yFMfuHkzIzNaYvlDw3KvSS+tIMk+aSHvBuoDiV2YCBA=
X-Gm-Gg: AfdE7ckjpSLgJ//JNvrm+QLjhl1vhmo3wV4PPDw3/SUpocXwxXwMAWWT9cqwLRsEqmC
 mau6t1cuUaSlUpP9gplXAAbcXv5FVOABmuGT65IeFeIXjCkjaCy+Lx40H+Za00+ngHdYkK5gu3K
 pkETVcenz/3ubZtD3ytSwjArpt+gYlCC5NNrwBfVhVM/9vTFcdAIhFnW2KZCqSYwZ2rqkyS7EWD
 rK/VFLrZJAmzgL206DQaEZST+IqkQnf/eoaK10JTW+D/Pt2Ui6Jtlm/yDyO/517MzYUAL6kUZJX
 sYQ0hP8BtUuY1m3l45ujoK7oXgBSuJ/CXVYmUTAWw4ti6cKugYxTS031tjauSRB7jQ5AgSqYn31
 0prvny0i3Sj8F4khD2ZUiXbqZQ8kH0+Lr1bMbzkLzAfgaJmnRmKRD1IagFJ9Hu1ocLFo8yeQHmm
 aC0UhPou2oGKuB8H0ADcGkGdk8e89IxIVfxBljESdkTM2rB+e6Lg4bDWnFIYnbhyIjgpiML7rcC
 HfqnKdqfZCP+shJykoOlbgi3ktKnR2vhpOyxKFzMutPX3FpOLFoLRnW/vQvU5OzEuN05CSxySXj
 fILYQcvfrQmb75PiZh3hLuDLt7Qn5WTrhnHLjvcgdQnMQAfHblfpMdU=
X-Received: by 2002:a05:6000:2902:b0:47d:eb17:3bee with SMTP id
 ffacd0b85a97d-47df074e323mr12079518f8f.6.1783668538121; 
 Fri, 10 Jul 2026 00:28:58 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm55176177f8f.19.2026.07.10.00.28.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:28:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:28:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 97/97] docs/devel/testing/: update documentation
User-Agent: meli/0.8.13
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-98-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260710062016.1818125-98-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thy7g8.2u3xwaqe3d2r0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 10 Jul 2026 09:20, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We document how to build and run tcg tests with new framework.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> docs/devel/build-system.rst |  4 +--
> docs/devel/testing/main.rst | 55 +++++++++++++++++--------------------
> 2 files changed, 27 insertions(+), 32 deletions(-)
>
>diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
>index 71331e64ac8..c64d40b42af 100644
>--- a/docs/devel/build-system.rst
>+++ b/docs/devel/build-system.rst
>@@ -447,8 +447,8 @@ these sub-Makefiles, the resulting build is largely non-recursive.
> Tests, whether defined in ``meson.build`` or not, are also ran by the
> Makefile with the traditional ``make check`` phony target, while benchmarks
> are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
>-with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
>-tests for all targets.
>+with ``make check-unit``, and ``make check-tcg`` builds and runs tcg tests
>+for all targets.
> 
> If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
> respectively to build emulators and run tests defined in meson.build.
>diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>index c6821a36d99..5a8f9386661 100644
>--- a/docs/devel/testing/main.rst
>+++ b/docs/devel/testing/main.rst
>@@ -1010,54 +1010,49 @@ simple as::
> 
>   apt install gcc-aarch64-linux-gnu
> 
>-The configure script will automatically pick up their presence.
>-Sometimes compilers have slightly odd names so the availability of
>-them can be prompted by passing in the appropriate configure option
>-for the architecture in question, for example::
>-
>-  $(configure) --cross-cc-aarch64=aarch64-cc
>-
>-There is also a ``--cross-cc-cflags-ARCH`` flag in case additional
>-compiler flags are needed to build for a given target.
>-
>-If you have the ability to run containers as the user the build system
>-will automatically use them where no system compiler is available. For
>-architectures where we also support building QEMU we will generally
>-use the same container to build tests. However there are a number of
>-additional containers defined that have a minimal cross-build
>-environment that is only suitable for building test cases. Sometimes
>-we may use a bleeding edge distribution for compiler features needed
>-for test cases that aren't yet in the LTS distros we support for QEMU
>-itself.
>+Meson will automatically pick up their presence. In case a cross compiler is
>+missing, if podman or docker are available, we'll automatically build
>+images containing cross compilers and execute those.
> 
> See :ref:`container-ref` for more details.
> 
> Running subset of tests
> ~~~~~~~~~~~~~~~~~~~~~~~
> 
>-You can build the tests for one architecture::
>+You can build the tcg tests using::
> 
>-  make build-tcg-tests-$TARGET
>+  make tcg-tests
> 
>-And run with::
>+And run them for one target with::
> 
>-  make run-tcg-tests-$TARGET
>+  make check-tcg-$TARGET
> 
> Adding ``V=1`` to the invocation will show the details of how to
> invoke QEMU for the test which is useful for debugging tests.
> 
>+Tests can also be run using directly meson test::
>+
>+  ./pyvenv/bin/meson test --suite tcg
>+  ./pyvenv/bin/meson test --suite tcg-$TARGET
>+
>+Tests can be listed using::
>+
>+  ./pyvenv/bin/meson test --suite tcg --list
>+
> Running individual tests
> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
>-Tests can also be run directly from the test build directory. If you
>-run ``make help`` from the test build directory you will get a list of
>-all the tests that can be run. Please note that same binaries are used
>-in multiple tests, for example::
>+Tests can also be run using directly meson test::
> 
>-  make run-plugin-test-mmap-with-libinline.so
>+  ./pyvenv/bin/meson test $TARGET-$TEST
> 
>-will run the mmap test with the ``libinline.so`` TCG plugin. The
>-gdbstub tests also re-use the test binaries but while exercising gdb.
>+For instance::
>+
>+  ./pyvenv/bin/meson test aarch64-softmmu-hello
>+
>+Test command and output can be accessed by using verbose flag::
>+
>+  ./pyvenv/bin/meson test aarch64-softmmu-hello --verbose
> 
> TCG test dependencies
> ~~~~~~~~~~~~~~~~~~~~~
>-- 
>2.47.3
>

