Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DFDC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphBQ-0006o7-Ja; Thu, 28 Mar 2024 00:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBF-0006Yj-JF; Thu, 28 Mar 2024 00:16:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBE-0003Hq-2x; Thu, 28 Mar 2024 00:15:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dff837d674so4477985ad.3; 
 Wed, 27 Mar 2024 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711599348; x=1712204148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RhYgZ2VP4lzdfoEaDZ5i/JmbrEu26JdSx05eA22CIE=;
 b=HckX1vEE0trG4roQFhfajxuSuAdesXTixeIU/+Q9HBf62wzZoeKfoDwsWn6B3W/26D
 jvClcaK9V/OX6Wf2dU9CFw/AundX8ffDZRaqR8uNYrjzsGnrTvk3k/TFtzLPrZF+yjFU
 vPBwWj4J8y9GZqYfokG5QoLLxAdVPeyf5FlBfXAXzAhtGa64mcYfBp5+uQfvDENribLz
 XSqP5LaJMHhGaUmPPb1dBPQ2N60TKi3gueZ0WGv94CiQSJaKgbLrjaI4jNJVdVLNSeZ+
 fFN57wsEuV6nwZXZS6CddHltnY+TBZ8IEdZHSsrz2VNnRQLCntyKG1UDVveH4AZGiu3F
 ok7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599348; x=1712204148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RhYgZ2VP4lzdfoEaDZ5i/JmbrEu26JdSx05eA22CIE=;
 b=Oq/AsX+Z+9fws3nrvbg/935I8CzTIy3TgBwkgBCY6Wszt/rLtfBnTiuQqvjaGBQE4O
 L0IKxPY8Ce/Exl+WmQA92hfiY0gL/RwQr6y20iujCEe5h54MLrK37av2cOeNRY0iizUQ
 aiD68uQNV8OsHz+MG540ThrbJKDQc4LSvTZdOGRiv0t5mVRWjFpnLlrwyaltV7gwiasE
 YvpOOgFO8c2MkdZDxr9CZjxnBpPW3hemP2ogXs/LwEAYTsoQqnnJKWdRprd4GJaModdP
 pFvUmfBxoczfkpm2ezSC95+jO+Qz0H99qV8NMnmx92lISTqoCBPgv8AlnhWcN7oh3JuB
 dRPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaqs3llHffwYEjlDIYbcXYEGBbqytdtmjMqAYWKHgUSeBpnov50MLMTUicXKhVkpIZYu2Nb0qNh+lnZGs1EOUqiRAb
X-Gm-Message-State: AOJu0Yw4kkUaqHxe+/8o6/hYOF+VoZ57yozjtik8hEf9iqA0dOpsBnXQ
 GQ2kspHI2DIy2Az1/nZdhzd/eI8hmHz02V9r/ZD4GgOquBnB3KR7GzauFNfq0pM=
X-Google-Smtp-Source: AGHT+IH8bfZ/br+IuIz9FaB7NRpSMtmswYP9nAf4HXmSgcS8yMWYHsoo2vQanFoDPLcleORlEk8O7w==
X-Received: by 2002:a17:902:d2d0:b0:1df:16b:9cb8 with SMTP id
 n16-20020a170902d2d000b001df016b9cb8mr1903781plc.2.1711599347783; 
 Wed, 27 Mar 2024 21:15:47 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709026f1600b001e0b5f9fb02sm395416plk.26.2024.03.27.21.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 21:15:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/4] tests/avocado: exec_command should not consume console
 output
Date: Thu, 28 Mar 2024 14:15:26 +1000
Message-ID: <20240328041527.2602823-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328041527.2602823-1-npiggin@gmail.com>
References: <20240328041527.2602823-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

_console_interaction reads data from the console even when there is only
an input string to send, and no output data to wait on. This can cause
lines to be missed by wait_for_console_pattern calls that follows an
exec_command. Fix this by not reading the console if there is no pattern
to wait for.

This solves occasional hangs in ppc_hv_tests.py, usually when run on KVM
hosts that are fast enough to output important lines quickly enough to be
consumed by exec_command, so they get missed by subsequent wait for
pattern calls.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/avocado_qemu/__init__.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 304c428168..5a3ae7f6b5 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -144,6 +144,13 @@ def _console_interaction(test, success_message, failure_message,
             vm.console_socket.sendall(send_string.encode())
             if not keep_sending:
                 send_string = None # send only once
+
+        # Only consume console output if waiting for something
+        if success_message is None and failure_message is None:
+            if send_string is None:
+                break
+            continue
+
         try:
             msg = console.readline().decode().strip()
         except UnicodeDecodeError:
-- 
2.42.0


