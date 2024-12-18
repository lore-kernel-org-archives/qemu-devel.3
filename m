Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0621BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0jJ-0000tk-Pf; Wed, 18 Dec 2024 15:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0jI-0000sh-BJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0jG-0005Po-PI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734553988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viKc+1aW/jYoqOHEHbbthcu/n6InX8xqnx7vkHHQz8s=;
 b=OMSSuJK8KR/RJxURoBPfZP4IPvopcPdZt7Xp6yJtJejJq7kXoz0eMHsi8VfioQZ9YIl4pg
 iVgijyV532NP71diEE+/tb/MjNVKX3w2NqqeFe+4k0WJxNxqC20j8+8SR+ImM+PtkVlOI/
 cBgsXHJ+h4/nGgQlorGKJC/6YmsAV3o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-q457qehMNmiRHb8z0U8HJw-1; Wed, 18 Dec 2024 15:33:07 -0500
X-MC-Unique: q457qehMNmiRHb8z0U8HJw-1
X-Mimecast-MFC-AGG-ID: q457qehMNmiRHb8z0U8HJw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d92f0737beso1181176d6.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 12:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734553986; x=1735158786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viKc+1aW/jYoqOHEHbbthcu/n6InX8xqnx7vkHHQz8s=;
 b=Odn9RB0d0/a9h3nygRt7CJ1Hz1tbjEtKrVtH/7+kp7SA52K/LmCUpzPZJdaHtWGsNJ
 T26IpzEFM4/YJBzH0aRu3VF3T46M6vJLfMW0O5aVWCSFY0H9Xi+dg+ub82pQszVUUy4V
 XYSxXWQOU9vpTUGIkIJUjcGHoQw8wQIzVVW4O3+aV1+2x/Pb8afd59jaO42pDkPBhEkX
 Dj6r2HjIJHk/ICjesXgqmFTgr+G1gU0JshWGEN0tpl79YHd/ENCp+SUivQxCmBMlRBiw
 IjZGvCUtuUnEq70Ss/ZKeO9eNto6jPzZBJBn/XjZ/A3h42TFuZWHcSOBU0H5FhzrKxw/
 WFCw==
X-Gm-Message-State: AOJu0YzB+0wAXt+cpLl+bcEk6Hbha+DkrNMwb/UL3CHYHmpK8qtLTyhP
 HUdnb/MDyl9eHFyLuqXcqiSJUYSpRBpFKGblb7h8ikMyfNZAdwDQNh/6EOE4u6x7ywIWAbuUaK0
 d/E1+rz8V6/ZAHJQG3cHVqP/C/lEHspaHAlqlB9huWpGO+jHdUQVm
X-Gm-Gg: ASbGnctf1fksx7jTD3l92QEOTEw7ixJLkV1TbhEugVYwkjTDyPnjR20B3C59dxReY3g
 TLyjF2hoZijxDtiMc9wnkm+yX2DHa7HggaXOoMC7eUmrIXOxmMdKyurMrPz5ZWnLdIzA8kpraYS
 0YCwTz5TEzxJ8+rY4AoABw4KxxoYkntn/NkHmxMpE0dEp0vK1aDiMXG0xuZvDYbfiWOV9kxYEdD
 6QVaIT1PRhWTkvTJtAfxmOZ3kHaiYCeBYnF4xXLotOQIcxQzeKtnN7dm9j8cAGnxs10xu7FTK4/
 WW0LHr0lEYQo7/vOiQ==
X-Received: by 2002:ad4:596a:0:b0:6d8:a1fe:7298 with SMTP id
 6a1803df08f44-6dd0926132emr63960216d6.41.1734553986620; 
 Wed, 18 Dec 2024 12:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAH5g0EnYs9Bf/6IXO6urQpIqwYDQukTVHZn1wwCpkrZsVwgFRTvFNOwgTv8GjSkWbAadKpA==
X-Received: by 2002:ad4:596a:0:b0:6d8:a1fe:7298 with SMTP id
 6a1803df08f44-6dd0926132emr63959896d6.41.1734553986246; 
 Wed, 18 Dec 2024 12:33:06 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd3630a9sm53967886d6.90.2024.12.18.12.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 12:33:05 -0800 (PST)
Date: Wed, 18 Dec 2024 15:33:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
Message-ID: <Z2MxfoH4cJ6BhH6X@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n>
 <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
 <Z1toIxDzI56ODYcC@x1n> <Z1xREcVCi-hn4BlW@x1n>
 <58935fbe-bb53-457d-b4d6-70c1d7b09e8c@oracle.com>
 <8406c79f-b7fb-4536-8d6a-126bb03a6c9f@oracle.com>
 <Z2L_mwAAEjbGRI0r@x1n>
 <3b2e7897-ff21-46ab-a900-551f78f7ca48@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b2e7897-ff21-46ab-a900-551f78f7ca48@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 03:22:50PM -0500, Steven Sistare wrote:
> On 12/18/2024 12:00 PM, Peter Xu wrote:
> > On Wed, Dec 18, 2024 at 11:34:34AM -0500, Steven Sistare wrote:
> > > After adding resizable support to qemu_ram_alloc_from_fd, I can also tweak it
> > > to grow the file while preserving error checking for the general case, and
> > > delete the explicit ftruncate in its caller:
> > > 
> > >      /*
> > >       * Allow file_ram_alloc to grow the file during CPR, if a resizable
> > >       * memory region wants a larger block than the incoming current size.
> > >       */
> > >      file_size = get_file_size(fd);
> > >      if (file_size && file_size < offset + max_size && size == max_size &&
> > >          migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> > > [...]
> > 
> > Firstly, this check is growing too long, maybe worthwhile to have a helper
> > already.
> > 
> > file_size_check():
> >      // COMMENTS...
> >      if (migrate_mode() == XXX) {
> >          return true;
> >      }
> > 
> > Said that, I think it's better we also add the flag to enforce the
> > truncation, only if cpr found a fd.  E.g. we may want to keep the old
> > behavior even if the user sets migrate mode to CPR (even without a
> > migration happening at all), then create a fd ramblock.
> 
> That was my intent.  Normally mode becomes TRANSFER only when outgoing migration
> is about to start, or is incoming, but conceivably the source qemu user could
> set mode early, before creating some object requiring aux memory.

Such ordering may not be wanted, and can be too trivial.

We used to discuss with Dan, and we wished all migration caps/params/modes
will only be set in the QMP "migrate" command, rather than being separate.

Actually we may start supporting such in the near future, taking all
migration setup in the QMP command 'migrate'.  Then none of migration
caps/params/modes will be global anymore, but only taken from the QMP
command.  From that POV, better not rely on that.

> 
> I can add a grow parameter to qemu_ram_alloc_from_fd and pass true only
> if the fd came from cpr_find_fd.  Sound OK?
> 
> RAMBlock *qemu_ram_alloc_from_fd(..., bool grow)
>     if (file_size && file_size < offset + max_size && !grow) {
>         error_setg(...
>     ...
>     new_block->host = file_ram_alloc(new_block, max_size, fd,
>                                      file_size < offset + max_size,
>                                      offset, errp);

Sounds good.

Thanks,

-- 
Peter Xu


