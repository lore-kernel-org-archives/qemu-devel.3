Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A954EDEC1E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgxF-0002Xp-NO; Wed, 04 Mar 2026 02:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxgxD-0002XW-EE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxgxB-0001w4-L9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772610452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvUPKYkxpX6p5uo9rCWImCxrWe8EsHHLUaB5/uPujno=;
 b=TsJlhJ9wxaha8Rqowe9FMKeXdgSySfhSN2AIViqQLAm02YLG5CgbGR+csPUxs3t95joVXy
 Ozmhw4ZQYguc0g01ZIwPmP4n1WJeYYYh0dZTy8PatX/+Lww0BXJR4LgzP/Zzk5p95M/Ndn
 hQ/NRIvixeuCl+5soBvDoeDiebNi4FM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-6oTblHAyMQqrV5T8kCCZ4w-1; Wed, 04 Mar 2026 02:47:31 -0500
X-MC-Unique: 6oTblHAyMQqrV5T8kCCZ4w-1
X-Mimecast-MFC-AGG-ID: 6oTblHAyMQqrV5T8kCCZ4w_1772610450
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so45554985e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772610450; x=1773215250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvUPKYkxpX6p5uo9rCWImCxrWe8EsHHLUaB5/uPujno=;
 b=u9M/vsQosKsfhxjbi1/wLkRP20/J7tAkkUiMfEE3BdEpv6sjI95DjPz5kr6Y/gjEXD
 Fzg2bs6fpoaIqUv0ykACivo7oHLM8twjZVW29WFMxiTw7lC9em/0+ag9H8fOkNc/tP0F
 SOG3/A8k0+jJP8/C85RbKdiJ7KAoWFQQBt9dWpbtJYRc9O+2xJO6NtTm882RWEsAs3RJ
 ANTkFRL8JKyU6Bwz5BhJwTLdHP+DhzUWU9wIMMr/7LxkGQEQFQz5pFp2Fk6NOqIvUCF9
 zP0J39IIDPJ4OewtahI+dV1q9mEtrch+ZeRWqpSKyOLpCbtdwdhfqvEDnzqF/IZr/LTr
 DpKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKA4DneafZx6EPoElLr1X1817h2pV7PtWYB4Sqry3rb4VQOAVJosmn7UE4D3wXBrItv/bsz6e+e7rQ@nongnu.org
X-Gm-Message-State: AOJu0YxRIIOwCyCxJ/MJcyumPWyHjycnn0VFx7PEaEYOpALaZViRRO4Z
 D3Nc7GCjLvnf8XUi/QlLavYRmR02fn76XqwhotZpaHMXNbOeaQTSPNGLY0FHHfrgtr7ZHU4KTrT
 JRS7WXwmgD4FHUKB091h7oY1pPlvs7I8lSR9uO6O1RjMBewIO2wv6xuzF
X-Gm-Gg: ATEYQzzBSYS9Sp1qr3NfbMH2a1DZnLM8V9j1MvBhkluQcBta4vk5XHgIdPmwfI8ADTZ
 t75GDTI0q9FPbQ9NaxPKiyWoKlIKAbV93ZJojEt4Q2UDr5YUY6Q/wX865EO5XdVkltQqsn66sIK
 432oWvWubOrayhzsoMqtR9KBLb2/RWdkwdZTrpfWpxPiTa7+0Gh0FJhEzR8luW3AdgSso6ECOrd
 Y5XTOnGDdNwxT6jBA5eJeVfHfgCdh3xlD2QBNGKf09gGOIBiXyiwI4C8QGZD0ZuplPTok6pR5vM
 i+0/mcONFHTbGvrnJsLC8iIO0TvYFS5aTBU6VExzTI9oPeGoUqeMSwnXXduPLWRU18ksSoxD2fa
 dj+MWYCN8GAlsEhg/s9DiwN/7xJPQQLzQZYvEVn0jLTvE9G/uwLF9hr3vmLun/L172o7uBQ==
X-Received: by 2002:a05:600c:620f:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-485198a2bcfmr14417405e9.31.1772610449825; 
 Tue, 03 Mar 2026 23:47:29 -0800 (PST)
X-Received: by 2002:a05:600c:620f:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-485198a2bcfmr14416935e9.31.1772610449335; 
 Tue, 03 Mar 2026 23:47:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851a8a9542sm9494755e9.1.2026.03.03.23.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 23:47:28 -0800 (PST)
Message-ID: <41aaf959-b417-469e-89aa-41c20a4b906c@redhat.com>
Date: Wed, 4 Mar 2026 08:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Pavel Hrdina <phrdina@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
 <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Hi Shameer,

On 2/10/26 4:12 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Shameer Kolothum Thodi
>> Sent: 02 February 2026 16:04
>> To: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
>> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
>> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
>> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
>> specify OAS bits
>>
>>
>>
>>> -----Original Message-----
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: 02 February 2026 16:00
>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>>> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
>>> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
>>> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>>> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
>>> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
>>> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
>>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>>> <kjaju@nvidia.com>
>>> Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
>>> specify OAS bits
>>>
>>> On Mon, Feb 02, 2026 at 03:38:50PM +0000, Shameer Kolothum Thodi
>>> wrote:
>>>
>>>>> We can treat ATS as a per-PCIe device property.. I think it would
>>>>> be fine to tell the SMMU that it always has ATS support, it will
>>>>> never do anything with it unless it sees a PCIe device with an ATS
>>>>> cap, and the physical STE generated by the hypervisor should sanitize the
>> EATS.
>>>>> BIOS overriding it should be reflected as the devices being
>>>>> reported as not supporting ATS, qemu should have a per-device flag
>>>>> to disable ATS.
>>>> Do we have way to detect that(IOMMU_FWSPEC_PCI_RC_ATS) from
>>>> userspace now?
>>> I don't think so.. I was describing how I suspect that should work.
>>>
>>> The iommu driver is the only entity that decides if ATS should be
>>> enabled per-device, so it should report back to userspace in iommufd
>>> if the device is allowed to enable ATS or not. That should roll up any
>>> FW overrides and the PCI cap block.
>> Right. May be just like the out_max_pasid_log2. Will take a look.
> Looking at adding the ATS detection support through iommufd, one
> idea is to extend the enum iommufd_hw_capabilities with
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. The question I have
> now is whether we need to differentiate an old kernel which doesn't
> have this support or not.
>
> This is how the usage would look with an added "ats" property on the
> vfio-pci device:
>
> -device vfio-pci,...,ats=on
>     if ATS_NOT_SUPPORTED then reject
> -device vfio-pci,...,ats=off
>     keep ATS off
> -device vfio-pci,...,ats=auto (default)
>    if ATS_NOT_SUPPORTED, disable ATS
>     otherwise, enable ATS if the PCIe ATS capability is present
>     (this also covers behaviour on older kernels)
>
> Does the above make sense?
Do you have plans wrt the migration to auto properties for the various
vSMMU properties (RIL, ssidsize, OAS, ATS)? I just would like to make
sure libvirt integrators take this new design into account.
Please let me know if some help is needed for the conversion of some of
the properties?

Thanks

Eric
>
> Thanks,
> Shameer
>


