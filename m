Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39141C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcJ-0003Vc-F2; Fri, 25 Jul 2025 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbx-0002xa-CM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbv-0002Rp-5w
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-af2a2a54a95so359666166b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458324; x=1754063124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ci13zANRlMXshyqaJ0Y9zNXzi7dZMXO5ioaNjRJV8Ak=;
 b=O8RYw6w5vIIKJaQJQyQxU58f8yxPBbpBzN7igHc0/S+WXYX6Ky4Or0nsYuk9RVC9yT
 ojMsWfB1hnZ5YXXG9UdjdEj+qsgQwWX1i5Ya4dT5/Iv9iDD8WNqL1Wzv6bcx+NYZWvXA
 KHSzVJbRrKUxFrTsebZiN9FIfTzQF11Z1hYouDlWYjfmVtZcyiwH/RSKOlhb5nkMZdT0
 UEnV2RR9RV7q/mKv30EWHsH/UXQfB2hDty7EezLfk7d1wmaqCm9p8cvQSmhxprncKxjp
 Y6II+qD+S2WuEMPK83BqKbRjus7nYDHVrKmBjCBE+u0le5FrgRQ+GXjXGDGvEovTh94c
 7vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458324; x=1754063124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ci13zANRlMXshyqaJ0Y9zNXzi7dZMXO5ioaNjRJV8Ak=;
 b=Z/b75uBuYYvBxb2sP5RNvWxydKqqsr37ZzWvSdjxgqXanXJIYkMFf11W1/e0Fmw+vb
 HMNRokPzNbU5Flgj9KUCPqIqAceZmpg3vDhV9LHBmuuyCL3m3y1Eq+nN1jRnrB2rjJd3
 CYPWrw36tVhCRTGXeMSELOHIWx40SK1tXVtgjYbRRlMkVQ9/b0WOUbPWMmsDHvU/8zK2
 TM2UNa/gW+0cs8B/HvNNbYDQGwJfg8kdRCEcehbgt7UmPc6NYmP2H7xgnYbaYD2nU5+d
 1cPrRf4wLLqUO5WTxMWnymTDQ3/PFlKZmev8nGSFxkFYfx4k4DJWehrbLLzqgpQjFQHf
 LSWw==
X-Gm-Message-State: AOJu0YyyDL2xOvjocDDGdPqn+uDau+Vymfowqrsos5o1OnmnSrlaZyDz
 1FbaUTkfnqW1an5uAwGo3k286oq8+PuUpu7tACgzYR+Q2W+gPuIQr2tfLrCGf40aGpc=
X-Gm-Gg: ASbGncvfopi+rqsRvIprYfg87rv+v1B3eup4sKlk9QFSdEvoq1iVoq6Mb04jj3dnWHQ
 H72JJP31M0U8yKEjkNmsDPLx/+M8Cur1Z4WTO63staQvRwvwzGRzvDa2j9nQwAKjIO2OwwcQoFx
 im882BSOUW8VxA2jlnWsSS5431dkkd/l7K1XxROsRPzvqJswCdSrZGFk6FEmW4zT8hmu85Jlf48
 jAeFKQ1OPXt4FFOXE8iX+Nv5R7cYlR6g0ixwdPyLHt8e3L95g6q8ovFjzp7RvympZ81LR6TsXja
 8/Z58cY6PDM8UfdQz2okgytyZbK7/7zVp07piE4l5c9j9SbNhFSPY6dmCnvKEK7N22snFG3dBTA
 O/Q7hxAff50IhI7HAwOdQ9II=
X-Google-Smtp-Source: AGHT+IGp8bL3b8uksvPgT262raT3NeWQnxuSjlqBF49tMYii/WVpozUG0lb5UOekE6qE4bxkPqv/7w==
X-Received: by 2002:a17:906:6a21:b0:af5:3172:ca80 with SMTP id
 a640c23a62f3a-af61dd649e5mr317347966b.38.1753458323531; 
 Fri, 25 Jul 2025 08:45:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af6358a1dbasm10020666b.53.2025.07.25.08.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E13B5F89B;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for 10.1 v2 03/14] docs/user: clean up headings
Date: Fri, 25 Jul 2025 16:45:06 +0100
Message-ID: <20250725154517.3523095-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

This was a slightly duff format for rst, make it use proper headings.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/main.rst | 50 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 9a1c60448c5..b8ff203c212 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -17,28 +17,34 @@ Features
 
 QEMU user space emulation has the following notable features:
 
-**System call translation:**
-   QEMU includes a generic system call translator. This means that the
-   parameters of the system calls can be converted to fix endianness and
-   32/64-bit mismatches between hosts and targets. IOCTLs can be
-   converted too.
-
-**POSIX signal handling:**
-   QEMU can redirect to the running program all signals coming from the
-   host (such as ``SIGALRM``), as well as synthesize signals from
-   virtual CPU exceptions (for example ``SIGFPE`` when the program
-   executes a division by zero).
-
-   QEMU relies on the host kernel to emulate most signal system calls,
-   for example to emulate the signal mask. On Linux, QEMU supports both
-   normal and real-time signals.
-
-**Threading:**
-   On Linux, QEMU can emulate the ``clone`` syscall and create a real
-   host thread (with a separate virtual CPU) for each emulated thread.
-   Note that not all targets currently emulate atomic operations
-   correctly. x86 and Arm use a global lock in order to preserve their
-   semantics.
+System call translation
+~~~~~~~~~~~~~~~~~~~~~~~
+
+QEMU includes a generic system call translator. This means that the
+parameters of the system calls can be converted to fix endianness
+and 32/64-bit mismatches between hosts and targets. IOCTLs can be
+converted too.
+
+POSIX signal handling
+~~~~~~~~~~~~~~~~~~~~~
+
+QEMU can redirect to the running program all signals coming from the
+host (such as ``SIGALRM``), as well as synthesize signals from
+virtual CPU exceptions (for example ``SIGFPE`` when the program
+executes a division by zero).
+
+QEMU relies on the host kernel to emulate most signal system calls,
+for example to emulate the signal mask. On Linux, QEMU supports both
+normal and real-time signals.
+
+Threading
+~~~~~~~~~
+
+On Linux, QEMU can emulate the ``clone`` syscall and create a real
+host thread (with a separate virtual CPU) for each emulated thread.
+Note that not all targets currently emulate atomic operations
+correctly. x86 and Arm use a global lock in order to preserve their
+semantics.
 
 QEMU was conceived so that ultimately it can emulate itself. Although it
 is not very useful, it is an important test to show the power of the
-- 
2.47.2


