Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836A5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEuG-0000dv-6b; Tue, 04 Nov 2025 06:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGEuE-0000dH-Fd
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:08:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGEuC-0003gi-TK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762254530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=97RdXNup4/6uhhRLpFvMdP9hLGQ/aeG/jwVxpMVqWSA=;
 b=AyGkpBHcnDE4vxKr/QduZuZ4XMqSaSGBUjc/m3P+fJrhnh9FEGs8ApzZ9eAbx8i7Ckj9bH
 fSP9a8TZVXrH4tnUtbcfSKYcBRE6zOi5NM+I+LT2nGhSABO8V/q4wje2hYIilGeSgh3c8+
 Oz1UndElpxZrRSpyYocaoLmzR4I0ThE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-j51p1DLqOs65q8iL4AmAkw-1; Tue,
 04 Nov 2025 06:08:47 -0500
X-MC-Unique: j51p1DLqOs65q8iL4AmAkw-1
X-Mimecast-MFC-AGG-ID: j51p1DLqOs65q8iL4AmAkw_1762254526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7441800673; Tue,  4 Nov 2025 11:08:46 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D803430001A1; Tue,  4 Nov 2025 11:08:44 +0000 (UTC)
Date: Tue, 4 Nov 2025 12:08:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 1/8] qio: Add trace points to net_listener
Message-ID: <aQneugckIJ-skmTr@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-11-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103202849.3687643-11-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> Upcoming patches will adjust how net_listener watches for new client
> connections; adding trace points now makes it easier to debug that the
> changes work as intended.  For example, adding
> --trace='qio_net_listener*' to the qemu-storage-daemon command line
> before --nbd-server will track when the server first starts listening
> for clients.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  io/net-listener.c | 17 +++++++++++++++++
>  io/trace-events   |  5 +++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/io/net-listener.c b/io/net-listener.c
> index 47405965a66..0adbc409cf2 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -23,6 +23,7 @@
>  #include "io/dns-resolver.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "trace.h"
> 
>  QIONetListener *qio_net_listener_new(void)
>  {
> @@ -50,6 +51,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
>          return TRUE;
>      }
> 
> +    trace_qio_net_listener_callback(listener, listener->io_func);
>      if (listener->io_func) {
>          listener->io_func(listener, sioc, listener->io_data);
>      }

Not necessarily a problem, but I wonder why you decided to have the
trace point unconditional here...

> @@ -143,6 +147,9 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
>  {
>      size_t i;
> 
> +    if (listener->io_func) {
> +        trace_qio_net_listener_watch_disabled(listener, "set_client_func");
> +    }
>      if (listener->io_notify) {
>          listener->io_notify(listener->io_data);
>      }

...while everywhere else you only call it with a non-NULL
listener->io_func.

Kevin


