Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB9C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhXO-0000c2-NL; Fri, 22 Mar 2024 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXL-0000bW-AF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXI-0000l2-2l
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711124063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfy5PVe/pn7+K0AvkkvST5u05icXsEXIGf7OvW4k9Lo=;
 b=feLQFiy6ZG9VfeCTyW2iPLe6nkpNAncxb+EHaXEgvjNuaMpfnbK2EdtqMiXjMqHAxRBCdj
 gNDhmIMYDdW266n1f1cTmkBiN1XFrQJmObFeaONwu+coG/88GWYASBkwQRP82ZB+BJ1rrt
 zEiBy8tDcROoDDUiRJuZ5zPGMHLM+1E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-MYvwUjkRN7OR-WUrAdAw7w-1; Fri, 22 Mar 2024 12:14:22 -0400
X-MC-Unique: MYvwUjkRN7OR-WUrAdAw7w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69672754479so962796d6.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124061; x=1711728861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfy5PVe/pn7+K0AvkkvST5u05icXsEXIGf7OvW4k9Lo=;
 b=KmiA5IpiEN6c0WyO3THkqkTLtsi4W27p8PKvzDSyZ7mvM3AJUZH/z+3HTNrLY0QhGP
 /xW1NH8lx5JFNDeYsZNiVdpf2tV8cxVws+tEKeDN2QPVgw3O8fPO/Y/kWT+mr9Bqd3dE
 jIbi1czwzaH8n96wI47zbPM/p5BK/UoaEdvs9dIbNwFvQlihVGAh8ujaw8XCtI5J/GFb
 mQF5Pf5zA0u4X2Ql8XbkGn3wMRKDi3bcFgdlVwBh7SlhKNcVH+4mek2XJ5pO19/A93Fa
 pnbmbmvs6dYCT/1gcWnQkI3RO2b2YJuCi06lBaAL0WZvMeEnQYlWoYSsWBDCUFcZCv1b
 KRow==
X-Gm-Message-State: AOJu0Yxlv8OweVtDWALuQVXo1hcXZPYR3Z6SdqhNEzMePJX+MMO3D70Z
 NWtBbhKHuHnLNKg6JEdAF4CK+cgj7hV/KUDhXZnBlDtncAM041OukfGVKAHFkfvjGwbYBvs3HhG
 hkBBlZouT5QZrMm+av/tMSQttt9IchSt0Za/dXkDaAupg9hcf5+e89ZftvAsu45/SenluSi2oJq
 8GINuC4EeGpN0AC5dURzq9BLrgmisCOZRi6w==
X-Received: by 2002:a05:6214:2b86:b0:696:732f:41ce with SMTP id
 kr6-20020a0562142b8600b00696732f41cemr1095490qvb.0.1711124061305; 
 Fri, 22 Mar 2024 09:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7o24OBMh7+Cs7R5tAiwutJEevu5TT10pinaUevCszhMSiOxLLaeKISC1zoW3XaB33xNIosg==
X-Received: by 2002:a05:6214:2b86:b0:696:732f:41ce with SMTP id
 kr6-20020a0562142b8600b00696732f41cemr1095462qvb.0.1711124060692; 
 Fri, 22 Mar 2024 09:14:20 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05621420e600b006904c34d5basm1202708qvk.64.2024.03.22.09.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 09:14:20 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 2/3] migration/postcopy: Fix high frequency sync
Date: Fri, 22 Mar 2024 12:14:16 -0400
Message-ID: <20240322161417.759586-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322161417.759586-1-peterx@redhat.com>
References: <20240322161417.759586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

With current code base I can observe extremely high sync count during
precopy, as long as one enables postcopy-ram=on before switchover to
postcopy.

To provide some context of when QEMU decides to do a full sync: it checks
must_precopy (which implies "data must be sent during precopy phase"), and
as long as it is lower than the threshold size we calculated (out of
bandwidth and expected downtime) QEMU will kick off the slow/exact sync.

However, when postcopy is enabled (even if still during precopy phase), RAM
only reports all pages as can_postcopy, and report must_precopy==0.  Then
"must_precopy <= threshold_size" mostly always triggers and enforces a slow
sync for every call to migration_iteration_run() when postcopy is enabled
even if not used.  That is insane.

It turns out it was a regress bug introduced in the previous refactoring in
8.0 as reported by Nina [1]:

  (a) c8df4a7aef ("migration: Split save_live_pending() into state_pending_*")

Then a workaround patch is applied at the end of release (8.0-rc4) to fix it:

  (b) 28ef5339c3 ("migration: fix ram_state_pending_exact()")

However that "workaround" was overlooked when during the cleanup in this
9.0 release in this commit..

  (c) b0504edd40 ("migration: Drop unnecessary check in ram's pending_exact()")

Then the issue was re-exposed as reported by Nina [1].

The problem with (b) is that it only fixed the case for RAM, rather than
all the rest of iterators.  Here a slow sync should only be required if all
dirty data (precopy+postcopy) is less than the threshold_size that QEMU
calculated.  It is even debatable whether a sync is needed when switched to
postcopy.  Currently ram_state_pending_exact() will be mostly noop if
switched to postcopy, and that logic seems to apply too for all the rest of
iterators, as sync dirty bitmap during a postcopy doesn't make much sense.
However let's leave such change for later, as we're in rc phase.

So rather than reusing commit (b), this patch provides the complete fix for
all iterators.  When at it, cleanup a little bit on the lines around.

[1] https://gitlab.com/qemu-project/qemu/-/issues/1565

Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Fixes: b0504edd40 ("migration: Drop unnecessary check in ram's pending_exact()")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240320214453.584374-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
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


