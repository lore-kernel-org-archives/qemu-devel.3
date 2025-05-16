Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E97FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 20:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG249-0001E0-L6; Fri, 16 May 2025 16:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uG246-0001DX-Gf
 for qemu-devel@nongnu.org; Fri, 16 May 2025 16:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uG245-0005Km-00
 for qemu-devel@nongnu.org; Fri, 16 May 2025 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747428835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnURT22OIYnC5gJKVtsNGXOoWVpAeYrD0y8GllRNCk0=;
 b=LrzarMGK+Ooltx23wbn08t/oQA0CO8S8+cLMf5kSHqJyXSwZZamLssGiShPQFOYx10k24A
 qHLCzYslj1g5eV7VK/PiyZYQdNlPEajTRKSr4dOhc97YsDzOFgppYJywaSiWAVPZNvgExy
 ubDFBotNgfVGsiRw+jA3U3mnBTMYFkY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ZcJzxPTzMXiq9FcNn6E_FQ-1; Fri, 16 May 2025 16:53:53 -0400
X-MC-Unique: ZcJzxPTzMXiq9FcNn6E_FQ-1
X-Mimecast-MFC-AGG-ID: ZcJzxPTzMXiq9FcNn6E_FQ_1747428832
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-231e3cfc144so8812995ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 13:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747428832; x=1748033632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pnURT22OIYnC5gJKVtsNGXOoWVpAeYrD0y8GllRNCk0=;
 b=UcssW1RRhYdz3GFCwA8VsTuWtW5LBdyxCfZDejVLx5BsJ4SNCiqC2Bz3lHKktytwSC
 AmzRTZ4GoX0tMRZUwkAnnkHSQOCtuvrpHdBLKE45rSWAqPKK40MIXFpoAab1lgJ18Rpz
 /S4jP8oWz2NGVavXNO3XqhwlEq0eFjuuftgR13gcU7Y/4ZQbXW3fhO4Hyp+TIy6J+B4g
 VA0ipEcwxE2Cdje16SijBX4nUi1rFzTqlGT2glma+zKG5NPVkjDrd/hh34P2KFSnLrta
 Cn10zuqc4FilKd7O0xDimTrA8mAusPP/AJrvlSVA+EWQsWQkA7MsqxJSxMHfAKnnBRnp
 IREQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU0hr9y1XDFtb2WwsFH4emEmByX37Ue0kddEvgYvWXz0ZcDtIL1nU4JKxJElukHCtb9BNTpTPYunm6@nongnu.org
X-Gm-Message-State: AOJu0Yzy4DwX8R/yC5RsjmdZw+vNAXvj8VAHd26ey+l+kDVnJQ3f3JBO
 fu+4O/3ZGyjdgUDHqUPoEqCijdB193WvchbKisEBQ3XKmZ0WdnbY0fQapWOz/VtDICRt11J3DC9
 A8HEbCeTuvjJAN+PkZ6whqfOOtXtT+d7WjBPhi+Bbk7aBVX/3msHsAZr9
X-Gm-Gg: ASbGncuqc4+f892Ujx4dg91VQo8eJ10cy2mwD8affwHFprrXnNj9+CJQJPu0RkygG9a
 V16pgfLPKN01QufkW6MPvz4BOd7j1Kv0xD01zxglb7MeHXefT6/GcnlofeCRJgUaFjpUj/ZrxqE
 joVClWpJT6HTEpGsP5fWsKXIs0hu0LyW2+gpIZeG/MUZ82YcdWo1p7Icyhw2/G64wVL9rMesZtE
 nf6hx6eM2HYV7/D++nbhKcnrjFvgXGxeCIvnLfORtWiDnEQX33OmY3Q6Yeo3Zw7/x7eKwvU1sGo
 B3YeaFfGsqS0
X-Received: by 2002:a17:903:2f4d:b0:22e:8183:1fae with SMTP id
 d9443c01a7336-231d4598d1dmr68338705ad.41.1747428832051; 
 Fri, 16 May 2025 13:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX5ta+UbrWyMf3IlA4DCmgQDBm7vtafBarcRr0/PwZpKO3JlGsIHAAKvFzUxGKNNksvwXtqA==
X-Received: by 2002:a17:903:2f4d:b0:22e:8183:1fae with SMTP id
 d9443c01a7336-231d4598d1dmr68338435ad.41.1747428831680; 
 Fri, 16 May 2025 13:53:51 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e981desm18520125ad.124.2025.05.16.13.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 13:53:51 -0700 (PDT)
Message-ID: <961b0a65-cadd-41a6-b754-9028dc1be4f6@redhat.com>
Date: Fri, 16 May 2025 16:53:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum via <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/8/25 9:57 AM, Peter Maydell wrote:
> On Thu, 8 May 2025 at 14:46, Donald Dutile <ddutile@redhat.com> wrote:
> 
>> I would refer to the ARM SMMU spec, Figure 2.3 in the G.a version, where
>> it's slightly different; more like:
>>
>>    +------------------+
>>    |   PCIe Devices   | (one device, unless a PCIe switch is btwn the RC & 'Devices';
>>    +------------------+   or, see more typical expansion below)
>>              |
>>       +-------------+
>>       |  PCIe RC A  |
>>       +-------------+
>>              |
>>       +------v---+    +-----------------------------------+
>>       | SMMUv3.A |    | Wide assortment of other platform |
>>       | (IOMMU)  |    |   devices not using SMMU          |
>>       +----+-----+    +-----------------------------------+
>>            |                      |   |   |
>>     +------+----------------------+---+---+-+
>>     |         System Interconnect           |
>>     +---------------------------------------+
>>                                  |
>>     +-------+--------+     +-----+-------------+
>>     |   System RAM   |<--->| CPU (NUMA socket) |
>>     +----------------+     +-------------------+
>>
>> In fact, the PCIe can be quite complex with PCIe bridges, and multiple Root Ports (RP's),
>> and multiple SMMU's:
>>
>>       +--------------+   +--------------+   +--------------+
>>       | PCIe Device  |   | PCIe Device  |   | PCIe Device  |
>>       +--------------+   +--------------+   +--------------+
>>             |                  |                  |        <--- PCIe bus
>>        +----------+       +----------+      +----------+
>>        | PCIe RP  |       | PCIe RP  |      | PCIe RP  |  <- may be PCI Bridge, may not
>>        +----------+       +----------+      +----------+
>>            |                  |                  |
>>        +----------+       +----------+       +----------+
>>        |  SMMU    |       |  SMMU    |       |  SMMU    |
>>        +----------+       +----------+       +----------+
>>            |                  |                  |   <- may be a bus, may not(hidden from OS)
>>            +------------------+------------------+
>>                               |
>>               +--------------------------+
>>               |          PCI RC A        |
>>               +--------------------------+
>>
> 
> 
>> The final take away: the (QEMU) SMMU/IOMMU must be associated with a PCIe bus
>> OR, the format has to be something like:
>>     -device smmuv3, id=smmuv3.1
>>     -device <blah>, smmu=smmuv3.1
>> where the device <-> SMMU (or if extended to x86, iommu) associativity is set w/o bus associativity.
> 
> The problem here seems to me to be that in the hardware we're
> modelling the SMMU always exists, because it's in the SoC,
> but you're trying to arrange for it to be created on the
> command line, via -device.
> 
> We don't have any of these problems with the current 'virt'
> board code, because we have the board code create the iommu
> (if the user asks for it via the iommu machine property),
> and it can wire it up to the PCI root complex as needed.
> 
> thanks
> -- PMM
> 
Peter,
Hey!
Learning more about the use-of/focus/expectation of '-device', I see your point.
The issue is that there isn't just one SMMU in a system (as the diagram above illustrates), they have associativity to
(pcie) devices (possibly more accurately, a pcie-(sub) tree) (for the focus of this discussion; could be non-pcie devices),
and we need an option format to associate smmu to pcie(domain/subtree(RPs), devices), and that typically references
busses (pxbs?) &/or pcie devices (-device). ... or do we only need to add iommu associativity to devices,
  ie, the second option line above, -device <blah>, iommu=smmuv3.1 ... which should enable the right IORT(s) to be
made for multiple smmus/iommus.

- Don



