Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B41C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQTw-0007yP-Km; Fri, 09 May 2025 12:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDQTv-0007yF-Hg
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDQTs-0006kx-Ro
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746807705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSMSWqDuF7KZEoapTc5y0SPuSAW2rz9OzDiwUvbRvLE=;
 b=CvzvOgZ9mDDu67P/nlZdlC7mX7LhBVGxVTupd68svLPrUnzNOpSvlG06noelduz0MkTLwr
 9lRQb+IvDOgeJmcbg9wu2eZ4jYNUb08Yv2vzQinW/sqA3QXCa05pDALN1KBDMlnvWtM8qm
 AN8FDsy4RqhMNH9EDLEQsTCNnvMZOgI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-6YfnX9YrPWGjKIppC4CBwQ-1; Fri, 09 May 2025 12:21:44 -0400
X-MC-Unique: 6YfnX9YrPWGjKIppC4CBwQ-1
X-Mimecast-MFC-AGG-ID: 6YfnX9YrPWGjKIppC4CBwQ_1746807704
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c760637fe5so412325685a.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746807702; x=1747412502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSMSWqDuF7KZEoapTc5y0SPuSAW2rz9OzDiwUvbRvLE=;
 b=Rnt2151ntLf8sddysTKSLRxD7ODKYvkhDKYZDh6Ef/84HmXcDc6spz02316ZrySCIW
 7HXpvPXakbTQ/3Zfm8S24MGGiPXFMVFHPaA06JZt0rS6KWIlqVtL3qZAlzQvjXAbp9Mu
 1c6Luf3L32lWdoQ39yHr6QvI+MHPN+eBCw8Q5eUrPllTuElmDdBzebTMhf0MLPrvScTx
 LX/HPtVV0jf54XqToiPDAdaP0+fGs0tHalc12sy/GRu702Kt1kwWCwBGAsbM+3xV6fdP
 F7m5QnsrMw0nKTlffhvtgqVBQT63W46oCtLcSMd95NCmfYhrk4lx28iQNWeqZz/bzAJ8
 0v1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ7f/UsD9g2HwyaRJVmXnvY2idFgMAQ0mY+mtE0lL3D0IyV6aQ+NIGLuLabgzReWrXV10PNpcVIHSH@nongnu.org
X-Gm-Message-State: AOJu0YzIwpJBGMrMnhWgVqaHuCnWZ1JhEJn2x5WgObZeGwIr3RPCtSPK
 bf/UNcj8RibzivE/JBS3hFF05PaLERNB6RJsPiXtDAgtG/C4V0mFVxynyML0XQZoAoqcGZnsABm
 035/46NKe/dggn2LdnUU3OPEzlfF7TSrF1YDo09RsUa5EV7n2AlLQvEWQaIt4
X-Gm-Gg: ASbGncvqM9YLc80KtiQu3CZXTMdMCj2gkExa14av2ghfdohF6en9P3N06vrxkRSa3rz
 Qzg4nepZic5wg8JHScDgrSH+6t8JHZ0kkbkhDnpOQUw58Dp3OQDnik2AacpnA9POIGbC9EHrHIA
 GBKWy3JNGJ26Fi0nUWr57fB/xwFvMlT0Ssi3lZLLQIp1sqoxcl3FRtqV6n2uJgov3A7kngPDglz
 cSjokJHrhkiRKHymJr9hsoamK1LkFdZC9NUgJHJX7TfdDCD4OlIVyenyU5uD22UJssQw6igSUzo
 SQo=
X-Received: by 2002:a05:620a:2618:b0:7c5:5584:dc1b with SMTP id
 af79cd13be357-7cd01169048mr941548085a.54.1746807702261; 
 Fri, 09 May 2025 09:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlKp+54QeGqjs46NXXcpdhnV2j/VI8xLLHwWHn0gAwZZBtKuV9XuApd8M6LZCa6/nK8MkYZQ==
X-Received: by 2002:a05:622a:1314:b0:47b:4f3:b257 with SMTP id
 d75a77b69052e-4945276462bmr57061891cf.31.1746807690625; 
 Fri, 09 May 2025 09:21:30 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-49452584100sm14334411cf.57.2025.05.09.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 09:21:30 -0700 (PDT)
Date: Fri, 9 May 2025 12:21:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <aB4rhlVGCSk7IwoE@x1.local>
References: <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
 <871ptqg6u9.fsf@suse.de> <151d8c-680a4080-15-6f9ea10@196998929>
 <aB0Swile4IjxTUsd@x1.local>
 <193e5a-681dfa80-3af-701c0f80@227192887>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <193e5a-681dfa80-3af-701c0f80@227192887>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, May 09, 2025 at 02:51:47PM +0200, Marco Cavenati wrote:
> Hello Peter,
> 
> On Thursday, May 08, 2025 22:23 CEST, Peter Xu <peterx@redhat.com> wrote:
> 
> > > The scenarios where zeroing is not required (incoming migration and
> > > -loadvm) share a common characteristic: the VM has not yet run in the
> > > current QEMU process.
> > > To avoid splitting read_ramblock_mapped_ram(), could we implement
> > > a check to determine if the VM has ever run and decide whether to zero
> > > the memory based on that? Maybe using RunState?
> > > 
> > > Then we can add something like this to read_ramblock_mapped_ram()
> > > ...
> > > clear_bit_idx = 0;
> > > for (...) {
> > >     // Zero pages
> > >     if (guest_has_ever_run()) {
> > >         unread = TARGET_PAGE_SIZE * (set_bit_idx - clear_bit_idx);
> > >         offset = clear_bit_idx << TARGET_PAGE_BITS;
> > >         host = host_from_ram_block_offset(block, offset);
> > >         if (!host) {...}
> > >         ram_handle_zero(host, unread);
> > >     }
> > >     // Non-zero pages
> > >     clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> > > ...
> > > (Plus trailing zero pages handling)
> > 
> > [...]
> > 
> > > > >> > In a nutshell, I'm using dirty page tracking to load from the snapshot
> > > > >> > only the pages that have been dirtied between two loadvm;
> > > > >> > mapped-ram is required to seek and read only the dirtied pages.
> > 
> > I may not have the full picture here, please bare with me if so.
> > 
> > It looks to me the major feature here you're proposing is like a group of
> > snapshots in sequence, while only the 1st snapshot contains full RAM data,
> > the rest only contains what were dirtied?
> >
> > From what I can tell, the interface will be completely different from
> > snapshots then - firstly the VM will be running when taking (at least the
> > 2nd+) snapshots, meanwhile there will be an extra phase after normal save
> > snapshot, which is "keep saving snapshots", during the window the user is
> > open to snapshot at any time based on the 1st snapshot.  I'm curious what's
> > the interfacing for the feature.  It seems we need a separate command
> > saying that "finished storing the current group of snapshots", which should
> > stop the dirty tracking.
> 
> My goal is to speed up recurrent snapshot restore of short living VMs.
> In my use case I create one snapshot, and then I restore it thousands
> of times, leaving the VM running for just a few functions execution for
> example.
> Still, you are right in saying that this is a two steps process.
> What I added (not in this patch, but in a downstream fork atm) are a
> couple of HMP commands:
> - loadvm_for_hotreaload: in a nutshell it's a loadvm that also starts dirty
> tracking
> - hotreload: again a loadvm but that takes advantage of the dirty log
> to selectively restore only dirty pages
> 
> > I'm also curious what is the use case, and I also wonder if "whether we
> > could avoid memset(0) on a zero page" is anything important here - maybe
> > you could start with simple (which is to always memset() for a zero page
> > when a page is dirtied)?
> 
> My use case is, you guessed it, fuzz testing aka fuzzing.
> About the zeroing, you are right, optimizing it is not a huge concern for
> my use case, doing what you say is perfectly fine.
> 
> Just to be clear, what I describe above is not the content of this patch.
> This patch aims only to make a first step in adding the support for the
> mapped-ram feature for savevm/loadvm snapshots, which is a
> prerequisite for my hotreload feature.
> mapped-ram is currently supported only in (file) migration.
> What's missing from this patch to have it working completely, is the
> handling of zero pages. Differently from migration, with snapshots pages
> are not all zero prior to the restore and must therefore be handled.
> 
> I hope I summarized in an understandable way, if not I'll be happy to
> further clarify :) 

Yes, thanks.

So you don't really need to take sequence of snapshots?  Hmm, that sounds
like a completely different use case that I originally thought.

Have you thought of leveraging ignore-shared and MAP_PRIVATE for the major
chunk of guest mem?

Let me explain; it's a very rough idea, but maybe you can collect something
useful.

So.. if you keep reloading one VM state thousands of times, it's better
first that you have some shmem file (let's imagine that's enough.. you
could have more backends) keeping the major chunk of the VM RAM image that
you migrated before into a file.

Say, the major part of guest mem is stored here:

  PATH_RAM=/dev/shm/XXX

Then you migrate (with ignore-shared=on) to a file here (NOTE: I _think_
you really can use file migration in this case with VM stopped first, not
snapshot save/load):

  PATH_VM_IMAGE=/tmp/VM_IMAGE_YYY

Then, the two files above should contain all info you need to start a new
VM.

When you want to recover that VM state, boot a VM using this cmdline:

  $qemu ... \
  -object memory-backend-file,mem-path=$PATH_RAM,share=off
  -incoming file:$PATH_VM_IMAGE

That'll boot a VM, directly loading the shmem page cache (always present on
the host, occupying RAM, though, outside of VM lifecycle, but it's part of
the design..), loading VM image would be lightning fast because it's tiny
when there's almost no RAM inside.  No concern on mapped-ram at all as the
rest RAMs are too trivial to just be a stream.

The important bit is share=off - that will mmap() the VM major RAM as
MAP_PRIVATE, then it'll do CoW on the "snapshot" you made before, whenever
you writes to some guest pages during fuzzing some functions, it copies the
shmem page cache over.  shmem page cache should never change its content.

Sounds working to you?

Thanks,

-- 
Peter Xu


