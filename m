Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DCFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxz5-0000WG-JT; Tue, 28 May 2024 10:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxz4-0000Vo-E6
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:39:26 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxz2-0003xC-UO
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:39:26 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5785199e0d6so1325539a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716907163; x=1717511963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82Dad7r9mnGdA86VN1MU+SipozoAUOPsiZ7WniVAyRg=;
 b=i2An08heFD5PI8ufXDeF2HIAwonMoBE5bDz960tKXyKMbDlhb/Dq4SXC/bq7Vs21rd
 0KDZWPDZsBQbCj8gkPQtfFOmUL5W+jj5H7UmSxWF2Cb/udB32VfatmMyMUAzd5klBWB6
 Oo0d64BSZsXtlWF3HqYpC5vjFhDowZrAfy5q10F8D84mJjFxS3aDb0EWtYzN70LOA5Cn
 JQICfsqVF8RHXddRqQns3yB0kbu73/mUmVKYEKZ5gtayTmbeuYGZ4hgEa70RpHdbf8Tz
 S2IXfEc61S/dZQbsf/2oDHfVM3IChV0+I3LrtPowDNvui7sLrZG87/U7MDoOote6PSUU
 n1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907163; x=1717511963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82Dad7r9mnGdA86VN1MU+SipozoAUOPsiZ7WniVAyRg=;
 b=dc8Xd2xyQ6day5YhUGcYVaxqFOvzSeU+sGT/aXInITTIc9+10fCHZMS+wLU+p0m6gr
 ofD4LZip+v3xcnhnyyO42rql64kzKheY1VwEODhAZTamAFedlNpcAxs9TsVtHjUBp9BY
 uA0x2WFm/3l4w9c1MRtZArqXyZPhJg0m8Jzm0jotptq9pjMgM2T/jj2MKjS2pSDJ8ult
 XkEo4OhYEiKkjIZ1YGrq5PJP/IrWm2n/8XOZlo3bdSgTtpYo1w6qPui7ssPDJ+ycSuVo
 T3XBZYKwTjhz3Xfj4pF1ZbFOndYbaZmNsWgu6IEnP/Hja8LdXhgKlu4wie9ppj4bN0ZS
 evdw==
X-Gm-Message-State: AOJu0YwSIZFU2r1LnjBBh+rcc2gdKFX+4AR7SeJ5Q/7kxxSFQXeqPzbR
 ITcwo7Xu3h/xwHIgnVX8FsHK0lO6u2k24wIc1SKJndQo4FjKWnFe03kO9u7EzmODzl5DKM5T2PN
 tY1+KVqzDt5ccrpcxmXH9ZmsF4JHl/4zjdnaG9Q==
X-Google-Smtp-Source: AGHT+IE/mfD9LNjwtaF/VBPziMkUPfqcW8wvGzsxJd7AprfLekckVu4Um6VjEahxvnLM3lwHKD8ZnsnnNNP7FDKxo6A=
X-Received: by 2002:a50:a45d:0:b0:578:632e:6794 with SMTP id
 4fb4d7f45d1cf-578632e6d9fmr11865679a12.10.1716907163547; Tue, 28 May 2024
 07:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240523194441.21036-3-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 15:39:12 +0100
Message-ID: <CAFEAcA-zQKi3Wt_wxHOEXRywCNrK=-Mrt1ZgX390de2Y0BsT8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] hw/char: Use v2 VMStateDescription for STM32L4x5
 USART
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc@lmichel.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 23 May 2024 at 20:44, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> `vmstate_stm32l4x5_usart_base` namely uses `VMSTATE_CLOCK` so
> version needs to be 2.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/char/stm32l4x5_usart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index 02f666308c..0f16f0917a 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -546,8 +546,8 @@ static int stm32l4x5_usart_base_post_load(void *opaqu=
e, int version_id)
>
>  static const VMStateDescription vmstate_stm32l4x5_usart_base =3D {
>      .name =3D TYPE_STM32L4X5_USART_BASE,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,

I don't understand why we are bumping the version number here;
can you explain? Usually we bump the version number when we
add a new vmstate field to the vmstate, but this commit doesn't
do that.

thanks
-- PMM

