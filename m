Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B539C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiHO-0002Ia-QI; Mon, 10 Jun 2024 12:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sGiHM-0002I6-JD
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sGiHK-0004oG-3D
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718038432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0s/uWAI7M1U/nwn2vRsulGAQeK7ZD9CxcvEqixgV7Pk=;
 b=AuRwgMI0vjFREm6IeYQ2OaH8pEn0MiZcv71mW1rne7QzoBx7sTZdOg1QJPdBxa0NS+ld8r
 vJz71uIZi1EQxtsmy+7TBJzW58xEJonMHTZZjTWO7Wti4I5+j4ra/EysZick9V4M+j4k87
 y+uus7Bw8FD4LQASpz8tB65S/Y22ACI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-2GWwTw2AOWC3XDNDgNWJew-1; Mon, 10 Jun 2024 12:53:50 -0400
X-MC-Unique: 2GWwTw2AOWC3XDNDgNWJew-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52bc277eba6so2146753e87.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038429; x=1718643229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0s/uWAI7M1U/nwn2vRsulGAQeK7ZD9CxcvEqixgV7Pk=;
 b=dZ7/xaobbPD06HBt+tnwuORndZwztQBqNF4c/pQOnVGhJGVuXehd6FOUKgiA3dF+rc
 tVKmZac6O13phft0pX5pTDK+XVAD64dPkzHiQgVOrX9rdBE7rkEicWNeuXIpsQuRDWxW
 Exfsa25ZNV2UJfVo1o7+CFNN84JyH0fxhzWEJ4bnpzFh4JOUUcq+oCuqqt3yoBczyLLk
 z9JyFi/oRWWfT3x2+1f4+rBvSQQcvC8eabYzTBL167h2Medo44sQVuzyzsBRv29EBTBb
 eofv8EsFCusN6zN73XFPF0p9W0lnaNitNsGqfTjiLXNqqjy21oJOt2u9w1an0tSDhdFQ
 vXYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHIhjfNMx66Vz5Ggs04wNAP5JbqWdVsc87vok46SGSwFWFrcqIsAzoPlm57VaDTRuNB1ioboqSbJ35DVsgGs3ZzFCCpFc=
X-Gm-Message-State: AOJu0Yyz7Y4AAM43m1SbMf5nNdy1vNKYCzEpd3K4/caeSJSCiTRFT6sQ
 U10oSzOs5hWSbl1vQy8WwLdgzx0K7g9wMpm+bKcs0r79JQss8P8ZnrUdbb7HbZZQi4eaZy3Y8u+
 7JdvpBUWMKXJvOYOjoUaJf+7zkrE2E9u7ChI9UqgAP/UPjm5XveRQ
X-Received: by 2002:a05:6512:3151:b0:52b:bd90:29c8 with SMTP id
 2adb3069b0e04-52bbd902b88mr4937222e87.60.1718038429147; 
 Mon, 10 Jun 2024 09:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDIbepzWqb2IwLUkEzkMNJg58oSTPqAIU04st1xcJRybwul0bBX3vXGo+XsAia5C0Sjy1+fQ==
X-Received: by 2002:a05:6512:3151:b0:52b:bd90:29c8 with SMTP id
 2adb3069b0e04-52bbd902b88mr4937209e87.60.1718038428714; 
 Mon, 10 Jun 2024 09:53:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f224d5151sm3914021f8f.3.2024.06.10.09.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 09:53:47 -0700 (PDT)
Message-ID: <d6ef8a37-9337-433e-a0bf-ce50af20a734@redhat.com>
Date: Mon, 10 Jun 2024 18:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <088a0db6-ae69-4d85-a817-1685d4053d17@redhat.com>
 <8ca65f18-5a0d-4176-9bc1-f318d4ba4db5@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <8ca65f18-5a0d-4176-9bc1-f318d4ba4db5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/7/24 5:10 PM, Joao Martins wrote:
> On 06/06/2024 16:43, Cédric Le Goater wrote:
>> Hello Joao,
>>
>> On 6/22/23 23:48, Joao Martins wrote:
>>> Hey,
>>>
>>> This series introduces support for vIOMMU with VFIO device migration,
>>> particurlarly related to how we do the dirty page tracking.
>>>
>>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>>> provide dma translation services for guests to provide some form of
>>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>>> and remove the migration blocker when vIOMMU is present provided the
>>> conditions are met. I have both use-cases here in one series, but I am happy
>>> to tackle them in separate series.
>>>
>>> As I found out we don't necessarily need to expose the whole vIOMMU
>>> functionality in order to just support interrupt remapping. x86 IOMMUs
>>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>>> can instantiate a IOMMU just for interrupt remapping without needing to
>>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>>> the same, but Linux doesn't quite support the IR-only part there yet,
>>> only intel-iommu.
>>>
>>> The series is organized as following:
>>>
>>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>>> establishes their first DMA mapping via the vIOMMU. So these first four
>>> patches add a way for vIOMMUs to be asked of their properties at start
>>> of day. I choose the least churn possible way for now (as opposed to a
>>> treewide conversion) and allow easy conversion a posteriori. As
>>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>>> was doing in v3.
>>>
>>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>>> DMA translation allowed. Today the 'dma-translation' attribute is
>>> x86-iommu only, but the way this series is structured nothing stops from
>>> other vIOMMUs supporting it too as long as they use
>>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>>> we've then tackled item (1) of the second paragraph.
>>>
>>> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
>>> IOVA address space, leveraging the logic we use to compose the dirty ranges.
>>> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
>>> addressing limits. This tackles item (2). So far I mainly use it with
>>> intel-iommu, although I have a small set of patches for virtio-iommu per
>>> Alex's suggestion in v2.
>>>
>>> Comments, suggestions welcome. Thanks for the review!
>>
>>
>> I spent sometime refreshing your series on upstream QEMU (See [1]) and
>> gave migration a try with CX-7 VF. LGTM. It doesn't seem we are far
>> from acceptance in QEMU 9.1. Are we ?
>>
> Yeah.
> 
> There was a comment from Zhenzhong on the vfio_viommu_preset() here[0]. But I
> was looking at that to remind myself what was it that we had to change, but even
> with re-reading the thread I can't spot any flaw that needs change.
> 
> [0]
> https://lore.kernel.org/qemu-devel/de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com/#r

I introduced a vfio_devices_all_viommu_preset() routine to check all devices
in a container and a simplified version of vfio_viommu_get_max_iova()
returning the space max_iova.


>> First, I will resend these with the changes I made :
>>
>>    vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>>    vfio/common: Move dirty tracking ranges update to helper()
>>
>> I guess the PCIIOMMUOps::get_iommu_attr needs a close review. Is
>> IOMMU_ATTR_DMA_TRANSLATION a must have ?
>>
> It's sort of the 'correct way' of relaxing vIOMMU checks, because you are 100%
> guaranteed that the guest won't do DMA. The other outstanding thing related to
> that is for older kernels which is to use the directmap for dirty page tracking,
> but the moment a mapping is attempted the migration doesn't start or if it's in
> progress it gets aborted[*]:
> 
> https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/
> 
> The above link and DMA_TRANSLATION is mostly for the usecase we use that only
> cares about vIOMMU for interrupt remapping only and no DMA translation services.
> But we can't just disable dma-translation in qemu because it may crash older
> kernels, so it supports both old and new this way.
> 
> [*] Recently I noticed you improved error reporting, so
> vfio_set_migration_error(-EOPNOTSUPP) probably has a better way of getting there.

Yes. So, I did a little more change to improve vfio_dirty_tracking_init().

>> The rest is mostly VFIO internals for dirty tracking.
>>
> Right.
> 
> I derailed with other work and also stuff required for iommu dirty tracking that
> I forgot about these patches, sorry.

That's fine.

I am trying to sort out which patches could be merged in advance for QEMU 9.1
and your series has shrunk a lot since it was last sent. I might resend the
whole to cherry pick the simple changes and get some R-b tags.


For the record, here is my watch list:

QEMU series under review:

* [v7] Add a host IOMMU device abstraction to check with vIOMMU
   https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com

   Needs feedback on the PCI IOMMU ops. vIOMMU "iommufd" property ?
   Pushed on vfio-9.1 branch.
   
* [RFC v2] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
   https://lore.kernel.org/all/20240607143905.765133-1-eric.auger@redhat.com
   
   Pushed on vfio-9.1 branch.

Need a resend :

* [v4] vfio: VFIO migration support with vIOMMU
   https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
   
   Refreshed the patchset on upstream and pushed on vfio-9.1 branch.
   
* [RFCv2] vfio/iommufd: IOMMUFD Dirty Tracking
   https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/

* [v1] vfio: container: Fix missing allocation of VFIOSpaprContainer
   https://lore.kernel.org/qemu-devel/171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com/
   

Other interesting series (IOMMU related):

* [rfcv2] intel_iommu: Enable stage-1 translation for emulated device
   https://lore.kernel.org/all/20240522062313.453317-1-zhenzhong.duan@intel.com/

* [PATCH ats_vtd v2 00/25] ATS support for VT-d
   https://lore.kernel.org/all/20240515071057.33990-1-clement.mathieu--drif@eviden.com/

* [RFC v3] SMMUv3 nested translation support
   https://lore.kernel.org/qemu-devel/20240429032403.74910-1-smostafa@google.com/

* [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
   https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

   Yet to be sent,
   https://github.com/nicolinc/qemu/commits/wip/iommufd_vcmdq/

* [RFC] Multifd device state transfer support with VFIO consumer
   https://lore.kernel.org/all/cover.1713269378.git.maciej.szmigiero@oracle.com/


Thanks,

C.

  



