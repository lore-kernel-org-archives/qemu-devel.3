Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD570C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPrH-0007LW-Bg; Fri, 24 May 2024 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPrC-0007F0-Mz
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:00:54 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPr9-0006yF-9m
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:00:54 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2bdf11888a5so1046376a91.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716537648; x=1717142448;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pCyAlcRJxBXr8WBNFU9VvAlTC1A+jWOc3+UmKJXMUEc=;
 b=ZV46rBFtSfXBfrWlf8UvqBv5go70DfGrvUVCtb+k3Tc2FLXUnQ9KboOnX/7zkoGAmf
 nscNHOJXBpQRO52ER+O0cYn78BgNXE3JzEPv8bu9ipGfe4WRjARhSEAXVHUo0NGqgnDq
 ccVcseXdSPbpqim35MNy4nyWvkXL3XsVB1RuTw6g23chgT5IaGJv/PVl5C8wZkoOEf/J
 Tkh8066foAqHsAbu/rtDX3RG9fsE8KMG8ONzh83NqMwNlroJ1shcFpVVpKggQLA27Kgb
 g91VtIaaQ+KRT/Lwds3IrzZRhkSDYJH1oDg7uVoIRrh46wJ5GajM7ppHWEyqqh/uskBj
 MNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716537648; x=1717142448;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCyAlcRJxBXr8WBNFU9VvAlTC1A+jWOc3+UmKJXMUEc=;
 b=t0zAs+CkQ5mOUmhMyZ6ihjhc2vQabhBQ3pYz+4e9Eg+wXSildzTKAlGXyeOalTN0uS
 5axVXPCTec/kYUv+lRSIFnCaoZ2VfZf3FQ47KbQMAawteNt4W2U10YMcihWaDihYiGX5
 XYj1ubyGeoqJSUWhBaKeX1d9g8psaW5dbO9HEMqPCkPb0+Sajx23k7HV9Y6Wk6xxaDqj
 BXgX8/csCL77Wt4QKdEEdslv43gu/AUCgaj4G75ILZVN/0KENzxRxNC8u8Q3cPxy7xZ8
 7dX7PoQ1gC0x57w1AB0gipd7Rxejffuv66jti5E5rofNIJeJm0pHwWEbUcK+IR2NL8H9
 Z0Ow==
X-Gm-Message-State: AOJu0YzjmKn/dlu2n5vjXgTvCmSMqH/DA0NiGkhHd9L247jz1OcV2/xp
 7FLIiIUMP7mNLgI+9Esh7cfgLO3/RsOZqUI1ibSxSwaOAYgWoOdAJajP0fiCbcZZMucZYa7sgWq
 xDVI=
X-Google-Smtp-Source: AGHT+IGBzXhsz59zLKanqwcxaXfKyJqLnPS5mqVuvp80KVjZpLChckGRyWEngY1SDJssQMxD7i2c8Q==
X-Received: by 2002:a17:90a:e2d2:b0:2bd:e68c:b0c0 with SMTP id
 98e67ed59e1d1-2bf5e170f33mr1453691a91.20.1716537648255; 
 Fri, 24 May 2024 01:00:48 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2bf5e13b6acsm846398a91.0.2024.05.24.01.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 01:00:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 May 2024 17:00:23 +0900
Subject: [PATCH RFC 2/2] Revert "meson: Propagate gnutls dependency"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-objects-v1-2-07cbbe96166b@daynix.com>
References: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
In-Reply-To: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-2c6f2
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This reverts commit 3eacf70bb5a83e4775ad8003cbca63a40f70c8c2.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build                | 4 ++--
 block/meson.build          | 2 +-
 io/meson.build             | 2 +-
 storage-daemon/meson.build | 2 +-
 ui/meson.build             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 0e6fa2e4b777..cd5a24807ec8 100644
--- a/meson.build
+++ b/meson.build
@@ -3518,7 +3518,7 @@ if have_block
     'blockdev-nbd.c',
     'iothread.c',
     'job-qmp.c',
-  ), gnutls)
+  ))
 
   # os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
   # os-win32.c does not
@@ -4008,7 +4008,7 @@ if have_tools
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               dependencies: [blockdev, qemuutil, gnutls, selinux],
+               dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
   subdir('storage-daemon')
diff --git a/block/meson.build b/block/meson.build
index e1f03fd773e9..0165ac178370 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -39,7 +39,7 @@ block_ss.add(files(
   'throttle.c',
   'throttle-groups.c',
   'write-threshold.c',
-), zstd, zlib, gnutls)
+), zstd, zlib)
 
 system_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
 system_ss.add(files('block-ram-registrar.c'))
diff --git a/io/meson.build b/io/meson.build
index 283b9b2bdbdf..1164812f9126 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -13,4 +13,4 @@ io_ss.add(files(
   'dns-resolver.c',
   'net-listener.c',
   'task.c',
-), gnutls)
+))
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 46267b63e72b..b955949fd6f3 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1,6 +1,6 @@
 qsd_ss = ss.source_set()
 qsd_ss.add(files('qemu-storage-daemon.c'))
-qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil, gnutls)
+qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
 
 subdir('qapi')
 
diff --git a/ui/meson.build b/ui/meson.build
index a5ce22a678ba..9358439ceeed 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -43,7 +43,7 @@ vnc_ss.add(files(
   'vnc-jobs.c',
   'vnc-clipboard.c',
 ))
-vnc_ss.add(zlib, jpeg, gnutls)
+vnc_ss.add(zlib, jpeg)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
 system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
 system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))

-- 
2.45.1


