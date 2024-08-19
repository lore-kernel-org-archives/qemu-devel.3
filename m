Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3D8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBG7-00078d-Ko; Mon, 19 Aug 2024 18:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEd-00013p-0Q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEb-0000kR-Ct
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3718706cf8aso3057250f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107940; x=1724712740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i525VHbDEEdaYNDK1SbTy9eAffjoVCoTHAg3yOkOeL4=;
 b=YCbxlXOcQw/1wfI80a4tUMlaW6O/Ls60Tspa/tcTA3iyMCyKIzdFGO27njlsjeM3Bs
 ouwNO03szdjhn1KD4eRxpWSxgmuYn5txOeziivBVJCzWRMaJDIvkO9cbIHy3fgTjtkgY
 xBUR+EuGzX8kJF/LOAaMUKFoRT35k/3H/iQHT+3qMfGveiw7pKmyMgNy7Rtq8kUDHkPy
 hcsBcH9cm/BT4XHFHsQHDhXy8w+DJVy55KsHxNl+UfwE8szbBjyfZ1XQfYDkiKnIxzE+
 JsFjOeOBXHAaMaAXVtG0md3glm+R1lt3sj8Gu0txXrFcBAyrJJS+PnoPhCzFYlhzsFYu
 2BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107940; x=1724712740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i525VHbDEEdaYNDK1SbTy9eAffjoVCoTHAg3yOkOeL4=;
 b=oiSxYU42J+WwZHkkZ1NMKDqQeHvdn0p2U6qjr5f0muT/xQvaxh0GKsHlj3/owBKXM1
 +CjQyBk+ZBDRxlr+ewKJxUtK7NMsBFAQO0YMywnV0nppzOhQp36gUb8BZG9raoNkVQmu
 BVbjzb74lWOn+VKc+n26JPEV+lNkV1UB6Wd5DNrIa2IsWsU2RdZDMVokxBBMo+Ugvz7w
 G3KJMevpqGWDrcJJbhMCLj0KqOrmf49Xc9uLtlm+68FZ8DWYAVftQJNEHSO+HhtepmQp
 W8sRLjlod5EhtOQ0U8z4AdXLrHlY+T0HgyfVcnvWHxo7pdZWY2VddnYZ2Ql3kn53EoJ5
 elRw==
X-Gm-Message-State: AOJu0YwEkmNQifVOtuswNAVhC15gyEFZOTfXCzETQ3YjLKH0r8xIJLzd
 UQFbIHYBfMliK4lAyzV0FpUFZcHnDAIVVKNz78xYayoPeBDyUFmLtRV65TUhG4XiKqhSJ7WH0tm
 nozg=
X-Google-Smtp-Source: AGHT+IHNfQLkqA2Cyy3T06sUUzcs+V5NfBtNgOyyq/MrTopBY32pDIND7ZknCm2RrCUmQPGCxLsy6Q==
X-Received: by 2002:adf:b307:0:b0:368:4edc:611e with SMTP id
 ffacd0b85a97d-37194344041mr7950257f8f.14.1724107939545; 
 Mon, 19 Aug 2024 15:52:19 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded367ebsm179600455e9.25.2024.08.19.15.52.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/20] tests/avocado: exec_command should not consume console
 output
Date: Tue, 20 Aug 2024 00:51:09 +0200
Message-ID: <20240819225116.17928-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240805232814.267843-2-npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


