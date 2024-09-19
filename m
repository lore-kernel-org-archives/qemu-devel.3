Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A5CF3941
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHUg-0007rw-Vs; Thu, 19 Sep 2024 09:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUW-0007ES-Ip
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:45 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUQ-0005zp-UN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=yth4XXP3doal8mi5kLWYXcmT+5/Krh3E/otCxVnGH08=; b=rCkMbo81Gy7YknXH
 2fWsXnJ9xiZVShtbTLOUGNdnuTmd6LuQb1h7rLCVvIKU5HRUkxrL01LacqvVZuBFIYkVi3JarstW1
 mkwESKSHv7LlNxbtdxQ0MujAUPMmfifU2J6kQINKqJYBZDiWC1UJUm0ptqenGZpBd2Hg2bDcP2ZID
 jx6dx0NEGhHN2JLP9CCLK2jPyR29eSvYarLFDqAJoK460d2oAAJcJKMpUz/+0Y2BFYjY02Y0xQQM3
 K685qClXh1YV8Z+ghDlxF9wfzZ7bdFNnDr1/kmUFRuVFw0dcyCyK9AfLmiIdj/sgHb1BOTIVu7wSz
 DnDvI+V+ZwdLkehGPg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHUL-006QOJ-0x;
 Thu, 19 Sep 2024 13:46:29 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 2/7] migration: Remove unused migrate_zero_blocks
Date: Thu, 19 Sep 2024 14:46:21 +0100
Message-ID: <20240919134626.166183-3-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
References: <20240919134626.166183-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

migrate_zero_blocks is unused since
  eef0bae3a7 ("migration: Remove block migration")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 migration/options.c | 7 -------
 migration/options.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 9460c5dee9..6f549984cb 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -339,13 +339,6 @@ bool migrate_xbzrle(void)
     return s->capabilities[MIGRATION_CAPABILITY_XBZRLE];
 }
 
-bool migrate_zero_blocks(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->capabilities[MIGRATION_CAPABILITY_ZERO_BLOCKS];
-}
-
 bool migrate_zero_copy_send(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 36e7b3723f..79084eed0d 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -40,7 +40,6 @@ bool migrate_release_ram(void);
 bool migrate_return_path(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
-bool migrate_zero_blocks(void);
 bool migrate_zero_copy_send(void);
 
 /*
-- 
2.46.1


