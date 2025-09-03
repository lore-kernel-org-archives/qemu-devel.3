Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13388CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfua-0001Pz-Iy; Wed, 03 Sep 2025 01:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utfuU-0001Of-64
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utfuS-0003IO-2j
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOnniIEdum+nTw/2qwPYLFe4n+CqqMVVABhbYVLetHU=;
 b=BU0sys3+0fHVUHRM6J146xln9OLUfuopjAgyVwcKyzT3kls4O//YiZC67ZKzLHiouRgAtf
 fUy2KtCZ7RZ2QacPWg0prvaa8bxGMjEBecrC2cQQwv92le6mhqEbey+63+F6pe8eku87FV
 QI1L4z9/Lz+R6AN1HFendbVHYdCkh5k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-EXnMQT7NNrOb2B0l9OpqpA-1; Wed, 03 Sep 2025 01:19:46 -0400
X-MC-Unique: EXnMQT7NNrOb2B0l9OpqpA-1
X-Mimecast-MFC-AGG-ID: EXnMQT7NNrOb2B0l9OpqpA_1756876785
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32b51a481feso655022a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756876785; x=1757481585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOnniIEdum+nTw/2qwPYLFe4n+CqqMVVABhbYVLetHU=;
 b=IVrRNUHvz6X2qeEOrF9m6FMEXmitifeSrKF45fua4dmoNAzsn/7An4M+wCc0aS4hnw
 2PazD86HgnurXhb4vLEWvV26KZhv+sPDhYnv27+F5xr553wx8kgKaZc3dpfBTU5qHx2g
 /+LkXW5qj8WJwQGpm8L59uurLnF/e1vcziHo3+hEO/ou1gs3uLgUOi39PfFAOYQrHbsI
 pHrGwULjnBTdYDbd5IrvheXzfeR2l8oENLenYCAzvwd0noS1/TJFGYc0AWH9wWABmrAS
 UXB2ymV+mUIbkd2kTZrk/i8lqejRGoDhq8Ji/sg2ScRGx85K1uIqQtNUdjZJObY1uG/I
 5Veg==
X-Gm-Message-State: AOJu0YzNxDHba+vQe353oHf8lovpYjCAyYsVZhQlx5CQIhXm7KJgMDXj
 t4t9bJ9Y4mM7YRGHoGeugQqtgmA2UNCmEmoceiFqneqBPfqhpCJ7YzJR9Fu40Tq2U16f6bq7yXd
 0xRdQ1oAQx1wmpwIzXtHwZ+Kn9DtnzY2tgKav3BsdALS5l8h9hyWU0PrIcEGP/1ZR2gtMaSe2Xg
 FctiEEoLFm4yirPNuRdCVfXlxXRvmlm9o=
X-Gm-Gg: ASbGncvsYy/EDu8DlwkFB9mMo76dBeBLwvcLUWU4vErgKNIcB7chZf9D/eHg4h7vWXc
 oR0TMYoz9M0J1Dg5s+kzVybF5DznEaXRnNainZSw8Zjn94Zo8JREalce9lAjbsgdswuRJxTei75
 XvL5mk1+jkOQo6/J6g737wYw==
X-Received: by 2002:a17:90b:1dcc:b0:324:e74a:117c with SMTP id
 98e67ed59e1d1-3280d362848mr19132840a91.13.1756876785107; 
 Tue, 02 Sep 2025 22:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2L9nqy+Ds6vJeJytUsRB6o42dQwZocUmyJuM040K5lKaBd/7e7x75XwdNUnD29ID8bF675gMpDJDii+JG6WA=
X-Received: by 2002:a17:90b:1dcc:b0:324:e74a:117c with SMTP id
 98e67ed59e1d1-3280d362848mr19132804a91.13.1756876784554; Tue, 02 Sep 2025
 22:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-12-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-12-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 13:19:33 +0800
X-Gm-Features: Ac12FXxCt31GEqdZVN3FOynmDO6rXy38UtEeXg24sgAArYBYpGgn5XQNxhdx8ic
Message-ID: <CACGkMEvOgLj0EjXOg6=fqcm08-5UY1JfQaOBKDQjfSJLk6zmLw@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] net/tap: net_init_tap_one(): refactor to use
 netdev as first arg
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, Aug 24, 2025 at 12:03=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This is needed for further unification of bridge initialization in
> net_init_tap() and net_init_bridge().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index eab0a86173..468dae7004 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -692,15 +692,18 @@ static int net_tap_init(const NetdevTapOptions *tap=
, int *vnet_hdr,
>
>  #define MAX_TAP_QUEUES 1024
>
> -static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState =
*peer,
> +static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
>                              const char *model, const char *name,
>                              const char *ifname, const char *script,
>                              const char *downscript, const char *vhostfdn=
ame,
>                              int vnet_hdr, int fd, Error **errp)
>  {
> +    const NetdevTapOptions *tap =3D &netdev->u.tap;
>      TAPState *s =3D net_tap_fd_init(peer, model, name, fd, vnet_hdr);
>      int vhostfd;
>
> +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_TAP);
> +

I think we should try our best to avoid assertions and return errors here.

Thanks

>      if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
>          goto failed;
>      }
> @@ -826,7 +829,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>              return -1;
>          }
>
> -        ret =3D net_init_tap_one(tap, peer, "tap", name, NULL,
> +        ret =3D net_init_tap_one(netdev, peer, "tap", name, NULL,
>                                 NULL, NULL,
>                                 tap->vhostfd, vnet_hdr, fd, errp);
>          if (ret < 0) {
> @@ -875,7 +878,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>                  return -1;
>              }
>
> -            ret =3D net_init_tap_one(tap, peer, "tap", name, NULL,
> +            ret =3D net_init_tap_one(netdev, peer, "tap", name, NULL,
>                                     NULL, NULL,
>                                     vhost_fds ? vhost_fds[i] : NULL,
>                                     vnet_hdr, fd, errp);
> @@ -905,7 +908,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>              return -1;
>          }
>
> -        ret =3D net_init_tap_one(tap, peer, "bridge", name, NULL,
> +        ret =3D net_init_tap_one(netdev, peer, "bridge", name, NULL,
>                                 NULL, NULL, tap->vhostfd,
>                                 vnet_hdr, fd, errp);
>          if (ret < 0) {
> @@ -946,7 +949,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>                  return -1;
>              }
>
> -            ret =3D net_init_tap_one(tap, peer, "tap", name, ifname,
> +            ret =3D net_init_tap_one(netdev, peer, "tap", name, ifname,
>                                     i >=3D 1 ? "no" : script,
>                                     i >=3D 1 ? "no" : downscript,
>                                     tap->vhostfd, vnet_hdr, fd, errp);
> --
> 2.48.1
>


