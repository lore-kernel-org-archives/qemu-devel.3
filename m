Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDDBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb780-0003eZ-1z; Mon, 05 Aug 2024 19:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb77y-0003dd-Ij; Mon, 05 Aug 2024 19:28:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb77w-0001Nf-5W; Mon, 05 Aug 2024 19:28:33 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb5789297eso7131854a91.3; 
 Mon, 05 Aug 2024 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722900509; x=1723505309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=865ipMsfnPjqevXUhuNC1hjLcECXbBAzIH19t+juWX8=;
 b=PVh/5S5+qutUwz63BWDwdc18mqUDXkbq8is0ofYIPgKCs0UmV7GlVsD2GFK/qcELkm
 XsI3Eo3jePBQc5FqPGOrb6+bJPJAzzne7pmSLDgr6LtuWqUhUzefGzOpkhwBlt3iYuND
 Mzqg0yNQXBukN7wSw7ELEorZ9qamludz1Ddf+O39huVSNNyJpd70ofWz2b4F07c/dFUK
 1tNYjW6ImkCH2/JYKaxwLY7/pcsAjQZ9o7B7UTYKt3nduy4/Drsju3BJT8k27hDPfMnY
 YwoET7GS+TwJABV0VlEk3575UTmpQpJtwogTfSuBW74lF8dU5nZidr9ZyBBjjhfCuwGE
 oKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722900509; x=1723505309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=865ipMsfnPjqevXUhuNC1hjLcECXbBAzIH19t+juWX8=;
 b=r/FQaMtPyPSuZcz/Yx50jnKRjQEu52ElNGMTY4ss6RxMICq8PYtP3Gm3fCtjgUaMHO
 KklBHeik/jnPISy6HGZiOMhymcBKZphOo6569dZzgGPXleKRw/kyEJ2F45r931F6FO2u
 l2YCwGkQLzqGMWmaKxZROxoxWkEBFVfQ5T4RDTOezFQY0qIHJWUrTNeZBGz/c258tujb
 9U64fRqytL4NSA7OmqjmVIslfQHik8sBoDm1wMrZH7nKume7mlcrxgwC7HUw0S5Ym36l
 ND7k7ii+OnQYdhBzOgvCAaWy/hl30G3aLyOHzxiKTGgvPHZ+/dPzYF369DDhLUAsybHw
 Z6qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXldQSvvoJsvY+voxnQAWFa1y4U/kAuVJev/wlxY3fjmKAyytUHeVmSPte1ZIEWvWr+4jeMadd18nUm6JAVEJXnOukm
X-Gm-Message-State: AOJu0YzAUSZ3znyFZJ4elSChpC4ewxtFWe+73AXWdBLpkRN99XfTtR42
 aRR2hqf/DNCLOmFCCmZ8vn6UVg2Hl/2GQXkGznBe4gKX8HGp3VZgQTGKkw==
X-Google-Smtp-Source: AGHT+IHeyx8Reax/Kx5/pMzlzcTkQymdBtooJ6suwFvh3pAEapv44zYVZLeqXV4Ara8yVFVovFD0cw==
X-Received: by 2002:a17:90b:1e4c:b0:2c9:57a4:a8c4 with SMTP id
 98e67ed59e1d1-2cff955901dmr11301565a91.42.1722900509438; 
 Mon, 05 Aug 2024 16:28:29 -0700 (PDT)
Received: from wheely.local0.net ([1.145.206.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffb390be6sm7659100a91.51.2024.08.05.16.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 16:28:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/2] tests/avocado: exec_command should not consume console
 output
Date: Tue,  6 Aug 2024 09:28:12 +1000
Message-ID: <20240805232814.267843-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805232814.267843-1-npiggin@gmail.com>
References: <20240805232814.267843-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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
index a3da2a96bb..ef935614cf 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -135,6 +135,13 @@ def _console_interaction(test, success_message, failure_message,
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
2.45.2


