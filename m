Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EE1C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnhy-0001yD-QF; Mon, 11 Mar 2024 18:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngl-0000hB-IW
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngj-0004FA-M8
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYBBBuT1r3W8EJmKlTmpyZe13YIEZba26k1f9sq+pH8=;
 b=CDtfZe1W4a5H6UHQY77+lgE8EFuF6E5G4MQVHqbFwyo8owc7gbflqCGgRpyuHKT3iT653U
 lHg7cqCmsMlEBSzfylZTTPb7i/Z2QmRk3pqfoZmCTvhltoy5dKwXs5XeWYIh4OB0yHiIlV
 aGdlrfiuGdRluo5vBAFw/+8n08Opy/I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-ro7FiHiSPNKtyrYm8xcSig-1; Mon, 11 Mar 2024 18:00:02 -0400
X-MC-Unique: ro7FiHiSPNKtyrYm8xcSig-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-690c19ee50bso1968766d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194402; x=1710799202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYBBBuT1r3W8EJmKlTmpyZe13YIEZba26k1f9sq+pH8=;
 b=jvS4CB3QRnlvTfEd3g30kbIStL0AZTEXKrQlXTUJKO/pmplaqW6+A7OafqXkWREIvG
 V/Co0VebG77P3FZgWyrypI1BjgO34lBFdVc4GPWV9I6wsIYDElnau3NYlhsBgw3/U0lw
 LrKV5ERCkcA2J21PtI+T5OaH2vSFDtwRZ4VNg/lZUe8ndDp7F87MPhs87x5IFS557dWM
 ujAB5z0RlaVboPyohy5qHmiqWb+mcwmfLuS4C9JAxJ/h35Q6RLKGhwf8k1Qw4L6sxD+v
 z4k4ovDI1WfSTQvmvX+dwqkYe2104UERtA5DXPClLm0/X6yiGFewtopyWzyBzusBvaz2
 5qkQ==
X-Gm-Message-State: AOJu0YyWGsocFGkC/3HBf0UlVYM9lTf70o/AslyjFtyYcZpMc5KnXg+6
 FK9jaSIMgAJ6Kj75wq/xzN4uFoYSY6w/8kBfEP4IfQU4+J2mby/HALyXPfTnVjCuj5UOdpXUA0/
 moIF/An+NU9ioggTHrQ7U5dGbQW5PJDmhN9h3zm9BZ2lqhXodnJY8uv/8QZRn/ZR5GPQj+TmvfD
 aSoosJAtHRfgyVs5KnCM/NuEdZtMXDN9i73w==
X-Received: by 2002:ad4:58c5:0:b0:68f:1c80:d78e with SMTP id
 dh5-20020ad458c5000000b0068f1c80d78emr7453794qvb.0.1710194402037; 
 Mon, 11 Mar 2024 15:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYMhtwNVbDITCwQRxVxFOrIlsV9jOD0yvJEQCL8Ij1gQ3Z9x/IJbFwL8oup7zt3dtUynxCYw==
X-Received: by 2002:ad4:58c5:0:b0:68f:1c80:d78e with SMTP id
 dh5-20020ad458c5000000b0068f1c80d78emr7453758qvb.0.1710194401588; 
 Mon, 11 Mar 2024 15:00:01 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:01 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 23/34] migration: migration_is_device
Date: Mon, 11 Mar 2024 17:59:14 -0400
Message-ID: <20240311215925.40618-24-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Define and export migration_is_device to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-8-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 hw/vfio/common.c         | 4 +---
 migration/migration.c    | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c4b5416357..28cfaed2c7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(void);
+bool migration_is_device(void);
 bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2dbbf62e15..de010680ff 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -180,10 +180,8 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
-    MigrationState *ms = migrate_get_current();
 
-    if (!migration_is_active() &&
-        ms->state != MIGRATION_STATUS_DEVICE) {
+    if (!migration_is_active() && !migration_is_device()) {
         return false;
     }
 
diff --git a/migration/migration.c b/migration/migration.c
index afe72af0b1..db1e627848 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1647,6 +1647,13 @@ bool migration_is_active(void)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+bool migration_is_device(void)
+{
+    MigrationState *s = current_migration;
+
+    return s->state == MIGRATION_STATUS_DEVICE;
+}
+
 bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
-- 
2.44.0


