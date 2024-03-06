Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81304C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 08:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhmNn-0005Ys-M8; Wed, 06 Mar 2024 03:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhmNk-0005YJ-Ih
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhmNh-0007ui-Rh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709712724;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLVAwEcxEBBxu2flhfM3oC7axrJcqk6FEbJ62gCArig=;
 b=TxDYWKKG/r0d8bcXKVzO9JcvJA4Ol0fP4f3izTMh4d2VSdqt8sQncBLSOSxObe98CUcZNm
 /S+qAimR253CyvVDfyTPl/nfLAmcasT0JHONK/7NiDOLeD/x9m84IsGwJI140ix5x7JKPG
 m+bLwirycAToPq6EEPhf9FbEjD2ZtPM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-yXQ4cEQ_O1i0VotnmXBZVg-1; Wed, 06 Mar 2024 03:12:02 -0500
X-MC-Unique: yXQ4cEQ_O1i0VotnmXBZVg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-427b56e96a6so19163051cf.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 00:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709712722; x=1710317522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pLVAwEcxEBBxu2flhfM3oC7axrJcqk6FEbJ62gCArig=;
 b=mxMyoopNXYLQljWPdriRPaKP4Ls3YZdX7KTdB3hj8VwXJeeZQx65Ex9bwex01k0rQX
 5f/rILIK85WJHdo7PA4k05jGIK1IDPWXDGYb4OFaI4MDIqSCfZiarW2tPLtG6La+/5Xx
 lfpCSXcyEUCmviCe52t88u8B2duZjE/WpF5blkZ3HseXOZ+XuXgBOi8i86ESdWy1+Mmf
 q3BrHverRoPp4Zia6Pf6t+ZaL+zz3xIuECx41N8827iRZn3eY/eqyF3Ulp43Mm3IhWM2
 7xOLeLERDqwXowensm2vAHN17kkoyUZDufdaxqOehcPM5qFm2HoE7Hfe42CEFYqL+eiM
 7WvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrY8jooiV/1ajp+TyfleLIGjqL4szMIazfZsXWQ7xxyML72lZF1ITU822Ws4+Tm41Ju1lapdWSl/S0Hx2bkxDxtB9Fdm8=
X-Gm-Message-State: AOJu0YyuzW5TTJ4p2TprlQiPpsNHMDk/fK5bSNEXUbkkid/vGXR1LfIw
 e3bOg/u0McO9ADAOptkkM6aBHvyp/DWmdHC1ZSAOFHA862nNWoUCZuNfVT9/BQVEr0OxchT/CpM
 M1Ud2BpKf6K1pY1EkgeeFjWmJ8PxiMZjKWVjWOfCdviycRrotDQsP
X-Received: by 2002:ac8:5701:0:b0:42e:e644:6a1b with SMTP id
 1-20020ac85701000000b0042ee6446a1bmr4635460qtw.1.1709712722500; 
 Wed, 06 Mar 2024 00:12:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLrlOWtIySmvuOisy5s4QGvFgoh0cuJZd8sx4IC3v3tEQRjSp8a5E5++fFHIPLlXqaB1QpeA==
X-Received: by 2002:ac8:5701:0:b0:42e:e644:6a1b with SMTP id
 1-20020ac85701000000b0042ee6446a1bmr4635437qtw.1.1709712722264; 
 Wed, 06 Mar 2024 00:12:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a05620a400100b007881fbfea7bsm3867890qko.24.2024.03.06.00.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 00:12:00 -0800 (PST)
Message-ID: <cc0afb73-efc5-4495-816e-a15786b7e943@redhat.com>
Date: Wed, 6 Mar 2024 09:11:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] hw/arm/virt: Set virtio-iommu aw-bits default
 value to 48
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240305180734.48515-1-eric.auger@redhat.com>
 <20240305180734.48515-9-eric.auger@redhat.com>
 <SJ0PR11MB674472228A664E543C15CD7092212@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB674472228A664E543C15CD7092212@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/6/24 04:25, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH v6 8/9] hw/arm/virt: Set virtio-iommu aw-bits default value
>> to 48
>>
>> On ARM we set 48b as a default (matching SMMUv3 SMMU_IDR5.VAX == 0).
>>
>> hw_compat_8_2 is used to handle the compatibility for machine types
>> before 9.0 (default was 64 bits).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/arm/virt.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 0af1943697..dcfb25369b 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -85,11 +85,28 @@
>> #include "hw/char/pl011.h"
>> #include "qemu/guest-random.h"
>>
>> +GlobalProperty arm_virt_compat[] = {
>> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>> +};
>> +const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
> This can be static, otherwise,
sure
>
> Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>
thanks!

Eric
>
> Thanks
> Zhenzhong
>
>> +
>> +/*
>> + * This cannot be called from the virt_machine_class_init() because
>> + * TYPE_VIRT_MACHINE is abstract and mc->compat_props
>> g_ptr_array_new()
>> + * only is called on virt non abstract class init.
>> + */
>> +static void arm_virt_compat_set(MachineClass *mc)
>> +{
>> +    compat_props_add(mc->compat_props, arm_virt_compat,
>> +                     arm_virt_compat_len);
>> +}
>> +
>> #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>>                                                     void *data) \
>>     { \
>>         MachineClass *mc = MACHINE_CLASS(oc); \
>> +        arm_virt_compat_set(mc); \
>>         virt_machine_##major##_##minor##_options(mc); \
>>         mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
>>         if (latest) { \
>> --
>> 2.41.0


