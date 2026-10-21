Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5163606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CUlZ/2q/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mu+sGxeB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJVNb-0005Lb-Dt; Wed, 21 Oct 2026 08:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xJVNZ-0005LH-06
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xJVNX-0007gf-3r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792585510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
 b=CUlZ/2q/9xZHpkWOQe1/voez2UWXku/h6YlZWzLIDXQxuHjGQjSoH2o61EBd7SpkuPTPZ+
 vySTeZrEU4CZf6iUlsx9XOgf8waH950sylGIkqqnpD7GnFv+j43jxr3jknzK+3sm/+3o2j
 grJVTs1bS7PA2e/zNCGn/cguFDiJAoU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-YKhmqUijM4SxckiMgKyk3g-1; Wed, 21 Oct 2026 12:25:06 +0000
X-MC-Unique: YKhmqUijM4SxckiMgKyk3g-1
X-Mimecast-MFC-AGG-ID: YKhmqUijM4SxckiMgKyk3g_1792585505
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso4783595ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792585505; x=1793190305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
 b=mu+sGxeBFzzG+qoH86943r23Yem646mA3xM1uTonYI+m4L3yeuOFIkQsPZjE8XtO7S
 k+MDQk7eYyYuqqABbYuNOvRiRO/GR/cDtoREyHzNRzhssXr57aCwsZ9FRIexrffQxMAt
 uCAvKGFw3aVr6760MdX99Ug924l2c+MUC9yOSQcUKML0f8Tva2sfeXabFuqLGDc3Qpt5
 Oxjof/8AA/akPA4W2oz28NyBDGXtfTa5nZtjN+g6TJ88SMbmvYxnfM69HdA0icvPmDvv
 C1SqnQCv8tj7jQIS95meO58nNg/P6SkasJ753E0B3htQUTjqwd5hj38lTfOOfEicDUkm
 gm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792585505; x=1793190305;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
 b=u1oNUfL+IoN+wAqRoBYlphzg7Goj9QSohwjU8yoNasBwpWoMS06t2NMCB2NBDv4Pug
 0UKRKVjnAQzCVnqTAUQAaOv/wca1LfIQ4wi0MokP44p+dGCVo8Yfs0k3DJxKBz/HzP+b
 OHab3xUC1uvg4m/JBEAUbCSdFdYE+WGSyXDaDVJGIHLeNM1zEGAwcrmS8SOIkSkXrFTM
 bmowTdflDpebIA+G2NPtcabswOSXwYuR96LFdxHEMjr7eKyEmk0fCHGoVluCXsq49ysO
 XjlDPEvhKzuYifuq4RQ+dtPR3/D/PmMk1ukDZbdNzPHo0V1kFIbGdk6XNOfehIFn9p8T
 naNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ+kdIwin5Ya+aYxL9AU1kyzkUGlSrgpxjibRVVCyFFdUDlZrwaeyIhZS4EsTG2QjbbS8hD7yhso1n@nongnu.org
X-Gm-Message-State: AFq9FYLkBE9tEnRINdsgTx7XyUw1/3ZiRjCUdWgiMa32LjG4OipOOEdD
 D8AjE/bIFUwZYTufDWLBmvKkit+ICfHVV2Qn54IkckgNanwuzKrjWm3F8vH4BBy7lpTWpnGutze
 2xsqfqHNuvNuDjfPzGBLQb5vyDKtQB6h5ut+lqHGdgvZc1Z/3qtuZBGAA
X-Gm-Gg: AYBFou3alTzBWvnFmeYXKAcX+yVfpCIvFjGW27vdPKYlmHH3JNTEymXzj/oeyol8VHX
 b8qZWRAe8rTcg6nnfwrR6IylDMmgyUXBNoMEPQkZNzX65+8kSX2+4s1YZHicOftd7Bx+sTFtugh
 bheFckud8qHFkCRB6GeMotYZdl5JlCU2p42JmDWmvqnGlr4nm/0NZUhunx6zmsIJajguz+ONwPc
 Bvn8eqLfmEaRMWqEwOqYmDXgejPw1n9vJhzfNYEFuD9cBHoGBKMnTaZM9CcNhLGm4HKeYp1FcPy
 +89MsZs4IqLlTJPASMG5yav0q4h+9peXTHw57kHHfZoFkdC4o22XeE9aP1ZMWbxF5tHd+y1ANbA
 fbHV0gjkQiXWRdTvawPPdAvZsVbenySAGnOnWUt7KyA==
X-Received: by 2002:a17:903:388d:b0:2e5:467a:7a6b with SMTP id
 d9443c01a7336-2ea43d3a195mr15032475ad.10.1792585505280; 
 Wed, 21 Oct 2026 05:25:05 -0700 (PDT)
X-Received: by 2002:a17:903:388d:b0:2e5:467a:7a6b with SMTP id
 d9443c01a7336-2ea43d3a195mr15032085ad.10.1792585504565; 
 Wed, 21 Oct 2026 05:25:04 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b4536ddsm10640795ad.43.2026.10.21.05.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 05:25:02 -0700 (PDT)
Message-ID: <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
Date: Wed, 21 Oct 2026 22:24:56 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atiKJ8-PyIHSRTKy@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
> On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
>> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> Once the Realm descriptor has been created, tell KVM to transfer runtime
>>> images (kernel, DT, and rootfs) from guest memory to Realm memory.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 76 insertions(+)
>>>
>>> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
>>> index 9985f5daba89..c082a5d8f3d1 100644
>>> --- a/target/arm/kvm-rme.c
>>> +++ b/target/arm/kvm-rme.c
>>> @@ -15,6 +15,7 @@
>>>    #include "migration/blocker.h"
>>>    #include "qapi/error.h"
>>>    #include "qemu/error-report.h"
>>> +#include "qemu/memalign.h"
>>>    #include "qom/object_interfaces.h"
>>>    #include "system/confidential-guest-support.h"
>>>    #include "system/kvm.h"
>>> @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>>>    static RmeGuest *rme_guest;
>>> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
>>> +                              Error **errp)
>>> +{
>>> +    int ret;
>>> +    void *buffer;
>>> +    hwaddr size = region->size;
>>> +    hwaddr base = region->base;
>>> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
>>> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
>>> +    struct kvm_arm_rmi_populate populate_args;
>>> +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
>>
>> s/qemu_real_host_page_size()/RME_PAGE_SIZE
> 
> It will always have to be qemu_real_host_page_size(), KVM configures it
> that way.
> 
>>> +
>>> +    if (!region->data) {
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    ret = kvm_set_memory_attributes_private(start, end - start);
>>> +    if (ret) {
>>> +        error_report("RME: failed to configure initial"
>>> +                     "private guest memory");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* Allocate page-aligned memory */
>>> +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
>>> +
>>> +    if (!buffer) {
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    memset(buffer, 0, aligned_size);
>>> +    memcpy(buffer, region->data, region->size);
>>> +
>>> +    populate_args = (struct kvm_arm_rmi_populate) {
>>> +        .base = start,
>>> +        .size = end - start,
>>> +        .source_uaddr = (uintptr_t)buffer,
>>> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
>>> +    };
>>> +
>>> +    while (populate_args.size > 0) {
>>> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
>>> +        if (ret) {
>>> +            error_setg_errno(errp, -ret,
>>> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>>> +                start, end);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    qemu_vfree(buffer);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>
>> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
>> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
>> is 64KB. The question is how do we know the added regions due to the alignment
>> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> 
> Getting back to this because it is important. Can you define "safe" here ?
> 
> I think it is VMM's role to load with the required alignment and make
> sure it does not double populate (that is anyway prevented by KVM), what was
> your concern here to make sure we are in agreement ?
> 

For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
by the second population.

Thanks,
Gavin

> Thanks,
> Lorenzo
> 
>> I guess we probably just reject unaligned regions if they're not expected.
>>
>> Even if the unaligned regions are allowed, they seem not well handled.
>>
>> - @aligned_size is still 64KB instead of the 128KB ?
>> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>>    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
>>
>>> +static void rme_populate_ram_region(gpointer data, gpointer err)
>>> +{
>>> +    Error **errp = err;
>>> +    const RmeRamRegion *region = data;
>>> +
>>> +    if (*errp) {
>>> +        return;
>>> +    }
>>> +
>>> +    rme_populate_range(region, /* measure */ true, errp);
>>> +}
>>> +
>>>    static void rme_vm_state_change(void *opaque, bool running, RunState state)
>>>    {
>>> +    Error *errp = NULL;
>>> +
>>>        if (!running) {
>>>            return;
>>>        }
>>> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
>>> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
>>> +    if (errp) {
>>> +        return;
>>> +    }
>>> +
>>>        kvm_mark_guest_state_protected();
>>>    }
>>
>> Thanks,
>> Gavin
>>
> 


