Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F8FC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2aU-0000OH-Ti; Mon, 03 Feb 2025 14:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf2aU-0000No-0r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf2aS-0003Li-0G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738612706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWwZV9+SaxNUH4OG1nDFfpXbVHizdXu4l5NWoU9sXws=;
 b=MRLEDXv6jF/JAOXqCg8DZgZjpyXG77KX0S8ebpiXRjTGU3WDOCrcchsQToKOBJHbyITm5j
 cAC05Jw9S4BcReUgpdVZBAwW0ijp8KSIZW1vOsQfriKKJRCbEQ9jgHL+oS1m+lJccTruyy
 C1WLPeVXp/4rYTiQiTAfdFfTPHDFvr8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-WsJ1QqHxONayLcx91s3uWQ-1; Mon, 03 Feb 2025 14:58:25 -0500
X-MC-Unique: WsJ1QqHxONayLcx91s3uWQ-1
X-Mimecast-MFC-AGG-ID: WsJ1QqHxONayLcx91s3uWQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-468f80df8caso89251381cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 11:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738612705; x=1739217505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWwZV9+SaxNUH4OG1nDFfpXbVHizdXu4l5NWoU9sXws=;
 b=YtyAWaRwmPu6h7hImXjJFRoaNWp1o+jmssDYTvQiPQC+VXHqkTR+aBohH/NJ0VH92o
 cp3Fn9502ETMgoFcdYNFxQ7P5Fzghu0eVUkCnjuiVq7nz79zP8WxQQPJf7qO+5Qv4X1F
 3jCbu631DMY3mRssWuT36CwykieB89yO/WoGnvAb2gHR7/ruL98istWOZD2jdba1n0kA
 y5qhDRKDo6dqf1fcqpl/U8vIbXyYtrT9OKho/wNySZJwEbyy2C5glol3bjKpfi2gaqht
 XIu7SIjYpsVET4sIZ2eBeoYy0PUENRyhQ6VzAxPBUZzP/G9Wd1tiqrdsWBamzBl/haCs
 F6Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIWIUWHB0ZPWkftOeNUPPHDYX+Iziid6zRFUywDA5GAjLLdcnIJ/iSpwWIsP3fA1T2B+GnW/qzRGzb@nongnu.org
X-Gm-Message-State: AOJu0YwKFfFz8y6Uz9Dng8faO2t8d4VgmbTPK0NgBZSUWI3RvSROsTVW
 yKhAmgAKSuSHiLzIdAEbLJnOGGYXycW68j2aUO5L/ZetoJRnAtaBwGFfLYAXegD6H2OX6o6m6jv
 TpY1Im4IEmJ1Xc25qFaDCYZ8xlkT+uU/fPZE1vx3oJy4wO3u4ypJx
X-Gm-Gg: ASbGnctYbqRoCcnu1exks9YmLsEab62ZrGrNi0k5vHI86Yq/gRVExyA43kwstjJutZy
 QFzxlDiuac5XiBFC7kUDnUZqsT9Z6asN5ctG2oPx5w4Lzqzo0ugNgl8V4Y85/rFvVPFaA5zy4AW
 w0Jd7NSU2bFg9zP8y2PNiqBbRFhpgjbPPjSbTW1t/Lc9L5mCQjdGgpE7yywgl4NyUOD9iSxfmLF
 JuQNKjRijuu9mtxcER5iqgUO08b5GzWAW1VfxyVBZ7M/E+Pb9ADFR/nKabAuDKw5Hkgjai+jNw+
 oT50NkLznwLiQzwx9+MeR5hHFj0xg6UVAnaHV9fLUKb+/GcH
X-Received: by 2002:a05:622a:6110:b0:467:770f:70a0 with SMTP id
 d75a77b69052e-46fd0a10e78mr245277121cf.10.1738612704824; 
 Mon, 03 Feb 2025 11:58:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa6rHov0orHXoH4YGHeCJpP14m0iJN0x09jTLRaPoEGl47s23+E80BZmkX1EaR3x4cYuqR1Q==
X-Received: by 2002:a05:622a:6110:b0:467:770f:70a0 with SMTP id
 d75a77b69052e-46fd0a10e78mr245276831cf.10.1738612704456; 
 Mon, 03 Feb 2025 11:58:24 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a75d6sm51956361cf.1.2025.02.03.11.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 11:58:23 -0800 (PST)
Date: Mon, 3 Feb 2025 14:58:22 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs
 to take BQL for some calls
Message-ID: <Z6Ef3iwQs7JSFY3c@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
 <Z57TPqhRYY4V14BE@gallifrey>
 <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
 <Z59o4u9zui3CPrkm@gallifrey>
 <fafbc505-acee-408e-a2ef-0a62bd30689b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fafbc505-acee-408e-a2ef-0a62bd30689b@maciej.szmigiero.name>
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

On Mon, Feb 03, 2025 at 02:57:36PM +0100, Maciej S. Szmigiero wrote:
> On 2.02.2025 13:45, Dr. David Alan Gilbert wrote:
> > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > On 2.02.2025 03:06, Dr. David Alan Gilbert wrote:
> > > > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > 
> > > > > postcopy_ram_listen_thread() is a free running thread, so it needs to
> > > > > take BQL around function calls to migration methods requiring BQL.
> > > > > 
> > > > > qemu_loadvm_state_main() needs BQL held since it ultimately calls
> > > > > "load_state" SaveVMHandlers.
> > > > > 
> > > > > migration_incoming_state_destroy() needs BQL held since it ultimately calls
> > > > > "load_cleanup" SaveVMHandlers.
> > > > > 
> > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > ---
> > > > >    migration/savevm.c | 4 ++++
> > > > >    1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > > index b0b74140daea..0ceea9638cc1 100644
> > > > > --- a/migration/savevm.c
> > > > > +++ b/migration/savevm.c
> > > > > @@ -2013,7 +2013,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > > > >         * in qemu_file, and thus we must be blocking now.
> > > > >         */
> > > > >        qemu_file_set_blocking(f, true);
> > > > > +    bql_lock();
> > > > >        load_res = qemu_loadvm_state_main(f, mis);
> > > > > +    bql_unlock();
> > > > 
> > > > Doesn't that leave that held for a heck of a long time?
> > > 
> > > Yes, and it effectively broke "postcopy recover" test but I
> > > think the reason for that is qemu_loadvm_state_main() and
> > > its children don't drop BQL while waiting for I/O.
> > > 
> > > I've described this case in more detail in my reply to Fabiano here:
> > > https://lore.kernel.org/qemu-devel/0a09e627-955e-4f26-8d08-0192ecd250a8@maciej.szmigiero.name/
> > 
> > While it might be the cause in this case, my feeling is it's more fundamental
> > here - it's the whole reason that postcopy has a separate ram listen
> > thread.  As the destination is running, after it loads it's devices
> > and as it starts up the destination will be still loading RAM
> > (and other postcopiable devices) potentially for quite a while.
> > Holding the bql around the ram listen thread means that the
> > execution of the destination won't be able to take that lock
> > until the postcopy load has finished; so while that might apparently
> > complete, it'll lead to the destination stalling until that's finished
> > which defeats the whole point of postcopy.
> > That last one probably won't fail a test but it will lead to a long stall
> > if you give it a nice big guest with lots of RAM that it's rapidly
> > changing.
> 
> Okay, I understand the postcopy case/flow now.
> Thanks for explaining it clearly.
> 
> > > I still think that "load_state" SaveVMHandlers need to be called
> > > with BQL held since implementations apparently expect it that way:
> > > for example, I think PCI device configuration restore calls
> > > address space manipulation methods which abort() if called
> > > without BQL held.
> > 
> > However, the only devices that *should* be arriving on the channel
> > that the postcopy_ram_listen_thread is reading from are those
> > that are postcopiable (i.e. RAM and hmm block's dirty_bitmap).
> > Those load handlers are safe to be run while the other devices
> > are being changed.   Note the *should* - you could add a check
> > to fail if any other device arrives on that channel.
> 
> I think ultimately there should be either an explicit check, or,
> as you suggest in the paragraph below, a separate SaveVMHandler
> that runs without BQL held.

To me those are bugs happening during postcopy, so those abort()s in
memory.c are indeed for catching these issues too.

> Since the current state of just running these SaveVMHandlers
> without BQL in this case and hoping that nothing breaks is
> clearly sub-optimal.
> 
> > > I have previously even submitted a patch to explicitly document
> > > "load_state" SaveVMHandler as requiring BQL (which was also
> > > included in the previous version of this patch set) and it
> > > received a "Reviewed-by:" tag:
> > > https://lore.kernel.org/qemu-devel/6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com/
> > > https://lore.kernel.org/qemu-devel/e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com/
> > > https://lore.kernel.org/qemu-devel/87o732bti7.fsf@suse.de/
> > 
> > It happens!
> > You could make this safer by having a load_state and a load_state_postcopy
> > member, and only mark the load_state as requiring the lock.
> 
> To not digress too much from the subject of this patch set
> (multifd VFIO device state transfer) for now I've just updated the
> TODO comment around that qemu_loadvm_state_main(), so hopefully this
> discussion won't get forgotten:
> https://gitlab.com/maciejsszmigiero/qemu/-/commit/046e3deac5b1dbc406b3e9571f62468bd6743e79

The commit message may still need some touch ups, e.g.:

  postcopy_ram_listen_thread() is a free running thread, so it needs to
  take BQL around function calls to migration methods requiring BQL.

This sentence is still not correct, IMHO. As Dave explained, the ram load
thread is designed to run without BQL at least for the major workloads it
runs.

I don't worry on src sending something that crashes the dest: if that
happens, that's a bug, we need to fix it..  In that case abort() either in
memory.c or migration/ would be the same.  We could add some explicit check
in migration code, but I don't expect it to catch anything real, at least
such never happened since postcopy introduced.. so it's roughly 10 years
without anything like that happens.

Taking BQL for migration_incoming_state_destroy() looks all safe.  There's
one qemu_ram_block_writeback() which made me a bit nervous initially, but
then looks like RAM backends should be almost noop (for shmem and
hugetlbfs) but except pmem.

The other alternative is we define load_cleanup() to not rely on BQL (which
I believe is true before this series?), then take it only when VFIO's path
needs it.

Thanks,

-- 
Peter Xu


