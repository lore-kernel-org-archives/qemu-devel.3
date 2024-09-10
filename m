Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABC2EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4qu-0003Oa-VC; Tue, 10 Sep 2024 13:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qr-0002sI-26
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:29 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qo-0004tI-Sw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:28 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so850186a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725990025; x=1726594825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlCj2ixhxM/epvOBESU4I3HZLS9l35ap6tDyuxDs4dc=;
 b=JS5RIiPtYSDrEPH0Dl9bI4J1B5atixhhrbPxalBWNa09lKoJi1ddI2MYe+Dbsow+oU
 Jj1feojV+NBhUPYQDEdzFUQfFenPjiOUeQxIRorSVJFcI/gVS7ryK0l7H2eV2ZFyHiwF
 EfKjz7F02xBN2dsQQ8CFH0jdCbtCEP/FjsuyZbs9EK2uBLDYQ50E7899VPiZJECwtLO/
 1auWxYk0fNHRh5vYfCcc/EhXPkxChJY5HIuOTKmQyd/Xj/h2ngTmUqmojwBnHy4nC4Bf
 Cdl5mrwrFCScKsHrimvR9tl9eOt4d7RF5VI8OavXJA+gfuhmxOabGF8o/LaUs7Xd30mb
 Nkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725990025; x=1726594825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlCj2ixhxM/epvOBESU4I3HZLS9l35ap6tDyuxDs4dc=;
 b=ONyUtFpcuaRLh5TY0+7+nRCyQtm7fZ/6B93mog7MT56ptV5Bvs8zSGT90oC4/q31KQ
 /6M/kYglfsHbZ5A06g6Wiq2xQcBqZWpOu3EMLS/pXMry/2rFZ0+TBGOIrHEvVWI9j8WC
 CM/vvwF2Jk6kWuILVuTMsZ5jxeMbASzaUc57YRVokbjhp+o0/58IOBXcAgZ/kz25/BFD
 rbnRtqJN5p7APyq6pR0XOWE2CP4oIhiMz9m8H17ENmzWIGPt3VMtAIDm6ZVF+LeVJQqw
 agTaEsOYZcEvfR+Lkb5wti6Rv0aKIUtWaFDNRrLGIUbuSsZreZUR1kjMJXfP91ollN64
 9Lkg==
X-Gm-Message-State: AOJu0YylW8MkIMY+Cf33EuHkXzXBg77kw/vCENEA0RxBqVx7pViIC98l
 n2ilJnNyZtwByR1hWbJnik8X8Aa66AwQ8iGf1JYGgjOfK6K42SVLO/tStE3dgDfH1m9a0sRoXQn
 nWN+gOA==
X-Google-Smtp-Source: AGHT+IEDoWGBv7ts4eAbU+3GWSnN9KnHavnhQ7oMRWijIdyG4R93doDvhi7Ldov7owH5gTg/MhEDzw==
X-Received: by 2002:a17:90a:4d81:b0:2d8:5b9f:75ab with SMTP id
 98e67ed59e1d1-2db830582dfmr361931a91.29.1725990025406; 
 Tue, 10 Sep 2024 10:40:25 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966d3asm6682751a91.38.2024.09.10.10.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:40:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 3/3] docs/devel: update tsan build documentation
Date: Tue, 10 Sep 2024 10:40:13 -0700
Message-Id: <20240910174013.1433331-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
References: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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
 docs/devel/testing/main.rst | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index e9921a4b10a..2e57390d990 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
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


