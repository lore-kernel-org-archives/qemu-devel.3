Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA20C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjyN-0007Sd-Nb; Mon, 08 Apr 2024 04:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rtjyM-0007SQ-Sv
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rtjyL-00066F-30
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712563400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HRzLsfi9v+rpjtpL/7jh+kVG4wDkrGyRBaLm7mCfyV8=;
 b=RttZw2TP4swFiIgykerVDjETxthlok6VkVucp3ZH+D3bClHxXiZBrkYWdj2xWH/RxuvEb6
 pr5I++B6pKt38Vq1rbAKrh/u+8vxAlKKbo3fu3xHzvC0cpo5Gkb7DeUHNLSmSTKBxiX8dl
 PtEU4gTHKZRyJug88YeTymFgVtowLKU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-_4KSeHxrOrqClpYwuKMI2w-1; Mon, 08 Apr 2024 04:03:18 -0400
X-MC-Unique: _4KSeHxrOrqClpYwuKMI2w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343c8e87a74so2494226f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563397; x=1713168197;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HRzLsfi9v+rpjtpL/7jh+kVG4wDkrGyRBaLm7mCfyV8=;
 b=NkXa9bFt4dkDZTs+vt5dXSWC8ey4bEfasxrKis5ntHusBnTe71oZeVkyTy4JR33p4c
 Me5H/UNbm/S3p+Wt19OsmrJ5oQqth+7cIiH4J/RSizncwzptxnU6hDnzmGtUBpx7hBze
 oFZx7MO/hMHO9JeY4vE3heTSmHT3JbchNfbzgcoTM/qvapG6s0O6rVU7nev3jo1k727e
 olgnMDHujEKnOMwrKIPDy67sK1z4J1rWkjJJLpIlLFQ9ik32yMNakfuH9/NqxHWEs8DB
 vRDWSpnk5OXI+2rb6yxQSlk2HuwZHQlx6AYl9kIJ+HZYmyO0X91nbVIX3yo8Uyf+eDXC
 XV5Q==
X-Gm-Message-State: AOJu0YwLft/jLVeFa2d3FGHjmF/F+oQZvjnFypzwuY/gl6X7LpLx3Ljw
 p1+pBsMcXjzOZqIfKZ6zA54ZHkiYtByTt4pHth67vBxD2dOS/bBachYJeziKQkuzAot9CNU3Qf5
 sHEGKn9HKIiXpGVyy+X+sK0ntQ/tyFgTuhotuKWEesXbt6MMWus+x
X-Received: by 2002:a05:6000:152:b0:343:96a0:cccd with SMTP id
 r18-20020a056000015200b0034396a0cccdmr7142030wrx.33.1712563397243; 
 Mon, 08 Apr 2024 01:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb1/5jeKgCie52fRfsLM7Timc6gB3AiDcGwJHGBHA4WYzy58wbGemoZcZTvfOH+ghT2erXxg==
X-Received: by 2002:a05:6000:152:b0:343:96a0:cccd with SMTP id
 r18-20020a056000015200b0034396a0cccdmr7141996wrx.33.1712563396812; 
 Mon, 08 Apr 2024 01:03:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379?
 (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de.
 [2003:cb:c718:1300:9860:66a2:fe4d:c379])
 by smtp.gmail.com with ESMTPSA id
 dr20-20020a5d5f94000000b0033ea499c645sm8455913wrb.4.2024.04.08.01.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 01:03:16 -0700 (PDT)
Message-ID: <b2cde66b-4733-4c1c-ad9b-361346a80deb@redhat.com>
Date: Mon, 8 Apr 2024 10:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 09/11] hostmem: add a new memory backend based
 on POSIX shm_open()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 gmaglione@redhat.com, Jason Wang <jasowang@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-10-sgarzare@redhat.com>
 <c5c89a6e-adf7-4f25-b9b5-2979e4367dfd@redhat.com>
 <gs6o25gxe22j3uptywtadcujnwqexfgc3drthrgzn44m44pder@zugei2amphni>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <gs6o25gxe22j3uptywtadcujnwqexfgc3drthrgzn44m44pder@zugei2amphni>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08.04.24 09:58, Stefano Garzarella wrote:
> On Thu, Apr 04, 2024 at 04:09:34PM +0200, David Hildenbrand wrote:
>> On 04.04.24 14:23, Stefano Garzarella wrote:
>>> shm_open() creates and opens a new POSIX shared memory object.
>>> A POSIX shared memory object allows creating memory backend with an
>>> associated file descriptor that can be shared with external processes
>>> (e.g. vhost-user).
>>>
>>> The new `memory-backend-shm` can be used as an alternative when
>>> `memory-backend-memfd` is not available (Linux only), since shm_open()
>>> should be provided by any POSIX-compliant operating system.
>>>
>>> This backend mimics memfd, allocating memory that is practically
>>> anonymous. In theory shm_open() requires a name, but this is allocated
>>> for a short time interval and shm_unlink() is called right after
>>> shm_open(). After that, only fd is shared with external processes
>>> (e.g., vhost-user) as if it were associated with anonymous memory.
>>>
>>> In the future we may also allow the user to specify the name to be
>>> passed to shm_open(), but for now we keep the backend simple, mimicking
>>> anonymous memory such as memfd.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> v3
>>> - enriched commit message and documentation to highlight that we
>>>    want to mimic memfd (David)
>>> ---
>>>   docs/system/devices/vhost-user.rst |   5 +-
>>>   qapi/qom.json                      |  17 +++++
>>>   backends/hostmem-shm.c             | 118 +++++++++++++++++++++++++++++
>>>   backends/meson.build               |   1 +
>>>   qemu-options.hx                    |  11 +++
>>>   5 files changed, 150 insertions(+), 2 deletions(-)
>>>   create mode 100644 backends/hostmem-shm.c
>>>
>>> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
>>> index 9b2da106ce..35259d8ec7 100644
>>> --- a/docs/system/devices/vhost-user.rst
>>> +++ b/docs/system/devices/vhost-user.rst
>>> @@ -98,8 +98,9 @@ Shared memory object
>>>   In order for the daemon to access the VirtIO queues to process the
>>>   requests it needs access to the guest's address space. This is
>>> -achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
>>> -objects. A reference to a file-descriptor which can access this object
>>> +achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
>>> +``memory-backend-shm`` objects.
>>> +A reference to a file-descriptor which can access this object
>>>   will be passed via the socket as part of the protocol negotiation.
>>>   Currently the shared memory object needs to match the size of the main
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 85e6b4f84a..5252ec69e3 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -721,6 +721,19 @@
>>>               '*hugetlbsize': 'size',
>>>               '*seal': 'bool' } }
>>> +##
>>> +# @MemoryBackendShmProperties:
>>> +#
>>> +# Properties for memory-backend-shm objects.
>>> +#
>>> +# The @share boolean option is true by default with shm.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'struct': 'MemoryBackendShmProperties',
>>> +  'base': 'MemoryBackendProperties',
>>> +  'data': { } }
>>> +
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> One comment: we should maybe just forbid setting share=off. it doesn't
>> make any sense and it can even result in an unexpected double memory
>> consumption. We missed doing that for memfd, unfortunately.
> 
> Good point!
> 
> IIUC the `share` property is defined by the parent `hostmem`, so I
> should find a way to override the property here and disable the setter,
> or add an option to `hostmem` to make the property non-writable.

Right, or simply fail later when you would find "share=off" in 
shm_backend_memory_alloc().

When ever supporting named shmem_open(), it could make sense for VM 
snapshotting. Right now it doesn't really make any sense.

-- 
Cheers,

David / dhildenb


