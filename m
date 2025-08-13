Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628A1C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 19:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umGnf-0005Qq-Ud; Wed, 13 Aug 2025 15:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umGnc-0005QW-QF
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 15:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umGnW-0001lJ-1q
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 15:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755111959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FDl/jsg6m4+WcEci0iUbUWigZQsVxCqGw37WOTKkqzE=;
 b=LX8hjlWDtaVaJmzffmN5T1vioHwUhjUL14ODIZphsU0S+bvIl9nx6xifCiux18BEe1tEka
 LG6YVwgbX5jy1ZfenAMLlt2RZ+KnGLwfXJ2hWf49q8nkrTEvGlYL/oLzTyA/cFVkk9mJh7
 4IecxlmvtUlUVEGcVx69EtoYI3EucoM=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-qSkLtwr-M2-nf9_pq09yHQ-1; Wed, 13 Aug 2025 15:05:55 -0400
X-MC-Unique: qSkLtwr-M2-nf9_pq09yHQ-1
X-Mimecast-MFC-AGG-ID: qSkLtwr-M2-nf9_pq09yHQ_1755111955
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-53b17393830so95368e0c.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 12:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755111955; x=1755716755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDl/jsg6m4+WcEci0iUbUWigZQsVxCqGw37WOTKkqzE=;
 b=PvlKmZOKhAueaFqXVex7bcJL2S21ZORdim1Yq9cNQzWi9QUVKRyRIB0pdBsGaEM1z+
 xjguJ/DVjV6jiRWUNzU5E4ciny7iKLNh1chd9mmHs1LfJ9rZO896x475BPy/qXp0LhWl
 YvDYbg9TwRTyZu+ZdCV764DhawJnrZ860y+VfkYNxUjq7BQYqIuIazV9h/9atuSk5BTF
 llpMEv7T/rUgtgsdwd+QR61gRC2PQXfpuAmmErvRIizxWg0tmynt+IX4m2rkNe9VwXjl
 XXOB73BBP772WOfCzpH1XoVDEc26QPAGrIGMsldZFc4zQOfsQ48dFIDcImoKFgppyrjw
 /upQ==
X-Gm-Message-State: AOJu0YwkU7GAeDXpCapPWFcxGVwG0j08igxw2RPTTL9rPJSxYCuk4ROs
 aWHIzinsiXuOx1LdeSwVDFcv2BD+GMnUmfUN5D/fjpvmr6eZlMUjiu+XT5a5hQH1zZiy/qc7xRj
 FhNKoFbj1o478asdIHJq0dq4YL0y2BxfvtPds5a+PDg455sWEEKr6/Pnc
X-Gm-Gg: ASbGnct9hxXHVHB6EI7RN+VX9Swk06xEy6qvoiiqokaBbeZ3NIe6RUyDJi8519glw6B
 LbUxUV9jYirY3JaD+H3t4zy+dANwvG3IdI/ZgKW2rrBE8LjTi2qcJwOMiILv+7+gJ3pfWNSZf47
 ph4ihmdWP6KsRciy1tWAOAivNAOQNSoivC7RWY2sYnvXr84UQ3ge7aY3RJJhKJ95deJoTUqaTUb
 Uy5NQDrb2S5APh1g25hopBTkKmzgvPFeG9UERbShIv+yFtTMALibXN/qTXUMMMglSdcaFSXLLdT
 /z9PZMpR/jdue7y/ntvQPyWw/QvCWhGA
X-Received: by 2002:a05:6122:218c:b0:537:3e51:eb98 with SMTP id
 71dfb90a1353d-53b18b3ad6emr91942e0c.12.1755111954851; 
 Wed, 13 Aug 2025 12:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJQVojbqKliEAnTnHilmEi8roWjvFCtXDOpLM/7l40v7lKO6SK7yHmAeSZtc4I1lEJqLPFSA==
X-Received: by 2002:a05:6122:218c:b0:537:3e51:eb98 with SMTP id
 71dfb90a1353d-53b18b3ad6emr91926e0c.12.1755111954469; 
 Wed, 13 Aug 2025 12:05:54 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70af5b0692csm1973986d6.46.2025.08.13.12.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 12:05:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:05:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 13/24] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
Message-ID: <aJziBqu6H9pnMmE7@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 30, 2025 at 04:59:02PM -0300, Fabiano Rosas wrote:
> Instead of setting parameters one by one, use the temporary object,
> which already contains the current migration parameters plus the new
> ones and was just validated by migration_params_check(). Use cloning
> to overwrite it.
> 
> This avoids the need to alter this function every time a new parameter
> is added.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 123 +++-----------------------------------------
>  1 file changed, 7 insertions(+), 116 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 4564db77f2..6619b5f21a 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -1341,123 +1342,13 @@ static void migrate_params_test_apply(MigrationParameters *params,
>  static void migrate_params_apply(MigrationParameters *params)
>  {
>      MigrationState *s = migrate_get_current();
> +    MigrationParameters *cur = &s->parameters;
>  
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> +    assert(bql_locked());
>  
> -    if (params->has_throttle_trigger_threshold) {
> -        s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
> -    }
> -
> -    if (params->has_cpu_throttle_initial) {
> -        s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
> -    }
> -
> -    if (params->has_cpu_throttle_increment) {
> -        s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
> -    }
> -
> -    if (params->has_cpu_throttle_tailslow) {
> -        s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
> -    }
> -
> -    if (params->tls_creds) {
> -        qapi_free_StrOrNull(s->parameters.tls_creds);
> -        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    }
> -
> -    if (params->tls_hostname) {
> -        qapi_free_StrOrNull(s->parameters.tls_hostname);
> -        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
> -                                                params->tls_hostname);
> -    }
> -
> -    if (params->tls_authz) {
> -        qapi_free_StrOrNull(s->parameters.tls_authz);
> -        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    }
> -
> -    if (params->has_max_bandwidth) {
> -        s->parameters.max_bandwidth = params->max_bandwidth;
> -    }
> -
> -    if (params->has_avail_switchover_bandwidth) {
> -        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> -    }
> -
> -    if (params->has_downtime_limit) {
> -        s->parameters.downtime_limit = params->downtime_limit;
> -    }
> -
> -    if (params->has_x_checkpoint_delay) {
> -        s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
> -    }
> -
> -    if (params->has_multifd_channels) {
> -        s->parameters.multifd_channels = params->multifd_channels;
> -    }
> -    if (params->has_multifd_compression) {
> -        s->parameters.multifd_compression = params->multifd_compression;
> -    }
> -    if (params->has_multifd_qatzip_level) {
> -        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
> -    }
> -    if (params->has_multifd_zlib_level) {
> -        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
> -    }
> -    if (params->has_multifd_zstd_level) {
> -        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
> -    }
> -    if (params->has_xbzrle_cache_size) {
> -        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
> -    }
> -    if (params->has_max_postcopy_bandwidth) {
> -        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
> -    }
> -    if (params->has_max_cpu_throttle) {
> -        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
> -    }
> -    if (params->has_announce_initial) {
> -        s->parameters.announce_initial = params->announce_initial;
> -    }
> -    if (params->has_announce_max) {
> -        s->parameters.announce_max = params->announce_max;
> -    }
> -    if (params->has_announce_rounds) {
> -        s->parameters.announce_rounds = params->announce_rounds;
> -    }
> -    if (params->has_announce_step) {
> -        s->parameters.announce_step = params->announce_step;
> -    }
> -
> -    if (params->has_block_bitmap_mapping) {
> -        qapi_free_BitmapMigrationNodeAliasList(
> -            s->parameters.block_bitmap_mapping);
> -
> -        s->has_block_bitmap_mapping = true;
> -        s->parameters.block_bitmap_mapping =
> -            QAPI_CLONE(BitmapMigrationNodeAliasList,
> -                       params->block_bitmap_mapping);
> -    }
> -
> -    if (params->has_x_vcpu_dirty_limit_period) {
> -        s->parameters.x_vcpu_dirty_limit_period =
> -            params->x_vcpu_dirty_limit_period;
> -    }
> -    if (params->has_vcpu_dirty_limit) {
> -        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
> -    }
> -
> -    if (params->has_mode) {
> -        s->parameters.mode = params->mode;
> -    }
> -
> -    if (params->has_zero_page_detection) {
> -        s->parameters.zero_page_detection = params->zero_page_detection;
> -    }
> -
> -    if (params->has_direct_io) {
> -        s->parameters.direct_io = params->direct_io;
> -    }
> +    migrate_tls_opts_free(cur);
> +    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);

So we free these without resetting the pointers.  Now, for example,
cur->tls_creds can point to garbage.  Then..

> +    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);

How does this patch guarantee cur->tls_creds's garbage pointer being
updated?  What if params->tls_creds is NULL?  Could it?

>  }
>  
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> @@ -1487,7 +1378,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>      }
>  
>      if (migrate_params_check(&tmp, errp)) {
> -        migrate_params_apply(params);
> +        migrate_params_apply(&tmp);
>          migrate_post_update_params(params, errp);
>      }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


