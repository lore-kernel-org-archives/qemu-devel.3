Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44978D37E3F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2WJ-0000VY-Hf; Wed, 14 Jan 2026 10:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2WG-0000UZ-KQ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2WD-0003vF-Vl
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768403443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkl1gws/f6nsZwpuV5YHMsh3uk6pHpsoLM4nHmie4mA=;
 b=hDYXyryo62UIdIToyYe8yUS1ycJLDeAL5vq4/XfjLtwbV1RVUv/HUUCS0MPxCW/iEUJ/qr
 aUwrHvbIwq39sJ8kHAdzuigUcl+lP5+AFoei59xNJAny97rqbsMOqKFa+cM4EVW7C1HU/N
 X0+cKkjuV8TNGOsc/HFiPEGgFXSEWsU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-MMjxAmobMR2cTE3v8qCcmA-1; Wed, 14 Jan 2026 10:10:42 -0500
X-MC-Unique: MMjxAmobMR2cTE3v8qCcmA-1
X-Mimecast-MFC-AGG-ID: MMjxAmobMR2cTE3v8qCcmA_1768403441
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a3a4af701so239361516d6.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768403441; x=1769008241; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kkl1gws/f6nsZwpuV5YHMsh3uk6pHpsoLM4nHmie4mA=;
 b=AUssYRwZucJoijlgkF1ON7MN/CcTZOAJEHGgOQu97ziiSHiS0sdbuP0Lu8nHtp1DZ7
 495WC4QzTqd7RRasVJBrOmXaRcrHrJvXn4H/M5HAdyHtt20/CujOLDPNE3Cwt78uAyNW
 +lx8W5Rs3F+LRmFBbLcwAmjO6V1vQkubNMaD86Mo957qzhcvwks7XqKLdc/FwscIBZDX
 u7uikvyYzysyT41IFkSxN3l/hHz+Td0EklhaSg0eGiq9aBRE52GNanSSeeFGYMlS4g6w
 aW4f6AZlrFvebabaofM8lYJHY2KJFc2JuL5rJ/vRcvUbqb2iHVsFDsjghh7a1Dh2jW/m
 4EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403441; x=1769008241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkl1gws/f6nsZwpuV5YHMsh3uk6pHpsoLM4nHmie4mA=;
 b=O+N2SfEET+g0pXlKzMB8viqTj94zfDCT3z2IMDFgy5g5MYEzJovqmISb2m4z3VW0ow
 1MvHwaWv7svAMhXX91jKy8UNd1l8hIe7zhoanAs91zk9Cc66JXQ5algEaOPO3ibQ3y8t
 770K2dGu2CpGMDFSQj5ou5qu3VPJp/tYDzRM4CQjWM0NoGogHBHHTlXrwUrgT9rk2W3P
 atC1pmLEtFkW3PTmF4lORCGYnpfYUilsB8NOTfXkx6q1l4wtDFxyPZzxH51kIEhRrdt1
 TWJeiKhgvMmuAQyL8AbM35JJI77Y3PB74DqA1vNmUr+1NuYGGpfmYgb23ZHcRO155zAI
 USEg==
X-Gm-Message-State: AOJu0Yzc0nuJLtBZmaX3bJuIcaUGMaQzpoRo/NNR4GZx7anIc27l74RW
 7PAeckaubWcQSLqIjDtxln9LghlqGBwFNQXpDgQiPn7VzDyhLUq9tzdWH7K9eiWJ9rNnMUfML/5
 yv5VoSV6FIUGntzhDGUfp/BboeoHuf8HDrboUf2dgjoe2rGNcAIN5yQ1d
X-Gm-Gg: AY/fxX6q6HfbIEXeNGl6N7STvS7O2p23ICpZeRQP5xwkj438ByMJAPkOyqYXtFgKSY4
 SEh7er25nNa/uusQgFV5Mt9DBV6Nc/RQEQZ20k9xLaI6Oq7HuTjeTr6CQe6aVkx4+Zo4vQn94FO
 5TxV/WxTCt12tYOPIxjQHhJikZZa8aiyCIOUUATpy/jk08f9bqy/+b+7/e8TY4T5gxlETjtnKb9
 PEczUfNWKFEzXkvbxZaOmxbMa3Wdpjbd0V9GEZ/poenmM7Ac9aVtxvWQrMgNj3+HAxEAm+va5PY
 95shMmcOubF4Hf/CvNjLOkfUM5amHFtGbiRJ5RgrW6KUEqOUdiXMTZyIkqmByRyNGd5IeHCdRBD
 F5IA=
X-Received: by 2002:a05:6214:250d:b0:884:6f86:e08c with SMTP id
 6a1803df08f44-89274380bbemr34882386d6.21.1768403441292; 
 Wed, 14 Jan 2026 07:10:41 -0800 (PST)
X-Received: by 2002:a05:6214:250d:b0:884:6f86:e08c with SMTP id
 6a1803df08f44-89274380bbemr34881626d6.21.1768403440686; 
 Wed, 14 Jan 2026 07:10:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907724ef14sm180394676d6.38.2026.01.14.07.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:10:40 -0800 (PST)
Date: Wed, 14 Jan 2026 10:10:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH 1/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Message-ID: <aWex7yI4jIoYXEjp@x1.local>
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114132309.5832-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 14, 2026 at 10:23:05AM -0300, Fabiano Rosas wrote:
> Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
> method makes the handling of the TLS strings more intuitive because it
> clones them as well.

The cover letter said this patch didn't change, but it has changed at least
somewhere.. anyway, I'm re-reviewing every line here.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..994e1cc5ac 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1264,9 +1264,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  static void migrate_params_test_apply(MigrationParameters *params,
>                                        MigrationParameters *dest)
>  {
> -    *dest = migrate_get_current()->parameters;
> +    MigrationState *s = migrate_get_current();
>  
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> +    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
>  
>      if (params->has_throttle_trigger_threshold) {
>          dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
> @@ -1285,24 +1285,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->tls_creds) {
> +        qapi_free_StrOrNull(dest->tls_creds);
>          dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_creds = NULL;
>      }
>  
>      if (params->tls_hostname) {
> +        qapi_free_StrOrNull(dest->tls_hostname);
>          dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_hostname = NULL;
>      }
>  
>      if (params->tls_authz) {
> +        qapi_free_StrOrNull(dest->tls_authz);
>          dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_authz = NULL;
>      }
>  
>      if (params->has_max_bandwidth) {
> @@ -1359,8 +1353,9 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->has_block_bitmap_mapping) {
> -        dest->has_block_bitmap_mapping = true;
> -        dest->block_bitmap_mapping = params->block_bitmap_mapping;
> +        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
> +        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
> +                                                params->block_bitmap_mapping);
>      }
>  
>      if (params->has_x_vcpu_dirty_limit_period) {
> @@ -1384,7 +1379,8 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->has_cpr_exec_command) {
> -        dest->cpr_exec_command = params->cpr_exec_command;
> +        qapi_free_strList(dest->cpr_exec_command);
> +        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
>      }
>  }

So we have 5 special cases here, (1-3) for tls, (4) for block bitmap, (5)
for cpr-exec-cmd.  All good.

>  
> @@ -1535,6 +1531,14 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>      migrate_params_test_apply(params, &tmp);
>  
>      if (migrate_params_check(&tmp, errp)) {
> +        /*
> +         * Mark block_bitmap_mapping as present now while we have the
> +         * params structure with the user input around.
> +         */
> +        if (params->has_block_bitmap_mapping) {
> +            migrate_get_current()->has_block_bitmap_mapping = true;
> +        }

Now I'm looking at the lastest master branch, we have:

migrate_params_apply():
    if (params->has_block_bitmap_mapping) {
        qapi_free_BitmapMigrationNodeAliasList(
            s->parameters.block_bitmap_mapping);

        s->has_block_bitmap_mapping = true;
        s->parameters.block_bitmap_mapping =
            QAPI_CLONE(BitmapMigrationNodeAliasList,
                       params->block_bitmap_mapping);
    }

Do we really need above change?

> +
>          migrate_params_apply(params);
>          migrate_post_update_params(params, errp);
>      }

The other thing is, when reaching here, after we have all 5 special cases
dynamically allocated, do we need to always free it?

We used to do it for the initial (1-3) for tls (in migrate_tls_opts_free()).
I think we should also free (4,5) now from &tmp?

> -- 
> 2.51.0
> 

-- 
Peter Xu


