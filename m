Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4FBC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklJ-0005Cs-UT; Mon, 11 Mar 2024 14:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklB-000551-6P; Mon, 11 Mar 2024 14:52:29 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl9-0004za-Kt; Mon, 11 Mar 2024 14:52:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e66da40b18so2020018b3a.0; 
 Mon, 11 Mar 2024 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183145; x=1710787945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Czg2StR8XjybUCCLbM84Bm4x8Sx+Jf8gI13TFlmrKA=;
 b=j+qJRGihdBYT+g0tkxn5bn95h+NGeuFOybzOKIrPADRLv79pAjOdIH45k9nHpfp6l/
 Zb71RZ8HQVWGupfTFBry9tgy6IjZ8TxY/9XJdJhwBVL3R+gB+Udvm8HxmTIOZ0sebBA0
 +cP45IDwEn8sJZ5te5NAt3UGkRCWlzgMh/T5PJ9JIG25GD5tGVP+KdmwNcYjLnAKSKNM
 tTMWJZ8X/P1Ry5swWqAkF5Pxp2JMxG8W/NtrlJ3CDW0Y4eK+aTcImKysoPQeab1i2fBp
 DP/43kjkdobgVJi9pmixLZDMeQCbBSEmKH/8fmXJ3FW+2mZ6OC3RUJYe8801x6ey7Sd0
 GDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183145; x=1710787945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Czg2StR8XjybUCCLbM84Bm4x8Sx+Jf8gI13TFlmrKA=;
 b=veUTo3P9KCJfTR0jAnN3Py1ID5Y9UXnaf5qqUO9dz2FZYEMLHBVcKtmR+QnLhYPJEf
 eqNYkmbi4rmHb87KN60XhXtz+QBMZdOc0hLIBCDN+y3h6JCol+vCwGhK5CLr0ewKsNi2
 VJVRjZ0C4WZ3I/jtBGo0HKP4P1a7DaHe9gNOovuVdT2EcRZX2eccxpqOa3sN+DuYZEao
 hBzRfNhJR8UIY5PjvOvaBxg7sQnz7G9HBV+OuEe9om9Xwk6dqtwBWjpFMlNAQ2Rmt7yZ
 Ea4mreMqts0akVdkvM7oMjoizrSsVCIscbqcZpI7IauL2y5KTYPkeQgcmq53CnHZtSZ6
 1kXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCQLfBxx6DzcNwq7FQby1LoOMyjrI2KGt5aRJjBtXim4TO7U3bGyVoOGwOo5FHQ9l8mOnAsc2iiItdL6TV1PVvnPss9LE=
X-Gm-Message-State: AOJu0YwAXPSbcl43M0JGmqcAQYein6guw7CtepnqxhL2BUZaUKOMRhtt
 3RMFZSkpGkyFqydU3RTvOYA2o31ibtE77Wp4HpPNeM75mMADuBqtVtaK3LpWS5o=
X-Google-Smtp-Source: AGHT+IE9GrKU41IPOzDNyNMBypUE/SDHbqY2egNUWA6P0FV9BY3m3xepWiiBOKzavqH9v2dpa5c+Rg==
X-Received: by 2002:a05:6a21:a585:b0:1a1:6a75:143b with SMTP id
 gd5-20020a056a21a58500b001a16a75143bmr5658313pzc.5.1710183145223; 
 Mon, 11 Mar 2024 11:52:25 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 05/13] ppc/spapr: Adjust ibm,pa-features for POWER9
Date: Tue, 12 Mar 2024 04:51:47 +1000
Message-ID: <20240311185200.2185753-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

"MMR" and "SPR SO" are not implemented in POWER9, so clear those bits.
HTM is not set by default, and only later if the cap is set, so remove
the comment that suggests otherwise.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7d7da30f60..247f920f07 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -248,14 +248,14 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
         /* 16: Vector */
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
         /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
-        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
-        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
-        /* 36: SPR SO, 40: Radix MMU */
-        0x80, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 40: Radix MMU */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
         /* 42: PM, 44: PC RA, 46: SC vec'd */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
         /* 48: SIMD, 50: QP BFP, 52: String */
-- 
2.42.0


