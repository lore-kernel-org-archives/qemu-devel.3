Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93984C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbT-0006Ji-MY; Fri, 16 May 2025 01:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbS-0006I1-Dd
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbQ-0001NX-HN
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2317d94c9cdso16327785ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373243; x=1747978043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqGoY+CilUPAjO+dXO+6qxpClMsZaBn+YNo/aP57Mxk=;
 b=NYo/HDAtRxweDrkzLG7bg/UxrwrXIo1yZGfzHBffiIUHQDhEr8IetP0iF+SWorwuI7
 QL76fRy4069miCmjtmyrganlE0T8cuS6SKCirOAxq0Os5QcGTedH+v5dO8R1zWjBNKcC
 PQ7DFn1FV0obcIu7VsBICpAUp+xcPxms9iKMq4hpAMvZPGsM+nDDKd9aM3t/7fSjFSpQ
 RAZLr3XPK+//CiO0HumkWt05MjtuxRyJehligkKJEoAUUgZyrtsH+5qY2kvFlO6PjZx4
 65Ij+q95ptdIitnBMGuU+qngA6DC5Zni8lV64tBIQvkWFgzuBXot0c2PuvvWLX6D9Oiq
 cB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373243; x=1747978043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqGoY+CilUPAjO+dXO+6qxpClMsZaBn+YNo/aP57Mxk=;
 b=qQDxWO5QX/JULw78AJtp0MMHd7xLX4Ah/Ei1Xqy4ii4XmOQyWcwh3V6ATLVHYVmbpT
 5VH4UQlmaIAO2VoGlqBC00DNl9uShjBqzxSsJAGB0cyUBSLGm7a49yjf/0zTe/xe2bAN
 m2SEpFcFsbfXJuIO6N6U+ue+4g5EO4LEC4iYLUjzP8OeBh3gYp0o9NzG2SsSedSPv3oQ
 CA1RSBoPBU2Ad+0M6fnR7YlnUQ/1BvOTkZydm+lorg/4S+fQwZ8PH8ir/MkwrBFYdjST
 +6bAIyxR/8bLl842nKgYHDKZM40nYQA9YTzuO/C6nUS/cdNlahzVZ7QRFK1AZ8LXCP3V
 MnRQ==
X-Gm-Message-State: AOJu0Yy7CGTB4mUQFgQnozDfttoOYW3lUBB97BK32vCLdtb7gC75Iv7c
 d117+c8UfO7YskMc6nHagIhcS6uJYAuiluQedAo23sVRdPYs24yVKZOYO1HTH6XI3XwAvGALc7U
 MD+BR
X-Gm-Gg: ASbGnctL/eGAd2R29jrdp/QFRT1ola9Sd5wCJPr+GT3P2vGrxSbLDI+HkFsDG4nryce
 yWCfFAOsvPgW/p4pnqTt4LnDfxGDbOQ5MVJ9o+vmLhPGSAS3WG9tZlG6FPX+9LmHRHJU/n3mtOz
 hIe9kGplc5cy0CynaopmFch/UJVOI+Xkjipc30BQh09i1mta+yN8Ytecoxwdq8MumGG/AfA47DA
 gu2KIyyp+3TMU3Dgt+mThcqtsWiSwX78kXn0vGp3NlheQ8ci4JUNTz4vfi43E4BrdAfMUhpnn7Q
 u+++XhP9t2+VSZQOehmBtCOTlqvwRmrE8VvTE84104IrvF92upA=
X-Google-Smtp-Source: AGHT+IHdGcYnD7etgGjPSQyyFm3Ma+Ccyjo/gTj3QPh+peprcRePm5WJ3NdSJENJuHpiHdQ3OcU2Pw==
X-Received: by 2002:a17:903:94f:b0:220:ea90:191e with SMTP id
 d9443c01a7336-231d43d9ca1mr25398015ad.4.1747373243077; 
 Thu, 15 May 2025 22:27:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 6/6] meson: remove lib{system, user}_ss aliases
Date: Thu, 15 May 2025 22:27:08 -0700
Message-ID: <20250516052708.930928-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build           | 2 --
 accel/tcg/meson.build | 8 ++++----
 gdbstub/meson.build   | 4 ++--
 hw/core/meson.build   | 4 ++--
 plugins/meson.build   | 4 ++--
 system/meson.build    | 2 +-
 tcg/meson.build       | 4 ++--
 7 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index 98b97fd7ba3..7aca61a1e8f 100644
--- a/meson.build
+++ b/meson.build
@@ -3712,14 +3712,12 @@ io_ss = ss.source_set()
 qmp_ss = ss.source_set()
 qom_ss = ss.source_set()
 system_ss = ss.source_set()
-libsystem_ss = system_ss
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
-libuser_ss = user_ss
 util_ss = ss.source_set()
 
 # accel modules
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 97d5e5a7112..575e92bb9e8 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -18,15 +18,15 @@ if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
 
-libuser_ss.add_all(tcg_ss)
-libsystem_ss.add_all(tcg_ss)
+user_ss.add_all(tcg_ss)
+system_ss.add_all(tcg_ss)
 
-libuser_ss.add(files(
+user_ss.add(files(
   'user-exec.c',
   'user-exec-stub.c',
 ))
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'cputlb.c',
   'icount-common.c',
   'monitor.c',
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index b25db86767e..15c666f5752 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -5,13 +5,13 @@
 #
 
 # We build two versions of gdbstub, one for each mode
-libuser_ss.add(files(
+user_ss.add(files(
   'gdbstub.c',
   'syscalls.c',
   'user.c'
 ))
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'gdbstub.c',
   'syscalls.c',
   'system.c'
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 547de6527cf..b5a545a0edd 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
@@ -46,7 +46,7 @@ libsystem_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-libuser_ss.add(files(
+user_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
 ))
diff --git a/plugins/meson.build b/plugins/meson.build
index 5383c7b88bf..b20edfbabc1 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,8 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-libuser_ss.add(files('api.c', 'core.c'))
-libsystem_ss.add(files('api.c', 'core.c'))
+user_ss.add(files('api.c', 'core.c'))
+system_ss.add(files('api.c', 'core.c'))
 
 common_ss.add(files('loader.c'))
 
diff --git a/system/meson.build b/system/meson.build
index c2f00827669..7514bf3455d 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -7,7 +7,7 @@ system_ss.add(files(
   'vl.c',
 ), sdl, libpmem, libdaxctl)
 
-libsystem_ss.add(files(
+system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
diff --git a/tcg/meson.build b/tcg/meson.build
index bd2821e4b54..706a6eb260e 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -27,5 +27,5 @@ if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
 endif
 
-libuser_ss.add_all(tcg_ss)
-libsystem_ss.add_all(tcg_ss)
+user_ss.add_all(tcg_ss)
+system_ss.add_all(tcg_ss)
-- 
2.47.2


