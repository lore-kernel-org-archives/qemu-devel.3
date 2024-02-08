Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931DDC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7Qs-0005Op-JY; Thu, 08 Feb 2024 11:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7Qq-0005OF-EN
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:39:24 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7Qo-0006iV-Vz
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:39:24 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so131019a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707410361; x=1708015161; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xwgqSLILmN81PpPDr1feygrnHBHWAHPBrU3h95SQpbk=;
 b=Y31l/3zlXpFBnP9Y8bXRiA/Q4C+cWaUnL/VlC8QahvdABcLlObFecI2hLvH1/RJfky
 g31Sd0Lz7oVxnAWo4/TXX+wuLhqNQr2ttPng7j/zUNfjgfraTBQYgiDrdWqL/pj8pzox
 JyxcqC3Rh/TgL+WUbWj/BFJehfrvicUorDRI1SVcfRsPpNKINpN7ABLPaL6Ip7KojMgn
 AXbGutcfw60Wz5JYKwMKXmSxFu/YL3rvrU9e+LKd2BFJsnaQ5DWaB9d5+x+8oR+Ahe6D
 CexZG7mxovf1JuHlN+MWXecnZi7Ze5i1hVEaVarN7E4rfH/GYnescogaDLurM8qbKqbj
 c1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707410361; x=1708015161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xwgqSLILmN81PpPDr1feygrnHBHWAHPBrU3h95SQpbk=;
 b=KIqAhXon0Zm4U6wbraKIT2ME3o2QVhi2SE/dYY4ro8P1mSyxwmndbMJqBI5R0GzWd2
 MTL0OcBffEGv/+CND0Ih3PgoZ9raVh7cMWupDBcWEA+yUT2dk6j31UCUD0VcJsQVwnF5
 TmLv6HGJ/iaIh7Y9gLlp4oe2kSrdvovUJZjZ9XKNu4MPbMV1IOG2L1KftygD1thY4G9/
 RAYZ3xjYLoJdxvh/VDJaiCrgRhViQykLCxyDs/WTyDeK24aNIQnC9ymCM9+cLv/i6C0B
 rPII9IehZU7VlG2dt+all5KNNVjLrAf2G9K5nu7eieE74hkkzC8ilbkFPaZ6hIg4wV22
 lmBQ==
X-Gm-Message-State: AOJu0Yzblabt0w1V/sxl5k7WuvRkO9xsgovp6Hdi4OW4n8WedidD+byh
 NvhN2n4EZjfZoaPYeLwzcF+k+mMFyZbYGINZNXShuMlHW1pX591uHGe/tqdiSiTiHq1GBhUSneP
 o2qy/OwYUuEdZ3hdmaN4nUs2Iy+zTyN57Qk4ueFYM7+LTKHAW
X-Google-Smtp-Source: AGHT+IFJ1E7FF97cDZQKHSoVXR1fryN92VebkYUrLe8uYetkn78x/cjTwAOkM4SYJKwKy6p3xekBU4xHRwWZcA54h5g=
X-Received: by 2002:a05:6402:710:b0:560:24d8:d2d1 with SMTP id
 w16-20020a056402071000b0056024d8d2d1mr74365edx.11.1707410361182; Thu, 08 Feb
 2024 08:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
 <20240202204847.2062798-2-komlodi@google.com>
In-Reply-To: <20240202204847.2062798-2-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:39:10 +0000
Message-ID: <CAFEAcA8R13bQ7niSXhZPJ3vUD_OdNWpvjpKrWpz-gZsJxO_=dg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/i2c: core: Add reset
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 2 Feb 2024 at 20:48, Joe Komlodi <komlodi@google.com> wrote:
>
> It's possible for a reset to come in the middle of a transaction, which
> causes the bus to be in an old state when a new transaction comes in.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  hw/i2c/core.c        | 19 +++++++++++++++++++
>  include/hw/i2c/i2c.h |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 4cf30b2c86..3128067bba 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -23,10 +23,29 @@ static Property i2c_props[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void i2c_bus_hold_reset(Object *obj)
> +{
> +    I2CBus *bus = I2C_BUS(obj);
> +    I2CNode *node, *next;
> +
> +    bus->broadcast = false;
> +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> +        QLIST_REMOVE(node, next);
> +        g_free(node);
> +    }
> +}

This does what it says it's going to do; but I think it
would be good to hear from Corey whether it's better to
do this, or instead to call i2c_end_transfer() in the
reset-enter phase.

Mostly QEMU's "reset" is like power-cycling, in which case
I guess that what we have here where we just forget about
the in-progress transfer and assume the device on the other
end is also going to reset back to a neutral state is what
we want.

Does i2c have a concept of a bus-level "reset" operation?

> +
> +static void i2c_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    rc->phases.hold = i2c_bus_hold_reset;
> +}
> +
>  static const TypeInfo i2c_bus_info = {
>      .name = TYPE_I2C_BUS,
>      .parent = TYPE_BUS,
>      .instance_size = sizeof(I2CBus),
> +    .class_init = i2c_bus_class_init,
>  };



>  static int i2c_bus_pre_save(void *opaque)
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 2a3abacd1b..49580e30e2 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -64,7 +64,7 @@ struct I2CSlave {
>  };
>
>  #define TYPE_I2C_BUS "i2c-bus"
> -OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
> +OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)

I don't think you need this change any more ?

thanks
-- PMM

