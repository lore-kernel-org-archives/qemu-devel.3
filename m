Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41674EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTeq-00061F-EN; Fri, 06 Feb 2026 16:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTe9-0005Pp-O5
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:58 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTe6-0002cH-Gk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:49 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4362c63531bso792978f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414343; x=1771019143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PCmrkPQJSJTgJNr3W7GtU1KB5rBLUpSrn0Qo7F3DZ4=;
 b=AWdT/Kfcogds4K2aLWc7a7y/ga7Q/WcYEWZu3T6hdtbgUjJWYplx6g7h631kMuUQ7Q
 rfYcxuET6j9GQ9XCg9LM8JvPeOFM/YJ3F2Ii9xl+ksiJ2IJZgSg2uk2IaxrnvAVydx+B
 dRvabJ5wp+E63dYbLD02a+QcNzN9TTekQJNf2jtAs1SxRftmymkHy6jfC9KsuD0cV2wR
 cehkiYjZ3owy7dv1Say8jl5vFl9Glwl81MiYk03kk00L9MqLkyMr73z0R+0ue86bAKo5
 pJbj7aqHti0rZMaKVC4HHza8Eky4wi4RmLsLhrQuYBph8ZiCen5HjWdkq7DRZ9uxQ6X7
 4iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414343; x=1771019143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1PCmrkPQJSJTgJNr3W7GtU1KB5rBLUpSrn0Qo7F3DZ4=;
 b=dbgYWcJ/srtFVPhdED7r0NlVQI/zpHxXvxfCJ1NJ7C8riK4cb/ztM5xm4LIjzj4gWi
 /YDNc/F5f9rWXGzJxXjFaNtD7pWRWGtKke8o54TxGbxe1SghusoCKMxo1Ul9xZkDNINA
 29RzM8nlJPhASgl/rP+C0mCO3uo5GnMEHuqlypoz+i0fdzOUG0a5BZ5SzKkznrCOavHh
 nX7f9nZMp8QzC0MboQr+inoMwNHph4zihssL6zK5ss1zvBspavZa2fXCsLzIuwCoB/S6
 PUCGKwXQVXPDRNKkPcOYPEF/7FPoRV6ipmOBNSAou9vjIb1YCTp+MnQ6VTGW1Jm+6xfa
 YrOA==
X-Gm-Message-State: AOJu0Yy+ULoA9yaZlmCLM81QxkSxLIjpEkxOP/YIQPXhy8ooPxABD7vx
 eYKsTn+y5Eibf0Q7/Aomv4ad69gamfqVFaWBtRxtTf1RsizHTNGa8e9rZpgU7nNq3egZmjyLmmd
 QBuAVYPw=
X-Gm-Gg: AZuq6aL/1spRN75TVO9Yn1NUg0oGGU0tBYUHVlO4iLYBDCC9Mvh7a1udLN0xgTtlmeo
 0+vt7WxBHpd9sbTyowFsLqB/VtiUAJK2hKWQDNvZwQEK7JhzDmr3hu4rxFkq8u8uESPGUMpaULL
 hcaBt/nYlf3sC3pzRtIlb0E3Wsd/9NkVbRa3MxDRZW5jOZFUWP+SC5C8FfeOXfEvWcde15L2FKQ
 AVmz70yDc9bPLUBWRYcnc4fbkkNkqaYKzeBWNaSnMIoAqV/PNSZhVoDpWebYWsdv8tgJrxWNyC9
 S9N5W5Qp6GZIAzxpfnBfxqJ0uhnjQ7cHgwDad1U3cDS4kTBL+eJ+9uCLKav3KgofH2LlHJRdOOG
 ZiKXfMpEGa7BETKpy9SfkF7aOa3yd40DOfWFhCDNzVVBN2mKHhM3c5qf5SUCQCHN8aubBByWDxS
 CkYKcWk1kzTSbKL4fIxruYz1oPcqKV0QMKjk25O9ml3ouYm6F0feFeHG2KolSX
X-Received: by 2002:a05:6000:402a:b0:431:8f8:7f24 with SMTP id
 ffacd0b85a97d-4362937844bmr6232869f8f.39.1770414342985; 
 Fri, 06 Feb 2026 13:45:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436297460a5sm7785500f8f.32.2026.02.06.13.45.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 08/30] target/s390x: Build system units in common source set
Date: Fri,  6 Feb 2026 22:44:26 +0100
Message-ID: <20260206214448.22008-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Except the ioinst.c file which uses the TARGET_PAGE_SIZE
definition in the ioinst_handle_chsc() method, all other
files in meson's s390x_system_ss[] source set don't use
any target-specific code. Moving them in the other
s390x_common_system_ss[] set to build as common objects
ensures these files won't use any target-specific API
such target_ulong / TARGET_PAGE_SIZE, thus forcing to use
the appropriate types instead (such vaddr, hwaddr, uint64_t,
...).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-8-philmd@linaro.org>
---
 target/s390x/meson.build     | 8 +++++++-
 target/s390x/tcg/meson.build | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 3b34ae034cb..096b7dcc42e 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -20,10 +20,15 @@ s390x_ss.add(gen_features_h)
 
 s390x_system_ss = ss.source_set()
 s390x_system_ss.add(files(
+  'ioinst.c',
+))
+
+s390x_common_system_ss = ss.source_set()
+s390x_common_system_ss.add(gen_features_h)
+s390x_common_system_ss.add(files(
   'helper.c',
   'arch_dump.c',
   'diag.c',
-  'ioinst.c',
   'machine.c',
   'mmu_helper.c',
   'sigp.c',
@@ -41,4 +46,5 @@ subdir('kvm')
 
 target_arch += {'s390x': s390x_ss}
 target_system_arch += {'s390x': s390x_system_ss}
+target_common_system_arch += {'s390x': s390x_common_system_ss}
 target_user_arch += {'s390x': s390x_user_ss}
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 515cb8b473d..17c9374d09e 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -12,6 +12,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-s390x_system_ss.add(when: 'CONFIG_TCG', if_true: files(
+s390x_common_system_ss.add(when: 'CONFIG_TCG', if_true: files(
   'debug.c',
 ))
-- 
2.52.0


