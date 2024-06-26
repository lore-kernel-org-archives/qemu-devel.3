Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A59C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 06:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMM1a-0004M9-Il; Wed, 26 Jun 2024 02:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMM1X-0004LR-7k; Wed, 26 Jun 2024 02:20:55 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMM1U-000569-KJ; Wed, 26 Jun 2024 02:20:54 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80d6c63af28so1701123241.0; 
 Tue, 25 Jun 2024 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719382851; x=1719987651; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gahf712DjtwjxXJvTM7DUlfoIDF3S17NjxZc56naeKI=;
 b=Uzpw1Mf1157cGT+HX84x9u2lR5KnqbV5EGuI/X992xRiT23peoib6yHXrSTwolBnKI
 20JRfCARdT1xafOBBvLILdtr7in8eDMJaitb/lgfF+eHg+gJI/nAM+PVwlPNO5fRR93q
 NDSrervLma06XHnI3jEhoZyYFEjK4hULXaoSNDESm6jCGyu+eFW7I0qk6H3NXc7IZ4+d
 FLt2wJ+DRdI5yt39o/sJIugA3i97iFP1YnCZ/4rZhlYraTwYQsfdyWB63nFOyFDP2w34
 bOu4dM40I8Y2+hgPzIfeMS7MSAGcZWS8+2WnQYmudAOpwX1rxgNqubERd9uKri1UrxPg
 un1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719382851; x=1719987651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gahf712DjtwjxXJvTM7DUlfoIDF3S17NjxZc56naeKI=;
 b=hLHqC1bPm7RE8uB1sDPZKU6IBroNSaGgVEuUE9biBnyu1cuhIRHeK1JMA5TjyO+l9X
 bztiAtasdLy5WoYv2Ho2LDqQcmLTgvp0DD24Kf0XNub0SRr1CQ8KUXDek6A827p7sCop
 19ORNQ7RyWmXF/nutuBui4n59NWwSRBzBj3DSBbba6WZdxQWDHbYXalR8R7VsDRx0Yck
 gnKjzvZOEg2KXXW/g08uc0ulyxRBvjjl6zo8WVT/5KjuwJJU0bhfj0XPHL/AUXJNKGBa
 ubdwUK7CV7XCYlTUL7Uj2mtXpXKlepfoCwexrEk87bo4cLN8fGeB+Jd8LMdZg5uO8qJ+
 8NDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7t8xcEcLTJa4MrZI19y16b0Fqo1obyIcpnDxE3wj2VKOcTKY3QB70GJ/iDu+nhtMJfLzXCbdYPPDRSxYe4F1pdts3dns=
X-Gm-Message-State: AOJu0Yz77EJ+Hk798nqZvQyQf4GsfW+OlnWUvc+LBuHPMyF/meLOMVkf
 sIKdZrQ7jY9H7Ha9HxKO5mF5OI+bI/jWucePeEkPybDAFbzFPYGPFLN2iOewbfSDmD4pFdIi+Kd
 knyi9x12YqQx+T2RNypodza3w/NE8Ow==
X-Google-Smtp-Source: AGHT+IGOTT9AEeJICHmqRttT42SVU+LeQRvX9EwjiTjTuX6RZGB4LtyEjxUknt6c50E6rOKZ9GzHmwMr2DN2bIIQd98=
X-Received: by 2002:a05:6102:114c:b0:48f:56a2:6128 with SMTP id
 ada2fe7eead31-48f56a2635amr7490743137.17.1719382851069; Tue, 25 Jun 2024
 23:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240604041445.244768-1-alvinga@andestech.com>
 <20240604041445.244768-2-alvinga@andestech.com>
In-Reply-To: <20240604041445.244768-2-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 16:20:24 +1000
Message-ID: <CAKmqyKOngPTAyno29HNBhFZ-GdU+0Jw2ymSadmTc3oR7r5P+MQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] target/riscv: Add functions for common matching
 conditions of trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jun 4, 2024 at 2:42=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu.o=
rg> wrote:

The `From` address is mangled here. It shows it was sent from the list
instead of your actual email address.

Do you mind looking into your email setup and see if you can fix it?

Alistair

>
> According to RISC-V Debug specification version 0.13 [1] (also applied
> to version 1.0 [2] but it has not been ratified yet), there are several
> common matching conditions before firing a trigger, including the
> enabled privilege levels of the trigger.
>
> This commit adds trigger_common_match() to prepare the common matching
> conditions for the type 2/3/6 triggers. For now, we just implement
> trigger_priv_match() to check if the enabled privilege levels of the
> trigger match CPU's current privilege level.
>
> [1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vo=
te
> [2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asc=
iidoc
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/debug.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index b110370ea6..05e001d041 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -241,6 +241,76 @@ static void do_trigger_action(CPURISCVState *env, ta=
rget_ulong trigger_index)
>      }
>  }
>
> +/*
> + * Check the privilege level of specific trigger matches CPU's current p=
rivilege
> + * level.
> + */
> +static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
> +                               int trigger_index)
> +{
> +    target_ulong ctrl =3D env->tdata1[trigger_index];
> +
> +    switch (type) {
> +    case TRIGGER_TYPE_AD_MATCH:
> +        /* type 2 trigger cannot be fired in VU/VS mode */
> +        if (env->virt_enabled) {
> +            return false;
> +        }
> +        /* check U/S/M bit against current privilege level */
> +        if ((ctrl >> 3) & BIT(env->priv)) {
> +            return true;
> +        }
> +        break;
> +    case TRIGGER_TYPE_AD_MATCH6:
> +        if (env->virt_enabled) {
> +            /* check VU/VS bit against current privilege level */
> +            if ((ctrl >> 23) & BIT(env->priv)) {
> +                return true;
> +            }
> +        } else {
> +            /* check U/S/M bit against current privilege level */
> +            if ((ctrl >> 3) & BIT(env->priv)) {
> +                return true;
> +            }
> +        }
> +        break;
> +    case TRIGGER_TYPE_INST_CNT:
> +        if (env->virt_enabled) {
> +            /* check VU/VS bit against current privilege level */
> +            if ((ctrl >> 25) & BIT(env->priv)) {
> +                return true;
> +            }
> +        } else {
> +            /* check U/S/M bit against current privilege level */
> +            if ((ctrl >> 6) & BIT(env->priv)) {
> +                return true;
> +            }
> +        }
> +        break;
> +    case TRIGGER_TYPE_INT:
> +    case TRIGGER_TYPE_EXCP:
> +    case TRIGGER_TYPE_EXT_SRC:
> +        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n", =
type);
> +        break;
> +    case TRIGGER_TYPE_NO_EXIST:
> +    case TRIGGER_TYPE_UNAVAIL:
> +        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\=
n",
> +                      type);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return false;
> +}
> +
> +/* Common matching conditions for all types of the triggers. */
> +static bool trigger_common_match(CPURISCVState *env, trigger_type_t type=
,
> +                                 int trigger_index)
> +{
> +    return trigger_priv_match(env, type, trigger_index);
> +}
> +
>  /* type 2 trigger */
>
>  static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong c=
trl)
> --
> 2.34.1
>
>

