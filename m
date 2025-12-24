Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB16E7545F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPiY-0008SX-W9; Wed, 24 Dec 2025 09:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPiL-0008Jt-C1
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:19:47 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPiA-0004cH-Hp
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:19:40 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7ffa421f1bso1198779266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766585972; x=1767190772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FErnbWfFQkcjgqYiKpC1v3T+ZThOO/2tJ55UwnlZHEk=;
 b=AefsrsBGKi9Sj8chP2lYIego3Fswf0e9qUCIPjhtYo64+lzcv0xZk+8+PYpSP4hflA
 4wYYaoQkUrmSgbm2J/0dSfhSGQso2ZWdRjc9K+O/BYb0WVNkAYeqtI5K83znSDUKsyD7
 NpS2PPDyqKeEOb6yZWEZHNZ8Bj2mrQR4QpIWSjcc3DrsykKqoCPWaHoB0ShtLtdET7S4
 cN54Efpp6AhmA85Xtnap10psuIw4MynLynq+JFXcIrJkpOwnYbSevU1yYZYZRq/vsPAh
 oKbhJrrcMm2QMTKmm3E6C3xkp+EINbKn+Xx1FPXulhRHIH9ikXZbQiuAEHG6qMs1UGp8
 TqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766585972; x=1767190772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FErnbWfFQkcjgqYiKpC1v3T+ZThOO/2tJ55UwnlZHEk=;
 b=K7ATKjrfxFZD7KFGhlJU+v503/wvvop+PsbMV4PfSn+A4vLgHyq42epKgpSZmj4Ts8
 NMrso5RvhAoI0rjmlX1zBm7z/sDA9UTCrxGAmS8+sXGWwBCvgL/DknfNSpVOWZkf0uij
 i0BVKkWfCRABuSXqmjGpU9Zb1z1swIXOy8G3kDt+eCWyL4+cOxsnprDnDoDABy71B+J7
 p2jEyJ95Z/iAUXcKdFNrPoh/OchdXQlXboyf9F/iChy4t/fpWYhcgsuJtlZgdfkhxgCt
 xhulu1rbwNMTQUDoQ3hvfOnvN8lAtyNt07a78m058QmTpplX3cHaMVumEJrdtbYcbHWn
 pjwg==
X-Gm-Message-State: AOJu0YxSPQ1WZ3WqX+HDVRKun3O0b4y88J3fybCA0PnEMz4O0sVOG9oK
 nREnO+rQ9VZAarnPCtNr9kdj82xRP/vRwvYCCKYNVG5+x3rGqS+05SY5fgVBlfQGwDC3Yxvkyh0
 +MOrrJxVcodAsPXyBOeDlVGTlWl+HqQ9GPivnYXwQdPlzKRXYdNxWp38=
X-Gm-Gg: AY/fxX4OnpYg1PVe7AEtjd+1HhbCvT0L3MVIHGNmlh7Lo8DenkYBuIXH/6ZfcitQY8/
 vCGnuEphE64zXUiz0uTeFcj7bg82prtm2expLwIgzLbruuFzcsc2I2elpEQh8W8KTd7q0W6kw2x
 D0pZjA18UkRPNC2qXTGA9VYhQgC2u+iQ4LZy4a4/ourRZnMVVp2KSc+CFzFOqsmVr7L2OCIdz4A
 Gmd7qIfVlM3VhGc+R9vHH8nuTqdeU3pn/ScxUTH5frgbPJ5w2rp+j70U2PJ0XtmNzcXRZg=
X-Google-Smtp-Source: AGHT+IHbjaOo/4IJSkmjAmMLXKxFESHIxxpiuGsmjxfQKM6xlsYsPPrIso8UJdibfwSguQjFsBl175vs7DREhmH3apI=
X-Received: by 2002:a17:907:70d7:b0:b80:1403:764c with SMTP id
 a640c23a62f3a-b80205e6bd3mr1604696566b.24.1766585972123; Wed, 24 Dec 2025
 06:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-4-philmd@linaro.org>
In-Reply-To: <20251224133949.85136-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:19:06 +0200
X-Gm-Features: AQt7F2r8_tTGimgEnANVoVpoYZyPESBDy0Rqbqld7CiREi4ONtAc_wqCl1vlOs4
Message-ID: <CAAjaMXZT4whGPbb71_C+e2Ge=g_zz1ZWASYsUWmViLiPj4zGSA@mail.gmail.com>
Subject: Re: [PATCH 3/6] monitor/hmp: Remove target_long uses in memory_dump()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

On Wed, Dec 24, 2025 at 3:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Pass a plain vaddr type to express virtual address.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  monitor/hmp-cmds-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index c00f75eab3c..d2bdf44dafd 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -232,7 +232,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict=
)
>      int count =3D qdict_get_int(qdict, "count");
>      int format =3D qdict_get_int(qdict, "format");
>      int size =3D qdict_get_int(qdict, "size");
> -    target_long addr =3D qdict_get_int(qdict, "addr");
> +    vaddr addr =3D qdict_get_int(qdict, "addr");
>
>      memory_dump(mon, count, format, size, addr, 0);
>  }
> --
> 2.52.0
>

