Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E6BE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEuY-0000ZM-FQ; Mon, 16 Dec 2024 12:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNEuC-0000NK-Ot
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNEu6-0001w8-I2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734370149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RthFyiiO1bV6Bp3f0bMBrsKQi6hz1y+H7k5xZu9vRs0=;
 b=QR8OfrakIelJwYxI8AQpJps/4vZ2ONkRjsVsuWW9vR2/Epx9GQl2dCKIIRt8tr1RlshvZe
 sl0fD2bFwe1dod1nvIz93KTOqxhlYQQd23XF/6lTMrmYrsQ2pCoCHQfoSEfOsoo3QM0KFe
 t6Z+ffGRQ/NeQs+R/0uqj2Dcs+yUs/Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-811fN4SyOLqLGlgIKrhsJg-1; Mon, 16 Dec 2024 12:29:06 -0500
X-MC-Unique: 811fN4SyOLqLGlgIKrhsJg-1
X-Mimecast-MFC-AGG-ID: 811fN4SyOLqLGlgIKrhsJg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso23811085e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734370145; x=1734974945;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RthFyiiO1bV6Bp3f0bMBrsKQi6hz1y+H7k5xZu9vRs0=;
 b=pW8BRqd5WEwJXlp4Cc2YXJDddeK8UKzMXUJjzxNKeAUWy/N1t/yxHsDgwTz8ulpnyq
 qOdfenKO90qbLWysqgTTGtRl7zBu1HUuvtH4SF4sJxkGsAAt4EjXsdHwZmInS0eJ2b2b
 VBsTMgQLFEKILJzm1lA7QzpORjRqzwvXbrAhpQTwNl22Osfq+PXSJw4MN6D/4AIley+L
 93b4bEuZu9jsLARvqTBXq64yYOO+E/MKLF8fz9Jb4oxyYSuRBaJOR1RhUrhU4sEQ2UqM
 QleZCq9iAmp8UtJ5yQwXGPABom9X78bkbu2mCpCPwZkW4mZb4tuP0VQoN+wFvh5STntw
 QNjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZcJXgCkW5DW0Vs9G0HeTbDUs1soyrHjimtDi6VYGHY95OMbjvhZ+oZZMAUfzeiSvEOsFtmnieN92d@nongnu.org
X-Gm-Message-State: AOJu0YxXJsCIrdslZt/E0ah9qrbqiVeUCXPhHtvKH2Aafaoe6amHBU+G
 qcBSP7KIaaweMBc5crY3riTjDvGtyiFSHvANJ04NTDErkZ3vPo7Czg789tOdO0gddHJDl/jCUAR
 YtofOHVrXpK05sVKXrwhLLVLP793Y2HyiOV9tDPN/TckrxkbWcPkV
X-Gm-Gg: ASbGncs4MBpR3zONyqXVH77UdT/seYUUUtkuDcKzViOzGkO972Nk4nimSkjUq8BKnVA
 8eIi4twHh/8ZUwl4gZZ8cSR6eRQRi/59tUqDgS3lbq9MaQH1AlZX7RxmyuW27X42iWZhp+OFeq2
 REv1siWD82LAEXKtSAexcMfZkMmhMR2e/ukWYxd/1vgj0gWhvvT5NzjiG8JVFC72eP8BCOi3aKj
 /PQA8RFhYDjRX/0JayQpYqUEbQMh5QORnLXCGgPxw05ccV3OMYqEphryHCIEvT98vMOskt8uVdK
 hYVMhvxSHSE751iHyS0ksrM4YDjE2tDO4cYLAbXfiI3VP1xz0S3w/YISpfoqGp2zgKw+4HVbowk
 kfdCzT5sc
X-Received: by 2002:a5d:64e9:0:b0:385:fc00:f5f3 with SMTP id
 ffacd0b85a97d-388da380c48mr362477f8f.4.1734370145057; 
 Mon, 16 Dec 2024 09:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTejaOmG5hrWlYzOxV+TzX1X/v+I26AsZI7I5bIcxihyz8uAVaEv2ufJqUngH1NCgryJNqSQ==
X-Received: by 2002:a5d:64e9:0:b0:385:fc00:f5f3 with SMTP id
 ffacd0b85a97d-388da380c48mr362456f8f.4.1734370144694; 
 Mon, 16 Dec 2024 09:29:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:f600:c577:b537:f52a:b994?
 (p200300cbc72af600c577b537f52ab994.dip0.t-ipconnect.de.
 [2003:cb:c72a:f600:c577:b537:f52a:b994])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801233asm8971950f8f.9.2024.12.16.09.29.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 09:29:04 -0800 (PST)
Message-ID: <49ed5940-8995-42cd-9587-8a2a01461f43@redhat.com>
Date: Mon, 16 Dec 2024 18:29:03 +0100
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
 <eb6b9c83-fedb-4765-a902-695fe889e45d@redhat.com>
 <625c8ade-f87f-4203-81ff-a4ea396f15ac@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <625c8ade-f87f-4203-81ff-a4ea396f15ac@linux.ibm.com>
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

On 16.12.24 18:26, Matthew Rosato wrote:
> 
>>> Good point.  Using s390_get_memory_limit() sounds good to me; That will make v3 of this series dependent on the s390x virtio-mem series but sounds like you're sending that sometime this week anyway.
>>
>> If my testing is good and there are no further comments, I'll queue it directly (no change to v2) to send it upstream.
>>
>> So it's probably a good idea to wait with a new series her.
>>
> 
> OK
> 
>>
>> We discussed at some point maybe requiring disabling uncoordinated discarding of RAM (virtio-balloon), is that already done implicitly now?
>>
> 
> Yes, this should be handled via the call to ram_block_uncoordinated_discard_disable() in vfio_ram_block_discard_disable() - I just traced that now to double-check.
> 

Cool, can you briefly mention that in the patch description? Thanks!

-- 
Cheers,

David / dhildenb


