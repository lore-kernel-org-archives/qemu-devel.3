Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23961C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGq0-0002Qh-Dt; Mon, 14 Jul 2025 06:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubGpQ-0002Jg-Sr
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:54:42 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubGpP-0008HN-4Y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:54:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae223591067so730619966b.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752490472; x=1753095272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+gqGwh/OcgeJvVbaiN95K2S7MGxZqAqfm1OoJ3oZ1Y=;
 b=QZjkkXnFFCWZ42Gfi/ZNdZqyL40FkGlJwk7JFa20bXRSh7/HnmeZXOSNWeUMAISG0o
 dxn51ZFDYMR3h94P4fWkDw9pzFSvgNSsfjKhseyGJxtmNXQUHttUUKeg6EcEvonBtMLU
 F5Drq90n6tdi9r/53AG8uk+9rkB3nFfF8dmASGiodGOCrKB1xur1ZbYrcePFQ+8N6k3q
 ZyIqslZpsoe128HZ5A1+01lqC/+N6syTmYwKLK+I4/8S0yyS44bOVwOI/Fo29JctPGNi
 aPG2oWb4xIvyvkAAgggAJxxRJaX9jm4nJrHpjAdsO9vVkvcFvlv6N0dJk6EhYvmNYaJU
 9ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752490472; x=1753095272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+gqGwh/OcgeJvVbaiN95K2S7MGxZqAqfm1OoJ3oZ1Y=;
 b=F667qlCUxEd3TQWS7XHOpFaVUwHCPYnICjE4I5GwMwbioe/thfri4yE4cXGCzmqh4t
 zbtb9TvM1HlJrrXG5YuW89P+6CpOr/70ua+GCK/QPQ44fN/+F/uRJfWn/PovkZ6Aw9TK
 xYgBW5fkeEBCMDfPjvpvqoLGdRIQfeawhcdy6TabmdajbCexABtu96aJq/lFeZM+gb92
 59Fzyvtb9Be9qZhVaMCgHZL6I4luGzYrJr8dJStxLBsMbdFtJacG5d3tLr1CnWMfWbmO
 brW4DSfCjZ6kPwgybRJIF0dnBSzZ+tNXhmHavosV4xjLg5OcFHdsqBea8b1WjhlymjvK
 Qspg==
X-Gm-Message-State: AOJu0YylsNUEOJP+2SNpD/8Iyh0gh78r0y1SyEJB+r5v5LGe5F8ZHOPX
 A9kFnlsUf8IZu0IuS6PlvAnQFAIOk4N6/wciOt6VLOLiM5dtHHJKjLxVT9/pryWfXveqnZUemex
 oWdJ8bNz+vY44tAPE2a28ea+esCEepeJFXQasc7YBEw==
X-Gm-Gg: ASbGncsKvk4fFQntw1ChvipjduojNOV4i0++OK7DB/7TMncswwpsShPGA99izJSTfSj
 FU/0SLsy/tMCTOT6bEh9mL5I82nGFG/EtPwGVz20EGcUqLKNLME3MSIZayPXBW3WhvH7j0xjezX
 wS6vOcc5z2vWStR7xOhpazTEyndtl1KsXX36azuO7YB79mE5ZiiCok48jEt5iyRrDs93Z1Br8dy
 tqHvw==
X-Google-Smtp-Source: AGHT+IFaoXwmMVNEenA9W5/M637XowyqOcXlwV3lTC9i7frD6HazsMttT4TTBjWAiEhwjr3UD5ZkgkQMgtHiyCAXnGM=
X-Received: by 2002:a17:906:fe0c:b0:ae3:5212:c906 with SMTP id
 a640c23a62f3a-ae6fbe13960mr1399309566b.10.1752490472321; Mon, 14 Jul 2025
 03:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250714102626.34431-1-sgarzare@redhat.com>
In-Reply-To: <20250714102626.34431-1-sgarzare@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 14 Jul 2025 13:54:06 +0300
X-Gm-Features: Ac12FXxsSd3D2J8LVQxPG_kXU65HoHSUI0dKWkZrkHynScC3Qm8YZlyp4Puf-kw
Message-ID: <CAAjaMXaHxzoouZm+7OLJ4n+59ndoFONWmKHLHKkak31GTi=pcg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add net/vhost* files under `vhost`
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jul 14, 2025 at 1:30=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> net/vhost* files should be interesting for vhost maintainers/reviewers.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e88ed2c0a9..045a896d08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2321,6 +2321,7 @@ F: include/*/vhost*
>  F: subprojects/libvhost-user/
>  F: block/export/vhost-user*
>  F: util/vhost-user-server.c
> +F: net/vhost*
>
>  vhost-shadow-virtqueue
>  R: Eugenio P=C3=A9rez <eperezma@redhat.com>
> --
> 2.50.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

