Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABCACFB44D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqtL-00038Y-6q; Mon, 07 Oct 2024 12:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqtJ-000382-FM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqtG-0001aO-35
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728319641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKj3xzDUIqWPH0JC1qTx9gCh0bSsz2n6Z1mmQTs1VCY=;
 b=b+P2e4Tvw6e/OFJwIEPxAvj2XbEL6O5KShD9gE4CyfZQQxo5u38s8YMQRbzQQixJO82Cnu
 A8y+WJS193pzmsr7Pyvrvurvszn1iRjJNC+4pnD8Q1+PVWzvvbFaTvllE38KIyhA7rMp4h
 ClFknRgvIoK/s6QzO6i8LfkL2IWCSIE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-c4rMvslyN9iYzB0wk8QPRA-1; Mon, 07 Oct 2024 12:47:20 -0400
X-MC-Unique: c4rMvslyN9iYzB0wk8QPRA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82cf30e0092so429251839f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319639; x=1728924439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKj3xzDUIqWPH0JC1qTx9gCh0bSsz2n6Z1mmQTs1VCY=;
 b=PMm8fDJYr6LnL1r43nJjjZdNha0TYQNkSGMaRUUJFUEB9L1JhrZWaWzei88s+4BehU
 W+0v5X8P1L/e/+0OdxwDI4PDMiCGSzpO1WO2ifNxG1ugJDO4PmKmsMwoKMPHIPg6Vg1V
 oxG4IqmklSVa+VczDg6E2gkMacbq/pCI0hM0ZuIZRm83eLQCMnRcM1TG+/QPBJisDct1
 rVbic6djHoI9b6tVX8yEuh8c2+DrsHfCFf4kYFZnmaTls6Tsrq9xhLKjwpPSzyAyxJfG
 9YJYgUe1cQti1CjHW1vbLq9xMNH4jjyTYqrwKrConga75uda0dlcpxkkMNIAaAvmM+6Y
 a09w==
X-Gm-Message-State: AOJu0YyukhtL01B7QQ244c5hO1p/eEWLl4kTMHWcienWDPH8TsBi+cQU
 +g5HsEzH7OhzkhCH1GkX2JFMSeKah6XqSdHCYtnB/8DbsbMnm6Pjp5FoD87aRuSMdTQRlwFi3pj
 CNr4n0Pjl2dOw6t0GsQ1CQngANOQAlnK6zpboR+d29u55Py5+bHdQ
X-Received: by 2002:a05:6602:2b83:b0:82d:18d:bab with SMTP id
 ca18e2360f4ac-834f7d7c0demr1062077839f.15.1728319639313; 
 Mon, 07 Oct 2024 09:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFFM0wqcXFidKZPWCPDwkc0ydKfsumpiM+ImuO4OYrvO+GmDEHkpUKr/Xb+CodUF2l41JyBg==
X-Received: by 2002:a05:6602:2b83:b0:82d:18d:bab with SMTP id
 ca18e2360f4ac-834f7d7c0demr1062075539f.15.1728319638968; 
 Mon, 07 Oct 2024 09:47:18 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db9290f992sm97248173.54.2024.10.07.09.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:47:18 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:47:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 09/13] migration: cpr-transfer save and load
Message-ID: <ZwQQlFkguUCp7UH1@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-10-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-10-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 30, 2024 at 12:40:40PM -0700, Steve Sistare wrote:
> Add functions to create a QEMUFile based on a unix URI, for saving or
> loading, for use by cpr-transfer mode to preserve CPR state.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

There're a few extra newlines below, though, which could be removed.

> ---
>  include/migration/cpr.h  |  3 ++
>  migration/cpr-transfer.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/meson.build    |  1 +
>  3 files changed, 85 insertions(+)
>  create mode 100644 migration/cpr-transfer.c
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index ac7a63e..51c19ed 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -30,4 +30,7 @@ int cpr_state_load(Error **errp);
>  void cpr_state_close(void);
>  struct QIOChannel *cpr_state_ioc(void);
>  
> +QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
> +QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
> +
>  #endif
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> new file mode 100644
> index 0000000..fb9ecd8
> --- /dev/null
> +++ b/migration/cpr-transfer.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "io/channel-file.h"
> +#include "io/channel-socket.h"
> +#include "io/net-listener.h"
> +#include "migration/cpr.h"
> +#include "migration/migration.h"
> +#include "migration/savevm.h"
> +#include "migration/qemu-file.h"
> +#include "migration/vmstate.h"
> +
> +QEMUFile *cpr_transfer_output(const char *uri, Error **errp)
> +{
> +    g_autoptr(MigrationChannel) channel = NULL;
> +    QIOChannel *ioc;
> +
> +    if (!migrate_uri_parse(uri, &channel, errp)) {
> +        return NULL;
> +    }
> +
> +    if (channel->addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> +        channel->addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
> +

here

> +        QIOChannelSocket *sioc = qio_channel_socket_new();
> +        SocketAddress *saddr = &channel->addr->u.socket;
> +
> +        if (qio_channel_socket_connect_sync(sioc, saddr, errp)) {
> +            object_unref(OBJECT(sioc));
> +            return NULL;
> +        }
> +        ioc = QIO_CHANNEL(sioc);
> +

here

> +    } else {
> +        error_setg(errp, "bad cpr-uri %s; must be unix:", uri);
> +        return NULL;
> +    }
> +
> +    qio_channel_set_name(ioc, "cpr-out");
> +    return qemu_file_new_output(ioc);
> +}
> +
> +QEMUFile *cpr_transfer_input(const char *uri, Error **errp)
> +{
> +    g_autoptr(MigrationChannel) channel = NULL;
> +    QIOChannel *ioc;
> +
> +    if (!migrate_uri_parse(uri, &channel, errp)) {
> +        return NULL;
> +    }
> +
> +    if (channel->addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> +        channel->addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
> +

here

> +        QIOChannelSocket *sioc;
> +        SocketAddress *saddr = &channel->addr->u.socket;
> +        QIONetListener *listener = qio_net_listener_new();
> +
> +        qio_net_listener_set_name(listener, "cpr-socket-listener");
> +        if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
> +            object_unref(OBJECT(listener));
> +            return NULL;
> +        }
> +
> +        sioc = qio_net_listener_wait_client(listener);
> +        ioc = QIO_CHANNEL(sioc);
> +

here

> +    } else {
> +        error_setg(errp, "bad cpr-uri %s; must be unix:", uri);
> +        return NULL;
> +    }
> +
> +    qio_channel_set_name(ioc, "cpr-in");
> +    return qemu_file_new_input(ioc);
> +}
> diff --git a/migration/meson.build b/migration/meson.build
> index e5f4211..684ba98 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -14,6 +14,7 @@ system_ss.add(files(
>    'channel.c',
>    'channel-block.c',
>    'cpr.c',
> +  'cpr-transfer.c',
>    'dirtyrate.c',
>    'exec.c',
>    'fd.c',
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


