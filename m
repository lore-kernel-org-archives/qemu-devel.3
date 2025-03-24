Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E35C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhcm-0007X2-4H; Mon, 24 Mar 2025 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twhcW-0007Qo-IO
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twhcP-00068q-CL
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822006;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUQyxueVFXvlrjK3VZzJCpddW1FgCnJYqfitLgz1Edg=;
 b=Ajp0Om/lkdro4emkcepfzWueNKrJARB1l2O6xQWbti6ewm7RoVbtIXXuvVHBT5YKvLfkN6
 Kdkizs4rMJWIabMAZJzD+MMmscLAplDjE1Aq95BX1N9pSHZsh9HO/Ck8SK/vMmxk7TlTtx
 7ovgZ7WiNhrRuSjh2hUa00zt/NYhcFk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-2L7dP-U8M-O3jLPw0qB6zg-1; Mon, 24 Mar 2025 09:13:24 -0400
X-MC-Unique: 2L7dP-U8M-O3jLPw0qB6zg-1
X-Mimecast-MFC-AGG-ID: 2L7dP-U8M-O3jLPw0qB6zg_1742822004
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cec217977so25951565e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742822003; x=1743426803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IUQyxueVFXvlrjK3VZzJCpddW1FgCnJYqfitLgz1Edg=;
 b=jMfjDrGzvvs15FITzIBAWx1bWPWTXh2AvlDmkGeHqSWH32fpD4pBA2kRgh1G0faBZY
 +eEFdtUXYUoaGbDITL9jHLPzIX9rHT8JBKcCmY5GER/gIy7hlcN/cZLkeFnRlsevrlMG
 UFVNh1tIJpv5YhDhR7ib7bbCwOV9Mf8GO99xm518Hntx1VYXV8VyABc7D0cGNTe9oOaY
 lJdSfrN5tHvWFZMKAuJKrH/TBRIRNsZ7Y+xZLce8XST39h12ezbhh+KrL/DeWqJO2gyE
 hybq1knQjJt3+NLLEe87vPixmJTE6NVgPPO9k4m8s1hFXplY+M18ZwjaQAEa+nyoT72n
 bv4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKBh4cqJYEmuqeOSh6yYIBT3VE4YyfsnvfkpgVEJQvdmjUUku3kLF0zLCJYoFb+u9xJCCK06u8EbSq@nongnu.org
X-Gm-Message-State: AOJu0Yyo+zEmc3UI1O8nG/cgbEhWod1JoYQkxySB7+at/HD+0of1y2Vm
 DpfBryyJ4yXdqGX+nj+sc/gVFGbPKo4xCVll7x1SbrYHGIxezyq0QMS7aLpw25UzYGa4tOK54lJ
 ElmJ9uvQ5ZJqJFf/pTiYgMTTNj05u/c90FU224UxeaZ0OLRqtieqg
X-Gm-Gg: ASbGncuhbi5Kv4a7eOnhFJRywOrhxMk0uJFAf1nXWKBheUwA2AWUQwFsqMEY7PpvguG
 YJnnftcNibxJClIMxgH8+rZ9f+9jSPia2bsQU9N3qdluqEpB0AxPr+VCAlHdkS+1cH/9f7Vmbhk
 h2WxClu+E0QT+Zksry6CLVwASWs15jDCVxLw36o7dcW/FqJkiEUWlNSJ0M3w47TEsAs1a7KBBbB
 Pr4CyYThNhOh6O4eqhvCLrhRjhSS9QI1XW3Rq2kr0GrgOW9Dnx4hElEC/i0pSW3E0/ixM4PeHvA
 BcqQzpHFfT6XWdfIOS66x5ses+YdBCnopSsSH/05EMzYJ1J/4jj8WCyRBuHMOyE=
X-Received: by 2002:a05:6000:43c9:b0:399:6dc0:f15b with SMTP id
 ffacd0b85a97d-3997f959596mr7960130f8f.48.1742822003526; 
 Mon, 24 Mar 2025 06:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtROkYF50rTLPghUVP4n46I4TYhw4IHykyp4wpS735E+adiox/H1xoxL6k961ZT8xICn27iw==
X-Received: by 2002:a05:6000:43c9:b0:399:6dc0:f15b with SMTP id
 ffacd0b85a97d-3997f959596mr7960104f8f.48.1742822003090; 
 Mon, 24 Mar 2025 06:13:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3372sm10824513f8f.21.2025.03.24.06.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 06:13:22 -0700 (PDT)
Message-ID: <ad0b5fac-2a7f-4978-9f6b-0f7b1df14a35@redhat.com>
Date: Mon, 24 Mar 2025 14:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <Z9xKL49nOenvQIsW@Asurada-Nvidia>
 <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Shameer,

On 3/24/25 9:19 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Thursday, March 20, 2025 5:03 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: Donald Dutile <ddutile@redhat.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
>> jgg@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>> pcie bus
>>
>> On Wed, Mar 19, 2025 at 09:26:29AM +0000, Shameerali Kolothum Thodi
>> wrote:
>>> Having said that,  current code only allows pxb-pcie root complexes
>> avoiding
>>> the pcie.0. The idea behind this was, user can use pcie.0 with a non accel
>> SMMUv3
>>> for any emulated devices avoiding the performance bottlenecks we are
>>> discussing for emulated dev+smmuv3-accel cases. But based on the
>> feedback from
>>> Eric and Daniel I will relax that restriction and will allow association with
>> pcie.0.
>>
>> Just want a clarification here..
>>
>> If VM has a passthrough device only:
>>  attach it to PCIE.0 <=> vSMMU0 (accel=on)
> Yes. Basically support accel=on to pcie.0 as well.

agreed we shall be able to instantiate the accelerated SMMU on pcie.0 too.
>
>> If VM has an emulated device and a passthrough device:
>>  attach the emulated device to PCIE.0 <=> vSMMU bypass (or accel=off?)
>>  attach the passthrough device to pxb-pcie <=> vSMMU0 (accel=on)
> This can be other way around as well:
> ie, 
> pass-through to pcie.0(accel=on) and emulated to any other pxb-pcie with accel = off.
+1
>
> I think the way bus numbers are allocated in Qemu for pcie.0 and pxb-pcie allows
> us to support this in IORT ID maps.
One trouble we may get into is possible bus reordering by the guest. I
don't know the details but I remember that in certain conditions the
guest can reorder the bus numbers.

Besides what I don't get in the above discussion, related to whether the
accelerated mode can also sipport emulated devices, is that if you use
the originally suggested hierarchy (pxb-pcie + root port + VFIO device)
you eventually get on guest side 2 devices protected by the SMMU
instance: the root port and the VFIO device. They end up in different
iommu groups. So there is already a mix of emulated and VFIO device.

Thanks

Eric
>
> Thanks,
> Shameer
>


