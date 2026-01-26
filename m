Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB2FC88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGvi-0008NC-66; Mon, 26 Jan 2026 02:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGgE-0003LP-PI
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGg8-0004hx-3u
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:32 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso1773075b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411182; x=1770015982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2m1YYGNyq/Rz1FBTgbyAMMQAXZAUd22fOojccDF0Y8=;
 b=XYgj41gN2ZOhPFh/8Qs2BKn7z1Uwjg686Nf+pdM65cbtzKfG7Yoth2DfFUiR6WJOpF
 9NPeUau+ggna95ae1E4aQY/hAxLMUMNFiLbPjJfNIz62JdG5NJSGczrgHDWKNegHd8w7
 RiFJ1QM6SsFJA7tR5MHXlOXrcCN0G5yNntPaDDds8li/w/Qz+l2fR4GdRypeYCsIClVv
 ZRSxMkRFK1cnyAGRiFEQHRkxorRyx7vGrgh5LYK05xJJqtPx4mMHHTMM4hjCEFhSvOqL
 5NixUfBbGY6l0UUfTdaOMc29aN9P4VtBjpMQ5jgZzkhpqWIcl8AuWIF9ykme5vL6dm6N
 OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411182; x=1770015982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A2m1YYGNyq/Rz1FBTgbyAMMQAXZAUd22fOojccDF0Y8=;
 b=btBsXhdfJ2hRgfVWKx1V7G4uJaZNaQYhR18OKWjOaFB/XEH5QkyQbwJUVDhClYNW4f
 1Bpdx5bhlEymheLcNm9+gPE4QYDnajlPtJi0zSXpfy8Xc2tkhpfM65JsPYvGjii7JSw5
 t2Bq5/Zp6Qv3iR/LP7Ht05yuiq3NsR8JfCR9+7Ig/j6uhGBYEiY5wbZiEeCAOnaN+q1g
 SQ0raTCagppHIhWBpiY1FJpzf28jFMVZjX7Nn/MQxoWrTv0Olq4iaPIuvQihXqrY+826
 rnycqFf5sDRaqTO4fJsIa24nkY0W48CQunwIeV30PeJlUhkOf3oDVeS5D+wh9Monp1j9
 Aohg==
X-Gm-Message-State: AOJu0YzaXZJNmp/NcdQAh41ffl7qFYJOJ245WhLwUeqjOQ4h+ZFxnca5
 stHg8ovQwSjjSxTQqMWQs0osPWlq5q8HCkCkpUxIA444JmO422iv6qQjB1fT1mw9
X-Gm-Gg: AZuq6aKN0kM3jWpnegcX+A+uBMRk4hanjvyY9KcDbfpp03RIXJ1bdLLnCIYr2XvtsTn
 Vk9KncuLAa7ykcdv2VpjuMicT79qDuPhUoTk/9II373jCWktWt/TbKQ41iHTHD24oeHiwtVFyHk
 BW5OlsWEsAJFZy7p9qnz7PcWZPG4wQIb7J/dEmKAvnW4l0jEJ8C8+jFtPQKYYW4WBpdDBjRWSFP
 vVIvcfnaWJ1ei32ww/U0oX3+VHIiMuVNgzYZkoHj7y93dXkl/d/mgTPbt8KeGR924YVSXWRLrzL
 0LyBRhHwjL6ck1RBppZO7jAptm2DlpRzC/bYao63aimitqY14uHcdQDfIfximw30NQjKNtvElX+
 Z8AgNOS33qrJtdm9vL/V9HaWAmLRqaG1cXUrdMe1Sg/C2oF3qKGI2GAFVfFtmTMUqd1U12iJ9B/
 c/pHdy6WDviOuSXgOpqJBYTqrhilElG/Rs2hLuJEBy3g==
X-Received: by 2002:a05:6a00:4b07:b0:822:30e:d15f with SMTP id
 d2e1a72fcca58-823411d7ee9mr3616085b3a.6.1769411182178; 
 Sun, 25 Jan 2026 23:06:22 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:06:21 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 30/33] meson.build: Propagate optimization flag for linking
 on Emscripten
Date: Mon, 26 Jan 2026 07:03:43 +0000
Message-ID: <f14e57f2c7fc03dd0f89fd058775aa6a2f0c025e.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Emscripten uses the optimization flag at the link time to enable
optimizations via Binaryen [1]. While meson.build currently recognizes the
-Doptimization option, it does not propagate it to the linking. This commit
updates meson.build to propagate the optimization flag to the linking when
targeting WebAssembly.

[1] https://emscripten.org/docs/optimizing/Optimizing-Code.html#how-emscripten-optimizes

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 82d9c94f4a..0bdc350f16 100644
--- a/meson.build
+++ b/meson.build
@@ -841,6 +841,12 @@ elif host_os == 'openbsd'
     # Disable OpenBSD W^X if available
     emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
   endif
+elif host_os == 'emscripten'
+  # Emscripten uses the optimization flag also during the link time.
+  # https://emscripten.org/docs/optimizing/Optimizing-Code.html#how-emscripten-optimizes
+  if get_option('optimization') != 'plain'
+    emulator_link_args += ['-O' + get_option('optimization')]
+  endif
 endif
 
 ###############################################
-- 
2.43.0


