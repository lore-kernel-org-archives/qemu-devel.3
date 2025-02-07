Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A1DC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSey-0005Qb-Ob; Fri, 07 Feb 2025 13:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSex-0005Q5-2c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSet-0006RH-SY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738951254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QoV914MfZzsSG8SzyX4qNk5L8mAm37U1DH4hWJspMTA=;
 b=VDUBuE6getIUNzd/RNZ4+qXrRpNafVkoCXoLCk2mGL/KWRTAgcm30y8/kAj+RsHGchjda8
 BYdfWKhpkPr9283rV6l6zj89dTL5G9lAJo1wlU2yAarHO708eb9uVczRTvzzCM0OYIEVOZ
 y8UDpb1xlbf30XNNEfvYYNjNuU4WtuE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-D8Ub8Ya0ODSE9ifCMPdTSg-1; Fri, 07 Feb 2025 13:00:53 -0500
X-MC-Unique: D8Ub8Ya0ODSE9ifCMPdTSg-1
X-Mimecast-MFC-AGG-ID: D8Ub8Ya0ODSE9ifCMPdTSg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7be6ec10e52so403860585a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951252; x=1739556052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoV914MfZzsSG8SzyX4qNk5L8mAm37U1DH4hWJspMTA=;
 b=c4yZ77kb/jSGn995n4AAN/xWn2OB0krahvRBn9M3QQuS+F8Mj+9LU71FY0yXEcmXGe
 KDKv0Dj2gtqggzPq7U3bEXe/3QtBkxXRQNPLOdijeSy46zbQpWHe4y2ljvnKfT1IXas8
 PJtEM5o77NzVXnR6/R9OOcyXHyjejlxMD7z5NAt3KA9QdbA1qL/tFoVlKZw4QkRX6nt4
 xlMyVsHgcV95+ohMaKUvoQy1CEhrWSfTClTXDjXxl85o42iXZN0xEkDQ9fuDDChEozWQ
 fuw0u4bVtjnQ5kYSQJ9NsVVeVvnMtA91GlpRqnFqCHOmyJMx97EH9z30QiSzkRvNsqAI
 ausQ==
X-Gm-Message-State: AOJu0YwWKvEENDa16TiA1A3jvFgcPTrIUrfFyBqAy6LQLgzWlv2y0IdB
 e0admmlQ1u5bYFVW6T5wW9glUNiqWWFGgHOeRHAzYAgsvw/9mxuML3OFmSJk4U36yGR8ga2P7mc
 kWY2a4TleE4eeWAU8utSuskm7xVD7wn+GtqHgbPyONtxgn2JqW9R7Bl8sLg3x
X-Gm-Gg: ASbGncsZjHLa15rUbcV7ELOi7fLv93gGAK4hpwRZZqqZBOsK5e1FSqQ2AInATqR9Clz
 +m88gaaeG9l5MTFBenuFYNQS/LzTeM4wipYyxwPiX4f9rgKop/Hc0I+YDn9VUnMKQtKTkmX6+yb
 6bQuTIZnFeFsC5WvquiGUhBn7sXdzoLoI8Fy95m2MI6bURC6bLOVthCsKNxfjZ10DzRkO5/sKXB
 ZgN7z9ulD8CwS4KM+I/TrH/xvjwVaq6iLJILhV3hXoJ+mIRpJ0TFqsWa8KoS12cmrqc+ffJhCq/
 SdAvjGgs5gLzgD5G1c2SfKwjiR1Mhu1lPlCD0cJ94eApyzSM
X-Received: by 2002:a05:620a:43a1:b0:7be:7f76:18cd with SMTP id
 af79cd13be357-7c047ca7be4mr677197985a.49.1738951252007; 
 Fri, 07 Feb 2025 10:00:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCIU4t9pgMSrLpmLeGInQCs3Eb5v2eaZnhpJdDPIdjvTKWqxFhlkFpwUrp4MLk2YmAgXuvoA==
X-Received: by 2002:a05:620a:43a1:b0:7be:7f76:18cd with SMTP id
 af79cd13be357-7c047ca7be4mr677189785a.49.1738951251353; 
 Fri, 07 Feb 2025 10:00:51 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041ded101sm219127485a.4.2025.02.07.10.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:00:50 -0800 (PST)
Date: Fri, 7 Feb 2025 13:00:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 3/8] migration/multifd: Terminate the TLS connection
Message-ID: <Z6ZKUTNVcCVgIbjh@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207142758.6936-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 11:27:53AM -0300, Fabiano Rosas wrote:
> The multifd recv side has been getting a TLS error of
> GNUTLS_E_PREMATURE_TERMINATION at the end of migration when the send
> side closes the sockets without ending the TLS session. This has been
> masked by the code not checking the migration error after loadvm.
> 
> Start ending the TLS session at multifd_send_shutdown() so the recv
> side always sees a clean termination (EOF) and we can start to
> differentiate that from an actual premature termination that might
> possibly happen in the middle of the migration.
> 
> There's nothing to be done if a previous migration error has already
> broken the connection, so add a comment explaining it and ignore any
> errors coming from gnutls_bye().
> 
> This doesn't break compat with older recv-side QEMUs because EOF has
> always caused the recv thread to exit cleanly.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial comment..

> ---
>  migration/multifd.c | 34 +++++++++++++++++++++++++++++++++-
>  migration/tls.c     |  5 +++++
>  migration/tls.h     |  2 +-
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ab73d6d984..b57cad3bb1 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -490,6 +490,32 @@ void multifd_send_shutdown(void)
>          return;
>      }
>  
> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        /* thread_created implies the TLS handshake has succeeded */
> +        if (p->tls_thread_created && p->thread_created) {
> +            Error *local_err = NULL;
> +            /*
> +             * The destination expects the TLS session to always be
> +             * properly terminated. This helps to detect a premature
> +             * termination in the middle of the stream.  Note that
> +             * older QEMUs always break the connection on the source
> +             * and the destination always sees
> +             * GNUTLS_E_PREMATURE_TERMINATION.
> +             */
> +            migration_tls_channel_end(p->c, &local_err);
> +
> +            if (local_err) {
> +                /*
> +                 * The above can fail with broken pipe due to a
> +                 * previous migration error, ignore the error.
> +                 */
> +                assert(migration_has_failed(migrate_get_current()));

Considering this is still src, do we want to be softer on this by
error_report?

Logically !migration_has_failed() means it succeeded, so we can throw src
qemu way now, that shouldn't be a huge deal. More of thinking out loud kind
of comment..  Your call.

> +            }
> +        }
> +    }
> +
>      multifd_send_terminate_threads();
>  
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -1141,7 +1167,13 @@ static void *multifd_recv_thread(void *opaque)
>  
>              ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>                                             p->packet_len, &local_err);
> -            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> +            if (!ret) {
> +                /* EOF */
> +                assert(!local_err);
> +                break;
> +            }
> +
> +            if (ret == -1) {
>                  break;
>              }
>  
> diff --git a/migration/tls.c b/migration/tls.c
> index fa03d9136c..5cbf952383 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -156,6 +156,11 @@ void migration_tls_channel_connect(MigrationState *s,
>                                NULL);
>  }
>  
> +void migration_tls_channel_end(QIOChannel *ioc, Error **errp)
> +{
> +    qio_channel_tls_bye(QIO_CHANNEL_TLS(ioc), errp);
> +}
> +
>  bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc)
>  {
>      if (!migrate_tls()) {
> diff --git a/migration/tls.h b/migration/tls.h
> index 5797d153cb..58b25e1228 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -36,7 +36,7 @@ void migration_tls_channel_connect(MigrationState *s,
>                                     QIOChannel *ioc,
>                                     const char *hostname,
>                                     Error **errp);
> -
> +void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>  /* Whether the QIO channel requires further TLS handshake? */
>  bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


