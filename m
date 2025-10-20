Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E1FCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzCZ-000793-PB; Mon, 20 Oct 2025 19:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzCW-00076C-4W
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:22:04 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzCP-0007kv-57
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:22:03 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-92b92e4b078so206058039f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002515; x=1761607315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDHz0SEdezA336YipDRgwHx7tbNa3wsUzsqvX082OBI=;
 b=QY0cB0tSjlA6bmAO/5dMBJGOOiJDoXoPFEL3a5XJUSItXseeaM3oTSQ90vIOeN6E6v
 8YzviToEL4NSE7g7L9MUM5Lj5vnoTTtuE0/zj47IRrZ59vp0wIYKi4wExAXupielj2rC
 7v5gg5SWKQ6jGamsngcu8N6sOI5FFmzZL38oU+9X8EzV2vT6L9U7lE/Wm8riS9jykyGc
 zaf/eBr52JnKjOx1wFGyoAnpCa3TCse/MEMTT/IwI7dJYfau0s0L8EWKzGQwjHet69QA
 ylNHfoPSyHl4q+FdBxELjwGNinkYiuw3h7knTnKstI0VyCQSYRGDiCgcJLZ9UO8JrG02
 w4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002515; x=1761607315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDHz0SEdezA336YipDRgwHx7tbNa3wsUzsqvX082OBI=;
 b=plLDROtU/QAif/ZHjKPPwjgIBRCs3CdwDg/a61Ays1O+3V/Xmxrt1NSBDgPq2KmEqA
 eylqVuBtPHpjdtNBTuVOs/QBsJSofr4gHQBYW8F+5yDLS6BY/5qVvwyQ8f9lspnxEY7Z
 rG5HqTvYEhxXkLck6GufH3pQwjAt/gSloAymQoJda+9PnNM+ttT6RM+LM0fQ5n8szg0v
 vh6zcpyeKXU4vq+/yi6JC4Umxk1i1XfbQzK82fK6QBQDsAH33CVw/Y7RdIcotgkcFXIs
 Y+YEWmLaFIWsr6pyKUj04EriWa718wD/dtjGt/+v2IlVXnvXTmvn/2Y6LDUFfsbEN7Qn
 XhjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLXYw9LBin6UP7QATVhbMWnmG0wai6P9TLwEin9KVNJ7OwCMatylRHekT2BERcN6Ae45XJnHoO0Hyr@nongnu.org
X-Gm-Message-State: AOJu0Yw1YgdE8jVWVYsolJhjRpp0LzuTw06CyuSYPYzdEo0qzLVedfRB
 0jEFOmMS5sRfwyWcVWSveSHgY6qm5JATSEUgkhXdzzPGYsRgaPh2qbRScwb3TGptOf4oPKuChTj
 X+LmuLwPoNPvMYEpWTcnaunv49PGNL9E=
X-Gm-Gg: ASbGncv8l2kknBw6BMJiDxqjpcyryROPgtXlNqOQbAHYaUlLfvVf41KVboJk25LVi65
 XoSjF90c0ADTx+IIjL7FzPcit2Kko0F/CLe3pXk/Al59tvoqYNVgUbzh20C25PB95R+OXA4O1x3
 husrMeWX447oe+HML7nvTMQOmzY1rUxeWt7YuNePw7AzGStgZsBaTwC7hFMU+dr+7BAQAfohtKp
 aReGivDYztwh14J3XP1q0m8IqlRO4UZgyxDFI1R8Uvp584+M5vEELAguMAl
X-Google-Smtp-Source: AGHT+IFyv1Ubl3VjC2mbci1lrMgtzqbJZ5zerb9WLzpMEGJGYP5Y5Ksg4jRFWEGMMLUjXqo0rYEKYRTZ7la0tPm49dY=
X-Received: by 2002:a05:6602:14d1:b0:940:da07:61ff with SMTP id
 ca18e2360f4ac-940da076a2bmr850135139f.8.1761002515508; Mon, 20 Oct 2025
 16:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-7-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-7-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:21:44 -0400
X-Gm-Features: AS18NWCg7_QHIv5Xd42LNW_ESNshmC3O4SlANgfPO6VEm28T0PdQ3ETqkootydQ
Message-ID: <CAFubqFuS=HZ2uqaKsXJ1dEBHwK4JADP3ROyWHL=YhzRgcdSN4Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/25] vhost-user: support connect api
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Thu, Oct 16, 2025 at 7:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Memory allocation and connecting of structures remain ins _init(),
> communication with backend goes to _connect().
>
> We need this for further support of backend-transfer migration of
> vhost-user-blk, as we'll need to postpone (or not do) initial
> communication to backend.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e45b74eddd..c5cb5ed528 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2270,21 +2270,12 @@ static int vhost_user_postcopy_notifier(NotifierW=
ithReturn *notifier,
>      return 0;
>  }
>
> -static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
> -                                   Error **errp)
> +static int vhost_user_backend_connect(struct vhost_dev *dev, Error **err=
p)
>  {
>      uint64_t features, ram_slots;
> -    struct vhost_user *u;
> -    VhostUserState *vus =3D (VhostUserState *) opaque;
> +    struct vhost_user *u =3D dev->opaque;
>      int err;
>
> -    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
> -
> -    u =3D g_new0(struct vhost_user, 1);
> -    u->user =3D vus;
> -    u->dev =3D dev;
> -    dev->opaque =3D u;
> -
>      err =3D vhost_user_get_features(dev, &features);
>      if (err < 0) {
>          error_setg_errno(errp, -err, "vhost_backend_init failed");
> @@ -2292,7 +2283,7 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>      }
>
>      if (virtio_has_feature(features, VHOST_USER_F_PROTOCOL_FEATURES)) {
> -        bool supports_f_config =3D vus->supports_config ||
> +        bool supports_f_config =3D u->user->supports_config ||
>              (dev->config_ops && dev->config_ops->vhost_dev_config_notifi=
er);
>          uint64_t protocol_features;
>
> @@ -2408,6 +2399,22 @@ static int vhost_user_backend_init(struct vhost_de=
v *dev, void *opaque,
>      return 0;
>  }
>
> +static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
> +                                   Error **errp)
> +{
> +    struct vhost_user *u;
> +    VhostUserState *vus =3D (VhostUserState *) opaque;
> +
> +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
> +
> +    u =3D g_new0(struct vhost_user, 1);
> +    u->user =3D vus;
> +    u->dev =3D dev;
> +    dev->opaque =3D u;
> +
> +    return 0;
> +}
> +
>  static int vhost_user_backend_cleanup(struct vhost_dev *dev)
>  {
>      struct vhost_user *u;
> @@ -3133,6 +3140,7 @@ void vhost_user_qmp_status(struct vhost_dev *dev, V=
irtioStatus *status)
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> +        .vhost_backend_connect =3D vhost_user_backend_connect,
>          .vhost_backend_cleanup =3D vhost_user_backend_cleanup,
>          .vhost_backend_memslots_limit =3D vhost_user_memslots_limit,
>          .vhost_backend_no_private_memslots =3D vhost_user_no_private_mem=
slots,
> --
> 2.48.1
>
>

