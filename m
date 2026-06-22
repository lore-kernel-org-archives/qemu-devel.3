Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A925CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmN-0004ft-KH; Mon, 22 Jun 2026 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmJ-0004f3-7p
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmG-00067O-QW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so28546415e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142895; x=1782747695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNNca2rTmvNpkzZ5xlkT0oe0NJHUtNG/NtDCClGF7RI=;
 b=d6t7+z/pOU2TRZ98evetiMXM3PQ1TIrWCXZjnYOnGuHya2f0m6ndT8ghFF2C4P0iSG
 ZBq9uV18daT2TSijuYX8NIqG6+ARZqsN0i+ag0Q9poVshc33+FEwiOzoR2zhBewQJLu5
 8trDxDUQKkbzKaNy5itX4lY8SQPfY6Ogifdvh1Or0kV8E781Q4zxSaLPL5REy0lG6+lo
 um0sl2lu9eMR6LRn2F4+NVyMPqCDXIAUecdu/uDrfFiluB6nzuYEoV3FcaI4sBW/MVD7
 jo30ksJ45qdmLjICL24iQbIsHD8uvEd6bD4EBdAPQ8Rev8MXwhZeJ8hxFwGS0Co42+7K
 Cp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142895; x=1782747695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNNca2rTmvNpkzZ5xlkT0oe0NJHUtNG/NtDCClGF7RI=;
 b=rjtJ7xHdIWhT/YhF81tURGPktt2kUqFTfLDuMqzUlf2y43TN4HyMtk0mt36DmOtXSX
 X6cEKa6z3FOoBvSvSJdQz86cns9Gtz9uS70XIItCmibDGEFXmEMn/8lvD4KJrvx+jvlE
 3Msw8QxqSD7Qni5/jA8aQ8JFhJdw77YMBaSGU3Zz8yAMIirbhnXuFPu6M3HEqMBxXgH4
 aOcNPKQeCvy6tHYWsN7OaAagP2WPQeUT/2tAUh3pDwp0YeEr4F7x8yRGEklkafD1CG/x
 qt+PhgTAf5Ex0cIHZZeuSw4EbQk7v/6gQNxxx1Zv6RJFJg9yVIRXWloXTmmZJFsK9xKh
 cadg==
X-Gm-Message-State: AOJu0YxM1npRCkBIZdz4BOexgPisl4VYZ2+7jphkmnbu+ZOA3m7XzWuN
 LSo76XowlMAyok5KXU/lbDreNwxGUfgQRBc6lW8hWGlbkrPPB/yzyjQzV/Hs1OQ/TMM=
X-Gm-Gg: AfdE7cnHk9nzLQGXBNnjhhGCph04tak7JkM3Zf6fhxvKDwtyi+8jQwo130DFV/ZMM+w
 YIpYqG8iwZurvrjQCbmwxsYrsu5b+BfQCBCilMYVOprBkBndWfSg+n6PbA7lnYikegJyJrI1aJc
 XrDO9zLK7k5MJYxqB34iUrzzLlyC5wmEI4pS4t3QXxwScvDUswHqOtuEF4aBkxaggRY/cjxQUTi
 RM90tPBj3nR3Eq6wyhUmiZsP3THksdXfm6knYz3UNoMeBdu+CkW0UetKjSxC5jLwrC3qL5yFq0V
 XtjTfg6fX5NZYHVL9hURt2ciyL87oyRWs7UVHiH2pRHQ1Z2A3ycAyDmv870qCW0x7QbCWemv7Mj
 a0QbbVX4/aQHgdQ71NQtMzPB+mZjwp1OGVrKAw6lkLYTed1dARvZroBOC+w+Ff8IM9GF/heZd4L
 Fj0EizecUnRNNR
X-Received: by 2002:a05:600c:2195:b0:490:e974:e006 with SMTP id
 5b1f17b1804b1-49240e9cc80mr173084495e9.29.1782142894230; 
 Mon, 22 Jun 2026 08:41:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm285071805e9.13.2026.06.22.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CAED5F8FE;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 2/7] python/qemu: split console from harness args
Date: Mon, 22 Jun 2026 16:41:26 +0100
Message-ID: <20260622154132.3166748-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Before we mess with the console output lets create a new helper just
for that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260619155657.944220-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index e8973a87394..18ee5ec0147 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -306,7 +306,11 @@ def _harness_args(self) -> List[str]:
                 moncdev = f"socket,id=mon,path={self._monitor_address}"
             args.extend(['-chardev', moncdev, '-mon',
                          'chardev=mon,mode=control'])
+        return args
 
+    @property
+    def _console_args(self) -> List[str]:
+        args: List[str] = []
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
@@ -372,6 +376,7 @@ def _pre_launch(self) -> None:
             self._wrapper,
             [self._binary],
             self._harness_args,
+            self._console_args,
             self._base_args,
             self._args
         ))
-- 
2.47.3


