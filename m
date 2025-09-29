Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0745FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GZb-0007XH-PV; Mon, 29 Sep 2025 12:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GZP-0007SD-2v
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GZF-0006HP-NP
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759162654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PCfGswOFgs9Byjd7wuVfj2ZWeDuI/UIDerUmDw7J8UM=;
 b=iTf9NkDEYwe6gvZQGUXaiXBCBRZ7t7hSZ47sXrkObkmeOiX34ob7nWnd7fqS3PaefYz61r
 k6c73bw/Gg/QkeyowhaAeET1T8JFtt2WuL+pa9YvFljF2LOK6me7n1BNAkgSK4VqApN7L+
 WQowlOXQOZwEuQTsSra8OwMZSQEtZyw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-GAzZhqJYOz6K6Sg4WLwY8A-1; Mon, 29 Sep 2025 12:17:32 -0400
X-MC-Unique: GAzZhqJYOz6K6Sg4WLwY8A-1
X-Mimecast-MFC-AGG-ID: GAzZhqJYOz6K6Sg4WLwY8A_1759162652
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e2c11b94cso29631275e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162652; x=1759767452;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCfGswOFgs9Byjd7wuVfj2ZWeDuI/UIDerUmDw7J8UM=;
 b=qr1sMgkVZsRezxxU1VovN2dC74xmJCMA371WlyNRaDlJlTnRtuSgVRwe9U4+tAZMde
 sAgpOreBYw/KTbWPqIglkRBCkUox+Zu5SA7Jx217CQ8VcV7NbfxbufB8fSaqQpFgCSMC
 e9gGQEdDF2I9pYH/FZS0I4/DRgyG+AuTntimuVD/c7SHdhip/uAX1vdfFMieizXRLL9I
 7anNFGVVTr5qEwHg8fQAfw9nIW5S1QxCE8PLccAgkSdkrJOan/cOscY7LBAfbohUgCxA
 z6uyTznbhoveNxzXuxirRMkVswtmZpJjPP9Ju2jbqkC/fvHqWwTsmScZ2OO86ZwrP0vN
 G6Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvhroGg32quQxCFoSxVGjeI6srB5DOmZU1F7OaMq4ZEsuLA7Tj9SRLpV3j0yHhuUayL2jGwWRmVl9T@nongnu.org
X-Gm-Message-State: AOJu0YzfWifX6+q99gWnMKBMg/FMeVtx08at9ARoVpgRoW++UL7qSZjh
 ho37TjvM4Br8Ecsz6YS0LBtrcYiveSY+lg0CnnAisUjrWu9ncMwoRVnSxCUCDrb8FY5nBhbjuij
 n3Vj8jCY2ZF5PVpDPpbohGdBb2aYABdEMN2qvlMjtwX+QsEPHTCcMBINt
X-Gm-Gg: ASbGncvtgzekssow9U8gLJs8pBmzCHx8Uptz4iIoU+9JuCQ6vYls55t8vHSKS/3wnoJ
 mY3hpa7btoDthj41LEL3Fo74QpKCVmaKMcOPS1l2AkJ2HafREHE+Swvq0irgAfGDOTlynLjEmA1
 7wHw4KO9SBdZOJZIWJOdJ/502h1MXO9HtrheJaIQgD44Ezoq+yi+lf5tlEVb9yw7hUFSCDxvLHS
 gbaGvubxuta+oFPXDdw9VpgGg/zsdEM0tgEwvjO+Y0OgFDS6F4SkgPodnbPTzyktGFglgNAs40a
 NZJ6JT14/FN7DeF0ciR6pBMqiqM71/gf/ygMJwLDi+bhMLefNfQolX9VTIR2ybOLpWppunR6swg
 Pbh0=
X-Received: by 2002:a05:600c:3f12:b0:46e:41e6:28c7 with SMTP id
 5b1f17b1804b1-46e41e6293fmr151486995e9.8.1759162651717; 
 Mon, 29 Sep 2025 09:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4q/u+inchio2ypb7klzNldPL10d2VdmIgK6LglOsBlLxZNpC7sQFFpyDZvpFjB9br+XLgzA==
X-Received: by 2002:a05:600c:3f12:b0:46e:41e6:28c7 with SMTP id
 5b1f17b1804b1-46e41e6293fmr151486675e9.8.1759162651230; 
 Mon, 29 Sep 2025 09:17:31 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d?
 ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f658ffsm18778625e9.14.2025.09.29.09.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 09:17:30 -0700 (PDT)
Message-ID: <f248001b-8ebf-4bc1-b97e-cddb908cbe35@redhat.com>
Date: Mon, 29 Sep 2025 18:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] physmem: Destroy all CPU AddressSpaces on unrealize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <20250929144228.1994037-4-peter.maydell@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250929144228.1994037-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.09.25 16:42, Peter Maydell wrote:
> When we unrealize a CPU object (which happens on vCPU hot-unplug), we
> should destroy all the AddressSpace objects we created via calls to
> cpu_address_space_init() when the CPU was realized.
> 
> Commit 24bec42f3d6eae added a function to do this for a specific
> AddressSpace, but did not add any places where the function was
> called.
> 
> Since we always want to destroy all the AddressSpaces on unrealize,
> regardless of the target architecture, we don't need to try to keep
> track of how many are still undestroyed, or make the target
> architecture code manually call a destroy function for each AS it
> created.  Instead we can adjust the function to always completely
> destroy the whole cpu->ases array, and arrange for it to be called
> during CPU unrealize as part of the common code.
> 
> Without this fix, AddressSanitizer will report a leak like this
> from a run where we hot-plugged and then hot-unplugged an x86 KVM
> vCPU:
> 
> Direct leak of 416 byte(s) in 1 object(s) allocated from:
>      #0 0x5b638565053d in calloc (/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/qemu-system-x86_64+0x1ee153d) (BuildId: c1cd6022b195142106e1bffeca23498c2b752bca)
>      #1 0x7c28083f77b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x5b6386999c7c in cpu_address_space_init /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../system/physmem.c:797:25
>      #3 0x5b638727f049 in kvm_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/kvm/kvm-cpu.c:102:5
>      #4 0x5b6385745f40 in accel_cpu_common_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../accel/accel-common.c:101:13
>      #5 0x5b638568fe3c in cpu_exec_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/cpu-common.c:232:10
>      #6 0x5b63874a2cd5 in x86_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/cpu.c:9321:5
>      #7 0x5b6387a0469a in device_set_realized /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:494:13
>      #8 0x5b6387a27d9e in property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:2375:5
>      #9 0x5b6387a2090b in object_property_set /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1450:5
>      #10 0x5b6387a35b05 in object_property_set_qobject /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/qom-qobject.c:28:10
>      #11 0x5b6387a21739 in object_property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1520:15
>      #12 0x5b63879fe510 in qdev_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:276:12
> 
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2517
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Complicated stuff, but LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


