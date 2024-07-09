Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F9C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREXs-0007q6-0k; Tue, 09 Jul 2024 13:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sREXq-0007pJ-Vz
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sREXp-0002RV-GL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720545744;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLCSdK5CDxFC2cuLoRA2C0FbaS0h1Z97ombPVZtp9+E=;
 b=WW0fPPOHrvzeo2B/5vPuv3JPeEFJKUxYP1la5Gmdv2EFxcO8apdvsmGkvhAjGUHu+USHkX
 koS3ztPdW7EOH2OHbdiNMn0MKIcL4S1+zbfLS1RAfVADHN6TxJbEw9k4zPgw8RFBv7TgCF
 m8jogHbBQWkCktSZ5XxC1Wfzq/bL2zY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-4IBFEXCwPQOsKIT3mC-4uA-1; Tue, 09 Jul 2024 13:22:22 -0400
X-MC-Unique: 4IBFEXCwPQOsKIT3mC-4uA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-447dc559df8so56379361cf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 10:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720545741; x=1721150541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iLCSdK5CDxFC2cuLoRA2C0FbaS0h1Z97ombPVZtp9+E=;
 b=STopVr3uDoxKGHXYb6yo5mWALmA3X8+k+AAKzb9pOH0upPJlF3JyU2uhFMUXQh9rHT
 W/MDNytMFKbRvA77CRo9K0xcUeYoLZaZN2j4KOz+Pgv/qeu1TcVqVxvHLUvviSVXBPDx
 yVsAzvGi4oB6MkyVVM1XgNVkwjGIbKuUM2qp9PtEDYwIuaOQ47EOpbpj+iw1aPRAjVq9
 uFUzq8zUnR7I6xdC7VGceatvr9/pCuL2rpkUcOVeZCG4sC7psfJ92zszgRJ8mzjHv+66
 6K3PswcViAF8lNDpn5hX9A0FSo28GEEI/MWyIQ4/VasfN8ULDxD/rZU/3QWxwOvBYSyV
 Bmxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU24WJ+nD84P1FtioAfS8Q+Y9K+RIfkVaGpXs9tqm0WzFahQTL6kMvaMJiPkQQpxtn67Jf2JfUh9FB3BueumemV/bEmmo8=
X-Gm-Message-State: AOJu0Ywcb5x9Tuj12SgkB4ATzCOvM2RNKk6RYogoiMDUxjdUf98weLhJ
 lkxn2B1yFgc+74yiP8PFUu+33ceGwY6lLIHvTLCJ31HcdzVCRCgCcuuiPp64rWwBbHK0mZlW5sr
 4XQieERcGbqHtZj72ssotDlBTQfZCV2SI47qQ4foNTYFgyzvAUnk8
X-Received: by 2002:a05:622a:24e:b0:447:f259:2954 with SMTP id
 d75a77b69052e-447faaa5f53mr31109271cf.51.1720545741229; 
 Tue, 09 Jul 2024 10:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL/4X/cZ9DENEjCie75O20UPBB1qdjg+CxwMH+JGJJM6MQROSO4ympQLIJ2mTFqRFjHHbi0g==
X-Received: by 2002:a05:622a:24e:b0:447:f259:2954 with SMTP id
 d75a77b69052e-447faaa5f53mr31109121cf.51.1720545740923; 
 Tue, 09 Jul 2024 10:22:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9b26842sm12359921cf.3.2024.07.09.10.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 10:22:20 -0700 (PDT)
Message-ID: <33e5c4b7-6f5e-4ef2-9156-9a1e4b6a2dfe@redhat.com>
Date: Tue, 9 Jul 2024 19:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 03/10] hw/arm/virt: Get the number of host-level
 SMMUv3 instances
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peterx@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <886883c4cb43117ef26e6c9434247b75cd827f31.1719361174.git.nicolinc@nvidia.com>
 <3d151591-4cc6-4de4-8055-27d6fb7200df@redhat.com>
 <Zo1vW5dwHqBM5zFN@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zo1vW5dwHqBM5zFN@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/9/24 19:11, Nicolin Chen wrote:
> On Tue, Jul 09, 2024 at 11:20:16AM +0200, Eric Auger wrote:
>> On 6/26/24 02:28, Nicolin Chen wrote:
>>> Nested SMMUv3 feature requires the support/presence of host-level SMMUv3
>>> instance(s). Add a helper to read the sysfs for the number of instances.
>>> Log them in a vms list using a new struct VirtNestedSmmu.
>>>
>>> This will be used by a following patch to assign a passthrough device to
>>> corresponding nested SMMUv3 instance.
>> Laterly the HostIOMMUDevice has been introduced to allow, among other
>> things, to pass information related to the physical IOMMU to the virtual
>> IOMMU.
>> I guess it would be well fitted to associate the viommu with its
>> underlying piommu.
> Wow, I missed that part -- backends/host_iommu_device. I will
> see how I can fit these well with that.
>
>> I don't think we have such kind of host introspection in machine type.
>> Generally in can happen in the very device or in libvirt.
> I think the biggest reason for having such an introspection in
> the virt code is because of hotplug, (though it's not properly
> implemented yet), as we don't know what new devices requiring
> for nested translation would be joining later. So somebody has
> to hold a full list.
>
> Would you mind elaborating how the "device" or "libvirt" can
> handle that?
If you know that on Grace you have 5 SMMU instances, can't you pre-build
a PCIe topology with 5 PXB and root ports at libvirt level.
Then when you hotplug your device you specify the corresponding slot
just as we do normally. But maybe I misunderstood the hotplug problematics.

Eric
>
> Thanks!
> Nicolin
>


