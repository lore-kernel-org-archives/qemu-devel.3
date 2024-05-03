Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4845C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30J5-0006Er-8D; Fri, 03 May 2024 17:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30J0-0006EG-NT
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30Ix-0005Eg-Us
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714771133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQ+KVArex3V9qYfBIO7Ll2iKJITF4KxrWZdl3r6/oI0=;
 b=PSavJtWnZkF7lOdmrye9tvL3Uk7UAeFLNQYV5BeZs+brouymQTMblssGZKwHPNtXFAXALU
 w1hBEh79AnWBx04b6mizvaNxVDuGo1o0LXIYQhJ4IP9wFyhUgK9mUWuxyC36owqb0F6XHM
 ftH/LHCwhj+Gwb2NNtT0Owib6NS28SI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-oKgY5YEsOGKKD77UxhjzrQ-1; Fri, 03 May 2024 17:18:51 -0400
X-MC-Unique: oKgY5YEsOGKKD77UxhjzrQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c95154adedso30247b6e.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714771131; x=1715375931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQ+KVArex3V9qYfBIO7Ll2iKJITF4KxrWZdl3r6/oI0=;
 b=Zsk2ZT//Sxr4TutCMwPMTKBzftgatjRXtLFcAVKHsnOJYXgACVSyaQT4H0Ctzr8wF5
 Z3r/VufzmgrA0yLKytIEoyFiSkY4nwFFmhD39JsxN3tdZAl9K5BW0RYRk+/dv134jrGf
 QbLRMAEkIVqk3xGJ794CosQDjU8S88kOpsx6Y+xM4IXG+GWnU9vsuAjkZD/eqKDQ8xfo
 JX0PTdYyq3hwFPXQ2/nj8NR+HKOfN0C3Rsg+hiV4D5NPN4NQ6usA89wteCLAjsqSIG5a
 vJTqCqsijbq6u/0tL1D+dOtPCCOo81amAGYiF/rdHcwyjVP4hai9nSUkqDbjGPD8YKY3
 eXcw==
X-Gm-Message-State: AOJu0YzQ7BgDicb6P4Yep5UpC9AUg62TY7a63DAfWM4qE05z/JVweywZ
 /XoWtVM/+wNjJqYVOshyoK15GyLsDI0JpFFlhhSFXUQnHk35RlFINJpyR/FNlE/Tc6rG6qAOz0Y
 DBixoaqem1+Dk/GdAEKVRgPBGN4ewAr0OXYqtjLCUORx8tnLDEWcG
X-Received: by 2002:a05:6808:16a3:b0:3c8:54ca:511d with SMTP id
 bb35-20020a05680816a300b003c854ca511dmr4654477oib.1.1714771130410; 
 Fri, 03 May 2024 14:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgmOpF4CBaiBLbhM1qic2qKu5jbdBo1dIz2np67Wuwkoi9G1MFJlOkOPMjThsej9UEa9nSKg==
X-Received: by 2002:a05:6808:16a3:b0:3c8:54ca:511d with SMTP id
 bb35-20020a05680816a300b003c854ca511dmr4654445oib.1.1714771129874; 
 Fri, 03 May 2024 14:18:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 y17-20020ad45311000000b006a0eb265a6asm1508082qvr.65.2024.05.03.14.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:18:49 -0700 (PDT)
Date: Fri, 3 May 2024 17:18:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 5/9] migration/multifd: Add direct-io support
Message-ID: <ZjVUt179hf4njXmr@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-6-farosas@suse.de> <ZjUs-2mhVDrPd3Kl@x1n>
 <87y18qmxa3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y18qmxa3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On Fri, May 03, 2024 at 05:54:28PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:38AM -0300, Fabiano Rosas wrote:
> >> When multifd is used along with mapped-ram, we can take benefit of a
> >> filesystem that supports the O_DIRECT flag and perform direct I/O in
> >> the multifd threads. This brings a significant performance improvement
> >> because direct-io writes bypass the page cache which would otherwise
> >> be thrashed by the multifd data which is unlikely to be needed again
> >> in a short period of time.
> >> 
> >> To be able to use a multifd channel opened with O_DIRECT, we must
> >> ensure that a certain aligment is used. Filesystems usually require a
> >> block-size alignment for direct I/O. The way to achieve this is by
> >> enabling the mapped-ram feature, which already aligns its I/O properly
> >> (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).
> >> 
> >> By setting O_DIRECT on the multifd channels, all writes to the same
> >> file descriptor need to be aligned as well, even the ones that come
> >> from outside multifd, such as the QEMUFile I/O from the main migration
> >> code. This makes it impossible to use the same file descriptor for the
> >> QEMUFile and for the multifd channels. The various flags and metadata
> >> written by the main migration code will always be unaligned by virtue
> >> of their small size. To workaround this issue, we'll require a second
> >> file descriptor to be used exclusively for direct I/O.
> >> 
> >> The second file descriptor can be obtained by QEMU by re-opening the
> >> migration file (already possible), or by being provided by the user or
> >> management application (support to be added in future patches).
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/file.c      | 22 +++++++++++++++++++---
> >>  migration/migration.c | 23 +++++++++++++++++++++++
> >>  2 files changed, 42 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/migration/file.c b/migration/file.c
> >> index 8f30999400..b9265b14dd 100644
> >> --- a/migration/file.c
> >> +++ b/migration/file.c
> >> @@ -83,17 +83,33 @@ void file_cleanup_outgoing_migration(void)
> >>  
> >>  bool file_send_channel_create(gpointer opaque, Error **errp)
> >>  {
> >> -    QIOChannelFile *ioc;
> >> +    QIOChannelFile *ioc = NULL;
> >>      int flags = O_WRONLY;
> >> -    bool ret = true;
> >> +    bool ret = false;
> >> +
> >> +    if (migrate_direct_io()) {
> >> +#ifdef O_DIRECT
> >> +        /*
> >> +         * Enable O_DIRECT for the secondary channels. These are used
> >> +         * for sending ram pages and writes should be guaranteed to be
> >> +         * aligned to at least page size.
> >> +         */
> >> +        flags |= O_DIRECT;
> >> +#else
> >> +        error_setg(errp, "System does not support O_DIRECT");
> >> +        error_append_hint(errp,
> >> +                          "Try disabling direct-io migration capability\n");
> >> +        goto out;
> >> +#endif
> >
> > Hopefully if we can fail migrate-set-parameters correctly always, we will
> > never trigger this error.
> >
> > I know Linux used some trick like this to even avoid such ifdefs:
> >
> >   if (qemu_has_direct_io() && migrate_direct_io()) {
> >       // reference O_DIRECT
> >   }
> >
> > So as long as qemu_has_direct_io() can return a constant "false" when
> > O_DIRECT not defined, the compiler is smart enough to ignore the O_DIRECT
> > inside the block.
> >
> > Even if it won't work, we can still avoid that error (and rely on the
> > set-parameter failure):
> >
> > #ifdef O_DIRECT
> >        if (migrate_direct_io()) {
> >            // reference O_DIRECT
> >        }
> > #endif
> >
> > Then it should run the same, just to try making ifdefs as light as
> > possible..
> 
> Ok.
> 
> Just FYI, in v2 I'm adding direct-io to migration incoming side as well,
> so I put this logic into a helper:
> 
> static bool file_enable_direct_io(int *flags, Error **errp)
> {
>     if (migrate_direct_io()) {
> #ifdef O_DIRECT
>         *flags |= O_DIRECT;
> #else
>         error_setg(errp, "System does not support O_DIRECT");
>         error_append_hint(errp,
>                           "Try disabling direct-io migration capability\n");
>         return false;
> #endif
>     }
> 
>     return true;
> }
> 
> But I'll apply your suggestions nonetheless.

Thanks, please give it a shot, I hope it will work with either way.

One thing to mention is, if you want to play with the qemu_has_direct_io()
approach with no "#ifdefs", you can't keep qemu_has_direct_io() in osdep.c,
but you must define it in osdep.h as static inline functions.  Otherwise I
think osdep.o is forced to include it as a function so that trick won't work.

Just try compile without O_DIRECT should see.

-- 
Peter Xu


