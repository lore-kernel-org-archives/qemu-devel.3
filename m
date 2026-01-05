Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E7DCD0402
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrxw-0007ZO-Ku; Mon, 05 Jan 2026 16:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrxu-0007Z7-QD
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrxs-0007DF-TM
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767647891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ez8OZT3TaUTTh0flEj5fT4zLhJU4DlIW/j27MbRhwEM=;
 b=gQq8bRrEG1JUvAhPURJNXEjzLY/tA6k+hQOplk1hR+au1nWA6HACx5g/Q5ZQf7TXEhkCek
 +9VPa+FmQuPdrt4EyPnlHMTymkwnxrgAoTjJG2P2sM0ra54iK3XRVCRxhP1KMUJsjRjUtT
 /mokNI4BrboY2Gp7OFT7bspGM9MoWyQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-Z8m0XmzxMCO8vqSTs5dNww-1; Mon, 05 Jan 2026 16:18:09 -0500
X-MC-Unique: Z8m0XmzxMCO8vqSTs5dNww-1
X-Mimecast-MFC-AGG-ID: Z8m0XmzxMCO8vqSTs5dNww_1767647889
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee3dfe072dso7160611cf.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767647889; x=1768252689; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ez8OZT3TaUTTh0flEj5fT4zLhJU4DlIW/j27MbRhwEM=;
 b=rmeK8Zrd1r6c8p9qr5FYf6JWajX00opkVI/i4iWElK33jrHNOTVorYGvGb5sLtJBC/
 pvKfqptQuz0Qq6LUxLxoBs/DC3dSB+Wc9eIeP3Jp/HutGi4U0KFF5mY5xLpaZFxjJjRy
 oHx96uLWzFx6LdAPKYJAfe87P4xz4+rd9nFypJ6OxUCC4POsYBwLOcTOE18pmmsMjVFj
 Nx+DV/gjAQfcVpx1rAsnnd9YdtNmPWeNp9U+0w9512b5cUv+0YR71HxEzWKwcTfyHIqF
 okdL3a3KS5C+9M+Cww+/vdfrV1UG4MJ6bx2M2tFDOIiQRTxRn3/5450ziDwN4dOnNJiv
 ehhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767647889; x=1768252689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ez8OZT3TaUTTh0flEj5fT4zLhJU4DlIW/j27MbRhwEM=;
 b=Kg5KWqO3EvpEovyGQQLZczhN4PI3Qov9+L9SxOqO4trf9SA5DY5GaLjWAdgL32TCTZ
 fOvkBVPUo6zaTGnPVxyGHP4TaahJn/yzXK6dgCYkAhNneNV6TBU/IOahl8366og0CA/3
 s7Rg20MdEhPmuGYgFUyyLaPrZN0bh+rUNlMnNbIYLrhgEUuC8zVoU/AbNyCrbSePuYob
 0KIg4MRWMAnHOSBB2wZzbg659rjGJB/HsvEFMxgagJrJ9BubJSSizyHOU4Snc1Sx4FSs
 s49FdqlAgqk/u283W/TeY+1vpxcqGTrlOLarSMZSX+rUO3G36AlSriPiPgXxEJ3kzeuY
 mZ3Q==
X-Gm-Message-State: AOJu0YzjlEyw7T7AxFWQ66HaoK+Q4P+XUpgsUVLqZ+g5rQ1IS3jG4XVg
 zXJyQjx6nhkJPqbGREMhbR2uvtVVw2QzmcvLz3BwsapRdlBvPJ6M1h0KcOdrdY4YP/ycxtfBwnI
 vFbEPgTnNt560LiTabs2htGQQM8LcD96SCSPZ2cxH0Z/1EMut8nxaRC38
X-Gm-Gg: AY/fxX5s4W8QKDxk4RdxeaPslJX/WyN5t1OMz3l05EJZI96aKFEzlCCcjOkSiKJyUcf
 c2GSzJ0g+7aYeQ/HFs+fawJB3FI81YS3rmiSaTUnibD2SeJL02xC8H7Fffu/q33Dd4/BMTKKmwN
 iXwC4vRlAi4lasOjRLr1YqggC74QIRXAu4ckKCKFH6em0kcfl5X6SYy0p3Q4jg0+WxOw8VZaXUD
 neVHumFk98/FMAqYJHlZ3C5TNzaDyj5gMEyEpi4jgu1hAbv+Q2IM1s4RXsMhyHpFeCStrxJfWd2
 iwaNiGDFYfruc6DSj+B1VykLIvbXdZjzvvroxjPcD4jxnAtY+uS0gt6xQvknxJg7RcMrRI39Ysf
 HGqI=
X-Received: by 2002:a05:622a:3c8:b0:4ed:3e3e:a287 with SMTP id
 d75a77b69052e-4ffa76d9db8mr12360311cf.24.1767647889013; 
 Mon, 05 Jan 2026 13:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE75G0PaEq/f0BFWqg6hAmGGaWnAe/DA+V/Q+ajuqTR4SZ9yD7eqEWlC2aYyNt6SjiiGCwVFA==
X-Received: by 2002:a05:622a:3c8:b0:4ed:3e3e:a287 with SMTP id
 d75a77b69052e-4ffa76d9db8mr12360031cf.24.1767647888467; 
 Mon, 05 Jan 2026 13:18:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4a9a19sm34008485a.1.2026.01.05.13.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:18:08 -0800 (PST)
Date: Mon, 5 Jan 2026 16:18:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 24/25] migration: Remove qmp_migrate_finish
Message-ID: <aVwqjod_ciTA3Vc0@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-25-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-25-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 05, 2026 at 04:06:41PM -0300, Fabiano Rosas wrote:
> After cleanups, the qmp_migrate_finish function is now just a call to
> migration_connect_outgoing(). Remove qmp_migrate_finish() and rename
> the qmp_migrate_finish_cb callback.
> 
> This also allows the cleanup at qmp_migrate_finish() to move to the
> top level along with everyting else.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick:

> ---
>  migration/migration.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a9d5f5880d..2991e01d65 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1997,15 +1997,18 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>      return true;
>  }
>  
> -static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
> -
> -static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
> -                                      GIOCondition cond,
> -                                      void *opaque)
> +static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
> +                                              GIOCondition cond, void *opaque)
>  {
> -    MigrationAddress *addr = opaque;
> +    MigrationState *s = migrate_get_current();
> +    Error *local_err = NULL;
> +
> +    migration_connect_outgoing(s, opaque, &local_err);
> +
> +    if (local_err) {
> +        migration_connect_error_propagate(s, local_err);
> +    }
>  
> -    qmp_migrate_finish(addr, NULL);
>      return G_SOURCE_REMOVE;
>  }
>  
> @@ -2059,10 +2062,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>       * connection, so qmp_migrate_finish will fail to connect, and then recover.
>       */
>      if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
> -        cpr_transfer_add_hup_watch(s, qmp_migrate_finish_cb, main_ch->addr);
> +        cpr_transfer_add_hup_watch(s, migration_connect_outgoing_cb,
> +                                   main_ch->addr);
>  
>      } else {
> -        qmp_migrate_finish(main_ch->addr, errp);
> +        migration_connect_outgoing(s, main_ch->addr, &local_err);

I definitely overlooked that here it used &local_err to replace errp when
looking at this patch the 1st time.  You did mention it in the commit
message on "move to the top level", good enough!  But maybe even better if
spelling it out on the error object being passed in the commit message too.

>      }
>  
>  out:
> @@ -2072,19 +2076,6 @@ out:
>      }
>  }
>  
> -static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
> -{
> -    MigrationState *s = migrate_get_current();
> -    Error *local_err = NULL;
> -
> -    migration_connect_outgoing(s, addr, &local_err);
> -
> -    if (local_err) {
> -        migration_connect_error_propagate(s, error_copy(local_err));
> -        error_propagate(errp, local_err);
> -    }
> -}
> -
>  void qmp_migrate_cancel(Error **errp)
>  {
>      /*
> -- 
> 2.51.0
> 

-- 
Peter Xu


