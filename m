Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uENzU-00054P-R3; Mon, 12 May 2025 03:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uENzQ-00053W-8U
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uENzM-0005mJ-HO
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747036453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tejtTw+ujDY0fXNQwgGGe4XMZMbnZF0Fex+Sgc96/fk=;
 b=cZ4WqNdkSkuWjbgBaqD8xN/hDcQuCCgnUnBgQMqJ57IafVtrdbA/HmnRm7YAU+0hxhcDAd
 n9l8wKFxOTLnk3nO/KLv43asswiRjMZK0N8RjbizXntjFhQEdPyEXI5AUzGRXwQyhi4+D1
 DxHHmwy16Czb14IFaomM8SAebzTi1Ao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-NZhxnfj5O4OtgYj0i5ReoA-1; Mon, 12 May 2025 03:54:11 -0400
X-MC-Unique: NZhxnfj5O4OtgYj0i5ReoA-1
X-Mimecast-MFC-AGG-ID: NZhxnfj5O4OtgYj0i5ReoA_1747036450
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b394504cso2054301f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 00:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747036450; x=1747641250;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tejtTw+ujDY0fXNQwgGGe4XMZMbnZF0Fex+Sgc96/fk=;
 b=Cl8s9B0VCtlaq27r3QjNy0K753pJyVMBzQ1zo523jBhcGGnIZZLbW84rro7+rQG6SM
 L3dfBGZuNevGVld7uVqT9LeszBxXBIevuXFu3+qQdE745PHFg0R2sKbi0bweDcCh4f+e
 5Al6e1XwztVTj2YlNbXyB5xGJkicObXVpImVAmf3hZol9oDlVlveoTgSQkURX7vlrJpA
 M/QfUn50GyGy9gzzye1La3xrgLSG79JRHkEdaYcupOmG9z5tNXi0lam2fgkurM//un3S
 mSeib0uRAz8VGDdItJgsjjHho24SvBdq/1F2GNKRSFqGKWnrRtnCAgkHEVcwYjDwvEEU
 9foQ==
X-Gm-Message-State: AOJu0Yzf8yLqBngMSgS7xg8ub8dCaqvNcHQh9+5UwT/RYa+cTnC0zKdu
 sEaudD0WhKzysL8wPqIt2w+ddUrr6vZ2QMyRLwOnCaqsQjcYDOt40q4hAyGTZpmIOyLVZwY4T65
 dgwSakkxjA64RRtQgTSDXdba0O4X/B/JUX0wOUAspP4r6wYMVcQyC
X-Gm-Gg: ASbGnctBsCm6OMhTq6/hNDTQMsgDtKfikaxcDX029Ox6mPkMXhk7zpE8bDDGZ6u+Ckq
 klcSpLgPKJZE/iWq6uoxWRWitz7ApVzGAsplsLGhIzmn1t5J3/sJ7RlbX7a3kYZN0EeHNw5g1JB
 LKHqKE/Eh8nFNi8/zxxZPEwgnj3L4RpztHFxDO14D3WHFYJ0ncUrSf94nLTDE4hYWC7oD13Z8Li
 /LPQjnkThfiAczGXx/hypw8cUfcv1k15We7DCHBsar2i7oyLjKuTb58u0F09FJybm8mX7GOSxdb
 70WkbQDCGobtxRqZNCZcufmATKMYY8vnNmDcd54NlCI=
X-Received: by 2002:a05:6000:144f:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a1f6c984a1mr10687455f8f.18.1747036450299; 
 Mon, 12 May 2025 00:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJhOje2oJq6znmxvPYbUk0BcriQBCtS8TcM/2GHT8GIwEPu6EwA7/uRqITP4TGEjjdEkmbMQ==
X-Received: by 2002:a05:6000:144f:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a1f6c984a1mr10687433f8f.18.1747036449963; 
 Mon, 12 May 2025 00:54:09 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f9ab.dip0.t-ipconnect.de.
 [79.224.249.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4cc2esm11798364f8f.90.2025.05.12.00.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 00:54:09 -0700 (PDT)
Message-ID: <fe236eaf-96b7-4b76-b2a8-f4e1935b4be7@redhat.com>
Date: Mon, 12 May 2025 09:54:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] memory: Change NotifyStateClear() definition to
 return the result
To: Chenyi Qiang <chenyi.qiang@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-11-chenyi.qiang@intel.com>
 <c7ee2562-5f66-44ed-b31f-db06916d3d7b@intel.com>
 <5fcf90b9-dff5-466c-9be5-2b6571a5de8a@linux.intel.com>
 <55547b18-be03-4684-9330-70fc2ba48954@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <55547b18-be03-4684-9330-70fc2ba48954@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 09.05.25 12:04, Chenyi Qiang wrote:
> 
> 
> On 5/9/2025 4:22 PM, Baolu Lu wrote:
>> On 4/27/2025 10:26 AM, Chenyi Qiang wrote:
>>> Hi David,
>>>
>>> Any thought on patch 10-12, which is to move the change attribute into a
>>> priority listener. A problem is how to handle the error handling of
>>> private_to_shared failure. Previously, we thought it would never be able
>>> to fail, but right now, it is possible in corner cases (e.g. -ENOMEM) in
>>> set_attribute_private(). At present, I simply raise an assert instead of
>>> adding any rollback work (see patch 11).
>>
>> Do the pages need to be pinned when converting them to a shared state
>> and unpinned when converting to a private state? Or is this handled
>> within the vfio_state_change_notify callbacks?
> 
> I think it is handled in vfio_state_change_notify(). Just like the
> device passthrough in legacy VM, the shared memory will be pinned during
> vfio dma-map and unpin during unmap.

We'll have to "unmap/unpin before shared->private" and "map/pin after 
private->shared" conversion.


vfio cannot fail unmap/unpin, but guest_memfd will be able to "easily" 
fail shared->private. But in that case (temporary references) we'll 
likely have to retry the conversion until it works.

guest_memfd cannot "easily" fail private->shared conversion, but vfio 
can fail map/pin, in which case we probably have to abort the conversion.

Error handling/recovery will be a bit more tricky than it is today.

-- 
Cheers,

David / dhildenb


