Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5BFC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 19:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rziTp-0003Fi-9x; Wed, 24 Apr 2024 15:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rziTn-0003FZ-As
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 15:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rziTk-0000yr-2h
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 15:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713987625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70EDjxU5QT5bdSHkmB5YG+v8NU9xwqvlS9mOFWJTIjA=;
 b=aeuNbzay5ykmlD3oHXGjzSXd00EUNiOLM/MJYlTAyMNPLOK2X3t01IM/BslF3C1JsrnB4F
 vZ7z3hWM0e+sRUgv6WpPd73K+VpkvJzRgQ5y8Yw2LDOtzY4tPhmtv51GFDsJDTEMWhP0qy
 bqQVICrpypIOsyt9bhw9crNFT3t1ciw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-V17gufiZO3mfNpzscp30ZA-1; Wed, 24 Apr 2024 15:40:23 -0400
X-MC-Unique: V17gufiZO3mfNpzscp30ZA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5acdbfb49daso48419eaf.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 12:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713987623; x=1714592423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70EDjxU5QT5bdSHkmB5YG+v8NU9xwqvlS9mOFWJTIjA=;
 b=kue7iU03acHJXHN8rfLPwhjlOG4s7cUdFCEJ+d8zY/JglUK8bDhz1n65fXH8k1gQF5
 3f4raWoLM5hVRc7UNkmQImU621GrmPV5m2IFhBcJ0dnpu8e6QrBODeJ5DJIq7/1Rz/9N
 vIdVRbZHBxudBvQ2yRHYaLUb0OfMB7lV1+LmupRwRh5L1Ibwdh2O2SwcTYjZ80cumuPk
 hHSzHvbDuviI9+QFwGTaAkAFlNYOdqPC8r7QdDyRexQi9t5Mlf8P7YHwzdJLI5z9U5jB
 yKCqR2Mq0fi6RmfXZ1FWyPzUBryEUw4iUTlIqbLglTTWIxY1iQr5E9bYcON/6T92AFjZ
 pBgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWTjILFmhLVWThFAsdgMzq8WDSir4F4DdoHQd0uawhiGBOHzj4KXC/dAiOqsnIe6mraFN3v/aY2jfXvWc1zzJV8kt53Io=
X-Gm-Message-State: AOJu0Yz5+660Nz918rQ7NibwXPcQoaa0CNSa28KGDjyRCWvX1jbyAA40
 bBxJgtshOTOe2fuvg1/8aUFVAD1K/qNYslWVGmEHtF+VtMz8Oaah0v3NNPNfqzEfK8VbHLn4i7e
 RIvORPGq9gTygc1bM9jEh4I8kS1UoLN6d6RWCnC3PL3LdSVEeFWHB
X-Received: by 2002:a05:6358:4285:b0:18b:3814:bf4 with SMTP id
 s5-20020a056358428500b0018b38140bf4mr4586110rwc.3.1713987620290; 
 Wed, 24 Apr 2024 12:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFftg9/R41qaNw3dqmzKgmKou0fzefB4KfuTPHRS2CrFytcLiaDNB9qX3rRhMpEPCSiBWK10g==
X-Received: by 2002:a05:6358:4285:b0:18b:3814:bf4 with SMTP id
 s5-20020a056358428500b0018b38140bf4mr4586083rwc.3.1713987619731; 
 Wed, 24 Apr 2024 12:40:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o20-20020ac86d14000000b0043842dc662esm5089595qtt.4.2024.04.24.12.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 12:40:19 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:40:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v2 1/2] migration: rework migrate_set_error() to
 migrate_report_err()
Message-ID: <ZilgISOGWfODZvMC@x1n>
References: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
 <20240424174245.1237942-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424174245.1237942-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 24, 2024 at 08:42:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 1. Most of callers want to free the error after call. Let's help them.
> 
> 2. Some callers log the error, some not. We also have places where we
>    log the stored error. Let's instead simply log every migration
>    error.
> 
> 3. Some callers have to retrieve current migration state only to pass
>    it to migrate_set_error(). In the new helper let's get the state
>    automatically.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/migration.c    | 48 ++++++++++++----------------------------
>  migration/migration.h    |  2 +-
>  migration/multifd.c      | 18 ++++++---------
>  migration/postcopy-ram.c |  3 +--
>  migration/savevm.c       | 16 +++++---------
>  5 files changed, 28 insertions(+), 59 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 696762bc64..806b7b080b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -285,7 +285,7 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
>  void migration_cancel(const Error *error)
>  {
>      if (error) {
> -        migrate_set_error(current_migration, error);
> +        migrate_report_err(error_copy(error));
>      }
>      if (migrate_dirty_limit()) {
>          qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
> @@ -779,13 +779,6 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> -        MigrationState *s = migrate_get_current();
> -
> -        if (migrate_has_error(s)) {
> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -                error_report_err(s->error);
> -            }
> -        }
>          error_report("load of migration failed: %s", strerror(-ret));
>          goto fail;
>      }
> @@ -1402,10 +1395,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>                            MIGRATION_STATUS_CANCELLED);
>      }
>  
> -    if (s->error) {
> -        /* It is used on info migrate.  We can't free it */
> -        error_report_err(error_copy(s->error));
> -    }
>      type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
>                                       MIG_EVENT_PRECOPY_DONE;
>      migration_call_notifiers(s, type, NULL);
> @@ -1418,12 +1407,14 @@ static void migrate_fd_cleanup_bh(void *opaque)
>      migrate_fd_cleanup(opaque);
>  }
>  
> -void migrate_set_error(MigrationState *s, const Error *error)
> +void migrate_report_err(Error *error)
>  {
> +    MigrationState *s = migrate_get_current();

Avoid passing in *s looks ok.

>      QEMU_LOCK_GUARD(&s->error_mutex);
>      if (!s->error) {
>          s->error = error_copy(error);

I think I get your point, but then looks like this error_copy() should be
removed but forgotten?

I remember I had an attempt to do similarly (but only transfer the
ownership):

https://lore.kernel.org/qemu-devel/20230829214235.69309-3-peterx@redhat.com/

However I gave up later and I forgot why.  One reason could be that I hit a
use-after-free, then found that well indeed leaking an Error is much better
than debugging a UAF.

So maybe we simply keep it like before?  If you like such change, let's
just be extremely caucious.

>      }
> +    error_report_err(error);

The ideal case to me is we don't trigger an error_report() all over the
place.  We're slightly going backward from that regard, IMHO..

Ideally I think we shouldn't dump anything to stderr, but user should
always query from qmp.

Thanks,

-- 
Peter Xu


