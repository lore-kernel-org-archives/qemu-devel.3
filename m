Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83096C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmj0-0001zz-LP; Thu, 14 Mar 2024 11:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkmiu-0001zo-8G
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkmis-00016h-Hl
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D31+BBZM9ZUhhr7Y6H0RmtF0XDBEJkK8NSX4DJpQxIM=;
 b=bDlTy39FfViIA7DI6FTLTf2Vg+vUUsFKn15vsmjOBIi0C33aEpqHYy9wiTQM0coKTdz6ln
 56t7uFDkI/2aYBs7dXOouyzog2mMjm5OnF/+EqLsQ4/fDs9Zu7GYdYVOOOOaxdSz4vC3QY
 b0db9zteeKljpGnWHcmK6GTdPXQaKMs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-HrRqvdvxOjCDoa_i_nRVjA-1; Thu, 14 Mar 2024 11:10:15 -0400
X-MC-Unique: HrRqvdvxOjCDoa_i_nRVjA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-690c19ee50bso3255426d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710429015; x=1711033815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D31+BBZM9ZUhhr7Y6H0RmtF0XDBEJkK8NSX4DJpQxIM=;
 b=MZYh5KzmfkoP4NyAdGLd0kSPYL1QeRDZApf5jk4BX9kTco1WTR+0azOSFO1zp9yBOb
 hr/SoFMwbspKSycj3r4alBd2PWjHngCC5CZwUdPPbCI9aN6E3eF4/cbL/Q87WKbwCTqG
 mh/Utxve7X9X3MbfqIHRS5njPPRuJaSOqSlc2bBFRFsig8etvWX6xWogWiF9IAfJnHzv
 uCcBR4Grw8x5yE0pdRGQlQSt/B7O8lsXmmL8NnFyC4J6CKNneXsgRRJQABekK2Zta9aI
 3U2Ui5M0sC0xtrWnbLAEdsuxS12gpfnoc5srRsgajeKYIz+ttQTaAgFhkNtZJKmzDxNT
 up7w==
X-Gm-Message-State: AOJu0YyM15sbDosNo40AO+4y+tqAxG8XLDZaiyO0gTKsMPXbcRmLUUT6
 wjswXj3SYUSXpMbK/tQTDSN5IKW2TQuej+8IAVSG77LOKwP+OyBiRhNfZOs8fPBG2Ug44oaV9Q1
 +yoCInMeL3EPDwNqFEKjhiFZb/gESOqNyxgpkqsltPFlLYSCFMlSpodmuhTqC
X-Received: by 2002:a05:6214:4384:b0:691:2524:2d87 with SMTP id
 oh4-20020a056214438400b0069125242d87mr2142215qvb.2.1710429014669; 
 Thu, 14 Mar 2024 08:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3vep0tWAaPKoSB5HLrZiMnY3/jUVsyFP79wDc3XjtwxD5YPj8TMO+JYjgl2n20L+anekk5Q==
X-Received: by 2002:a05:6214:4384:b0:691:2524:2d87 with SMTP id
 oh4-20020a056214438400b0069125242d87mr2142181qvb.2.1710429014192; 
 Thu, 14 Mar 2024 08:10:14 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 r9-20020a056214124900b00690bee954fasm557434qvv.98.2024.03.14.08.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 08:10:13 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:10:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/multifd: Ensure we're not given a
 socket for file migration
Message-ID: <ZfMTVApNl01-yS_v@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313212824.16974-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Wed, Mar 13, 2024 at 06:28:24PM -0300, Fabiano Rosas wrote:
> When doing migration using the fd: URI, the incoming migration starts
> before the user has passed the file descriptor to QEMU. This means
> that the checks at migration_channels_and_transport_compatible()
> happen too soon and we need to allow a migration channel of type
> SOCKET_ADDRESS_TYPE_FD even though socket migration is not supported
> with multifd.

Hmm, bare with me if this is a stupid one.. why the incoming migration can
start _before_ the user passed in the fd?

IOW, why can't we rely on a single fd_is_socket() check for
SOCKET_ADDRESS_TYPE_FD in transport_supports_multi_channels()?

> 
> The commit decdc76772 ("migration/multifd: Add mapped-ram support to
> fd: URI") was supposed to add a second check prior to starting
> migration to make sure a socket fd is not passed instead of a file fd,
> but failed to do so.
> 
> Add the missing verification.
> 
> Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/fd.c   | 8 ++++++++
>  migration/file.c | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/migration/fd.c b/migration/fd.c
> index 39a52e5c90..c07030f715 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -22,6 +22,7 @@
>  #include "migration.h"
>  #include "monitor/monitor.h"
>  #include "io/channel-file.h"
> +#include "io/channel-socket.h"
>  #include "io/channel-util.h"
>  #include "options.h"
>  #include "trace.h"
> @@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>      }
>  
>      if (migrate_multifd()) {
> +        if (fd_is_socket(fd)) {
> +            error_setg(errp,
> +                       "Multifd migration to a socket FD is not supported");
> +            object_unref(ioc);
> +            return;
> +        }
> +
>          file_create_incoming_channels(ioc, errp);
>      } else {
>          qio_channel_set_name(ioc, "migration-fd-incoming");
> diff --git a/migration/file.c b/migration/file.c
> index ddde0ca818..b6e8ba13f2 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -15,6 +15,7 @@
>  #include "file.h"
>  #include "migration.h"
>  #include "io/channel-file.h"
> +#include "io/channel-socket.h"
>  #include "io/channel-util.h"
>  #include "options.h"
>  #include "trace.h"
> @@ -58,6 +59,12 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
>      int fd = fd_args_get_fd();
>  
>      if (fd && fd != -1) {
> +        if (fd_is_socket(fd)) {
> +            error_setg(errp,
> +                       "Multifd migration to a socket FD is not supported");
> +            goto out;
> +        }
> +
>          ioc = qio_channel_file_new_dupfd(fd, errp);
>      } else {
>          ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> -- 
> 2.35.3
> 

-- 
Peter Xu


