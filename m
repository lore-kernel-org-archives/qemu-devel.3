Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5888CCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa5F0-00021V-Ve; Thu, 18 Jun 2026 01:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5Ez-00021E-GF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:37 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5Ex-00070a-E7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:37 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65I5O8Nk053708
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Jun 2026 14:24:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=y4BvBI8UPWBoU2ceh6yFXqUwb4Otv8Qb1TDyOX9Vh1M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781760249; v=1;
 b=bmX8mN8hoxRoR9ByKYklfaDA85S162n2MTA2A62d3hwBGCWDS/xNd+YAMk/ScSek
 lj2mzh0BKd5z4tE14cCGnD71oWW71XL4dTRntOChXTROtIFkSzyrCUt9Klk4m8/P
 UK4bUgLORwnT938DNo7yhb9I2R5CXULMiefXi2g6WgE2gcJLlCY2CARrlz8ArXmd
 MoUNMazzPM0lT/gE+BLPO82Aujj/Jmv6nKWa0tjPkVHMCj6divt1UX3dN8idm4a2
 XM2trAlucmI5GcOL51J2vwsgzl14ccbNl+XJ77M2sOksNVRuXWBUUY/ynAUS/s6x
 erG0cHvOyhWyvyxvZReqxw==
Message-ID: <0fa87239-9213-4c54-a72f-652aef1360a4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Jun 2026 14:24:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/7] system: add qemu_irq_new / qemu_irq_new_child /
 qemu_irq_new_array
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-6-berrange@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260616155554.264412-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/06/17 0:55, Daniel P. Berrangé wrote:
> Prepare for the move to dynamically allocated IRQ objects by
> introducing qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
> functions which call through to object_new instead of object_initialize.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/core/irq.c         | 35 ++++++++++++++++++++
>   include/hw/core/irq.h | 75 ++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 106 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 106805e241..e943c87b81 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -49,6 +49,13 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
>       init_irq_fields(irq, handler, opaque, n);
>   }
>   
> +IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n)
> +{
> +    IRQState *irq = IRQ(object_new(TYPE_IRQ));
> +    init_irq_fields(irq, handler, opaque, n);
> +    return irq;
> +}
> +
>   void qemu_init_irq_child(Object *parent, const char *propname,
>                            IRQState *irq, qemu_irq_handler handler,
>                            void *opaque, int n)
> @@ -57,14 +64,42 @@ void qemu_init_irq_child(Object *parent, const char *propname,
>       init_irq_fields(irq, handler, opaque, n);
>   }
>   
> +IRQState *qemu_irq_new_child(Object *parent, const char *propname,
> +                             qemu_irq_handler handler,
> +                             void *opaque, int n,
> +                             Error **errp)
> +{
> +    IRQState *irq = IRQ(object_new_with_props(TYPE_IRQ, parent, propname,
> +                                              errp, NULL));

object_new_with_props() rejects a property name including [*]. 
hw/char/serial-pci-multi.c passes "irq[*]" to qemu_init_irq_child() so 
this prevents simply replacing it.

Regards,
Akihiko Odaki

> +    if (!irq) {
> +        return NULL;
> +    }
> +    init_irq_fields(irq, handler, opaque, n);
> +    return irq;
> +}
> +
> +
>   void qemu_init_irqs(IRQState irq[], size_t count,
>                       qemu_irq_handler handler, void *opaque)
>   {
>       for (size_t i = 0; i < count; i++) {
> +        QEMU_DEPRECATIONS_OFF;
>           qemu_init_irq(&irq[i], handler, opaque, i);
> +        QEMU_DEPRECATIONS_ON;
>       }
>   }
>   
> +IRQState **qemu_irq_new_array(size_t count,
> +                              qemu_irq_handler handler, void *opaque)
> +{
> +    IRQState **irqs = g_new0(IRQState *, count);
> +    for (size_t i = 0; i < count; i++) {
> +        irqs[i] = qemu_irq_new(handler, opaque, i);
> +    }
> +    return irqs;
> +}
> +
> +
>   qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
>                              void *opaque, int n)
>   {
> diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
> index 291fdd67df..af9bf6fb12 100644
> --- a/include/hw/core/irq.h
> +++ b/include/hw/core/irq.h
> @@ -34,7 +34,12 @@ static inline void qemu_irq_pulse(qemu_irq irq)
>       qemu_set_irq(irq, 0);
>   }
>   
> -/*
> +/**
> + * qemu_init_irq: Initialize IRQ
> + * @handler: handler function for incoming interrupts
> + * @opaque: opaque data to pass to @handler
> + * @n: interrupt number to pass to @handler
> + *
>    * Init a single IRQ. The irq is assigned with a handler, an opaque data
>    * and the interrupt number. The caller must free this with qemu_free_irq().
>    * If you are using this inside a device's init or realize method, then
> @@ -42,7 +47,21 @@ static inline void qemu_irq_pulse(qemu_irq irq)
>    * to manually clean up the IRQ.
>    */
>   void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
> -                   int n);
> +                   int n)
> +    QEMU_DEPRECATED;
> +/**
> + * qemu_new_irq: Allocate IRQ
> + * @handler: handler function for incoming interrupts
> + * @opaque: opaque data to pass to @handler
> + * @n: interrupt number to pass to @handler
> + *
> + * The returned IRQ will have a single reference, which is held by the
> + * caller and must be released to free the returned IRQ object when
> + * no longer required.
> + *
> + * Returns: the newly allocated IRQ
> + */
> +IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n);
>   
>   /**
>    * qemu_init_irq_child: Initialize IRQ and make it a QOM child
> @@ -56,10 +75,38 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
>    * Init a single IRQ and make the IRQ object a child of @parent with
>    * the child-property name @propname. The IRQ object will thus be
>    * automatically freed when @parent is destroyed.
> + *
> + * Use of this function is now deprecated. All IRQs must be
> + * allocated using the qemu_irq_new() family of functions and not
> + * statically embedded in a larger struct.
>    */
>   void qemu_init_irq_child(Object *parent, const char *propname,
>                            IRQState *irq, qemu_irq_handler handler,
> -                         void *opaque, int n);
> +                         void *opaque, int n)
> +    QEMU_DEPRECATED;
> +
> +/**
> + * qemu_init_irq_child: Allocate IRQ and make it a QOM child
> + * @parent: QOM object which owns this IRQ
> + * @propname: child property name
> + * @handler: handler function for incoming interrupts
> + * @opaque: opaque data to pass to @handler
> + * @n: interrupt number to pass to @handler
> + *
> + * Allocate a single IRQ and make the IRQ object a child of @parent with
> + * the child-property name @propname.
> + *
> + * The returned IRQ will have a single reference, which is held by the
> + * @owner object in the QOM composition tree. Thus in the absence of
> + * any further references being acquired, the IRQ will be freed when
> + * @owner is freed
> + *
> + * Returns: the newly allocated IRQ
> + */
> +IRQState *qemu_irq_new_child(Object *parent, const char *propname,
> +                             qemu_irq_handler handler,
> +                             void *opaque, int n,
> +                             Error **errp);
>   
>   
>   /**
> @@ -69,9 +116,29 @@ void qemu_init_irq_child(Object *parent, const char *propname,
>    * @count: number of IRQs to initialize
>    * @handler: handler to assign to each IRQ
>    * @opaque: opaque data to pass to @handler
> + *
> + * Use of this function is now deprecated. All IRQs must be
> + * allocated using the qemu_irq_new() family of functions and not
> + * statically embedded in a larger struct.
>    */
>   void qemu_init_irqs(IRQState irq[], size_t count,
> -                    qemu_irq_handler handler, void *opaque);
> +                    qemu_irq_handler handler, void *opaque)
> +    QEMU_DEPRECATED;
> +/**
> + * qemu_irq_new_array: Allocate an array of IRQs.
> + * @count: number of IRQs to initialize
> + * @handler: handler to assign to each IRQ
> + * @opaque: opaque data to pass to @handler
> + *
> + * The returned IRQs will have a single reference, which is held by the
> + * caller and must be released to free the returned IRQs object when
> + * no longer required. The return array memory must also be freed by
> + * the caller.
> + *
> + * Returns: an array of IRQ objects
> + */
> +IRQState **qemu_irq_new_array(size_t count,
> +                              qemu_irq_handler handler, void *opaque);
>   
>   /* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
>    * opaque data.


