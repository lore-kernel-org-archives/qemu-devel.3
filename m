Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E56C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tau-0001BQ-Du; Fri, 03 May 2024 10:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2tas-0001B8-G8
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2taq-0003ik-9h
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714745331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBxsi6I5ypGBAgRAq/NHPwOAg6qHnv+PCMWN4qMPlVE=;
 b=fB9F199lTrl8nLqm8ozu6YU+1KPgd76u3r+vfgU+ZkeLLvLwNjUv1ApwKZDdTvKKX9t4pv
 gFadl4sskCT32Nr0OqIfpoyeozjUNxPSTez2K0LCi82jPBmOiIBKT8Nwz87GQRdv/i3l1i
 KewGZctiEtrU3XCZOB4vxWgbH3vCkHA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-lXb4h0pjPvm2iwNctYLnlw-1; Fri,
 03 May 2024 10:08:47 -0400
X-MC-Unique: lXb4h0pjPvm2iwNctYLnlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1DB7380009D;
 Fri,  3 May 2024 14:08:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94920EC680;
 Fri,  3 May 2024 14:08:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 85E8F21E6811; Fri,  3 May 2024 16:08:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] hmp/migration: Fix documents for "migrate" command
In-Reply-To: <ZjTsouwxaJ8S5Icf@x1n> (Peter Xu's message of "Fri, 3 May 2024
 09:54:42 -0400")
References: <20240502154729.370938-1-peterx@redhat.com>
 <87fruz1iwu.fsf@pond.sub.org> <ZjTsouwxaJ8S5Icf@x1n>
Date: Fri, 03 May 2024 16:08:45 +0200
Message-ID: <87h6ffvvgy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

If there's still time, suggest to tweak the subject to

    hmp/migration: Fix "migrate" command's documentation

Peter Xu <peterx@redhat.com> writes:

> On Fri, May 03, 2024 at 08:58:09AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
>> > 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
>> > adding a Fixes to make life easier for the stable maintainer.
>> 
>> I'm curious: how does not adding Fixes: make life easier?
>
> Because if I attach Fixes then IIUC Michael will read it through and judge
> whether it should apply to stable, where I want to skip that for him
> because I think this doesn't apply to stable.  Reasons:
>
>   - This is a document update, IIUC we normally only keep the latest
>     document uptodate, not all the stable versions (especiailly for HMP,
>     which isn't a stable ABI)?  I assume it applies the same when a qtest
>     case got a slight fixup.
>
>   - This patch is even more special as it will need explicit backport due
>     to the removal of block migration, and I really don't think any of us
>     should spend time on that..

Right.  But Fixes: is also for downstreams, who may want to make their
own decisions.

I think I'd always add Fixes:.  When I think there's a need to steer
stable away from it, I'd say so in the commit message.  I doubt needed
here, as the subject states it's just a doc fix for HMP.

>> > When at it, slightly cleanup the lines, move "detach/-d" to a separate
>> > section rather than appending it at the end of the command description.
>> >
>> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
>> > Cc: Fabiano Rosas <farosas@suse.de>
>> > Cc: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >
>> > Based-on: <20240430142737.29066-1-farosas@suse.de>
>> > ("[PATCH v3 0/6] migration removals & deprecations")
>> > ---
>> >  hmp-commands.hx | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/hmp-commands.hx b/hmp-commands.hx
>> > index ebca2cdced..484a8a1c3a 100644
>> > --- a/hmp-commands.hx
>> > +++ b/hmp-commands.hx
>> > @@ -918,8 +918,13 @@ ERST
>>        {
>>            .name       = "migrate",
>>            .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
>>            .params     = "[-d] [-b] [-i] [-r] uri",
>>            .help       = "migrate to URI (using -d to not wait for completion)"
>>                          "\n\t\t\t -b for migration without shared storage with"
>>                          " full copy of disk\n\t\t\t -i for migration without "
>>                          "shared storage with incremental copy of disk "
>>                          "(base image shared between src and destination)"
>>                          "\n\t\t\t -r to resume a paused migration",
>>            .cmd        = hmp_migrate,
>>        },
>> >  
>> >  
>> >  SRST
>> > -``migrate [-d]`` *uri*
>> > -  Migrate to *uri* (using -d to not wait for completion).
>> > +``migrate [-d] [-r]`` *uri*
>> > +  Migrate the current VM to *uri*.
>> 
>> Could there be any other VM than the current one?  Scratch "current"?
>
> I didn't have "current" until I generated the doc and read, then I see
> right below "migrate_cancel" has it:
>
> SRST
> ``migrate_cancel``
>   Cancel the current VM migration.
> ERST
>
> But maybe it means "current migration", not "current VM".. So yeah I can
> drop it.
>
>> 
>> > +
>> > +  ``-d``
>> > +    Run this command asynchronously, so that the command doesn't wait for completion.
>> 
>> What is run asynchronously, and what isn't waiting?  These are two
>> different entities, aren't they?  Calling them "this command" and "the
>> command" is confusing :)
>> 
>> Perhaps
>> 
>>        Start the migration process, but do not wait for its completion.
>> 
>> Maybe add a hint on how to wait or poll for completion?
>
> Yes this reads better; I will add the hint too.
>
>> 
>> > +  ``-r``
>> > +    Resume a paused postcopy migration.
>> 
>> .help doesn't have "postcopy".  Should it?
>
> It should.
>
> This is the fixup I'll squash when sending v2, let me know if there's other
> early comments, thanks.
>
> ===8<===
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 484a8a1c3a..06746f0afc 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -912,17 +912,18 @@ ERST
>          .args_type  = "detach:-d,resume:-r,uri:s",
>          .params     = "[-d] [-r] uri",
>          .help       = "migrate to URI (using -d to not wait for completion)"
> -                     "\n\t\t\t -r to resume a paused migration",
> +                     "\n\t\t\t -r to resume a paused postcopy migration",
>          .cmd        = hmp_migrate,
>      },
>  
>  
>  SRST
>  ``migrate [-d] [-r]`` *uri*
> -  Migrate the current VM to *uri*.
> +  Migrate the VM to *uri*.
>  
>    ``-d``
> -    Run this command asynchronously, so that the command doesn't wait for completion.
> +    Start the migration process, but do not wait for its completion.  To
> +    query an ongoing migration process, use "info migrate".
>    ``-r``
>      Resume a paused postcopy migration.
>  ERST

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


