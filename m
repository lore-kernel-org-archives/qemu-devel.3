Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C759C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwIz-0004Zm-UP; Mon, 21 Jul 2025 15:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGp-0002aX-7D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:33:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGm-0003Tr-5h
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:33:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2363616a1a6so40877275ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753126430; x=1753731230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fiWneQVRhAt9GEzGA7Cv+Xb1Q7+1U8BEW2cPJ5jb3fw=;
 b=WBCFju7vmBAeRXhSganE5/WWq0riR0SVW6z4kDRliw7w/AdrnA6jqoZBBNuOwdO1qg
 3rJdg40a4JTg4O5A/I8fkN1e3OMvc3C79zVLZjS+aEQWmXWltQeaBt6C+cXs/cV0iyHO
 Ym3d2AOctzsO4Ez6SV8yFcwzd413cfHGU7mreP9zMfVynXy9XbpHhFgy1lFIoBSWlB1x
 WdcD6tW1To1DqCbtDP/ldr21QJbNAgEo3gl6FPqVaUn/iNcL+JSVfU/9c8TXdvY8ZAr1
 puago00w6drjFfQQGPk6oGBuPHBFhMfwKPQNNhAAvPN/neNMU/ZT4zh6Bqc4l9cNLlBr
 OhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753126430; x=1753731230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fiWneQVRhAt9GEzGA7Cv+Xb1Q7+1U8BEW2cPJ5jb3fw=;
 b=RfSU2ZL2fjYbm6irUzvmTOm1wZ+isksze8HyjNhJKRLpPzUvprvkRbGAFXmKgJ/MHI
 ookvghQAyumNXkPeOcvVX0uR6cn+8mik7F7B03C7OtkfRS+8I4eCLjt+h3MTkMI3hLdd
 yyr9d8IAI/VingF1r7NeYa6PsX7K6+uOoa1AhUqjKMPPuEWjR+Xi+h+g5AVGyvwg9ai6
 e6XC+foRAau9UXWRudlsLCS/116qSOXla/a7Cbldl8wJBw8XSvhvsE0ZSwALP1KcY60S
 BRDNOXza66zZ2EHMvwnY6X9oO8ASFbYEWY11sw/sBdCpChRbpCMJZQBj0yB4PZEpNctZ
 A5jw==
X-Gm-Message-State: AOJu0YwhNjgs4/upE28L+OGriz9Eq66PWBzwgHLMLRdvobFnZE/oSIEr
 CX0X6iQYoIdIwp9JGlXWuTFwEav+MyhiljNI1xBxQqoDR/b2p9CG40xLTRC0uHi+js1SdbQJXfu
 VcrSy
X-Gm-Gg: ASbGncsaWaI0U4kGYRklOiVRUdINvUjfCHr3wm0VtcgfTBxMwt+M2ZWMb9sioDNgThr
 UCDL8wGdmClINa0jfWYBoy205wRIjCVeK1ZhXXwDOjzNT2OoZT4rPhtOBo8P89JcAYJnFFh8W9C
 qC8QE32Ct/psvtn8VFsLJgx93OIErTIjLw4mKatVu0E0f6ITT+iM6TVhVbJDCymDAwujmLg5oql
 vQzOg01e/t1n2Ot5tQz2mFvHaxrj2CG+a7/sJt/HuJ3KYlrIRPTcyZ9MJYIMZJk+z/0CKXJpvEN
 a3wqDk3vYtMWqIRub88Kai3J4LecuJTQWlbCbuoyPF0+fB7m2pd/Edw7puKmlDrBSnofW6uwZxT
 syr+g2mzfFHIUvMKhm+tpTg==
X-Google-Smtp-Source: AGHT+IFbyL0OAOoGP9so17trwCT8rnRpHhg+GBi+OzNe3wKxfNlgG8uZorlV1sGHCmYF1ozGRl0G9Q==
X-Received: by 2002:a17:903:b90:b0:237:ec18:ead7 with SMTP id
 d9443c01a7336-23e2572fbd9mr386926285ad.24.1753126430554; 
 Mon, 21 Jul 2025 12:33:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e4750sm62238685ad.6.2025.07.21.12.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 12:33:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 0/6] contrib/plugins: uftrace
Date: Mon, 21 Jul 2025 12:33:34 -0700
Message-ID: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

This plugin generates a binary trace compatible with the excellent uftrace:
https://github.com/namhyung/uftrace

In short, it tracks all function calls performed during execution, based on
frame pointer analysis. A big advantage over "uftrace record" is that it works
in system mode, allowing to trace a full system execution, which was the
original goal. It works as well in user mode, but uftrace itself already does
this. It's implemented for aarch64 only (with the intent to add x86_64 later).

Let's start with concrete examples of the result.

First, in system mode, booting a stack using TF-A + U-boot + Linux:
- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
- Stat and open syscalls in kernel
https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview

Full trace is available here:
https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
You can download and open it on https://ui.perfetto.dev/ to explore it.

Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
- Loading program and its interpreter
https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
- TB creation
https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview

Full trace is available here:
https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz

If you had curiosity and now you're ready to give some attention, most of the
details you want to read are included in the documentation patch (final one).

Overhead is around x2 (sampling only) to x10-x15 (precise), and long traces can
be directly filtered with uftrace if needed.

The series is splitted in:
- implementing the plugin
- adding useful options (especially sampling and privilege level tracing)
- add a companion script to symbolize traces generated
- add documentation with examples

I hope this plugin can help people trying to understand what happens out of the
user space, and get a better grasp of how firmwares, bootloader, and kernel
interact behind the curtain.

v2
--

- trace active stacks on exit
- do not erase map generated in system_emulation
- add documentation to generate restricted visual traces around specific events
  of execution

Pierrick Bouvier (6):
  contrib/plugins/uftrace: new uftrace plugin
  contrib/plugins/uftrace: add trace-sample option
  contrib/plugins/uftrace: add trace-privilege-level option
  contrib/plugins/uftrace: add timestamp-based-on-real-time option
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst           | 207 +++++++
 contrib/plugins/uftrace.c          | 919 +++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |   3 +-
 contrib/plugins/uftrace_symbols.py | 152 +++++
 4 files changed, 1280 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2


