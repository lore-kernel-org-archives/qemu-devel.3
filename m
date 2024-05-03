Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BB0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2u1T-0004cJ-W3; Fri, 03 May 2024 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2u1I-0004Xg-3P
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2u1E-0008GN-VN
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714746972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8BKYZfVdxXFpD0Qg+FzlwbEeqYH1R+8dX0f5uM9zZ+c=;
 b=ciglVLZQGLNILUAmPTzBqLxviAOHiPsMF3kF+S2Xx2R7gtd2oKAjz/kAnHgWt+ynjInI4d
 mm14f3IVHGLKJ9mWUtPrKzGUTQFv9QCUU4dxwOrAqrAfB8ZTsrb2TEEw54HYfVubJk946a
 5Xp+lAeYcPLrLmJOdg9dTAEbV83K+ho=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ch0dwst3OnmGZK7hR9nZ9Q-1; Fri, 03 May 2024 10:36:10 -0400
X-MC-Unique: ch0dwst3OnmGZK7hR9nZ9Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79085537977so5783785a.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714746970; x=1715351770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BKYZfVdxXFpD0Qg+FzlwbEeqYH1R+8dX0f5uM9zZ+c=;
 b=ftW6nbajnFI2zq481n7Mi+hmxrfcJnMuM03ixYgjlwcEZM5+wLvxSNXqkn/dmtD7KT
 atnMHz2MIbiVQgA9493+hD0il86Yc/Y7STrnnVF+bMwnCb/gdt3vbndWMhC4EDpxlUtO
 Howqy3QEY6uOxEYFXA4KTPob1bs6Pv1A2Im64x178V+VI6QGOKHeYxEf9YispOe0VggS
 jf8D4/tGDKROtuQcZNkHDIZufUQXYGReT2Ctdi67486s4UUOa3rYq3ipc57aYQHIjL9g
 IQgdysjTWZ0drkPoaZfU2WAjbyk5YtoqG9Gdv4iMbHHPh3/UN6sCQfDVfjEyXSd6iA81
 s7Cw==
X-Gm-Message-State: AOJu0YyL18WoLc1wtIDKCjbVFfhhrTgrmUPJb7Q31f4uFNnMume0xShP
 5Rb6EgOG4ULdCHRYCMYm9ztplN63HOoufcKUV4Cr2Od6e2xC16UdHrvkqsxu7LbzW12aDbOQ02x
 JbtmDx+ATNeU7N0vtsMnuXmUz+uD+S7oVU/l3uO+iq9OyZdidRIqp
X-Received: by 2002:a05:620a:3184:b0:790:f0ed:8664 with SMTP id
 bi4-20020a05620a318400b00790f0ed8664mr3114014qkb.2.1714746969868; 
 Fri, 03 May 2024 07:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKIVjwK9Pl4OwgensOzGKbIrRRWMsHLW+cJSEmZ3TrVJ9++63jguSJHk9E/OkfjNn0zEwUgw==
X-Received: by 2002:a05:620a:3184:b0:790:f0ed:8664 with SMTP id
 bi4-20020a05620a318400b00790f0ed8664mr3113853qkb.2.1714746967361; 
 Fri, 03 May 2024 07:36:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 az18-20020a05620a171200b007906ab7b0b5sm1282644qkb.11.2024.05.03.07.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 07:36:07 -0700 (PDT)
Date: Fri, 3 May 2024 10:36:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] hmp/migration: Fix documents for "migrate" command
Message-ID: <ZjT2Vp5PoUUmHc8A@x1n>
References: <20240502154729.370938-1-peterx@redhat.com>
 <87fruz1iwu.fsf@pond.sub.org> <ZjTsouwxaJ8S5Icf@x1n>
 <87h6ffvvgy.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6ffvvgy.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, May 03, 2024 at 04:08:45PM +0200, Markus Armbruster wrote:
> If there's still time, suggest to tweak the subject to
> 
>     hmp/migration: Fix "migrate" command's documentation

Yes there is. :)

> 
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, May 03, 2024 at 08:58:09AM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
> >> > 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
> >> > adding a Fixes to make life easier for the stable maintainer.
> >> 
> >> I'm curious: how does not adding Fixes: make life easier?
> >
> > Because if I attach Fixes then IIUC Michael will read it through and judge
> > whether it should apply to stable, where I want to skip that for him
> > because I think this doesn't apply to stable.  Reasons:
> >
> >   - This is a document update, IIUC we normally only keep the latest
> >     document uptodate, not all the stable versions (especiailly for HMP,
> >     which isn't a stable ABI)?  I assume it applies the same when a qtest
> >     case got a slight fixup.
> >
> >   - This patch is even more special as it will need explicit backport due
> >     to the removal of block migration, and I really don't think any of us
> >     should spend time on that..
> 
> Right.  But Fixes: is also for downstreams, who may want to make their
> own decisions.
> 
> I think I'd always add Fixes:.  When I think there's a need to steer
> stable away from it, I'd say so in the commit message.  I doubt needed
> here, as the subject states it's just a doc fix for HMP.

OK, I'll attach a Fixes.

> 
> >> > When at it, slightly cleanup the lines, move "detach/-d" to a separate
> >> > section rather than appending it at the end of the command description.
> >> >
> >> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> >> > Cc: Fabiano Rosas <farosas@suse.de>
> >> > Cc: Markus Armbruster <armbru@redhat.com>
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >
> >> > Based-on: <20240430142737.29066-1-farosas@suse.de>
> >> > ("[PATCH v3 0/6] migration removals & deprecations")
> >> > ---
> >> >  hmp-commands.hx | 9 +++++++--
> >> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> >> > index ebca2cdced..484a8a1c3a 100644
> >> > --- a/hmp-commands.hx
> >> > +++ b/hmp-commands.hx
> >> > @@ -918,8 +918,13 @@ ERST
> >>        {
> >>            .name       = "migrate",
> >>            .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
> >>            .params     = "[-d] [-b] [-i] [-r] uri",
> >>            .help       = "migrate to URI (using -d to not wait for completion)"
> >>                          "\n\t\t\t -b for migration without shared storage with"
> >>                          " full copy of disk\n\t\t\t -i for migration without "
> >>                          "shared storage with incremental copy of disk "
> >>                          "(base image shared between src and destination)"
> >>                          "\n\t\t\t -r to resume a paused migration",
> >>            .cmd        = hmp_migrate,
> >>        },
> >> >  
> >> >  
> >> >  SRST
> >> > -``migrate [-d]`` *uri*
> >> > -  Migrate to *uri* (using -d to not wait for completion).
> >> > +``migrate [-d] [-r]`` *uri*
> >> > +  Migrate the current VM to *uri*.
> >> 
> >> Could there be any other VM than the current one?  Scratch "current"?
> >
> > I didn't have "current" until I generated the doc and read, then I see
> > right below "migrate_cancel" has it:
> >
> > SRST
> > ``migrate_cancel``
> >   Cancel the current VM migration.
> > ERST
> >
> > But maybe it means "current migration", not "current VM".. So yeah I can
> > drop it.
> >
> >> 
> >> > +
> >> > +  ``-d``
> >> > +    Run this command asynchronously, so that the command doesn't wait for completion.
> >> 
> >> What is run asynchronously, and what isn't waiting?  These are two
> >> different entities, aren't they?  Calling them "this command" and "the
> >> command" is confusing :)
> >> 
> >> Perhaps
> >> 
> >>        Start the migration process, but do not wait for its completion.
> >> 
> >> Maybe add a hint on how to wait or poll for completion?
> >
> > Yes this reads better; I will add the hint too.
> >
> >> 
> >> > +  ``-r``
> >> > +    Resume a paused postcopy migration.
> >> 
> >> .help doesn't have "postcopy".  Should it?
> >
> > It should.
> >
> > This is the fixup I'll squash when sending v2, let me know if there's other
> > early comments, thanks.
> >
> > ===8<===
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 484a8a1c3a..06746f0afc 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -912,17 +912,18 @@ ERST
> >          .args_type  = "detach:-d,resume:-r,uri:s",
> >          .params     = "[-d] [-r] uri",
> >          .help       = "migrate to URI (using -d to not wait for completion)"
> > -                     "\n\t\t\t -r to resume a paused migration",
> > +                     "\n\t\t\t -r to resume a paused postcopy migration",
> >          .cmd        = hmp_migrate,
> >      },
> >  
> >  
> >  SRST
> >  ``migrate [-d] [-r]`` *uri*
> > -  Migrate the current VM to *uri*.
> > +  Migrate the VM to *uri*.
> >  
> >    ``-d``
> > -    Run this command asynchronously, so that the command doesn't wait for completion.
> > +    Start the migration process, but do not wait for its completion.  To
> > +    query an ongoing migration process, use "info migrate".
> >    ``-r``
> >      Resume a paused postcopy migration.
> >  ERST
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thank you!

-- 
Peter Xu


