Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779C8C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphBp-0007MW-Il; Thu, 28 Mar 2024 00:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBE-0006Yf-IW; Thu, 28 Mar 2024 00:16:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBC-000372-1s; Thu, 28 Mar 2024 00:15:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1df01161b39so4781825ad.3; 
 Wed, 27 Mar 2024 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711599343; x=1712204143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqzpXtzmhrMDzEkGd0Sfciym3rwCKwhHPnmWOgqCxBY=;
 b=Fl9HdHa9H7tW7EEK+QvSdTAqMv3rQCozJqY1GvRS6646V+YujWzVjl6MpzAzHgPXzf
 SE6yxBN4N5BbIPtPCBy/ryAbRQuAMD2Evpwd0WKE3EWPd6HQktE+3bd7RYJI0B3H4PPl
 RGyVQ4HwHAXM2nuGhsdfZ2zt3O1thxVr/p9wiOOOfvEwITRRo/Bn/d++U+rOaoNkrjoI
 rWheGr9n6In7Ab1EOQ9oUFGTORv/P0gU7/kbzY9NVqSupkCEEapHGBSd3gaK3uKbzXaZ
 Mci3VBXYXK50S6k1eXW1MDNSEQ/S+VvvQV7uvEECrFEC+Vx1DxkJgssww7rWiQVObHkQ
 P68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599343; x=1712204143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqzpXtzmhrMDzEkGd0Sfciym3rwCKwhHPnmWOgqCxBY=;
 b=UaPRgL+5zAOQ7nlBgUyiFoIiaIVRblDVzp3DgLYV4CmIGkc0VpQ9FK/XOpHjDZJom5
 apT2ZLZ3Koon9WI/Zrkkq/NVKFDVeQsxuy5S+A6XjWHGWJ7M5yIn/V61th15jgKa0JQi
 cZAzOfAghrG24GMeTN/YbOfRS6vYY3d8y4XHPhcso7uQWn0VXOeiJMeIFzMUXVTt9Z2e
 WC6JZDbHqbZFXlfhduVAq6TowpTBZDnG/NDn1zLePcIrR3JarcVO5iR1W7ceahzj9BEc
 ijOxEsUv1nU/nPV33VjXEz9m1jg1Vk1L76OM4UJd04iDzI9gQ+KQ+IlPwSNbak3p29pr
 sbXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3IN+s0uxLqSGV+6CVfR/w3dynD3H0pi7ZKRYXjW3P/MOgiywjKfpJLh6Z67vm9JPqehqzu+XG/uLkmfPw5LFN2l5
X-Gm-Message-State: AOJu0YxU25mJucyEFVfLfP+8DCmDJ1E/hxXY1/tvCCL3TkXResdRJM2R
 sGH6+rOE3mKjIXbKpLxAS0NpjS5vyvwLxxmCGci9gieL++6QdfiSa1Az93SAebg=
X-Google-Smtp-Source: AGHT+IG602GijABdOb7sI7aqe+m8hFXcp/MHPoZqCkNrFjfht151ObZ2RHdRwjfi+juOKIKAgmtjHQ==
X-Received: by 2002:a17:902:d2d0:b0:1e1:179:d5dc with SMTP id
 n16-20020a170902d2d000b001e10179d5dcmr2116474plc.67.1711599343391; 
 Wed, 27 Mar 2024 21:15:43 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709026f1600b001e0b5f9fb02sm395416plk.26.2024.03.27.21.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 21:15:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/4] tests/avocado: ppc_hv_tests.py set alpine time before
 setup-alpine
Date: Thu, 28 Mar 2024 14:15:25 +1000
Message-ID: <20240328041527.2602823-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328041527.2602823-1-npiggin@gmail.com>
References: <20240328041527.2602823-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

If the time is wrong, setup-alpine SSL certificate checks can fail.
setup-alpine is used to bring up the network, but it doesn't seem
to to set NTP time before the failing SSL checks. This test has
recently started failing presumably because the default time has
now fallen too far behind.

Fix this by setting time from the host time before running setup-alpine.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_hv_tests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
index 2c8ddd9257..bf8822bb97 100644
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/avocado/ppc_hv_tests.py
@@ -14,6 +14,7 @@
 import os
 import time
 import subprocess
+from datetime import datetime
 
 deps = ["xorriso"] # dependent tools needed in the test setup/box.
 
@@ -107,6 +108,8 @@ def do_start_alpine(self):
         exec_command(self, 'root')
         wait_for_console_pattern(self, 'localhost login:')
         wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        # If the time is wrong, SSL certificates can fail.
+        exec_command(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'))
         exec_command(self, 'setup-alpine -qe')
         wait_for_console_pattern(self, 'Updating repository indexes... done.')
 
-- 
2.42.0


