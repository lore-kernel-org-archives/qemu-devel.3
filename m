Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C02BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEI2h-0007Yg-2O; Mon, 03 Jun 2024 20:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI2d-0007MI-3M; Mon, 03 Jun 2024 20:28:43 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI2a-0003Cj-P4; Mon, 03 Jun 2024 20:28:42 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4eb0089b4a2so166065e0c.2; 
 Mon, 03 Jun 2024 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717460917; x=1718065717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XlkvZagI0/biGibflFteTod8KWoRms0TIY5VStJWzk=;
 b=PrKMT025cm0OgEM3PUWgG46CqSvw4j82eZEHRK7K9J6/tkeWNDT+gzb4zJ/614svKW
 WD3HIJ2u6ZrknhTThbES//yeci0YCIXCSwXy7w3BPd2FAQcNAlX4tUxF8PYud+6x7o+B
 In3/x8ddKMWa5MQuCxTbAgiW9tVJMhUWmXWVd6ZmE8hEHWxELFkaMuOhsZTaWy15COHm
 DEOnECghL23Nb/wij8FXp1xYp9hNgQ9+Zcbe2xgwgTD+q9SjfQ7CN/QKS+SZAqOWJuOV
 gJ36B9a/gkk9sS9zN5JOdDCi0n+EnG13GFPYjeNnrvNU4GH1LoeCCZlLyxod37PMcyMg
 IB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460917; x=1718065717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XlkvZagI0/biGibflFteTod8KWoRms0TIY5VStJWzk=;
 b=PkSjsqBrPAvr5mBRR7uGLgdTlWYTQhS4EH737iL0f9fU/vE8jKryA8eII7j9ggKEfs
 KDfNY6cHGV+Wo/+6f3O16ULdcnajIT1c6D3InwfKGKa0N3TSBckDcMxrK97HmpKhEm6P
 A9arXoyGTeseRd+D6W8Ni9kErlzwsB4vgVWB0eJsoKyWXL7cyTddbc4dFqXa5BgWzP06
 T0YfRlBWl9g+VYraGuGFrcmTXmvg2OR8owE+kx89jhWbiDubZ/e6otWlaKGP7vVo+Eo7
 sXmrKOyu07Ha2At3AEUPFUHjdaeFLfgWxQk+dIp3esB14qSKhrpWEVNmfgYAXCvVLHTM
 NhbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKe+49nzvoEU74V4LWuqYa/XdNVF39FCPEmxP6gU7JkNtJo8DAvPS/Olw9TGJKGQYhIgkdRPU8TpGLG+AbfrdSlSCq7TY=
X-Gm-Message-State: AOJu0YzcnVF6ueU0otO9sn0uEAVQyVVYkfvHe8tA7ongEB2JeGOR9IvD
 uqHfCW08M3GSQfnBdFpEDvHHbTGHjfLA/YPFtj7E5b+Vzozmrn663YPbmgcp5XYh3W9hNjd0Yd2
 TVjjIPrMXYFyuAAKySHxpONQNqEg9Wg==
X-Google-Smtp-Source: AGHT+IG4jCGP2yVq4UlbVy+/dAFqMEG3EEGMkY4ng3VGxa8Jf+uUbbHnd9lMhid0iYkoWw1KNkNQotWI9BC8UhPq9X0=
X-Received: by 2002:a1f:f847:0:b0:4ea:fe74:fe4a with SMTP id
 71dfb90a1353d-4eb02e0962cmr10047722e0c.1.1717460915351; Mon, 03 Jun 2024
 17:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240227012405.71650-1-alvinga@andestech.com>
 <20240227012405.71650-2-alvinga@andestech.com>
In-Reply-To: <20240227012405.71650-2-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:28:09 +1000
Message-ID: <CAKmqyKNgRvkFr0Tp2E4P_LB08XZFQ18xKZSZ471fXm-=JXzbeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] target/riscv: Add functions for common matching
 conditions of trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Feb 27, 2024 at 11:26=E2=80=AFAM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..3891236b82 100644
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

