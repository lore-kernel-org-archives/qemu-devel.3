Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E365C4829C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwN-0002uX-C7; Wed, 07 Feb 2024 11:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwL-0002tP-Ux
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwK-00068O-3u
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40fc52c2ae4so7330965e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323902; x=1707928702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM5vrN0Mlz2zZCFNsOvOH4Md1jU+CHoqT++QO5pSQvE=;
 b=Dv8Ut1t3diR6G97LfsvjCNnKcaKw/2qnmaaGSUtBpzlbQBrOYuISqhFjmmlW2JCer3
 Hfyt8rdvVB9SvNtKES7wp8WLph9VNq+MDBfOL52xoWagGAVVFTsZRiNEuNAL05vgraAc
 vSbs16hXE0z8+x5bNeOJYV+EAqkMqTm+yO6ZByMWmd9AojdUHXHxjdCHw5EymUHlWaP6
 tm+xnQqA/0Ur2OCLphxhwj3+NX97JPrLdoiklpdZHpUn27QEt+hJqJA7jDcO8I+cI6D1
 z/vN51HKtnfYvvxL5CpIlgrboSNBRJVgjHBds/W0tm4rCkF1xZX+N7SFCbH8/APLz2Tb
 aEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323902; x=1707928702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM5vrN0Mlz2zZCFNsOvOH4Md1jU+CHoqT++QO5pSQvE=;
 b=FKwc6ThjN1/0gJ2QkBryWvb+fymqWe9BsFzvJHHCQD6CzSze0fujt1JvRqPg92mr+Q
 0bZAZBQ3F4GOHpZTMb1eYahMn8QXYlhv1/V3NVn/+R/fxDkUo3uNxwBOSJnVEmnq6AKx
 iYh0mMel98jxWUTVRxmV7L5nWedNm81ObSORcd/jjxRMgU9AkKhU/NiLsxUSPYlpFVMI
 kw34ZqxGzmgUtyjTfn8VPSnGtrbWNP05DXJKLEgueqXbvZJAHzJ5W27PNUXUwFyXtaU+
 0SOQIs7b6nsIWD+CAsKNZpjoqMdzBpnsHXaEci9fOH6XsjUSmBjmd3XUOYTqtYCEONrH
 EbIg==
X-Gm-Message-State: AOJu0YyPu9Ors/T5srY6R5IB0xZu5CEuwrQKuQ2XT1dAHqyAkOhFgo4H
 Ve77B+jpMXlnG90e1TtPBoticzTtpQa9DXtwiy86XNcVuDhzCj51F3Cg+BRB4WU=
X-Google-Smtp-Source: AGHT+IGRn8o+3PguwBMQKbgAfAf68TmGaanFkxmhOOIUWDE6pq12LGO9dPZ4sbxX968w/g0y+Ao1ug==
X-Received: by 2002:a05:6000:1887:b0:33a:e9dd:5b6b with SMTP id
 a7-20020a056000188700b0033ae9dd5b6bmr5051977wri.9.1707323902065; 
 Wed, 07 Feb 2024 08:38:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUYag4D21fnS+Nt3Iaa0dWG4qWZq8iz7hwR054Tieh1RJruin5WpYjIvfHJUsbaIMXvRT0a8w0Y7xumZ62eTYqyk7M5dHRcd073VKqaempqxzU3NI3jMnLLMX1ouaZmTgS0y4gs6vgHt0JUXgU1HhOWnRQqW6XWyDDVCHNRid5ugUdq3Ex3o8zdgCEjQmyF51CVoJvMlwQSgBWFm1BJYnCZWfqQgVYVEvtShNto7qBgyNpXMV3ekxzMuGiuD/qRXcOCmfFIp/j7QuXexWYapukhaXU0c72UkvOlVP9HNrm7f4xJnS0IkJAg7k7+EDxbnQLlFpljISxnfi57XteE8g3ZHhqtGQPWqKD/A6YU+NCPq8rm45SzXwj7F7TL+3YI4/Ce4bk8V+Eu+PZFqfQuEh01tf3UQO0oKp8rFWUMnLpuLFijLiTv7g3GAun9BJA3IZLiHlYmdUAF3odWSigqf84aWgLHBo0pFBTbh9qb5ZQIjh2BHHLdseZbzvCGf8Rl+lyMdNcz0gyidQEUkamYgzJTBLmY072NCWj4BNad/X1FEseVZ1NhdnUleZ2WCBDQQYh/HQeppZzdUFnpmER0xxOzIPlsf8m6BHUaAE4W/C8PxNNK+Fef37M207yUmyNHrEN6B2tsa0+4vmttFuAp6q8/HNzQT9hwpLAwy4/sbChqabDwQjRU1WfBdFQnPEE/CytfnqGzqtLXTfGBYi0MR1jqktR/vCFBnQwS2W/D3uXbawLY9zAqUVTmaPrMTPxip9PXtfUkV+5xeheXSM1lV73AEO07XIZBL5g7TyZLT5JI+X+XjdHBAnIZXpvSDzIjunEZZrbnoMxWl75nXctY3GGHgdn1TVv7ZqYf+a6R
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 dr9-20020a5d5f89000000b0033b14f22180sm1931991wrb.20.2024.02.07.08.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D06AA5F936;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 08/14] meson: Link with libinotify on FreeBSD
Date: Wed,  7 Feb 2024 16:38:06 +0000
Message-Id: <20240207163812.3231697-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

make vm-build-freebsd fails with:

    ld: error: undefined symbol: inotify_init1
    >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
    >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a

On FreeBSD the inotify functions are defined in libinotify.so. Add it
to the dependencies.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240206002344.12372-5-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build      | 23 +++++++++++++++++++----
 util/meson.build |  6 +++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index b5d6dc94a83..e5d6f2d057e 100644
--- a/meson.build
+++ b/meson.build
@@ -2384,6 +2384,22 @@ else
 endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
+have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
+have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
+inotify = not_found
+if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
+  # libinotify-kqueue
+  inotify = cc.find_library('inotify')
+  if have_inotify_init
+    have_inotify_init = inotify.found()
+  endif
+  if have_inotify_init1
+    have_inotify_init1 = inotify.found()
+  endif
+endif
+config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
+config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
+
 # has_header_symbol
 config_host_data.set('CONFIG_BLKZONED',
                      cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
@@ -2400,10 +2416,6 @@ config_host_data.set('CONFIG_FIEMAP',
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))
-config_host_data.set('CONFIG_INOTIFY',
-                     cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
-config_host_data.set('CONFIG_INOTIFY1',
-                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
 config_host_data.set('CONFIG_PRCTL_PR_SET_TIMERSLACK',
                      cc.has_header_symbol('sys/prctl.h', 'PR_SET_TIMERSLACK'))
 config_host_data.set('CONFIG_RTNETLINK',
@@ -4407,6 +4419,9 @@ summary_info += {'libudev':           libudev}
 summary_info += {'FUSE lseek':        fuse_lseek.found()}
 summary_info += {'selinux':           selinux}
 summary_info += {'libdw':             libdw}
+if host_os == 'freebsd'
+  summary_info += {'libinotify-kqueue': inotify}
+endif
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
diff --git a/util/meson.build b/util/meson.build
index af3bf5692d8..0ef9886be04 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -104,7 +104,11 @@ if have_block
   util_ss.add(files('throttle.c'))
   util_ss.add(files('timed-average.c'))
   if config_host_data.get('CONFIG_INOTIFY1')
-    util_ss.add(files('filemonitor-inotify.c'))
+    freebsd_dep = []
+    if host_os == 'freebsd'
+      freebsd_dep = inotify
+    endif
+    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif
-- 
2.39.2


