Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F423DC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpoGn-0001Bd-9V; Wed, 05 Mar 2025 07:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpoGl-0001BJ-1a
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpoGj-0005Sr-Ae
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741179274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrJpxyQI9zO+ArC+0KMVKQ3hyO2P9Ctt+qA2rqscBak=;
 b=B4/wWaeKQkvA9DeQoHhQ1FDAAMaOhoKldkoDfst3YrnhOyQFflvBX/AZDkI1vaockp5HaU
 SNhGQ9JGvqhCtcXjnlvHBcWuiLMBXhV568TfG6Ld954j2tdMsyUF80Hg8ZCWZ8+LxWcrSU
 3QmWzZyw4BH/kxzu+ysexihAkY2j9rM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-jqI9MdqGOhKaNjFV6A4T1g-1; Wed, 05 Mar 2025 07:54:23 -0500
X-MC-Unique: jqI9MdqGOhKaNjFV6A4T1g-1
X-Mimecast-MFC-AGG-ID: jqI9MdqGOhKaNjFV6A4T1g_1741179263
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-474f98ba7e4so84290591cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 04:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741179263; x=1741784063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrJpxyQI9zO+ArC+0KMVKQ3hyO2P9Ctt+qA2rqscBak=;
 b=qgb+CT9pdnB6/6oILpo5ZxupXTVbIjWel44YCZQM7Z2b6rUmZligi/3sKRMIMUP9oe
 S8cdvrUIWrqjOJfVvdrrnqOOMlTzH8VmKXur/4EYlPlltcJ3Z/3q0kfuKyn+gP7I7vgd
 TpuPdb+p0cv2uRDWlQoyT+2sBIXLv178/z1wNlWPP2SKkrkZYBMlbkp0qGxNav8+Q/HH
 s/MyYI/GORO7ytScX208QnOVTq+dXJb1nM3AsDDVKZhJxkDuUeheGwrkAf5pPjHawdLj
 mCppa3NfdBqORd5Oe/s/0X/H5fFLrz93bWSvfJUS6XV1LI0VPXfV+GJRGh85eOvE4f5+
 C1PQ==
X-Gm-Message-State: AOJu0YzD3Lpk8JSu6xBoN02gc5kBoHSdmcLjIzcRHC8fBFz9CfQ6Ri5k
 VBU0BQmAXDRlOk5f4jwTJY3QKzXegV/o9VDDpiuxNpYvR/fjUDTcQdnYfOfcMHHZYvWEh+a4a17
 CDH4djJamwnlP+5y9D4ktKglYNwWBwXhk+KpaivfHd4kmh3imIgRJTaGDeSBu
X-Gm-Gg: ASbGncvuudZ2B2POSIH7ZO9g/tbSD4fQRAt4xvExXQbvCvYKF4kAMufILoNUAR+AwXA
 0PvaxBbi65CKXLzCYWXH5vsyaOd+4HzFzZUaz6OSjTOWa3zL3OZ6mc0YBbAy1BvQD6Lj79oXTU/
 7FBs9KdmYnh8zTBRMrb0B/YaoOTHxBuOqrQBVlXS8ZiE62dPhG5xbjiYDX2rrlhcP9J0exjErSb
 3ab2zRdbCGzBVmLNzrTNOFQzYPcCslRs7dgh2CjHZWpuumoOmEEouC/zVtq6eqSlgCH8ucKZ0Kg
 cRrtadE=
X-Received: by 2002:a05:622a:1212:b0:475:6af:9fb0 with SMTP id
 d75a77b69052e-4750b4c1d64mr37374931cf.42.1741179262976; 
 Wed, 05 Mar 2025 04:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUWP79+2+1Vqr6/3Qp9arouGK4b1joyfRkDk9B3GY+LZ0LSBIGokHqUzdHD72+6vMsJVkH8Q==
X-Received: by 2002:a05:622a:1212:b0:475:6af:9fb0 with SMTP id
 d75a77b69052e-4750b4c1d64mr37371001cf.42.1741179261610; 
 Wed, 05 Mar 2025 04:54:21 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47511dbd9fbsm4510011cf.12.2025.03.05.04.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 04:54:20 -0800 (PST)
Date: Wed, 5 Mar 2025 07:54:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
Message-ID: <Z8hJeneeuKqD1i8Q@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05, 2025 at 04:51:00PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Tue, 4 Mar 2025 at 20:05, Peter Xu <peterx@redhat.com> wrote:
> > I think we need the header, the ram is a module.
> > Do similarly like qemu_savevm_state_complete_precopy_iterable() but do
> > whatever a vmstate hander wants, so it'll be with a header.
> 
> * I don't fully see yet how this shall work.

Another option is add another event for precopy_notifier_list, it can be
PRECOPY_NOTIFY_SWITCH_POSTCOPY, then make RAM register to it, send the
header itself, and do the flush and sync.

Let me know if you want me to write the patches.  That's almost the only
thing left to make it clearer..

> 
> > Please consider adding details like "we need message AAA on BBB channel to
> > serialize with CCC" and details.  Not asking that as required to merge, but
> > my understanding is that that's what is missing and that's why none of yet
> > versions can make sure of it in code.  Maybe that'll help you to understand
> > how that was serialized.
> 
> * Okay, will try.
> 
> >
> > MULTIFD_SYNC_LOCAL will not invoke MULTIFD_FLAG_SYNC, which we need.
> ...
> > So is it your intention to not send MULTIFD_FLAG_SYNC above?
> > In all cases, I still think that's not the right way to do.
> 
> * It makes little difference; MULTIFD_FLAG_SYNC is also used to
> increase 'multifd_recv_state->sem_sync' semaphore on the destination
> side, which then unblocks the 'main' thread waiting on it.

AFAIU that's the whole difference and whole point of doing such..

> ===
> diff --git a/migration/migration.c b/migration/migration.c
> index 65fc4f5eed..d8c4ea0ad1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3402,7 +3402,7 @@ static MigIterateState
> migration_iteration_run(MigrationState *s)
>          && can_switchover && qatomic_read(&s->start_postcopy)) {
>          if (migrate_multifd()) {
>              multifd_send_flush();
> -            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
> +            multifd_send_sync_main(MULTIFD_SYNC_ALL);
>              qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
>              multifd_send_shutdown();
>          }
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 8928ca2611..2b5bc2d478 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1265,7 +1265,7 @@ static void *multifd_recv_thread(void *opaque)
> 
>      rcu_unregister_thread();
>      trace_multifd_recv_thread_end(p->id, p->packets_recved);
> -    qemu_sem_post(&multifd_recv_state->sem_sync);
> +//  qemu_sem_post(&multifd_recv_state->sem_sync);
> 
>      return NULL;
>  }
> ===
> host-1] 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>              OK             159.46s   79 subtests passed
> host-2] 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>              OK             164.55s   79 subtests passed
> ===
> 
> * I tried the above patch and it also works the same. I'll use this, no issues.

We can't introduce a migration global cmd just to work the same as
RAM_SAVE_FLAG_MULTIFD_FLUSH, which is a sub-cmd for a module.

> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


