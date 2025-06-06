Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B100C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZ11-0003iA-AB; Fri, 06 Jun 2025 11:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNZ0y-0003hk-N5
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNZ0x-0000U3-5R
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749223789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g1rLBVmmwtzcGtQeXXpcni6kRPHbqy7xWU4y65nGhgw=;
 b=fbHA3nauBQmt5fXkRYtP00Yh6EC9g64CJuK4yUiaqSFgbyZUCj35KscEQiSWvW2YoZfsCk
 OT0QS4VBnRT9+bz4uMAJhU44USWBTqSWFewA0WV6X4qYIR4pbBdPxO0tcNvk07KsMRE5Pp
 Cs6WiASd657Oc1mPa/fdtL9ONAQbZvk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BsCKZNGdP2-3kH4T60nmbA-1; Fri, 06 Jun 2025 11:29:48 -0400
X-MC-Unique: BsCKZNGdP2-3kH4T60nmbA-1
X-Mimecast-MFC-AGG-ID: BsCKZNGdP2-3kH4T60nmbA_1749223788
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a43988c314so35321491cf.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749223788; x=1749828588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1rLBVmmwtzcGtQeXXpcni6kRPHbqy7xWU4y65nGhgw=;
 b=rdgtu9s6fDKLNOL7ptfM/+ve9msoM8GvDZSe+dT7NYQ4OrzZRArQ40rw/NrBtSbMHZ
 t1p4lz8qTRGH2T+MyHugUehQYx1+wswsOkz1RpsqickISeJx5EqK9k/fI3lMlWd1PmcQ
 UIQGaoi1GAo7r2Yr9f8MyxkMBdUH4OIz/lUInlllYQaYy+R9GAm+SN89e5UOdhAXQ1uT
 4bXN3HHS0oPSpe+fcNdjsnzcgOkhkqvnaZdGXaOg8XBzEXhl8IATYuPzVxzn7XPVUnL4
 eviuaHE+13FiDQBgio0ij14jhD0PKQzDqQLGNTydoc7QkT0+StjrqTHxIxFcCn+NIaHQ
 0pKg==
X-Gm-Message-State: AOJu0Yw+GW4dKTBY5PEE7oGzgz4mi8c3ZEi4uGNmeJzt2oJVX/XK7wtX
 bDLUuaf1R9hrsldoJKp80Ec1j1vyWKHXHQqgsYyTLuJ8Usu2jV5p2135+70oVbEPd2/855eiwyA
 beMOA1qUPslgc+S9YpXhse5YQuUpKnHW7ZcDSEUKfBNOyQQAoWE9FVUC1Xwlfvrma
X-Gm-Gg: ASbGncv1jXfEAa50GU3naOA61UGvvgTOHnNQC6EO5V/6XqcGKAdKlPxFibUZKQ+oquw
 g2qA33kiM4RLUSKzm+TTsYg322q0qoj6qAqRQ/kkdfa4xSy8axjhJWhJArbhEarxGxJ41t7X4RA
 jR7uxedzov8TstUUU9SmuAywb9u/52B+A2wK4um5r/Ie8LF03iqMVhWmGWck8/05pw96RQ3Tb6o
 2saP9DxSup0JBg7tWepGgwCND56Y331v3Z00ClwEdAIDGKPe7JaFhAOZRpeuwfDHFEEh0+zmbEK
 rYy5OEzxop1zNQ==
X-Received: by 2002:a05:6214:f2a:b0:6fa:ccb6:603d with SMTP id
 6a1803df08f44-6fb08f560bcmr64274076d6.16.1749223788012; 
 Fri, 06 Jun 2025 08:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHefazEO0zqBtBNOQv9nqr5EwfAutLj3hfjJgYxWbJjHzezlqLrSwLFZq0si6D+jMj1cpn4qg==
X-Received: by 2002:a05:6214:f2a:b0:6fa:ccb6:603d with SMTP id
 6a1803df08f44-6fb08f560bcmr64273746d6.16.1749223787670; 
 Fri, 06 Jun 2025 08:29:47 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac84cbsm12605096d6.32.2025.06.06.08.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:29:47 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:29:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 10/21] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
Message-ID: <aEMJacJqDHLrdkgn@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 02, 2025 at 10:37:59PM -0300, Fabiano Rosas wrote:
> QAPI_CLONE_MEMBERS is a better option than copying parameters one by
> one because it operates on the entire struct and follows pointers. It
> also avoids the need to alter this function every time a new parameter
> is added.
> 
> Note, since this is a deep clone, now we must free the TLS strings
> before assignment.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index dd62e726cb..0a2a3050ec 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -918,7 +918,9 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
>  {
>      StrOrNull *dst = *dstp;
>  
> -    assert(!dst);
> +    if (dst) {
> +        qapi_free_StrOrNull(dst);
> +    }
>  
>      dst = *dstp = g_new0(StrOrNull, 1);
>      dst->type = QTYPE_QSTRING;
> @@ -975,42 +977,17 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      MigrationParameters *params;
>      MigrationState *s = migrate_get_current();
>  
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
>      params = g_malloc0(sizeof(*params));
>  
> -    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
> -    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
> -    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
> -    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
> +    QAPI_CLONE_MEMBERS(MigrationParameters, params, &s->parameters);
>  
>      tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
>      tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
>      tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
>  
> -    params->max_bandwidth = s->parameters.max_bandwidth;
> -    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
> -    params->downtime_limit = s->parameters.downtime_limit;
> -    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
> -    params->multifd_channels = s->parameters.multifd_channels;
> -    params->multifd_compression = s->parameters.multifd_compression;
> -    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
> -    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
> -    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
> -    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
> -    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
> -    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
> -    params->announce_initial = s->parameters.announce_initial;
> -    params->announce_max = s->parameters.announce_max;
> -    params->announce_rounds = s->parameters.announce_rounds;
> -    params->announce_step = s->parameters.announce_step;
>      params->block_bitmap_mapping =
>          QAPI_CLONE(BitmapMigrationNodeAliasList,
>                     s->parameters.block_bitmap_mapping);

Wouldn't the QAPI_CLONE_MEMBERS() have deep cloned this too?

> -    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
> -    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
> -    params->mode = s->parameters.mode;
> -    params->zero_page_detection = s->parameters.zero_page_detection;
> -    params->direct_io = s->parameters.direct_io;
>  
>      /*
>       * query-migrate-parameters expects all members of
> -- 
> 2.35.3
> 

-- 
Peter Xu


