Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDCFC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3C-0000QD-RK; Mon, 19 Feb 2024 03:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2w-0000Ka-BY; Mon, 19 Feb 2024 03:30:51 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2u-0002DF-Mc; Mon, 19 Feb 2024 03:30:42 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e32a92e0fdso163192b3a.0; 
 Mon, 19 Feb 2024 00:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331436; x=1708936236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oE+i0wB8T8QiAUtycDHPhVOaO7KwBsgheydu+gbxs90=;
 b=j0Mn6XhF9L1okKTehVpegbOd/vkPJXk6N0MUwqa8ERrfj3oYRu4G2qQVfdXOF7vV+j
 hsBt5YlKAMufvR4KrMVtS9QxZvTZg3UllrG9sjRZXMUSjaOagF7Y0FKPmF5nBoZddqHO
 /pzhEFAne+8uFX2IHBz43pMGwsfpNULIjsHXYSiD0GgGjv3G8S//39+UbLeMzolZo42P
 p5LVBF0Cg0/E8DjtzqsWK1jfu8GUV781Sl//EJi6LHWqD+QFpnmzgYwO6ud2oNI8oTp0
 tjkU1WV3LDRDpfSlJqWobBgYYDZkqUCKhkL7HdU5LKNGYp6nE9KetMLICR8dSMQmVsuJ
 MNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331436; x=1708936236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oE+i0wB8T8QiAUtycDHPhVOaO7KwBsgheydu+gbxs90=;
 b=msqEyOyn6oMjVR4THzePMQvJ5mKesh7LTJnz0qNJeiS46IzQR4TPJosc1Rn6n5W4WL
 oVa46SnQ1mbhXytty9+RdsFzp0WghlaBCN4I2rjG4WiiIrWAWrc920B3MZZ8O+Z7JfNr
 MEV5Dak092u9Yx5uQgXZK38klMBGTWK6KYBZH0sF7mHpcBAp7E3MbverRwF5JUOKYEKs
 yH2Qaoaknukog+nl2Ghs5kw+ShdzaeYUSNlTOOHYI2FB/H/AcCuPIKSmyKGPk+MGk62G
 Ow9VtH6JTgLRzf8qbtTd9A2609Bag25hRHZIdvHm2u4G3sFEOdsvVNxBDbuDWGWjYd8I
 bcFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFCwLzZEqugkJZeiPEKGOAQeg88v2dlqwDIxrAWKM83CY+4iME+MBLJfmdZJ7HS0hCMEPALl3pXzqj3yLPJI8Sekzu
X-Gm-Message-State: AOJu0YwLTTSDpw2avOxZBM3tSbg1zx7l1WcjVUHbMR0/wSrAJUHtT7JO
 EHZR+VfK+SvTkHaPZjLw/UCbv/t/cNWRyIkwv/7nipCXihRh17YFE2kkSt1g
X-Google-Smtp-Source: AGHT+IGZ/rY5IRufE+E/alUEUdREQTAc1PgYRApdcv8yC/AV6/jludzemk1iIpvVHPUqn/Pw3fkNuA==
X-Received: by 2002:a17:902:d2c1:b0:1db:dd24:9945 with SMTP id
 n1-20020a170902d2c100b001dbdd249945mr3299934plc.14.1708331436381; 
 Mon, 19 Feb 2024 00:30:36 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 10/49] tests/avocado: Use default CPU for pseries machine
Date: Mon, 19 Feb 2024 18:28:59 +1000
Message-ID: <20240219082938.238302-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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


