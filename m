Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB8DC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoMA-000435-Db; Wed, 21 Feb 2024 10:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcoJj-0000wk-TI
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:15:28 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcn78-0004pk-Vn
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:58:25 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512cba0f953so1743400e87.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708523901; x=1709128701; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5v01uuNucPzklG1pJUuR1hHMAbZDPMdecrkaWDq/cXc=;
 b=KhA83g7QuHf9xsM72crsGVMtA1DIfPfpISEsFNI262YfFU0jzvujUZBcelNG9Fxl3e
 tQ7jFAXKzdt6w2weM1zH2jqngqsZHPc2vzhb2te2lplVXcjKrXYBUnH4+3zK0JobrVQ9
 HeMj94zGl3lGQSACXdV66CMPtxwEfll0X9NLvbhzuvNgLBDSJvCeYk0RJyBIdjH0I7nv
 bvAhswVETVr204thJ3i7v4iEOoh7c73dbzzzs+xke9QTZFzq58+FZ0hSdVbLwygxAIIT
 DJ6KMkxrodlqdNqzTBbIzEzQdYIuQzopkDekrljZ2+xTmIqeiR4saqwftjCvzFJZLuBC
 419g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708523901; x=1709128701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5v01uuNucPzklG1pJUuR1hHMAbZDPMdecrkaWDq/cXc=;
 b=pliurWS3SnEEhWmP9DFGK9AVbTxnw4dBKy0n8YdEMzdu1wI+QAPYEqf2YCRiwd0uSI
 0VsdyWMVAJLTthrjFTPiII3+tOtjH0LLTYNnRNIdGmtsFBBCaKy2rd7VoNwJiNlOCfPK
 vagBxybQ5P/PM4j4zZdSbEWxedw5YufDyh4+y00gNaM28IxyceJSr+T39uDOFsjBqRCQ
 0SWqKWLyWk5/RngZvp73rWGgIgC7i74r+I7nq+cqR9MQyN6UJNiSZSV33XSytuwir7rO
 SsfWZ22MDr2RiVUMY5gLJnV/YhG8tF2zwcwG9gfWIInL3UxCDntV70s4CAcg/K1i24uh
 SshQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS4udRfevC+/pW7TyVll8OQRj+feBqNSxIw/v6Rt9w5ZdY+qKK1czrDHOeOW1AiypJ/tabLsGo85ZoeO2HBU0JUInnqW4=
X-Gm-Message-State: AOJu0YzZN3jt3kSQBmnCsQyaatdPvzdm05HUsMHzl+KG682S6f+gIWRk
 AwAESzM+CJ2B/CCSZtUJ1rBwhi2GwmLupxjnW98EG2wp9z6WrJPDmo7XkkL0wr6bU8fAv49tsex
 xRPh9/flLo04Dt+tuzk4+cK9RokE=
X-Google-Smtp-Source: AGHT+IG/gg256HLVbwSw8tCDxCesONUpT9jnRaFgZ41qxqzBfQk1HARVrMz3n2UjKC9IndLzLT28OKDHmBjFvVAf4FE=
X-Received: by 2002:a05:6512:4018:b0:512:d00c:2972 with SMTP id
 br24-20020a056512401800b00512d00c2972mr2239161lfb.24.1708523900490; Wed, 21
 Feb 2024 05:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
In-Reply-To: <20240216224002.1476890-2-hao.xiang@bytedance.com>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Wed, 21 Feb 2024 05:58:08 -0800
Message-ID: <CAEr7rXjdbTzPByJkysvkKrWXzwjhMpDBW4Po0MuifGr5YV3woQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] migration/multifd: Add new migration option
 zero-page-detection.
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002dd77e0611e4b81b"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=ufimtseva@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000002dd77e0611e4b81b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:41=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:

> This new parameter controls where the zero page checking is running.
> 1. If this parameter is set to 'legacy', zero page checking is
> done in the migration main thread.
> 2. If this parameter is set to 'none', zero page checking is disabled.
>
>
Hello Hao

Few questions and comments.

First the commit message states that the parameter control where the
checking is done, but it also controls
if sending of zero pages is done by multifd threads or not.



> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  hw/core/qdev-properties-system.c    | 10 ++++++++++
>  include/hw/qdev-properties-system.h |  4 ++++
>  migration/migration-hmp-cmds.c      |  9 +++++++++
>  migration/options.c                 | 21 ++++++++++++++++++++
>  migration/options.h                 |  1 +
>  migration/ram.c                     |  4 ++++
>  qapi/migration.json                 | 30 ++++++++++++++++++++++++++---
>  7 files changed, 76 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index 1a396521d5..63843f18b5 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -679,6 +679,16 @@ const PropertyInfo qdev_prop_mig_mode =3D {
>      .set_default_value =3D qdev_propinfo_set_default_value_enum,
>  };
>
> +const PropertyInfo qdev_prop_zero_page_detection =3D {
> +    .name =3D "ZeroPageDetection",
> +    .description =3D "zero_page_detection values, "
> +                   "multifd,legacy,none",
> +    .enum_table =3D &ZeroPageDetection_lookup,
> +    .get =3D qdev_propinfo_get_enum,
> +    .set =3D qdev_propinfo_set_enum,
> +    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- Reserved Region --- */
>
>  /*
> diff --git a/include/hw/qdev-properties-system.h
> b/include/hw/qdev-properties-system.h
> index 06c359c190..839b170235 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_reserved_region;
>  extern const PropertyInfo qdev_prop_multifd_compression;
>  extern const PropertyInfo qdev_prop_mig_mode;
> +extern const PropertyInfo qdev_prop_zero_page_detection;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>  extern const PropertyInfo qdev_prop_bios_chs_trans;
> @@ -47,6 +48,9 @@ extern const PropertyInfo
> qdev_prop_iothread_vq_mapping_list;
>  #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
>                         MigMode)
> +#define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
> +                       ZeroPageDetection)
>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>                          LostTickPolicy)
> diff --git a/migration/migration-hmp-cmds.c
> b/migration/migration-hmp-cmds.c
> index 99b49df5dd..7e96ae6ffd 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const
> QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>
>  MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
>              MultiFDCompression_str(params->multifd_compression));
> +        assert(params->has_zero_page_detection);
>

What is the reason to have assert here?


> +        monitor_printf(mon, "%s: %s\n",
> +
> MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
> +            qapi_enum_lookup(&ZeroPageDetection_lookup,
> +                params->zero_page_detection));
>          monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
>              params->xbzrle_cache_size);
> @@ -634,6 +639,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const
> QDict *qdict)
>          p->has_multifd_zstd_level =3D true;
>          visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
>          break;
> +    case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:
> +        p->has_zero_page_detection =3D true;
> +        visit_type_ZeroPageDetection(v, param, &p->zero_page_detection,
> &err);
> +        break;
>      case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
>          p->has_xbzrle_cache_size =3D true;
>          if (!visit_type_size(v, param, &cache_size, &err)) {
> diff --git a/migration/options.c b/migration/options.c
> index 3e3e0b93b4..3c603391b0 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -179,6 +179,9 @@ Property migration_properties[] =3D {
>      DEFINE_PROP_MIG_MODE("mode", MigrationState,
>                        parameters.mode,
>                        MIG_MODE_NORMAL),
> +    DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationStat=
e,
> +                       parameters.zero_page_detection,
> +                       ZERO_PAGE_DETECTION_LEGACY),
>
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -903,6 +906,13 @@ uint64_t migrate_xbzrle_cache_size(void)
>      return s->parameters.xbzrle_cache_size;
>  }
>
> +ZeroPageDetection migrate_zero_page_detection(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->parameters.zero_page_detection;
> +}
> +
>  /* parameter setters */
>
>  void migrate_set_block_incremental(bool value)
> @@ -1013,6 +1023,8 @@ MigrationParameters
> *qmp_query_migrate_parameters(Error **errp)
>      params->vcpu_dirty_limit =3D s->parameters.vcpu_dirty_limit;
>      params->has_mode =3D true;
>      params->mode =3D s->parameters.mode;
> +    params->has_zero_page_detection =3D true;
> +    params->zero_page_detection =3D s->parameters.zero_page_detection;
>
>      return params;
>  }
> @@ -1049,6 +1061,7 @@ void migrate_params_init(MigrationParameters *param=
s)
>      params->has_x_vcpu_dirty_limit_period =3D true;
>      params->has_vcpu_dirty_limit =3D true;
>      params->has_mode =3D true;
> +    params->has_zero_page_detection =3D true;
>  }
>
>  /*
> @@ -1350,6 +1363,10 @@ static void
> migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_mode) {
>          dest->mode =3D params->mode;
>      }
> +
> +    if (params->has_zero_page_detection) {
> +        dest->zero_page_detection =3D params->zero_page_detection;
> +    }
>  }
>
>  static void migrate_params_apply(MigrateSetParameters *params, Error
> **errp)
> @@ -1494,6 +1511,10 @@ static void
> migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_mode) {
>          s->parameters.mode =3D params->mode;
>      }
> +
> +    if (params->has_zero_page_detection) {
> +        s->parameters.zero_page_detection =3D params->zero_page_detectio=
n;
> +    }
>  }
>
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error
> **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 246c160aee..b7c4fb3861 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -93,6 +93,7 @@ const char *migrate_tls_authz(void);
>  const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
> +ZeroPageDetection migrate_zero_page_detection(void);
>
>  /* parameters setters */
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 4649a81204..556725c30f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1123,6 +1123,10 @@ static int save_zero_page(RAMState *rs,
> PageSearchStatus *pss,
>      QEMUFile *file =3D pss->pss_channel;
>      int len =3D 0;
>
> +    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGACY) {
> +        return 0;
> +    }
> +
>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>          return 0;
>      }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5a565d9b8d..99843a8e95 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -653,6 +653,17 @@
>  { 'enum': 'MigMode',
>    'data': [ 'normal', 'cpr-reboot' ] }
>
> +##
> +# @ZeroPageDetection:
> +#
> +# @legacy: Perform zero page checking from main migration thread. (since
> 9.0)
> +#
> +# @none: Do not perform zero page checking.
> +#
> +##
> +{ 'enum': 'ZeroPageDetection',
> +  'data': [ 'legacy', 'none' ] }
> +
>

Above you have introduced the qdev property qdev_prop_zero_page_detection
with multifd, but it is not present in the scheme.
Perhaps 'mulitfd' in qdev_prop_zero_page_detection belongs to another patch=
?



>  ##
>  # @BitmapMigrationBitmapAliasTransform:
>  #
> @@ -874,6 +885,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal=
'.
>  #        (Since 8.2)
>  #
> +# @zero-page-detection: See description in @ZeroPageDetection.
> +#     Default is 'legacy'. (Since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -907,7 +921,8 @@
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features':
> ['unstable'] },
>             'vcpu-dirty-limit',
> -           'mode'] }
> +           'mode',
> +           'zero-page-detection'] }
>
>  ##
>  # @MigrateSetParameters:
> @@ -1066,6 +1081,10 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal=
'.
>  #        (Since 8.2)
>  #
> +# @zero-page-detection: See description in @ZeroPageDetection.
> +#     Default is 'legacy'. (Since 9.0)
> +#
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1119,7 +1138,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] }=
,
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*zero-page-detection': 'ZeroPageDetection'} }
>
>  ##
>  # @migrate-set-parameters:
> @@ -1294,6 +1314,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal=
'.
>  #        (Since 8.2)
>  #
> +# @zero-page-detection: See description in @ZeroPageDetection.
> +#     Default is 'legacy'. (Since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1344,7 +1367,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] }=
,
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*zero-page-detection': 'ZeroPageDetection'} }
>
>  ##
>  # @query-migrate-parameters:
> --
> 2.30.2
>
>
>

--=20
Elena

--0000000000002dd77e0611e4b81b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 16, 2024 at 2:41=E2=80=AF=
PM Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com">hao.xiang@byted=
ance.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">This new parameter controls where the zero page checking is running=
.<br>
1. If this parameter is set to &#39;legacy&#39;, zero page checking is<br>
done in the migration main thread.<br>
2. If this parameter is set to &#39;none&#39;, zero page checking is disabl=
ed.<br>
<br></blockquote><div><br></div><div>Hello Hao</div><div><br></div><div>Few=
 questions and comments.</div><div><br></div><div>First the commit message =
states that the parameter control where the checking is done, but it also c=
ontrols</div><div>if sending of zero pages is done by multifd threads or no=
t.</div><div><br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Signed-off-by: Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com" tar=
get=3D"_blank">hao.xiang@bytedance.com</a>&gt;<br>
---<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 | 10 ++++++++++<br>
=C2=A0include/hw/qdev-properties-system.h |=C2=A0 4 ++++<br>
=C2=A0migration/migration-hmp-cmds.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++++=
+<br>
=C2=A0migration/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 21 ++++++++++++++++++++<br>
=C2=A0migration/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 30 ++++++++++++++++++++++++++---<br>
=C2=A07 files changed, 76 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c<br>
index 1a396521d5..63843f18b5 100644<br>
--- a/hw/core/qdev-properties-system.c<br>
+++ b/hw/core/qdev-properties-system.c<br>
@@ -679,6 +679,16 @@ const PropertyInfo qdev_prop_mig_mode =3D {<br>
=C2=A0 =C2=A0 =C2=A0.set_default_value =3D qdev_propinfo_set_default_value_=
enum,<br>
=C2=A0};<br>
<br>
+const PropertyInfo qdev_prop_zero_page_detection =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;ZeroPageDetection&quot;,<br>
+=C2=A0 =C2=A0 .description =3D &quot;zero_page_detection values, &quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;multifd,legacy,none&quot;,<br>
+=C2=A0 =C2=A0 .enum_table =3D &amp;ZeroPageDetection_lookup,<br>
+=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+};<br>
+<br>
=C2=A0/* --- Reserved Region --- */<br>
<br>
=C2=A0/*<br>
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properti=
es-system.h<br>
index 06c359c190..839b170235 100644<br>
--- a/include/hw/qdev-properties-system.h<br>
+++ b/include/hw/qdev-properties-system.h<br>
@@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;<br>
=C2=A0extern const PropertyInfo qdev_prop_reserved_region;<br>
=C2=A0extern const PropertyInfo qdev_prop_multifd_compression;<br>
=C2=A0extern const PropertyInfo qdev_prop_mig_mode;<br>
+extern const PropertyInfo qdev_prop_zero_page_detection;<br>
=C2=A0extern const PropertyInfo qdev_prop_losttickpolicy;<br>
=C2=A0extern const PropertyInfo qdev_prop_blockdev_on_error;<br>
=C2=A0extern const PropertyInfo qdev_prop_bios_chs_trans;<br>
@@ -47,6 +48,9 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_l=
ist;<br>
=C2=A0#define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, =
\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 MigMode)<br>
+#define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detec=
tion, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ZeroPageDetection)<br>
=C2=A0#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpo=
licy, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0LostTickPolicy)<br>
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.=
c<br>
index 99b49df5dd..7e96ae6ffd 100644<br>
--- a/migration/migration-hmp-cmds.c<br>
+++ b/migration/migration-hmp-cmds.c<br>
@@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const Q=
Dict *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;%s: %s\n&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MigrationParameter_str(MIGR=
ATION_PARAMETER_MULTIFD_COMPRESSION),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MultiFDCompression_str(para=
ms-&gt;multifd_compression));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(params-&gt;has_zero_page_detection);<br=
></blockquote><div><br></div><div>What is the reason to have assert here?</=
div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;%s: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigrationParameter_str(MIGRATION=
_PARAMETER_ZERO_PAGE_DETECTION),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_enum_lookup(&amp;ZeroPageDe=
tection_lookup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params-&gt;zero_pa=
ge_detection));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;%s: %&quot; PRI=
u64 &quot; bytes\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MigrationParameter_str(MIGR=
ATION_PARAMETER_XBZRLE_CACHE_SIZE),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;xbzrle_cache_siz=
e);<br>
@@ -634,6 +639,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDi=
ct *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;has_multifd_zstd_level =3D true;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0visit_type_uint8(v, param, &amp;p-&gt;mul=
tifd_zstd_level, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;has_zero_page_detection =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 visit_type_ZeroPageDetection(v, param, &amp;p-=
&gt;zero_page_detection, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;has_xbzrle_cache_size =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!visit_type_size(v, param, &amp;cache=
_size, &amp;err)) {<br>
diff --git a/migration/options.c b/migration/options.c<br>
index 3e3e0b93b4..3c603391b0 100644<br>
--- a/migration/options.c<br>
+++ b/migration/options.c<br>
@@ -179,6 +179,9 @@ Property migration_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_MIG_MODE(&quot;mode&quot;, MigrationState,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0parameters.mode,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIG_MODE_NORMAL),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_ZERO_PAGE_DETECTION(&quot;zero-page-detection&qu=
ot;, MigrationState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0parameters.zero_page_detection,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ZERO_PAGE_DETECTION_LEGACY),<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Migration capabilities */<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_MIG_CAP(&quot;x-xbzrle&quot;, MIGRATION_CAP=
ABILITY_XBZRLE),<br>
@@ -903,6 +906,13 @@ uint64_t migrate_xbzrle_cache_size(void)<br>
=C2=A0 =C2=A0 =C2=A0return s-&gt;parameters.xbzrle_cache_size;<br>
=C2=A0}<br>
<br>
+ZeroPageDetection migrate_zero_page_detection(void)<br>
+{<br>
+=C2=A0 =C2=A0 MigrationState *s =3D migrate_get_current();<br>
+<br>
+=C2=A0 =C2=A0 return s-&gt;parameters.zero_page_detection;<br>
+}<br>
+<br>
=C2=A0/* parameter setters */<br>
<br>
=C2=A0void migrate_set_block_incremental(bool value)<br>
@@ -1013,6 +1023,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;vcpu_dirty_limit =3D s-&gt;parameters.vcpu_d=
irty_limit;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_mode =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;mode =3D s-&gt;parameters.mode;<br>
+=C2=A0 =C2=A0 params-&gt;has_zero_page_detection =3D true;<br>
+=C2=A0 =C2=A0 params-&gt;zero_page_detection =3D s-&gt;parameters.zero_pag=
e_detection;<br>
<br>
=C2=A0 =C2=A0 =C2=A0return params;<br>
=C2=A0}<br>
@@ -1049,6 +1061,7 @@ void migrate_params_init(MigrationParameters *params)=
<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_x_vcpu_dirty_limit_period =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_vcpu_dirty_limit =3D true;<br>
=C2=A0 =C2=A0 =C2=A0params-&gt;has_mode =3D true;<br>
+=C2=A0 =C2=A0 params-&gt;has_zero_page_detection =3D true;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -1350,6 +1363,10 @@ static void migrate_params_test_apply(MigrateSetPara=
meters *params,<br>
=C2=A0 =C2=A0 =C2=A0if (params-&gt;has_mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest-&gt;mode =3D params-&gt;mode;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 if (params-&gt;has_zero_page_detection) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dest-&gt;zero_page_detection =3D params-&gt;ze=
ro_page_detection;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void migrate_params_apply(MigrateSetParameters *params, Error =
**errp)<br>
@@ -1494,6 +1511,10 @@ static void migrate_params_apply(MigrateSetParameter=
s *params, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0if (params-&gt;has_mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;parameters.mode =3D params-&gt;mode=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 if (params-&gt;has_zero_page_detection) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;parameters.zero_page_detection =3D param=
s-&gt;zero_page_detection;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void qmp_migrate_set_parameters(MigrateSetParameters *params, Error *=
*errp)<br>
diff --git a/migration/options.h b/migration/options.h<br>
index 246c160aee..b7c4fb3861 100644<br>
--- a/migration/options.h<br>
+++ b/migration/options.h<br>
@@ -93,6 +93,7 @@ const char *migrate_tls_authz(void);<br>
=C2=A0const char *migrate_tls_creds(void);<br>
=C2=A0const char *migrate_tls_hostname(void);<br>
=C2=A0uint64_t migrate_xbzrle_cache_size(void);<br>
+ZeroPageDetection migrate_zero_page_detection(void);<br>
<br>
=C2=A0/* parameters setters */<br>
<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 4649a81204..556725c30f 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -1123,6 +1123,10 @@ static int save_zero_page(RAMState *rs, PageSearchSt=
atus *pss,<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *file =3D pss-&gt;pss_channel;<br>
=C2=A0 =C2=A0 =C2=A0int len =3D 0;<br>
<br>
+=C2=A0 =C2=A0 if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_L=
EGACY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 5a565d9b8d..99843a8e95 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -653,6 +653,17 @@<br>
=C2=A0{ &#39;enum&#39;: &#39;MigMode&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: [ &#39;normal&#39;, &#39;cpr-reboot&#39; ] }<b=
r>
<br>
+##<br>
+# @ZeroPageDetection:<br>
+#<br>
+# @legacy: Perform zero page checking from main migration thread. (since 9=
.0)<br>
+#<br>
+# @none: Do not perform zero page checking.<br>
+#<br>
+##<br>
+{ &#39;enum&#39;: &#39;ZeroPageDetection&#39;,<br>
+=C2=A0 &#39;data&#39;: [ &#39;legacy&#39;, &#39;none&#39; ] }<br>
+<br></blockquote><div><br></div><div>Above you have introduced the qdev pr=
operty qdev_prop_zero_page_detection with multifd, but it is not present in=
 the scheme.</div><div>Perhaps &#39;mulitfd&#39; in qdev_prop_zero_page_det=
ection belongs to another patch?</div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0##<br>
=C2=A0# @BitmapMigrationBitmapAliasTransform:<br>
=C2=A0#<br>
@@ -874,6 +885,9 @@<br>
=C2=A0# @mode: Migration mode. See description in @MigMode. Default is &#39=
;normal&#39;.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Since 8.2)<br>
=C2=A0#<br>
+# @zero-page-detection: See description in @ZeroPageDetection.<br>
+#=C2=A0 =C2=A0 =C2=A0Default is &#39;legacy&#39;. (Since 9.0)<br>
+#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
=C2=A0# @deprecated: Member @block-incremental is deprecated.=C2=A0 Use<br>
@@ -907,7 +921,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;block-bitmap-mapping&#39;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &#39;name&#39;: &#39;x-vcpu-dir=
ty-limit-period&#39;, &#39;features&#39;: [&#39;unstable&#39;] },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vcpu-dirty-limit&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mode&#39;] }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mode&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;zero-page-detection&#39;] }<=
br>
<br>
=C2=A0##<br>
=C2=A0# @MigrateSetParameters:<br>
@@ -1066,6 +1081,10 @@<br>
=C2=A0# @mode: Migration mode. See description in @MigMode. Default is &#39=
;normal&#39;.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Since 8.2)<br>
=C2=A0#<br>
+# @zero-page-detection: See description in @ZeroPageDetection.<br>
+#=C2=A0 =C2=A0 =C2=A0Default is &#39;legacy&#39;. (Since 9.0)<br>
+#<br>
+#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
=C2=A0# @deprecated: Member @block-incremental is deprecated.=C2=A0 Use<br>
@@ -1119,7 +1138,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*x-vcpu-dirty-limit-pe=
riod&#39;: { &#39;type&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;features&#39;: [ &#39;unstable&#39; ] },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*vcpu-dirty-limit&#39;=
: &#39;uint64&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*mode&#39;: &#39;MigMode&#3=
9;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*mode&#39;: &#39;MigMode&#3=
9;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*zero-page-detection&#39;: =
&#39;ZeroPageDetection&#39;} }<br>
<br>
=C2=A0##<br>
=C2=A0# @migrate-set-parameters:<br>
@@ -1294,6 +1314,9 @@<br>
=C2=A0# @mode: Migration mode. See description in @MigMode. Default is &#39=
;normal&#39;.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Since 8.2)<br>
=C2=A0#<br>
+# @zero-page-detection: See description in @ZeroPageDetection.<br>
+#=C2=A0 =C2=A0 =C2=A0Default is &#39;legacy&#39;. (Since 9.0)<br>
+#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
=C2=A0# @deprecated: Member @block-incremental is deprecated.=C2=A0 Use<br>
@@ -1344,7 +1367,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*x-vcpu-dirty-limit-pe=
riod&#39;: { &#39;type&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;features&#39;: [ &#39;unstable&#39; ] },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*vcpu-dirty-limit&#39;=
: &#39;uint64&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*mode&#39;: &#39;MigMode&#3=
9;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*mode&#39;: &#39;MigMode&#3=
9;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*zero-page-detection&#39;: =
&#39;ZeroPageDetection&#39;} }<br>
<br>
=C2=A0##<br>
=C2=A0# @query-migrate-parameters:<br>
-- <br>
2.30.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Elena</div></=
div>

--0000000000002dd77e0611e4b81b--

