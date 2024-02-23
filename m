Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB39C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXu9-0003pH-Ic; Fri, 23 Feb 2024 10:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhy-0005S5-0w; Fri, 23 Feb 2024 10:43:30 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXht-00066F-HL; Fri, 23 Feb 2024 10:43:29 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d918008b99so3553105ad.3; 
 Fri, 23 Feb 2024 07:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703003; x=1709307803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oE+i0wB8T8QiAUtycDHPhVOaO7KwBsgheydu+gbxs90=;
 b=ZXKmhcRR8tuBJf/TliKUPF0menUhIdKZONsE3b7CZt8D8KVZhwWpUosPs9F6z5u7v/
 mImfsMVai7iV9kcLsL8LxFv7JWVudHLP/L0TdigZEqqZceb4/oNKYKtJh4yUsggrjWci
 p+dgrKIt7WdCN9GWuVOx+7XcX4T371TZc3pDlfp8Yevq7oLxLWc311i1AzgDlLz6EYjO
 skj0o0OTsm8T+HVMO4axg45aKb+n912CrWI0GwO46MO0TYJk95GU2JEQYyZUxpaRUy1I
 oUyBvk0bUo2OXV3XhtGPSEbN51tLS1Y2VL2LjJ2VbvmArLzulV0IYxdLgOaPtfNSbG0i
 nCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703003; x=1709307803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oE+i0wB8T8QiAUtycDHPhVOaO7KwBsgheydu+gbxs90=;
 b=QVvP8iqSC5fAISeFYIrN7uuD7X297o7QJ3f3qDw/lCpQThPrHPb6z1Jj3pr+zlpFDG
 dzA/6x2uRs2YxA0Aea750Psb6GECpLyQDgmf4L9nH5j7ftqwlUkyYXBiKr+te3pVPYJe
 pBdUHxjiQ1EUbQrJSShGJEA7v/lxTj6QvwzUhWvHxHWZszELwB94xVStpj2Y8PnbKjLB
 RTKdzM3GTLXsJF37GS4jwvsYonmdE6OFIzvfL2tBSUuNpO8ZrPWxwDLfYKK3jJo0rDI/
 Bs+kGD13Rc9v9xG7uwS838A7TuMJHRQpMeP7wU+xvhVwbiVEMKnEt8ZCQtLQ7NRsG4/U
 PuMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNmG2pfMkc7jLRstXjsKnf7T040HUANSPsPiGgAnqvyoalfOFJt6EGyYNRG1lXcUvkjgxb2y75pLLBIZ+6mu1RpLXu
X-Gm-Message-State: AOJu0Ywgd0Pen1W5OiRv9ta/eiNBvF5H16ljPaSFIU/RloCp2YBnvdE2
 jwO3gDNmdpaSQ90pA024lWwG9NjsVTGczVxcS0/cYPTZoKZEA0PsU86cwM1i
X-Google-Smtp-Source: AGHT+IEunVq1h5DE4vFk1Tx1wGlgTQsFdYpywOWmqTh2xEUFVdIDKxRLPlHxvika79PPBTHxqdsqAA==
X-Received: by 2002:a17:902:f54f:b0:1da:22d9:e7fd with SMTP id
 h15-20020a170902f54f00b001da22d9e7fdmr185903plf.20.1708703003626; 
 Fri, 23 Feb 2024 07:43:23 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 09/47] tests/avocado: Use default CPU for pseries machine
Date: Sat, 24 Feb 2024 01:41:28 +1000
Message-ID: <20240223154211.1001692-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use the default CPU with the pseries machine unless there is a
specific requirement.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/migration.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/avocado/migration.py b/tests/avocado/migration.py
index 09b62f813e..be6234b3c2 100644
--- a/tests/avocado/migration.py
+++ b/tests/avocado/migration.py
@@ -123,7 +123,6 @@ class PPC64(MigrationTest):
     """
     :avocado: tags=arch:ppc64
     :avocado: tags=machine:pseries
-    :avocado: tags=cpu:power9_v2.0
     """
 
     def test_migration_with_tcp_localhost(self):
-- 
2.42.0


