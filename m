Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F69C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSl2-0000Je-KD; Fri, 07 Feb 2025 13:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSl1-0000JS-5M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSky-0002R6-O6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738951630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6gb7olLjeh6PYxSzonzmFmr9KosDaXAXB9/iwp2P/k=;
 b=LjOZ3tvw3YXOQ1OsPOXxpJMDJVhaf3Nb8Fh78q6D6gqp1IbaRMnlovrPSV4Rbqm80U91j2
 MckoUS1XsoQ3Sc386TQoccNgz2e5RSWua+3jHaPj7+g2k551IyCt1ofkJZwhjBvV2hDGcP
 1gUxybFgXFGDnqXcNdRfTdlHnM8tDGU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-dCX7EMEMPQqyGBCpk26tKQ-1; Fri, 07 Feb 2025 13:07:09 -0500
X-MC-Unique: dCX7EMEMPQqyGBCpk26tKQ-1
X-Mimecast-MFC-AGG-ID: dCX7EMEMPQqyGBCpk26tKQ
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e2378169a4so56352356d6.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951628; x=1739556428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6gb7olLjeh6PYxSzonzmFmr9KosDaXAXB9/iwp2P/k=;
 b=Ba1Np73Sc6+DP3+u1qxi+5g1PjGPqrMN1Wzjn7qxXp1FfCdvwMei8+1MsM1IlWAffm
 U1H2aYy8cBtJbu/ZKli4sPhF2E1GGhtvSakDbCvz7FcmYlUoW27e184XHeU9oXr+3ylG
 zUpB1rCB2y0dtibrA2zGkcAaGRRb4gdAXONC1o+eoWzU+iUZIweoByKz5O94nGnRbYaO
 JINYHDnkljdU62N/9O6weaMuSLyX0QsZHmyMzVWXTRixJ05TgoYOhl0LRugIL8B/yKJ4
 I+3o1H3vM75pGb8r19PsoNv5/kCe1cy3M6Q7kMil5BsTnRNR9W6Vy0fbVwFP2HZIxZQf
 KGXw==
X-Gm-Message-State: AOJu0Yy/aJnRfMKSPRNOSa0aCPn/HiR+pty39n4glKa+hg52xTd25Zoi
 xohVHUzxIJ0m/KGvzq67HI4ISj7yKCRlC4gtO8V3Ar6BLwRHtCKTMDWRhJF9A7JXQ+gBEke+8FT
 zOgVBca2p3DEHlbMUmxlMNbM/l7CyUYW2LS29aL67p3zyTn3hD3Ku
X-Gm-Gg: ASbGnct68uOeQsTiErAdwdeKjA8bYIK0iPclUgbkIHMd0dWI0KeI4APClOzzcsJsE0K
 sEyppyPVzHf9KEMYmKSOxk3l3RjZtU+SKC5N8nLm3irI83lV510OpIyiL4pXWxBXSjLpBZOcjTp
 1A44PxbllqfG42IUVFiTxEQhfg63As3CWWSlfSl/Sqcx7c+ZQGK5xGLeu2DAPkhV1y81cBmlH4x
 J3Vc75K0HYz2K2c5DXvW35n/RIDJSm0bIfBQJNGoH9EbgQ9vIis2owONp/cDsJggvvd+JfHICkb
 Z/7kAWPJx6UbDVKvoIo/AtlGyWH1aGJyQ9L337s/NBLAzShZ
X-Received: by 2002:a05:6214:29e4:b0:6d8:8874:2131 with SMTP id
 6a1803df08f44-6e4455e192emr60684106d6.13.1738951628442; 
 Fri, 07 Feb 2025 10:07:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtnCxKhPfoMdKsQTaauwHcgc5d4o5BWzHfXAzGZrzBGEGv7w0XsaNYa4SEvx35bLGiHnIyfw==
X-Received: by 2002:a05:6214:29e4:b0:6d8:8874:2131 with SMTP id
 6a1803df08f44-6e4455e192emr60683766d6.13.1738951628096; 
 Fri, 07 Feb 2025 10:07:08 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e449c271b2sm7816276d6.36.2025.02.07.10.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:07:07 -0800 (PST)
Date: Fri, 7 Feb 2025 13:07:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 8/8] migration/multifd: Add a compat property for
 TLS termination
Message-ID: <Z6ZLyp32-t9aURgR@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207142758.6936-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 07, 2025 at 11:27:58AM -0300, Fabiano Rosas wrote:
> We're currently changing the way the source multifd migration handles
> the shutdown of the multifd channels when TLS is in use to perform a
> clean termination by calling gnutls_bye().
> 
> Older src QEMUs will always close the channel without terminating the
> TLS session. New dst QEMUs treat an unclean termination as an
> error. Due to synchronization conditions, src QEMUs 9.1 and 9.2 are an
> exception and can put the destination in a condition where it ignores
> the unclean termination. For src QEMUs older than 9.1, we'll need a
> compat property on the destination to inform that the src does not
> terminate the TLS session.
> 
> Add multifd_clean_tls_termination (default true) that can be switched
> on the destination whenever a src QEMU <9.1 is in use.

Patch looks good.  Though did you forget to add the compat entry?

I suggest we add it for all pre-9.2, in case whoever backports the recent
changes so it re-exposes again in any distro stables.

IMHO it doesn't hurt us much to be always cautious on 9.1 and 9.2 too by
loosing the termination a bit.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.h | 33 +++++++++++++++++++++++++++++++++
>  migration/multifd.c   |  8 +++++++-
>  migration/multifd.h   |  2 ++
>  migration/options.c   |  2 ++
>  4 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 4c1fafc2b5..77def0b437 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -443,6 +443,39 @@ struct MigrationState {
>       * Default value is false. (since 8.1)
>       */
>      bool multifd_flush_after_each_section;
> +
> +    /*
> +     * This variable only makes sense when set on the machine that is
> +     * the destination of a multifd migration with TLS enabled. It
> +     * affects the behavior of the last send->recv iteration with
> +     * regards to termination of the TLS session.
> +     *
> +     * When set:
> +     *
> +     * - the destination QEMU instance can expect to never get a
> +     *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
> +     *   message: "The TLS connection was non-properly terminated".
> +     *
> +     * When clear:
> +     *
> +     * - the destination QEMU instance can expect to see a
> +     *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
> +     *   whenever the last recv() call of that channel happens after
> +     *   the source QEMU instance has already issued shutdown() on the
> +     *   channel.
> +     *
> +     *   Commit 637280aeb2 (since 9.1) introduced a side effect that
> +     *   causes the destination instance to not be affected by the
> +     *   premature termination, while commit 1d457daf86 (since 10.0)
> +     *   causes the premature termination condition to be once again
> +     *   reachable.
> +     *
> +     * NOTE: Regardless of the state of this option, a premature
> +     * termination of the TLS connection might happen due to error at
> +     * any moment prior to the last send->recv iteration.
> +     */
> +    bool multifd_clean_tls_termination;
> +
>      /*
>       * This decides the size of guest memory chunk that will be used
>       * to track dirty bitmap clearing.  The size of memory chunk will
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b4f82b0893..4342399818 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1147,6 +1147,7 @@ void multifd_recv_sync_main(void)
>  
>  static void *multifd_recv_thread(void *opaque)
>  {
> +    MigrationState *s = migrate_get_current();
>      MultiFDRecvParams *p = opaque;
>      Error *local_err = NULL;
>      bool use_packets = multifd_use_packets();
> @@ -1155,6 +1156,10 @@ static void *multifd_recv_thread(void *opaque)
>      trace_multifd_recv_thread_start(p->id);
>      rcu_register_thread();
>  
> +    if (!s->multifd_clean_tls_termination) {
> +        p->read_flags = QIO_CHANNEL_READ_FLAG_RELAXED_EOF;
> +    }
> +
>      while (true) {
>          uint32_t flags = 0;
>          bool has_data = false;
> @@ -1166,7 +1171,8 @@ static void *multifd_recv_thread(void *opaque)
>              }
>  
>              ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> -                                           p->packet_len, 0, &local_err);
> +                                           p->packet_len, p->read_flags,
> +                                           &local_err);
>              if (!ret) {
>                  /* EOF */
>                  assert(!local_err);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index bd785b9873..cf408ff721 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -244,6 +244,8 @@ typedef struct {
>      uint32_t zero_num;
>      /* used for de-compression methods */
>      void *compress_data;
> +    /* Flags for the QIOChannel */
> +    int read_flags;
>  } MultiFDRecvParams;
>  
>  typedef struct {
> diff --git a/migration/options.c b/migration/options.c
> index 1ad950e397..feda354935 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -99,6 +99,8 @@ const Property migration_properties[] = {
>                        clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
>      DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
>                       preempt_pre_7_2, false),
> +    DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
> +                     multifd_clean_tls_termination, true),
>  
>      /* Migration parameters */
>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
> -- 
> 2.35.3
> 

-- 
Peter Xu


