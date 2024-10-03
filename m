Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F59CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLtb-0008VS-OZ; Thu, 03 Oct 2024 09:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtZ-0008UD-Bz
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:29 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtX-0005yO-FZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so150445566b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962166; x=1728566966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+mZhMdTyezK+/73TcBlszbUKpA2sHa5X4BD20uLdQE=;
 b=tYxz//udZowDeOdTGSXf5rhA9x/YNC5FYf7gvFkVQaC9tZ6mD/BMtYFAxJC2oKlj9a
 Zxthd/AKG9t63EZ1rxBX5G9BgiIIOv77rjv7RjuBP4In9hnAFN6HIOtUD+8kkTIbggYB
 b1MR/apjKDSnXJqRmjirKeWvNDSDkoAwHn8pBFUMHvBJNXot8Cg56wWfe7R3cvvnli0g
 n74/GrsfttDtSjktaOJPqVV9oW6mF5wQ2uLRM+1RMCcoBgEV+oOB0aP+1nF4++FiS+xz
 Q9B+kjVuGA5FXHy+NvlXnaDB9Nz+gbzBfZAhW8kyQ/qhk9d0PfuliX1Zc/s3Z6hUphpc
 JSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962166; x=1728566966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+mZhMdTyezK+/73TcBlszbUKpA2sHa5X4BD20uLdQE=;
 b=f8k764cfDRQtWlAVBWt1uy1x0bybcGhYDf2OExnf5y1DzqgcncZDDMXh8wZNgrMoUi
 2s1/CXGnXt+h6Gu8meNw9ovdINk6Fwop3JfUT6VRSO8980CbHXPucDEnUwfl7IETlM/V
 Q8tj3vfiZfRmmurHKSpDp9hdvqj7/A/GivQ+zljH3G96FqHXZaCNf8SWLIorH+JR+GkW
 4TqO8A9UIvYbceoUNgcQ4kya7SIHftunLfveEYgrsABj1sXdVq2rq/acGIUOzxrOy9uS
 JAQ2RgAQ1znUva8latYKFHp5xmzO+WPARz9GfVRmafVjbn4eHU0SQCFfGmhPc6BJxSCh
 Uw5A==
X-Gm-Message-State: AOJu0YzYC5Sd7s3I74F+GZnv1D5ozKldMvk79Xxnrdc5kp6N5OiKg0Bt
 IPMDHLcVw+nUOQ1Q7pTCGtT0BpgQxrelvIcMF/uFrgLoX+b8lLrYtvMYI5wvAgQ4RQYPScMy5CK
 e8Fg=
X-Google-Smtp-Source: AGHT+IG3d9BqQ2iUHLcqUfguxnYEjybOGdqNIQ3xPntZLD9WzNZ+W/AkizWzPcXjDcdj1pOOfEKnQw==
X-Received: by 2002:a17:907:1c9b:b0:a93:ae71:994c with SMTP id
 a640c23a62f3a-a98f838a6bfmr627586366b.57.1727962165711; 
 Thu, 03 Oct 2024 06:29:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:25 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is
Subject: [PATCH v11 6/9] meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
Date: Thu,  3 Oct 2024 16:28:48 +0300
Message-ID: <23f7b0cc9801d315f5d7835e30d775e133ec2fb9.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

Rust crates, introduced from the next commit onwards, can optionally use
the glib allocator API and need to know whether g_aligned_alloc etc are
available.

This commit adds a define in config_host_data that depends on glib
version >= 2.72.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 04fd17bb6b..c952b3b15a 100644
--- a/meson.build
+++ b/meson.build
@@ -948,7 +948,9 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 ################
 
 # When bumping glib minimum version, please check also whether to increase
-# the _WIN32_WINNT setting in osdep.h according to the value from glib
+# the _WIN32_WINNT setting in osdep.h according to the value from glib.
+# You should also check if any of the glib.version() checks
+# below can also be removed.
 glib_req_ver = '>=2.66.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
@@ -998,6 +1000,9 @@ glib = declare_dependency(dependencies: [glib_pc, gmodule],
 # TODO: remove this check and the corresponding workaround (qtree) when
 # the minimum supported glib is >= 2.75.3
 glib_has_gslice = glib.version().version_compare('<2.75.3')
+# Check whether glib has the aligned_alloc family of functions.
+# <https://docs.gtk.org/glib/func.aligned_alloc.html>
+glib_has_aligned_alloc = glib.version().version_compare('>=2.72.0')
 
 # override glib dep to include the above refinements
 meson.override_dependency('glib-2.0', glib)
@@ -2536,6 +2541,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
+config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
-- 
γαῖα πυρί μιχθήτω


