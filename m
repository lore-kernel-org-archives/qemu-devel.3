Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE5ECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utexq-0003IV-Du; Wed, 03 Sep 2025 00:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utexm-0003IG-T0
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 00:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utexk-0007bB-Sq
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 00:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756873149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGT34auug2xukE4iujlHtRWaEQGwwjlB4/t+zpAt6Z4=;
 b=V2ryJkZwSMR2lGLif4byLZdaJ3SsPftOg4Z6C6VC877kH+J3/lbyeZdLxgWlYUxiIbZwr8
 elHec7fWJUVPWaz7LaAb35jPx5j+Pl05Ndj8izbSsTNRgiipdT8QJ0PqlbrA35yvMvWpht
 gPTfMt4hc9G6lurqHVFxjygyCjWZVUs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-upX15n34Phe64qvJ59rnqQ-1; Wed, 03 Sep 2025 00:19:07 -0400
X-MC-Unique: upX15n34Phe64qvJ59rnqQ-1
X-Mimecast-MFC-AGG-ID: upX15n34Phe64qvJ59rnqQ_1756873146
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-329b750757aso2459819a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 21:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756873146; x=1757477946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGT34auug2xukE4iujlHtRWaEQGwwjlB4/t+zpAt6Z4=;
 b=mGui9VQ0/drh6U3toiXeilL+uV7WzeI+QFRD66koMtTqBiVSZn1ppF9kW1dfk+QHnE
 p2il1aLVRlLK84YutkLSf4WRy12CQ1I9Db7SN7f8HU+P/XXKjgQzzmR2Wrs0J63LG88d
 nSNoMqIDziSHgYkJM3oAuNVbokqE4N5nR8Hnsz39eLydY8SXNNgYwsk+/vTcIEkowmtV
 JWXCvRmw9HJPGYHOhLULVDjkQxaNxbEeBZsMQsac3VV1MBtaP3nFfvcUr8ljcg4KT6D4
 nuZGJ4PjFAtf9oakwWOVnk9DX1gK3m36CuQEMm8AqEZnoHESMmrh6gETAFfQIPGOuQBk
 jX+Q==
X-Gm-Message-State: AOJu0YydATjGsmqRf3Jt/LI6xrR9sgWOyIFKnnKqUC2BLsiijPjHrCgW
 qZrOrQkw5Y7ko4Zs8Fx2ioXGaS9Nw6ZcYoCpPEZ/AvzlmNDKiu7t594BiJbqSStjTmaX7jBm5yX
 KOfRyxGnJLyoeQQ1iO/TOn29ZDcdjZmLFRfa6csuAlifwoMeHUp5nN5VDbMYcLH5P6qI8EfvkHT
 RGtAO6x43I6UCfTJBqRlWqRp8TgANSTwM=
X-Gm-Gg: ASbGnct7VaKAlLN1DF9NF3PSSZP/1Ft/d3n27/cIey5QczrEhRN0eGnICaiF4i/+YwP
 wSPZVzeon6aIfHb1ROi6lDWz6Z7DXMlA8esd/OrfzeEwMPld2EBpk6U7V/+xv7kwSuT7v+WGPWV
 v2MgFmghnUgSkez5tYnmHJ0w==
X-Received: by 2002:a17:90b:54cc:b0:329:8b65:25b5 with SMTP id
 98e67ed59e1d1-3298b652c59mr13661858a91.26.1756873145913; 
 Tue, 02 Sep 2025 21:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqKfEUK6Y77EHGs7bkM43q3Yq6Hbsdy2L5oXiW/oC8Mzz6Y6uxbqQDsQSXcAq3oFey4/4edpa5kHHFWwPk18k=
X-Received: by 2002:a17:90b:54cc:b0:329:8b65:25b5 with SMTP id
 98e67ed59e1d1-3298b652c59mr13661840a91.26.1756873145454; Tue, 02 Sep 2025
 21:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-6-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-6-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 12:18:54 +0800
X-Gm-Features: Ac12FXxc2apVBZPx4iryEb_QPTS-er8uTDY2xELSBWrad_kznXVMRmGMPLLZB5w
Message-ID: <CACGkMEsbnX5tqw_1RpKcfmg=0Q8bi2AgXsa+heps45XY1P3ObQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] net/tap: net_init_tap_one(): move parameter
 checking earlier
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
> Let's keep all similar argument checking in net_init_tap() function.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 58c3318b1c..3fe99ef63f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -765,9 +765,6 @@ static int net_init_tap_one(const NetdevTapOptions *t=
ap, NetClientState *peer,
>                         "vhost-net requested but could not be initialized=
");
>              goto failed;
>          }
> -    } else if (vhostfdname) {
> -        error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
> -        goto failed;
>      }
>
>      return 0;
> @@ -829,6 +826,11 @@ int net_init_tap(const Netdev *netdev, const char *n=
ame,
>          return -1;
>      }
>
> +    if (tap->has_vhost && !tap->vhost && (tap->vhostfds || tap->vhostfd)=
) {
> +        error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
> +        return -1;
> +    }

So this doesn't deal with vhost force or is this expected to be
applied on top of the deprecation of vhostforce?

Thanks

> +
>      if (tap->fd) {
>          if (tap->ifname || tap->script || tap->downscript ||
>              tap->has_vnet_hdr || tap->helper || tap->has_queues ||
> --
> 2.48.1
>


