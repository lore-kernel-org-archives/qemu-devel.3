Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56DCC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpLr-0007bd-M3; Thu, 14 Mar 2024 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkpLY-0007CC-Ns
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkpLS-0005i3-64
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710439100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bmzA7ofjcHyBGtEnZoez5F86eGFzMwkffuyeikUn0Fc=;
 b=F3swfUGKbtYPkgMIlC2TlqcSbJFPViOfEnAJtyOmXFboiSoeDRPZjEuVCAKsqD5iE5Yv74
 7l96oFCNl9WtVmih3Rrw8TfHX45ku9M8erRkNnRxX3mqR21YccTbW3IitdD3b2AAjHt9bh
 JuFHpJZHq5vBKfTJ3E9SxdgwMr76Szg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-9v0sVOHwPl-YnBg1jMnw5A-1; Thu, 14 Mar 2024 13:58:18 -0400
X-MC-Unique: 9v0sVOHwPl-YnBg1jMnw5A-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-22206c445fcso432641fac.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710439097; x=1711043897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmzA7ofjcHyBGtEnZoez5F86eGFzMwkffuyeikUn0Fc=;
 b=sIDZdlaEdXjtEZRsJhAxdYOEHs7iRL6iqLjzT4rhp4KamyYqbgrEEoBtwAeT7JtRmn
 YsDTrpiyIqBcRq7gpSj26cbJ/BDK9nxKLDur/w3ka6AD00TU+4gT9p/lT/zLZm4gYIDb
 uFE21qVekrSWaRNlSJ4k8CiBl7L5OiRMkD3DmxJZcnemJdE9d4657XQfHzxaLGRc9YHr
 CmXqQdb6vbdoYqb3lYhgq1+uBbkqqoPKV+1NIInQKluSVYRR/t1ODyitkW5tmH9zYLqg
 u5ZqEWUGNh/vraPRLNl6SfUt7nndsf2cT0H34j7vqV33r6g5hF6BC+ulZCiUZYd0jJNp
 SeRA==
X-Gm-Message-State: AOJu0YyYAHCYIce7bWXvqoIM0ZZMamcvaTgGFXaEtI8r611YRomplW60
 A/qtxzevd/XMPHd4CX+oYgpzkg1Hz+DhStJ2ybxfU/lcOPhn1M3mJ21Z/oU4IUpfz3xQu31l2kg
 pxmh6zNF4bqeSHDz6jeYcRxOezzxMVGQRDXBk+18OxqewaNbjw0Qj
X-Received: by 2002:a05:6870:548b:b0:221:8fd1:21d9 with SMTP id
 f11-20020a056870548b00b002218fd121d9mr2661507oan.1.1710439097480; 
 Thu, 14 Mar 2024 10:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ5iJpTBp9HTsOLNGLh73Kjm8abhWfz2l6ntutXTbLjNBqelGZrjAJtgpnEB0ZX1I1wY+jaw==
X-Received: by 2002:a05:6870:548b:b0:221:8fd1:21d9 with SMTP id
 f11-20020a056870548b00b002218fd121d9mr2661496oan.1.1710439097104; 
 Thu, 14 Mar 2024 10:58:17 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z17-20020a056214041100b0068ff8d75a90sm750022qvx.19.2024.03.14.10.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:58:16 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:58:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/multifd: Ensure we're not given a
 socket for file migration
Message-ID: <ZfM6t7NfRXK_1k6m@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-3-farosas@suse.de> <ZfMTVApNl01-yS_v@x1n>
 <ZfMbJnC96vUXnPTJ@x1n> <87sf0svjuo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf0svjuo.fsf@suse.de>
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

On Thu, Mar 14, 2024 at 01:50:07PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Mar 14, 2024 at 11:10:12AM -0400, Peter Xu wrote:
> >> On Wed, Mar 13, 2024 at 06:28:24PM -0300, Fabiano Rosas wrote:
> >> > When doing migration using the fd: URI, the incoming migration starts
> >> > before the user has passed the file descriptor to QEMU. This means
> >> > that the checks at migration_channels_and_transport_compatible()
> >> > happen too soon and we need to allow a migration channel of type
> >> > SOCKET_ADDRESS_TYPE_FD even though socket migration is not supported
> >> > with multifd.
> >> 
> >> Hmm, bare with me if this is a stupid one.. why the incoming migration can
> >> start _before_ the user passed in the fd?
> >> 
> >> IOW, why can't we rely on a single fd_is_socket() check for
> >> SOCKET_ADDRESS_TYPE_FD in transport_supports_multi_channels()?
> >> 
> >> > 
> >> > The commit decdc76772 ("migration/multifd: Add mapped-ram support to
> >> > fd: URI") was supposed to add a second check prior to starting
> >> > migration to make sure a socket fd is not passed instead of a file fd,
> >> > but failed to do so.
> >> > 
> >> > Add the missing verification.
> >> > 
> >> > Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > ---
> >> >  migration/fd.c   | 8 ++++++++
> >> >  migration/file.c | 7 +++++++
> >> >  2 files changed, 15 insertions(+)
> >> > 
> >> > diff --git a/migration/fd.c b/migration/fd.c
> >> > index 39a52e5c90..c07030f715 100644
> >> > --- a/migration/fd.c
> >> > +++ b/migration/fd.c
> >> > @@ -22,6 +22,7 @@
> >> >  #include "migration.h"
> >> >  #include "monitor/monitor.h"
> >> >  #include "io/channel-file.h"
> >> > +#include "io/channel-socket.h"
> >> >  #include "io/channel-util.h"
> >> >  #include "options.h"
> >> >  #include "trace.h"
> >> > @@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
> >> >      }
> >> >  
> >> >      if (migrate_multifd()) {
> >> > +        if (fd_is_socket(fd)) {
> >> > +            error_setg(errp,
> >> > +                       "Multifd migration to a socket FD is not supported");
> >> > +            object_unref(ioc);
> >> > +            return;
> >> > +        }
> >
> > And... I just noticed this is forbiding multifd+socket+fd in general?  But
> > isn't that the majority of multifd usage when with libvirt over sockets?
> 
> I didn't think multifd supported socket fds, does it? I don't see code
> to create the multiple channels anywhere. How would that work? Multiple
> threads writing to a single socket fd? I'm a bit confused.

You're probably right.

I somehow had the assumption that Libvirt always used fds to passover to
QEMU for migration, but indeed multifd at least shouldn't support it as I
read the code again..  It'll be good if Dan would help to clarify when fd
will be used in migrations.

-- 
Peter Xu


