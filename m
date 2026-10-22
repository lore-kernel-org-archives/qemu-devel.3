Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn3u8vwu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RwZOp8MB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2FI-0005ma-Dl; Thu, 22 Oct 2026 19:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xK2FG-0005mJ-Nf
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xK2FE-0006Or-GU
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792711846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
 b=Jn3u8vwu/5GDV5GZjmQO1Sty/hZgv470TM9L0VKIh8ekRScc1c9smM5UWFFSrWrcUa8WpL
 mwVVw2Ez2Yr5KP1Lx1LjiSxjaxNGl3f8LXzNBbt9jT+7FoXR6OxFZezvOdR5v0XFg5wbLx
 TN9RUIajoJdJ6aRbIdhf8f9xNQoTLco=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-fXDf-apfMyq-Ac5hnJBAew-1; Thu, 22 Oct 2026 19:30:45 -0400
X-MC-Unique: fXDf-apfMyq-Ac5hnJBAew-1
X-Mimecast-MFC-AGG-ID: fXDf-apfMyq-Ac5hnJBAew_1792711844
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3adbc9a47fbso289315a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792711844; x=1793316644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
 b=RwZOp8MBAvACdoOIz6Ic89ZPOZK8q4utgBy0AIk9iZIfDORvEE32zP776QUuW6TtiK
 /nUFoP3hzgTyUHduefO9cZn2dCP4xI4mR3ImuGG4qfwioPDvOYRfmhuesMD0rUa2lHpe
 Q8GBHPv1zucG19B0Bsbg1W90HMbwKuhLZE5ddmBNOWvRq+PBMkTu0yCeGCDsGc84se0k
 5amNmO8RY6aUQakn+2fajpuBiGTQFpKlAkl/pCp6FdLk5zW/SixnfarOxBCX4vC36Ayd
 CcTXc73arDdjLGyoRxj0ubel5nsbRMx9RlTrDTgRt6Gf0d5i5p8tHsWJO7gWVXYPrezv
 3kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792711844; x=1793316644;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
 b=XS+k5fLxznwbCp2yN7DgxDAsxSx/h5hymK3ByBPAVe5TChtnoomw0utRteNaD8V2WI
 nJs0qFaW3ENP7t0gNpdYRi0DNipD7deU5fl0zOnuE5dLhXcNmmHlwMMn8WhWIwUxewmG
 tbAEh5kBpYdKez6KlCSwe4OyLl/PChgUZOH79bgkRBZ6TlUJZ6Gj1bndGfze80Ev8nuZ
 sn775dh50DVsm9NACOIg44vVHiw5yt8wsHFuec2tXI0eZCLjwYFRUg6du3MODn1vr4Ce
 CXvFuVudIFNjB3PEhZugztuUA1rEZUZ3Iwyy5MnsiDdMWegGC+pGquAGKEWhfz7zGfYE
 Komw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1VAwSnRR4bN7HGeUs0Tw4uXqmLWll8O3w6B0fnFfNAwaqyDHy9hpkq37v3ek0Q1r2l6GZtkPiHjX3@nongnu.org
X-Gm-Message-State: AFq9FYJAIX73zFJw5WkIbaMgG4PykRQurW3/b942SJIIj1pWNvjoy7QG
 3o64pg50d0sge4ZGo87F5x9lmkQxI3fBnZQy9vbiVqOTRKODXk+Wxuk9nLJSouR0WOYktxXNaiW
 lEKOYUk/lsw9kLmf1NcJ9RmL1UhTpaSZ+X+YdXrhK9sXTb+r61HS8Dojh
X-Gm-Gg: AYBFou1O5rGPMfRrdGFBAajZ7FZAOs9+gdWN7BFpoa4YwX7gGuzowYAfM4pWjBLJf1f
 xrHO1wdZdAGGuiVFBvTDaHzZ3Hd1lEqZB2+nSbpHclAAH/mvJ8mgjvugoanaHqTmjrE6uCPAD5o
 BHgQ/MftniQfHUCgoBsqealbn7SLrB1EWpTjardsRd0at6ywZmOtiyA47bfK6ov3RNcJleWOcmw
 A3ExpzCiMhouLhL5yIKaZhvc7uhSRusOp6rJgjSQcfY8k1KYwgQgLaktFBj7J/K2+o/J9tKOgGm
 DO17jnRrD84EyWWt7TG8R8YXfFU8P6bG241zEzSTwvDOZxsKoKJOwnnX0Qw/tXLIvaeWpHkCTnZ
 WAcO8+EBZG0R2V2WA+W6X2SmpLalnCEGwIzDPHaHDvg==
X-Received: by 2002:a17:90a:a793:b0:3ac:b3f9:70cb with SMTP id
 98e67ed59e1d1-3adce7cab7amr185974a91.57.1792711844130; 
 Thu, 22 Oct 2026 16:30:44 -0700 (PDT)
X-Received: by 2002:a17:90a:a793:b0:3ac:b3f9:70cb with SMTP id
 98e67ed59e1d1-3adce7cab7amr185948a91.57.1792711843565; 
 Thu, 22 Oct 2026 16:30:43 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adcdb06b91sm325014a91.2.2026.10.22.16.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 16:30:42 -0700 (PDT)
Message-ID: <ff029f82-07e2-469b-a758-6d27212a9227@redhat.com>
Date: Fri, 23 Oct 2026 09:30:36 +1000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com> <atiKJ8-PyIHSRTKy@red-moon>
 <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com> <atoe77pJ119cDcSF@red-moon>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atoe77pJ119cDcSF@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 12:34 AM, Lorenzo Pieralisi wrote:
> On Wed, Oct 21, 2026 at 10:24:56PM +1000, Gavin Shan wrote:
>> On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
>>>> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
>>>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>>
>>>>> Once the Realm descriptor has been created, tell KVM to transfer runtime
>>>>> images (kernel, DT, and rootfs) from guest memory to Realm memory.
>>>>>
>>>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> ---
>>>>>     target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 76 insertions(+)
>>>>>
>>>>> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
>>>>> index 9985f5daba89..c082a5d8f3d1 100644
>>>>> --- a/target/arm/kvm-rme.c
>>>>> +++ b/target/arm/kvm-rme.c
>>>>> @@ -15,6 +15,7 @@
>>>>>     #include "migration/blocker.h"
>>>>>     #include "qapi/error.h"
>>>>>     #include "qemu/error-report.h"
>>>>> +#include "qemu/memalign.h"
>>>>>     #include "qom/object_interfaces.h"
>>>>>     #include "system/confidential-guest-support.h"
>>>>>     #include "system/kvm.h"
>>>>> @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>>>>>     static RmeGuest *rme_guest;
>>>>> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
>>>>> +                              Error **errp)
>>>>> +{
>>>>> +    int ret;
>>>>> +    void *buffer;
>>>>> +    hwaddr size = region->size;
>>>>> +    hwaddr base = region->base;
>>>>> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
>>>>> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
>>>>> +    struct kvm_arm_rmi_populate populate_args;
>>>>> +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
>>>>
>>>> s/qemu_real_host_page_size()/RME_PAGE_SIZE
>>>
>>> It will always have to be qemu_real_host_page_size(), KVM configures it
>>> that way.
>>>
>>>>> +
>>>>> +    if (!region->data) {
>>>>> +        return -ENODEV;
>>>>> +    }
>>>>> +
>>>>> +    ret = kvm_set_memory_attributes_private(start, end - start);
>>>>> +    if (ret) {
>>>>> +        error_report("RME: failed to configure initial"
>>>>> +                     "private guest memory");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /* Allocate page-aligned memory */
>>>>> +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
>>>>> +
>>>>> +    if (!buffer) {
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    memset(buffer, 0, aligned_size);
>>>>> +    memcpy(buffer, region->data, region->size);
>>>>> +
>>>>> +    populate_args = (struct kvm_arm_rmi_populate) {
>>>>> +        .base = start,
>>>>> +        .size = end - start,
>>>>> +        .source_uaddr = (uintptr_t)buffer,
>>>>> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
>>>>> +    };
>>>>> +
>>>>> +    while (populate_args.size > 0) {
>>>>> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
>>>>> +        if (ret) {
>>>>> +            error_setg_errno(errp, -ret,
>>>>> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>>>>> +                start, end);
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    qemu_vfree(buffer);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>
>>>> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
>>>> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
>>>> is 64KB. The question is how do we know the added regions due to the alignment
>>>> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
>>>
>>> Getting back to this because it is important. Can you define "safe" here ?
>>>
>>> I think it is VMM's role to load with the required alignment and make
>>> sure it does not double populate (that is anyway prevented by KVM), what was
>>> your concern here to make sure we are in agreement ?
>>>
>>
>> For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
>> host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
>> and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
>> TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
>> by the second population.
> 
> It is not allowed by the RMM and it is a VMM bug that we have to prevent.
> 

Ok, thanks for your confirm. It's why I asked if we ever see an unaligned
Rom region. If all Rom regions are aligned to host page size, then we needn't
to handle the unaligned Rom regions in rme_populate_range(). Otherwise, we
need come up with a solution to address the issue.

The solution would be to generate a temporary region list based on the existing
Rom region list. For each region in the temporary list, its start/size are well
aligned to host page size, and the temporary buffer is allocated, and the data
is properly copied over from the original Rom region. The population is done
based on the temporary list. For example, we need to have [0 64kb], [128kb 192kb]
regions in the temporary list if we have Rom region [0 1kb], [4kb 5kb] [16kb 17kb],
[132kb 133kb], [136kb 140kb]. The host page size is assumed to be 64kb in the example.

    [0 64kb] covers [0 1kb], [4kb 5kb] [16kb 17kb]
    [128kb 192kb] covers [132kb 133kb], [136kb 140kb]

Thanks,
Gavin

> Thanks,
> Lorenzo
> 
>> Thanks,
>> Gavin
>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> I guess we probably just reject unaligned regions if they're not expected.
>>>>
>>>> Even if the unaligned regions are allowed, they seem not well handled.
>>>>
>>>> - @aligned_size is still 64KB instead of the 128KB ?
>>>> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>>>>     [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
>>>>
>>>>> +static void rme_populate_ram_region(gpointer data, gpointer err)
>>>>> +{
>>>>> +    Error **errp = err;
>>>>> +    const RmeRamRegion *region = data;
>>>>> +
>>>>> +    if (*errp) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    rme_populate_range(region, /* measure */ true, errp);
>>>>> +}
>>>>> +
>>>>>     static void rme_vm_state_change(void *opaque, bool running, RunState state)
>>>>>     {
>>>>> +    Error *errp = NULL;
>>>>> +
>>>>>         if (!running) {
>>>>>             return;
>>>>>         }
>>>>> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
>>>>> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
>>>>> +    if (errp) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>         kvm_mark_guest_state_protected();
>>>>>     }
>>>>
>>>> Thanks,
>>>> Gavin
>>>>
>>>
>>
> 


