Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53774D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrhP-0007d3-JJ; Mon, 19 Jan 2026 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhrh8-0007b7-8j
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhrh3-0007la-HQ
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768838488;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkNFHMjVcRNOk3MkCKGBOyDTzxGFZH8/T+TYOSWSSUg=;
 b=SDjcLmyaZLdZ6quVB2pe6hrs3pStAQJc2YQgNNZJexFOu2UbIJcYtu94n161we0fqz6KRv
 Ox0mx+cPIpXDCdcPuvw9AJYhzZqi+Wqn6rVkPMgRhtb3e9a3nIU9gkUmOvT/Nasv6OBKER
 HeoUn7A1ttmlA6hYEUZGyvbu/zMKV1c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-37gXuO6LOxisKl7SbKzuwg-1; Mon, 19 Jan 2026 11:01:26 -0500
X-MC-Unique: 37gXuO6LOxisKl7SbKzuwg-1
X-Mimecast-MFC-AGG-ID: 37gXuO6LOxisKl7SbKzuwg_1768838484
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801d21c280so25979335e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 08:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768838484; x=1769443284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkNFHMjVcRNOk3MkCKGBOyDTzxGFZH8/T+TYOSWSSUg=;
 b=Dl1IUa8gOo/ss2uPOFMVJ54S3kgkMbRe5fC5w/SlMy1kMfay3wMiArNKTbKNb4HVnd
 i/ngE6wmcWmELAsu44KFdS1HkPTWfih/LVBeJPcEfHdgXjuIbdpFxbnReRah0Oe6Dhor
 oCJpk8oQzwZMTI48CxThqMNR5Z694kUgEXYIOvb6KGsSpNgEcvvU7A2acEbDB3D703zK
 81EgPOg8z7B55CzyRvEAZUgT2WTxRqqH4svLGUUcihG79LXT/LYwoL7nqL5PUvBNosM2
 3dRd2vWxYwZsnY5LLXBcPzJKVfFrdTYxIf/DV0attiiY+rr22BpbePCI3mcpekIl7wCf
 QPIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQCBKiGqmnBuQBs+rItAA84xhYcMEdd+tMk94io6lOwC6ftIotxe1fDyfSKbXfywdfKCzTlI1j3HYX@nongnu.org
X-Gm-Message-State: AOJu0Yx/pQ7qq+x4MbbhJ1i8IvRc29qLusJx3YtoFeEi0Yz/Ktv+57Al
 Y23gJxUA0JGw6KHsWj25pHFooIDyUgZhYGb/RKmkaFVI9Cs/CsCSt7mt+4fX+pSBlsHJXsbAgw+
 X/FhCZzdaoTJaUQesCu60eyhIy5j8Mw6cno8A3areru9+s4hyVsiFVQCG
X-Gm-Gg: AY/fxX6+MYiUiv6Ci1St/qbly1anVrFOgU4kbJs4IClolpoCk6ubC9q04dUSdZdKlwg
 y1iLrqC0dy1ggs8gQbd7PgP0axi4U12RI01sXjjbXTNSpausRH7lcDOdTnZVLuXZoSLkhezPzBv
 B4vDcOSe4mEDv8l22J3v7h8Kc3cD3yuiHLS0/EaQ6xvNn8gO36xI9yLrm/89uKsXre36EdIzxCh
 2dLgLQcKC5ozt884CajgG4CmWyL18BJ8GtEjpgFFS1+snxxW0bGyco5oR7CPhSprfase8IxlfGH
 ZwV2b/XotsR6NH3WjWs3Oy77zr0WzjM1l90HFMN2YraNIo/ARgkwBBfLdXf43EA/T9JNQC5yiPl
 I3s4Dsc+3PmpOd/yho8ecxO+Z/gUBxVD3bjgXDI4cC4F+/7E2bcAkoDzZ4A==
X-Received: by 2002:a05:600c:8b38:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4801e30f96cmr148175385e9.14.1768838482596; 
 Mon, 19 Jan 2026 08:01:22 -0800 (PST)
X-Received: by 2002:a05:600c:8b38:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4801e30f96cmr148174305e9.14.1768838481656; 
 Mon, 19 Jan 2026 08:01:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f429071besm252304705e9.10.2026.01.19.08.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 08:01:21 -0800 (PST)
Message-ID: <c796d5e8-6859-41e6-87f9-b1195dddeb1a@redhat.com>
Date: Mon, 19 Jan 2026 17:01:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <CABQgh9FwSTB8Cp8f1POSBti376ZH3B0e0mLu9FU==p1wVwquGg@mail.gmail.com>
 <CH3PR12MB7548626563C6E67FB802D850AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548626563C6E67FB802D850AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/14/26 11:36 AM, Shameer Kolothum wrote:
> Hi Zhangfei,
>
>> -----Original Message-----
>> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Sent: 14 January 2026 04:18
>> To: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
>> berrange@redhat.com; clg@redhat.com; alex@shazbot.org; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
>> Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
>> capability at a fixed offset
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi, Shameer
>>
>> On Mon, 12 Jan 2026 at 03:58, Shameer Kolothum
>> <skolothumtho@nvidia.com> wrote:
>>> Add pcie_insert_capability(), a helper to insert a PCIe extended
>>> capability into an existing extended capability list at a
>>> caller-specified offset.
>>>
>>> Unlike pcie_add_capability(), which always appends a capability to the
>>> end of the list, this helper preserves the existing list ordering
>>> while allowing insertion at an arbitrary offset.
>>>
>>> The helper only validates that the insertion does not overwrite an
>>> existing PCIe extended capability header, since corrupting a header
>>> would break the extended capability linked list. Validation of
>>> overlaps with other configuration space registers or
>>> capability-specific register blocks is left to the caller.
>>>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> The guest kernel fails to boot with para "ssidsize=16" with v7 series.
>> Without ssidsize, guest kernel can boot no problem.
> Thanks for giving this a spin. 
>
>> However, pasid feature requires ssidsize.
>> smmuv3_accel_get_viommu_flags
>> if (s->ssidsize) {
>> flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>>
>> v6 does not has such issue, and does not requires ssidsize param.
> As mentioned in cover letter this series has changed the way the overall 
> PASID is enabled. It now allows user to specify an offset to place the
> PASID CAP for vfio-pci devices,
>
> -device vfio-pci,host=0018:06:00.0,..,x-vpasid-cap-offset=xxx
>
> If none is specified it will place it at the last offset as default.
>
> And you need "ssidsize" to specify the SMMUv3 sub stream Id bits.
>  
>> log:
>> ASSERT_EFI_ERROR (Status = Invalid Parameter) ASSERT [PciBusDxe]
>> /home/linaro/work/edk2/MdeModulePkg/Bus/Pci/PciBusDxe/PciLib.c(626):
>> !(((INTN)(RETURN_STATUS)(Status)) < 0)
> It could be that the pcie_insert_capability() helper added here is corrupting
> the config space. Looking at it again, I can see that it is not handling a few
> corner cases.  Could you please replace the pcie_insert_capability() with
> the below and retest. 
>
> Thanks,
> Shameer
>
> ...
>
> bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>                             uint16_t offset, uint16_t size)
> {
>     uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
>     uint32_t header;
>
>     assert(offset >= PCI_CONFIG_SPACE_SIZE);
>     assert(offset < (uint16_t)(offset + size));
>     assert((uint16_t)(offset + size) <= PCIE_CONFIG_SPACE_SIZE);
>     assert(size >= 8);
>     assert(pci_is_express(dev));
>
>     header = pci_get_long(dev->config + pos);
>     if (!header) {
>         /* No extended capability, check requested offset is at PCI_CONFIG_SPACE_SIZE*/
>         if (offset != pos) {
>             return false;
>         }
>         pci_set_long(dev->config + pos, PCI_EXT_CAP(cap_id, cap_ver, 0));
>         goto out;
>     }
>
>     while (header && pos && offset >= pos) {
>         uint16_t next = PCI_EXT_CAP_NEXT(header);
>
>         /* Reject insertion inside an existing ECAP header (4 bytes) */
If I understand correctly you don't check the whole EXT CAP size but
just the header, correct?
>         if (offset < pos + PCI_EXT_CAP_ALIGN) {
>             return false;
>         }
>
>         prev = pos;
>         pos = next;
>         header = pos ? pci_get_long(dev->config + pos) : 0;
>     }
>
>     pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, pos));
>     if (prev) {
>         pcie_ext_cap_set_next(dev, prev, offset);
>     }
>
> out:
>     /* Make capability read-only by default */
>     memset(dev->wmask + offset, 0, size);
>     memset(dev->w1cmask + offset, 0, size);
>     /* Check capability by default */
>     memset(dev->cmask + offset, 0xFF, size);
>     return true;
> }
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric


