Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB57EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01P0-0007Cx-1z; Thu, 25 Apr 2024 11:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s01Ox-0007CD-KR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s01Ov-0000MV-Ro
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714060364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3szdyDL9eEFnSf8Nl3MWXAcXU5l3d49IAnmD45hMtI=;
 b=HYYyKT6Cy3QwEZVyuU+Jp6tnztrHt7Y883XHnKOGd9YTVrgKN2NFG4v0UIQ0gPUYeZbO6L
 Slac5nUAw+sLu4xP6DjIldEe7x556LFzMAoNMqwteeLfb5VBh0zHMJoLlRGjTDxeDZyXbN
 PZRzV7opopYBHaYDGF4TpehK3j3tjFw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-1BokekcrM3C_gmoabXmbWg-1; Thu, 25 Apr 2024 11:52:42 -0400
X-MC-Unique: 1BokekcrM3C_gmoabXmbWg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78ed20d9423so160921985a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714060362; x=1714665162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3szdyDL9eEFnSf8Nl3MWXAcXU5l3d49IAnmD45hMtI=;
 b=VZaeTpu6o/UVrf3A2owR5y+aXCiiYU2vurQ5gyWBE+fHCsuYY3amcmd1+hmdX/jrCO
 2pP1uIcv5fai3SmdRHGKkmO5FCRw3jIrQtmeQ425NHKTsyuvR9IbfngRaHXF2T3hb7l0
 GxmLYDW3PMPDF85dKWNTxLszpNt6P+Vyz+j18fHr7+aKUx2B/ep5dlFkJxGY3ekv8HDs
 FyYzVHrn3vS4In54IlY6nPBvaIGFD1e1iIniyZFRstwABkAkZ2PCZl0qyK/RLzv2bHLS
 1POK8WZnGJ9lzDGCmpl8hztKfoglBpnXszYjFiN6wbVbDF0atDJf796dewoiMaJ9YtTW
 ltNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8imZ3Z68DZ8e2TrURsysSGdvnavMcZjpbwiKoBhUM7bKyCHhBHAhnEL62hUIlXUfp95d14GuHU352d5T+t5UY4xqwqzQ=
X-Gm-Message-State: AOJu0Yy9+EfhQMjqr1PV2EGneHg8InUu+psHT/gFlwxl/LN9Byr0dMlj
 38QaByCWEHXF1JAXPgn8yrxVwH6H22oZTxZjNHVnO1bT0qpSdzPH2M80dFzIptqUqmh9IVRo5r4
 xzSC84u7qQMHUaHm+kbhKXoIPcSo5g77/lWhVRlc/iJFkNuJbvngh
X-Received: by 2002:a05:620a:254b:b0:790:7346:2a49 with SMTP id
 s11-20020a05620a254b00b0079073462a49mr7160794qko.6.1714060362132; 
 Thu, 25 Apr 2024 08:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4nF3FBlmDJTX/201xw9oRPnBg7VjpkZxce8yCObVzwZ4hNKCuiZX/MqVYn14udwDPsM00uQ==
X-Received: by 2002:a05:620a:254b:b0:790:7346:2a49 with SMTP id
 s11-20020a05620a254b00b0079073462a49mr7160779qko.6.1714060361848; 
 Thu, 25 Apr 2024 08:52:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o8-20020ae9f508000000b0079072fa29e4sm3934787qkg.2.2024.04.25.08.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:52:41 -0700 (PDT)
Message-ID: <20f41dad-a291-4060-ae49-6ea93a5182f0@redhat.com>
Date: Thu, 25 Apr 2024 17:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] vfio/ccw: Make vfio_ccw_register_irq_notifier()
 return a bool
To: Eric Farman <farman@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-5-clg@redhat.com> <87il056783.fsf@pond.sub.org>
 <f1ac1e5f27239411f0e4a658507c331a106fd0a8.camel@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f1ac1e5f27239411f0e4a658507c331a106fd0a8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/25/24 14:55, Eric Farman wrote:
> On Thu, 2024-04-25 at 12:56 +0200, Markus Armbruster wrote:
>> Cédric Le Goater <clg@redhat.com> writes:
>>
>>> Since vfio_ccw_register_irq_notifier() takes an 'Error **'
>>> argument,
>>> best practices suggest to return a bool. See the qapi/error.h Rules
>>> section.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/ccw.c | 22 +++++++++++-----------
>>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> index
>>> 6764388bc47a970329fce2233626ccb8178e0165..1c630f6e9abe93ae0c2b5615d
>>> 4409669f096c8c9 100644
>>> --- a/hw/vfio/ccw.c
>>> +++ b/hw/vfio/ccw.c
>>> @@ -379,7 +379,7 @@ read_err:
>>>       css_inject_io_interrupt(sch);
>>>   }
>>>   
>>> -static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>>> +static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>>>                                              unsigned int irq,
>>>                                              Error **errp)
>>>   {
>>> @@ -405,13 +405,13 @@ static void
>>> vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>>>           break;
>>>       default:
>>>           error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
>>> -        return;
>>> +        return false;
>>>       }
>>>   
>>>       if (vdev->num_irqs < irq + 1) {
>>>           error_setg(errp, "vfio: IRQ %u not available (number of
>>> irqs %u)",
>>>                      irq, vdev->num_irqs);
>>> -        return;
>>> +        return false;
>>>       }
>>>   
>>>       argsz = sizeof(*irq_info);
>>> @@ -421,14 +421,14 @@ static void
>>> vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>>>       if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>>>                 irq_info) < 0 || irq_info->count < 1) {
>>>           error_setg_errno(errp, errno, "vfio: Error getting irq
>>> info");
>>> -        return;
>>> +        return false;
>>>       }
>>>   
>>>       if (event_notifier_init(notifier, 0)) {
>>>           error_setg_errno(errp, errno,
>>>                            "vfio: Unable to init event notifier for
>>> irq (%d)",
>>>                            irq);
>>> -        return;
>>> +        return false;
>>>       }
>>>   
>>>       fd = event_notifier_get_fd(notifier);
>>> @@ -439,6 +439,8 @@ static void
>>> vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>>>           qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>>>           event_notifier_cleanup(notifier);
>>>       }
>>> +
>>> +    return true;
>>>   }
>>>   
>>>   static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
>>> @@ -602,20 +604,18 @@ static void vfio_ccw_realize(DeviceState
>>> *dev, Error **errp)
>>>           goto out_region_err;
>>>       }
>>>   
>>> -    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX,
>>> &err);
>>> -    if (err) {
>>> +    if (!vfio_ccw_register_irq_notifier(vcdev,
>>> VFIO_CCW_IO_IRQ_INDEX, &err)) {
>>
>> Please pass errp instead of &err.
>>
>>>           goto out_io_notifier_err;
>>>       }
>>>   
>>>       if (vcdev->crw_region) {
>>> -        vfio_ccw_register_irq_notifier(vcdev,
>>> VFIO_CCW_CRW_IRQ_INDEX, &err);
>>> -        if (err) {
>>> +        if (!vfio_ccw_register_irq_notifier(vcdev,
>>> VFIO_CCW_CRW_IRQ_INDEX,
>>> +                                            &err)) {
>>
>> Likewise.
>>
>>>               goto out_irq_notifier_err;
>>>           }
>>>       }
>>>   
>>> -    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX,
>>> &err);
>>> -    if (err) {
>>> +    if (!vfio_ccw_register_irq_notifier(vcdev,
>>> VFIO_CCW_REQ_IRQ_INDEX, &err)) {
>>>           /*
>>>            * Report this error, but do not make it a failing
>>> condition.
>>>            * Lack of this IRQ in the host does not prevent normal
>>> operation.
>>              */
>>             error_report_err(err);
>>
>> Not this patch's problem, but here goes anyway: since this isn't an
>> error, we shouldn't use error_report_err().  Would warn_report_err()
>> be
>> appropriate?  info_report_err() doesn't exist, but it could.
>>
>> Preferably with errp instead of &err (two times):
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
> 
> Don't recall why I used error_report_err() instead of something else
> (or creating info_), but probably just familiarity. There's no need for
> it (or the equivalent code in -ap) to be error, and could be another
> cleanup.

yes. I will send an extra cleanup to replace error_... with warn_...
and another one to use errp.

Thanks,

C.


> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>


