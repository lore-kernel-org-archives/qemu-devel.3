Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD74C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 06:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ms6-0007tE-PC; Fri, 03 May 2024 02:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2ms5-0007sw-Et
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2ms3-0005cE-Ho
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714719494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDZPYmK50eCIDTIHf93sFTCdqZZ3eNlFHBHQtlOZx60=;
 b=h+K54LJlPSMJJzbvNHxbfjkNR+7xGcT8I4jXpWyDSAjKJIXdCKadGjYXv+Xqv49q25n1pp
 cI7ZO6Q91oNRopvuwh7KK594NB+3fvzeDKRta947+pMYsz756U92n9EMmZ8nQ8hLuVW1P6
 ReAtYS7owZ31pIkmPnYwZM0ElhuRBpc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-xlO1pe2AMja9HAls93UoXA-1; Fri,
 03 May 2024 02:58:11 -0400
X-MC-Unique: xlO1pe2AMja9HAls93UoXA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B497D28EC100;
 Fri,  3 May 2024 06:58:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82AB6492BC6;
 Fri,  3 May 2024 06:58:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8241C21E6682; Fri,  3 May 2024 08:58:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] hmp/migration: Fix documents for "migrate" command
In-Reply-To: <20240502154729.370938-1-peterx@redhat.com> (Peter Xu's message
 of "Thu, 2 May 2024 11:47:29 -0400")
References: <20240502154729.370938-1-peterx@redhat.com>
Date: Fri, 03 May 2024 08:58:09 +0200
Message-ID: <87fruz1iwu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Peter Xu <peterx@redhat.com> writes:

> Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
> 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
> adding a Fixes to make life easier for the stable maintainer.

I'm curious: how does not adding Fixes: make life easier?

> When at it, slightly cleanup the lines, move "detach/-d" to a separate
> section rather than appending it at the end of the command description.
>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> Based-on: <20240430142737.29066-1-farosas@suse.de>
> ("[PATCH v3 0/6] migration removals & deprecations")
> ---
>  hmp-commands.hx | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index ebca2cdced..484a8a1c3a 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -918,8 +918,13 @@ ERST
       {
           .name       = "migrate",
           .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
           .params     = "[-d] [-b] [-i] [-r] uri",
           .help       = "migrate to URI (using -d to not wait for completion)"
                         "\n\t\t\t -b for migration without shared storage with"
                         " full copy of disk\n\t\t\t -i for migration without "
                         "shared storage with incremental copy of disk "
                         "(base image shared between src and destination)"
                         "\n\t\t\t -r to resume a paused migration",
           .cmd        = hmp_migrate,
       },
>  
>  
>  SRST
> -``migrate [-d]`` *uri*
> -  Migrate to *uri* (using -d to not wait for completion).
> +``migrate [-d] [-r]`` *uri*
> +  Migrate the current VM to *uri*.

Could there be any other VM than the current one?  Scratch "current"?

> +
> +  ``-d``
> +    Run this command asynchronously, so that the command doesn't wait for completion.

What is run asynchronously, and what isn't waiting?  These are two
different entities, aren't they?  Calling them "this command" and "the
command" is confusing :)

Perhaps

       Start the migration process, but do not wait for its completion.

Maybe add a hint on how to wait or poll for completion?

> +  ``-r``
> +    Resume a paused postcopy migration.

.help doesn't have "postcopy".  Should it?

>  ERST
>  
>      {


