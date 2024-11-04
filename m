Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54762D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ksZ-00025r-El; Sun, 03 Nov 2024 19:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ksG-0001gz-Cp; Sun, 03 Nov 2024 19:23:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ksE-0002rg-IP; Sun, 03 Nov 2024 19:23:16 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720d5ada03cso2294366b3a.1; 
 Sun, 03 Nov 2024 16:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679790; x=1731284590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQvvTBs9o0+GQ/IwCIJ/WgPOMyuLV1oDDUGAzHCQ7y8=;
 b=cAHgmpgV0UsE4dmyigW8WVoLberXmD82C7wMXJmE8ZNLkABR10GW5cmSwbT/BHiTO9
 pMYA28vPIlj+3PmgPH4CGzEIr2JOIKnaA/8bTRSjtVeom3vehyEnVSLOzS0GlAyCC1Ds
 YoOYcTuRLhHFU6ytoP3iR9qtVtAGzV5Wjg8Fkg5wt0zRaMFH4JyeYwan9cVde/zOGwLW
 JIItvCvv1R8etp5Y41yGc5wumNeTiz9BGE8fWOXupmCoXwBxUYHDheyKCTEdJmSp3CES
 sXdZ7PARffl1AezKt4Zbmpg+rn6oQTcHvrMPIt+H0aFM6CIVh3dJ2jZh86Zu80dAq+ew
 ndqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679790; x=1731284590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQvvTBs9o0+GQ/IwCIJ/WgPOMyuLV1oDDUGAzHCQ7y8=;
 b=kmZYJdxpXc7BMHqpcN6lJetxWge3LyUKrlSSnjk+uU/BBVDmOUZEyxW8X/te+WDjUD
 s08FLcdbBMOiZhY5a1MeoeQdp8zRJzBnRXMqo+HYMRBROk9oPDzkLvShsczls5Ihi6yS
 axf07keBoQoMKZOp3rHJ9VN/ZkCzaREMCvwF/OM2aGfbCEttNab/kjbeBKNaT9f437cg
 NWU5Bso19wpkHAK8XrQFfis0joDhsp3Em8vh6/CgoIJEZoKkXfOx50dn2mp4SEoQaLhK
 EOg26ahgREjyezOTFHy5DvrY/vRQLHaMoU2R74CM3iVh+o6R/FkGvIx2rKPuG8qe8nNj
 1aOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpVy4mhjOunlgm1VGGe8Ofsc9FkW0bkNJnJMhkUEMdANj5cAkLrKvOkAnAANEe+Rvc+IfL5eVQvQ==@nongnu.org
X-Gm-Message-State: AOJu0Yy7PHrw+IzoBHPXsWRxsGkdccBY/CAbLILpqwtaCI2HQgNeDQXM
 56y7QTbUycCVWh7e41BQQbH04Rxs0SUancSNNlimKtENSDIXrUuYvfos8A==
X-Google-Smtp-Source: AGHT+IGOyBcaFl4ICxeZZhHqBgL5UPV28AiP5bTcNaCZ5cYzHR37tcJpUSyai9vK8rxvMYQ2ZXRkOQ==
X-Received: by 2002:a05:6a00:92a1:b0:71e:4414:eb21 with SMTP id
 d2e1a72fcca58-720b9db35a3mr20566009b3a.17.1730679788463; 
 Sun, 03 Nov 2024 16:23:08 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:23:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 66/67] MAINTAINERS: Remove myself from XIVE
Date: Mon,  4 Nov 2024 10:18:55 +1000
Message-ID: <20241104001900.682660-67-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Working on XIVE has been one of the most complex and fascinating
experiences for me. It's been a real journey, and now it's time for
IBM to take over and guide its future. I'm stepping back as the
maintainer of XIVE.

Cc: Michael Kowal <kowal@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf8c9b379..840eebc944 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2618,7 +2618,6 @@ F: tests/qtest/fw_cfg-test.c
 T: git https://github.com/philmd/qemu.git fw_cfg-next
 
 XIVE
-M: Cédric Le Goater <clg@kaod.org>
 R: Frédéric Barrat <fbarrat@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
-- 
2.45.2


