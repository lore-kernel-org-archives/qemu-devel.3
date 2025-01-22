Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A472DC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVaN-0004jN-Lq; Wed, 22 Jan 2025 02:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taVaL-0004in-EE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taVaJ-0003h8-DC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737532533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9QbCcnhOCwDqHTDGr12UlNscT4Hiusjc6Xs3cgat5k=;
 b=h6D82rocC67Xbhd8bFiOV66+YUSuQAJVhD3YTnhzjErsSWjXNMCJKTUkZDekxmwVpF+qvq
 ZTFcaLV+lqoZHF/OmfoyFciF6VrODb9CI0OLgqnxGErcS5DYM8nXAYar9qpGvk/eT+7+Wc
 F6cMgtWo/86Mt36wG0UGGPs92S3WAZA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-mzCxpXiWMw2gngrheHQkcg-1; Wed, 22 Jan 2025 02:55:30 -0500
X-MC-Unique: mzCxpXiWMw2gngrheHQkcg-1
X-Mimecast-MFC-AGG-ID: mzCxpXiWMw2gngrheHQkcg
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4679aeb21e6so112121091cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737532529; x=1738137329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/9QbCcnhOCwDqHTDGr12UlNscT4Hiusjc6Xs3cgat5k=;
 b=woPvEetEWtONfNSOEbxR0IDoJ5d8Vs3nsp16t+8bu/FLPe7vtUG+Q6J3L5mBcYdRwb
 m6XpjfzoV4wzCD2GXYfTR+MP/T9rPP6fwBOwr70+O35DRMqlsACHvJx+w3TBwvv0inAr
 gX5G19yIERbu+ki6t6Vq79Z/HTk+2fUK7mmgjJ30deXqDwadF4bdJhuz7E3/3K1zFg4C
 N2MlNwSNoOmHiT2Sa1mnunaxzquIoIjX0jWvrrtR0WUTZtnOsaHOTHPldUcZkxGfZ0AD
 RXlwEhqTmOEV14jTtGUSHTAZqDZyAfO4H72b0IGVnIX5IDKGO8gySPKl6RQTmN4Tk2ul
 nIUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEKY3UQ9Y0niNjUNP8jRzGrLlOPUnqsTzIr2zxWN9JPJrAaJ7yeBX0kEKUD5fsE8fhSyaaxThQJ5Yv@nongnu.org
X-Gm-Message-State: AOJu0YzIDVDdzlpDxLHudShRawWI7uPUaOkf9I3gCajHGovchVAJcmdz
 l0ZvKvGBHVw+HE7wxjsv6nIYVzrMXAD/DPLMJy5O7pI1ImQOW0HV4WD3+stNuUYw5NSYSbFo41C
 9JwURcl5eiv+xMK/N/ZpruO0em4gzeWe2nGKRYqMeo1P6hzwmupBw
X-Gm-Gg: ASbGncv1j+yy9vBM1jIIuQQxuQF6S41bfUrE7KqVw37GQDvCSqsZFq41+HTtl71znGr
 4uBjsVyvfQQuoriNMVy+XnU5KL2fyz6YYZtSx01UWcyLhODne/ze9+K+o8p/6+KpqsUBRz7oZB+
 mQYhDl1CGrZ6ABozS4Hf3pGSxuoyNb915SXz3CXrgEw402ujrm3mGpaJjL/Pt3Rc+KExawZJ9Wa
 mkZQK+uIgrBjUOJdiYwLnVcAkjoOClzkWyB7Knkskm93neEUP8/L8rQ0injqXjGnmK+yEo3xOWM
 oJg9zruznm5bHk/pAGJPoTbE7UhxkZCIzCIH8REjSg==
X-Received: by 2002:a05:622a:292:b0:460:a82a:39a8 with SMTP id
 d75a77b69052e-46e12a56a1fmr365500881cf.13.1737532529498; 
 Tue, 21 Jan 2025 23:55:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6hbVvXQb8RLxC3q7aPhq94MvtQ3KhfLN5BPElv7OJOEwty9aCRw33fFjmhJ4wd4TaYfCpPQ==
X-Received: by 2002:a05:622a:292:b0:460:a82a:39a8 with SMTP id
 d75a77b69052e-46e12a56a1fmr365500741cf.13.1737532529186; 
 Tue, 21 Jan 2025 23:55:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102ec283sm61431671cf.2.2025.01.21.23.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:55:28 -0800 (PST)
Message-ID: <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
Date: Wed, 22 Jan 2025 08:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com,
 sgarzare@redhat.com, lvivier@redhat.com, zhenzhong.duan@intel.com
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

Hi Jason,


On 1/22/25 8:17 AM, Jason Wang wrote:
> On Wed, Jan 22, 2025 at 12:25 AM Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Hi Jason,
>>
>> On 1/21/25 4:27 AM, Jason Wang wrote:
>>> On Tue, Jan 21, 2025 at 1:33 AM Eric Auger <eric.auger@redhat.com> wrote:
>>>> When a guest exposed with a vhost device and protected by an
>>>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>>>
>>>> Fail to lookup the translated address ffffe000
>>>>
>>>> We observe that the IOMMU gets disabled through a write to the global
>>>> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>>>> When this warning happens it can be observed an inflight IOTLB
>>>> miss occurs after the IOMMU disable and before the vhost stop. In
>>>> that case a flat translation occurs and the check in
>>>> vhost_memory_region_lookup() fails.
>>>>
>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>>>> unregistered.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  hw/virtio/vhost.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index 6aa72fd434..128c2ab094 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener *listener,
>>>>              break;
>>>>          }
>>>>      }
>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>>>> +    }
>>> So the current code assumes:
>>>
>>> 1) IOMMU is enabled before vhost starts
>>> 2) IOMMU is disabled after vhost stops
>>>
>>> This patch seems to fix 2) but not 1). Do we need to deal with the
>>> IOMMU enabled after vhost starts?
>> sorry I initially misunderstood the above comment. Indeed in the reboot
>> case assumption 2) happens to be wrong. However what I currently do is:
>> stop listening to iotlb miss requests from the kernel because my
>> understanding is those requests are just spurious ones, generate
>> warnings and we do not care since we are rebooting the system.
>>
>> However I do not claim this could handle the case where the IOMMU MR
>> would be turned off and then turned on. I think in that case we should
>> also flush the kernel IOTLB and this is not taken care of in this patch.
>> Is it a relevant use case?
> Not sure.
>
>> wrt removing assumption 1) and allow IOMMU enabled after vhost start. Is
>> that a valid use case as the virtio driver is using the dma api?
> It should not be but we can't assume the behaviour of the guest. It
> could be buggy or even malicious.

agreed
>
> Btw, we had the following codes while handling te:
>
> /* Handle Translation Enable/Disable */
> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> {
>     if (s->dmar_enabled == en) {
>         return;
>     }
>
>     trace_vtd_dmar_enable(en);
>
> ...
>
>     vtd_reset_caches(s);
>     vtd_address_space_refresh_all(s);
> }
>
> vtd_address_space_refresh_all() will basically disable the iommu
> memory region. It looks not sufficient to trigger the region_del
> callback, maybe we should delete the region or introduce listener
> callback?

This is exactly the code path which is entered in my use case.

vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del. But given the current implement of this latter the IOTLB callback is not unset and the kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem->regions are not updated? shouldn't they. Can you explain what they correspond to?

Thanks

Eric

>
> Thanks
>
>> Eric
>>
>>
>>> Thanks
>>>
>>>>  }
>>>>
>>>>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>>>> --
>>>> 2.47.1
>>>>


