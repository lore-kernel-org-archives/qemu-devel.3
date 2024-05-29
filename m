Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791D1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 19:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOkl-0008N9-Q3; Wed, 29 May 2024 15:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOkk-0008Mm-37
 for qemu-devel@nongnu.org; Wed, 29 May 2024 15:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOki-0000Vv-7n
 for qemu-devel@nongnu.org; Wed, 29 May 2024 15:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717010063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lONYpmb/pW6VfQOXvexobjf8LEFV46dwQj9dmvcFqgQ=;
 b=LUQJhvaDZw9+SOyZws/+pZQAFTDLUDSVbCAG8OaB7JEcJK5cPm8iHiCcsoj2Gvry1WXJED
 p1r8lTPPgGUa2A51TJUq2uwIskK7Kc/kdD4nUMGA7wK5kDa9DY5Vlb6KT89s//A9UbGGME
 SQdy9qFGQd6cNWbv+s5Uo6DHRE5T5Sk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-WqpLE-DsPoa_Ijx8dDmSeQ-1; Wed, 29 May 2024 15:14:21 -0400
X-MC-Unique: WqpLE-DsPoa_Ijx8dDmSeQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6f908f002c2so9759a34.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717010061; x=1717614861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lONYpmb/pW6VfQOXvexobjf8LEFV46dwQj9dmvcFqgQ=;
 b=AT+aorzgN1ojj8dr6CuU3NN88tGtQ7OTCyaDYBs7bqF4MlyoKmehK76VX/lVrvi81g
 ACJkAsQQ9sLisdtfNWdNDkTsNVbDaIQkg0icXekb/NhmNVSyqqtZHjP71KzL8UUG5H6H
 LZ307SHlnfT88jdcGGaqgMi11/IBGVnXdymEt7ax99Z41G5RRJM9smBp448hrt3Il83I
 qM1QTExrkGXzWwIU2GhITqaImubsLxI9CQBdlpzbWlapWvR6L902B+GxnheLwspOUoKz
 G2AyaV1db2MTd3OL5BooJc5RQfTRXOwFJ5ZSbCtpOFYo9MLAlCYy4mYXWjY7zYO3IH4h
 gpFg==
X-Gm-Message-State: AOJu0Yzh6boVfF0OfbHEDytXyCHUBOVqwul5lQNSM3RNJzjp96uDA3ag
 dgs4UMOb2ZXU2ccp0rKEamTQaBxEg82njFXdCiQLS45TMCx25cocNfuqpfHq5tgdvsZFGK2TnrQ
 AjgJ2un6I1nEiI6E6AsJbGLxOFKZII6+ux6anFCPcs+TsdwtcLBoU
X-Received: by 2002:a05:6830:2c0c:b0:6f1:2171:4f9a with SMTP id
 46e09a7af769-6f90ad6149amr127820a34.0.1717010060515; 
 Wed, 29 May 2024 12:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEZ1eqPqBg9mPgP3BiiSysC1ihypl+17OJ2x6DBKG2KrX0RzMUi3r5X935Hm0ZZGH0fGYrrw==
X-Received: by 2002:a05:6830:2c0c:b0:6f1:2171:4f9a with SMTP id
 46e09a7af769-6f90ad6149amr127781a34.0.1717010059876; 
 Wed, 29 May 2024 12:14:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fe27a2956sm10372971cf.87.2024.05.29.12.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 12:14:19 -0700 (PDT)
Date: Wed, 29 May 2024 15:14:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
Message-ID: <Zld-iWfa3_yEWgn6@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n>
 <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 49f1cb2..ca04a0e 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
> > >                                         uint64_t size,
> > >                                         Error **errp)
> > >   {
> > > +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> > 
> > If there's a machine option to "use memfd for allocations", then it's
> > shared mem... Hmm..
> > 
> > It is a bit confusing to me in quite a few levels:
> > 
> >    - Why memory allocation method will be defined by a machine property,
> >      even if we have memory-backend-* which should cover everything?
> 
> Some memory regions are implicitly created, and have no explicit representation
> on the qemu command line.  memfd-alloc affects those.
> 
> More generally, memfd-alloc affects all ramblock allocations that are
> not explicitly represented by memory-backend object.  Thus the simple
> command line "qemu -m 1G" does not explicitly describe an object, so it
> goes through the anonymous allocation path, and is affected by memfd-alloc.

Can we simply now allow "qemu -m 1G" to work for cpr-exec?  AFAIU that's
what we do with cpr-reboot: we ask the user to specify the right things to
make other thing work.  Otherwise it won't.

> 
> Internally, create_default_memdev does create a memory-backend object.
> That is what my doc comment above refers to:
>   Any associated memory-backend objects are created with share=on
> 
> An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
> 
> The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
> 
> +#     Memory backend objects must have the share=on attribute, and
> +#     must be mmap'able in the new QEMU process.  For example,
> +#     memory-backend-file is acceptable, but memory-backend-ram is
> +#     not.
> +#
> +#     The VM must be started with the '-machine memfd-alloc=on'
> +#     option.  This causes implicit ram blocks -- those not explicitly
> +#     described by a memory-backend object -- to be allocated by
> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> +#     RAM when it is specified without a memory-backend object.

VGA is IIRC 16MB chunk, ROM is even smaller.  If the user specifies -object
memory-backend-file,share=on propertly, these should be the only outliers?

Are these important enough for the downtime?  Can we put them into the
migrated image alongside with the rest device states?

> 
> >    - Even if we have such a machine property, why setting "memfd" will
> >      always imply shared?  why not private?  After all it's not called
> >      "memfd-shared-alloc", and we can create private mappings using
> >      e.g. memory-backend-memfd,share=off.
> 
> There is no use case for memfd-alloc with share=off, so no point IMO in
> making the option more verbose.

Unfortunately this fact doesn't make the property easier to understand. :-(

> For cpr, the mapping with all its modifications must be visible to new
> qemu when qemu mmaps it.

So this might be the important part - do you mean migrating
VGA/ROM/... small ramblocks won't work (besides any performance concerns)?
Could you elaborate?

Cpr-reboot already introduced lots of tricky knobs to QEMU.  We may need to
restrict that specialty to minimal, making the interfacing as clear as
possible, or (at least migration) maintainers will start to be soon scared
and running away, if such proposal was not shot down.

In short, I hope when we introduce new knobs for cpr, we shouldn't always
keep cpr-* modes in mind, but consider whenever the user can use it without
cpr-*.  I'm not sure whether it'll be always possible, but we should try.

Thanks,

-- 
Peter Xu


