Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDE5C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdLz-0005Cj-Ki; Mon, 10 Mar 2025 09:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trdLu-000519-Fv
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trdLr-0008Co-Dp
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741613966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lKBlLxQsicC1rfobcNYis1DkuTBei7nN9YXbDyxSvSY=;
 b=Sn71/duWG+48obXCmsUKTw/F1GJ3o9yKROfkrmHJaUfwSH68XcW6ScXAatImQr6wslFIZe
 OyFzcsTRmRzNhBRqUD6frf+Ra9R07kXo0UBs9DoufIHOl7eZWrd/7YuHe4u9BLdiM3IuMV
 0xcbu1qYIKyegiV5snNcBjTUh1iz4Gw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-_Eh3BuSJPMOj3rFt5HkngQ-1; Mon, 10 Mar 2025 09:39:24 -0400
X-MC-Unique: _Eh3BuSJPMOj3rFt5HkngQ-1
X-Mimecast-MFC-AGG-ID: _Eh3BuSJPMOj3rFt5HkngQ_1741613963
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43bc97e6360so19984995e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613962; x=1742218762;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKBlLxQsicC1rfobcNYis1DkuTBei7nN9YXbDyxSvSY=;
 b=dmPcbDhmuK3vosAecpim7fbD8L3AfpPzmaMgM/yJPVshTXF3yOm+zaOZwJXzkWkO63
 PdGYPajSokGskJNE8iDK8ZoLOLK3J+2FGLHS15IWHxTXL6S9QOzd8n9/fKpYUr15+Sq+
 Il9WT/qAfQVuLdTaL8A6igybEbvXmXj5IQ5tQXpaqbNTTVOkdJ5FxXstmORoS/ea7wIt
 Dwtb06bHKZ/Ni6LAdCcHO7BrqgJHheLw/Gt4O0uJ67tp36BBecVO0P19BdK8W3TVAzAX
 cX+17GZ+rzMneQTUboY8KJfJ9mYF/MjoF4rR6KYfFFtdby/GgfNI6Dk4QqCST3TeSwvt
 7Zpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8hgszDngaEKuEZh3tkCaka4yabbXTS8yX9xn0BkqzSAyOPpLgxFPQ3alW6ywgg9QPpn+RK/rifNOc@nongnu.org
X-Gm-Message-State: AOJu0YyMsjJR2OIaajp1qTbzhXriI0IcXqX6Z5mVgWf/oNO5aVtX457Z
 N3VGUyhi2iMyBRl+dRCuUu4La2s83EJIxUczpVK6JPzZqSf+CRsPuYMpNesRvb7Euyh3ECcvrBW
 9QXhGln6JGIgMleA057l94J1rLUv8VvYz0T+y29bO5afqR+Oqi3mptp2qqIDEuQ8=
X-Gm-Gg: ASbGncsZufozfqBjB6xFeKhchju9Tz90FgVb5F/w2hhbWU1XVYIH565IRmyI6gniE4G
 WP3NpkiuKcgg57PcYKwAKC0c5T4Ayu1LJFn19k/MurFJG/urQJdSQeqpKde7180lyzRd7qGg7z7
 cW2hCrvM1wWRCaLgRHggg4QfuPxj/2w/GC4ol+zW7qyLprJkYCidV6EvrFNa9GDLmgwxURzSok3
 4h6OA1UBqfG7ZgCRbskEFKDtJOWYnTUfmnVYN245tWEw63rc9OzC04c3BzI8pWYvT6dlVm9KJPc
 W3xFS9ymvCuFaYeRuj2SJg70vfndaDwE/XHeZuiX8KH+0qyykAeuZA==
X-Received: by 2002:a05:600c:4747:b0:43d:10a:1b90 with SMTP id
 5b1f17b1804b1-43d010a1e8cmr2245425e9.16.1741613962444; 
 Mon, 10 Mar 2025 06:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPL4lng0BQPVl4Q9+EcbbWH3Rh7srck0T7Q1dUtsTBeLnj00JjMW6+Rh44Rm9mOEotOrP42g==
X-Received: by 2002:a05:600c:4747:b0:43d:10a:1b90 with SMTP id
 5b1f17b1804b1-43d010a1e8cmr2245105e9.16.1741613962134; 
 Mon, 10 Mar 2025 06:39:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfcfd2a95sm16933045e9.29.2025.03.10.06.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:39:21 -0700 (PDT)
Message-ID: <7fd3d18d-8972-4978-940d-31048a2ae2be@redhat.com>
Date: Mon, 10 Mar 2025 14:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/migration: Use BE byte order for device state
 wire packets
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <f0bf02377f18f3cf6b8942528b3b5bce97fb6ab7.1741344976.git.maciej.szmigiero@oracle.com>
 <aaad9f89-56c8-4df7-bb36-fb212b39ade4@nvidia.com>
 <51f2cf5d-4396-40aa-9801-00dd2b135391@redhat.com>
 <da727e43-bf1d-45dc-b60e-51df3ca0c7fd@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <da727e43-bf1d-45dc-b60e-51df3ca0c7fd@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/10/25 13:53, Maciej S. Szmigiero wrote:
> On 10.03.2025 10:23, Cédric Le Goater wrote:
>> On 3/10/25 09:17, Avihai Horon wrote:
>>>
>>> On 07/03/2025 12:57, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Wire data commonly use BE byte order (including in the existing migration
>>>> protocol), use it also for for VFIO device state packets.
>>>
>>> Nit: should we add a sentence about the motivation? Something like:
>>>
>>> This will allow VFIO multifd device state transfer between hosts with different endianness.
>>> Although currently there is no such use case, it's good to have it now for completeness.
>>
>> Maciej,
>>
>> Could you please send a v2 with this change ?  and
> 
> I've sent v2 now as a standalone patch.
> 
>>>>
>>>> Fixes: 3228d311ab18 ("vfio/migration: Multifd device state transfer support - received buffers queuing")
>>>> Fixes: 6d644baef203 ("vfio/migration: Multifd device state transfer support - send side")
>>
>> we don't need these Fixes trailers because the feature is not part of
>> a released QEMU version yet.
> 
> Removed these tags now.
> 
> I've originally added them because you said last week it's going to be a "Fixes" patch:
> https://lore.kernel.org/qemu-devel/7eb4dd80-0ae3-4522-bd1d-b004c19c4bf2@redhat.com/

yes. We are still in time for hard freeze, even soft freeze. So,
it's less important.

These tags are really useful for distro backports and for stable
trees.

On the TODO list, we still have to discuss :

  "vfio/migration: Add max in-flight VFIO device state buffer * limit"

and we should be done for QEMU 10.0.

Thanks,

C.


