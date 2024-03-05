Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1821C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 22:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcyx-0007AV-J4; Tue, 05 Mar 2024 17:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhcyw-00079r-7K
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:09:54 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhcyu-0000jj-Nw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:09:53 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7d698a8d93cso3517681241.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709676591; x=1710281391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIAUoqwZw8jjQEXl/6GyiIUaJ3twVU9qfT6FoSeBtUo=;
 b=GVQuvzjOg8/ZZhxnyS+eSqCQLBjKDeNAEKTlSNniVeU0gZAZJilJ4QLl8DVW6tc4uX
 xmIv8Nof604PciDkE1hRhU5pnxQ6VYtUOxesYyvGAW4N4OQOcZlLpO1xkqJSBbzCVexU
 XXNcWYJG2o0n4GWr2ABNT77ktb1SHqEktGgvgKpyBOGkNIm5BMBxjlrQFyyTS0QR1vuV
 TI6Do7NTRTPTPbhSMGPFaxKLX9PlJs3slqd2tadgjr/gTe9qgQUZPQPMvUKF5tO6nJTd
 qA2NpMlvyUqDvP7nRVVNsa7VsClJzbgJMKGNq8bKhVm3AC7cf6DmOfmSrKWHXjv/KzVn
 VxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709676591; x=1710281391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIAUoqwZw8jjQEXl/6GyiIUaJ3twVU9qfT6FoSeBtUo=;
 b=eiDVacJAgvAzcozhtS4OMWN/MoA78cJQZmTskQB/Nw3jiHhLnlPQSZJ1U8uYisAtzg
 yXyngrcQnko9tvnDAnE6FfzO5BwiqKyMIsreMlO3mMxrasna5C0QyyjXIWsQVWhXqLbz
 Cm3GJGqAXGe/IUvTegzJ98jEScQQKLeBEONebUO2smR1XRc/9sQglhgjfG8F9dpdiA77
 /woLXdbmiGc1XGutGP2ullfHMocsnl73Rhd932FfFBZmsZLDk1TpSHuXcCaj0HeN5J/p
 xrU5t/czUJg08mtS1WhnogcwSxdGcQ8WgSD8Z/Xi9V4JFxaSDlPAHFgl4JkFIC230KPY
 HIPg==
X-Gm-Message-State: AOJu0YxprilpeDswg16GdkS879wYNZdVlsJRznGA1vXOW0jvEyuJpT25
 S83y0Tvyhk9tQIjM72nFwrXEAW3eFoeFusRZTNjlR0JVyaE8rKU1yFwe4znlKdp9T3tHXeD3pgG
 dnrA=
X-Google-Smtp-Source: AGHT+IGaEw+XaJIT3CpIm8ByBxEgcEZcTCoy7C3krS1BcFFUCp8V/I/p4lcSOTyruOFGP0Skvw5WTw==
X-Received: by 2002:a05:6122:220d:b0:4c8:90e5:6792 with SMTP id
 bb13-20020a056122220d00b004c890e56792mr3806749vkb.7.1709676591258; 
 Tue, 05 Mar 2024 14:09:51 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 m11-20020ac807cb000000b0042e6be98dbasm2997038qth.31.2024.03.05.14.09.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 14:09:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/2] meson: Make qemu-system binary installation optional
Date: Tue,  5 Mar 2024 23:09:37 +0100
Message-ID: <20240305220938.85410-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305220938.85410-1-philmd@linaro.org>
References: <20240305220938.85410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=philmd@linaro.org; helo=mail-ua1-x935.google.com
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

In order to allow qemu-system binaries to not be
installed by default, add the 'install' key to target
dictionaries in the execs[] array. Keep the current
default: all binaries are installed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index c59ca496f2..51b995f4c7 100644
--- a/meson.build
+++ b/meson.build
@@ -3913,14 +3913,16 @@ foreach target : target_dirs
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
       'sources': files('system/main.c'),
-      'dependencies': []
+      'dependencies': [],
+      'install': true
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
         'sources': files('system/main.c'),
-        'dependencies': []
+        'dependencies': [],
+        'install': true
       }]
     endif
     if get_option('fuzzing')
@@ -3930,6 +3932,7 @@ foreach target : target_dirs
         'win_subsystem': 'console',
         'sources': specific_fuzz.sources(),
         'dependencies': specific_fuzz.dependencies(),
+        'install': true
       }]
     endif
   else
@@ -3937,7 +3940,8 @@ foreach target : target_dirs
       'name': 'qemu-' + target_name,
       'win_subsystem': 'console',
       'sources': [],
-      'dependencies': []
+      'dependencies': [],
+      'install': true
     }]
   endif
   foreach exe: execs
@@ -3947,7 +3951,7 @@ foreach target : target_dirs
     endif
 
     emulator = executable(exe_name, exe['sources'],
-               install: true,
+               install: exe['install'],
                c_args: c_args,
                dependencies: arch_deps + deps + exe['dependencies'],
                objects: lib.extract_all_objects(recursive: true),
-- 
2.41.0


