Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyMp-0004uP-Oa; Wed, 20 Mar 2024 12:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmyMn-0004s5-9T
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmyMl-0000jc-N9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710950434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7SLCMTM7Rllrcd/kdHSOwjAZzSpMFurH3MxGFxfxyJc=;
 b=HKEny5p/Hy5CNwt59KjLXHegObSiPxr6XkluHW9yoUrJ4XQvIOKDKZ19DgMQasyl3j+me4
 8Krl75BxtJqu0qloV06YB25GiSLDFdHpTnY2KYyNi/sn0dNX97OAYHZJMM7TAi08uAqFzF
 sDm/e4nPIuPD1Ucg9ol4+wCPHLRWTr8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-B-Ykz0a5PL-DpxFihM8ZJA-1; Wed, 20 Mar 2024 12:00:33 -0400
X-MC-Unique: B-Ykz0a5PL-DpxFihM8ZJA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d480b8dd54so120551fa.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710950431; x=1711555231;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7SLCMTM7Rllrcd/kdHSOwjAZzSpMFurH3MxGFxfxyJc=;
 b=ikAcXBoT4csfVljmnbUy5MkSifuLAmdY/H35+2b1eOb7uR4uAppXglkCD/EEtVQLJv
 ZJAFRE3m9uIbEA6VZbvqJkTkLZew3NmhcJgHpFI/atgqqV+tA+XRc/8yBBeLZJzOydIz
 l6CPUehISwZWGd0CG4nTsfyARnhQZU0qITcB8zwNF/QYf71f4HVaW+hpCjRKNu+u9P9p
 TxZqfeUstACDbFfoL4QuKWISfNuauXG6GpiVZY3+HbH1KbflDw6+izU5Fe+3qsuD/MzA
 8+ilfzyQGrHcHN4JeIauyO3vlWhvGDrdFh7LFpbvzepyue9j7N5t5WYMFXZml4YM1uu6
 Lvqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4wFbXNrcYwJTPu8p1SmwWwAPJv8XIPnpryMi962aRpy6WgWWKyHqjhgrXF9Oolo98QERgILKjLEdeO6nA2XyWSA+vdEo=
X-Gm-Message-State: AOJu0YwH4uq3obkeJLP6pocmZgeh7bqq35NL0IQCXsmM1RBvLR71wO0b
 rMyPC3XzH7C9GBYx49lEIlziPmdT6N0SBTC5Ms4dewt5WZ2LTENDrrFZZQ0+ibxNlT1HRe7Rj7w
 5T4if5cGZlufAsnXrnfreNCi7TwqcAmWc/1IUxjV25rq8leGe/6NwwUsrrkET
X-Received: by 2002:a2e:9396:0:b0:2d4:2640:2eaa with SMTP id
 g22-20020a2e9396000000b002d426402eaamr11434549ljh.49.1710950430769; 
 Wed, 20 Mar 2024 09:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4FhH1Bax01abjQpxGAlTxNovLWHXMtN1mTBZxO3xxDMETxUDpmQj7wF3qX1CUkxG9w9QT/Q==
X-Received: by 2002:a2e:9396:0:b0:2d4:2640:2eaa with SMTP id
 g22-20020a2e9396000000b002d426402eaamr11434526ljh.49.1710950430327; 
 Wed, 20 Mar 2024 09:00:30 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 r8-20020a056402018800b00568d5e737b0sm3962667edv.57.2024.03.20.09.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 09:00:29 -0700 (PDT)
Message-ID: <5fe262bc-7226-4d99-9bf7-ed357b8fdf7a@redhat.com>
Date: Wed, 20 Mar 2024 17:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/49] kvm: Introduce support for memory_attributes
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-11-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-11-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

On 3/20/24 09:39, Michael Roth wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Introduce the helper functions to set the attributes of a range of
> memory to private or shared.
> 
> This is necessary to notify KVM the private/shared attribute of each gpa
> range. KVM needs the information to decide the GPA needs to be mapped at
> hva-based shared memory or guest_memfd based private memory.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v4:
> - move the check of kvm_supported_memory_attributes to the common
>    kvm_set_memory_attributes(); (Wang Wei)
> - change warn_report() to error_report() in kvm_set_memory_attributes()
>    and drop the __func__; (Daniel)
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   accel/kvm/kvm-all.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   include/sysemu/kvm.h |  3 +++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e83429b31e..df7a32735a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -92,6 +92,7 @@ static bool kvm_has_guest_debug;
>   static int kvm_sstep_flags;
>   static bool kvm_immediate_exit;
>   static bool kvm_guest_memfd_supported;
> +static uint64_t kvm_supported_memory_attributes;
>   static hwaddr kvm_max_slot_size = ~0;
>   
>   static const KVMCapabilityInfo kvm_required_capabilites[] = {
> @@ -1304,6 +1305,46 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
>       kvm_max_slot_size = max_slot_size;
>   }
>   
> +static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
> +{
> +    struct kvm_memory_attributes attrs;
> +    int r;
> +
> +    if (kvm_supported_memory_attributes == 0) {
> +        error_report("No memory attribute supported by KVM\n");
> +        return -EINVAL;
> +    }
> +
> +    if ((attr & kvm_supported_memory_attributes) != attr) {
> +        error_report("memory attribute 0x%lx not supported by KVM,"
> +                     " supported bits are 0x%lx\n",
> +                     attr, kvm_supported_memory_attributes);
> +        return -EINVAL;
> +    }

This should also be tested at the same time as kvm_guest_memfd_supported.

Paolo

> +    attrs.attributes = attr;
> +    attrs.address = start;
> +    attrs.size = size;
> +    attrs.flags = 0;
> +
> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
> +    if (r) {
> +        error_report("failed to set memory (0x%lx+%#zx) with attr 0x%lx error '%s'",
> +                     start, size, attr, strerror(errno));
> +    }
> +    return r;
> +}
> +
> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size)
> +{
> +    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size)
> +{
> +    return kvm_set_memory_attributes(start, size, 0);
> +}
> +
>   /* Called with KVMMemoryListener.slots_lock held */
>   static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                                MemoryRegionSection *section, bool add)
> @@ -2439,6 +2480,9 @@ static int kvm_init(MachineState *ms)
>   
>       kvm_guest_memfd_supported = kvm_check_extension(s, KVM_CAP_GUEST_MEMFD);
>   
> +    ret = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> +    kvm_supported_memory_attributes = ret > 0 ? ret : 0;
> +
>       if (object_property_find(OBJECT(current_machine), "kvm-type")) {
>           g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
>                                                               "kvm-type",
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index b4913281e2..2cb3192509 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -538,4 +538,7 @@ void kvm_mark_guest_state_protected(void);
>   bool kvm_hwpoisoned_mem(void);
>   
>   int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
> +
> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
>   #endif

This suggests that


