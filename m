Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED1C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPvd-0006Ch-1g; Thu, 01 Feb 2024 00:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPvc-0006CU-Cb
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:48:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPvZ-0006nN-Qf
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706766477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWBmzfKHBijB3txDMi+RTxKzLxuhin9HzTm/96/+sAg=;
 b=ApGQ9q6TTv7B5jRZxgjrB53C7ZHc0pO2/XW9ee0Pj4Ij0NPSQU6SyBnVE9WZYGdnvb1LLj
 yEp74tBSRFMdRtOUsf0AUIpanAI+vFXUHcDqlxiNghF29W1wC5Ux722lMb02ch4NtU9jxT
 db7R93BtvtbsJ6uIXiVlY1VVagltFzc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326--uRf3uSvO0SLLlCh2T4znw-1; Thu, 01 Feb 2024 00:47:54 -0500
X-MC-Unique: -uRf3uSvO0SLLlCh2T4znw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so141758a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706766473; x=1707371273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWBmzfKHBijB3txDMi+RTxKzLxuhin9HzTm/96/+sAg=;
 b=NAoNamW9OSEmzGfVctB9KSUvB7+dfvKJh7gI5RAk8bUh8RiDXPAXp2jYh1JrymX3s6
 SOlhdREw7PU4YajIoyZ/tQGI92opRU4WltRb+mW8pDe1Bol7jyWBg49XpWyDsbNyBAuW
 mGWTVI47gtwXVm3GM2mb2HQAQ5PUDntf9K9qefr+Y612NTbXDUMV2v7tBDPpzdqonUD8
 gCbrNEJIb2OO9E7VF3q41rjbaaXpeVgcH6W1V2UPSKmAO/Xlu6tU7c3kp9mDb16QepF0
 MfmnwMLxvp7WXpKW+KctGEHDY9XpQFK4YkMhyfuiL5YKsK12ta4NIRdcMOnAvS8LnNqK
 R0JQ==
X-Gm-Message-State: AOJu0Yw2bgIxIQRMLFXgS1zU+Plb+CWzQtj/bG9EdC+/u5JsN6KpInaR
 m0WSjq5KlswO2XSGkCoNkXp1tGN+r4eC4Dcd7t1Y+R6MPiBMRpHxnW66DnKgOgRt8/0VYKa5InN
 /sPBy/o4ZRGKCXmXocl0/gte5xl1/kWLYS+SJ96HPg0DkzpZJuDti
X-Received: by 2002:a05:6a00:4b:b0:6dd:86b1:7d93 with SMTP id
 i11-20020a056a00004b00b006dd86b17d93mr1683093pfk.0.1706766472995; 
 Wed, 31 Jan 2024 21:47:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCUUmtBxVX0rTI18AlIAuh6sDNb/bEuCj983BXx1OoLmhApppmpJSEjpAzm/vgDe+43+Pw+Q==
X-Received: by 2002:a05:6a00:4b:b0:6dd:86b1:7d93 with SMTP id
 i11-20020a056a00004b00b006dd86b17d93mr1683083pfk.0.1706766472570; 
 Wed, 31 Jan 2024 21:47:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXA8hV3+zVIL2pFfzyuyus1l4buM0mxPuSYKXCsISXOc6NVRV7drK4RkmMeBjFUeKTswC0Afwvbd/HRhPCkkOvf9ZmIGkkP83W3T83n9382PIMBRl3Wk001egOxNvFkLTcUb/N3GYkmNn/kCv3ZMSSBedQQibeDmIqD7MnSPDDtwwVbmVvRn1coyRqBMBbh53qegvWQ3r+sAnGjD3lEERc=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j8-20020a056a00234800b006d6b91c6eb6sm11257141pfj.13.2024.01.31.21.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 21:47:52 -0800 (PST)
Date: Thu, 1 Feb 2024 13:47:45 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 00/14] migration/multifd: Refactor ->send_prepare() and
 cleanups
Message-ID: <ZbswgRJTXP4yKiuf@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <871q9xjey8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871q9xjey8.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 31, 2024 at 07:49:51PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > This patchset contains quite a few refactorings to current multifd:
> >
> >   - It picked up some patches from an old series of mine [0] (the last
> >     patches were dropped, though; I did the cleanup slightly differently):
> >
> >     I still managed to include one patch to split pending_job, but I
> >     rewrote the patch here.
> >
> >   - It tries to cleanup multiple multifd paths here and there, the ultimate
> >     goal is to redefine send_prepare() to be something like:
> >
> >       p->pages ----------->  send_prepare() -------------> IOVs
> >
> >     So that there's no obvious change yet on multifd_ops besides redefined
> >     interface for send_prepare().  We may want a separate OPs for file
> >     later.
> >
> > For 2), one benefit is already presented by Fabiano in his other series [1]
> > on cleaning up zero copy, but this patchset addressed it quite differently,
> > and hopefully also more gradually.  The other benefit is for sure if we
> > have a more concrete API for send_prepare() and if we can reach an initial
> > consensus, then we can have the recent compression accelerators rebased on
> > top of this one.
> >
> > This also prepares for the case where the input can be extended to even not
> > any p->pages, but arbitrary data (like VFIO's potential use case in the
> > future?).  But that will also for later even if reasonable.
> >
> > Please have a look.  Thanks,
> >
> > [0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
> > [1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de
> >
> > Peter Xu (14):
> >   migration/multifd: Drop stale comment for multifd zero copy
> >   migration/multifd: multifd_send_kick_main()
> >   migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
> >   migration/multifd: Postpone reset of MultiFDPages_t
> >   migration/multifd: Drop MultiFDSendParams.normal[] array
> >   migration/multifd: Separate SYNC request with normal jobs
> >   migration/multifd: Simplify locking in sender thread
> >   migration/multifd: Drop pages->num check in sender thread
> >   migration/multifd: Rename p->num_packets and clean it up
> >   migration/multifd: Move total_normal_pages accounting
> >   migration/multifd: Move trace_multifd_send|recv()
> >   migration/multifd: multifd_send_prepare_header()
> >   migration/multifd: Move header prepare/fill into send_prepare()
> >   migration/multifd: Forbid spurious wakeups
> >
> >  migration/multifd.h      |  34 +++--
> >  migration/multifd-zlib.c |  11 +-
> >  migration/multifd-zstd.c |  11 +-
> >  migration/multifd.c      | 291 +++++++++++++++++++--------------------
> >  4 files changed, 182 insertions(+), 165 deletions(-)
> 
> This series didn't survive my 9999 iterations test on the opensuse
> machine.
> 
> # Running /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
> ...
> kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> 
> 
> #0  0x00005575dda06399 in qemu_mutex_lock_impl (mutex=0x18, file=0x5575ddce9cc3 "../util/qemu-thread-posix.c", line=275) at ../util/qemu-thread-posix.c:92
> #1  0x00005575dda06a94 in qemu_sem_post (sem=0x18) at ../util/qemu-thread-posix.c:275
> #2  0x00005575dd56a512 in multifd_send_thread (opaque=0x5575df054ef8) at ../migration/multifd.c:720
> #3  0x00005575dda0709b in qemu_thread_start (args=0x7fd404001d50) at ../util/qemu-thread-posix.c:541
> #4  0x00007fd45e8a26ea in start_thread (arg=0x7fd3faffd700) at pthread_create.c:477
> #5  0x00007fd45cd2150f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> The multifd thread is posting channels_ready with an already freed
> multifd_send_state.
> 
> This is the bug Avihai has hit. We're going into multifd_save_cleanup()
> so early that multifd_new_send_channel_async() hasn't even had the
> chance to set p->running. So it misses the join and frees everything up
> while a second multifd thread is just starting.

Thanks for doing that.

Would this series makes that bug easier to happen?  I didn't do a lot of
test on it, it only survived the smoke test and the kicked CI job.  I think
we can still decide to fix that issues separately; but if this series makes
that easier to happen then that's definitely bad..

-- 
Peter Xu


