Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62329C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiv1y-0007GC-NI; Mon, 04 Aug 2025 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiuFY-0004yj-N8
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:25:11 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiuFW-0002Ae-A6
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:25:07 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-712be7e034cso37932267b3.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754310305; x=1754915105; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jkpMkCEFN+3DuTId4gdEnuPVXQJW+IwhbmJ4dhsWCGk=;
 b=udSF+aY9IxryhJnuw/w0l4CtEYl8zsw0DHeonMail4GkjH8gh0VHHQGG5OK3AX1o4T
 MpMrqKaUr8XnoNIP7KPD8cZQnFkmUh5/a44mnVv4D2xCYb4UYrtYT1wVNYVU2hwfRt8j
 277DzqGTwb5byKp3DSJsgaEoPV+owJSwE7guLO27f1PIp0gUFe00GEmTwwAHa0h3HAYQ
 3J49p0ej/1K3/eGqUsyuXRRcRK1TzmIkGRPDDwD+Zl88dPUNUb/rjZQOZKhHUXA1L67p
 vZxAZf0wmecsDIQ+y4JtKAHKWhB3XKhJWE5A8yy4sGx3IKCJIUKHbj2FykP7h7M+yakE
 yxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754310305; x=1754915105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jkpMkCEFN+3DuTId4gdEnuPVXQJW+IwhbmJ4dhsWCGk=;
 b=iP1jqYg0hsveolBefZPRcJpDidKY+rbqmLh05i9iQ7a5OIQeXNWfn8IWWMmsVfHyY5
 J+xhevQprfoJEoIXGY3w/1sudyt7Kw5/4LPB4u7b4rtZI6bG+ASAtyG3bfLC3MrM7t9Y
 i4uN3qQwCZH6EielDUBKcEwV88HKounXBbKMifYlfVcgEn1+tew3c2CYx9LWhNKiLzcr
 N3arn9BE6RxD7Ip0/eW/g1bzr/wZIParVK2M3Ijq01UZJu8SgSBrXGegtxlODeibIFGW
 vf8KdmKOUvJIrM9JeNiYqqExm0f6iLy91CRuF4Az5F92oHx/VN6uO74aySvWz1qXyESf
 5pgw==
X-Gm-Message-State: AOJu0YxojPY/XepRvR9h+sea0eq/L5UX0g23sGxQVolBZGa00qzdmYrn
 L0Jvs6zBYFf4745CVr+XTzEhMY92m+YZRR7EwahiOm2biJrFbS9hn8rccMwGYGoSD1ZrAMMFMza
 j/0twQqh2Ph2r+zjiQjTZmtEngOItVpzl87XIUdxEeg==
X-Gm-Gg: ASbGncvy+394dKUzvv7GW8x/wrAKdv8pALHuCdvvWQnH7+i9I0CJAdWHutzJFTrGalp
 VcHATRwHEwdVyVNQ0EgpW52qi8dkzXQUsjzyAqNqSa/8pgJzGGl1UAIxOEp4wthBSbCOGcTcgWn
 bvRMopiVZv9qpFtZuCkNBN7xt/FSBdKTbfo1QtZiS3fzZtzmuDj3DguI7qmrz0jrsmaUyO53BZB
 D5JV3EyOPOkoIVfh4w=
X-Google-Smtp-Source: AGHT+IFQJ/znbxOONyTl16/C5Y1S38EA1I1UHM+snittR/zNCN1qWA14pSG/LppCgM/JgYh0IY9TgapUcry0e7At/ck=
X-Received: by 2002:a05:690c:660f:b0:71a:2d5f:49ae with SMTP id
 00721157ae682-71b7f5e1304mr111743697b3.6.1754310304938; Mon, 04 Aug 2025
 05:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
In-Reply-To: <20250716095432.81923-14-luc.michel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 13:24:52 +0100
X-Gm-Features: Ac12FXw5hYM7S5lWY_h5eG6eAXt1iHL4O7ekcFpHEI3ZjoR5UJQi607sHGae1XQ
Message-ID: <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 16 Jul 2025 at 10:55, Luc Michel <luc.michel@amd.com> wrote:
>
> Improve the IRQ index in the VersalMap structure to turn it into a
> descriptor:
>    - the lower 16 bits still represent the IRQ index
>    - bit 18 is used to indicate a shared IRQ connected to a OR gate
>    - bits 19 to 22 indicate the index on the OR gate.
>
> This allows to share an IRQ among multiple devices. An OR gate is
> created to connect the devices to the actual IRQ pin.


> +/*
> + * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
> + * used to return the corresponding or gate input IRQ. The or gate is created if
> + * not already existant.
> + *
> + * Or gates are placed under the /soc/irq-or-gates QOM container.
> + */
> +static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> +                                          qemu_irq target_irq)
> +{
> +    Object *container = versal_get_child(s, "irq-or-gates");
> +    DeviceState *dev;
> +    g_autofree char *name;
> +    int idx, or_idx;
> +
> +    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> +    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> +
> +    name = g_strdup_printf("irq[%d]", idx);
> +    dev = DEVICE(object_resolve_path_at(container, name));
> +
> +    if (dev == NULL) {
> +        dev = qdev_new(TYPE_OR_IRQ);

Here we create a device...

> +        object_property_add_child(container, name, OBJECT(dev));
> +        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
> +        qdev_realize_and_unref(dev, NULL, &error_abort);
> +        qdev_connect_gpio_out(dev, 0, target_irq);
> +    }
> +
> +    return qdev_get_gpio_in(dev, or_idx);

...but then we don't save the pointer to it, so the only
thing still hanging onto it is the QOM tree.

If you want to change "embedded device struct" into
"allocate memory to create devices" that's fine, but the
SoC should still keep track of everything it's creating,
so that (at least in theory) it could clean it up on
unrealize.

thanks
-- PMM

