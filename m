Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E04CD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 06:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruoOa-0000j2-09; Thu, 11 Apr 2024 02:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ruoOX-0000bC-OT
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 02:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ruoOW-0001IL-Aa
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 02:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712818726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKQlQMKGHLsEbVrn+FLiDMKKW/n1F18R3/TKAj/jonI=;
 b=gnunOFvUaDDZREAsLN5HwkHuSoPd7LrlQhicQMASFq4jmKBWks6B9SoKDxMkGfjM5z74cH
 ueFQKMoFBAjMbyFNg6desysUolEzzLywLC3b9My5Y8AZm0hjzzihQNSWtetP+73x5Ny/JH
 0GL/DJFQHuo8rfc/j5QaxqAfnJU3IJA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-9cjV6rS2N5WSdq2VLTqSXQ-1; Thu, 11 Apr 2024 02:58:44 -0400
X-MC-Unique: 9cjV6rS2N5WSdq2VLTqSXQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56fe8be5474so135696a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 23:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712818724; x=1713423524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKQlQMKGHLsEbVrn+FLiDMKKW/n1F18R3/TKAj/jonI=;
 b=OC6zkoQght68L054/+y4eWpqu/hQiYtj/kLBhOkltLPjqQhqWDXFHb6mWILUX9d+sM
 auQTuk9dMYe29+dfSmR+IGa1e8HNhe/mdHsL2sT4xoh6HU4NOvqAqacbXvMW/CsI940t
 BYv4XDHZLJMqjn1W2QbC/CoLMA5SoH08F1486YOmd1qP6fJhKDvz4qTaEhfUPdAs24+u
 DlbKtfZBsTLNgMS7xdL+ylrmfDIKjsowiEBmHantBiPGBArQhcaU28oilPggiPqfz+Q8
 WV2B8a/GVj8Uf8Hr1INeX0QVXF5noTPPzKwHKJ24QugGo0TnRSE81izX8/4+DL6ieGCb
 UjEA==
X-Gm-Message-State: AOJu0Yxoi/8JkZTmwKL3VNaEiyoXkEqfCjZECKyNy30gs8qOlSiVkP/E
 L+0IGJ84I8AUtN0vMWnmZV/vqgMx2XUDCq3bGPALtq8Eph/bmiSD7qVwUVK1IKHbtKBUv93XU5A
 ucKsI4+6DkpaZoOeOgAo1AZUd/8TLhWLSkBREIz9wkg890YW05kp2RlARlmIaujQykVGD+BcLyG
 RsqYVJamyQRS5OA42Q/MLJ0ihYQXM=
X-Received: by 2002:a50:cdcf:0:b0:56f:d910:4b7 with SMTP id
 h15-20020a50cdcf000000b0056fd91004b7mr2610366edj.15.1712818723923; 
 Wed, 10 Apr 2024 23:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg+XfyDPSpLUAQYQVMjdDjlJZ+JKEzIygtcbEFyxU2liAxEnFin8ycEFUSgIr9cv7ZAfYq4saUy943z2besPE=
X-Received: by 2002:a50:cdcf:0:b0:56f:d910:4b7 with SMTP id
 h15-20020a50cdcf000000b0056fd91004b7mr2610355edj.15.1712818723544; Wed, 10
 Apr 2024 23:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240410160614.90627-1-philmd@linaro.org>
 <20240410160614.90627-2-philmd@linaro.org>
In-Reply-To: <20240410160614.90627-2-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Apr 2024 10:58:31 +0400
Message-ID: <CAMxuvazq=E+Z4jTDkcVMCi32T1pup9T2=6mOKgi10Mt5tDRXsw@mail.gmail.com>
Subject: Re: [PATCH 01/12] ui/console-vc: Replace sprintf() by
 g_strdup_printf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

On Wed, Apr 10, 2024 at 8:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
>
> Replace sprintf() by g_strdup_printf() in order to avoid:
>
>   [702/1310] Compiling C object libcommon.fa.p/ui_console-vc.c.o
>   ui/console-vc.c:824:21: warning: 'sprintf' is deprecated:
>     This function is provided for compatibility reasons only.
>     Due to security concerns inherent in the design of sprintf(3),
>     it is highly recommended that you use snprintf(3) instead.
>     [-Wdeprecated-declarations]
>                     sprintf(response, "\033[%d;%dR",
>                     ^
>   1 warning generated.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/console-vc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 899fa11c94..b455db436d 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -648,7 +648,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>      QemuTextConsole *s =3D vc->console;
>      int i;
>      int x, y;
> -    char response[40];
> +    g_autofree char *response =3D NULL;
>
>      switch(vc->state) {
>      case TTY_STATE_NORM:
> @@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>                      break;
>                  case 6:
>                      /* report cursor position */
> -                    sprintf(response, "\033[%d;%dR",
> +                    response =3D g_strdup_printf("\033[%d;%dR",
>                             (s->y_base + s->y) % s->total_height + 1,
>                              s->x + 1);
>                      vc_respond_str(vc, response);
> --
> 2.41.0
>


