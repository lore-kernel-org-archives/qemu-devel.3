Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF38CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9TDC-0003ia-Ur; Thu, 16 Oct 2025 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9TD6-0003hJ-0s
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9TCs-0004ko-75
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760641204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUwqhRn4nHdXaXBnoD8O4RDs8PMEJ8JE4AdnhP3uwkk=;
 b=BbBi2yNF2Cu+KhyRgsfBbIPMWbhQIQ5AcP/i5+T2Edj9fWgaB/Ln0IECmnB0k1Iz2+E3Wq
 8NUynsLrHlqnrftEZ8ocSD/wpbf13CfCO7DzfA8d00DNEDGwV74XlezsFR55+djfqMkTkn
 P9mqgVeW57zmdFixqM/NSZpkgBSWqd8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-It9xLeL3NvuQ0Bib6E2XPA-1; Thu, 16 Oct 2025 15:00:02 -0400
X-MC-Unique: It9xLeL3NvuQ0Bib6E2XPA-1
X-Mimecast-MFC-AGG-ID: It9xLeL3NvuQ0Bib6E2XPA_1760641201
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88e91599ee5so512314985a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 12:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760641201; x=1761246001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUwqhRn4nHdXaXBnoD8O4RDs8PMEJ8JE4AdnhP3uwkk=;
 b=sN+fNvhHa+qTY/YxolQeJ+gKAXfYIECkpg8x9dUuPZbf7mlQ/n9TDBE7mJoCjNjCcT
 sWCmLTlCz69FsjqeXrBo+iiw3N58dzLkT6zj337B1kVJffWgm6DZZW6+F0WkrxTj83dS
 X1pypfkBse4nmNRLikz1COu/Df0ce5dx79YlE465aApneblfJEIgVHjlCZfI6HswTghL
 i8EQjRlr4BA2w4vRaIn4kiVBLd3F6LAmdj9FU/AYUl7xTWMDK74zi0YL0zQ+WB5e3KcN
 Eqt+Ct3nRRO+PID15yu1iH0lqGf7l0wzc4mOSb1R96ibEcMw/XDAXDUmxOegqHo3aHEk
 4VhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUBH4Zjv50dhu8+hOLgWUXqHOytrao0LkF9+SJcmzKfHcNZSW2TFb0voc+J8YAVKQs3ezz2V2EwZfN@nongnu.org
X-Gm-Message-State: AOJu0YzBgXrPAuHBLQkDAs8ZTTO7VhdsEHhd8DdmLxiQkApgbgKW1VcI
 UCfMO0TfM5cC0iGXhC8PRx++IUrfOXKoiM4FnHVRThZJ4onWRYPWxiv+jfwc3w5tmonET4mY5ZQ
 Vftrghh4p9Fl6dON/QXRlxT1gEijwUR6+twlmvyE1lDPg7UW4h8eMaOGp
X-Gm-Gg: ASbGncs/tbnwdlLQo1TiIjmvOjlt7o73K9vGTiBnK9MVC711ds4kxYJ+VU/icQClwEu
 cVFs87aJPyBuX3AgOm8Ak2fk+WAg6BD+PBMSFZeuSXStKHmjQbt8Fpb+4+YcE+2009ogkvi47AU
 QGFhw0FzG6XSyWGbegsnkjulEXRTUggyAl599ozC00xcNEoNmevJFs5YlUd4/IwKf8Avuuz4hI5
 f+p8OXF0EFmXcKIyKUTazzw3bqZTcfCticp6iY6+YwJpJkuIpjf+DgKEPGNUEY34dGFW7Rb3FJr
 aVtL4OxwWhuyealJZ+EG/IGtR8e72lK4YLQtNCwwcRKiyC1z6jF4x27DLajyv2pvLj0=
X-Received: by 2002:a05:622a:181c:b0:4b7:a44f:527e with SMTP id
 d75a77b69052e-4e89d400231mr15708481cf.76.1760641201301; 
 Thu, 16 Oct 2025 12:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLRtZLu+NusQ8lOEj5p9eVqi45NvKPuUfi7fL7wwfzTirC4H9LOwGx1hP81asT2hQZfY/Gnw==
X-Received: by 2002:a05:622a:181c:b0:4b7:a44f:527e with SMTP id
 d75a77b69052e-4e89d400231mr15708171cf.76.1760641200851; 
 Thu, 16 Oct 2025 12:00:00 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f359687d0sm264271385a.13.2025.10.16.11.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 12:00:00 -0700 (PDT)
Date: Thu, 16 Oct 2025 14:59:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: Re: [PATCH v2 15/25] migration: introduce vmstate_event_notifier
Message-ID: <aPFArPHrqwerez2g@x1.local>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-16-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016114104.1384675-16-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 16, 2025 at 02:40:52PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> This will be used to support backend-transfer migration for
> vhost-user-blk, we'll migrate event notifier fds through
> migration stream, to avoid extra contact with backend.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Acked-by: Peter Xu <peterx@redhat.com>

Note: we recently merged _errp versions of all below three hooks.  You can
also switch to that if all of them can fail.  You can keep my A-b if you
switch over.

> ---
>  include/migration/vmstate.h        |  7 ++++
>  migration/meson.build              |  1 +
>  migration/vmstate-event-notifier.c | 54 ++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 migration/vmstate-event-notifier.c
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f243518fb5..7f1f1c166a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1294,4 +1294,11 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
>  
>  bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
>  
> +extern const VMStateDescription vmstate_event_notifier;
> +
> +#define VMSTATE_EVENT_NOTIFIER(_field, _struct) \
> +    VMSTATE_STRUCT(_field, _struct, 0, vmstate_event_notifier, \
> +                   EventNotifier)
> +
> +
>  #endif
> diff --git a/migration/meson.build b/migration/meson.build
> index 16909d54c5..b5341ae0cb 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -5,6 +5,7 @@ migration_files = files(
>    'xbzrle.c',
>    'vmstate-types.c',
>    'vmstate.c',
> +  'vmstate-event-notifier.c',
>    'qemu-file.c',
>    'yank_functions.c',
>  )
> diff --git a/migration/vmstate-event-notifier.c b/migration/vmstate-event-notifier.c
> new file mode 100644
> index 0000000000..2076eec961
> --- /dev/null
> +++ b/migration/vmstate-event-notifier.c
> @@ -0,0 +1,54 @@
> +/*
> + * Event notifier migration support
> + * Copyright (c) Yandex Technologies LLC, 2025
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/event_notifier.h"
> +#include "migration/vmstate.h"
> +
> +static int event_notifier_pre_save(void *opaque)
> +{
> +    struct EventNotifier *e = opaque;
> +
> +    if (!e->initialized || e->rfd != e->wfd) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int event_notifier_pre_load(void *opaque)
> +{
> +    struct EventNotifier *e = opaque;
> +
> +    if (e->initialized) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int event_notifier_post_load(void *opaque, int version_id)
> +{
> +    struct EventNotifier *e = opaque;
> +
> +    if (e->rfd < 0) {
> +        return -1;
> +    }
> +
> +    e->wfd = e->rfd;
> +    e->initialized = true;
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_event_notifier = {
> +    .name = "event-notifier",
> +    .pre_save = event_notifier_pre_save,
> +    .pre_load = event_notifier_pre_load,
> +    .post_load = event_notifier_post_load,
> +    .fields = (const VMStateField[]){VMSTATE_FD(rfd, EventNotifier),
> +                                     VMSTATE_END_OF_LIST()},
> +};
> -- 
> 2.48.1
> 

-- 
Peter Xu


