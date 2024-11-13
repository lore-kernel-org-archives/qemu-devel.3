Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7E6D637B3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJnK-0007TM-81; Wed, 13 Nov 2024 15:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJn9-0007PR-Eb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJn5-0006OX-1w
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731528998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpMfqeldvMbPLP14S9UOP/iadixTEp0ZhzeI0was3h0=;
 b=EadsIVr0N+w25iOTq9lY16GYwihmk4+2Td4l63SeBe6izNBE7D0akHCzaBuQlt9yiWGt6D
 xJihDCvEN5Bunhm0XA6IvLIjH/NIuF1JCof6OSeDaMUIJbkqjBO3KCs5HUPE3Pl4JpJ3+i
 oMVH17G2TMU1a53Qo96jZ/pq1gKJ10s=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-N1eu-ZN9N32K1vVCzOxFEQ-1; Wed, 13 Nov 2024 15:16:37 -0500
X-MC-Unique: N1eu-ZN9N32K1vVCzOxFEQ-1
X-Mimecast-MFC-AGG-ID: N1eu-ZN9N32K1vVCzOxFEQ
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83abb164a4fso789968739f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731528996; x=1732133796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpMfqeldvMbPLP14S9UOP/iadixTEp0ZhzeI0was3h0=;
 b=i/L4oSujprzMmIhJsfZeSM0uEV7LM6x/oXsBX7LadSUFJXAvkq2J2kxurjAQ9GL+J2
 VCdNNvTnnTQ3aoPtqcsP7g9c4bQuT8IydDFL9rxstNdh7Xg2j2YxU2H2j1OsOw5W36jz
 6NXI9m+8wxTReUpOpEebQt2LCiMgKX97Q2wdl+kTEybKglOVm1lj2sVcJCoNEomhHc/8
 5LQ+pc+hE0AI98NID2Mq/nNnjnttlobk/ok2maPfqpj+FmPEr7mCReW8dBz7oUrrge1a
 5G80AeL+rJz+07fGxgDpcaYJnyPSH7tlhvvJur+Z/dHUIArCcBU+vDKGLFCxjGwRzc77
 RD/A==
X-Gm-Message-State: AOJu0Yz26MnF7qNeVouu1mUHL82RzANy2SdKdUmfJ/Sohe8Yq4WcNd13
 LCyIqSB0F8mFUB71uq7LzlwHnbl0bjK+cfQRdhX45f+EMXT2bYsJwBkOKPlM7zu9RnxAHwJq3Ds
 d0xVgZT44/KKUJazYvIHnNnLTkt3EQ8VC112MiNYth6vpPO5sCspwn3XXPy0U383FVx7xXnE3X7
 bRmrFU6eTtl3V7p2KMUiDk7O48+XvS8+8jPg==
X-Received: by 2002:a05:6602:6c06:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-83e4fb294femr541866439f.11.1731528995730; 
 Wed, 13 Nov 2024 12:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh+AQSBIDxvkvcjrdPe4rptpykwQaXS+Is6xnJQAUuMn9izTtiVQhHhlb3AYO+/mZLVYPUFA==
X-Received: by 2002:a05:6602:6c06:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-83e4fb294femr541864139f.11.1731528995348; 
 Wed, 13 Nov 2024 12:16:35 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132239bcsm280419039f.10.2024.11.13.12.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:16:34 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Denis Rastyogin <gerben@altlinux.org>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/2] migration: Check current_migration in
 migration_is_running()
Date: Wed, 13 Nov 2024 15:16:30 -0500
Message-ID: <20241113201631.2920541-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241113201631.2920541-1-peterx@redhat.com>
References: <20241113201631.2920541-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Report shows that commit 34a8892dec broke iotest 055:

https://lore.kernel.org/r/b8806360-a2b6-4608-83a3-db67e264c733@linaro.org

Denis Rastyogin reported more such issue:

https://lore.kernel.org/r/20241107114256.106831-1-gerben@altlinux.org

  In this merge, the migration_is_idle() function was replaced with
  migrate_is_running().  However, the null pointer check for `s` was
  removed, leading to a dereference of `s` when using qemu-system-x86_64
  -hda *.vdi.

When replacing migration_is_idle() with "!migration_is_running()", it was
overlooked that the idle helper also checks for current_migration being
available first.  Sample stack dump:

 migration_is_running
 is_busy
 migrate_add_blocker_modes
 migrate_add_blocker_normal
 vmdk_open
 bdrv_open_driver
 bdrv_open_common
 bdrv_open_inherit
 bdrv_open
 blk_new_open
 blockdev_init
 drive_new
 drive_init_func
 qemu_opts_foreach
 configure_blockdev
 qemu_create_early_backends
 qemu_init
 main

The check would be there if the whole series was applied, but since the
last patches in the previous series rely on some other patches to land
first, we need to recover the behavior of migration_is_idle() first before
that whole set will be merged.

I left migration_is_active / migration_is_device alone, as I don't think
it's possible for them to hit uninitialized current_migration. Also they're
prone to removal soon from VFIO side.

Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 34a8892dec ("migration: Drop migration_is_idle()")
Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reported-by: Denis Rastyogin <gerben@altlinux.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241105182725.2393425-1-peterx@redhat.com
[peterx: enhance commit msg]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index aedf7f0751..8c5bd0a75c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1117,6 +1117,10 @@ bool migration_is_running(void)
 {
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return false;
+    }
+
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-- 
2.45.0


