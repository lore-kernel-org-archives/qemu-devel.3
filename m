Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C152AC87FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueckN-0006Zv-T0; Wed, 23 Jul 2025 12:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckL-0006Q7-Jm
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckI-0007Bf-OY
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so282005e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753289708; x=1753894508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00yvims1BjJ3R3G/W5bXXwJ7prb70xvvqvzHA18CXuQ=;
 b=E0QkoOm0XiYHsImKk3cOeK5AhoZ7qTkd9SIQAdrtnDfkxhSmVBSk87QkbF0TEhrRgu
 TDiHP9jSCGhv4yqFcvYSUL1WCSySKVJkeHUMtdPSG4WKvSqLiqAtPI06f32aRWja3TFE
 jKv/E3kIGFsdMGAkFFabJbfyJW4vCp48dLspblY8Wm6EZQ3hxA34kMTiuEdchIFURZVK
 rCtejwQ4FnZgntg4+ynDs5opeKeHkJYqXFN4QEVM8XGswR89fO0ihOUBtPuSr3T1iyv9
 HCLz4rTT9SZ11whDS5/EVVNJHfS0jxTDwJ5IW+ber3OKmjXGC8ETs3aOWbXjUovhW4d/
 clPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753289708; x=1753894508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00yvims1BjJ3R3G/W5bXXwJ7prb70xvvqvzHA18CXuQ=;
 b=Pa6sLHaYDu4jryu+dx0UV20IzMIFUBkTuPLFHoa/7nldc7ligw53C3TYUKpBcqG77F
 S54A83qMDwadtZokr0KK3KtxxfnBM5xdJvTGuzy5KmIhC3wrAQSYLIde54zkOBU/BPew
 x0nEiA7i9vBITG9Xh7daRjaoAXWdm6Osaor9LSJXIA+/v7bU07tdnlKwx9t1NMWOsiTA
 IidO1FfqqAz1nYeQZK6u7TRiEaMzE3Fw4QrQ4a2oU/R25jXE164XqvXmjJIpznv8j5xM
 iUbF0L5CNpBEYuDMZIxPSeHCL6wEEHvnl1ASTdtbw+bC7F2GK5z5p5JjcqEsYWOSA9fy
 dNaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmC8mitqam+1taUyzkwGu4IjP+OohdEvVrttUeP+F2VHL5PF8U0jcOErAWRn7w2+5ulqiesJFyB6DL@nongnu.org
X-Gm-Message-State: AOJu0YxXHJfTxD6FK8d9PtFJeWG8QyjXKD4qV8JjHpt2brN2bhO1GdaY
 4MUpksZrV5Re3x2bLPhrWNlA39GE7w7ATTK1tSucDAiHXbaR6Ndd5mYKZO8UfWOOAv0=
X-Gm-Gg: ASbGncto0cz7w12xhjcvjiLZ/cr3eFJGfc1L+E/nAxRgtAVP3RUff/jE6FNKUgX9Xwu
 KI1WPSKxuS3VdqKYdYL/YO7xLFw+2uFc3wFhKZH/az7+wEfba5juZ+v95kOiXMgZYym1M7AMrN/
 xt+kuZQmtMls20Y9nmvpb/xdbXZXff5EjV9LAlarurWIZBZhfWTt/M5AQpwyU+EhAvO4VbmdMFA
 nl133hJ7xYF+EXQI8RtZNJmIuyutXJMYSfhWIze7MfLDEll/0iy+YMZHaCorrd7TEGAhVAlI49m
 AsX6yRWarg6Lmb9CQHk9rVtUfOksGrNjPBlXMTRI51bwq+Zi19CfHrtin20P6gDQBaGBQSIwG17
 lZ1BIXdgefTPXp2UB/W+LHsFTNBhL
X-Google-Smtp-Source: AGHT+IEsXgtwlcQ8q1XM5foV/TzjKtYJ6QaARWqdhENGtdOmashhzcxbHk3iuIHTwqna7fZBwXWccw==
X-Received: by 2002:a05:6000:2508:b0:3a5:1c0d:85e8 with SMTP id
 ffacd0b85a97d-3b768cb12bcmr3048861f8f.22.1753289708016; 
 Wed, 23 Jul 2025 09:55:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd224sm28559825e9.21.2025.07.23.09.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:55:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 3/6] decodetree: Infer argument set before inferring
 format
Date: Wed, 23 Jul 2025 17:54:55 +0100
Message-ID: <20250723165458.3509150-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723165458.3509150-1-peter.maydell@linaro.org>
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Failure to confirm an argument set first may result in
the selection of a format which leaves extra arguments
to be filled in by the pattern.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250722183343.273533-1-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/decode/succ_infer1.decode | 4 ++++
 scripts/decodetree.py           | 7 ++++---
 tests/decode/meson.build        | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 tests/decode/succ_infer1.decode

diff --git a/tests/decode/succ_infer1.decode b/tests/decode/succ_infer1.decode
new file mode 100644
index 00000000000..6fa40bada5c
--- /dev/null
+++ b/tests/decode/succ_infer1.decode
@@ -0,0 +1,4 @@
+&rprr_load      rd pg rn rm dtype nreg
+@rprr_load      .... .... ... rm:5 ... pg:3 rn:5 rd:5            &rprr_load
+
+LD1Q            1100 0100 000 rm:5 101 pg:3 rn:5 rd:5
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e8b72da3a97..f992472b73e 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1016,9 +1016,12 @@ def infer_format(arg, fieldmask, flds, width):
         else:
             var_flds[n] = c
 
+    if not arg:
+        arg = infer_argument_set(flds)
+
     # Look for an existing format with the same argument set and fields
     for fmt in formats.values():
-        if arg and fmt.base != arg:
+        if fmt.base != arg:
             continue
         if fieldmask != fmt.fieldmask:
             continue
@@ -1029,8 +1032,6 @@ def infer_format(arg, fieldmask, flds, width):
         return (fmt, const_flds)
 
     name = decode_function + '_Fmt_' + str(len(formats))
-    if not arg:
-        arg = infer_argument_set(flds)
 
     fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds, width)
     formats[name] = fmt
diff --git a/tests/decode/meson.build b/tests/decode/meson.build
index b13fada9800..63405ca08fd 100644
--- a/tests/decode/meson.build
+++ b/tests/decode/meson.build
@@ -41,6 +41,7 @@ succ_tests = [
     'succ_argset_type1.decode',
     'succ_function.decode',
     'succ_ident1.decode',
+    'succ_infer1.decode',
     'succ_named_field.decode',
     'succ_pattern_group_nest1.decode',
     'succ_pattern_group_nest2.decode',
-- 
2.43.0


