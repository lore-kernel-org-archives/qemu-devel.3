Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F82E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEOZ-0004Gv-Gb; Mon, 16 Dec 2024 11:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNEOX-0004GX-Va
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNEOW-0005e0-0i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734368190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5YC3H5hxesju5n1SIeu4R5CVLoqAEpWTMjq+Ga2jNLI=;
 b=YAMlK9/Mp+nqT/atSXEHCxL7ASntJA08U5pq29PojOChVDJfEla6lrstRw3HErhlUrwD+f
 n19l245S1CAOEiQZmgcRGIYarrUk4PuUusLli957YaQkNDoQundFHh83nd5KJ1b3wdi28h
 uH+x7OiCjh03MJnKGEGDllfRcu4XdWk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Lceao1DLMk-Bb8_3rQhBYA-1; Mon, 16 Dec 2024 11:56:28 -0500
X-MC-Unique: Lceao1DLMk-Bb8_3rQhBYA-1
X-Mimecast-MFC-AGG-ID: Lceao1DLMk-Bb8_3rQhBYA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso6129375e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734368187; x=1734972987;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5YC3H5hxesju5n1SIeu4R5CVLoqAEpWTMjq+Ga2jNLI=;
 b=OQqr7alNZIJgzfMIE5FxqUmN16iyWJsFa3l52GPJGvN2fxAP3MbNyhpO4Lzzjf4KOq
 ERcteYqDGYyGNoQ57JyaSwPXpeIHEqqhB5Z8agjUP4jpt+Acm0lwjDT9QU+FERt5LbVs
 KGJxx7eM842orRnPQJRYHIKsYdsS1eIVVTe1srbdhmqGqPETsGjLAWq4dJ6Xm9D8Qt33
 T6Z2wodHUWNlvJTnH6q7+DzQjO2ru8SEyglB8GxmkXvnAiXXEjb0KUJwIZ1hUS2cFN5p
 GBpcNIAOkJAe3onCIjXzI1RdZvJs2CgRizuoXiuVm8DgUrghlZA+uXNVnDOTqN0P0xy1
 V1Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK+oNs3o/VOD8SM31rG6dpJY1PP0NYV8Nc/31Bv4ozphcwLBZgGvkPMmWJzrPV3sy/umido3zK2nA2@nongnu.org
X-Gm-Message-State: AOJu0YxdOQhIPDqfRjuMWUgELPkkw8JjyUXCUWr2q9/gG2qNzhjUSapr
 sW17bqtAZhwvhcPWDKzelQomfnQBXf+Utkk8riL9tITP7Nkw+qqg3OQjDg1s4U+bTfcT/P0y1ZZ
 HR8zlSrjtNOyK5ZvZhwlRW6a2RMrjVjElgjWpVQpgnf6mFK0TMWml
X-Gm-Gg: ASbGncu9pIjcRV79FCH4IK1AXA5FYzYL5p2jYRQv1EJK9lZ306bkPOf+hHfULSENXXF
 DZ/5YSgZC5s15zViDC0AWV1baDDVGIqokzTybo0ruppWwhJjJe+AN92SmikHmnidFxBFtJnnGaN
 00clw5o7FdV1V0bkgq0HMxFqpxaBbsLIP4eC8uVxASq7Pu+HiSWA57eWvyZ4ubduaH2oVt7xfER
 exT0RdDg5oyb5fIfLE/B6bNE7w70onpCvfkiSxiyHxIZ+9v0oh7SvNcdDSCT/aMJ6EIRxzMAuze
 ZnmF2d5aN2dsM9XlW0oxv+NiFQYw5nG2WU2ueRyQkNJciViMgJoEwGYm0XnczhasFRipKnp1fCv
 P4X5r7aAB
X-Received: by 2002:a05:600c:348f:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-4362aa9f682mr113934685e9.27.1734368187467; 
 Mon, 16 Dec 2024 08:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnaOCNd480G9yf9ihtZjdgEVY/oBPneRv5o0wgsgcIFywVg18ua5YaEpxHd5HmKUl/BPeHag==
X-Received: by 2002:a05:600c:348f:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-4362aa9f682mr113934485e9.27.1734368187143; 
 Mon, 16 Dec 2024 08:56:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:f600:c577:b537:f52a:b994?
 (p200300cbc72af600c577b537f52ab994.dip0.t-ipconnect.de.
 [2003:cb:c72a:f600:c577:b537:f52a:b994])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625553234sm148088255e9.3.2024.12.16.08.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 08:56:25 -0800 (PST)
Message-ID: <eb6b9c83-fedb-4765-a902-695fe889e45d@redhat.com>
Date: Mon, 16 Dec 2024 17:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
 <20241213225440.571382-2-mjrosato@linux.ibm.com>
 <7e07ef1e-4fa5-40d7-85f9-d7a199901b4f@linaro.org>
 <46acb391-154e-43a1-a459-1646dc27fb33@redhat.com>
 <f1cba8bd-b15a-456c-8640-7c0ed221b2d3@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f1cba8bd-b15a-456c-8640-7c0ed221b2d3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16.12.24 17:53, Matthew Rosato wrote:
> 
>>>> +{
>>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>>> +
>>>> +    /*
>>>> +     * For direct-mapping we must map the entire guest address space.  Rather
>>>> +     * than using an iommu, create a memory region alias that maps GPA X to
>>>> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
>>>> +     */
>>>> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
>>>> +                                            iommu->pbdev->uid);
>>>> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
>>>> +                             0, ms->ram_size);
>>>
>>> Is it a good idea to take the whole machine ram-size here?
>>> Could it be better to pass it as qdev property?
>>
>> I think we want all guest RAM, just like ordinary vfio on !s390x without a viommu would do.
>>
>> Matthew, I assume to handle virtio-mem, we would actually pass in here the result from s390_get_memory_limit(), which will cover initial+device RAM, correct? Until then, this would map initial RAM only.
>>
> 
> Good point.  Using s390_get_memory_limit() sounds good to me; That will make v3 of this series dependent on the s390x virtio-mem series but sounds like you're sending that sometime this week anyway.

If my testing is good and there are no further comments, I'll queue it 
directly (no change to v2) to send it upstream.

So it's probably a good idea to wait with a new series her.

> 
> I'll start testing on top of that with something like..
> 
> memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
>                           0, s390_get_memory_limit(s390ms));
> 

Yes, I think so.


We discussed at some point maybe requiring disabling uncoordinated 
discarding of RAM (virtio-balloon), is that already done implicitly now?

-- 
Cheers,

David / dhildenb


