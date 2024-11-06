Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C072D59F4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iSN-0002al-EG; Wed, 06 Nov 2024 11:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8iSM-0002aY-8o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8iSI-00037v-Cs
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730908823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7sdH+rYKC6KHs1cHu43aGInVlwCqkBC58JodVVzum8M=;
 b=P0d5f8VsqQ8qqocXHoWdZC0J6oW8vPJD3VC//6J4r0FTWGUJGCnjQ0O6ll6egS7wPE/HhO
 4AFkYnmuD4IMjstKBXQdjb55XVFfISvcacJBpUQP0VJ4FFAGQzBDfU58EmiU6p2xq6y6mg
 CGFy7mVK53hwPUAKRZE0kQ5IYEl0As8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-RI9Hjqb4NAiO4yUHT_Scqg-1; Wed, 06 Nov 2024 11:00:20 -0500
X-MC-Unique: RI9Hjqb4NAiO4yUHT_Scqg-1
X-Mimecast-MFC-AGG-ID: RI9Hjqb4NAiO4yUHT_Scqg
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-288de8b3be2so5165282fac.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730908819; x=1731513619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sdH+rYKC6KHs1cHu43aGInVlwCqkBC58JodVVzum8M=;
 b=fGRwWKyO/Ok8uU+2y8vsfWVvPROLCnF7bJ4kajrsh/kwrCg1/nR+ikW/vlIzORlBIS
 m/1AwooCi/AwWNVbgEjrcEykLqTdHJrFUBPnB/nljM/YH9N9rfyEqX35z78OQ/W8ZxR8
 BE5fwDzzW85gzQhPs4o85rK8N4vu36M1uT9uaKXDadX75HCA+iUimVamhoyKb196Avib
 Zb0YdejZ2R6cyxZFyEhCgoJ+HfaLUHqkhHtchhelXnMTSn3F8QQvOqE36J8PdG25VabX
 Tts3Sr7rVgl721Z8DPIPsxM+a+W3e2dqbDgLc5BXFcxuojNLpljrTCbxLrdnnv7Hh3au
 TWwg==
X-Gm-Message-State: AOJu0YwZGLtQ+lI/yPyOUnCmQBbfwiOTW3Yl1Vr7oSmnVN8rciiQseQk
 IWptB8grR2wowbRWF85y+tfgaIfUNbLeeHQowDm1vk0Mfy+jF4f+Nf3Yt0tHd1KCbdvEFZJAink
 R1PECr1yNmtCvpb5RZZj+ur4fWjh/5wErBtnvA1qS2osRUFUU5bTl
X-Received: by 2002:a05:6870:2b09:b0:277:f14c:9c0f with SMTP id
 586e51a60fabf-2949efbaf21mr18689070fac.32.1730908818008; 
 Wed, 06 Nov 2024 08:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQCECjlY1+wGzvihDtX/IJzFNyvNW0SgadA/LnSeodY7stYshOMRruKwtu3pwMUczqj77lA==
X-Received: by 2002:a05:6870:2b09:b0:277:f14c:9c0f with SMTP id
 586e51a60fabf-2949efbaf21mr18689021fac.32.1730908817465; 
 Wed, 06 Nov 2024 08:00:17 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29487429f9csm4393026fac.9.2024.11.06.08.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 08:00:16 -0800 (PST)
Date: Wed, 6 Nov 2024 11:00:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZyuSjp2rImbm6ByN@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 06, 2024 at 05:49:23PM +0530, Prasad Pandit wrote:
> On Tue, 5 Nov 2024 at 18:30, Peter Xu <peterx@redhat.com> wrote:
> > https://www.qemu.org/docs/master/devel/qapi-code-gen.html
> >
> >         Sometimes, the behaviour of QEMU changes compatibly, but without a
> >         change in the QMP syntax (usually by allowing values or operations
> >         that previously resulted in an error). QMP clients may still need
> >         to know whether the extension is available.
> >
> >         For this purpose, a list of features can be specified for
> >         definitions, enumeration values, and struct members. Each feature
> >         list member can either be { 'name': STRING, '*if': COND }, or
> >         STRING, which is shorthand for { 'name': STRING }.
> 
> * I see, okay.
> 
> > It's a legacy issue as not all features are developed together, and that
> > was planned to be fixed together with handshake.  I think the handshake
> > could introduce one header on top to pair channels.
> >
> > IMHO it is an overkill to add a feature now if it works even if tricky,
> > because it's not the 1st day it was tricky. And we're going to have another
> > header very soon..
> 
> * See, current (this series)  'if'  conditional in the
> migration_ioc_process_incoming() function is simple as:
> 
>     if (qio_channel_has_feature(ioc,
> QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) { peek_magic_bytes() ... }

IIUC we can't simply change it to this.  We can do this with a compat
property and we can start sending a magic in the preempt channel, but then
the code still needs to keep working with old binaries of QEMU, so in all
cases we'll need to keep the old complexity for quite a while.

IOW, I think it may break migrations from old QEMUs when postcopy preempt
is enabled, because then the new QEMU (with your patch applied) will always
peek the byte assuming the magic is there, but old binaries don't have
those.

Handshake, in my mind, will use a totally separate path, then the hope is
we'll move to that with more machine types and finally obsolete / remove
this path.

> 
> If we don't send magic value for the postcopy channel, then we avoid
> peeking into magic bytes when postcopy is enabled, because otherwise
> thread will block peeking into the magic bytes, so the 'if'
> conditional becomes:
> 
>     if (migrate_multifd() && !migrate_postcopy() &&
> qio_channel_has_feature (...) ) {
>         peek_magic_bytes()
>         ...
>     } else {
>        When migrate_postcopy() is true
>        It'll reach here not only for the 'Postcopy' channel, but even
> for the 'default' and 'multifd' channels which send the magic bytes.
> Then here again we'll need to identify different channels, right?
>     }
> 
> * Let's not make it so complex. Let's send the magic value for the

Firstly, the complexity is there on migration, requiring it work with old
qemu binaries, bi-directional by default.  In your case you're changing
receiving side, so it's even more important, because it's common old qemu
migrates to new ones.

What I want to avoid is we introduce two flags in a short period doing the
same thing.  If we want we can merge the effort, I'll leave that to you and
Fabiano to decide, so that maybe you can work out the channel establishment
part of things.

But note again that I still think your goal of enabling multifd + postcopy
may not require that new flag yet, simply because after 7.2 qemu will
connect preempt channel later than the main channel.  I think logically
QEMU can identify which channel is which: the preempt channel must be
established in this case after both main thread and multifd threads.

Meanwhile, as mentioned above, we still need to make pre-7.2 works in
general on migration in most cases (when there's network instability it
won't work.. so that's unavoidable)..  it's indeed slightly complicated,
but hopefully could still work.

In all cases, we may want to test postcopy preempt from a 7.1 qemu to the
new qemu to keep it working when the patch is ready (and you can already
try that with current patch).

> postcopy channel and simplify it. If 'handshake' feature is going to
> redo it, so be it, what's the difference? OR maybe we can align it
> with the 'handshake' feature or as part of it or something like that.
> 
> @Fabiano Rosas : may I know more about the 'handshake' feature? What
> it'll do and not do?
> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


