Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07AFC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 06:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tntRF-0002kj-Pn; Fri, 28 Feb 2025 01:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntRA-0002h7-BD; Fri, 28 Feb 2025 01:01:29 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntR7-0001sl-Cx; Fri, 28 Feb 2025 01:01:27 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-866e8a51fa9so1540475241.1; 
 Thu, 27 Feb 2025 22:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740722484; x=1741327284; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMIek1Qt0SDB4Tnuhpt26UnDK8Zak53jHxoYGVgsG4g=;
 b=Q8OV2P3RrrGSTZRP+ryD8pkLMijSps7MDWvIONjrqhiOgnZcvxNhlEu7CWBYkzMGbB
 X31rgJ/XV8eYHsF7quLTg0pMyZYn+6lqaYJADAr/bD4M6mALL3tgPeAAPmaE+U4oJsEM
 L3YH7G0PAkK7sJNslG7ZEPcMGZEA4qxJCFTYMCNs5mRNeHekhQzc5KiA42Tih6viMCEd
 1bXW9oNpOqf9hbbtv8GVIKe+cYB4UdRP4ih1oClV4TapM3oQc4MfqLGb5gzpyRcjdeTd
 x3ubYREIMr7CZYo++xGEighvTIggnYRWO9U0BE1pzQBAthqzoRpnmrZRL1nuXK3kFOit
 Ct+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740722484; x=1741327284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMIek1Qt0SDB4Tnuhpt26UnDK8Zak53jHxoYGVgsG4g=;
 b=Mk/OzX97rFDWCZmc34M4XwzlgZ40FR0nvHYFU7tEk8RNNVxRxFpLUxQnP79gWJbb+q
 I6yDRhPjoQmjE5h6udeghOTPxmk36TJwWZeof7qGb0zPBanJq8kGyifwFQ8I4tw67DK0
 J4j1g4Itklng8vIC2R4uZ1sbljy6xMdUfqEUIseT8ePZTjF1TgvXlL72JBbnSf4JtzE3
 kHqgsxnlkPeJ2DAxPI0EEabW/F5K5uNUv5ApSlab0NhkRMGWkr3wRLG6iqk0el5fFYpe
 JY4jnAj5YUWe5l6qfuPLvOj094Lm9zw7jnn9cuQF0ObVVqO99pG9hX66vLEFSgt+EYb2
 crXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrPbEai09qxVVRFXgFDlmJORB7Sf/NgNcGYGokfCkccIbw7wfWCq12Wrrg1k1KZP1zQjn3DAteOFzU@nongnu.org
X-Gm-Message-State: AOJu0YyetmZMFYqqyzPfMme+MDJa9a57TyQPFKseSyir+SP8uLy6uuH5
 DJt84qv4ETwr71fQ2jh1AzooWDgwT6d2rCtEUeJWGdExcZEGdhuDsWtT5idJURckYNrlIJFmOt2
 Y9mY2cYZ8WwvT2NPDfY8FxGH3Qjc=
X-Gm-Gg: ASbGncsILtDlxWYjyL4+EkKcCd8/Ly8jUCV4dT22nniLFEU2qchqyk1ooGmdrwA9L8l
 uxA8GDf0TlDtGJFYTARu8SdcGq4kL7mDMQDyIrwxMuZTDaAvDvn0HdX6vUqDqG52rKHfuudY47r
 p+lQMUEnyPu/7viN4VKQhWOQwnl7ojL6S/lyVt
X-Google-Smtp-Source: AGHT+IE11FCg+b3D15xZcFMkKl6o7O+/2A207rYTaYhD90qwX0JRENrJKWPL/w/x72XPdUdTLfM5en95gTqYvbX94G4=
X-Received: by 2002:a05:6102:2d07:b0:4bb:dfd8:4195 with SMTP id
 ada2fe7eead31-4c0440581e8mr1865062137.3.1740722483878; Thu, 27 Feb 2025
 22:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20250122083617.3940240-1-ethan84@andestech.com>
 <20250122084725.3971111-1-ethan84@andestech.com>
In-Reply-To: <20250122084725.3971111-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 16:00:57 +1000
X-Gm-Features: AQ5f1Jp_0CoWe3_dj3-C7s9TlpGOZ7o7JjAC9mO88H0sRA2fksTN4GlVPi2c20k
Message-ID: <CAKmqyKM7mKhgmn7RKy7n3T_HgApwRvuQFbmnmxBSukkXbi0inw@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] hw/misc/riscv_iopmp_dispatcher: Device for
 redirect IOPMP transaction infomation
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
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

On Wed, Jan 22, 2025 at 6:48=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> This device determines the target IOPMP device for forwarding information
> based on:
> * Address: For parallel IOPMP devices
> * Stage: For cascading IOPMP devices
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  hw/misc/meson.build                      |   1 +
>  hw/misc/riscv_iopmp_dispatcher.c         | 136 +++++++++++++++++++++++
>  include/hw/misc/riscv_iopmp_dispatcher.h |  61 ++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 hw/misc/riscv_iopmp_dispatcher.c
>  create mode 100644 include/hw/misc/riscv_iopmp_dispatcher.h
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 88f2bb6b88..497f83637f 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: fil=
es('sifive_e_aon.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prc=
i.c'))
>  specific_ss.add(when: 'CONFIG_RISCV_IOPMP', if_true: files('riscv_iopmp.=
c'))
> +specific_ss.add(when: 'CONFIG_RISCV_IOPMP', if_true: files('riscv_iopmp_=
dispatcher.c'))
>
>  subdir('macio')
>
> diff --git a/hw/misc/riscv_iopmp_dispatcher.c b/hw/misc/riscv_iopmp_dispa=
tcher.c
> new file mode 100644
> index 0000000000..4086e9c82b
> --- /dev/null
> +++ b/hw/misc/riscv_iopmp_dispatcher.c
> @@ -0,0 +1,136 @@
> +/*
> + * QEMU RISC-V IOPMP dispatcher
> + *
> + * Receives transaction information from the requestor and forwards it t=
o the
> + * corresponding IOPMP device.
> + *
> + * Copyright (c) 2023-2025 Andes Tech. Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "exec/exec-all.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/riscv_iopmp_dispatcher.h"
> +#include "memory.h"
> +#include "hw/irq.h"
> +#include "hw/misc/riscv_iopmp_txn_info.h"
> +
> +static void riscv_iopmp_dispatcher_realize(DeviceState *dev, Error **err=
p)
> +{
> +    int i;
> +    RISCVIOPMPDispState *s =3D RISCV_IOPMP_DISP(dev);
> +
> +    s->SinkMemMap =3D g_new(SinkMemMapEntry *, s->stage_num);
> +    for (i =3D 0; i < s->stage_num; i++) {
> +        s->SinkMemMap[i] =3D g_new(SinkMemMapEntry, s->target_num);
> +    }
> +
> +    object_initialize_child(OBJECT(s), "iopmp_dispatcher_txn_info",
> +                            &s->txn_info_sink,
> +                            TYPE_RISCV_IOPMP_DISP_SS);
> +}
> +
> +static const Property iopmp_dispatcher_properties[] =3D {
> +    DEFINE_PROP_UINT32("stage-num", RISCVIOPMPDispState, stage_num, 2),
> +    DEFINE_PROP_UINT32("target-num", RISCVIOPMPDispState, target_num, 10=
),
> +};
> +
> +static void riscv_iopmp_dispatcher_class_init(ObjectClass *klass, void *=
data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    device_class_set_props(dc, iopmp_dispatcher_properties);
> +    dc->realize =3D riscv_iopmp_dispatcher_realize;
> +}
> +
> +static const TypeInfo riscv_iopmp_dispatcher_info =3D {
> +    .name =3D TYPE_RISCV_IOPMP_DISP,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(RISCVIOPMPDispState),
> +    .class_init =3D riscv_iopmp_dispatcher_class_init,
> +};
> +
> +static size_t dispatcher_txn_info_push(StreamSink *txn_info_sink,
> +                                       unsigned char *buf,
> +                                       size_t len, bool eop)
> +{
> +    uint64_t addr;
> +    uint32_t stage;
> +    int i, j;
> +    riscv_iopmp_disp_ss *ss =3D
> +        RISCV_IOPMP_DISP_SS(txn_info_sink);
> +    RISCVIOPMPDispState *s =3D RISCV_IOPMP_DISP(container_of(ss,
> +        RISCVIOPMPDispState, txn_info_sink));
> +    riscv_iopmp_txn_info signal;
> +    memcpy(&signal, buf, len);

Shouldn't the `len` be verified before this?

Also, instead of copying if you can cast the `buf` pointer to a
`riscv_iopmp_txn_info` pointer

Alistair

> +    addr =3D signal.start_addr;
> +    stage =3D signal.stage;
> +    for (i =3D stage; i < s->stage_num; i++) {
> +        for (j =3D 0; j < s->target_num; j++) {
> +            if (s->SinkMemMap[i][j].map.base <=3D addr &&
> +                addr < s->SinkMemMap[i][j].map.base
> +                + s->SinkMemMap[i][j].map.size) {
> +                    return stream_push(s->SinkMemMap[i][j].sink, buf, le=
n, eop);
> +            }
> +        }
> +    }
> +    /* Always pass if target is not protected by IOPMP*/
> +    return 1;
> +}
> +
> +static void riscv_iopmp_disp_ss_class_init(
> +    ObjectClass *klass, void *data)
> +{
> +    StreamSinkClass *ssc =3D STREAM_SINK_CLASS(klass);
> +    ssc->push =3D dispatcher_txn_info_push;
> +}
> +
> +static const TypeInfo riscv_iopmp_disp_ss_info =3D {
> +    .name =3D TYPE_RISCV_IOPMP_DISP_SS,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(riscv_iopmp_disp_ss),
> +    .class_init =3D riscv_iopmp_disp_ss_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_STREAM_SINK },
> +        { }
> +    },
> +};
> +
> +void iopmp_dispatcher_add_target(DeviceState *dev, StreamSink *sink,
> +    uint64_t base, uint64_t size, uint32_t stage, uint32_t id)
> +{
> +    RISCVIOPMPDispState *s =3D RISCV_IOPMP_DISP(dev);
> +    if (stage < s->stage_num && id < s->target_num) {
> +        s->SinkMemMap[stage][id].map.base =3D base;
> +        s->SinkMemMap[stage][id].map.size =3D size;
> +        s->SinkMemMap[stage][id].sink =3D sink;
> +    }
> +}
> +
> +static void
> +iopmp_dispatcher_register_types(void)
> +{
> +    type_register_static(&riscv_iopmp_dispatcher_info);
> +    type_register_static(&riscv_iopmp_disp_ss_info);
> +}
> +
> +type_init(iopmp_dispatcher_register_types);
> +
> diff --git a/include/hw/misc/riscv_iopmp_dispatcher.h b/include/hw/misc/r=
iscv_iopmp_dispatcher.h
> new file mode 100644
> index 0000000000..bbaa76507b
> --- /dev/null
> +++ b/include/hw/misc/riscv_iopmp_dispatcher.h
> @@ -0,0 +1,61 @@
> +/*
> + * QEMU RISC-V IOPMP dispatcher
> + *
> + * Receives transaction information from the requestor and forwards it t=
o the
> + * corresponding IOPMP device.
> + *
> + * Copyright (c) 2023-2024 Andes Tech. Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RISCV_IOPMP_DISPATCHER_H
> +#define RISCV_IOPMP_DISPATCHER_H
> +
> +#include "hw/sysbus.h"
> +#include "qemu/typedefs.h"
> +#include "memory.h"
> +#include "hw/stream.h"
> +#include "hw/misc/riscv_iopmp_txn_info.h"
> +#include "exec/hwaddr.h"
> +
> +#define TYPE_RISCV_IOPMP_DISP "riscv-iopmp-dispatcher"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOPMPDispState, RISCV_IOPMP_DISP)
> +
> +#define TYPE_RISCV_IOPMP_DISP_SS "riscv-iopmp-dispatcher-streamsink"
> +OBJECT_DECLARE_SIMPLE_TYPE(riscv_iopmp_disp_ss, RISCV_IOPMP_DISP_SS)
> +
> +typedef struct riscv_iopmp_disp_ss {
> +    Object parent;
> +} riscv_iopmp_disp_ss;
> +
> +typedef struct SinkMemMapEntry {
> +    StreamSink *sink;
> +    MemMapEntry map;
> +} SinkMemMapEntry;
> +
> +typedef struct RISCVIOPMPDispState {
> +    SysBusDevice parent_obj;
> +    riscv_iopmp_disp_ss txn_info_sink;
> +    SinkMemMapEntry **SinkMemMap;
> +    /* The maximum number of cascading stages of IOPMP */
> +    uint32_t stage_num;
> +    /* The maximum number of parallel IOPMP devices within a single stag=
e. */
> +    uint32_t target_num;
> +} RISCVIOPMPDispState;
> +
> +void iopmp_dispatcher_add_target(DeviceState *dev, StreamSink *sink,
> +    uint64_t base, uint64_t size, uint32_t stage, uint32_t id);
> +#endif
> --
> 2.34.1
>
>

