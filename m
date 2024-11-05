Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF95D3177E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OH8-0003XY-H4; Tue, 05 Nov 2024 13:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8OH6-0003XL-Jw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8OH4-0006cK-Rm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730831250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NPYcQ8UIY1gdG4Z/o/P7oSv8n8u9DR49fZZLAJOnHOA=;
 b=fM/G8sjowM6sqRvsfkDeptic417jitJSmW7E23w8KkxwfmTTwpV+F75R+RAynNv660vSVE
 EcWdlq6VTpYE2sg0YXCQdIM56crS8VJZZILkbEsP3q71ZOEsoyjDcqmWWCNi/5Bc9Tj6fp
 75//agAH9gPAY2PFGnYdCUkwm5gSU38=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-qxkIyDlcO3yzk4gkahFUbg-1; Tue, 05 Nov 2024 13:27:28 -0500
X-MC-Unique: qxkIyDlcO3yzk4gkahFUbg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e5fef7b247so6113984b6e.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730831247; x=1731436047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPYcQ8UIY1gdG4Z/o/P7oSv8n8u9DR49fZZLAJOnHOA=;
 b=JGNluALckt9/hcO+zbjth8A4yks3lvOEfj8VayOb2lE5jR2rtEn0wxjeI3SK6jxYqU
 nGLONi5az3xh6yvPhDJqUx1aRHbKR+ujzGKBCb7Q3We449zhTezUPxh0WqJmd4131EG1
 DQ2kK7nvjm1cup8zkSdY+bLND4ffInjJoQbDgxR2Bs78T1IqiQRKRcSpc2fV7Ttj7inH
 gfsRldGgNCHWHYBy4CD4OxdPnCvymjcwGK4WdS5YK6vC3yVUPn7mNia0JPkq6nRiu12x
 pT+7pKF/CgH5MTS5CXguCyK51GPcCMBMYROsHBhJnenvDPoqfMwgzYqvITQdlTU0ESMh
 b43w==
X-Gm-Message-State: AOJu0YyBNyDuvA7FJ9dEVcFKgbstR0Nn9AkoULUHPuazBvD2pGuDzvVS
 mM7pcN2j3R67kQ6tqDc18EjEkT62aExjIQkSUgZawtjO2spzQXt8cBv494kKeGf2YYN5Ol9C7aL
 t+OSM3IGZcjWYhh5+JJAd/IqjZ5ARwZXboNlZs11gBN/BEpEBPU3MPodirN3M5YG6Fk8s5Cskug
 SXg1CzKY6EkdFFdk8QvcTEf2hFUDG2kSsYaQ==
X-Received: by 2002:a05:6808:2e93:b0:3e7:5b07:6a with SMTP id
 5614622812f47-3e75b07017amr14616688b6e.22.1730831247250; 
 Tue, 05 Nov 2024 10:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpqTHNb5/GPzadlfJoonk70gGHnJGSh7tHESLzpU9K9GQuW3rMvHy9pDO2B51RCcMy5B3GYg==
X-Received: by 2002:a05:6808:2e93:b0:3e7:5b07:6a with SMTP id
 5614622812f47-3e75b07017amr14616661b6e.22.1730831246959; 
 Tue, 05 Nov 2024 10:27:26 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415a635sm63001546d6.98.2024.11.05.10.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 10:27:26 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] migration: Check current_migration in migration_is_running()
Date: Tue,  5 Nov 2024 13:27:25 -0500
Message-ID: <20241105182725.2393425-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When replacing migration_is_idle() with "!migration_is_running()", it was
overlooked that the idle helper also checks for current_migration being
available first.

The check would be there if the whole series was applied, but since the
last patches in the previous series rely on some other patches to land
first, we need to recover the behavior of migration_is_idle() first before
that whole set will be merged.

I left migration_is_active / migration_is_device alone, as I don't think
it's possible for them to hit his case (current_migration not initialized).
Also they're prone to removal soon from VFIO side.

Cc: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 34a8892dec ("migration: Drop migration_is_idle()")
Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


