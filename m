Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4A8C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc2RO-0006Z9-JJ; Wed, 16 Jul 2025 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uc2OX-0003TV-Kz
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uc2OS-0001p4-Od
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752673313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cYn5BZaWsZ40OsB5wfX9MI/dG0d/NfSDu2krKtQ9Rqw=;
 b=Ohfm3UnTZkhjepdX9giA6//yJNefLpyN0UfAAc8KVpG9jyDo2Z1QOrKROa6uhqJPXM2jUX
 OvG7h9PuKbW5pKHOXn7eidr0rF8kilMKYVzauQxxfQlxiMXDyXNswDqJbEA+MIv4Vf6iqd
 KXAl7Tcdq/ZtuZQN2yzn/BKCYpCXYYw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-IlPMuUNTPuy0NzMvifg2Uw-1; Wed, 16 Jul 2025 09:41:52 -0400
X-MC-Unique: IlPMuUNTPuy0NzMvifg2Uw-1
X-Mimecast-MFC-AGG-ID: IlPMuUNTPuy0NzMvifg2Uw_1752673311
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4560a30a793so18420485e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 06:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752673311; x=1753278111;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cYn5BZaWsZ40OsB5wfX9MI/dG0d/NfSDu2krKtQ9Rqw=;
 b=fmSlk/osYYuHWFpRlouRQzG6qVn/NJt02DhvAzkxhk7Xz6+KJ5w4wY5tFHerEvUe89
 bs+jX8kWWsQRnOtcd2M0tGmxNxhfJ/5rUf+y+jFVooRUeb5e23EPwPj7QZZc4gsE5FsE
 NWdrM3f42q9iG0BEUkAJGoC2T5FO7rJOIKa+aXZ/C/q4qA5CKbGcxgd+UR2kDtBh5V8y
 aRvgZZ6+qrbsgt8T5yPLB29uz2xWy0kXq+j2+iqP3dIisq5GYGFGFhISkXn6z+9Srwte
 4PXTGtjpDTgNTUHkRdETLLCZPWKnIoJTGXIJDWDPDDia/Z1WN01JAK/33AKLU0ydiXC4
 T2jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxpCn4mNbiA71olMbc0FSqETLz0SBmFGVIuzkeXiSkr+Nbcp+7yMIx0my0MKw0sxcdwsPrgNZwL3U3@nongnu.org
X-Gm-Message-State: AOJu0YwF7I/pD5VvVh0UGsX684MWeQwubYhDVD1UtIpL9k/mmLCGgwR2
 aWZjUbSemLUP8/80NhpZwKsi+v0920CXjf6V47wc1bxY2ZyBryJvPQn0x+CnQNyc8KHh6kwHTfz
 SyVcR/DvoyiT8Y1YtXoYX44Tr17N66THZKPeYg0v33hLn8gjvzuH4Atxi
X-Gm-Gg: ASbGncsl6gt+jr8qJyhHYtqJASeQN7ITVxVBw5U4j8Dx4/M2dGBFPotNnGLLcnag71Q
 Oo/DDU+8ydcoA9bIOQogRJUB5whliYUllxzbKgHh8tqLo5/AaUcNFu6KN2BiMYXpzFRNaLibEyz
 as3XApo8KF2GDX8UO9d86HQupxxFmdCMqJxKG/hNmYeH/rBrr4cHFUM6V9yTwTGGBAlAHla11p9
 0sDYtRQlivWsnN2eJ61f0XqKD68BK6U9QQM1togqPxMxAmiw9Ebhgtrc1kHp39nlRCDl74DzEBU
 Y3YszCp179jJse100nlsKnNGmbhrzeOTYsdLoruDJ0bKOiq+cVRVxHeAjLbDjqCxVTONv9iifd1
 bBDFvpO+gE5yaPUgtBAh7I6qPod6hDrBlmj+UG++Tl89H3pu8QG83ltDNjFKeOO6y8DI=
X-Received: by 2002:a05:600c:3e15:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-4562e39865dmr32282425e9.30.1752673311087; 
 Wed, 16 Jul 2025 06:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3dSqL6cYA+JKZokvjgD9TeQG7Cxb7sMauztkBqDjTaYpun0h6bbBt4NEle8xjzeEBxml2rQ==
X-Received: by 2002:a05:600c:3e15:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-4562e39865dmr32282065e9.30.1752673310618; 
 Wed, 16 Jul 2025 06:41:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33?
 (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de.
 [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e81a6f1sm21731395e9.21.2025.07.16.06.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 06:41:50 -0700 (PDT)
Message-ID: <50aadfb3-be59-4803-b659-039d37eca597@redhat.com>
Date: Wed, 16 Jul 2025 15:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vhost: Fix used memslot tracking when destroying a
 vhost device
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: yuanminghao <yuanmh12@chinatelecom.cn>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250603111336.1858888-1-david@redhat.com>
 <c1a99ac3-bdb7-4825-99c8-b3a55241be84@tls.msk.ru>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <c1a99ac3-bdb7-4825-99c8-b3a55241be84@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16.07.25 15:31, Michael Tokarev wrote:
> On 03.06.2025 14:13, David Hildenbrand wrote:
>> When we unplug a vhost device, we end up calling vhost_dev_cleanup()
>> where we do a memory_listener_unregister().
>>
>> This memory_listener_unregister() call will end up disconnecting the
>> listener from the address space through listener_del_address_space().
>>
>> In that process, we effectively communicate the removal of all memory
>> regions from that listener, resulting in region_del() + commit()
>> callbacks getting triggered.
>>
>> So in case of vhost, we end up calling vhost_commit() with no remaining
>> memory slots (0).
>>
>> In vhost_commit() we end up overwriting the global variables
>> used_memslots / used_shared_memslots, used for detecting the number
>> of free memslots. With used_memslots / used_shared_memslots set to 0
>> by vhost_commit() during device removal, we'll later assume that the
>> other vhost devices still have plenty of memslots left when calling
>> vhost_get_free_memslots().
>>
>> Let's fix it by simply removing the global variables and depending
>> only on the actual per-device count.
>>
>> Easy to reproduce by adding two vhost-user devices to a VM and then
>> hot-unplugging one of them.
>>
>> While at it, detect unexpected underflows in vhost_get_free_memslots()
>> and issue a warning.
>>
>> Reported-by: yuanminghao <yuanmh12@chinatelecom.cn>
>> Link: https://lore.kernel.org/qemu-devel/20241121060755.164310-1-yuanmh12@chinatelecom.cn/
>> Fixes: 2ce68e4cf5be ("vhost: add vhost_has_free_slot() interface")
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Is it a stable material (10.0.x) too?

Probably better to have it in stable, yes. Thanks!

-- 
Cheers,

David / dhildenb


