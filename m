Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4698CC48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 01:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhJyJ-0002w9-IU; Mon, 04 Mar 2024 20:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhJyG-0002uM-N4
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 20:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhJyD-0007hQ-Pn
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 20:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709603504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuiIcdpzUi6J8DInd0oJT7G9xu38q0xz9vwLy1droKw=;
 b=avobbFnRc5iF8gVylEG2pkHCuU4QfLbNgL8SC0Ao1cDH93WEQGbr/9gCYDOU3R+U0k5w+w
 CStzeoEZlpeutMhU1oEg486fveYHfGeJYBx5vEeTlMS4BqeAfpSaauUMnCd54fjvK8siXA
 f1MYOXls+9NUdIG/u01yK+VDLJsPGsQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-wUxYSFMhMAWD1mtqE0Mlwg-1; Mon, 04 Mar 2024 20:51:42 -0500
X-MC-Unique: wUxYSFMhMAWD1mtqE0Mlwg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso2404111a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 17:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709603501; x=1710208301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YuiIcdpzUi6J8DInd0oJT7G9xu38q0xz9vwLy1droKw=;
 b=JX0+2aqRFTNHeECT2cL5eac8lvJr8PpvkeSrTfll/E3AYQs/m46SPqio/uP74Ydx/7
 Qp56Y1v8bGs0cmQcv+WGbTXjcN9cbEVyINAciMzC6pEnKWgmqQCOv6kFQzpHs0JxkITM
 K14ksMb3IijD3uPQ/CcuuS+p5JHwZDbeba4Qim/WpopVe3r7H81RwK2lfunQIUDGieOT
 AuKDv5dvaR4vr8Xobrkj5RHop8PhSrmxD/MPKuPF0JZ5iQTK+s2uddFr+hYYvbhFEytO
 2FqeCUo3urkL6gADpuqR56SZSM5b98EIY1P5z+IXQjJsw6jA+eEWmpTc0fL0NZ2fNe95
 YtgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIPas2lNjYTwxSl7CAyGkDaBvQjurupkDgRwCFGutVeLdBZhf9Il+7UMI9tyLJywur8g1sVg1zQoJX+t6EVZuZ724PZ94=
X-Gm-Message-State: AOJu0YzmE9QkW2rsEaLg5kV5BR0pEn8QVF62ZNn5kd12Wz8w8hvZ0mQC
 YL46g2ooTiB0Wh+l741KIP/Mi297oD2k6RjKcS+D1RqshA8SpKEBnyt/l8lpd4HnsUspS8nhlDL
 zKl5OvWMY1Oq1quQteHYs1nJwQOq6yOeu8K6V7BfddaIFi6NUjyZ2iODLDQVq+7M=
X-Received: by 2002:a05:6a00:93a4:b0:6e6:c6f:dc7e with SMTP id
 ka36-20020a056a0093a400b006e60c6fdc7emr7455138pfb.3.1709603500638; 
 Mon, 04 Mar 2024 17:51:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5n1GR0QgzU3dcfrSaAg+hiwIwHAhDA04aHINSHjAi/3yOPWjDuCKJw/Urbo0gr0qsCBH5NQ==
X-Received: by 2002:a05:6a00:93a4:b0:6e6:c6f:dc7e with SMTP id
 ka36-20020a056a0093a400b006e60c6fdc7emr7455118pfb.3.1709603500173; 
 Mon, 04 Mar 2024 17:51:40 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b123-20020a62cf81000000b006e594b068c8sm8147209pfg.116.2024.03.04.17.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 17:51:39 -0800 (PST)
Date: Tue, 5 Mar 2024 09:51:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeZ6pI0O4-3ZQ10A@x1n>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com> <ZeXEROyMmHffj1b2@x1n>
 <ZeXIoVho09HtXKQQ@x1n> <87r0gp21py.fsf@suse.de>
 <ZeY3c-zFV-i1mrrP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeY3c-zFV-i1mrrP@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 04, 2024 at 09:04:51PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 04, 2024 at 05:15:05PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Mon, Mar 04, 2024 at 08:53:24PM +0800, Peter Xu wrote:
> > >> On Mon, Mar 04, 2024 at 12:42:25PM +0000, Daniel P. Berrangé wrote:
> > >> > On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
> > >> > > Fabiano,
> > >> > > 
> > >> > > On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> > >> > > > => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
> > >> > > 
> > >> > > I'm curious normally how much time does it take to do the final fdatasync()
> > >> > > for you when you did this test.
> > 
> > I measured and it takes ~4s for the live migration and ~2s for the
> > non-live. I didn't notice this before because the VM goes into
> > postmigrate, so it's paused anyway.

For my case it took me tens of seconds at least, if not go into minutes,
which I didn't measure.

I could have dirtied harder, or I just had a slower disk.  IIUC the worst
case is all cache dirty (didn't yet writeback in the kernel), say 100GB,
assuming the disk bandwidth 1GB/s (that's the bw of my test machine hard
drive of 1M chunk dd for a 10GB file, even without a sync..), IIUC it means
it could take 1min or more in reality.

> > 
> > >> > > 
> > >> > > I finally got a relatively large system today and gave it a quick shot over
> > >> > > 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
> > >> > > migration save/load does all fine, so I don't think there's anything wrong
> > >> > > with the patchset, however when save completes (I'll need to stop the
> > >> > > workload as my disk isn't fast enough I guess..) I'll always hit a super
> > >> > > long hang of QEMU on fdatasync() on XFS during which the main thread is in
> > >> > > UNINTERRUPTIBLE state.
> > >> > 
> > >> > That isn't very surprising. If you don't have O_DIRECT enabled, then
> > >> > all that disk I/O from the migrate is going to be in RAM, and thus the
> > >> > fdatasync() is likely to trigger writing out alot of data.
> > >> > 
> > >> > Blocking the main QEMU thread though is pretty unhelpful. That suggests
> > >> > the data sync needs to be moved to a non-main thread.
> > >> 
> > >> Perhaps migration thread itself can also be a candidate, then.
> > >> 
> > >> > 
> > >> > With O_DIRECT meanwhile there should be essentially no hit from fdatasync.
> > >> 
> > >> The update of COMPLETED status can be a good place of a marker point to
> > >> show such flush done if from the gut feeling of a user POV.  If that makes
> > >> sense, maybe we can do that sync before setting COMPLETED.
> > 
> > At the migration completion I believe the multifd threads will have
> > already cleaned up and dropped the reference to the channel, it might be
> > too late then.
> > 
> > In the multifd threads, we'll be wasting (like we are today) the extra
> > syscalls after the first sync succeeds.
> > 
> > >> 
> > >> No matter which thread does that sync, it's still a pity that it'll go into
> > >> UNINTERRUPTIBLE during fdatasync(), then whoever wants to e.g. attach a gdb
> > >> onto it to have a look will also hang.
> > >
> > > Or... would it be nicer we get rid of the fdatasync() but leave that for
> > > upper layers?  QEMU used to support file: migration already, it never
> > > manage cache behavior; it does smell like something shouldn't be done in
> > > QEMU when thinking about it, at least mapped-ram is nothing special to me
> > > from this regard.
> > >
> > > User should be able to control that either manually (sync), or Libvirt can
> > > do that after QEMU quits; after all Libvirt holds the fd itself?  It should
> > > allow us to get rid of above UNINTERRUPTIBLE / un-debuggable period of QEMU
> > > went away.  Another side benefit: rather than holding all of QEMU resources
> > > (especially, guest RAM) when waiting for a super slow disk flush, Libvirt /
> > > upper layer can do that separately after releasing all the QEMU resources
> > > first.
> > 
> > I like the idea of QEMU having a self-contained
> > implementation. Specially since we'll add O_DIRECT support, which is
> > already quite heavy-handed if we're talking about managing cache
> > behavior.

O_DIRECT is optionally selected by the user by setting the new parameter
first, so the user is still in full control - it's still user's decision on
how cache should be managed, even if QEMU needs explicit changes to support
and expose the new parameter.

For fdatasync(), I think it's slightly different in that it doesn't require
anything implemented in QEMU, as the snapshot is always in the form of a
file, and file is pretty common concept which well supports sync semantics
separately.  Instead of providing yet another parameter to control it, we
can just avoid that datasync.

Besides what I already described above as reasons, I think it's also legal
if an user wants to temporarily flush a VM into a disk (in paused state),
run some RAM-intense loads (which can immediately make use of guest's RAM
which is directly freed, but may _not_ always require a page cache flush),
then relaunch the VM.  In that case keeping some cache around might help
already to speedup relaunching to avoid unnecessary swap-ins/swap-outs.

> > 
> > However, it's not trivial to find the right place to add the sync.
> > Wherever we put it there will be some implications, such as ensuring the
> > sync works even after migration failure, avoiding concurrent cleanup,
> > etc.
> > 
> > In any case, I don't think it's correct to have the sync at
> > qio_channel_close(), now that we've seen it might block for a long
> > time. We could at the very least have a qio_channel_flush()[1] which the
> > QIOChannelFile implements with fdatasync(). Then the clients can choose
> > when to sync.
> 
> Yes, I agree with de-coupling it.

Yes, that decoupling makes sense to me.  That definitely answers some of my
previous confusions.

The following question is whether we should require a qio_channel_flush()
by default at anywhere around the end of migration for mapped-ram, in which
case I lean towards removing it completely.  In all cases, considering the
time it could hang qemu (possible in minutes) we may want to change that
behavior for 9.0 if possible.

Thanks,

-- 
Peter Xu


