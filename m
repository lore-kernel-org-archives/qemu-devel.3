Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07038C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz05-0003qm-DT; Tue, 13 Feb 2024 15:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzt-0003Yx-Rs
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzs-00029Z-7A
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dIHxPmxBRjAdkbTgjMO6HK+ZBxRAFVh/P8ME+umupjM=; b=Ern9tEG4vaDqFP6HfR1ItMPg6D
 2YkZE2Il73WN+Lvb9D6EfxD/s0+5cLzyZUE93Fgk96KNIfBVgnpZcrr2ExYAfwkNwnMuyXLFm41qo
 n4RCjtWW9c2Sz8/O//45bjDGabw12eNBwQWBHHKG+Ayh5uaUMdCR+JQe56kWK8rOE1pPtrpR4xcCz
 XVGiZzVKXU0XhhyVtJbpFyxMYDfORJ3UYJQbW9NP6TIzQMHlaf9y1Ug7K4IbJ2epFkjmZC7Ho4Md6
 BZh/3fo4YP11epxZ0X4ciZqEFLCVhAL9F6B5TsgossfkAcNAs8pU1czlGGRtx7Au3sRVj9JQ246i1
 8XECDtYybB+QpNEZdJOjcGfy/DwWPPdyjnrMcfMmCc48bYopIXNfdwEk0nkxmmaadjgVR49v7wMBL
 K2nbfPWsgV+bncvf9+YJ3wHd6omaeKckSG+CaP2lzHtpuBRTYTCnsCJCpBVVGJELjmLGvhY+jLjJt
 3tL0fj4VJfLKddudeuDH/zRkdQ6LoxBExCHgOzzi7r1PUNx4vc+IcZVkuNOqAgaa8NUBCQGlH32oI
 I0zGALvhDejdGqcVjZC48yjDagP0R+9GJpXxHoccFPcrn0ISzt8ZLLy1w3mq/iorlSMn+rQLpIyXy
 9/42hDCWExlSAEg5y20vSvjsOj3ytiq0lSvy6nu1U=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyiB-0008m4-5T; Tue, 13 Feb 2024 19:44:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:52 +0000
Message-Id: <20240213194052.1162753-89-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 88/88] esp.c: add my copyright to the file
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series has involved rewriting and/or updating a considerable part of the ESP
emulation so update the copyright in esp.c to reflect this.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-89-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b8762d5ee0..590ff99744 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2005-2006 Fabrice Bellard
  * Copyright (c) 2012 Herve Poussineau
+ * Copyright (c) 2023 Mark Cave-Ayland
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
-- 
2.39.2


