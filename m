Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC34C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rknFN-0000Sz-1M; Thu, 14 Mar 2024 11:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rknFI-0000Sk-RG
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rknFB-0006t0-Bh
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710431018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ivjlUdJ9DlU0H8mqhtnj9i4vjnyWZzqWs3N3xcO7XM=;
 b=dhoJb95UohtGxZMpyvmydxzR8StMdJ27yIlsRqOqcE7myIoQOCOqIbTP/VS5AjrGPUSC/Y
 bcrqEl8Uws/4kpn10VFE8dHINLklIuets3hD1POrYFwyEx1phJYLbKQP7/QbVzOwaPG5uA
 kGSWxGIv3Tioca6BPKdRtJ6vDVelqy0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-0bO5GhMOM3qzAVdxT_sZng-1; Thu, 14 Mar 2024 11:43:37 -0400
X-MC-Unique: 0bO5GhMOM3qzAVdxT_sZng-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69152af7760so1839656d6.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710431016; x=1711035816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ivjlUdJ9DlU0H8mqhtnj9i4vjnyWZzqWs3N3xcO7XM=;
 b=RjFClyFrWaNVpehDjD/Go1KjjF/iVTeLAzzH3xihdaH1HhcR78+qUoF7moYgVUihnM
 tJF76mWrM8YX76WefXKz97lE5h8OT5KJQASI8nDuxAr9skx7dpPXWP3cQp4cLofQpXY9
 oTtEIWpt1NcsLh9ltod8caFd0e3SiQ0gV07//06pLUskG9XVc6UopEuGZIEbrtWX6Fhn
 WNLlhIvtoX5HrY/iodGulNqmhSP8cvhVIJlqYorH0Zz0KsQdCRDT6OqHXzqWAzpp4uba
 az6nICYMe2prtbSDtq4eqGrtui7xtndwIoekxIqtCpNJ2jDEkARwKmSQv93niQDCXkK1
 Ggiw==
X-Gm-Message-State: AOJu0YyD1XbUQpA+7707ogWhUkdvs+lVf3FVkCsVxASyF9E6Wkwdsk9Z
 2iOuDreZUBOBimX0SpOhmTcyJA/FzadHg7ivOdwyF13hDM95AyqRG/6etsujbpHQ9SzTMvrm5sH
 xhHZKsUC+NVQzKY4yBiPCEY6ds0EonytfOHktt8rX+DHdqSjJrjB7OAN9gKXv
X-Received: by 2002:a05:6214:318b:b0:690:b5a9:84f1 with SMTP id
 lb11-20020a056214318b00b00690b5a984f1mr2206242qvb.1.1710431016316; 
 Thu, 14 Mar 2024 08:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+QFkM8FcIOUjym880VmR7Og2Eta+21aGKNN3C/wocRSy7t9Miw3dvyGnubr5g+pKbv6fH0A==
X-Received: by 2002:a05:6214:318b:b0:690:b5a9:84f1 with SMTP id
 lb11-20020a056214318b00b00690b5a984f1mr2206217qvb.1.1710431015797; 
 Thu, 14 Mar 2024 08:43:35 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gy10-20020a056214242a00b0068f6e1c3582sm569069qvb.146.2024.03.14.08.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 08:43:35 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:43:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/multifd: Ensure we're not given a
 socket for file migration
Message-ID: <ZfMbJnC96vUXnPTJ@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-3-farosas@suse.de> <ZfMTVApNl01-yS_v@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfMTVApNl01-yS_v@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 14, 2024 at 11:10:12AM -0400, Peter Xu wrote:
> On Wed, Mar 13, 2024 at 06:28:24PM -0300, Fabiano Rosas wrote:
> > When doing migration using the fd: URI, the incoming migration starts
> > before the user has passed the file descriptor to QEMU. This means
> > that the checks at migration_channels_and_transport_compatible()
> > happen too soon and we need to allow a migration channel of type
> > SOCKET_ADDRESS_TYPE_FD even though socket migration is not supported
> > with multifd.
> 
> Hmm, bare with me if this is a stupid one.. why the incoming migration can
> start _before_ the user passed in the fd?
> 
> IOW, why can't we rely on a single fd_is_socket() check for
> SOCKET_ADDRESS_TYPE_FD in transport_supports_multi_channels()?
> 
> > 
> > The commit decdc76772 ("migration/multifd: Add mapped-ram support to
> > fd: URI") was supposed to add a second check prior to starting
> > migration to make sure a socket fd is not passed instead of a file fd,
> > but failed to do so.
> > 
> > Add the missing verification.
> > 
> > Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/fd.c   | 8 ++++++++
> >  migration/file.c | 7 +++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/migration/fd.c b/migration/fd.c
> > index 39a52e5c90..c07030f715 100644
> > --- a/migration/fd.c
> > +++ b/migration/fd.c
> > @@ -22,6 +22,7 @@
> >  #include "migration.h"
> >  #include "monitor/monitor.h"
> >  #include "io/channel-file.h"
> > +#include "io/channel-socket.h"
> >  #include "io/channel-util.h"
> >  #include "options.h"
> >  #include "trace.h"
> > @@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
> >      }
> >  
> >      if (migrate_multifd()) {
> > +        if (fd_is_socket(fd)) {
> > +            error_setg(errp,
> > +                       "Multifd migration to a socket FD is not supported");
> > +            object_unref(ioc);
> > +            return;
> > +        }

And... I just noticed this is forbiding multifd+socket+fd in general?  But
isn't that the majority of multifd usage when with libvirt over sockets?

Shouldn't it about fd's seekable-or-not instead when mapped-ram enabled
(IOW, migration_needs_seekable_channel() only)?

> > +
> >          file_create_incoming_channels(ioc, errp);
> >      } else {
> >          qio_channel_set_name(ioc, "migration-fd-incoming");
> > diff --git a/migration/file.c b/migration/file.c
> > index ddde0ca818..b6e8ba13f2 100644
> > --- a/migration/file.c
> > +++ b/migration/file.c
> > @@ -15,6 +15,7 @@
> >  #include "file.h"
> >  #include "migration.h"
> >  #include "io/channel-file.h"
> > +#include "io/channel-socket.h"
> >  #include "io/channel-util.h"
> >  #include "options.h"
> >  #include "trace.h"
> > @@ -58,6 +59,12 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
> >      int fd = fd_args_get_fd();
> >  
> >      if (fd && fd != -1) {
> > +        if (fd_is_socket(fd)) {
> > +            error_setg(errp,
> > +                       "Multifd migration to a socket FD is not supported");
> > +            goto out;
> > +        }
> > +
> >          ioc = qio_channel_file_new_dupfd(fd, errp);
> >      } else {
> >          ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> > -- 
> > 2.35.3
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


