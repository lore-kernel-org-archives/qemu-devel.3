Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F09C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMgb-0002Bb-LS; Wed, 14 Aug 2024 18:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMga-00025j-7L
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgY-0007MF-3N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so3563805ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675301; x=1724280101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJho7r2KSIGZArJtcY0/tQGk0chbARupwvgFA11PnCQ=;
 b=JVxdkMoYel9RVeqopVLQ2iRIOhWom3bCyiVWwV2ja6LbKNnn5AD14/H0iYAC03fURo
 i3Yru+g26uG3gpgWqywVbL5p++TOmftESo1rroAQRoTLqWJP63EjaKDg++CT3B4XXs3b
 1xCh3+EiRDo5pKqfe/GGzN4tbbwR5DItHc3EXMtFid8QtxNrRdsGj0y50kfkHxTPvxGg
 x1CdKp3CODGy2DjuY0nQj+V29z+oKBaOxUKDr3Kv0Je5UwjCzNx8wmxblg2FwDyrmfQx
 vrKVZlNdDVR7rKxRisSwLR/AzeOBAMXqbFSYoqes13v1dAGNze5HeFHtkGdkszECoOjC
 Sr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675301; x=1724280101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJho7r2KSIGZArJtcY0/tQGk0chbARupwvgFA11PnCQ=;
 b=rspFR3ol3AeOTVnHkNTGi22zZnxqOEM2uY8D8u42M4Bh77Y3C4jSCarU6pdfjHugJg
 ta5RoplW3n5oW9BBhCSqAB/ZKZuRYJ3fr5Gp6af9KxJ/CdQ9p4y9hoZRChcQ3vC8U06t
 2/eEUK6cmQLMlXKHy86QlMVbCTRVdCidAyqSJJkEeoSL/CNSdSpMjwR7GVxd9ZeZ7Z5k
 I/zFwnO7BjTnW2YKG1DU9ztNeed74EKvlCCTeAeNVVCEIl4pS2BMHi4+isKLHlbmDIP1
 De5XjeEe8elGJzumR5Ma/2uljdNTwfT2lRHBQiR8Ylhsl6I7BwR3n8weLoeMNNkHKC5z
 L9FQ==
X-Gm-Message-State: AOJu0Yz/OCRqvKw50OY2R4r2HjVchVY++iNFVmROdgSQ9dHafUQptvy0
 /DAXUxW6+P/QEJzAGY1TV1EmcTE2AVc+jL1b4VFjRTRtqs89aTYazCQoF1MYPtuOEUUtksL/tZl
 F/PM=
X-Google-Smtp-Source: AGHT+IHfpUHmltRgG/gVjytdo0w2YyJNJqcCukrC0Pgjx2S3EMn+ubfqhC4bAxsC2vTGIUfXWKdtyQ==
X-Received: by 2002:a17:903:11c8:b0:1ff:49c:1562 with SMTP id
 d9443c01a7336-201d64d8afcmr48133095ad.56.1723675300659; 
 Wed, 14 Aug 2024 15:41:40 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03b2874sm1225595ad.308.2024.08.14.15.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 15:41:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 4/4] docs/devel: update tsan build documentation
Date: Wed, 14 Aug 2024 15:41:32 -0700
Message-Id: <20240814224132.897098-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mention it's now possible to build with gcc, instead of clang, and
explain how to build a sanitized glib version.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/testing.rst | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index af73d3d64fb..f10cfc3f786 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -634,20 +634,38 @@ Building and Testing with TSan
 It is possible to build and test with TSan, with a few additional steps.
 These steps are normally done automatically in the docker.
 
-There is a one time patch needed in clang-9 or clang-10 at this time:
+TSan is supported for clang and gcc.
+One particularity of sanitizers is that all the code, including shared objects
+dependencies, should be built with it.
+In the case of TSan, any synchronization primitive from glib (GMutex for
+instance) will not be recognized, and will lead to false positives.
+
+To build a tsan version of glib:
 
 .. code::
 
-  sed -i 's/^const/static const/g' \
-      /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
+   $ git clone --depth=1 --branch=2.81.0 https://github.com/GNOME/glib.git
+   $ cd glib
+   $ CFLAGS="-O2 -g -fsanitize=thread" meson build
+   $ ninja -C build
 
 To configure the build for TSan:
 
 .. code::
 
-  ../configure --enable-tsan --cc=clang-10 --cxx=clang++-10 \
+  ../configure --enable-tsan \
                --disable-werror --extra-cflags="-O0"
 
+When executing qemu, don't forget to point to tsan glib:
+
+.. code::
+
+   $ glib_dir=/path/to/glib
+   $ export LD_LIBRARY_PATH=$glib_dir/build/gio:$glib_dir/build/glib:$glib_dir/build/gmodule:$glib_dir/build/gobject:$glib_dir/build/gthread
+   # check correct version is used
+   $ ldd build/qemu-x86_64 | grep glib
+   $ qemu-system-x86_64 ...
+
 The runtime behavior of TSAN is controlled by the TSAN_OPTIONS environment
 variable.
 
-- 
2.39.2


