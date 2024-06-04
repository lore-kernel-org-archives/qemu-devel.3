Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD99C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEV8R-000691-Sq; Tue, 04 Jun 2024 10:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEV8O-00067j-Ro
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEV8M-00017H-NJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717511249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HqZBaOzbSNuAjVGT1JehuwAgPx3MPDWirtJx+HJuAMw=;
 b=bVwVDpuP69FdEvZ9qCNIbMRthkAjpnYQGqI9TYyv0f/O4Nff/Q7w8OyZQVnTtByUW1tkhp
 QGh8oDtoqN3MmzEceFysdAh7PbeNZ5hfpMDQeAAjvYYFdL7cqS0bcZWu6myoAYnhuR4C9c
 ep681heDYOR4LrB/S6s4bCVG4MnBvNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-N4mj01lVO4uUoseWevKOxA-1; Tue, 04 Jun 2024 10:27:27 -0400
X-MC-Unique: N4mj01lVO4uUoseWevKOxA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e0f069ad4so3103840f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717511246; x=1718116046;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqZBaOzbSNuAjVGT1JehuwAgPx3MPDWirtJx+HJuAMw=;
 b=le9qzm92SO61ESzZohYvbsCTrY9ZR3EexG2n2B8HX1DMqRb6mlLZURFtRfFn847Or6
 eIFqk0QNsQDHVdlAb8U7snRjIhK9pENHLu63fWf9gHyhXrL9CM1nn+WvRsoIqijvZvF9
 wDIZfn47/yJO1aymV+tlpogxP3mDBnnC6N4MsAJhQqL5SOWJNoQv4Iu1XwgRRfm9U5ef
 nEP5sriwXGAHamoT/xjl+S41eGrdTC3B8fowooIUMcshOaVPcUg44v/qI2CXDUyZZ6JB
 ti+Ilc3RJxI5Mk+b1jYWlFrrM+6W/Qe1tE2iX0Bim7KDdOg7vBsaaoIy4S+XvCs/Q+Im
 lDgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfqrLONSQ+izM3miWLgfcU/Xe2r0GMAD37Q1hsbSY2eAswSZgT+strz9E/9YoFUWx6BBa9DFoVZnWNp9eFIMsvgCvzY7w=
X-Gm-Message-State: AOJu0YzDTiKaq+pbLSpOeB1Bq7jWhyL/WGeZziy8/vgJDo/+ObGxBewi
 EOoqC8qW2MYv6TlilZJwHNzNXKFgLOzdw4uo0bq0vY7RMJ2bY8aUegVKx4JE4VsssGY7pAv8yCT
 phIY2qcgwk4VfX2/5hn7JaifDIB0ktxucDC6Zsf3LrKa8iK+kwB5M
X-Received: by 2002:adf:fc82:0:b0:35e:7d21:cad2 with SMTP id
 ffacd0b85a97d-35e7d21d132mr2070726f8f.30.1717511246275; 
 Tue, 04 Jun 2024 07:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzpF2+TqD1mnvRnldgkkR0KzApEUyVTAv/Fz2pnAPWYVqGH+P8oAAXKgLZTLApnuvMSe7+Rg==
X-Received: by 2002:adf:fc82:0:b0:35e:7d21:cad2 with SMTP id
 ffacd0b85a97d-35e7d21d132mr2070710f8f.30.1717511245868; 
 Tue, 04 Jun 2024 07:27:25 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-97.web.vodafone.de.
 [109.43.178.97]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e5260d400sm7988691f8f.77.2024.06.04.07.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:27:25 -0700 (PDT)
Message-ID: <8240e6c8-8de1-4529-9479-73e555c1b590@redhat.com>
Date: Tue, 4 Jun 2024 16:27:23 +0200
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
> +
> +    if (index < 0) {
> +        error_setg(errp, "LOADPARM: non-boot device");

If the user is not very experienced, this error message is not very helpful. 
Maybe: "loadparm is only supported on devices with bootindex property" ?

> +    }
> +
> +    if (!visit_type_str(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    s390_ipl_fmt_loadparm(dev->loadparm, val, errp);
> +}
> +
> +static const PropertyInfo ccw_loadparm = {
> +    .name  = "ccw_loadparm",
> +    .description = "Up to 8 chars in set of [A-Za-z0-9. ] (lower case"
> +            " chars converted to upper case) to pass to machine loader,"
> +            " boot manager, and guest kernel",

I know, we're using the same text for the description of the machine 
property already, but maybe we could do better here: The string is very 
long, it wraps around unless you use a very huge console window when running 
QEMU with e.g. "-device virtio-blk-ccw,help".

What do you think about using something like this:

  .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass to the guest 
loader/kernel";

?

> +    .get = ccw_device_get_loadparm,
> +    .set = ccw_device_set_loadparm,
> +};
> +
> +#define DEFINE_PROP_CCW_LOADPARM(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(uint8_t[8]))

Not sure if it's worth the effort to create a macro just for this if you 
only need it once below. I'd maybe rather inline the DEFINE_PROP below.

>   static Property ccw_device_properties[] = {
>       DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
>       DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
>       DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
> +    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index e934bf89d1..2d4f5152b3 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -34,6 +34,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/cutils.h"
>   #include "qemu/option.h"
> +#include "qemu/ctype.h"
>   #include "standard-headers/linux/virtio_ids.h"
>   
>   #define KERN_IMAGE_START                0x010000UL
> @@ -390,12 +391,44 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>       return ccw_dev;
>   }
>   
> +void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
> +{
> +    int i;
> +
> +    /* Initialize the loadparm with spaces */
> +    memset(loadparm, ' ', LOADPARM_LEN);
> +    for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
> +        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
> +
> +        if (('A' <= c && c <= 'Z') || ('0' <= c && c <= '9') || (c == '.') ||
> +            (c == ' ')) {

You could simplify it to:

     if (qemu_isalpha(c) || c == '.' || c == ' ')

> +            loadparm[i] = c;
> +        } else {
> +            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
> +                       c, c);
> +            return;
> +        }
> +    }
> +}
> +
> +void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)

I'd maybe rename this function now, maybe s390_ipl_convert_loadparm() or 
something similar?

> +{
> +    int i;
> +
> +    /* Initialize the loadparm with EBCDIC spaces (0x40) */
> +    memset(ebcdic_lp, '@', LOADPARM_LEN);
> +    for (i = 0; i < LOADPARM_LEN && ascii_lp[i]; i++) {
> +        ebcdic_lp[i] = ascii2ebcdic[(uint8_t) ascii_lp[i]];
> +    }
> +}
> +
>   static bool s390_gen_initial_iplb(S390IPLState *ipl)
>   {
>       DeviceState *dev_st;
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
> +    uint8_t *lp;
>   
>       dev_st = get_boot_device(0);
>       if (dev_st) {
> @@ -406,6 +439,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>        * Currently allow IPL only from CCW devices.
>        */
>       if (ccw_dev) {
> +        lp = ccw_dev->loadparm;
> +
>           switch (devtype) {
>           case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> @@ -438,40 +473,20 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>               break;
>           }
>   
> -        if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
> -            ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
> +        /* If the device loadparm is empty use the global machine loadparm */
> +        if (memcmp(lp, "\0\0\0\0\0\0\0\0", 8) == 0) {
> +            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
>           }
>   
> +        s390_ipl_set_loadparm((char *)lp, ipl->iplb.loadparm);
> +        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;

That means DIAG308_FLAGS_LP_VALID is now always set, even if no loadparm has 
been specified? Shouldn't it be omitted if the user did not specify the 
loadparm property?

>           return true;
>       }
>   
>       return false;
>   }

  Thomas



