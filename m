Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44583C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 19:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2FkT-0003d6-PN; Wed, 01 May 2024 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FkS-0003cb-5r
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FkO-0006ge-Ay
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714592167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3ezuYrBmJ7Dn8MvWs4Rmbg0MbY9CjnwQVl4oNmhbCw=;
 b=ITNv/fSKsUW5qnxrJJucexlrojcqVRZGydAsK567LF5JV/NLYozis+2dERzeoy6X2xHUtb
 XJ0v9ZqXJ0HapDM90d5OHhrcMNhb7ryCiI6qTh8SulNaK1Fg8s/SJ/uZOc5kIZk5xlxDle
 2MYA6sMsg1S2KzSA8EVRlh8sbLA/V0U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-3YY7nYFlPFiDDUs1NWSxaQ-1; Wed, 01 May 2024 15:36:05 -0400
X-MC-Unique: 3YY7nYFlPFiDDUs1NWSxaQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78f081986baso85503685a.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 12:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714592165; x=1715196965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3ezuYrBmJ7Dn8MvWs4Rmbg0MbY9CjnwQVl4oNmhbCw=;
 b=JwDsXgT0WsUkTojLQGJY9iGQfaL1be9EtsHomfVzYrTDgMuGux5ZmUGN9tdxA0+CnN
 RlSd32oap6HuCsG+rSySblrZReXzvtabfD8P6dkYJEyXuQf7huaKxatmznPkpXvUh9nc
 JapcT37r4H3qJ61sA9+6cOG21U8GPYzbH6XoQ14hiFiRgqdINsLElxDTZr1Nn4ruLr1r
 K+xvh+2AfSI9GsnL1i7Y6iLNMo39BZfw4g/xk2PfLtx1WS0sjx40zrBwduMNi2rWBh+z
 d3inl26vMnNvRZA2VJO4wg5AaKQRR58Ug/eWWmHFywzEQputoEYk8Kv6KD0RCt/thR0S
 P+2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaiDMXiK4zFHgzJBT9yXuQo9ofGEQ3vzd3SMyUEPQ+8K8aMmYvcn02OeLuVErs8aF53CJu5+Zt7QPT6tVFSjDS6fD4NV8=
X-Gm-Message-State: AOJu0YwD9eGptgx8ystpLMF162EHam3lMmSfTQL6CDgGw1lvtN3gjvJ7
 /AzNyspLwagBSI1akXLkZ5i/8Wm+p3GhyDeF3hFNhr9TDjx08YbIxH7y7HDO09/oepzPmcLSCI/
 ycaedGqKvWhIGxA+V9t1ZNZytgnahssWRaAolgcUvk3SI0G8HVkzh
X-Received: by 2002:a05:620a:45a2:b0:790:eb3b:eec with SMTP id
 bp34-20020a05620a45a200b00790eb3b0eecmr3963117qkb.2.1714592164905; 
 Wed, 01 May 2024 12:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLIs9u3rRdo8DLYkqLZazmYWQ1i8uNwi9jGiw1bXybpfvN++1ET1wZ9E2wy0LuGVgzH0+RYQ==
X-Received: by 2002:a05:620a:45a2:b0:790:eb3b:eec with SMTP id
 bp34-20020a05620a45a200b00790eb3b0eecmr3963075qkb.2.1714592164143; 
 Wed, 01 May 2024 12:36:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 vr2-20020a05620a55a200b00790a2e12dc8sm5769483qkn.116.2024.05.01.12.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 12:36:03 -0700 (PDT)
Date: Wed, 1 May 2024 15:36:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, farosas@suse.de, armbru@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 11/14] migration/multifd: Add migration option set
 packet size.
Message-ID: <ZjKZof0M6rrGmwjL@x1n>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-12-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-12-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Thu, Apr 25, 2024 at 02:21:14AM +0000, Hao Xiang wrote:
> The current multifd packet size is 128 * 4kb. This change adds
> an option to set the packet size. Both sender and receiver needs
> to set the same packet size for things to work.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  migration/options.c | 36 ++++++++++++++++++++++++++++++++++++
>  migration/options.h |  1 +
>  qapi/migration.json | 21 ++++++++++++++++++---
>  3 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index dc8642df81..a9deb079eb 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -79,6 +79,12 @@
>  #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
>  #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
>  
> +/*
> + * Parameter for multifd packet size.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
> +#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1023 * 4 * 1024)
> +
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>  
> @@ -184,6 +190,9 @@ Property migration_properties[] = {
>                         ZERO_PAGE_DETECTION_MULTIFD),
>      DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
>                         parameters.multifd_dsa_accel),
> +    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
> +                     parameters.multifd_packet_size,
> +                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),

Having such knob looks all fine, but I feel like this patch is half-baked,
no?  There seems to have another part in the next patch.  Maybe they need
to be squashed together.

>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -879,6 +888,13 @@ int migrate_multifd_channels(void)
>      return s->parameters.multifd_channels;
>  }
>  
> +uint64_t migrate_multifd_packet_size(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.multifd_packet_size;
> +}
> +
>  MultiFDCompression migrate_multifd_compression(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1031,6 +1047,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
>      params->has_block_incremental = true;
>      params->block_incremental = s->parameters.block_incremental;
> +    params->has_multifd_packet_size = true;
> +    params->multifd_packet_size = s->parameters.multifd_packet_size;
>      params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
>      params->has_multifd_compression = true;
> @@ -1094,6 +1112,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
>      params->has_block_incremental = true;
> +    params->has_multifd_packet_size = true;
>      params->has_multifd_channels = true;
>      params->has_multifd_compression = true;
>      params->has_multifd_zlib_level = true;
> @@ -1195,6 +1214,17 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  
>      /* x_checkpoint_delay is now always positive */
>  
> +    if (params->has_multifd_packet_size &&
> +        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
> +            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE) ||
> +            (params->multifd_packet_size % qemu_target_page_size() != 0))) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                    "multifd_packet_size",
> +                    "a value between 524288 and 4190208, "

We should reference the macros here.

> +                    "must be a multiple of guest VM's page size.");
> +        return false;
> +    }
> +
>      if (params->has_multifd_channels && (params->multifd_channels < 1)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     "multifd_channels",
> @@ -1374,6 +1404,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_block_incremental) {
>          dest->block_incremental = params->block_incremental;
>      }
> +    if (params->has_multifd_packet_size) {
> +        dest->multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          dest->multifd_channels = params->multifd_channels;
>      }
> @@ -1524,6 +1557,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>                      " use blockdev-mirror with NBD instead");
>          s->parameters.block_incremental = params->block_incremental;
>      }
> +    if (params->has_multifd_packet_size) {
> +        s->parameters.multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          s->parameters.multifd_channels = params->multifd_channels;
>      }
> diff --git a/migration/options.h b/migration/options.h
> index 1cb3393be9..23995e6608 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -92,6 +92,7 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  const char *migrate_multifd_dsa_accel(void);
> +uint64_t migrate_multifd_packet_size(void);
>  
>  /* parameters setters */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 934fa8839e..39d609c394 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -920,6 +920,10 @@
>  #     characters. Setting this string to an empty string means disabling
>  #     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest VM's page size.

Maybe just call it "guest page size".

> +#     The default value is 524288 and max value is 4190208. (Since 9.2)

IMHO we can avoid mentioning these in QAPI.  This will be a very, very,
developer oriented value: if the default isn't the best to the majority of
people, we should change the default.  Not easy for an admin to understand
what is this about.

I'm even thinking whether we should only expose it via one migration debug
option (-global migration.multifd-packet-size only), rather exporting it in
QMP or even HMP.  Or do you want this actually to be tunable for real?

> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -954,7 +958,8 @@
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
>             'mode',
> -           'zero-page-detection'] }
> +           'zero-page-detection',
> +           'multifd-packet-size'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1134,6 +1139,10 @@
>  #     characters. Setting this string to an empty string means disabling
>  #     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest VM's page size.
> +#     The default value is 524288 and max value is 4190208. (Since 9.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1189,7 +1198,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*multifd-dsa-accel': 'StrOrNull'} }
> +            '*multifd-dsa-accel': 'StrOrNull',
> +            '*multifd-packet-size' : 'uint64'} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1373,6 +1383,10 @@
>  #     characters. Setting this string to an empty string means disabling
>  #     DSA accelerator offloading. Defaults to an empty string. (since 9.2)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest VM's page size.
> +#     The default value is 524288 and max value is 4190208. (Since 9.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1425,7 +1439,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*multifd-dsa-accel': 'str'} }
> +            '*multifd-dsa-accel': 'str',
> +            '*multifd-packet-size': 'uint64'} }
>  
>  ##
>  # @query-migrate-parameters:
> -- 
> 2.30.2
> 
> 

-- 
Peter Xu


