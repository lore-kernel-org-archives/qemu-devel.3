Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C804FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq14-0001ur-Su; Tue, 14 Jan 2025 18:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq12-0001tv-Ra
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq11-00044K-BZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6ibT0N3eQDXuj76OU80+8wwd1uXT2Xl2UVx22v24lc=;
 b=iKRLUpJWORbAnNuNYZ6Sj7CKuvP16ICUzbpRy1MWMh9X+Ngoeebcsuv56gOhB/CZuMxs5P
 YDDk4pcVYzdJtsYR1gEA3+SwYIHpQgNLhnvNcGyy+xGUC7ZkOoFQcK1FHW5QNpKsxH79is
 rsvEf+FrhtsCnKgv0RVUGfuK0hmMbTM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-qiZt72bHPESCaTtTSmYlxA-1; Tue, 14 Jan 2025 18:08:04 -0500
X-MC-Unique: qiZt72bHPESCaTtTSmYlxA-1
X-Mimecast-MFC-AGG-ID: qiZt72bHPESCaTtTSmYlxA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8fe8a0371so96120666d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896084; x=1737500884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6ibT0N3eQDXuj76OU80+8wwd1uXT2Xl2UVx22v24lc=;
 b=H3pj+zd5hnqoDaTHvHz0b/V3Hjo7+Qgh5N0KeUSpzPhFxdIdj80+FJlG2elZ2gOPdD
 13Eemi6O8Vkj0JWbBIlsxIfpxgx0w7pL3bsettilAyIpkbj1vyN/WHrgHofGDvrPVmcu
 TnXJCRoTBbeQUlu0OKk4GSvZRjfgKuzAt2wvsZwVv/h7AX684elJQFmSk0dI5N6rn1Nr
 xgkvxm4ASkJ1rKlvd2/4uifOo+dn3rJYiIegEALuQYVh0kk65965raSQ+lZ1CCMUDN92
 zpaMzhYy1ryZ3iS8b66lPdCW3tLM9Ft9WuLaubmLfVzW2o6fWwn6Y4zUakSzhjE5RWCo
 8CYw==
X-Gm-Message-State: AOJu0YyBoOP4oXIKYt3OXoMMZxGbQKgFePaVW3qZnXcXUpvDyjABCQN1
 GJ9QmdTMACRST877M283T/nS0bHX4iC8PGFmjy3gvH7pUueckExeVT0r0JHzAGZvMKSrwAN7cl4
 i8axyBYpLnSaAKg08D08dhzMy2vxt9hOmJj5y4lkWbbYXYaTqtObbSI0RwISnlC2u/5SvPfK+BM
 y1NQl++zaU10h7J1cZbtLyhgGGq0vmCN+Asg==
X-Gm-Gg: ASbGncsVmWa4cNHgR1lczOhsxJ8OLtATbDah7Wrbh+XoLloL1NAS4Bt8WBYRFmMRVvj
 U8DqbFXc1jYrhKUd1z7VxdtL1NS3nLDboaZGIBQmK4NPg4SoCvnw8qA8unbZLPBSvZwjU0y1jPe
 wGcxTXf5gcDXWuUoCWbb3ikbc/AMpbYMIUU8hxMaVzXI/1Omxs2awxeWD0qq2Dt4IC/V1yNEAm6
 1zBronggCKNOknlYcRPv12e/4Liw79CMCrdpX/F11SDLr1ml3ISVUEz5MHXNtf9lS32zprHNv3J
 Q/7aVSYCU4KTC4puGcgBheDYfN0Ntofs
X-Received: by 2002:a05:6214:528e:b0:6dd:b9a6:e626 with SMTP id
 6a1803df08f44-6df9b1c4fa7mr450551336d6.8.1736896083755; 
 Tue, 14 Jan 2025 15:08:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHez8lz2JlCPSMlbxZaVYgHjfiicZrlgkCHnsnYgnuTT8ML97EipTPzCC7k+YBFzBJW/eYbEQ==
X-Received: by 2002:a05:6214:528e:b0:6dd:b9a6:e626 with SMTP id
 6a1803df08f44-6df9b1c4fa7mr450550936d6.8.1736896083394; 
 Tue, 14 Jan 2025 15:08:03 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 08/16] migration: Adjust locking in migration_maybe_pause()
Date: Tue, 14 Jan 2025 18:07:38 -0500
Message-ID: <20250114230746.3268797-9-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In migration_maybe_pause() QEMU may yield BQL before waiting for a
semaphore.  However it yields the BQL too early, which logically gives it
chance for the main thread to quickly take the BQL and modify the state to
CANCELLING.

To avoid such race condition from happening at all, always update the
migration states within the BQL.  It'll make sure no concurrent
cancellation can ever happen.

With that, IIUC there's chance we can remove the extra parameter in
migration_maybe_pause() to update active state, but that'll be done
separately later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 13b7df0d5b..5c688059de 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2701,14 +2701,14 @@ static int migration_maybe_pause(MigrationState *s,
      * wait for the 'pause_sem' semaphore.
      */
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        bql_unlock();
         migrate_set_state(&s->state, *current_active_state,
                           MIGRATION_STATUS_PRE_SWITCHOVER);
+        bql_unlock();
         qemu_sem_wait(&s->pause_sem);
+        bql_lock();
         migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
                           new_state);
         *current_active_state = new_state;
-        bql_lock();
     }
 
     return s->state == new_state ? 0 : -EINVAL;
-- 
2.47.0


