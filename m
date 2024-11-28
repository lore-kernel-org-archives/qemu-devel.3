Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF05D690EB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 08:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGa6K-0002T4-N2; Thu, 28 Nov 2024 03:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tGa67-0002S1-7T
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 03:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tGa62-00018i-SN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 03:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732783316;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQPZv9JMprD+qOBBg6yonw8J/WmWGRfK0eeqFtoI9do=;
 b=YnwVJyS9dEryE+5bfuFKwAZ16eG1xbg43Uj46KjikxG2dbn4tpQIa7qJ0Bgcc+1u2uj0uA
 YS6LMgVpr3OQnf6VmLlo4LxpMoEln52DvBXQJvDF+ZlxQE3NhwYugd1bfq2pQar5M+0TIJ
 rKchc2vRTkSavbYJ3jpvxA/S/hGH9eA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-N6zaIBrVMcSOSemnUO0EOA-1; Thu, 28 Nov 2024 03:41:54 -0500
X-MC-Unique: N6zaIBrVMcSOSemnUO0EOA-1
X-Mimecast-MFC-AGG-ID: N6zaIBrVMcSOSemnUO0EOA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43498af79a6so3435335e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 00:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732783312; x=1733388112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQPZv9JMprD+qOBBg6yonw8J/WmWGRfK0eeqFtoI9do=;
 b=RdrLRMCXZ8++Hyhg7WQsrCPs9yvfPdfbzhStBpbnFyEvRTt9fjEJ02qh5p709G4/Ns
 NPOoyoi7odHTFtZ2ewR2TwF1SPASMKNj2sq+zAiIdgSlMTx1DLPSZo1G7Frl1heZ1WZy
 vsOf4Gi/Bp0yxjRxg94SczV+epb2U2PXGVd3jF094RN60tkrN+zj4ynaN+UO8u+IcpzD
 nc/QYH9F6HduQ9CA/fUIwcJg7ih0+MEskMrYh/0owodmi3TituypZzUlp0bTvBQr/d3H
 +rO05b7387Nk1ebARPMiob+iL7R9jtPLDUIzwk5Wi5H5ATLzXa7RM1eqmD2Uv4l42OIo
 YmeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0W/HXH88JD7GgwKK6XqKgQ/Fdb2FRJRgOkjVUDtjgLn+krTh3GaJUjiQC6Fh0qnWelMctQfw1h+tr@nongnu.org
X-Gm-Message-State: AOJu0Yzvj3S36bvxGa3KLcgAdLr5c8D9cvu7mI6uDv8J6GyaRyh8H603
 Xw+okWEZO+kldp+1dTri3/tfgwaOQQfjLDhZM1JIzkDHWSslAq+fBfsX/wCCbxIPLIje2i2MhlH
 ZAN1s8IAlkBXlr1O1cKiX6G2KprfFbDgjPNb7TWi3hJo1mxOmQoRE
X-Gm-Gg: ASbGncuio0nwKKD3Pi13W3Kt3rQ/m+T0XDv9zLSprFR0orPRn62cQSBuM4G+Uc6rvQA
 zWPgw4/E/yo3g9cza6MGvHg7mDPE+Wj3FcWgqSZbjFixjGQXORogISmySjetSMc3R+IYqGN1rGp
 Q0pbXMkS8cit6b9wMsJ4iLcB7bF+XIYALQwkBvygrJxWOboMGuDY4CvRYyPIBaRhh1ZR9g3U4KQ
 4SqAS95aZ+d/VZqv3WV4wTGKjPR4QgVmgEoEBdS7udaN+zGA6a1h3YhZUeJ0H7DD++a6Jv4D10q
 G2Q7pD9upQwiteISh3ii5A==
X-Received: by 2002:a05:600c:4b17:b0:42c:b697:a62c with SMTP id
 5b1f17b1804b1-434afb9453emr18526675e9.5.1732783312247; 
 Thu, 28 Nov 2024 00:41:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMAgmfeWeYdmaKEocHmHZceVpHYIENss8rpb6NIzY9DPwcS+93uV9V96ZAljsTedHv5CCSHw==
X-Received: by 2002:a05:600c:4b17:b0:42c:b697:a62c with SMTP id
 5b1f17b1804b1-434afb9453emr18526495e9.5.1732783311931; 
 Thu, 28 Nov 2024 00:41:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d29fbsm45695395e9.29.2024.11.28.00.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 00:41:51 -0800 (PST)
Message-ID: <f97bcbc0-cda8-4a5c-90e6-c3648617b934@redhat.com>
Date: Thu, 28 Nov 2024 09:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Donald Dutile <ddutile@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
 <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
 <CABQgh9ErT6BmvbrUr_aNiLFws2Kx-=NzGJJCo+vV7AV_U6Pk9g@mail.gmail.com>
 <05470fe6-4336-455a-8b30-e05fb273aa25@redhat.com>
 <3fa6f093ff9a4749bcd25d0dfa60b1d7@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3fa6f093ff9a4749bcd25d0dfa60b1d7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/28/24 09:28, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Thursday, November 28, 2024 8:07 AM
>> To: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Donald Dutile
>> <ddutile@redhat.com>; Nicolin Chen <nicolinc@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
>> Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>
>> Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for
>> SMMUv3 Nested device
>>
>>
>>
>> On 11/28/24 04:25, Zhangfei Gao wrote:
>>> Hi, Eric
>>>
>>> On Thu, 28 Nov 2024 at 00:06, Eric Auger <eric.auger@redhat.com> wrote:
>>>
>>>>> Yeah, there is no live migration support yet in the SMMU qmeu driver,
>>>>> AFAIK?
>>>> the non accelerated SMMU QEMU device does support migration.
>>> Could you clarify more about this?
>>> The migration is not supported if using viommu (SMMU QEMU device),
>> isn't it?
>> No this is not correct. Current QEMU SMMU device *does* support
>> migration (see VMStateDescription) as well as qemu virtio-iommu device.
>> so for instance if you run a guest with smmuv3 and protected virtio-pci
>> devices this is supposed to be migratable. If it does not work this is
>> bug and this should be fixed ;-)
> I think if I am right Zhangfei was testing with vfio-pci device assigned on his vSVA
> branch. But migration with vfio device is currently explicitly blocked if vIOMMU is
> present. 
definitively I was talking about migration vSMMU/VFIO which is not upstream.
>
> I think Joao is working on it here[1].
>
> But we may require additional support when we have vSVA to handle any
> in-flight page fault handling gracefully.
>
> Thanks,
> Shameer
> 1. https://lore.kernel.org/all/20230622214845.3980-1-joao.m.martins@oracle.com/
Thanks

Eric
>
>
>


