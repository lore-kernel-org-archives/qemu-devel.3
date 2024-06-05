Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33A4C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElPE-0001bP-Rt; Wed, 05 Jun 2024 03:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sElPD-0001am-SD
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sElPC-0002qT-33
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717573796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hJH0D9ZuyzjDbV55z9uexRo9GJb5L8V7B2slff7xdSM=;
 b=VbeckPVVkUc8uCKbRhpi6uPEFwmve+t4Xtpv7pobFX/+5fVLot5X7lAPSNrY9nHzqY7wPZ
 dPq3pf82pgfnOjmW9fNgkFffaX9Bru9DG0Rg0cQVjGDw/DpXksjmA7mhj84HXI5AddxToq
 vfRQhjCdNsaha3oshCIDM2TBOqmkMfA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-5Bo_onJnPLmbH7ccsFDLrw-1; Wed, 05 Jun 2024 03:49:54 -0400
X-MC-Unique: 5Bo_onJnPLmbH7ccsFDLrw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so3931551f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717573793; x=1718178593;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJH0D9ZuyzjDbV55z9uexRo9GJb5L8V7B2slff7xdSM=;
 b=COHuvLzabtYLEeDm+O4FSSrboMdMw04ycEl/iCEOU9+AAdFuY7jS68bakatXXrGin2
 X2n4ee2LYiWTS0WfI/VXd8Mif+aZJ28KqtYcSBtcfiLvU0vsKH/HfWnepbzbOT2/cFYt
 LJqwl6elbNRvDmzMrMV57l8VO30c+aN0rpNDK4jbpKWno3Du9ufgOyghHK3G6d4VLJK+
 UpuJ0xC//wM0FQTZNyT7aWtSpid5fr5VjsC5FY5Az7zle5onZ62cIujB/dMU9cepkDae
 BRJ/fcYuFr0n+8lPmsyosnu+yna65U3vRu4d79/xeDjkhDjz4MQJSwQJpnNuQ/0tmPUN
 CPOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuueHSjrURP5TmlyAgGGP8maX+Urch9qt1X3DQDc5qsBhanNSut/hOZzBhaURR6btDheKHzHtPkI0HxsWYPAYRtbMfyjQ=
X-Gm-Message-State: AOJu0YxFE3wI3tP4an4DX875ROmwFSK3BejBORWFKaPa5sXsMzpYQcs4
 xGBNJoy+0PoCkon7xKGjReMMIL/ETeU/acsi95GcAcDNYNE4pKEDBqm7LRV6MtLIJiX82Q31dVY
 lKixa1/X0phBma7Rf/aUS9Ma+tfWT4pFBi5bXGo+QwWPmQrJ7NKmb
X-Received: by 2002:a5d:4c86:0:b0:357:ff92:aae7 with SMTP id
 ffacd0b85a97d-35e8404a062mr1253859f8f.2.1717573793640; 
 Wed, 05 Jun 2024 00:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAizrIqxmBtbM+Ai9Nnm/78M3NGWiRPBY0HpALwYXWTTZQn1jlYfqgzDRNVyQkDf7uhonLQQ==
X-Received: by 2002:a5d:4c86:0:b0:357:ff92:aae7 with SMTP id
 ffacd0b85a97d-35e8404a062mr1253847f8f.2.1717573793238; 
 Wed, 05 Jun 2024 00:49:53 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bba6sm13523799f8f.104.2024.06.05.00.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:49:52 -0700 (PDT)
Message-ID: <acbc5a71-9f94-40b1-9aad-1686ca9aa560@redhat.com>
Date: Wed, 5 Jun 2024 09:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] s390x: Add loadparm to CcwDevice
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-3-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240529154311.734548-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add a loadparm property to the CcwDevice object so that different loadparms
> can be defined on a per-device basis when using multiple boot devices.
> 
> The machine/global loadparm is still supported. If both a global and per-device
> loadparm are defined, the per-device value will override the global value for
> that device, but any other devices that do not specify a per-device loadparm
> will still use the global loadparm.
> 
> Assigning a loadparm to a non-boot device is invalid and will be rejected.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index fb8c1acc64..143e085279 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -13,6 +13,10 @@
>   #include "ccw-device.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/module.h"
> +#include "ipl.h"
> +#include "qapi/visitor.h"
> +#include "qemu/ctype.h"
> +#include "qapi/error.h"
>   
>   static void ccw_device_refill_ids(CcwDevice *dev)
>   {
> @@ -36,10 +40,55 @@ static void ccw_device_realize(CcwDevice *dev, Error **errp)
>       ccw_device_refill_ids(dev);
>   }
>   
> +static void ccw_device_get_loadparm(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    CcwDevice *dev = CCW_DEVICE(obj);
> +    char *str = g_strndup((char *) dev->loadparm, sizeof(dev->loadparm));
> +
> +    visit_type_str(v, name, &str, errp);
> +    g_free(str);
> +}
> +
> +static void ccw_device_set_loadparm(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    CcwDevice *dev = CCW_DEVICE(obj);
> +    char *val;
> +    int index;
> +
> +    index = object_property_get_int(obj, "bootindex", &error_abort);

The error_abort is rather unfortunate here, it can be used to terminate QEMU 
unexpectedly:

$ ./qemu-system-s390x -no-shutdown -nographic -serial none -monitor stdio
QEMU 9.0.50 monitor - type 'help' for more information
(qemu) device_add virtio-rng-ccw,loadparm=1
Unexpected error in object_property_find_err() at 
../../devel/qemu/qom/object.c:1358:
Property 'virtio-rng-ccw.bootindex' not found
Aborted (core dumped)

Since you check for the error via "index" afterwards anyway, I think it's 
likely ok to replace &error_abort with NULL here.

But apart from that, it's also a bit ugly that each and every ccw device 
gets a loadparm property now. Would it be possible to add it to the devices 
that can be used for booting only?

  Thomas


