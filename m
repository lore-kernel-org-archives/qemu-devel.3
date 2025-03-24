Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F35C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twj4V-0007kg-4S; Mon, 24 Mar 2025 10:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twj4T-0007kT-1g
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twj4R-0003FB-E0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742827590;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/6dJM7WjLY3R3rYiRGivphCR3M2STG0pH0mvJdxxt4=;
 b=MDDR5IvsldTsP6adikXPqNuWpwuPwuTkmDJzcWEDWgWA+IrNhMlzpS6J2IaMNg3KjaamT6
 kpk8a6e64zYofKj2x4NubHNwvvGY7KiZjmIpnlMk5xg2Pa6YTD1F4fRGRUsZaRGLB521iE
 2FlHh6PGKzAIbzSP+FYk1+0C/XWzq6k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-9ys2yllMNLeBcW3nO9MnhA-1; Mon, 24 Mar 2025 10:46:27 -0400
X-MC-Unique: 9ys2yllMNLeBcW3nO9MnhA-1
X-Mimecast-MFC-AGG-ID: 9ys2yllMNLeBcW3nO9MnhA_1742827586
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3914bc0cc4aso2302807f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742827586; x=1743432386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y/6dJM7WjLY3R3rYiRGivphCR3M2STG0pH0mvJdxxt4=;
 b=E6FitzmtHvXJ3HQY3VmJBEdxq95Ck3C82hdwfdnxkXKhX04kmpJoJwDXYgshaMz2/T
 2TmD/NoTY93GXTHFlBLkji88OHM0kVUsICbb5+MAdPR3oEkypilcyW3DhWbHFkx38bXi
 RTriLbPeyVQSpgXdk1WpF64qYFChn1+oS9t8f8Yz1HtJ8/lxBlnwozv7r+zSo3GziBQj
 O6qOwhxipwfygE4MlcDuzTmRY5MwUTSuH5VutQ/fjM2TINVktMMCmZQnNsyHOz64r50Q
 QxQX+Dk7jq3lISR3aRhOx09Ks+rz83TozbaCnsnrz8FyfCabkZZCJoBdPVNtIdXCSKjc
 ZQbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW48fmekOkj+5FVT5n1ZuBEAetMYqHxdj4WiNDHtOEyPGldKiF7oEkDVcHo1WRpW2vVrJOAX7ri/GEo@nongnu.org
X-Gm-Message-State: AOJu0YxcObiOE3ft08IllkBCZMzx2/MBouVFY42Y6tdvIWa66xxiYmNb
 wWhOeHDq6mw81JyvhZYQ5Ou72RooD7pR1D3oQFY+HhlOkYTA8Ayd/etIsffE+qvYthAyMRpmIeJ
 YQXBuCEABdC2rH8dCJzIFydrHHm1W+UGYZPojM5NQ+xr3HLfHgp5/
X-Gm-Gg: ASbGncu+f4as6SISHgujWXh+UBAP/anxU7QxGKKc3B1nf4b9i82w8CSLCIJss/qG7pI
 /R2xpDKbrlzKDSAy6bjepYzFUVSqKCWB0joH4Ay5vduNUJSAW3hyMoaobN9a38rb+0CJB3mj0J3
 fHt0k+Z9WE6x8KQmU8QA4ob+qaxCZPaUniMxgdwOYj8iVVGkRgUtqXnVUPDqfKZHUNCEJuKu7sj
 Kop62zDTTO82sSQuPS+474cuwCufdR7bs5rkjcuPLN27lMsL0yAwPY5eLPhnCD+OkSzgUqNc0si
 /s7o4ukzEN5BS3W+u+iIvL9u9kwWGncIetwp0pwSLQplqVVnMNJDF8JRI1aKgpg=
X-Received: by 2002:a05:6000:1543:b0:391:3cf6:95fd with SMTP id
 ffacd0b85a97d-3997f9144c4mr11349609f8f.30.1742827585762; 
 Mon, 24 Mar 2025 07:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP/W0gruz98J2WFbQWaPv89KM7O6uPUJB1KPmANBzds8Wog7IyfcxgPu98nLyPRX6rdHK9JQ==
X-Received: by 2002:a05:6000:1543:b0:391:3cf6:95fd with SMTP id
 ffacd0b85a97d-3997f9144c4mr11349576f8f.30.1742827585262; 
 Mon, 24 Mar 2025 07:46:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39ab907da9asm8567283f8f.90.2025.03.24.07.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 07:46:24 -0700 (PDT)
Message-ID: <b0465153-3781-44e7-a012-a5994dcbbdae@redhat.com>
Date: Mon, 24 Mar 2025 15:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
 <Z9r7dT/5E+YToqc9@Asurada-Nvidia>
 <c70fdb0c-ef56-4a52-8591-31df51ff0eec@redhat.com>
 <Z9sORySxEEL0VXMq@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z9sORySxEEL0VXMq@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/19/25 7:34 PM, Nicolin Chen wrote:
> On Wed, Mar 19, 2025 at 07:09:33PM +0100, Eric Auger wrote:
>>> Option means something like this:
>>> 	-device smmuv3,accel=on
>>> instead of
>>> 	-device "smmuv3-accel"
>>> ?
>>>
>>> Yea, I think that's good.
>> Yeah actually that's a big debate for not much. From an implementation
>> pov that shall not change much. The only doubt I have is if we need to
>> conditionnaly expose the MSI RESV regions it is easier to do if we
>> detect we have a smmuv3-accel. what the option allows is the auto mode.
> Mind elaborating your doubt about the MSI RESV region?
>
> Do you mean how VMS code should tag "accel=on" option and generate
> RMR nodes in the IORT table?
yes that was my point. Earlier we detected whether a "nested-smmu" was
part of the object hierarchy. Now we do the same with smmu type and
check if accel=on. I guess we can retrieve the property value but this
is worth to test.
>
>>> We certainly can't do case (a): not all TLBI commands gives an "SID"
>>> field (so would have to broadcast, i.e. underlying SMMU HW would run
>>> commands that were supposed for emulated devices only); in case of
>>> vCMDQ, commands for emulated devices would be issued to real HW and
>> I am still confused about that. For instance if the guest sends an
>> NH_ASID, NH_VA invalidation and it happens both the emulated device and
>> VFIO-device share the same cd.asid (same guest iommu domain, which
>> practically should not happen) why shouldn't we propagate the
>> invalidation to the host. Does the problem come from the usage of vCMDQ
>> or would you foresee the same problem with a generic physical SMMU?
> Host (HW) would end up with executing commands that were issued for
> emulated devices, which impacts performance.
>
> With vCMDQ, QEMU cannot trap command queue because all invalidation
> commands will be issued to HW directly from the guest kernel driver.
> This includes TLBI and ATC_INV commands. It's probably okay to run
> TLBI commands with vCMDQ (again perf impact), while ATC_INV commands
> would result in "unkonwn SID" errors or directly ATC_INV timeouts.
OK understood. Thanks and sorry for the misunderstanding

Eric
>
> Thanks
> Nicolin
>


