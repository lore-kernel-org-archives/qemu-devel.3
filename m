Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E41C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gkJ-0000lX-L0; Wed, 22 May 2024 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9gkI-0000im-DV
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9gkF-0004lD-Uw
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716364243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY06rTXRs0Vqb2YQ7myeGsTa/A5nD9HcvfYnxrxdkxs=;
 b=Br9HqpTdfcvKcu60l5UwqMLAltEGDHS3a0e9HBsU6v09UGksjAa1TWiA+451zYbvb7/EMo
 hXM2u1XjCweBbr6HnHRNZDGeGW5zUnXtl22quIrHIpacPoEKlRKAWbzEZ4h6Mj52sLqIGS
 3MjuVaRyoQt3jNVDf2dzrf9n8YqrHmQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-_HLUu0aAMO6MSd7sr2zWug-1; Wed, 22 May 2024 03:50:41 -0400
X-MC-Unique: _HLUu0aAMO6MSd7sr2zWug-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792c10a363bso1886642585a.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 00:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716364241; x=1716969041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UY06rTXRs0Vqb2YQ7myeGsTa/A5nD9HcvfYnxrxdkxs=;
 b=m65sFUjnrtvN2VXb1oA7NOxDfIwzmWZrLiNMvhsijsbG1Mab3L0C6u+L+WTR1CacTm
 09Tr3gPbENMo1rwBiTjwbA+xKk5pZ5LUDy9/swEwsRiYLXUkDuomH/BrimhTnnV917Uh
 EXmnFKw6/ukaNacFbkfhx80CCYiL/6WfIG9qwtPMkXmkKrlYWxwUrPc6gnMT2RpczkkF
 GEZquizGGknv0MorphaHWlGVXb6poexE+HbVotU2HLm7At4SWTOVdQ9jEb5VgTIr+Dj1
 lzBfGrkbr2go8rcXuRWpbDNyGFJBDr9mUPyNtA0ZSzKLBkRKg1dzP+yx+nbKsywS/fbb
 2kWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEMIfZbd/ytnenZ8Twpw+G0f4XO/aXxBknKzCF1bGUO/G8eCdVEsGAmSAoAD4zdLeNWhDJ7BbASJF4iIKDP/bAlALzUSY=
X-Gm-Message-State: AOJu0YzcSYNmixlH4RVTEf18XD7hLnmuCVxkRmfG4oLknC3J1mCs06i/
 d6UvP7p4/FhMhaYTS5Wg9nAorWIWbVVy3HOXrEQYOS2Uc2GIRP522+6Mv4vpLI9qb/Q+BvhhtuD
 ofxsP/cypAf0/0ouWYu+iFs9OG2wNZWGnqm64zyRiN8qEa+o/m1sQ
X-Received: by 2002:a05:620a:351:b0:792:8db7:6791 with SMTP id
 af79cd13be357-794994c5233mr116806285a.72.1716364241072; 
 Wed, 22 May 2024 00:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Z+ALGOMBMWv+7gD4AkagNsV3RXio6Dtuz2oB7w/zxVbl/WTJeK5zOZVCk/NzaY/+/XbrAA==
X-Received: by 2002:a05:620a:351:b0:792:8db7:6791 with SMTP id
 af79cd13be357-794994c5233mr116804985a.72.1716364240681; 
 Wed, 22 May 2024 00:50:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79319319b50sm499249685a.33.2024.05.22.00.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 00:50:40 -0700 (PDT)
Message-ID: <adb8e0e9-a58d-45f5-979c-fe16d82ad988@redhat.com>
Date: Wed, 22 May 2024 09:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] vfio/ccw: Drop local @err in vfio_ccw_realize()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-20-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/22/24 06:40, Zhenzhong Duan wrote:
> Use @errp to fetch error information directly and drop the local
> variable @err.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/ccw.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2600e62e37..168c9e5973 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -574,17 +574,17 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>   
>   static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_GUARD();
>       S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>       VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>       VFIODevice *vbasedev = &vcdev->vdev;
> -    Error *err = NULL;
>   
>       /* Call the class init function for subchannel. */
>       if (cdc->realize) {
> -        cdc->realize(cdev, vcdev->vdev.sysfsdev, &err);
> -        if (err) {
> -            goto out_err_propagate;
> +        cdc->realize(cdev, vcdev->vdev.sysfsdev, errp);
> +        if (*errp) {
> +            return;

We should change the realize() return value to bool also. this is more
work and it should be addressed in its own patchset I think and ...

>           }
>       }
>   
> @@ -597,27 +597,28 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           goto out_attach_dev_err;
>       }
>   
> -    if (!vfio_ccw_get_region(vcdev, &err)) {
> +    if (!vfio_ccw_get_region(vcdev, errp)) {
>           goto out_region_err;
>       }
>   
> -    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err)) {
> +    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, errp)) {
>           goto out_io_notifier_err;
>       }
>   
>       if (vcdev->crw_region) {
>           if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX,
> -                                            &err)) {
> +                                            errp)) {
>               goto out_irq_notifier_err;
>           }
>       }
>   
> -    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, &err)) {
> +    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, errp)) {
>           /*
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.
>            */
> -        error_report_err(err);
> +        error_report_err(*errp);

This should use a local Error variable and be a warn_report_err instead.

Let's address these changes in another series. I can take care of it
later if no one does.

Thanks,

C.



> +        *errp = NULL;
>       }
>   
>       return;
> @@ -635,8 +636,6 @@ out_attach_dev_err:
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
>       }
> -out_err_propagate:
> -    error_propagate(errp, err);
>   }
>   
>   static void vfio_ccw_unrealize(DeviceState *dev)


