Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFD9CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utg3P-00055K-J8; Wed, 03 Sep 2025 01:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utg3L-00054k-TP
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utg3I-0006rb-7x
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756877338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGFdE40gXLdp3eO9VHQ5ZL8GKdqIfzGaLOOUYAd/hGA=;
 b=XZo8PuLxzhE4pGTNB2b4je36sQZ/pSk2ca/I1UYC0fKg0/eRVI44/WOHHuvepss1d3j6ds
 sdd9vyW+RbI+SvkJCnA4DqmSRzG7wnvkNrakhACYSpAGjB1hsKtOQdZOwkQMAi5teGPYU5
 UjLw0wwktyjbr4IvGCTxB20p8synWgc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-NW7oAvxVNdaKmWnyj2ZViQ-1; Wed, 03 Sep 2025 01:28:53 -0400
X-MC-Unique: NW7oAvxVNdaKmWnyj2ZViQ-1
X-Mimecast-MFC-AGG-ID: NW7oAvxVNdaKmWnyj2ZViQ_1756877333
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3280d0d4d11so5641614a91.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756877333; x=1757482133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGFdE40gXLdp3eO9VHQ5ZL8GKdqIfzGaLOOUYAd/hGA=;
 b=JiB6OP/2NT4OkmMVfGIIEsotp4eQwc4AQg+32CH2C5Y45VPGCyJwNxrHC9Zt6wgt+t
 usCP8MURotP10AUIyQLdVs0tlcVuHC8U8ePJSaZ2luJ9EUlRjhfGe/docYubG0eAhlhM
 D8fzGc8ZjP9JP6qkLkq6B4wofSVewMzqCOMJoJjCLm4xffpWwarvvNQNlYvywFK3W06Q
 lzQjBRY4Mj/QqtDI4YLECmBZ89d8feYm084ODpcGJ9qplAcKmZegypXuR/b/jIpvept7
 m60docEuqmseuvYWwX6ByUqvFmfNBykohP1UfZ6WkzfyDW+bbRzT3z6cVrPg1FFkRXpP
 2Y5w==
X-Gm-Message-State: AOJu0YxrTvmX8k31nBQUWb7xq++fTvOb/uNmPuhnnPBDgXtu7K3B7hrD
 gaKDY5kdfJIOjbToYjnjX05kegrWsQw08VDQ7KoVK5MFZJ2wVOgzCWoJ97pPrYLSwxj9/QluuWD
 LU1txBxNNoA5H5QTTzklFbYhUUi+NQSB2GWqnrd28Y5/hYl5J14qHr741HNExOfM8IplG/YiAqT
 mPKN4LAqsztIvlcCi6GsrF8Y31P09pc8o=
X-Gm-Gg: ASbGnctyFpyoLhMER7EDU6Dei5D5lpUrO8jpEMRhcRTH4a0GWUN3jH1dy3+NLfaUt0K
 FeVINIaI/xW4Cc4VYubYSBlbysShd/FsD7HXkP8T+2g/6Tp/CjqrvSmxgKzaCArt9kLWv3uD3wp
 nnlYg7lN8GfOHRWANPk3GYAQ==
X-Received: by 2002:a17:90b:1dc1:b0:327:8c05:f8a4 with SMTP id
 98e67ed59e1d1-328154140a1mr16619026a91.1.1756877332682; 
 Tue, 02 Sep 2025 22:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbzE91DVcXQkaiC/mwmc7IT0NPmpKnPv06yhRb7uAYsj0bvI8xEnv5VP5s0FVOOb/nZcyRU07MqSe4Xu6uPyk=
X-Received: by 2002:a17:90b:1dc1:b0:327:8c05:f8a4 with SMTP id
 98e67ed59e1d1-328154140a1mr16619004a91.1.1756877332233; Tue, 02 Sep 2025
 22:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-13-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-13-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 13:28:41 +0800
X-Gm-Features: Ac12FXxhavSEtTPN2vvGPLtaqD22qW-kBc6y54IQmfwso3ocmImSNRZwehei72o
Message-ID: <CACGkMEuRYb654ruHax6qcK9uLcn+_kJ4GsGEdrQwj3TZa-rdHw@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] net/tap: net_init_tap_one(): support bridge
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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
> Use net_init_tap_one() in net_init_bridge().

Need to explain why this is needed.

Patch looks good.

Thanks

>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 468dae7004..5acfb128a1 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -88,6 +88,12 @@ static void launch_script(const char *setup_script, co=
nst char *ifname,
>  static void tap_send(void *opaque);
>  static void tap_writable(void *opaque);
>
> +static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
> +                            const char *model, const char *name,
> +                            const char *ifname, const char *script,
> +                            const char *downscript, const char *vhostfdn=
ame,
> +                            int vnet_hdr, int fd, Error **errp);
> +
>  static void tap_update_fd_handler(TAPState *s)
>  {
>      qemu_set_fd_handler(s->fd,
> @@ -626,8 +632,7 @@ int net_init_bridge(const Netdev *netdev, const char =
*name,
>  {
>      const NetdevBridgeOptions *bridge;
>      const char *helper, *br;
> -    TAPState *s;
> -    int fd, vnet_hdr;
> +    int fd, vnet_hdr, ret;
>
>      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_BRIDGE);
>      bridge =3D &netdev->u.bridge;
> @@ -648,9 +653,14 @@ int net_init_bridge(const Netdev *netdev, const char=
 *name,
>          close(fd);
>          return -1;
>      }
> -    s =3D net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
>
> -    qemu_set_info_str(&s->nc, "helper=3D%s,br=3D%s", helper, br);
> +    ret =3D net_init_tap_one(netdev, peer, "bridge", name,
> +                           NULL, NULL, NULL,
> +                           NULL, vnet_hdr, fd, errp);
> +    if (ret < 0) {
> +        close(fd);
> +        return -1;
> +    }
>
>      return 0;
>  }
> @@ -698,11 +708,19 @@ static int net_init_tap_one(const Netdev *netdev, N=
etClientState *peer,
>                              const char *downscript, const char *vhostfdn=
ame,
>                              int vnet_hdr, int fd, Error **errp)
>  {
> -    const NetdevTapOptions *tap =3D &netdev->u.tap;
> +    const NetdevTapOptions *tap;
>      TAPState *s =3D net_tap_fd_init(peer, model, name, fd, vnet_hdr);
>      int vhostfd;
>
> +    if (netdev->type =3D=3D NET_CLIENT_DRIVER_BRIDGE) {
> +        const NetdevBridgeOptions *bridge =3D &netdev->u.bridge;
> +        qemu_set_info_str(&s->nc, "helper=3D%s,br=3D%s",
> +                          bridge->helper, bridge->br);
> +        return 0;
> +    }
> +
>      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_TAP);
> +    tap =3D &netdev->u.tap;
>
>      if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
>          goto failed;
> --
> 2.48.1
>


