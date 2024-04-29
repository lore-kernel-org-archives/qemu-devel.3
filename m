Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C16C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WLo-00035j-Fs; Mon, 29 Apr 2024 15:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WLf-00034a-UQ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WLT-0003vQ-6b
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714417641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3edzH0JvWg5Vo651BGwfUmiryy8Xjv7VeI2KnDG9aHg=;
 b=LjeGZPzFffkuZiQq75fX1tTR4yiGIbGSy70mxApSoMke6lNRYPGMGn2Y43WQ0Ntn2JVrvB
 fq8M8wWgJNzuzX9NIRZe3/XOZzLGs6R6BqUos4VY/8eS/V9S88hbFfstAU0mp2nLadKOnI
 QgpbfksW/RTl6VFSdWYacyd9O+JGlvk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-sTYqwFcCOoCvt6XKcGDAdg-1; Mon, 29 Apr 2024 15:07:19 -0400
X-MC-Unique: sTYqwFcCOoCvt6XKcGDAdg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b265953217so49102a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714417638; x=1715022438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3edzH0JvWg5Vo651BGwfUmiryy8Xjv7VeI2KnDG9aHg=;
 b=ZBj4cLiayw3j+Psg/RarUn1lZJQriuZ1GD1kQ/XvDVHiB0ClM0kM3OHBBdGA3cunsw
 dBTNxBjLQ/6RGkPwCRbd/MFPInh+v4w7nCAO7PBEGxXTcYbnfPVG6skLwuaJ6i1uFc2z
 p7AREsEOguIxLqvlq1Xo797RBTyDFC+oXg3Ws5PqEA69FhlSYmFSqCdLZDPOSayMdSLz
 qWUl8wwYLn7T9RdCn70j0DURM6GvtoENgvyrRPD90qcLfeJOytrArvIlJ9S2YlVByouW
 C334s+WAsTUvF+lgjtQmS/lZ/2GKDvwIaCpJG02eG1QOPv3CaUL9JjR9sV4JKrxWbi76
 aA1w==
X-Gm-Message-State: AOJu0YylUBuQL9bK4V/J0K4BtARKqcLy9YSYxVB9tLpvNoR4Db4O0xjQ
 uwJFL8QyUbvcqFREZ41oPe5a7DKdRXGbixMbdTY/JPqmbxcNJ9ZPgaopvNwbVrzsq1Uu79IK+Je
 tu6tHlYlqnaSCGvKmfgc5tr+WhoTuh4Q0eRckDrzEzSVDEEqop5lz
X-Received: by 2002:a05:6a20:9789:b0:1af:5385:3aff with SMTP id
 hx9-20020a056a20978900b001af53853affmr1632315pzc.3.1714417637943; 
 Mon, 29 Apr 2024 12:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgguPGiUF04UXOnTg7ThOv8OzECqSqdo8/iqTB6Abb4HF9a/YS5MBiTO3GjwXDUkMtC70Yzg==
X-Received: by 2002:a05:6a20:9789:b0:1af:5385:3aff with SMTP id
 hx9-20020a056a20978900b001af53853affmr1632275pzc.3.1714417637196; 
 Mon, 29 Apr 2024 12:07:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ki14-20020a170903068e00b001e434923462sm20749771plb.50.2024.04.29.12.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:07:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:07:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 6/6] migration: Deprecate fd: for file migration
Message-ID: <Zi_v4XEhSk43z5ey@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-7-farosas@suse.de> <Zi_puGn7Y1ArcLCL@x1n>
 <87zftcdn04.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zftcdn04.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 03:47:39PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 10:14:08AM -0300, Fabiano Rosas wrote:
> >> The fd: URI can currently trigger two different types of migration, a
> >> TCP migration using sockets and a file migration using a plain
> >> file. This is in conflict with the recently introduced (8.2) QMP
> >> migrate API that takes structured data as JSON-like format. We cannot
> >> keep the same backend for both types of migration because with the new
> >> API the code is more tightly coupled to the type of transport. This
> >> means a TCP migration must use the 'socket' transport and a file
> >> migration must use the 'file' transport.
> >> 
> >> If we keep allowing fd: when using a file, this creates an issue when
> >> the user converts the old-style (fd:) to the new style ("transport":
> >> "socket") invocation because the file descriptor in question has
> >> previously been allowed to be either a plain file or a socket.
> >> 
> >> To avoid creating too much confusion, we can simply deprecate the fd:
> >> + file usage, which is thought to be rarely used currently and instead
> >> establish a 1:1 correspondence between fd: URI and socket transport,
> >> and file: URI and file transport.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  docs/about/deprecated.rst | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >> 
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index 0fb5c82640..813f7996fe 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -464,3 +464,17 @@ both, older and future versions of QEMU.
> >>  The ``blacklist`` config file option has been renamed to ``block-rpcs``
> >>  (to be in sync with the renaming of the corresponding command line
> >>  option).
> >> +
> >> +Migration
> >> +---------
> >> +
> >> +``fd:`` URI when used for file migration (since 9.1)
> >> +''''''''''''''''''''''''''''''''''''''''''''''''''''
> >> +
> >> +The ``fd:`` URI can currently provide a file descriptor that
> >> +references either a socket or a plain file. These are two different
> >> +types of migration. In order to reduce ambiguity, the ``fd:`` URI
> >> +usage of providing a file descriptor to a plain file has been
> >> +deprecated in favor of explicitly using the ``file:`` URI with the
> >> +file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
> >> +command documentation for details on the ``fdset`` usage.
> >
> > Wanna do some warn_report() when detected non-socket fds alongside?  Looks
> > like we previously do this for all deprecations.
> 
> Yes, good point.
> 
> >
> > What's the plan when it's support removed?  I'm imaginging that we sanity
> > check fstat() + S_ISSOCK on the fd and fail otherwise?  In that case we can
> > have the code there, dump warn_report(), then switch to failing qmp migrate
> > (and incoming side) later on?
> 
> Something along those lines. We currently use fd_is_socket():
> 
> bool fd_is_socket(int fd)
> {
>     int optval;
>     socklen_t optlen = sizeof(optval);
>     return !getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
> }
> 
> I'm thinking of this in fd_start_outgoing_migation():
> 
>     if (!fd_is_socket(fd)) {
>         warn_report("fd: migration to a file is deprecated."
>                     " Use file: instead.");
>     }

Sounds good, perhaps also in fd_start_incoming_migration().

-- 
Peter Xu


