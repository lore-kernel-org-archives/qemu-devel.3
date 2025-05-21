Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ECAC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1K-0001W0-A7; Wed, 21 May 2025 18:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1G-0001VU-6V
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs18-00050T-Mr
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73972a54919so6841899b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866867; x=1748471667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ovqoyh1Z07q6U2ncxWKFORWZC8MsNQ9STTasIkxgjnk=;
 b=dRJdoAIqakLVGERvp+VkC6S0LLzWkjl6g3k/rCOOzTynRcZ3aHTMB6Cyba8gmoEXN5
 DwYkTS7H19Y7+EolXWm26oSflUJw5moXK/2JhTG83xcR8ktGPoGfEXvvVExsAPGX0loM
 EFj3IWejaeaiPQ4hb10UfFjMYsUHhgUTJmTmoPGv75xQEZzx9jVs7+dbGrZHPGsRA98N
 t7YXAMTRAcLFAHuPOHrFTNEJC0mt9KKEs+35U1abXLMGsRoK9q87xdsxN5QGcpwLiv3g
 KPZJuyUyQH1Td8BEpe8ex2B8dQLlj/pm80NLUMsRs9E6r4tVl3CNzBMeSbS6NZNd57ne
 4cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866867; x=1748471667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ovqoyh1Z07q6U2ncxWKFORWZC8MsNQ9STTasIkxgjnk=;
 b=fpjb0OVlHm9o2K+PTYJm03UHygE1oN08F9vTPXdCmTHv4h66Tqdx/f89G5i75+BALU
 tbdpMSZ/weSzzSRZfCSF4nudcmoVnM/32gsHPXBNyAOqsdHVFH7vqEzG1eddrRSW9r1K
 UAtka7dRIlqSnFoqC2P8/Q3/f3ZYIO/ZpP0v+rCDITndAsQexeeCDt5UfZaVupMrO6Zp
 eqLIwwAwShA7MFFm/4TVxPwtPUKDNHoPE6EwDMY9cllALh7/KkuVi8e9BXLy4WTLwgVM
 R4WZQMx3BzzgUwMQDISBLYN1c4gciBGdq6OuQQLiqU6eYeGfGpfJZQ5RadrmyTRTxULx
 FMqg==
X-Gm-Message-State: AOJu0YwayJJPQ/jwpWJzJP1rBgWWSdCLNS4E1WYGQ3VwAuA/NXUkFSen
 7EbYxAGMzCDsIvbJQdCcWDp3RN4/TZ0aXWj7RfDDhMaYCe/6NdCZbnyKL1OAbuC49GEkYQmveiP
 epYHc
X-Gm-Gg: ASbGncsChBzASuHQF4pqRgJPMV6xaMcfba8nycHjfY3JwfsXSEoRctgHtNP/zqerTl1
 Wb9P0HkRYDwUKRWzH0Sn3e8VOeIoBKdFSJC3bXF7G4maJBHyQSD0M88L+rIc5CgaXIY1YSRxfrw
 IVXIxg5w6bKvCC/S237n4/Rt4GhOgpyBxbS5jSJ/jljkCjxMOvfMLJZbcppIkq9IvqNHJVDR5UP
 oxW7hS/bZr6R053enCQjG1SPl60MZkPipKxPmaeJ+bXWSrURJQ5wMlIDoO2IW3cQF92hHGVVxkb
 p+1QUzA5T7nwyIgZRxkh4yL+XpE5p6KAGPHDaBSE9hEKcmlfRyA=
X-Google-Smtp-Source: AGHT+IEa3Rqyn5MeyANSf94wB7yrKHXf4hzFFQQqXQazKt/PdQKCN5j4GMGaQHhJSAqgCHTQxaoveQ==
X-Received: by 2002:a05:6a20:72a6:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-216218c643fmr31166007637.10.1747866867088; 
 Wed, 21 May 2025 15:34:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 6/7] meson: remove lib{system, user}_ss aliases
Date: Wed, 21 May 2025 15:34:13 -0700
Message-ID: <20250521223414.248276-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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
index 23815c916cb..087ce7dd20d 100644
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


