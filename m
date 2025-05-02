Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9CDC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAns2-0007xr-3K; Fri, 02 May 2025 06:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAnrx-0007ws-J4
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:43:49 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAnrv-0002bz-Lp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:43:49 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6fead317874so16436777b3.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746182626; x=1746787426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GexDT+VUNUCl5r25ZNb+plTQVDBEWyi+RAbRBrHe48I=;
 b=oUHZtainvpKdi9ZqIMIUylkQaNFT7vtfRGDqNkGJbb/EYJGq8GmtIunoXG2sKeMOCp
 DQZrGIlOTtT7gqy6cNW0sMsFDo9TupOfNeuCtlgw+gOm1RlO6A1qoCYOVEysqR0bUcPf
 1VD144NmubuDk0Y4C2po6dZQxYn4JkmFif+iIWp6l8KEaEvo0H4fv5y/n/Tp+ly399HY
 DgZMU2MiOUvMQrQv2NI2CGBSHrPfhKJfzzhHZTLGJSYnz7ezRhGBLO9XyDy/RkdCjwwS
 p7NBZVhOL14GzrWibMKIePlNy9eCjIaA9Ufow/gwVgrEYdVFpR1obm5uSZqVLmAjPJnl
 aC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746182626; x=1746787426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GexDT+VUNUCl5r25ZNb+plTQVDBEWyi+RAbRBrHe48I=;
 b=ivQa6qYHcLFtCOx124rvYWllZjgUFgzXPbbNgN9MGogQB5QqFi6+lZGdVtIdfUPJus
 zQ/3YNjAAp6JIzNsajG1KSry+YAmtZG1u+RvnbtIkK0XiSwt2LuvJUXgpbFYmG6N70sE
 EB9GkQsW3cViBazSOBYcVqO9hZWh3/Uiryy/dCoWQCsF7CW9z7b2VjpUdOtQJikUVqA+
 8BMRoypJzlfz1F7lmNs2VagC8JmkTqgiPMAiHDqIA17CLddpdzKG4Ba9fGybiUmqoqmL
 qMoQXxPvDmhGIGr5bUOjqfnyTXeX35YFn48lWHyxxKSbVZUC2bd84/21ZbXO4VZCnPzJ
 QStw==
X-Gm-Message-State: AOJu0YwSE/Im2Eyn9W/2enAFSb8MoqHj4qeMs5rQKPeBDFeFOhLfy8Ca
 e0nc25+tDc02vVRq8uznJXSg+lkRB5XNOmXJBTGDAdt+piTlpstVt5gA+Gt/8W1v2+OUuv+xmwO
 9yl+kE7HpSXIRrrfswlnsAihYhCJsHtAHbIHlqCAnsYYmBvb3
X-Gm-Gg: ASbGncu+F3xHaFYbCQ+RqjZ2h7cd1g8noVwBr5f7V9FQiRJWs0B0GU6QhNPXADinJaC
 Qc7qI6WvF/U1afALIMq1rEWnjWDe3BuoiTWpWo/sqhIjUD186oCsgitVUNYuWL2P0fdW1Lbrhbl
 7G0OWZlj9cDFJF/i0pL6rBIJU=
X-Google-Smtp-Source: AGHT+IHWIoK0Pcg6obSfaFDqzmVRw+6j9JcScl2x0b3/mUDQhcf0LX1mAKM6ADda/VvOQAeChVxmBgFPvUYS1j4jTmw=
X-Received: by 2002:a05:690c:3347:b0:706:a7ac:f166 with SMTP id
 00721157ae682-708ced1dabfmr33695687b3.3.1746182626245; Fri, 02 May 2025
 03:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250423120937.21490-1-philmd@linaro.org>
In-Reply-To: <20250423120937.21490-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 11:43:35 +0100
X-Gm-Features: ATxdqUHIdnOIPUiNgwmQfSITHYR1-qVYTi-evijEhO3CKImLw1-bABdWuCZQ6Pc
Message-ID: <CAFEAcA_VuKxNwXN4=5KM5aRUoYvYvZ8Ho8sDXN1vQB81jwF-yQ@mail.gmail.com>
Subject: Re: [PATCH] hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 23 Apr 2025 at 13:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> uint8_t is good enough to hold a property "between 0 and 0xff".
>
> Define pullups/pulldowns properties using DEFINE_PROP_UINT8()
> macro, remove unnecessary range checks in pl061_realize().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/gpio/pl061.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
> index 60ce4a7f628..25b7ae3eccc 100644
> --- a/hw/gpio/pl061.c
> +++ b/hw/gpio/pl061.c
> @@ -79,8 +79,8 @@ struct PL061State {
>      qemu_irq out[N_GPIOS];
>      const unsigned char *id;
>      /* Properties, for non-Luminary PL061 */
> -    uint32_t pullups;
> -    uint32_t pulldowns;
> +    uint8_t pullups;
> +    uint8_t pulldowns;
>  };
>
>  static const VMStateDescription vmstate_pl061 =3D {
> @@ -548,14 +548,6 @@ static void pl061_realize(DeviceState *dev, Error **=
errp)
>  {
>      PL061State *s =3D PL061(dev);
>
> -    if (s->pullups > 0xff) {
> -        error_setg(errp, "pullups property must be between 0 and 0xff");
> -        return;
> -    }
> -    if (s->pulldowns > 0xff) {
> -        error_setg(errp, "pulldowns property must be between 0 and 0xff"=
);
> -        return;
> -    }
>      if (s->pullups & s->pulldowns) {
>          error_setg(errp, "no bit may be set both in pullups and pulldown=
s");
>          return;
> @@ -563,8 +555,8 @@ static void pl061_realize(DeviceState *dev, Error **e=
rrp)
>  }
>
>  static const Property pl061_props[] =3D {
> -    DEFINE_PROP_UINT32("pullups", PL061State, pullups, 0xff),
> -    DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
> +    DEFINE_PROP_UINT8("pullups", PL061State, pullups, 0xff),
> +    DEFINE_PROP_UINT8("pulldowns", PL061State, pulldowns, 0x0),
>  };

Now we have uint8 properties which get set via calls
to qdev_prop_set_uint32(), which seems a bit inconsistent
(though not actually incorrect, since all those set_uint*
wrappers call object_property_set_int() in the end).

thanks
-- PMM

