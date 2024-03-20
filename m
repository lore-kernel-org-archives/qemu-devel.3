Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC2FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 21:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn3k7-00044Z-LB; Wed, 20 Mar 2024 17:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn3k6-000444-1r
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 17:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn3k4-00060H-AJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 17:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710971099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xue1l6ti/1XxFYgKeVbSHWUqMibW0qilWZUtfgWpjjs=;
 b=aM1lBKtyttfNFgY95KwnaCF8eDcU2mMGqN4knfguY0qKDI1pSB6c8Q0KIytqEdsiNv8c3e
 k++xSSfM57ubD3OSR15H48qxG0x7PJzfpwHkYk+3URWADZ6non4TAcGg3Eux6hFMmlJDbV
 qmBJqTuk+WHk3EvCwIyVZWE9//oIJPU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-vrj6rz24NZuzGnNQhWEJ3g-1; Wed, 20 Mar 2024 17:44:57 -0400
X-MC-Unique: vrj6rz24NZuzGnNQhWEJ3g-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e6b0efc193so2786a34.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 14:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710971096; x=1711575896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xue1l6ti/1XxFYgKeVbSHWUqMibW0qilWZUtfgWpjjs=;
 b=bexMKUSOb11k2eccsN971tnH4KTLVqc3mDTbWXZMb8tusA8IX4hyr3X5wxnVtjfAt3
 S6iCCt/F0iRzHmOuvSsvSz3SaGovGO8v2czZ4kR257qYK3+rnDC9MmKIJrCL7Ol2zbtn
 4cNVeBv5Fj9Vuu36QreiFnqdVDl3q52cQ8t2nRpUa5+nzeyGnQysqzxx+xF3Aev6Qm1d
 jxurtFij3k47MjQvwdXU0MqCrYYdLswuhB3iwTxSJWZOOoAQ1BOMX5SQQJxHO4kwd8nD
 T6YLTPpX2mpPJsSoXly3IycS50ABB2DLS0bbmX6spqNA4H9V/Xi0WabxbL2d9KGgXLCC
 D/Xw==
X-Gm-Message-State: AOJu0YyTxZq8uyBi+nNVrkKCMt1qB5IzhoVFxOqqPwiwWJhF8x95P80A
 A0rNcpG/1K87rm/l7amfDxbcBJ40nT2adS8zc5hqa+UfH2H01h1QDRw7pfysqTr70pd4jejRbY9
 KYuAmt3V5pV1iLB6WjXLEfW01BeaJtnL3xi6Alh29Bw3qd1Q3MDSW1nJvFmBEqHvtgspvySitYB
 2oxBRdKPjPUSyFZ0QKtgjUpa8/9FCDc3eGgw==
X-Received: by 2002:a9d:4b0a:0:b0:6e6:9b39:b1e with SMTP id
 q10-20020a9d4b0a000000b006e69b390b1emr7143203otf.0.1710971095855; 
 Wed, 20 Mar 2024 14:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJJpieanTngXZv42KQjFUWpB4V99e10q8y0Gyxw+NJxq5PkesqL7fMRIHoPouuqMQSEpQj6g==
X-Received: by 2002:a9d:4b0a:0:b0:6e6:9b39:b1e with SMTP id
 q10-20020a9d4b0a000000b006e69b390b1emr7143184otf.0.1710971095352; 
 Wed, 20 Mar 2024 14:44:55 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 dy4-20020a05620a60c400b00787fd080d28sm6920408qkb.74.2024.03.20.14.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 14:44:55 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH] migration/postcopy: Fix high frequency sync
Date: Wed, 20 Mar 2024 17:44:53 -0400
Message-ID: <20240320214453.584374-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

On current code base I can observe extremely high sync count during
precopy, as long as one enables postcopy-ram=on before switchover to
postcopy.

To provide some context of when we decide to do a full sync: we check
must_precopy (which implies "data must be sent during precopy phase"), and
as long as it is lower than the threshold size we calculated (out of
bandwidth and expected downtime) we will kick off the slow sync.

However, when postcopy is enabled (even if still during precopy phase), RAM
only reports all pages as can_postcopy, and report must_precopy==0.  Then
"must_precopy <= threshold_size" mostly always triggers and enforces a slow
sync for every call to migration_iteration_run() when postcopy is enabled
even if not used.  That is insane.

It turns out it was a regress bug introduced in the previous refactoring in
QEMU 8.0 in late 2022. Fix this by checking the whole RAM size rather than
must_precopy, like before.  Not copy stable yet as many things changed, and
even if this should be a major performance regression, no functional change
has observed (and that's also probably why nobody found it).  I only notice
this when looking for another bug reported by Nina.

When at it, cleanup a little bit on the lines around.

Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Fixes: c8df4a7aef ("migration: Split save_live_pending() into state_pending_*")
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Nina: I copied you only because this might still be relevant, as this issue
also misteriously points back to c8df4a7aef..  However I don't think it
should be a fix of your problem, at most it can change the possibility of
reproducability.

This is not a regression for this release, but I still want to have it for
9.0.  Fabiano, any opinions / objections?
---
 migration/migration.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 047b6b49cf..9fe8fd2afd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3199,17 +3199,16 @@ typedef enum {
  */
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
-    uint64_t must_precopy, can_postcopy;
+    uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
     bool can_switchover = migration_can_switchover(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
-    uint64_t pending_size = must_precopy + can_postcopy;
-
+    pending_size = must_precopy + can_postcopy;
     trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
 
-    if (must_precopy <= s->threshold_size) {
+    if (pending_size < s->threshold_size) {
         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
         pending_size = must_precopy + can_postcopy;
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
-- 
2.44.0


