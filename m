Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E33CD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurYv-0000UR-BQ; Thu, 11 Apr 2024 06:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rurYq-0000JI-I1
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rurYb-0000DO-Kf
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712830883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpf7ulNgxQ2wtOe1r2RNuRfhZSnxrlZ2QWZQE2lnupE=;
 b=LNB29QCFFnyOUJFKHUai4CneqPPMMBxZ+JFEglXVNwemLAOvBBCtrN8jkg4fcrDxcxtsP1
 5SywsYn5KYgZXVJtZSrd+Pkf9xlXy3xB5Ci0V/Mi6wsycjsMP9UQ7dFHdgtfX5taAFodqO
 LS4W2OGSCvWrwqn114y8Kxn7+LZ3qTU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-E3w4HMj6MEavxgLKML8eeA-1; Thu, 11 Apr 2024 06:21:22 -0400
X-MC-Unique: E3w4HMj6MEavxgLKML8eeA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56fe1a9d358so374536a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830881; x=1713435681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jpf7ulNgxQ2wtOe1r2RNuRfhZSnxrlZ2QWZQE2lnupE=;
 b=xK7j77IriqPMYpNFc+g5YuYALp/FgJCdZEAq9hyDik7VQiy5ZgDy/OuJ8c7rOFuvh8
 1o9YDnvZIdbB4RL8fC70QaKwmvBXA799Q/YFK3VOdf/F7IAaEb+REOS5ytl96GLU077M
 KnSKRNTtyGKot7GzQYdaCg3f7BXc9zTSA2XXVd2+agd1Jx33IYPjhk0cbG2CK9zm8kPO
 RiHD0LLa7EPAVxpuNz+FoLOZYoKy4cXuKMLP27jd5ejJ/YYPYs5SoNP+OGwZGi7k4VJj
 B2Jr7JU53IePYI4wlh8tCImHS1I9Y8y1yxkGrCc5g5bQd0lCiqcQL3qfVIgZVEQuNZVa
 VwdQ==
X-Gm-Message-State: AOJu0Yz9NA2TKBHQjtAEnowdq0CYLe/VNXCaOAlhMXXs45v+ED6Cy8zy
 WIdERzNVt1xibk3WohthmvCSEfyo0xjBOfC+34jriSqAs8y3mfYsbhAcdMXGoJeATYHosOutUZS
 tFjSElV8b8EZdYEeqgLRybVDnbPzRZcxZRWuHKSK8v4NsEOhVWu2a39WaOGkuaGnXZz7PHV/PaM
 2Z0mD268nUYDDU92NmNgf2rlRXq64=
X-Received: by 2002:a50:d51e:0:b0:567:45e2:c4db with SMTP id
 u30-20020a50d51e000000b0056745e2c4dbmr3345533edi.39.1712830881207; 
 Thu, 11 Apr 2024 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Ub+EO4Hq/EUG81B5vI/SCkwDXHWtB/Vk4w0HzMzkeOY2Rjp7HU4bv9yV1dGOFE97HMAIKAXT8Val3Cdv7+0=
X-Received: by 2002:a50:d51e:0:b0:567:45e2:c4db with SMTP id
 u30-20020a50d51e000000b0056745e2c4dbmr3345517edi.39.1712830880796; Thu, 11
 Apr 2024 03:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-2-philmd@linaro.org>
In-Reply-To: <20240411101550.99392-2-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Apr 2024 14:21:09 +0400
Message-ID: <CAMxuvawSYW079_H8yOPV3tqft0iWrD_EhRtz+z5qrWDxaSW7NQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] ui/console-vc: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 11, 2024 at 2:16=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
>
> Replace sprintf() by snprintf() in order to avoid:
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
>  ui/console-vc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 899fa11c94..847d5fb174 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>                      break;
>                  case 6:
>                      /* report cursor position */
> -                    sprintf(response, "\033[%d;%dR",
> +                    snprintf(response, sizeof(response), "\033[%d;%dR",
>                             (s->y_base + s->y) % s->total_height + 1,
>                              s->x + 1);
>                      vc_respond_str(vc, response);
> --
> 2.41.0
>


