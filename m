Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D5C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYBp-0005cL-Ez; Fri, 23 Feb 2024 11:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXt0-0007Nx-Gb; Fri, 23 Feb 2024 10:54:54 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXsy-00088B-Qb; Fri, 23 Feb 2024 10:54:54 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e32a92e0fdso222573b3a.0; 
 Fri, 23 Feb 2024 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703690; x=1709308490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b/3a1uVCQ/mXsUqfz4Xd/d5tDH6b6wbMh9+RuzGh6cg=;
 b=OHBzzucTUTC/b0U9RXAcKsLcZ1W/spu1lAaXmjJgz+FllEqK4t/rs9xzJ7tZcKP2qR
 mjdVIlUwqXLW+m665+7WvMULbUD/JiaJvqsUkNdOL0cPBBhy2kvQ/Spiz3IRQf+Ue0vv
 usZwU/zknIk68daeFSusjvtMnZrnPk1FgWXW/ocZ42NvnlT/cUFI7znXzJZkFyqmloxs
 4zuPJjVMSdDRD+kaq9CDc5AaLadtt4c330nMv2BcKulwJZVlmdKn38MbK/ZouvF1jErR
 8vAqyGUoDT57Zy8wCQz32LLoP3SeXijJqulB03L3nH1rXcEzFl8L7v87Awqpo1/8+2Wd
 Cd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703690; x=1709308490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b/3a1uVCQ/mXsUqfz4Xd/d5tDH6b6wbMh9+RuzGh6cg=;
 b=gLmxbz7mpSvgZUXnzWIWb+2uQ2YYtIrPCrP82VLKJtIguwMlPjNc2HBNXHiaL/ayF6
 rVqqW23xZYlPOB1pzIp5veCY68HgLOkDEA9HFafcF+HK9cxgJo5Nexobd5k3g+aanJ5H
 h0u9L5iFErTqVkutiH3dmi8V0MmNQ/ufmOPbLQ8LPA9l/Tjl0e6qcCYoqQNNh6eiHqhi
 TCwtwefuPUQn0weUlham1M1EC5fUhrhOhM13sEIKgQ2vMqv+K+YzTvjx1Z5TVx26T3/z
 CHjmx34mXO9GKMiyYQ3GXXoaZxF+GdK0bQfTEfeHZLoLOWdKnDr49Cdm/C+QL9Nffm4G
 n5mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmEfL38m+RDKq7QT1EGGx5bXgYZJxLCPBCXNY2D3JCMe+/YbEB8QA/1ENbQYIbE/FRbx6HwNSZMdkO5rlENuuIpV9m
X-Gm-Message-State: AOJu0YzORAM5Amz91/X2lUQZ1ckiy98k3j15ZAhWcts7aw49RXY6dbgz
 bVYf3HdbGD+ZEZN+qGPwMh/ANrxZgggGmjl2GzVE+7OabEUEZlzwPQ0JW4hW
X-Google-Smtp-Source: AGHT+IHi0G9K4F8gZ32ez8Cg1XI7KgOUq2XLMDXu4UeJK44okNFJE+0XXut9V5cLIGsRgaLvSLnHkw==
X-Received: by 2002:a05:6a00:2da2:b0:6e4:c5a1:e41d with SMTP id
 fb34-20020a056a002da200b006e4c5a1e41dmr243402pfb.29.1708703689748; 
 Fri, 23 Feb 2024 07:54:49 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 m5-20020a62f205000000b006e468cd0a5asm9775959pfh.178.2024.02.23.07.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:54:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Willian Rampazzo <willianr@redhat.com>
Subject: [PATCH] tests/avocado: exec_command should not consume console output
Date: Sat, 24 Feb 2024 01:54:39 +1000
Message-ID: <20240223155439.1001956-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

_console_interaction reads data from the console even when there is only
an input string to send, and no output data to wait on. This can cause
lines to be missed by wait_for_console_pattern calls that follows an
exec_command. Fix this by not reading the console if there is no pattern
to wait for.

This does not seem to affect any upstream test case that I can see, but
it does cause occasional hangs in the proposed ppc_hv_tests.py test,
usually when run on KVM hosts that are fast enough to output important
lines early enough to be consumed.

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


