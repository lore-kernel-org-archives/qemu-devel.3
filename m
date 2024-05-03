Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30058C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tND-0004cI-GK; Fri, 03 May 2024 09:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2tNB-0004c2-8r
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2tN9-0000sz-GR
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714744486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJAhCBSy2ZAesPpgrJf9tXNZY8WJCBSLiKmCyitgmsw=;
 b=AB4B4TrrP4lr7EFwA7FLTM3s6mzHe5xfEMKonJRUyHBVsaD9a7pFvFzrmBmsUkr2Q/erL8
 y9DzZc5HF5NaibGrp5gZkc5jFMDEdLrnZdpPg+6tTxtqMR0cbhn3rnO8qc2vbeNHrckQ+R
 CSI2oVQyx3y6udGMayVe6XYafeJ8gnE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-gN8c5YvUPRq0bbyA6ZUUuA-1; Fri, 03 May 2024 09:54:44 -0400
X-MC-Unique: gN8c5YvUPRq0bbyA6ZUUuA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4379bbdc9b4so33097521cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714744484; x=1715349284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJAhCBSy2ZAesPpgrJf9tXNZY8WJCBSLiKmCyitgmsw=;
 b=adJMYNVnkZ4z3PQzSdu2F10JhVG+MhS3Q7FXkTyzR4fmjctd+qG9++JEU0eYItuIJ5
 Nq2IvuGVamM29QehTeLeyS3MT6GX6xfZIsWyn17kVaVoMEVUzqlhrc0rU0Xn+SkDUpl0
 HMO9FgeJGRlCxvsHRx5yO3we5gEeT2RYuSYt4Oq8sjKvfjuaOVHYwlTU9iEmhTXuYhQD
 HfSQq9ftCG+StTUn7jJfJx380DfmbzqidrAH/xpnhx7k3kTvUSE0N1jqUq6zQwv1QgiL
 kYXlGhTrEmCySmIAG6wptnBifluAeOUpYP/sSt598GEYAKbqAw6dtbzGDyYcjbpYOmlg
 Ekeg==
X-Gm-Message-State: AOJu0YxG2rS/Xlw1bD7f1QBmURQIxYxrccPLSjELgStwibNmKINg04Ej
 ixrRvRcw61xgK6fUG+yrUuH1SKQsd9SHVBXL4XRCNhbSQL1RWQsuQUhWpIFkvglf7KeiiWtvzbn
 PB0fgcCjjEzjQrBJuwj+DSRIrQ5NU6oVhlht+/ICBxwZ2BRq1KDCA
X-Received: by 2002:a05:620a:40d2:b0:790:b658:b926 with SMTP id
 g18-20020a05620a40d200b00790b658b926mr2983060qko.3.1714744483899; 
 Fri, 03 May 2024 06:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyCrR3H3jZHa3j+fAVyR3cUweu+FLcFDZbip4uMwsV2t1E1cQ5mSlwojuQ1q/gFPRINnG+YA==
X-Received: by 2002:a05:620a:40d2:b0:790:b658:b926 with SMTP id
 g18-20020a05620a40d200b00790b658b926mr2983021qko.3.1714744483305; 
 Fri, 03 May 2024 06:54:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05620a280900b00790eb55fd58sm1235278qkp.129.2024.05.03.06.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 06:54:43 -0700 (PDT)
Date: Fri, 3 May 2024 09:54:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] hmp/migration: Fix documents for "migrate" command
Message-ID: <ZjTsouwxaJ8S5Icf@x1n>
References: <20240502154729.370938-1-peterx@redhat.com>
 <87fruz1iwu.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fruz1iwu.fsf@pond.sub.org>
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

On Fri, May 03, 2024 at 08:58:09AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
> > 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
> > adding a Fixes to make life easier for the stable maintainer.
> 
> I'm curious: how does not adding Fixes: make life easier?

Because if I attach Fixes then IIUC Michael will read it through and judge
whether it should apply to stable, where I want to skip that for him
because I think this doesn't apply to stable.  Reasons:

  - This is a document update, IIUC we normally only keep the latest
    document uptodate, not all the stable versions (especiailly for HMP,
    which isn't a stable ABI)?  I assume it applies the same when a qtest
    case got a slight fixup.

  - This patch is even more special as it will need explicit backport due
    to the removal of block migration, and I really don't think any of us
    should spend time on that..

> 
> > When at it, slightly cleanup the lines, move "detach/-d" to a separate
> > section rather than appending it at the end of the command description.
> >
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >
> > Based-on: <20240430142737.29066-1-farosas@suse.de>
> > ("[PATCH v3 0/6] migration removals & deprecations")
> > ---
> >  hmp-commands.hx | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index ebca2cdced..484a8a1c3a 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -918,8 +918,13 @@ ERST
>        {
>            .name       = "migrate",
>            .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
>            .params     = "[-d] [-b] [-i] [-r] uri",
>            .help       = "migrate to URI (using -d to not wait for completion)"
>                          "\n\t\t\t -b for migration without shared storage with"
>                          " full copy of disk\n\t\t\t -i for migration without "
>                          "shared storage with incremental copy of disk "
>                          "(base image shared between src and destination)"
>                          "\n\t\t\t -r to resume a paused migration",
>            .cmd        = hmp_migrate,
>        },
> >  
> >  
> >  SRST
> > -``migrate [-d]`` *uri*
> > -  Migrate to *uri* (using -d to not wait for completion).
> > +``migrate [-d] [-r]`` *uri*
> > +  Migrate the current VM to *uri*.
> 
> Could there be any other VM than the current one?  Scratch "current"?

I didn't have "current" until I generated the doc and read, then I see
right below "migrate_cancel" has it:

SRST
``migrate_cancel``
  Cancel the current VM migration.
ERST

But maybe it means "current migration", not "current VM".. So yeah I can
drop it.

> 
> > +
> > +  ``-d``
> > +    Run this command asynchronously, so that the command doesn't wait for completion.
> 
> What is run asynchronously, and what isn't waiting?  These are two
> different entities, aren't they?  Calling them "this command" and "the
> command" is confusing :)
> 
> Perhaps
> 
>        Start the migration process, but do not wait for its completion.
> 
> Maybe add a hint on how to wait or poll for completion?

Yes this reads better; I will add the hint too.

> 
> > +  ``-r``
> > +    Resume a paused postcopy migration.
> 
> .help doesn't have "postcopy".  Should it?

It should.

This is the fixup I'll squash when sending v2, let me know if there's other
early comments, thanks.

===8<===
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 484a8a1c3a..06746f0afc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -912,17 +912,18 @@ ERST
         .args_type  = "detach:-d,resume:-r,uri:s",
         .params     = "[-d] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-                     "\n\t\t\t -r to resume a paused migration",
+                     "\n\t\t\t -r to resume a paused postcopy migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
 ``migrate [-d] [-r]`` *uri*
-  Migrate the current VM to *uri*.
+  Migrate the VM to *uri*.
 
   ``-d``
-    Run this command asynchronously, so that the command doesn't wait for completion.
+    Start the migration process, but do not wait for its completion.  To
+    query an ongoing migration process, use "info migrate".
   ``-r``
     Resume a paused postcopy migration.
 ERST

-- 
Peter Xu


