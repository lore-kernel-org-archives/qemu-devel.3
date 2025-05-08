Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE9C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7mQ-0007kA-Td; Thu, 08 May 2025 16:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uD7mP-0007jr-3J
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uD7mN-0005Uh-8v
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746735816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pcuFwboxXzi9TFsOabQ2I6EzEpt1cYtdd/DhNMeF49o=;
 b=Mpwy1uXxKB08Lbx0k66Qh9WEWzLvE3Qg/E8v6lWEOF41XR+hxOwWKsWpqfUJh6NUMJwtvM
 UcgqY/IjLwJ8W0mS92Ji37jJCBeAc/jV5LnnWRHF3qEdnrDpaQzSmQNU8RiZ7nkYuIqSbL
 +B0OraHMHkog5uKNzV1FiH2+KhZX7iY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-F7GGmInoOs2crQNz0yHGCg-1; Thu, 08 May 2025 16:23:34 -0400
X-MC-Unique: F7GGmInoOs2crQNz0yHGCg-1
X-Mimecast-MFC-AGG-ID: F7GGmInoOs2crQNz0yHGCg_1746735814
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7caee990722so262019585a.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746735814; x=1747340614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcuFwboxXzi9TFsOabQ2I6EzEpt1cYtdd/DhNMeF49o=;
 b=ahMyDxgTGUhla+Xcm8EriGHsnZv+9mTKN+jMztI6VCNolX2eFhjexMpDfZcymxx4kt
 H733bDpLgga5SuKDcN42g1VBgOdvV1OxN6rZ8AveVIyn7nYJDpmIYBsqQzF2vd3UKExV
 3oZ7cq4UiIbZe7YcIFw17R1wnip/IfOz7truPFShPhVznSGFU7aIS3BVqBfdJLjOX11t
 qudeC1kHJT17CVYFMot98hFC3vAhj8kFalsGn9OMr5OVB/wW+axVHxyq2EOw1+AgiZdy
 zsNfDx/Juz9mOjytgVQm3gJ0f9Oj4htflYNHPoTCFSrlzWmG+/jLNlXMyRRzzVzVuAUm
 StmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsEGdqtTFCnqMZLozfkmF4fxaLHxVKQXq6h3QlGQjyF6gkKKfKzIJzf6gQXSzWY/iyyCIUDSIWOgxv@nongnu.org
X-Gm-Message-State: AOJu0Ywx+H/qtMjUeXaddYeMVg6LTz0pSTGmsamsWIYMhbpHXax6FWW7
 06pmTR2hrgNWUB4i1ecSiEV1Va3qirLoiIUog+x7FcvGraicP1EWqcgLA2/jIKr5XXJYIMJID5p
 n+EYKXbupKb7f5a4yv0o9dQJg++K86vCFFie47k5JhKa1gPSQAyYY
X-Gm-Gg: ASbGnctyDRmNwHStAvm4PyK0uX4LwZwjhOKYJdTe/hv+NKGrwETubXgPNE5x+t4aqHG
 D930ixE/96jzC/qMBUl5/w4+NIC0MbHBIDHkJ0Kg592SCXui3T5av85O/0cczO2l5ajMFLIZGIo
 FLyu8zafj0+e3UzsLDbFOmacyEWD/o0paGoN2PQYjHLjy4DuEBStsGlg83iKhg0r7iKXyaFXrOz
 dZnfsTF1yatDxvlyjs8y0LN0bOBnmG6qZrL+8MPHP/ZLi/GuhVFuVs1pzXnoB06ynniM1yEmQ/1
 iuU=
X-Received: by 2002:a05:620a:1916:b0:7c5:47c6:b886 with SMTP id
 af79cd13be357-7cd011393admr156880885a.43.1746735814445; 
 Thu, 08 May 2025 13:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjB0Y7JO/mP+K2NxMoNQUBVoHKiML8o7lKXzD8Jcqweglwu7MmG0HI/D2m6BJdiueznOqFog==
X-Received: by 2002:a05:620a:1916:b0:7c5:47c6:b886 with SMTP id
 af79cd13be357-7cd011393admr156878385a.43.1746735814120; 
 Thu, 08 May 2025 13:23:34 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f4e13bsm36480885a.20.2025.05.08.13.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 13:23:33 -0700 (PDT)
Date: Thu, 8 May 2025 16:23:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <aB0Swile4IjxTUsd@x1.local>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
 <871ptqg6u9.fsf@suse.de> <151d8c-680a4080-15-6f9ea10@196998929>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151d8c-680a4080-15-6f9ea10@196998929>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, Apr 24, 2025 at 03:44:49PM +0200, Marco Cavenati wrote:
> > If we decide we need to explicitly select that new code, I don't think
> > we need any new capability, because the user has no choice in it. We
> > know that loadvm needs it, but -loadvm doesn't, any other sort of
> > mapped-ram migration also doesn't need it. There is some discussion to
> > be had on whether we want to bind it to the commands themselves, or do
> > some form of detection of clean ram. I think it's best we postopone this
> > part of the discussion until Peter is back (next week), so we can have
> > more eyes on it.

Some more eyes are back, useful or not. :)

> 
> The scenarios where zeroing is not required (incoming migration and
> -loadvm) share a common characteristic: the VM has not yet run in the
> current QEMU process.
> To avoid splitting read_ramblock_mapped_ram(), could we implement
> a check to determine if the VM has ever run and decide whether to zero
> the memory based on that? Maybe using RunState?
> 
> Then we can add something like this to read_ramblock_mapped_ram()
> ...
> clear_bit_idx = 0;
> for (...) {
>     // Zero pages
>     if (guest_has_ever_run()) {
>         unread = TARGET_PAGE_SIZE * (set_bit_idx - clear_bit_idx);
>         offset = clear_bit_idx << TARGET_PAGE_BITS;
>         host = host_from_ram_block_offset(block, offset);
>         if (!host) {...}
>         ram_handle_zero(host, unread);
>     }
>     // Non-zero pages
>     clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> ...
> (Plus trailing zero pages handling)

[...]

> > >> > In a nutshell, I'm using dirty page tracking to load from the snapshot
> > >> > only the pages that have been dirtied between two loadvm;
> > >> > mapped-ram is required to seek and read only the dirtied pages.

I may not have the full picture here, please bare with me if so.

It looks to me the major feature here you're proposing is like a group of
snapshots in sequence, while only the 1st snapshot contains full RAM data,
the rest only contains what were dirtied?

From what I can tell, the interface will be completely different from
snapshots then - firstly the VM will be running when taking (at least the
2nd+) snapshots, meanwhile there will be an extra phase after normal save
snapshot, which is "keep saving snapshots", during the window the user is
open to snapshot at any time based on the 1st snapshot.  I'm curious what's
the interfacing for the feature.  It seems we need a separate command
saying that "finished storing the current group of snapshots", which should
stop the dirty tracking.

I'm also curious what is the use case, and I also wonder if "whether we
could avoid memset(0) on a zero page" is anything important here - maybe
you could start with simple (which is to always memset() for a zero page
when a page is dirtied)?

Thanks,

-- 
Peter Xu


