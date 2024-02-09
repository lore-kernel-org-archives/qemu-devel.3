Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88065C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 22:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYZUh-0001jI-PD; Fri, 09 Feb 2024 17:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rYZUW-0001hE-Gt
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 17:37:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rYZUU-0003si-OJ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 17:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707518220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W1N5gGymcOmQ0uib7FqbuIvNmBor++wNZfxw1SqVMmg=;
 b=NcXpHAvMgUGsv9ojgdIY//H0cyrjZdjmMVGG4IDKQSc5o4A4lmRT1yTkRH2LGroCjs1YZm
 XUCF/+msJUXK20MplCUyuYyKaYkIpBazF4scaNqOPZVJeY1mpPZALzNzkUzLnCGux6gX+K
 rdpHONBlHb6CHI/G30DJGkKP+ypDiU4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-LIMhNGTmPUOnv_rwxgXOpQ-1; Fri, 09 Feb 2024 17:36:58 -0500
X-MC-Unique: LIMhNGTmPUOnv_rwxgXOpQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b2238ceceso577708f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 14:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707518217; x=1708123017;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1N5gGymcOmQ0uib7FqbuIvNmBor++wNZfxw1SqVMmg=;
 b=poknV7lMkdKXdXtWi5JxcvUzQWsaQStDj76aBxikxEOZR8mPeCwO9EbWp9Dkj+ihnd
 diaVYVEqf8lscqbaDOpePvKLHMWTlQWgLA6LoNVyr9trraHQ314RQYkSoLYcI5zEYI4I
 Ci3vD2g6Z8UqjZk5pg26aF5Izgh9i6FMF2GUhWDKZu38Cy+kGH1HPFQrlfXWA1oi5J+t
 ZBTCDcN8D5PjBxq9TByyZRbZOxHKITUlu16Y2GXrzfXbPbOZblLKwTBxuLJe6oeGW0Is
 WkgnCas1Y0HYa728bstpZAH2OmuEnItn21fN1wn/UkQySgmM8+5rOejgzeoCfWBtW5F1
 JBcw==
X-Gm-Message-State: AOJu0YxJcKHFvTMEyBtyJI45OzV1/rcnNa322haChw81BW5zSs9Jhz1B
 nVyodenzF+CBwyLTE0/vJznVMYbJiUaXBOkUMELAEY0RdsVt7lj7cH4+B4k5g5mvTaJ/HSMLo3c
 V/+KkXdZRL7wyaeosXygonHzlfxDcW2TcecbIVFbvwSueyB2MzJZT
X-Received: by 2002:adf:e485:0:b0:33b:4ec0:815d with SMTP id
 i5-20020adfe485000000b0033b4ec0815dmr298161wrm.41.1707518217581; 
 Fri, 09 Feb 2024 14:36:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbUsj/9m1U6mYEi6X6n2gIgz9JLyolN5aVlRM29g1z0cNOv7jq9EPM1Y9qZDQTxx8nAPDtLA==
X-Received: by 2002:adf:e485:0:b0:33b:4ec0:815d with SMTP id
 i5-20020adfe485000000b0033b4ec0815dmr298147wrm.41.1707518217218; 
 Fri, 09 Feb 2024 14:36:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXFBgNbJ2hnzLBHimmaLFFWEnQAbry6QuwIpHNf4TCeMgRmwXBQm0p0erMJQky2ef3GIu9sn1y/+BLF8mQj5hggHjf8xT652CuJrUqOxQFZe90AxsvQVr1BTosOxq3BxgXVRyqt1GqecJKnS6OJ4VqHvyykcjcMKuHwZRI4V6tlwqgqaQbewxv3x1m8czQwBcOwfNCnJTMRnVA=
Received: from ?IPV6:2003:cb:c718:6800:9d15:2b60:4f57:7998?
 (p200300cbc71868009d152b604f577998.dip0.t-ipconnect.de.
 [2003:cb:c718:6800:9d15:2b60:4f57:7998])
 by smtp.gmail.com with ESMTPSA id
 bv4-20020a0560001f0400b0033b670b0a6asm302786wrb.74.2024.02.09.14.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 14:36:56 -0800 (PST)
Message-ID: <6f5963d8-e91d-41b6-88e8-3b1e723b6a6b@redhat.com>
Date: Fri, 9 Feb 2024 23:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] libvhost-user: support more memslots and cleanup
 memslot handling code
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20240202215332.118728-1-david@redhat.com>
 <m4ss6m67yk43tasdutjey544dwfvznd2r7ytwe5bccvsiiuhdt@ejefxhpxnm2u>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <m4ss6m67yk43tasdutjey544dwfvznd2r7ytwe5bccvsiiuhdt@ejefxhpxnm2u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07.02.24 12:40, Stefano Garzarella wrote:
> On Fri, Feb 02, 2024 at 10:53:17PM +0100, David Hildenbrand wrote:
>> This series adds support for more memslots (509) to libvhost-user, to
>> make it fully compatible with virtio-mem that uses up to 256 memslots
>> accross all memory devices in "dynamic-memslot" mode (more details
>> in patch #3).
>>
>> One simple fix upfront.
>>
>> With that in place, this series optimizes and extens memory region
>> handling in libvhost-user:
>> * Heavily deduplicate and clean up the memory region handling code
>> * Speeds up GPA->VA translation with many memslots using binary search
>> * Optimize mmap_offset handling to use it as fd_offset for mmap()
>> * Avoid ring remapping when adding a single memory region
>> * Avoid dumping all guest memory, possibly allocating memory in sparse
>>   memory mappings when the process crashes
>>
>> I'm being very careful to not break some weird corner case that modern
>> QEMU might no longer trigger, but older one could have triggered or some
>> other frontend might trigger.
>>
>> The only thing where I am not careful is to forbid memory regions that
>> overlap in GPA space: it doesn't make any sense.
>>
>> With this series, virtio-mem (with dynamic-memslots=on) +
>> qemu-storage-daemon works flawlessly and as expected in my tests.
> 
> I don't know much about this code, but I didn't find anything wrong with
> it. Thank you also for the great cleanup!
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks Stefano for the review, highly appreciated!

-- 
Cheers,

David / dhildenb


