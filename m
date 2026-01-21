Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697FAD262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 06:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viRnS-0002TL-GH; Wed, 21 Jan 2026 01:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1viRnQ-0002Sh-PF
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:34:28 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1viRnP-0007vc-AN
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:34:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso36073175ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 22:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768977265; x=1769582065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLyFU6JJzHSGb0nMOP/py68gFHq8tNFVvbuPdW4PqOk=;
 b=I9tx8E9w99iMqDyj/sKmD//N8YxbiLcCs7wDOKt7VWx+g+Y5ZjFuqDvvSM1e3p/k/q
 /MLFmdkxBAyUAJlXFeT2m3NW81H0hVGG3P77A1uuI/XFitwmbUGdKkbD9qGzEwarA3Oc
 gsl3fZ1eDMN9Cy4v8E9Yq9bmuWiG39VK993H/fCC8xVreb3m+f0S8NOY2oiY3aJ+UImm
 4Pp7cB52O7Bj9u7IUM0FAkgSfZRlFFhP8bsPdPWHLZAF9/xQtbLaBn9+0TWYzRvw4tim
 Vpn4SKwxkxttub6EF0xwFqhAQSZbvS3huYyDxGIACHVGDX8SkIYSfeuR6uihL1SJh8r/
 YO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977265; x=1769582065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLyFU6JJzHSGb0nMOP/py68gFHq8tNFVvbuPdW4PqOk=;
 b=ufEs0UtVogXk0GWnHwEeDvuxnKHLjGluefbweJmiuq6gSm4V9k9vNVKYkqrcus5R0I
 d1h87wDzvSScgOBDyWh7orFf2N/eneUnpln2W3OwDm3svdMDB4RVyiCG76K79Gd/8pPR
 SKOpL+wa3t9l1doBuBs8afGfBoNg9oFpwtv6IziHLJabRDxZiXGdIJKc43oqzqTdxFsC
 7EBLXddUa15OVWETXu3m9ikc63Zfb0YYPSNavcTvhX0QryFWCIhEOSZf8Gz/JO+zjh5t
 KCPJ43+huqVHqtd72WCEJkmaBguuGSuKXZCJ5aHs0g5UnJAUjfiRN06R/fLTefy2x1ii
 3psw==
X-Gm-Message-State: AOJu0Yx4ssCJvBEmE5UCgInEw3bGzlBOSbdRbomLLC245a+v5b5F14RF
 BGAnEjK1hJrWEJ6SZtcr+1rblnID8aeN73am9KlC9gfKCb1sU8TiM5LUxDqPWtQU80OJnb72Fnw
 ClcqfU2Ogz7F+TWGSfYnt+81ZxcxI9nNHCGlbw+5K6n/XtNBBRwZEHN5BD5qie5PbPrOD8ubA57
 cMa/hIAH4brQuV4tfh4IKZLCuSKXcS4PWYbs8XgQ==
X-Gm-Gg: AZuq6aIlM58Ky8oRhKOtRfg6l7Bm0Wm4KHsf6MyiIy48yedw0suCXsE8fkZrmk5BaIQ
 SVq6jwgHX/LHyopxNbKpqmIAZR88IpUZgieqXRQZ4YX0A+VfBTE7LxhrX75PGpRBxnILg/oV1/x
 BYHx43KAyOiNvOThL1t3+ACU251ixke+tCZM/yzPNFPka90iRw3194QLbdHdLR3klMtWDAhKE3Y
 +G9oNNaf4Ebf/17q00+GSU6/yk7/ErPU6tuAcz1fnFmIUDXDLaazDGV8Wd/mgmJQMl9hY2mT5jT
 1jZYSQyUyhFju5THON2bvlJNZGfoQaagz3gDV5wGzBeioq1rUD4qGq83lGkTy50wOCz3CDGwaw0
 3Frf7B81y3s465DODXfbpjESr+z+CRthHWXhPKsWRbHbrX5zyVI33/E922HA5erz00FvVQZyubM
 xNgsn1EFFm2NTUPdoXun+p2yiW5m1Kaod8
X-Received: by 2002:a17:902:e5c4:b0:2a7:99c9:1086 with SMTP id
 d9443c01a7336-2a799c9178emr17212235ad.47.1768977264731; 
 Tue, 20 Jan 2026 22:34:24 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb7fsm143216645ad.64.2026.01.20.22.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:34:24 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Markus Armbruster <armbru@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH] hw/vfio: cpr-iommufd: Fix wrong usage of
 migrate_add_blocker_modes
Date: Wed, 21 Jan 2026 14:34:18 +0800
Message-ID: <20260121063418.2001326-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x631.google.com
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

The return value of API is 0 for success and negative error code for
failure. We'll check if the return value equals to 0.
Also, the MIG_MODE should be CPR_TRANSFER and CPR_EXEC instead
of 2 same bits.

The API usage is aligned with 'hw/vfio/cpr-legacy.c' after these 2
changes.

Fixes: 3ca0a0ab05c ("migration: Use bitset of MigMode instead of variable arguments")
Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/vfio/cpr-iommufd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index c244db88fbb..6758c73b6b9 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -159,8 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
 
     if (!vfio_cpr_supported(be, cpr_blocker)) {
         return migrate_add_blocker_modes(cpr_blocker,
-                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_TRANSFER),
-                    errp);
+                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC),
+                    errp) == 0;
     }
 
     vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
-- 
2.43.0


