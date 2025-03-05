Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFA3C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmoY-0007Lf-2m; Wed, 05 Mar 2025 06:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpmoW-0007LS-Tu
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:21:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpmoU-00061n-SK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741173680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ef+psEki+3p8J4WctHUw8UZXzCljxoahxNR8TjdHtqc=;
 b=LXCS/+ddKcSsGzge5/J2iq2aTIUGnDcEaW9TlTWrXnhHf7w/7rmCs1PZeevfTDsQFZBBjN
 c73KPZOjR5I785KAkbR9CwrC5K189xzzeSc0/4AWFXzkkiNbciM0gUta1h6hFobF7pbO3a
 uYki00tNI1fi18nw7809A+L2HcvT8mE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-hVT6i7BOMPOMTyAF5DxbHw-1; Wed, 05 Mar 2025 06:21:18 -0500
X-MC-Unique: hVT6i7BOMPOMTyAF5DxbHw-1
X-Mimecast-MFC-AGG-ID: hVT6i7BOMPOMTyAF5DxbHw_1741173677
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391189236e7so1177868f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741173677; x=1741778477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ef+psEki+3p8J4WctHUw8UZXzCljxoahxNR8TjdHtqc=;
 b=I3yBeGI1bbALMqRtL1Dj4fLpFiWu9La2DIK9PHH/aQl65P4fZR2JidLYp2PEfTqz/A
 WGLE/UdS4o5bFI3znuztz4bAHbD1WWgywIeQa39nWeFuqcXUtMjLmT8cPhyGUMbdjokt
 PN2pQHlg0DIQbMPd/UXDjXskVBxJxoGI0/rjuJMrkHPVHaZJZ7cciTgYaPS79uDBgUka
 ZSsLoogG4PAAvlDMJH0roPqpe+QBeeE4eYTk6xu3QIKT4MxeHUbBvo+MBgDqkyqvyPbj
 qOWZHs+AqRvS31LTLvDmGSDCqjelJbxoy8SBsdTjT0icQpYu/eXO/xjtwC27JmpEnhmE
 irpA==
X-Gm-Message-State: AOJu0YzSJni+GskfXLw3TRjYDasdaSP3dkindncOhnvbAN/y3do06ykr
 XwV4XrGer236bPL/BFUkH6QSGOtOI5GVOKOz9epRkFGCGwnqYhsmZo4MnFbmx12AOOdA1WOdLXB
 /DXS08FnqHm3YWih9xotNqg5VgmBfbQfTrSoy/mdrMsc4fxXg3gvtwgAfioUbTETA3JB/1wElGN
 /ooRdAgdVlCrkliwmWNCN25KpAmNM=
X-Gm-Gg: ASbGncugikGtlASkWdqHs+LRW5BkQbtHoCEh/MYoxGzJSozL9hAzq+LRQe+9goA2Ysy
 5vv/tkKK+/RNFKopDmkA2ShB3U3BguZ7MpM9PaOWxyLC9pYBterWNk37q2lThN93/g26CfZyTIs
 E=
X-Received: by 2002:a05:6000:1a8f:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-3911f726553mr2252661f8f.10.1741173677195; 
 Wed, 05 Mar 2025 03:21:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqYcT7HTRv8WaPOyYnDapHvEY1gbaJ4VzROX5HQnXoCGxROMvH3l86pxN+k6Nj3IYxTmU/1ovNeNPgDYajBkw=
X-Received: by 2002:a05:6000:1a8f:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-3911f726553mr2252641f8f.10.1741173676906; Wed, 05 Mar 2025
 03:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
In-Reply-To: <Z8cPnxqOvp1hFpx8@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 5 Mar 2025 16:51:00 +0530
X-Gm-Features: AQ5f1JpciaH4QIfVFg2zSJluO3TJq1F-oxODCy-b1iH1-oZ5n35iNnqA1lIVuBI
Message-ID: <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Tue, 4 Mar 2025 at 20:05, Peter Xu <peterx@redhat.com> wrote:
> I think we need the header, the ram is a module.
> Do similarly like qemu_savevm_state_complete_precopy_iterable() but do
> whatever a vmstate hander wants, so it'll be with a header.

* I don't fully see yet how this shall work.

> Please consider adding details like "we need message AAA on BBB channel to
> serialize with CCC" and details.  Not asking that as required to merge, but
> my understanding is that that's what is missing and that's why none of yet
> versions can make sure of it in code.  Maybe that'll help you to understand
> how that was serialized.

* Okay, will try.

>
> MULTIFD_SYNC_LOCAL will not invoke MULTIFD_FLAG_SYNC, which we need.
...
> So is it your intention to not send MULTIFD_FLAG_SYNC above?
> In all cases, I still think that's not the right way to do.

* It makes little difference; MULTIFD_FLAG_SYNC is also used to
increase 'multifd_recv_state->sem_sync' semaphore on the destination
side, which then unblocks the 'main' thread waiting on it.
===
diff --git a/migration/migration.c b/migration/migration.c
index 65fc4f5eed..d8c4ea0ad1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3402,7 +3402,7 @@ static MigIterateState
migration_iteration_run(MigrationState *s)
         && can_switchover && qatomic_read(&s->start_postcopy)) {
         if (migrate_multifd()) {
             multifd_send_flush();
-            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
+            multifd_send_sync_main(MULTIFD_SYNC_ALL);
             qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
             multifd_send_shutdown();
         }
diff --git a/migration/multifd.c b/migration/multifd.c
index 8928ca2611..2b5bc2d478 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1265,7 +1265,7 @@ static void *multifd_recv_thread(void *opaque)

     rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->packets_recved);
-    qemu_sem_post(&multifd_recv_state->sem_sync);
+//  qemu_sem_post(&multifd_recv_state->sem_sync);

     return NULL;
 }
===
host-1] 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
             OK             159.46s   79 subtests passed
host-2] 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
             OK             164.55s   79 subtests passed
===

* I tried the above patch and it also works the same. I'll use this, no issues.

Thank you.
---
  - Prasad


