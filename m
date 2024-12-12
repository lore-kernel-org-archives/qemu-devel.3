Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F99E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 21:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLr7I-00065w-Rc; Thu, 12 Dec 2024 16:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tLr7H-00065f-MB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tLr7E-0001H0-FP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734040377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kf9SnwwmnJrMvaBh3IrQ1RM/qKq9BFbAX1/w2mTz5mg=;
 b=LlivgEDLK7ulAN11TSwh1R8wLdaH68ou3Ut6vnMua6qVhL9yDRdWDx5QVPoYfRn76Zr9KH
 6B16UmZcwV9uFF0+kcGUOsXY+ttAOw2zZzSzJV0aiNeGrfJcEyPqeIfaxVXxcHvsGVm5QG
 UlBSY1SeWgAFoG1KqHZbND/7ZymaUmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-8sAtuaa1Py-xlH2Zzp3jfA-1; Thu, 12 Dec 2024 16:52:56 -0500
X-MC-Unique: 8sAtuaa1Py-xlH2Zzp3jfA-1
X-Mimecast-MFC-AGG-ID: 8sAtuaa1Py-xlH2Zzp3jfA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso677590f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 13:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734040375; x=1734645175;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Kf9SnwwmnJrMvaBh3IrQ1RM/qKq9BFbAX1/w2mTz5mg=;
 b=FFEafxRcymTgFcoHjdCMOHcl6jVm6PBEUrGRD/2WXJxHTH2/zQEP0/Rbndw8rDhd6h
 Lfujw/9NBH8K9c3mvgNhMjfe4TIkWGtWMNMXVkDfhcROY3kxF9kdhiXcuYRLp9RtmGh2
 AcjUAd7fklGBGwj5sK+fwl2KlFvx/BHj7iLt8R/F4bZKFvNm1r6fTl3QRDjEQZbXzMTl
 3wQd2KnCgLUEd5GfiZ0KYJfJVsD7P6G4hA8PJYetQtPMKLgMgVlPZFe83NEFXOUBrfJU
 s6LDcZzqJXUCKDiQA+EAFz7bMe6X2uEQEoSpj5oHwJ5KdWHtu3M2dKBVvtCn1nGPCgBr
 A1Jg==
X-Gm-Message-State: AOJu0YzLp7kKXi8Sy3qlMZtXaDAgd3Gq4PcXg0D/hW6BDnWW9GedZS8M
 TJf5Fz+jG1cpF7T8FTSLqlZW7t0BS1x7SRYr7vVSEtu5xMv5Z8i3jggOzG20Rwo/0qDVhameunE
 vLwzu6K1yoK099FsQfC47+3E1DTUPESqLq7uv3+qy8pQv0BIm/3oG+dOaTlI8JKeqF6cou0T7Ag
 wRIKqlIIQZco3mJc6sdgDpUT8Yg6f7v+vZIJk=
X-Gm-Gg: ASbGncsRQ7f9LSCeUz3+isF2pZUklvkM4nqXt5nFDlisrcbHZqa9DBiAWMOf2kNNn7/
 zirLRjh/KLxqkgafqBjTrAU/fTofB2neJeCub14Ajt6zAB0uvMJ4qZWi8MiTw0ohwjfK/xZrYk1
 ngyYBEdy0xIhbGa80snLytpie4UclvJy0fnVvhjDykbfTpvG5JISYsKdtyCHUou98oLI17sMHP7
 q8gmPx/Nm+0+lEC6bF8myR8eWkp36HWPHjc7SfrSGZ7UIiB6Nr+K6zwrMd86R+vq0locLg1hlxu
 i3nmMk6I00CLZbkqkwWf/COq9th49L+hCuMdfoOtAfWQK+DpQI5r+4ZkAhagWJTbeGqH+CCmSf8
 bRihwV6wL
X-Received: by 2002:a5d:64cf:0:b0:385:f220:f789 with SMTP id
 ffacd0b85a97d-3888e0c1645mr113778f8f.48.1734040374846; 
 Thu, 12 Dec 2024 13:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhV520dPKf+Ng6DYqmhkaAJ6Tyg/Xml+nuYnQaVRAYl+uTcCPOFk0bAYJ7O7yR5Dcjw61sRw==
X-Received: by 2002:a5d:64cf:0:b0:385:f220:f789 with SMTP id
 ffacd0b85a97d-3888e0c1645mr113756f8f.48.1734040374386; 
 Thu, 12 Dec 2024 13:52:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c716:2b00:720b:42a1:ba95:a3db?
 (p200300cbc7162b00720b42a1ba95a3db.dip0.t-ipconnect.de.
 [2003:cb:c716:2b00:720b:42a1:ba95:a3db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514d35sm5214781f8f.74.2024.12.12.13.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 13:52:53 -0800 (PST)
Message-ID: <7e1025b4-c246-432c-b70d-e7156afb6519@redhat.com>
Date: Thu, 12 Dec 2024 22:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] s390x: virtio-mem support
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <07ca4492-1590-4cc6-94a1-0eea417da59e@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <07ca4492-1590-4cc6-94a1-0eea417da59e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13.11.24 15:46, David Hildenbrand wrote:
> On 08.10.24 12:54, David Hildenbrand wrote:
>> Based on current master.
>>
>> There is really not much left to do on s390x, because virtio-mem already
>> implements most things we need today (e.g., early-migration,
>> unplugged-inaccessible). The biggest part of this series is just doing what
>> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
>> well, messing with the physical memory layout where we can now exceed
>> initial RAM size and have sparsity (memory holes).
>>
>> I tested a lot of things, including:
>>    * Memory hotplug/unplug
>>    * Device hotplug/unplug
>>    * System resets / reboots
>>    * Migrate to/from file (including storage attributes under KVM)
>>    * Basic live migration
>>    * Basic postcopy live migration
>>
>> More details on how to use it on s390x -- which is pretty much how
>> we use it on other architectures, except
>> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
>>
>> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
>> be documented in the kernel and at [2] once this+kernel part go upstream.
>>
>> There are not many s390x-specific virtio-mem future work items, except:
>> * Storage attribute migration might be improved
>> * We might want to reset storage attributes of unplugged memory
>>     (might or might not be required for upcoming page table reclaim in
>>      Linux; TBD)
>>
>> The Linux driver is available at [3].
>>
>> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
>> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
>> [3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com
> 
> Gentle ping (and thanks to Thomas for the review!).
> 
> I assume the kernel portion will go upstream in the next merge window.
> I'd like get the QEMU parts merged soon after that.
> 
> 9.2 is going to get released in roughly one month, so there is still time.

In the meantime, 9.2 was released. I don't have any changes planned. 
Series still applies to current master, I'll do a quick test tomorrow.

> 
> @Thomas, this is mostly s390x stuff, so I guess it should go through the
> s390x tree? But I could also take this through my "memory devices" tree.
> 

@Thomas, any thoughts?

-- 
Cheers,

David / dhildenb


