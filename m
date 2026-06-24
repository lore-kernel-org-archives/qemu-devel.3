Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB5CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcR1d-0005KV-70; Wed, 24 Jun 2026 13:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcR1V-0005J7-0f
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcR1S-0005f4-3Q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782320660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/Nxu1go6cVhB8TcmsWmtIhS+4r8Mj0nDW+Bpk7W7AY0=;
 b=OM8w9/pa9aVN5ESE/YeqHnOghP/aqRl6NWWJRgniJVvk96MzhiEgzfVv9J7/HAi15Hkhsf
 RdNlxHOFEUXTRalj0I5vzgwStRo8RZOzjIRSGSlBT31XYmYTjfSNCgx2eJPGvq9VKgh6Zt
 T8T3waXNNAmSWzpYYYdYthWtFjK+fLA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-mixTE3iLPRmPlcDkRVnYFA-1; Wed,
 24 Jun 2026 13:04:17 -0400
X-MC-Unique: mixTE3iLPRmPlcDkRVnYFA-1
X-Mimecast-MFC-AGG-ID: mixTE3iLPRmPlcDkRVnYFA_1782320655
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45F001800581; Wed, 24 Jun 2026 17:04:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F087419560A1; Wed, 24 Jun 2026 17:04:11 +0000 (UTC)
Date: Wed, 24 Jun 2026 18:04:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: alistair@alistair23.me, peter.maydell@linaro.org, kfting@nuvoton.com,
 wuhaotsh@google.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
Message-ID: <ajwOCBoTqZWJ2lqD@redhat.com>
References: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
 <20260624153322.1470576-3-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624153322.1470576-3-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 24, 2026 at 04:32:30PM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/adc/npcm7xx_adc.c | 75 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
> index 3584c27c75..accaaf2620 100644
> --- a/hw/adc/npcm7xx_adc.c
> +++ b/hw/adc/npcm7xx_adc.c
> @@ -20,6 +20,8 @@
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/registerfields.h"
>  #include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> @@ -229,7 +231,6 @@ static void npcm7xx_adc_init(Object *obj)
>  {
>      NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    int i;
>  
>      sysbus_init_irq(sbd, &s->irq);
>  
> @@ -240,15 +241,63 @@ static void npcm7xx_adc_init(Object *obj)
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
> +static void npcm7xx_adc_get_input(Object *obj, Visitor *v,
> +                                  const char *name, void *opaque,
> +                                  Error **errp)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    uint32_t idx, val;
> +    int res;
> +
> +    res = sscanf(name, "adci[%u]", &idx);
> +    if (res == EOF || res != 1) {
> +        error_setg(errp, "unable to parse index from %s", name);
> +        return;
> +    }
> +
> +    val = s->adci[idx];
> +    visit_type_uint32(v, name, &val, errp);
> +}
> +
> +static void npcm7xx_adc_set_input(Object *obj, Visitor *v,
> +                                  const char *name, void *opaque,
> +                                  Error **errp)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    uint32_t idx, val;
> +    int res;
> +
> +    res = sscanf(name, "adci[%u]", &idx);
> +    if (res == EOF || res != 1) {
> +        error_setg(errp, "unable to parse index from %s", name);
> +        return;
> +    }
> +
> +    val = s->adci[idx];
> +    if (!visit_type_uint32(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    s->adci[idx] = val;
> +}
> +
> +static void npcm7xx_adc_set_vref(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    uint32_t vref = s->vref;
> +
> +    if (!visit_type_uint32(v, name, &vref, errp)) {
> +        return;
> +    }
> +
> +    s->vref = vref;
> +}
> +
>  static const VMStateDescription vmstate_npcm7xx_adc = {
>      .name = "npcm7xx-adc",
>      .version_id = 0,
> @@ -275,6 +324,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
>  {
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    int i;
>  
>      dc->desc = "NPCM7xx ADC Module";
>      dc->vmsd = &vmstate_npcm7xx_adc;
> @@ -282,6 +332,17 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
>      rc->phases.hold = npcm7xx_adc_hold_reset;
>  
>      device_class_set_props(dc, npcm7xx_timer_properties);
> +
> +    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
> +        object_class_property_add(klass, "adci[*]", "uint32",
> +                                  npcm7xx_adc_get_input,
> +                                  npcm7xx_adc_set_input,
> +                                  NULL, NULL);
> +    }

IMHO the logic around "[*]" expansion is mostly useful for child
properties where you don't know ahead of time how many relationships
might already exist.

In this case though, we know exactly how many props we want and we
know we want to start from 0. 

How about we do this explicitly:

   g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
   object_class_property_add(klass, adciprop, "uint32",
                             npcm7xx_adc_get_input,
                             npcm7xx_adc_set_input,
                             NULL, NULL);

which avoids the O(N^2) performance of handling '[*]' and
thus makes the prior patch redundant.

I kind of wish we didn't have '[' in the property name but
we're probably stuck with that for back compat.

> +    object_class_property_add(klass, "vref", "uint32",
> +                              NULL,
> +                              npcm7xx_adc_set_vref,
> +                              NULL, NULL);
>  }
>  
>  static const TypeInfo npcm7xx_adc_info = {
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


