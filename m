Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D716C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 08:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6R9N-0006Jw-7J; Mon, 13 May 2024 04:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s6R9J-0006Je-4d
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s6R9H-0003c0-A8
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715589305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+3HjxIloN4Veq4TysFLj294/lJurRaG6HUWNDMxYQs=;
 b=dz81k9P+iCedP+KUrt7KKZ6btGhyP6p8lIRxR3zemHud79EyHNdNx0zmkrQSddewkcCO5G
 Xz2+5QSo1inRiziEoH5qZU6Awgh1Ygo8rb2Zc/crw1BJyynOEkHsAJ4Dt38JL+5zjZYJDS
 Mf2CaBQpwStsziFVZXucnm3zLWc25SM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-2cdbJ2k2PuKR2JaOv4ByvQ-1; Mon, 13 May 2024 04:30:44 -0400
X-MC-Unique: 2cdbJ2k2PuKR2JaOv4ByvQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5729ec37366so2074394a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 01:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715589043; x=1716193843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+3HjxIloN4Veq4TysFLj294/lJurRaG6HUWNDMxYQs=;
 b=GzJLpksydlxhwh6Oqdf46CC/NycDldatDBKU5dEN6QbWIMLD6Xxb3HiHFyOwDxszc/
 ADhUKl3+/9QlqITXtHhV/U8QS4cvL7OOCyy0zUa1aidVxeKuIcRZ97WwDOpv2JyJJK9W
 dXnBE6HD72Q+S/mmL7sMsLnsIMhvqBp//woKMeQ6ZtAKzfd5K+s8ceuCR6scxZdhyGDD
 CalLNdMXlXhtfQ4HDtKGcK7YIvcVl8PjSglh7a8lQmvVoG0S/5YQAfGNmb3+tAEK1+v1
 WcjO142kXfZZG/FE/R/C+Jk48aeJHjrVS38X6zWBPu8RLFfX1SwQpYybYDQDtjOjFFXS
 O6FQ==
X-Gm-Message-State: AOJu0YztKaRgipeW3pz6tynZecXHzLPKuctVA3DnZ3Tj8nw8ZRSHpTgQ
 bCQyzCgNjA1t1eSkpbK0XXwYIVcJa0mvC4l1QLPxc1l8qvp5GVS9NOXMCG9MsoxfSP+kGkwVp1Q
 /xeB72f3r1mM3R1mqLJp60RhpRQJEHXhxnd1vLX6rGqAa8Y4LY955xjASHWbekppaMXAdoG35wO
 NxoJNzOtQsiIselqHhKtFjMic/avk=
X-Received: by 2002:a50:8d16:0:b0:572:459a:7aed with SMTP id
 4fb4d7f45d1cf-5734d6f55f9mr6049269a12.37.1715589043073; 
 Mon, 13 May 2024 01:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4wZ5rl57JFSrYrRt96RAo+dA4zclGvhExaBWMpD7xOW2ysNP7pVEqcX84FHW05k2a23Sqc9uL047h3El1IPs=
X-Received: by 2002:a50:8d16:0:b0:572:459a:7aed with SMTP id
 4fb4d7f45d1cf-5734d6f55f9mr6049261a12.37.1715589042770; Mon, 13 May 2024
 01:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240512095945.1879-1-shentey@gmail.com>
In-Reply-To: <20240512095945.1879-1-shentey@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 13 May 2024 12:30:31 +0400
Message-ID: <CAMxuvaxKpGrR=ZM=ty-TSGuLnPnberUjLT-tfmTWEAFaYxs89g@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Allow host to power down screen
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, May 12, 2024 at 2:00=E2=80=AFPM Bernhard Beschow <shentey@gmail.com=
> wrote:
>
> By default, SDL disables the screen saver which prevents the host from po=
wering
> down the screen even if the screen is locked. This results in draining th=
e
> battery needlessly when the host isn't connected to a wall charger. Fix t=
hat by
> enabling the screen saver.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/sdl2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 4971963f00..0a0eb5a42d 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -874,6 +874,7 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
>      SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>  #endif
>      SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    SDL_EnableScreenSaver();
>      memset(&info, 0, sizeof(info));
>      SDL_VERSION(&info.version);
>
> --
> 2.45.0
>


