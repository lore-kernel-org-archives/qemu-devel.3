Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EE606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHG-0003DB-1V; Thu, 05 Nov 2026 03:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHA-0003CM-CR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:56:52 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtH8-0003bT-8N
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:56:52 -0500
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso840080a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869007; x=1794473807;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DFUwTGhxs+oQlqKi2Vl6ULXqAEARBQBYqw7B8NgufZk=;
 b=IAbxshKNJ05O1LSMJBL03Mi/5xMHFCgNNlg5XNZVtrOv61JbQSsOWhPyNFqO23GdMr
 CJce2Ixz9QTJ2psazgp7goG2cmhwVk0u3w7QPpNh6/cm09+SKULVTAuunat4xZdXpogL
 q2R1XxvxcA53RUGhcvv5PTVog43YrMru5nhFBnkTLXrD7QoVzvEQSE2b0PYlf4r3uD/7
 P3UL+bcZ8JeYMtVaNDuGFOgfrYI519YOCGmxq5e0VjfsGoz9C7/g+V488XqROdf4pKF/
 mCcHgMvbGsp5gv+SeV/zWOuWcRvJ6Qt7eHAwOIRiJuzGcc59IS9nczD/v7DX3CLEKRlG
 UFFA==
X-Gm-Message-State: APuU4Z8flgCwO2Dm3IfK8YkuRPQZ8tfGEiMJ5CNnYKkFmJx+HxyzZ2r2
 dDR0q01mhPypZT8au2EolLxeYtOJDgi0ioVouQCRRzExblzJG5MpAkRexDXQ8w==
X-Gm-Gg: AYBFou0jVYzw675fHhA9qW04G/mJIUglxwFTHhs0MPwEMDH5OkD4EGqSo/RGkKKsPkV
 Qd7eCVq6N8+mieleONPQwZ7SNrJY/sr9hbCFw2/mrZhmuZSIZfA3BrbMIrU1XkffRjQdS5u+HpU
 QoizqGO2zpyiVyN9GFMh3EnMR5vHOVVKbBPsM8OIAZLU/IEzlSaFTkzAKN+UHNnmNHNwIaaQ8hI
 W5w3//chegccVItjFZbv9RW2xPv41Gpapi2wvb8QgOYEdOohRhadgDrNu5IBCsYMK2XN8iiHk1W
 TAA504qs/x4yHmKhdiGCmTHf6fZCEF6vWTPaYjl9DadyzpnFnpuhVvsZTUhqMbJ1fmfIYiY9aGk
 4Hhn5//BJl9TKDjrzXm1qRQLjBjMeItSS2YZY46veTSuC2jpsPGcrMa789YL+WJirEKkeNkHQQz
 D8FLBjuhMPeC7m0IGhAV8WEhyaJYZIF73oUbvZbANo2D9W0Wz4o6CCnriJ8roEAmsbfBuIEPre7
 hZbITQCb3hA8AqNye6N/T2Bu5LpPc0InP8iE1SiPwsMQ0kDMpqhuEY4Q2pFeBxAIFsn6RFP2x8Q
 0qu3CbXOX/AhaZ4HLZ9IlVwZh/8Nyq8//w1+2YAC+nHfhY9l1fK39ijChP9rm2UklBG4BsmyoH2
 Eh84Z0A==
X-Received: by 2002:a17:90b:440d:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3ae897f8c6fmr14250848a91.30.1793869006695; 
 Thu, 05 Nov 2026 00:56:46 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32b2b57sm3113861a91.15.2026.11.05.00.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:56:46 -0800 (PST)
Subject: [PATCH 00/19] hw/rtc: DS1338 improvements and DS1339 support
Date: Thu, 05 Nov 2026 16:50:36 +0800
Message-Id: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVRRXAVsdB2MBZIp0Qivbti+
 Rb/38DoCBna5AaHJzFta4RMEzDzsE4oyEZDnuWVlFkpnDfCslSqEapErY2tKyw0xGB3ONL1zbr
 +Nx96QePfA4TwAEMSD6BuAAAA
X-Change-ID: 20261105-rtc-ds1339-35ebbcd86e4b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868639; l=2084;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=chtMKugc4RKaG7rWkmc1YhD2UCT1+u+4sNSGG3jdCkA=;
 b=PKaUakKXRCjpjja4W3n8M48w7Moaq5Fzre8b+jf62IlzJEIDeRjuM3JrzTFwHUJFBXSJrJMft
 bCFGs8MN9nUARCUCE/CpMNHN9059dhEBLu3YunLuppzEBvTzjZZUZXE
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based on master, at:
  f29ccc287a

Add the DS1339 RTC as a DS1338 variant. Improve the DS1338
implementation with support for the clock-halt bit, and a
"persist-on-reset" property keeping the registers across a reset.

New qtests for the DS1339, plus DS1338 cases for the register map.

The DS1338 vmstate goes from version 2 to 3, but older streams still
load fine.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel Blot (19):
      hw/rtc: ds1338: program the clock from the time registers
      hw/rtc: ds1338: implement the DS1338 clock-halt bit
      hw/rtc: ds1338: refresh the user registers on a read rollover only
      hw/rtc: ds1338: add a persist-on-reset property
      tests/qtest: ds1338: cover the DS1338-specific register map
      tests/qtest: ds1338: cover the power-on register defaults
      tests/qtest: ds1338: cover the clock-halt bit
      tests/qtest: ds1338: cover persist-on-reset
      tests/qtest: ds1338: cover the reserved bits of the time registers
      hw/rtc: ds1338: add DS1339 variant
      tests/qtest: ds1339: add RTC test
      tests/qtest: ds1339: cover power-on defaults and reserved-bit masking
      tests/qtest: ds1339: cover oscillator stop/restart and time programming
      tests/qtest: ds1339: cover the Century bit
      tests/qtest: ds1339: cover the end-of-month rollover
      tests/qtest: ds1339: cover the 12-hour format
      tests/qtest: ds1339: cover the day-of-week counter
      tests/qtest: ds1339: cover persist-on-reset
      tests/qtest: ds1339: cover the migration round trip

 hw/rtc/ds1338.c           | 353 ++++++++++++++++++++++------
 include/hw/rtc/ds1338.h   |   3 +-
 tests/qtest/ds1338-test.c | 191 ++++++++++++++-
 tests/qtest/ds1339-test.c | 581 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 5 files changed, 1054 insertions(+), 75 deletions(-)
---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261105-rtc-ds1339-35ebbcd86e4b

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


