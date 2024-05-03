Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152BFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xIT-0006uM-DK; Fri, 03 May 2024 14:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2xIR-0006tk-C0
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2xIL-0007KU-6c
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714759562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKk7nMNp+OcZQ8oycddE12M3/iM7zbBVbrUuw2IUczo=;
 b=Sb2u8cH+fz3eD0HSdmduWaqTl6V4REi4YiM9RLoTbOJaCo+kD7F3CKqcQ/M1oWhU3yWDhc
 JrFnoreOjAXIvjEJyOW3s3vlGlpAQCP5BVXqhJYIGa+oguU5y+lHI0Bbbb3AsdAbU/SCWl
 zaLt3/usLDY3eOp01Mg286/9a0keZn0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-r3sEn2VfO4a6AW7Q8jH8og-1; Fri, 03 May 2024 14:05:58 -0400
X-MC-Unique: r3sEn2VfO4a6AW7Q8jH8og-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4379bbdc9b4so33773121cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714759557; x=1715364357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKk7nMNp+OcZQ8oycddE12M3/iM7zbBVbrUuw2IUczo=;
 b=qVI4O8GiOs1qdssGUMiOAzX5QTPxv19lZs5fVtmV+M2hyGidrUnqhrn/+zrtC9HspT
 aA6w+ar/W4cE30tz1VfBb633DSRF7sRG0sjM0pccUkvA1xbw95EH5fe3dEdymwXUZpzp
 e014YFgcZS4QCay26MjF4lC+zahbKd4OBQZUL2xWUUeE/7mvpoE1QXyb1UgGgqtFetcz
 JL7Zk5mlw+DHbh8xFRNwCsM+zkQgSGvkYWqkbfKoHpfIwBjZkn/rCFow+CfUys/8fyK7
 ldjzsifKQ4IwV6hTTf6TtS3lx6zBK1bkNhid4sqf3Kc+bLluAdn6rUUObOolwO4yfcYi
 8EkA==
X-Gm-Message-State: AOJu0YwjxcwJ83RIQyusvxpx0aRWLI5VpmMbeCvZkXuLWaEqMNCs3s3/
 3Ms4vpivsCvofpU1Mf+QubggiB6FENAoFV0tuU+q5Uc5rE5QNSJSFhJM6evgwwGBSdQObgA7X2I
 v26KSY/+qk0E20iLbbYqEA3ErkxU8WCZqVFP+n5flzV20nEdzI//FX/MDhiro
X-Received: by 2002:a05:622a:285:b0:43b:e8:3858 with SMTP id
 z5-20020a05622a028500b0043b00e83858mr3673907qtw.5.1714759556798; 
 Fri, 03 May 2024 11:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/3GD4B1mNygxLVKuTtF9MvvDkc1YObSpPQGGnFRGsL6Foxbfc5PLJvGk95LtHwIhanAa9Jg==
X-Received: by 2002:a05:622a:285:b0:43b:e8:3858 with SMTP id
 z5-20020a05622a028500b0043b00e83858mr3673860qtw.5.1714759556102; 
 Fri, 03 May 2024 11:05:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cp4-20020a05622a420400b0043c64a65454sm1812995qtb.0.2024.05.03.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 11:05:55 -0700 (PDT)
Date: Fri, 3 May 2024 14:05:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
Message-ID: <ZjUnghSvdy-wWtnN@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
> Add the direct-io migration parameter that tells the migration code to
> use O_DIRECT when opening the migration stream file whenever possible.
> 
> This is currently only used with the mapped-ram migration that has a
> clear window guaranteed to perform aligned writes.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qemu/osdep.h           |  2 ++
>  migration/migration-hmp-cmds.c | 11 +++++++++++
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 18 +++++++++++++++---
>  util/osdep.c                   |  9 +++++++++
>  6 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index c7053cdc2b..645c14a65d 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>  bool qemu_has_ofd_lock(void);
>  #endif
>  
> +bool qemu_has_direct_io(void);
> +
>  #if defined(__HAIKU__) && defined(__i386__)
>  #define FMT_pid "%ld"
>  #elif defined(WIN64)
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6ffd..8496a2b34e 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>              qapi_enum_lookup(&MigMode_lookup, params->mode));
> +
> +        if (params->has_direct_io) {
> +            monitor_printf(mon, "%s: %s\n",
> +                           MigrationParameter_str(
> +                               MIGRATION_PARAMETER_DIRECT_IO),
> +                           params->direct_io ? "on" : "off");
> +        }

This will be the first parameter to optionally display here.  I think it's
a sign of misuse of has_direct_io field..

IMHO has_direct_io should be best to be kept as "whether direct_io field is
valid" and that's all of it.  It hopefully shouldn't contain more
information than that, or otherwise it'll be another small challenge we
need to overcome when we can remove all these has_* fields, and can also be
easily overlooked.

IMHO what we should do is assert has_direct_io==true here too, meanwhile...

>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -690,6 +697,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_mode = true;
>          visit_type_MigMode(v, param, &p->mode, &err);
>          break;
> +    case MIGRATION_PARAMETER_DIRECT_IO:
> +        p->has_direct_io = true;
> +        visit_type_bool(v, param, &p->direct_io, &err);
> +        break;
>      default:
>          assert(0);
>      }
> diff --git a/migration/options.c b/migration/options.c
> index 239f5ecfb4..ae464aa4f2 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -826,6 +826,22 @@ int migrate_decompress_threads(void)
>      return s->parameters.decompress_threads;
>  }
>  
> +bool migrate_direct_io(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    /* For now O_DIRECT is only supported with mapped-ram */
> +    if (!s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM]) {
> +        return false;
> +    }
> +
> +    if (s->parameters.has_direct_io) {
> +        return s->parameters.direct_io;
> +    }
> +
> +    return false;
> +}
> +
>  uint64_t migrate_downtime_limit(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1061,6 +1077,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->has_zero_page_detection = true;
>      params->zero_page_detection = s->parameters.zero_page_detection;
>  
> +    if (s->parameters.has_direct_io) {
> +        params->has_direct_io = true;
> +        params->direct_io = s->parameters.direct_io;
> +    }
> +
>      return params;
>  }
>  
> @@ -1097,6 +1118,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_vcpu_dirty_limit = true;
>      params->has_mode = true;
>      params->has_zero_page_detection = true;
> +    params->has_direct_io = qemu_has_direct_io();
>  }
>  
>  /*
> @@ -1416,6 +1438,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_zero_page_detection) {
>          dest->zero_page_detection = params->zero_page_detection;
>      }
> +
> +    if (params->has_direct_io) {
> +        dest->direct_io = params->direct_io;

.. do proper check here to make sure the current QEMU is built with direct
IO support, then fail QMP migrate-set-parameters otherwise when someone
tries to enable it on a QEMU that doesn't support it.

Always displaying direct_io parameter also helps when we simply want to
check qemu version and whether it supports this feature in general.

> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1570,6 +1596,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_zero_page_detection) {
>          s->parameters.zero_page_detection = params->zero_page_detection;
>      }
> +
> +    if (params->has_direct_io) {
> +        s->parameters.direct_io = params->direct_io;
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index ab8199e207..aa5509cd2a 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -76,6 +76,7 @@ uint8_t migrate_cpu_throttle_increment(void);
>  uint8_t migrate_cpu_throttle_initial(void);
>  bool migrate_cpu_throttle_tailslow(void);
>  int migrate_decompress_threads(void);
> +bool migrate_direct_io(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..1a8a4b114c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,6 +914,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the @mapped-ram capability is enabled. (since 9.1)

Here it seems to imply setting direct-io=true will fail if mapped-ram not
enabled, but in reality it's fine, it'll just be ignored.  I think that's
the right thing to do to reduce correlation effects between params/caps
(otherwise, when unset mapped-ram cap, we'll need to double check again to
unset direct-io too; just cumbersome).

I suggest we state the fact, that this field is ignored when mapped-ram
capability is not enabled, rather than "requires mapped-ram".  Same to all
the rest two places in qapi doc.

> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -948,7 +951,8 @@
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
>             'mode',
> -           'zero-page-detection'] }
> +           'zero-page-detection',
> +           'direct-io'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1122,6 +1126,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the @mapped-ram capability is enabled. (since 9.1)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1176,7 +1183,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection'} }
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1354,6 +1362,9 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @direct-io: Open migration files with O_DIRECT when possible. This
> +#     requires that the @mapped-ram capability is enabled. (since 9.1)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1405,7 +1416,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
> -            '*zero-page-detection': 'ZeroPageDetection'} }
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*direct-io': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..d0227a60ab 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -277,6 +277,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
>  }
>  #endif
>  
> +bool qemu_has_direct_io(void)
> +{
> +#ifdef O_DIRECT
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>  static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
>  {
>      int ret;
> -- 
> 2.35.3
> 

-- 
Peter Xu


