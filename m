Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE7CCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 20:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uycPw-0005p5-9p; Tue, 16 Sep 2025 16:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steviea@google.com>)
 id 1uycPs-0005oU-88
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 16:36:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <steviea@google.com>)
 id 1uycPq-0004vJ-JJ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 16:36:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-265f460ae7bso47465ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758054999; x=1758659799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yf1ZDzwXdB2A2eNZdnLqHYk2R3XFN3FkaKolUJPzAs0=;
 b=CQxzAMQ3qvZ6xUNatAItcQLBp64rmWATqAZ+FgZR3ywgB9sl+mb5Wyz9eIvthRIWUS
 BLhm6uoKIy7cMqxIeh0B7MNHBuJMwBrPpX7oizELoN7HUX67F8q+sDnGfAO9s+2mAywR
 SHgMmvNEUhpnfDmXfAnBbRKQeoMyUydYG+gisSAA3uAhrtPYO3PE9gNhszETucTf++os
 27gmYw3QrXgKOqEtiEASQ9xu7tA5veZQl946P1ouWszrU9GGnvgw+APbNiRGEHDIgyBa
 UbuFRj+H7v/rb78xg6c/Q8G+idxEoycHd3HOWh2f+32P7NUhx1nbSd3B1aWbdYKBR70C
 OOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758054999; x=1758659799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yf1ZDzwXdB2A2eNZdnLqHYk2R3XFN3FkaKolUJPzAs0=;
 b=tqdFavAUWnD7LeqKWO8xnRMuZADIyUFDXXr5XYtFHgYkR/XpyDSc2zhi6ROB8Z9Bme
 e0ME7mW6YI3/Zbxsg7VkeYBv5FdBSMfRn6+ko/pgT3TMtfvPFEiaPvxE/A68e8DVCr+y
 sr46aKgIhRSSC9bXM91v6DRg0r1RCPaSWfhg2oJJ1VJarxXK1VfEn3hg2AJ7YgqolO+0
 fHQddWE0y7reaMOv1eM+be3OLbN8u73/zNjoOqxFEmKKwMnr5dJV/dpprjP7BzkEfE5z
 EnUyLjnmNhfti7yVPW81E79iNBZvEWRZsQNASMy89r10dB/UjP9xteTysEBUXUlhnJGF
 0QKg==
X-Gm-Message-State: AOJu0YyZscK71FKcVep3c+xQ6SLiQwT2wwJy5VytY/Q2iDOBVWNjfMsp
 O4BOe5gMfYc+oPvJzNlfGb8JGjF7Ea1rJsgRb2cgpakHT36V2SbB0faBqLerJTMyYJbubKw0Bmm
 RD3mUeXz8L8Suj26HMByPln7hnUGWAhcZ3PWyXSabPkU47ObxD77C8pDhwTg=
X-Gm-Gg: ASbGnctfM1Qtn/wgP7Y7f0K1KVMSxemLfC8jhIbPULtsd03gErVK9T95+znoGrPQb5+
 xon0IAF493bxLVsTTbJYRcRwrt7AIehzmF5M1GC99oOd+8IQd4weBrEwLa82y9xZF/TtM8F2qS8
 I8aF5cPLkA8TuDIzkMg4FFesiLy2wSRzZJrO2vs8FGlDgoizgbMErs0tSadcprvIEY48sJOF02E
 PuBb9Dy+VsDYezigk0sP0xWqDYf26slIyrybRH/oeoka3QKTeTW6v0Iom7LAxaQ5A==
X-Google-Smtp-Source: AGHT+IGJ/qM1jgPOlJ83hAcqd4LJmOZxA+vP+3o5lDEMWsO6mAT4G9PxUAy/IFs6i1RbeDO5kZ7Eoh2UCDRKchkmi0U=
X-Received: by 2002:a17:902:da8b:b0:24b:1b9d:58f1 with SMTP id
 d9443c01a7336-26808af2256mr184225ad.17.1758054999111; Tue, 16 Sep 2025
 13:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250916165859.1718787-1-steviea@google.com>
In-Reply-To: <20250916165859.1718787-1-steviea@google.com>
From: Stevie Alvarez <steviea@google.com>
Date: Tue, 16 Sep 2025 13:36:27 -0700
X-Gm-Features: AS18NWAaYUA9bXuMJJbd-WxMPLviaxaCW8kmjDiuq-5RxwTPwqyrOubLE8Hapac
Message-ID: <CALeaR2rPWGPjxVHihWCRyD8RY0GU6QZez78ki3XaetLQBRw2mg@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pca954x: enable vmstate
To: qemu-devel@nongnu.org
Cc: venture@google.com, cminyard@mvista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=steviea@google.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 9:59=E2=80=AFAM Stevie Alvarez <steviea@google.com>=
 wrote:
+ CC Corey Minyard for I2C maintainers.
>
> From: Patrick Venture <venture@google.com>
>
> Add missing vmstate support.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  hw/i2c/i2c_mux_pca954x.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index a8ef640cd2..78828acafb 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -22,6 +22,7 @@
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
> +#include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qemu/queue.h"
> @@ -211,6 +212,18 @@ static void pca954x_init(Object *obj)
>      }
>  }
>
> +static const VMStateDescription pca954x_vmstate =3D {
> +    .name =3D TYPE_PCA954X,
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_SMBUS_DEVICE(parent, Pca954xState),
> +        VMSTATE_UINT8(control, Pca954xState),
> +        VMSTATE_BOOL_ARRAY(enabled, Pca954xState, PCA9548_CHANNEL_COUNT)=
,
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const Property pca954x_props[] =3D {
>      DEFINE_PROP_STRING("name", Pca954xState, name),
>  };
> @@ -228,6 +241,7 @@ static void pca954x_class_init(ObjectClass *klass, co=
nst void *data)
>
>      dc->desc =3D "Pca954x i2c-mux";
>      dc->realize =3D pca954x_realize;
> +    dc->vmsd =3D &pca954x_vmstate;
>
>      k->write_data =3D pca954x_write_data;
>      k->receive_byte =3D pca954x_read_byte;
> --
> 2.51.0.384.g4c02a37b29-goog
>

