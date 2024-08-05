Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69819C52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasnJ-0005by-L6; Mon, 05 Aug 2024 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejasvipin76@gmail.com>)
 id 1sarlB-0005AX-Gh; Mon, 05 Aug 2024 03:04:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tejasvipin76@gmail.com>)
 id 1sarl9-0006QX-QD; Mon, 05 Aug 2024 03:04:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso93081965ad.2; 
 Mon, 05 Aug 2024 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722841437; x=1723446237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CI8oUk9cDQT0xO+kzgQaEwt83ymP26MK6WYI8qZRMfU=;
 b=EB0BVhJ5IU5RjG07i7a/bRR06Q3tJtbvKxbVuO6SElZCOYBHlQcUupqHqHEWUNwN2m
 mK/lDhtnPoNF8LK/tnk7/YaG0qh6qWqZ2Ctsv1GW0tOnJV+vRZOZvW/kWAu6YxMMoIMF
 5XL+DTkUzLyuN0xVP/QBsp+b/WnT/dL2UdRCXD1eyyZ54Ls3aCHsfjeHJ/xdTaz/Gdrc
 xEaZ8cvFJO1hDSPjTBrPFxJb6ZI6gXneEBPWHQM/fhWX2+JohRerM3K3GWPaquAYl8cc
 LdbD9GecYmdKlK8rDVWroZmXwNbfCpk/YMegnY4JUOHWVpBvmqiR2TptTGb9lz7UbrFP
 C7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841437; x=1723446237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CI8oUk9cDQT0xO+kzgQaEwt83ymP26MK6WYI8qZRMfU=;
 b=Z0K7pB/3Xfv6AD6cq47MhK6q47XKsQGi+tznr2pT1lpzeaVbNfGX18SyigZ49JIfSl
 2M/35OhcnMTK51819VDIrwKquuLHMG6YVaNOXzmQnUuhNLraplscKfH2LuLRZJYA5Ttv
 5S7xLGgFBn5X1seJFj0Uysn00GO1cHtGXFrSM/8vH3RF1XOootRrZYYt6ygyIYXc1MvM
 dc11nATTm5wg0Hbv41rg5yTOjNXl2wf5M3Y9lnPNCs5hyGOL7ufXurCCAiqForBW4i3g
 14r37N5HQgxxq2drmdhTxFvClltBde0iRQ6oggowP8u18ORAjod4uTxCBq/5zTvOtyi4
 QwWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqOimu/xjza0OT7AJ+O5GeyydUoJ8CVsb/jA00Rh5XxRDIJozduk1Sj/DSH6r3sozA+JIkKmth32pN6fu4k7EiPrPYiHphZJejErFh5agbmgZzA9BqW6SmgoE=
X-Gm-Message-State: AOJu0YxnnLlJfpL+PYPV0PhhnNjN/a8h+ElzWkuI64rMyMLhoxrraMoN
 wdFO33HHC2Iz2EYjHyWICvBeCsW+QSUrszQ/MMd+pJy9MOQlMKthdWiCZA==
X-Google-Smtp-Source: AGHT+IGrtMHEg4AyILeHsdYFvcHAlvPjLrfdBcTVfRl5l3dyBpDZSxm2jan73XLYsJasnReFMcDL9w==
X-Received: by 2002:a17:902:d4c5:b0:1fd:5e91:2b13 with SMTP id
 d9443c01a7336-1ff5722c06bmr153488205ad.1.1722841436638; 
 Mon, 05 Aug 2024 00:03:56 -0700 (PDT)
Received: from distilledx.localdomain ([14.96.13.220])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f26f4bsm59929585ad.34.2024.08.05.00.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 00:03:56 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: mark.cave-ayland@ilande.co.uk
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] ppc: fix incorrect spelling of PowerMac
Date: Mon,  5 Aug 2024 12:31:50 +0530
Message-ID: <20240805070150.369824-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=tejasvipin76@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Aug 2024 04:10:15 -0400
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

PowerMac is spelled as PowerMAC (Media Access Control) in some places.
This is misleading.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2297
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 docs/system/ppc/powermac.rst | 4 ++--
 hw/ppc/mac_newworld.c        | 2 +-
 hw/ppc/mac_oldworld.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/powermac.rst b/docs/system/ppc/powermac.rst
index 04334ba210..3eac81c491 100644
--- a/docs/system/ppc/powermac.rst
+++ b/docs/system/ppc/powermac.rst
@@ -4,8 +4,8 @@ PowerMac family boards (``g3beige``, ``mac99``)
 Use the executable ``qemu-system-ppc`` to simulate a complete PowerMac
 PowerPC system.
 
-- ``g3beige``              Heathrow based PowerMAC
-- ``mac99``                Mac99 based PowerMAC
+- ``g3beige``              Heathrow based PowerMac
+- ``mac99``                Mac99 based PowerMac
 
 Supported devices
 -----------------
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index ff9e490c4e..9d249a506c 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -571,7 +571,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
 
-    mc->desc = "Mac99 based PowerMAC";
+    mc->desc = "Mac99 based PowerMac";
     mc->init = ppc_core99_init;
     mc->block_default_type = IF_IDE;
     /* SMP is not supported currently */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 1981d3d8f6..eef3261002 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -411,7 +411,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
 
-    mc->desc = "Heathrow based PowerMAC";
+    mc->desc = "Heathrow based PowerMac";
     mc->init = ppc_heathrow_init;
     mc->block_default_type = IF_IDE;
     /* SMP is not supported currently */
-- 
2.46.0


