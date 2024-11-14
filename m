Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7E2D65C6D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXIk-0005Su-So; Thu, 14 Nov 2024 05:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBXIh-0005SS-Cn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:42:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBXIf-0001uI-Lx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731580924;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFDFfa8BumsYNrA9VM6cY1bLhqLeRJ9r5PDt7Li9+cw=;
 b=UC8kmiJrY5XRgNJv11c6E5iaJ3rkbvX+hK9XZKp747jVkxHt5W4rfClALL32xjb0bILCrd
 gg211c/vb/rHb8x+0oknF9xFTrwB3Iayn7UBFq2SlC/WvfRMJ2DynV31YLoTtVYIjFS2Ds
 y4xtKVyUrUjv7I50fVqkeL/+DBpGtL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-QHO9v36TN_iSco3oBDVNSQ-1; Thu, 14 Nov 2024 05:42:03 -0500
X-MC-Unique: QHO9v36TN_iSco3oBDVNSQ-1
X-Mimecast-MFC-AGG-ID: QHO9v36TN_iSco3oBDVNSQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382219f45baso7241f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 02:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731580922; x=1732185722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFDFfa8BumsYNrA9VM6cY1bLhqLeRJ9r5PDt7Li9+cw=;
 b=ueLSSxC3iF+/FHu6BKkKatSQDqE76tnmLnH/Yz7AUEuMSxD8bvM9MwQwvSavz14DHF
 6R/1f5XG8Dn34gsAF4kKTJUqagGq4fjkwyzu483GSWyaQIASIYr6sybaj58vLjFJK6Lz
 6+dyH4ryJuoxljkpakxdl1fuGp3h1EvAGFCrbi0Mv0pDd19Mr2DeyU8tVy7qDYG7+xmL
 DsHQbQwcpJBPBhorEllPSAOaHUYxejWs3WZUlcMeKMVCpwKLDf5J26BNSgqim0zwq4gd
 tpMTHJr5DYw1WO4VMHtDpkN5bwFMXYLJ+xV5b/UxHHGKEc61YjnN34E2jxKhzEPufEb7
 PjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOzE5ratbKI6HnE9Xqi+RAph1FdqjfEUK/oxbxYQkP14urA6tvzeeRpAMS8lvw0YjojyrdfKDaMATu@nongnu.org
X-Gm-Message-State: AOJu0Yz03jODu2SEx3to4nU1+vuwCh23gDRSeFHXsHDPlYhhIhWyt2go
 ieq5zLUSDxs2/EJ+WVkoR054XXHkU85MrK5t9B77YjxfF6x3ICvGaeKfFfS0chT/VJl2oVqA+qf
 T+wwrcz72DpHcKvl0zk2N2aLqo3y7W+IKZd7oS1xw/nINvDzzHjzC
X-Received: by 2002:a5d:64e2:0:b0:381:f08b:71a4 with SMTP id
 ffacd0b85a97d-3820833ad72mr7984230f8f.45.1731580921916; 
 Thu, 14 Nov 2024 02:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESxkjAtGPP8t9U8iGbowy255ZHVvOB10IaIl9M5OtWbMBQ/OEc81PDBIl3lRWSytrRCUWyPg==
X-Received: by 2002:a5d:64e2:0:b0:381:f08b:71a4 with SMTP id
 ffacd0b85a97d-3820833ad72mr7984199f8f.45.1731580921520; 
 Thu, 14 Nov 2024 02:42:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae15d95sm1125291f8f.85.2024.11.14.02.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 02:42:00 -0800 (PST)
Message-ID: <a30e5df1-3dcc-48c9-b632-861dbeee7886@redhat.com>
Date: Thu, 14 Nov 2024 11:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
 <ZzTwZWXp0dIZB3E4@Asurada-Nvidia>
 <cf0d88bc649344a4b396575cc58394ac@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <cf0d88bc649344a4b396575cc58394ac@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On 11/14/24 09:48, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Wednesday, November 13, 2024 6:31 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>> ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions
>> to handle MSI nested binding
>>
>> On Fri, Nov 08, 2024 at 12:52:42PM +0000, Shameer Kolothum wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> To handle SMMUv3 nested stage support it is practical to expose the
>>> guest with reserved memory regions (RMRs) covering the IOVAs used by
>>> the host kernel to map physical MSI doorbells.
>> There has been an ongoing solution for MSI alternative:
>> https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/
>>
>> So, I think we should keep this patch out of this series, instead put it on top
>> of the testing branch.
> Yes. I think then we can support DT solution as well. 
>
> On that MSI RFC above, have you seen Eric's earlier/initial proposal to bind the Guest MSI in
> nested cases. IIRC, it was providing an IOCTL and then creating a mapping in the host.
>
> I think this is the latest on that.
> https://lore.kernel.org/linux-iommu/20210411114659.15051-4-eric.auger@redhat.com/
yes this is the latest before I stopped my VFIO integration efforts.
>
> But not sure, why we then moved to RMR approach. Eric?

This was indeed the 1st integration approach. Using RMR instead was
suggested by Jean-Philippe and I considered it as simpler (because we
needed the SET_MSI_BINDING iotcl) so I changed the approach.

Thanks

Eric
>
> Thanks,
> Shameer
>


