Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE79F1125811
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OFg-0001pW-8I; Wed, 11 Mar 2026 14:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0OFe-0001p9-8R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0OFc-0007Lo-O9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773253544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJNOCK4CKWh0vHBUxPW+9hTdN7h2sEqQGfG64Cfbd1M=;
 b=O0kthWxEwU3/7HNfVkNEB81jC1xFhIrHQwZryotovqzUlQ9Rm0ul2sD9nJFGl14rcz9S91
 bm8a2qzwn8UT6tuvpfHpXZx9k2QeyeHKuq6y6lyJZSXS+ae6nQgczbJ76ektiEO4oEHyXc
 dEmt042/ECBX4bb7pOVhRpvk5362kXs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-3LKV60g0NkeCpIivj5PQPg-1; Wed, 11 Mar 2026 14:25:43 -0400
X-MC-Unique: 3LKV60g0NkeCpIivj5PQPg-1
X-Mimecast-MFC-AGG-ID: 3LKV60g0NkeCpIivj5PQPg_1773253542
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485335f4466so3248285e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773253542; x=1773858342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJNOCK4CKWh0vHBUxPW+9hTdN7h2sEqQGfG64Cfbd1M=;
 b=TxImHU2Z4Yg8s3IcFizJXtG4NyupgfVksjNwBH/MRWIEEVC4kGDV0mQV8TaU0klDcl
 ReoSw3WdDO2TekksLrutW2bvJEyXWbEJywycmPlaT5dMAN+bgHUHtbbn1hNQYuXU4hLG
 fYaRu+ZCgG9uT/qaoU2UwGw74fXPcvRhkH17BgMFM9uiEqp0nsUpNvNfHFUb2I3KNvnS
 yvw4ZHpMOHfqjsU6DzEhZ8kQHmxz0UjdkGabhlnuB35dMyaNKoEFx67wCAEAHKhRSXgK
 5PMNMJlvXviKFnug97dbHyFsWtcf7CtG3S/hRSDxg2czenjfVAia6mFbzErSvPdMBvxD
 /djQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkRMnFIjhxGNeUHT1UHhA3rjiSBZ8qagoPsXMTuJjlk2zwA+hMQyHqkhpdhJJfc809NNEOfP2EoQU6@nongnu.org
X-Gm-Message-State: AOJu0YywgTFu2huAvt8CsyPg0iWmjvra5BeC2dbpPARWB4Kdli5DQO5x
 lChfvrd7sf1wHK+Tw6F1blw8Gl4C9J5o/LNvTqh0GyuvfvRLAhVYm0hoVx2TJTQmAMSDM8N6l5Q
 qcz2ZzD1/zfFs32rCmF2TWIc8beQ59VwORWdbzStEN07pjZe9xgKIDn1q
X-Gm-Gg: ATEYQzzSpu5mlWXQXugf3T8mH3md0mX28L58lHnRj/2dmU7n4PYscFrFJaxJPWMZ24b
 Atoam8fTrWQVIfyDNRUAjwOoMzhENZUzGwosEh290e51ngCWJdkPDW8rMH3FE8NnCrPjY6ZtCkF
 TXF86MOJDRPe9XkTsUPtH/NKJpfiDn535lLvW9k0p2hpv8LibslF4itA0vOMZP6ii97B10QP55J
 L3gH1k+CLQpy0IBr4Owlhz07Zbv7cMD+qatk3/ovqrZZopXcolMY3lZo0SbwTZjHnijmRccO6F+
 Vv2nWqIupSzXk82ZQEZWv6zlKrZ+7C6h8mhmGX9TTsojaeV2aoxMeiZIzamOkF85SFy6ldVHYbL
 QBGkzgcDsJQ7WMvqScuXlcKLcAEm3YS/StcRn3qkMCroyEodBblxIH6DcH3xkCrT8EfP/aw==
X-Received: by 2002:a05:600c:8b45:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-4854b0ac451mr56760375e9.7.1773253541733; 
 Wed, 11 Mar 2026 11:25:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-4854b0ac451mr56760065e9.7.1773253541297; 
 Wed, 11 Mar 2026 11:25:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0bff95sm46820475e9.3.2026.03.11.11.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:25:40 -0700 (PDT)
Message-ID: <fbc0432d-231e-400a-9749-c31ceb564a20@redhat.com>
Date: Wed, 11 Mar 2026 19:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <a9c03e3c-448e-480a-a6dd-b3c4c7903758@redhat.com>
 <33209425-ff30-4106-827f-a12a86161afb@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <33209425-ff30-4106-827f-a12a86161afb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/11/26 6:55 PM, Nathan Chen wrote:
>
>
> On 3/11/2026 10:43 AM, Eric Auger wrote:
>>
>> On 3/9/26 8:21 PM, Nathan Chen wrote:
>>> Hi,
>>>
>>> This series introduces support for specifying 'auto' for arm-smmuv3
>>> accelerated mode's ATS, RIL, SSIDSIZE, and OAS feature properties.
>>> When set to 'auto', these feature values are derived directly from
>>> host IOMMU capabilities, avoiding the need for management layers to
>>> introspect host settings.
>>>
>>> Accelerated SMMUv3 Address Translation Services support is derived
>>> from IDR0, Range Invalidation support is derived from IDR3, Substream
>>> ID size is derived from IDR1, and output address space is derived from
>>> IDR5.
>>>
>>> Additionally, an OnOffAuto "ats" property is added for vfio-pci
>>> devices,
>>> where setting 'auto' detects the per-device presence of
>>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED from the kernel, and the ATS cap can
>>> be advertised or hidden by setting 'on' or 'off'. This is dependent
>>> on Shameer's recent kernel series for reporting effective ATS support
>>> status [0].
>>>
>>> The default values are set to 'auto' for all properties.
>>>
>>> A complete branch can be found here:
>>> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto
>> I have just noticed we are missing documentation for smmuv3 accel
>> options in
>>
>> qemu-options.hx
>>
>> At the moment we just have:
>>
>> ``-device arm-smmuv3,primary-bus=id``
>>      This is only supported by ``-machine virt`` (ARM).
>>
>>      ``primary-bus=id``
>>          Accepts either the default root complex (pcie.0) or a
>>          pxb-pcie based root complex.
>
> I will add a commit to include documentation for the smmuv3 accel
> options in the next refresh. 

Great. Thanks!

>
> Thanks,
> Nathan
>


