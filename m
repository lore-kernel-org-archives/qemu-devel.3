Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85261C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2Y-000093-4p; Mon, 19 Feb 2024 03:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2W-00005w-F3; Mon, 19 Feb 2024 03:30:16 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2U-00026j-8f; Mon, 19 Feb 2024 03:30:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so38223755ad.2; 
 Mon, 19 Feb 2024 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331412; x=1708936212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZINW/4P9SwnnIKpdjz8GObx2nHGX756vAFyLFtYVyw=;
 b=gtI84NhDTh8Gdegeu4XRolhPbndflvVR3oHwbBlFJnpTrINpXFYQK4siHkAdbtVmCh
 tEu6Nrga3ezfb8jMKJvWFX3th11W0y+/TO9vwuok5YGGH1tptB8pTsjCuSx1/leh/eRO
 1mlsLi/rAq8Vh61eR1dala7ZV3fOybD0gy4SQIWk0VFezTnH0kxFfkbdH+3agRZMvdtA
 JB97HngKgXMVrKexeepX5kfs5I/xKMv0m5/FDdOSm1aRnJwPhWXx3yJ8zUSzURp6xHs2
 EjY9WrGm4+CbGYm/JgN2XUz570OpsXhTdR3PtBzcrTbLxvPl+ALlelSugoSFbu2lLBn3
 yXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331412; x=1708936212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZINW/4P9SwnnIKpdjz8GObx2nHGX756vAFyLFtYVyw=;
 b=gDq0zvBBSRhlmOgMOMc8SmiP13/HYetHsQgV7h97rixnoiACFjE3SUk2iCiG3yCoKQ
 TAAtgtwb6F7X7mnfD05a0j66FuRQdJQOcd2xGqDbPR11u3xPOjrzpkXpXGrxhs6uKTXv
 DSn5NQMQyUD4TaIpfxh4LOND60rLNwKRe3p6AxLt7TiTJp9DYgKWdMBRIwaAk6SZ+9py
 Fff6s2aRgpVpE9PUd5oMZmR92LZJ1Q1mutaI/jlDyMx0iCqmfuqGPd+YVA4jbVaCRdWI
 SbPaclyBWJIz66634eHTJCiK5BxCTiNoByI8Ix3BJcCZvMLGScY65bdFYQI7tHV4aNjc
 0Iiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUltvvOChB5mCCqGbxMVA2XTvd+Jg8NmsHx4nWGn3fiVbQXOc/37ek4UuDqbA9bakVj8/ytoDHogFpyFCJB3Vjb8OrJ
X-Gm-Message-State: AOJu0YwWzAfWupkF3TDpfirLwUCh/3t4DPxuuX1leeaQ/pik1gRFCXJp
 VN00lAWKR8et3kjy613dwQTi3mc2cuNQXFvz/EBrxCl2aOzc4VuRsYN1Ip7r
X-Google-Smtp-Source: AGHT+IGSQ83rm05VZ8Tmm//HPkxcY0zEqLGNPbwLeh34Gc9UJqm0p2Kd6xvk9jATzNN6VjUuK0/AjQ==
X-Received: by 2002:a17:902:ccc8:b0:1dc:ac1:993f with SMTP id
 z8-20020a170902ccc800b001dc0ac1993fmr56567ple.44.1708331412275; 
 Mon, 19 Feb 2024 00:30:12 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:12 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 04/49] tests/avocado: improve flaky ppc/pnv
 boot_linux_console.py test
Date: Mon, 19 Feb 2024 18:28:53 +1000
Message-ID: <20240219082938.238302-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

The expected MTD partition detection output does not always appear on
the console, despite the test reaching the boot loader and the string
appearing in dmesg. Possibly due to an init script that quietens the
console output. Using an earlier log message improves reliability.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3f0180e1f8..af104fff1c 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1368,7 +1368,8 @@ def do_test_ppc64_powernv(self, proc):
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
         self.wait_for_console_pattern("zImage starting: loaded")
         self.wait_for_console_pattern("Run /init as init process")
-        self.wait_for_console_pattern("Creating 1 MTD partitions")
+        # Device detection output driven by udev probing is sometimes cut off
+        # from console output, suspect S14silence-console init script.
 
     def test_ppc_powernv8(self):
         """
-- 
2.42.0


