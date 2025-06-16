Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CE0C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR67T-0006ml-MV; Mon, 16 Jun 2025 05:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uR66e-0003pB-LW; Mon, 16 Jun 2025 05:26:21 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uR66Z-0006bX-Cf; Mon, 16 Jun 2025 05:26:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3141b84bf65so434075a91.1; 
 Mon, 16 Jun 2025 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750065966; x=1750670766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+/3HMADXf0HtBF8KLRVm6z51m1HeA/H0vSXqEkSXH4=;
 b=boGUi4X0P7wfRcUX9dz0bWb/XR64GNK4kvg2DLA+V0G+oLzDs5NqCMqY5kiP5MUFvs
 2z4nD6ccUh/N2pCtQ4YCcPHZbLmsufDOnE/35uJcGqj5+FihpFo0Z8MGC7KOp2o4b173
 LtY7OFhIOC25rj/PQA97oznS9RujfdXLJatG7h/96ZWJ+Y0M+SABBHajaDxc1UbYEwCU
 J8eUBhdw4baS3wMEdkK3YAIXLG28WIhkbhrYFsF2fVf1cax+J0T/rJ0KUsZHJWghAp76
 PxufkrvgW1+LOFTSQirGXkrIhmmk7psjesMFUQBchRZ/RRlAnPGcuEeYvcCSRdMZ+KvL
 jmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750065966; x=1750670766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+/3HMADXf0HtBF8KLRVm6z51m1HeA/H0vSXqEkSXH4=;
 b=Ew7udWvoZikna5MzJd+2OEAWMDSQXPLJ2cNJm4cimjbWm239oXoslL5Rs7SODGZO10
 SPV3o4lDy4Trv4Ec9v9OGMu1ju74N9lXLCrNJj0CP72xILev/OJiIZREGMWihqQj4IY1
 t+lXLiMsIZTt4UVvcYGkwhIJ8+ZUgRyKifBQei+aHxn55PLDZtaZqx/EyqXTmiYB/1/E
 J2eFWrVV2VFwT9Dm241jse/uZjCDx6dKQbDj/15VjdWoc2yB529hwea85oknSAX7wnxq
 PZkyEwI6Lmumf/kiEE3HnBkGGMpLlNSuH5uBIQZf81vkW6nP+7XjQB+/BdCshDnTO+hZ
 l5Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy4bED8vBLzT8B58Q/mX5FHWl+eZmcWylGdbuJd074NG61L1dUCZiHPpwfoyX2RzUt9cOUgToSYTI+@nongnu.org
X-Gm-Message-State: AOJu0YyfCdxvCoI7WdAO4ImO4JMkE9zgbpIgKSviUgPOO8thyBTPwe5f
 iK7SaoUHNtM2I5tDqu1+G7r6lwo1x+SpPVMGp/3QzvdFHpXgWUkP0gbLgF+6pIoONqkTVPps+FO
 wA3OqXG97SAqMxIsXQrHwF6z0nNfNzZw=
X-Gm-Gg: ASbGncts+tdzRfwHJcWaNZ/XWX02pLHwoKBDYPJMKWoj5zHBMMGFs1Q+VvsLO6MRv5S
 5ryYwkENKXovvCK3BZtLhZlBY4H+MFUDbQ583mC9BaKQbEgm1wPKeCkQaoIoJ61jHUV1vKiRaOo
 5XrrRM3DjxmlXPHP2fT1W6cRQimTSZUo0bFkb3wyRACWTvR76oEBciIA==
X-Google-Smtp-Source: AGHT+IE44MtVVsZTqTaeo7ZKZCw8dUA0nSkl3XRkw2WaLFqYFSyXCyl39iS++4m9IE9DN+Wn2ufMksJXVrMisInP3K4=
X-Received: by 2002:a17:90b:2f8b:b0:312:51a9:5d44 with SMTP id
 98e67ed59e1d1-313f1bef890mr12309718a91.5.1750065966414; Mon, 16 Jun 2025
 02:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
In-Reply-To: <20250515112908.383693-2-f.ebner@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Jun 2025 11:25:54 +0200
X-Gm-Features: AX0GCFsFOmA0j6UH6b-LEYrl1GTtIVCYuaHQxnr7NrNnvVPw3ePv3lAmBfLgAcA
Message-ID: <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=idryomov@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 15, 2025 at 1:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Currently, most Ceph configuration options are not exposed via QAPI.
> While it is possible to specify a dedicated Ceph configuration file,
> specialized options are often only required for a selection of images
> on the RBD storage, not all of them. To avoid the need to generate a
> dedicated Ceph configuration file for each image (or for each required
> combination of options), support a selection of key-value pairs via
> QAPI.
>
> Initially, this is just 'rbd_cache_policy'. For example, this is
> useful with small images used as a pflash for EFI variables. Setting
> the 'rbd_cache_policy' to 'writeback' yields a substantial improvement
> there [0].
>
> The function qemu_rbd_extract_key_value_pairs() was copied/adapted
> from the existing qemu_rbd_extract_encryption_create_options().
>
> [0]: https://bugzilla.proxmox.com/show_bug.cgi?id=3D3329#c9
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/rbd.c          | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json | 37 ++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 7446e66659..2924f23093 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -298,6 +298,27 @@ static int qemu_rbd_set_auth(rados_t cluster, Blockd=
evOptionsRbd *opts,
>      return 0;
>  }
>
> +static int qemu_rbd_set_key_value_pairs(rados_t cluster,
> +                                        RbdKeyValuePairs *key_value_pair=
s,
> +                                        Error **errp)
> +{
> +    if (!key_value_pairs) {
> +        return 0;
> +    }
> +
> +    if (key_value_pairs->has_rbd_cache_policy) {
> +        RbdCachePolicy value =3D key_value_pairs->rbd_cache_policy;
> +        int r =3D rados_conf_set(cluster, "rbd_cache_policy",
> +                               RbdCachePolicy_str(value));
> +        if (r < 0) {
> +            error_setg_errno(errp, -r, "could not set 'rbd_cache_policy'=
");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_j=
son,
>                                   Error **errp)
>  {
> @@ -791,6 +812,44 @@ exit:
>      return ret;
>  }
>
> +static int qemu_rbd_extract_key_value_pairs(
> +        QemuOpts *opts,
> +        RbdKeyValuePairs **key_value_pairs,
> +        Error **errp)
> +{
> +    QDict *opts_qdict;
> +    QDict *key_value_pairs_qdict;
> +    Visitor *v;
> +    int ret =3D 0;
> +
> +    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
> +    qdict_extract_subqdict(opts_qdict, &key_value_pairs_qdict,
> +                           "key-value-pairs.");
> +    qobject_unref(opts_qdict);
> +    if (!qdict_size(key_value_pairs_qdict)) {
> +        *key_value_pairs =3D NULL;
> +        goto exit;
> +    }
> +
> +    /* Convert options into a QAPI object */
> +    v =3D qobject_input_visitor_new_flat_confused(key_value_pairs_qdict,=
 errp);
> +    if (!v) {
> +        ret =3D -EINVAL;
> +        goto exit;
> +    }
> +
> +    visit_type_RbdKeyValuePairs(v, NULL, key_value_pairs, errp);
> +    visit_free(v);
> +    if (!*key_value_pairs) {
> +        ret =3D -EINVAL;
> +        goto exit;
> +    }
> +
> +exit:
> +    qobject_unref(key_value_pairs_qdict);
> +    return ret;
> +}
> +
>  static int coroutine_fn qemu_rbd_co_create_opts(BlockDriver *drv,
>                                                  const char *filename,
>                                                  QemuOpts *opts,
> @@ -800,6 +859,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(Block=
Driver *drv,
>      BlockdevCreateOptionsRbd *rbd_opts;
>      BlockdevOptionsRbd *loc;
>      RbdEncryptionCreateOptions *encrypt =3D NULL;
> +    RbdKeyValuePairs *key_value_pairs =3D NULL;
>      Error *local_err =3D NULL;
>      const char *keypairs, *password_secret;
>      QDict *options =3D NULL;
> @@ -848,6 +908,13 @@ static int coroutine_fn qemu_rbd_co_create_opts(Bloc=
kDriver *drv,
>      loc->image       =3D g_strdup(qdict_get_try_str(options, "image"));
>      keypairs         =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs")=
;
>
> +    /* These are the key-value pairs coming in via the QAPI. */
> +    ret =3D qemu_rbd_extract_key_value_pairs(opts, &key_value_pairs, err=
p);
> +    if (ret < 0) {
> +        goto exit;
> +    }
> +    loc->key_value_pairs =3D key_value_pairs;
> +
>      ret =3D qemu_rbd_do_create(create_options, keypairs, password_secret=
, errp);
>      if (ret < 0) {
>          goto exit;
> @@ -937,6 +1004,12 @@ static int qemu_rbd_connect(rados_t *cluster, rados=
_ioctx_t *io_ctx,
>          goto failed_shutdown;
>      }
>
> +    /* For the key-value pairs coming via QAPI. */
> +    r =3D qemu_rbd_set_key_value_pairs(*cluster, opts->key_value_pairs, =
errp);
> +    if (r < 0) {
> +        goto failed_shutdown;
> +    }
> +
>      if (mon_host) {
>          r =3D rados_conf_set(*cluster, "mon_host", mon_host);
>          if (r < 0) {
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 91c70e24a7..4666765e66 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4301,6 +4301,39 @@
>    'data': { 'luks': 'RbdEncryptionCreateOptionsLUKS',
>              'luks2': 'RbdEncryptionCreateOptionsLUKS2' } }
>
> +##
> +# @RbdCachePolicy:
> +#
> +# An enumeration of values for the 'rbd_cache_policy' Ceph
> +# configuration setting.  See the Ceph documentation for details.
> +#
> +# @writearound: cachable writes return immediately, reads are not
> +#     served from the cache.
> +#
> +# @writeback: cachable writes return immediately, reads are served
> +#     from the cache.
> +#
> +# @writethrough: writes return only when the data is on disk for all
> +#     replicas, reads are served from the cache.
> +#
> +# Since 10.1
> +##
> +{ 'enum' : 'RbdCachePolicy',
> +  'data' : [ 'writearound', 'writeback', 'writethrough' ] }
> +
> +
> +##
> +# @RbdKeyValuePairs:
> +#
> +# Key-value pairs for Ceph configuration.
> +#
> +# @rbd-cache-policy: Ceph configuration option 'rbd_cache_policy'.
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'RbdKeyValuePairs',
> +  'data': { '*rbd-cache-policy': 'RbdCachePolicy' } }

Hi Fiona,

I'm not following the rationale for introducing RbdKeyValuePairs
struct.  If there is a desire to expose rbd_cache_policy option this
way, couldn't it just be added to BlockdevOptionsRbd struct?  The
existing auth_client_required option has a very similar pattern.

If exposing rbd_cache_policy option, rbd_cache option (enabled/disabled
bool) should likely be exposed as well.  It doesn't make much sense to
provide a built-in way to adjust the cache policy without also providing
a built-in way to disable the cache entirely.  Then the question of what
would be better from the QAPI perspective arises: a bool option to map
to Ceph as close as possible or perhaps an additional 'disabled' value
in RbdCachePolicy enum?  And regardless of that, the need to remember
to update QEMU if a new cache policy is ever added because even though
these are just strings, QEMU is going to be validating them...

> +
>  ##
>  # @BlockdevOptionsRbd:
>  #
> @@ -4327,6 +4360,9 @@
>  #     authentication.  This maps to Ceph configuration option "key".
>  #     (Since 3.0)
>  #
> +# @key-value-pairs: Key-value pairs for additional Ceph configuraton.
> +#     (Since 10.1)
> +#
>  # @server: Monitor host address and port.  This maps to the "mon_host"
>  #     Ceph option.
>  #
> @@ -4342,6 +4378,7 @@
>              '*user': 'str',
>              '*auth-client-required': ['RbdAuthMode'],
>              '*key-secret': 'str',
> +            '*key-value-pairs' : 'RbdKeyValuePairs',

To side-step all of the above, have you considered implementing
a straightforward passthrough to Ceph instead?  Something like

  '*key-value-pairs': ['RbdKeyValuePair']

where RbdKeyValuePair is just a pair arbitrary strings (and
key-value-pairs is thus an optional list of those).  rados_conf_set()
would be called just the same but the user would be able to override
any Ceph option they wish, not just a few that we thought of here.

Thanks,

                Ilya

