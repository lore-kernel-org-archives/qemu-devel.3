Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53407C4828D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 02:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVj40-00026O-3I; Thu, 01 Feb 2024 21:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVj3z-00026C-5l
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 21:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVj3j-0000fN-Sy
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 21:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706840018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z2bCjhTyolSpYPBIDQopGSNmlmYmosFAaxdagjqcbT4=;
 b=bqAZJyuljnpnZWzX6aRHbLd+hQjE5ar3XuSH1GJoWkBqfKvBBETjd3I9DQKqfTc7jmwV1L
 VtMQYS46uyh8DVXkqMSJdABzottgDVUUMfolULZ2jHh04CLmNz1/KkGqvsRqbQVZQaMNcy
 QSqWBQ9Vkw2ZuaAE6PAK47Dt7M8Qgbc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-5Pwz8IhvNweowZ1oI0Verg-1; Thu, 01 Feb 2024 21:13:37 -0500
X-MC-Unique: 5Pwz8IhvNweowZ1oI0Verg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so349923b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 18:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706840016; x=1707444816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2bCjhTyolSpYPBIDQopGSNmlmYmosFAaxdagjqcbT4=;
 b=CFtEzAwYwQ2D5gWnkhbYIaevVR7gQekjg628yl7qSpJ7k0d4T2Hr2EWB1KBeqK8W4h
 rVyjayPMA8L83y3Zvl6RaZ6aLIv3An1P/Xbgq2igVBkzLfq0wFmiidyxnDkSnxpo6Kp+
 fH5QNdZVqkRrJolD+1Hy2JS5eARGEF+pyWtnobbHXT5FU5kLfWgCcY6fDi7m3fDF5zbm
 dGlj65SYq7goY2xWKCUvkiFjKiGwHVch0F9No/ihib2vfncEvY7+DqdBDRjMkvUu3mWg
 sUhyUUgkGYIv3mXMT2RG4zGWNYIt6CKFJoy6gZ1RfKGzWbeDTYPfImzPZnzdyBQlZzxH
 o3NA==
X-Forwarded-Encrypted: i=0;
 AJvYcCVvIleSeiXX/byhhC8kTHPA66nVHOGjj7wRRk9cfWSpjXe0Zx5kbGm9iYM5yIZ8SuRP645G5fWMHSY12kEzw9w/kpsz6MI=
X-Gm-Message-State: AOJu0YzXou3wjGa8OBWd+3VdWL1sZJ0MFXrpYKPnwxjeVIHvq+rI8Rtk
 6aAA3r+M95kzuvUF5xapdSUdtEFMkSFvIxdddj7txbKN4oJfx4d2R/66Ay4m2N14P0namNXt5fe
 mZ1BkdS/bP7S8bB3oanN7pkcCHI2P8UEUtNarUB+3bdcCoipRyQbO
X-Received: by 2002:a05:6a00:1d83:b0:6df:f706:b2d8 with SMTP id
 z3-20020a056a001d8300b006dff706b2d8mr775523pfw.0.1706840016131; 
 Thu, 01 Feb 2024 18:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbgvhpM0qh2lfidJi14SOHhioWs2Ee5HdyEtj3Qqk7EDG9hFdLYWflwNtppXa6G6OTBuqa3A==
X-Received: by 2002:a05:6a00:1d83:b0:6df:f706:b2d8 with SMTP id
 z3-20020a056a001d8300b006dff706b2d8mr775502pfw.0.1706840015739; 
 Thu, 01 Feb 2024 18:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU7HAi9HiEZdFpbKHBrVv5M3/v2HaGBKAUnwFDwV5v6lp++PgnjsbBLDP82UNKFt2bJO0AZo2gFNegjxuLUVocsfoab5lzjBCslvbUu8xtNT8jZnFtUxYNuhwr7OAd4H1HsDVrNkMi29TnvfM2U57E0thDSRJgyijVoqzdxyrhHpe7xXqw+UWWfHzODkhMBSCWr5O0ii+56r4Nsj8bS/nZj8GQ=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y11-20020a62f24b000000b006ddc7de91e9sm416322pfl.197.2024.02.01.18.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 18:13:35 -0800 (PST)
Date: Fri, 2 Feb 2024 10:12:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 00/14] migration/multifd: Refactor ->send_prepare() and
 cleanups
Message-ID: <ZbxPoEDNsqYo3D38@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <871q9xjey8.fsf@suse.de> <ZbswgRJTXP4yKiuf@x1n>
 <5515481b-3601-46e0-ba82-cbec056966f0@nvidia.com>
 <87le83j1s4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le83j1s4.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 01, 2024 at 06:46:35PM -0300, Fabiano Rosas wrote:
> Avihai Horon <avihaih@nvidia.com> writes:
> 
> > On 01/02/2024 7:47, Peter Xu wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On Wed, Jan 31, 2024 at 07:49:51PM -0300, Fabiano Rosas wrote:
> >>> peterx@redhat.com writes:
> >>>
> >>>> From: Peter Xu <peterx@redhat.com>
> >>>>
> >>>> This patchset contains quite a few refactorings to current multifd:
> >>>>
> >>>>    - It picked up some patches from an old series of mine [0] (the last
> >>>>      patches were dropped, though; I did the cleanup slightly differently):
> >>>>
> >>>>      I still managed to include one patch to split pending_job, but I
> >>>>      rewrote the patch here.
> >>>>
> >>>>    - It tries to cleanup multiple multifd paths here and there, the ultimate
> >>>>      goal is to redefine send_prepare() to be something like:
> >>>>
> >>>>        p->pages ----------->  send_prepare() -------------> IOVs
> >>>>
> >>>>      So that there's no obvious change yet on multifd_ops besides redefined
> >>>>      interface for send_prepare().  We may want a separate OPs for file
> >>>>      later.
> >>>>
> >>>> For 2), one benefit is already presented by Fabiano in his other series [1]
> >>>> on cleaning up zero copy, but this patchset addressed it quite differently,
> >>>> and hopefully also more gradually.  The other benefit is for sure if we
> >>>> have a more concrete API for send_prepare() and if we can reach an initial
> >>>> consensus, then we can have the recent compression accelerators rebased on
> >>>> top of this one.
> >>>>
> >>>> This also prepares for the case where the input can be extended to even not
> >>>> any p->pages, but arbitrary data (like VFIO's potential use case in the
> >>>> future?).  But that will also for later even if reasonable.
> >>>>
> >>>> Please have a look.  Thanks,
> >>>>
> >>>> [0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
> >>>> [1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de
> >>>>
> >>>> Peter Xu (14):
> >>>>    migration/multifd: Drop stale comment for multifd zero copy
> >>>>    migration/multifd: multifd_send_kick_main()
> >>>>    migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
> >>>>    migration/multifd: Postpone reset of MultiFDPages_t
> >>>>    migration/multifd: Drop MultiFDSendParams.normal[] array
> >>>>    migration/multifd: Separate SYNC request with normal jobs
> >>>>    migration/multifd: Simplify locking in sender thread
> >>>>    migration/multifd: Drop pages->num check in sender thread
> >>>>    migration/multifd: Rename p->num_packets and clean it up
> >>>>    migration/multifd: Move total_normal_pages accounting
> >>>>    migration/multifd: Move trace_multifd_send|recv()
> >>>>    migration/multifd: multifd_send_prepare_header()
> >>>>    migration/multifd: Move header prepare/fill into send_prepare()
> >>>>    migration/multifd: Forbid spurious wakeups
> >>>>
> >>>>   migration/multifd.h      |  34 +++--
> >>>>   migration/multifd-zlib.c |  11 +-
> >>>>   migration/multifd-zstd.c |  11 +-
> >>>>   migration/multifd.c      | 291 +++++++++++++++++++--------------------
> >>>>   4 files changed, 182 insertions(+), 165 deletions(-)
> >>> This series didn't survive my 9999 iterations test on the opensuse
> >>> machine.
> >>>
> >>> # Running /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
> >>> ...
> >>> kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>>
> >>>
> >>> #0  0x00005575dda06399 in qemu_mutex_lock_impl (mutex=0x18, file=0x5575ddce9cc3 "../util/qemu-thread-posix.c", line=275) at ../util/qemu-thread-posix.c:92
> >>> #1  0x00005575dda06a94 in qemu_sem_post (sem=0x18) at ../util/qemu-thread-posix.c:275
> >>> #2  0x00005575dd56a512 in multifd_send_thread (opaque=0x5575df054ef8) at ../migration/multifd.c:720
> >>> #3  0x00005575dda0709b in qemu_thread_start (args=0x7fd404001d50) at ../util/qemu-thread-posix.c:541
> >>> #4  0x00007fd45e8a26ea in start_thread (arg=0x7fd3faffd700) at pthread_create.c:477
> >>> #5  0x00007fd45cd2150f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> >>>
> >>> The multifd thread is posting channels_ready with an already freed
> >>> multifd_send_state.
> >>>
> >>> This is the bug Avihai has hit. We're going into multifd_save_cleanup()
> >>> so early that multifd_new_send_channel_async() hasn't even had the
> >>> chance to set p->running. So it misses the join and frees everything up
> >>> while a second multifd thread is just starting.
> >> Thanks for doing that.
> >>
> >> Would this series makes that bug easier to happen?
> >
> > I think so.
> > Patch #3 added an extra multifd_send_should_exit() check in 
> > multifd_send_sync_main(), so now it can exit early if the first channel 
> > fails.
> > Plus, now migration state is set to FAILED early by:
> > multifd_new_send_channel_async()->multifd_send_terminate_threads() and 
> > multifd_tls_outgoing_handshake()->multifd_send_terminate_threads()
> > so migration_iteration_run() is completely skipped because 
> > migration_is_active() check before it will return false.
> >
> > I *think* this is what makes main migration thread finish earlier and 
> > call multifd_save_cleanup() earlier, at least for me.
> >
> 
> I'm doing some experiments with a global semaphore like channels_ready
> instead of a per-channel structure like you suggested. I think we only
> need to have a point past which we're assured no more channels will be
> created. With that we'd only need one post at
> multifd_new_send_channel_async.

Fabiano, Avihai,

If this series is not drastically making things worse, I would leave that
issue alone for now and move on with reposting this one, with the hope that
we still have time to address this in 9.0 (while the issue existed much
longer).  I do have plan to merge this one earlier if possible, assuming
it'll be easier for the accelerator projects to rebase on top.

If I missed something please feel free to still reply in v2.

Thanks,

-- 
Peter Xu


