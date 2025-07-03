Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453A2C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMrm-00062B-Sp; Thu, 03 Jul 2025 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMrd-0005zg-7F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:32:46 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMrX-0001Th-R3
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:32:44 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e81749142b3so6552610276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751560356; x=1752165156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pn5w1GsCyCVtzHTNJdoRMgZpRqJbtnjrQ18l0UfDKrk=;
 b=j+6n4oO2PX/nBiZFQt42GWAPEX7NGu7AVV8ffsh8ZdUM7pecd2D6dfUOTmhTgtWpf3
 YZk+12q4TAttm/VxVR1jTxOLrGbv/FAmkXDS5SFo0E0PFAZMZTpo+Vm6TI+EkHIWDl4x
 OTkJHU7uWbRX9NiahcF7qcjhY580wMrDwdK3py0zAKfF3ivVjBisIrBtXLBewZgSXtfn
 bDVlwNDxmzbauVW7wJVgE7hqDh2pbeV/u93AR6P8AokB6CRV9CvN8WVFQGrLLPBDGyvu
 G8WnWSJJD5D+WqBXJ1RovFX7Ay9EnBFd2ie4CJ9H437oGclQHQWTN9qWexNDk+G7wqES
 CY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560356; x=1752165156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pn5w1GsCyCVtzHTNJdoRMgZpRqJbtnjrQ18l0UfDKrk=;
 b=Q64Usj5dMNhGg5XkHRK0nrAr2Z79uS1Uo15esQD+HfZV8p3JgSJKTkZNnMOf4Xr0aF
 mT1LCrzI6zam9aGMKzpyplPIqQB0GzkBXXDsFfvQZeEygfkmveYJL7w1xFcJTeUVKHZ6
 Ql2LgQSNrpgJ+GWtTkB7n1n2AVSScLSVBMRxDIEqhzxsTwH+j42Q68NY/CBgeK2uYMss
 RFNzdSVFda/XpR/nPv3RyzuG+9KL5hM/B6qUPtsoj7VRr8ui9tDlJlkpD3GVACH1uhAr
 ZgDIaL6bOy1W7g+oqL9HiX+bNLNPPJVJE2zg4EhHZ8CVzCQxreVQa/K6CnanEpOaIZM9
 AeXw==
X-Gm-Message-State: AOJu0YzaVfb+9TQ299oCzXOWWBOMTeLs24GPBpp+4sQyFEUYX+jwKE08
 dNo0t+hGz4tNu4thJ9+6GJfXs3z1oRrcid4TMPLLRmDy0WKQvBkJjPA26ErOw6ZRvr7xLFA/Roc
 BFkZ597kPJm1P0g/Q9Tc0QKRVcuYoCFDBji/Hm1FnHSn51dzFf4B+
X-Gm-Gg: ASbGncttRZzygj0ZJrjydCRCSxAQCjOAgnwrtxnmdLAcdhpsLZVxktkz5OR4CIgDt6y
 XpBOkv5ZdoyTuw1RA7B9CKSynd5I6rmCJrv6Qx2zq4mp24eM5vw7GXRuBJN6ltlqkHvPJyeigAA
 wDl+LKgHHSNiz3fKTI87716L+fogAs1Ilr2jn91m1SY8IB
X-Google-Smtp-Source: AGHT+IFJZ1599vFfxDnyXlEEmgVFCBdQpH4QWWDGW6IGzGqNlv/BMnhTQ6NGtTG13d0GYv6Y4xrq2gWowv1ZuClJ1KA=
X-Received: by 2002:a05:690c:309:b0:6ef:5097:5daa with SMTP id
 00721157ae682-7164d56acc2mr114095247b3.34.1751560356440; Thu, 03 Jul 2025
 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-12-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-12-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:32:25 +0100
X-Gm-Features: Ac12FXxa0GCFt8QMKllfrw0NVPhjtPLKkMF3uB42p4IlbukCsT9QitI1D8pcTMU
Message-ID: <CAFEAcA-OQDE57TjZ9dVnW69GS_bqwULgENoYh0koJim9M5A3Yg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] MAX78000: Add AES to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds AES to max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/max78000_soc.c         | 12 +++++++++---
>  include/hw/arm/max78000_soc.h |  2 ++
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 09667b578c..f6d599a62e 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
>
>      object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
>
> +    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>  }
>
> @@ -133,6 +135,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      dev->id = g_strdup("trng");
>      object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
>
> +    dev = DEVICE(&s->aes);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
> +    dev->id = g_strdup("aes");
> +    object_property_set_link(OBJECT(gcrdev), "aes", OBJECT(dev), &err);
> +

Same comment about not touching dev->id as for earlier patches.

thanks
-- PMM

