Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38732C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4KC-0002Xr-AI; Tue, 07 Jul 2026 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh4KA-0002Wz-KY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh4K7-00009R-St
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783425046;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0VYQT+LHVqjxpJgmd89ZTe5ZBs9GCf+grcMrDrJXCa0=;
 b=aiL5WFoq/6tfAwjlnZ3Sq2zfuxxd/XcuUVdUMOF5Ma3xAOUf3HokSzRxvxYu0y9b3C2vXY
 pXyqo00x8euPLFcy5uGc0BXjjXoM/yDGMRfA3uD/4KD4/EDI1Clc5qGibF5rZ84G7k/NqW
 LM5hF1fTcx/uNhjSvGLFtWFoZIRebG0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-AWj8xt4eMWGgBjM0kWRRrA-1; Tue,
 07 Jul 2026 07:50:42 -0400
X-MC-Unique: AWj8xt4eMWGgBjM0kWRRrA-1
X-Mimecast-MFC-AGG-ID: AWj8xt4eMWGgBjM0kWRRrA_1783425041
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5E401955DBA; Tue,  7 Jul 2026 11:50:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E566F36924; Tue,  7 Jul 2026 11:50:37 +0000 (UTC)
Date: Tue, 7 Jul 2026 12:50:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
Message-ID: <akzoCkJVpWsoPIV_@redhat.com>
References: <20260703143408.3235231-1-mark.caveayland@nutanix.com>
 <20260703143408.3235231-2-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703143408.3235231-2-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 03, 2026 at 03:32:17PM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/adc/npcm7xx_adc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
> index 3584c27c75..27d42f87b1 100644
> --- a/hw/adc/npcm7xx_adc.c
> +++ b/hw/adc/npcm7xx_adc.c
> @@ -229,7 +229,6 @@ static void npcm7xx_adc_init(Object *obj)
>  {
>      NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    int i;
>  
>      sysbus_init_irq(sbd, &s->irq);
>  
> @@ -240,12 +239,6 @@ static void npcm7xx_adc_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
>  
> -    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
> -        object_property_add_uint32_ptr(obj, "adci[*]",
> -                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
> -    }
> -    object_property_add_uint32_ptr(obj, "vref",
> -            &s->vref, OBJ_PROP_FLAG_WRITE);
>      npcm7xx_adc_calibrate(s);
>  }
>  
> @@ -275,6 +268,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
>  {
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    int i;
>  
>      dc->desc = "NPCM7xx ADC Module";
>      dc->vmsd = &vmstate_npcm7xx_adc;
> @@ -282,6 +276,17 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
>      rc->phases.hold = npcm7xx_adc_hold_reset;
>  
>      device_class_set_props(dc, npcm7xx_timer_properties);
> +
> +    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
> +        g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
> +
> +        object_class_property_add_uint32_ptr(klass, adciprop,
> +                offsetof(NPCM7xxADCState, adci[i]),
> +                OBJ_PROP_FLAG_READWRITE);
> +    }
> +    object_class_property_add_uint32_ptr(klass, "vref",
> +                offsetof(NPCM7xxADCState, vref),
> +                OBJ_PROP_FLAG_WRITE);

Are you sure this actually works ?

With the old code:

        object_property_add_uint32_ptr(obj, "adci[*]",
                &s->adci[i], OBJ_PROP_FLAG_READWRITE);

we're passing the absolute address of a struct field.

With the new code:

        object_class_property_add_uint32_ptr(klass, adciprop,
                offsetof(NPCM7xxADCState, adci[i]),
                OBJ_PROP_FLAG_READWRITE);

we're passing the relative offset from the start of the struct.

I agree this makes sense as the semantics we'd want/need, but it
doesn't seem to be what's actually implementefd

Both object_property_add_uint32_ptr and object_class_property_add_uint32_ptr
use the same property_get_uint32_ptr & property_set_uint32_ptr
callbacks.

IOW, afaict object_class_property_add_uint32_ptr is expecting to get
an absolute address, not a relative offset.

This seems to make object_class_property_add_uint32_ptr largely
useless unless trying to set global variables, instead of instance
level fields.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


