Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73FBCD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqpi5-00032N-4l; Sun, 31 Mar 2024 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqpi3-000301-2S; Sun, 31 Mar 2024 03:34:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqpi1-0002Jb-Ku; Sun, 31 Mar 2024 03:34:30 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ea9a605ca7so2212987b3a.0; 
 Sun, 31 Mar 2024 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870468; x=1712475268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNe5dOzqOeierXs9KtggpyMYBczM9maytA5+1Uk3r58=;
 b=XnhLq2BnHSSj0vxToZR+C/RXURCpzL3s2LeHQ29uZhLjuxWJGqj9sBio9cQ8qEbCsT
 ofAByzNBzoqKRSjbjRGh9PNPMqV2UXaio97kugLBhsGp+gz9hbkoJ4CI9aFh2gpWd7OG
 9ZxkVWgAV5cTPmiX0sPaH3ebfSV7r20NUm5sSUq6LnTMLiPOnUVRJ4z+klxFy1Q8ZJIL
 fD8y8EbmiAZeBmDFlmqUc6Pnnh5QybVKNkEIL8dgBs+Gy86N1Q6VBoT9RuNWjkqgW8Zd
 MBom5Y0BvfzHOQ8p+CT9bmzdyvYEr6A8qEYjLQWwzdahOxggI101GEtDEsEq7VrA+QqC
 2eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870468; x=1712475268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNe5dOzqOeierXs9KtggpyMYBczM9maytA5+1Uk3r58=;
 b=nXfyGNC9Cb2DN35jahUnToeaemsQ1NbExhfkdSWawOs7t6Ic6bLVjtqI1I/RlO7UJr
 r8u9agTH6yIc12G1ur/63vQC/1jUQqamF5k5GAX7w/sfBuPht6fvr6cAGqaxrMcC7v7J
 0IgQjvG8G07nCN4sYaqTf8mj0qC6y/ab73sVAIv5Y/OTaaEjcgZXIJaK3g+q5bcLUcBk
 sOdNLZDyDUKw+hVFR5M7WN6ebErpnhb3w0Oe9XExgTfqP32vlphBdXNT/pSRD8lmekoG
 xGB/8pleoiWyPX3UxCHFsD2q7czgRBNJ+f8RMvFiy7ZYjKdtRtICpZfRoxRwe82b54bX
 7fhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOHyHdqxM8BaDTPKsaucBVkyZYEbHVwq7IR+/Qqc6owQJ23Vrsj0/cPCIhsJ86gWdQf0aDdouCvgSrslCv7gC/5jD2
X-Gm-Message-State: AOJu0Ywm7q+Xq9LeCR2tVLsUgDY471ndqbvvwIPyWgQos90D/eTuLW1s
 8LXLXNHsqL0L7+IPNPZ5k6LHmjr1cKQyHFRHrHOhgE7+JIsQDgEZL4oieeC4a5Q=
X-Google-Smtp-Source: AGHT+IGOSzte/modj7JZksb7ZDiiiXJEXTZBZionLWBAORlBDO8GB9MrtlKvxNxO+cpLuzT9XMINIw==
X-Received: by 2002:a05:6a00:181b:b0:6e7:6bc4:ef8c with SMTP id
 y27-20020a056a00181b00b006e76bc4ef8cmr13846300pfa.3.1711870467662; 
 Sun, 31 Mar 2024 00:34:27 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 8/8] tests/avocado: ppc_hv_tests.py set alpine time before
 setup-alpine
Date: Sun, 31 Mar 2024 17:33:45 +1000
Message-ID: <20240331073349.88324-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Fixes: c9cb496710758 ("tests/avocado: ppc add hypervisor tests")
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
2.43.0


