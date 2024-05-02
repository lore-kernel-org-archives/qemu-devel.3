Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A188FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Xl8-00006a-36; Thu, 02 May 2024 10:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Xl6-00006L-92
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Xl4-00066m-C4
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714661400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjRm6klNwPKBYwB+V77gPikBfwCKa5r8pYp/X8npRQA=;
 b=iL+dHaM8E6afPhAwo+/VjzFwyzBjzqDVxPlr9/mT8k9EHk6BpAFQXelcKUpSsFUbckUjXc
 dK8RyD6rnPcq+f/z+13eKGyleSAl4pvNQWdE9fZ5Qy+ok9U761Z4z/tO+uQu6PWpJ4K/ba
 1nQOefNR1dLoWdTwWKQM5TABSjkuECA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-XtJXL8k1N_efZerJa0RGSQ-1; Thu, 02 May 2024 10:49:59 -0400
X-MC-Unique: XtJXL8k1N_efZerJa0RGSQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c94df9c3f6so282175b6e.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 07:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714661398; x=1715266198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjRm6klNwPKBYwB+V77gPikBfwCKa5r8pYp/X8npRQA=;
 b=Dbp0ILEFrpWXoUv/FulviVtKA1hmTPmMeqihfcc44Iu41Z9cuCi9uWl91SJbgOR484
 ryDPO+EhaXvpxB3GBulPY2ZLvaaP/gRyfbaRQeH4gYxR0WqmGCuw+p/nExGzFEgl/v03
 iBfcbfNkZFYno8F+hU4LpOvwnExePUyD0eIi+LXQrklTlRAusajJBlR9zNn0ySs23o+T
 m8/eZxEjXDn9sfW94vZPZk1nvPY9QZTPlBvdiIaseg6CteWep+etxIQ5bUECEIbhZoCE
 aW+tSgxkcfJDFhC8HAZjwD4+1E2fPhuuSRMUygy0o7XiNbbHNI0nQXzflKrl28X3PM1v
 0v1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRD/ZL/eB7JolbkaE+taGxRrJNLRquFt6TdsdfC35OavhG4RBU9PZ/Rd6X1j/At1uBerU/7MgCTUfaL8ZnSgzQdXBam1E=
X-Gm-Message-State: AOJu0YxM6e3+3p1NyFN3uiYmNBgBUfzYmkcb59NGDbmfn6+VFJDlcq1B
 B3FxATq5Ga+8c88OjtHFvuktaxQmSehsMJiMxfY1JCas69vigDUaZmDiGLYA7fL3Y0Izq0btnox
 NgFE71Kk86p4qNyj8inqyY209hc7iL3k3CweG0jjMIYw7vS15G6BL
X-Received: by 2002:a05:6830:33ea:b0:6ee:eac3:ba24 with SMTP id
 i10-20020a05683033ea00b006eeeac3ba24mr37972otu.3.1714661397871; 
 Thu, 02 May 2024 07:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvflCPF4mDdOV1VICgvANpuWoSLwbXUGueXWN0/QBY0Xod4t6gEq/xvqRZZBXefcubwCGVIQ==
X-Received: by 2002:a05:6830:33ea:b0:6ee:eac3:ba24 with SMTP id
 i10-20020a05683033ea00b006eeeac3ba24mr37908otu.3.1714661397031; 
 Thu, 02 May 2024 07:49:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cr13-20020a056830670d00b006ee576e9732sm210715otb.79.2024.05.02.07.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:49:56 -0700 (PDT)
Date: Thu, 2 May 2024 10:49:54 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 3/6] migration: Remove 'blk/-b' option from migrate
 commands
Message-ID: <ZjOoEtCHvuPHZnUs@x1n>
References: <20240430142737.29066-1-farosas@suse.de>
 <20240430142737.29066-4-farosas@suse.de>
 <87y18s77ma.fsf@pond.sub.org> <ZjOWiu6kfxXcxhNB@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjOWiu6kfxXcxhNB@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, May 02, 2024 at 01:35:06PM +0000, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
> > Fabiano Rosas <farosas@suse.de> writes:
> > 
> > > The block migration is considered obsolete and has been deprecated in
> > > 8.2. Remove the migrate command option that enables it. This only
> > > affects the QMP and HMP commands, the feature can still be accessed by
> > > setting the migration 'block' capability. The whole feature will be
> > > removed in a future patch.
> > >
> > > Deprecation commit 8846b5bfca ("migration: migrate 'blk' command
> > > option is deprecated.").
> > >
> > > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > 
> > [...]
> > 
> > > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > > index 7978302949..ebca2cdced 100644
> > > --- a/hmp-commands.hx
> > > +++ b/hmp-commands.hx
> > > @@ -909,21 +909,17 @@ ERST
> > >  
> > >      {
> > >          .name       = "migrate",
> > > -        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
> > > -        .params     = "[-d] [-b] [-r] uri",
> > > +        .args_type  = "detach:-d,resume:-r,uri:s",
> > > +        .params     = "[-d] [-r] uri",
> > >          .help       = "migrate to URI (using -d to not wait for completion)"
> > > -		      "\n\t\t\t -b for migration without shared storage with"
> > > -		      " full copy of disk\n\t\t\t -r to resume a paused migration",
> > > +		      "\n\t\t\t -r to resume a paused migration",
> > >          .cmd        = hmp_migrate,
> > >      },
> > >  
> > >  
> > >  SRST
> > > -``migrate [-d] [-b]`` *uri*
> > > +``migrate [-d]`` *uri*
> > >    Migrate to *uri* (using -d to not wait for completion).
> > > -
> > > -  ``-b``
> > > -    for migration with full copy of disk
> > >  ERST
> > 
> > Not this patch's fault, but here goes anyway: -r is undocumented here.
> 
> Probably one for Peter I guess.

Yes, and I'll send a patch! :-D

-- 
Peter Xu


