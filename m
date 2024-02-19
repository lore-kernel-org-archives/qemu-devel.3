Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF83C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2b-0000AD-KT; Mon, 19 Feb 2024 03:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2Z-00009Z-H4; Mon, 19 Feb 2024 03:30:19 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2X-00027M-Vd; Mon, 19 Feb 2024 03:30:19 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d7881b1843so34357515ad.3; 
 Mon, 19 Feb 2024 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331416; x=1708936216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbqCxehm0a8dcFpNHIyygMku+fKTrkl8BbyDwKaDinw=;
 b=f9UWMqLrhpWiJAijrgBHJxKwvQmHhkNQGuGJYY1tbokEk2YTH9RIFVd34YUnDRsVru
 cTrYzKfkbKWsNO4m9s/YjeLKRisGp7fgJYGzWga43w4wFLrU6EUjNBBczJhVuGzcbf6M
 pzU6op5RJyHhWGATd32ZUqayXlmywOZHfeH5oWUtmLFI9a3FJkEVr0Tk+z91KStbSywp
 0+TPrVi8sMNW+cw9Wk2Q+gUElYhncIn8TEjqQdJlihYofrRmUTwk98qV5oIVOSreRrCs
 UwigVoZPIiKG1vx5D+wQpdtWWgxT/9EKt8Dr3TlmKKc9eDiDHTeCQOOsN63T8kWYjdaO
 AGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331416; x=1708936216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbqCxehm0a8dcFpNHIyygMku+fKTrkl8BbyDwKaDinw=;
 b=Sz9D9XrXA7H+ycjvCQs6kqeXMyrnPkVi5zupGLIf9pYxq+/+Dx+OeAPNps9phNunQ7
 uPcTg3ZLoxlNNDjqBahT5crXvpHkFq0VBbb11XFitjmxq1kVadRwxKQBn40A1PfqVTf/
 M4w66RBssZMz/wPCoW2gZURAJwwb+xn3l6O9BYzgAybZqCwis+OyJ6YdhEA3yUkec88k
 ehZn5dj7J66NLSKebfUB4xoFCMjk1xAEy1fkdTJBUkvzEIzWqq+5wNgtIkptuVpURFna
 pq94EC0tiBczwC6APmR24k6T1YPTcOSLMvg0JBZ81MYOABN2bu9Kaiwzt9N/I4KODeSL
 83Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpNi2h9MWbusnyFAt+2O/eUCvtPaDxsGQYAW050DZNFQjL8zO8F/azMN6kClkqxI8Ya7biltRQFGlCA84wQKUkIkWC
X-Gm-Message-State: AOJu0Yy2JxxXIz45xrFDKAb8ZNgJcFIQEWDWY4u6XSTjZ38vb3sX6PB0
 mkHXMRE87vHPEp0CVcoNNzDwMBgVXXUbLnFyDNnt8+e9tWnQhNyus7p1h783
X-Google-Smtp-Source: AGHT+IGnqWEr76zPlLUKvxR4MF+rRTZSmr2EaSTyEbOzzgbKKYG7tGPcgRe5dVMQAnLY6gs8CKTrCw==
X-Received: by 2002:a17:902:784d:b0:1db:9fa2:3408 with SMTP id
 e13-20020a170902784d00b001db9fa23408mr10079682pln.42.1708331416035; 
 Mon, 19 Feb 2024 00:30:16 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 05/49] tests/avocado: ppc add powernv10 boot_linux_console test
Date: Mon, 19 Feb 2024 18:28:54 +1000
Message-ID: <20240219082938.238302-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Add test for POWER10.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index af104fff1c..a00202df3c 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1387,6 +1387,14 @@ def test_ppc_powernv9(self):
         """
         self.do_test_ppc64_powernv('P9')
 
+    def test_ppc_powernv10(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv10
+        :avocado: tags=accel:tcg
+        """
+        self.do_test_ppc64_powernv('P10')
+
     def test_ppc_g3beige(self):
         """
         :avocado: tags=arch:ppc
-- 
2.42.0


