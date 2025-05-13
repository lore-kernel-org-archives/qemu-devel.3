Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpQp-0001qS-NR; Tue, 13 May 2025 09:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEpQm-0001q8-B6
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEpQj-0004su-MU
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747141936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HRsdhSthzE4HJRcMruTsVkrSKyQw+16tWar4GJTP75s=;
 b=JDzVerhMnD1158x+Ed/uaOv1dbkL9ZMrVSNLKjVVUDBUmD7pHRA/Hvo9X0LXfwDIE23/hz
 Mhy9Xw4/rH7+SHo0gM/20YlJKoxtNO/1ak8hw7/RB4b1qgYnqv0Vyf5ae+8t2RuS6QNzTV
 Ea+R8dvozf1Hh5ZJfav3/WufVQ/AElk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-WGkOOyh_NSKEH56QprYThw-1; Tue, 13 May 2025 09:12:14 -0400
X-MC-Unique: WGkOOyh_NSKEH56QprYThw-1
X-Mimecast-MFC-AGG-ID: WGkOOyh_NSKEH56QprYThw_1747141934
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so25411365e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 06:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747141934; x=1747746734;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HRsdhSthzE4HJRcMruTsVkrSKyQw+16tWar4GJTP75s=;
 b=cLJL9RyQ+EG2CyhXXMcKs8OKPrgjQd7+pDY2L7EZ+cXhQvbr2pYTodg5W0OerlKIri
 NBRgIDX/43gFvNixiTrCVX3A5/dHcuUWNSBUxa+FQ9mhP2a6zdQfz72D9isR+48R95zv
 /ABa45KANm7ExSAYGZjMz1aPS1mI5sZt3Ks1Gi4BCXbt4wdUgOjPQp+AlzCoDBMpi6Ci
 ter9YvFYcUAwBvz9sCSEagD5EIoBZewlISO95ITzGklWXydyW3e+DTBwqrJa6jK332O4
 wX8cbIRVX/je+f+jHJSxr6+YSvgc0WI5S7Q/iTo5tOOw4d0oqSe9hpyYtnmx9Ki7sLoF
 4n1Q==
X-Gm-Message-State: AOJu0YxLxZRq7UIcNDF2/J5XbgdYvvsDXpf1COe34jZQ6KLxlU8URcqA
 URVF2siyo/poE0mUEURff5BoeFSObR6cYRTAhpevPFU9A6nLblPTdVMqeAbKnkGVlA2i97WtU05
 DKDPWRpnm+lY3tz7fEJQ9SQARTTs6UG/bRAcsZsO7cauyrNS+ZySD
X-Gm-Gg: ASbGncsMOx9c5smHWBYpf2VwBE23HykPyaO81vcd3X0thGeb8zL5laJ1tl3O2Ro73uv
 OajEERUpMtRdt9e650xLQo4lUstKZzQtImrIWBBYubxR+O6E4xFBpI273uTYo2WxNFMvonmPttQ
 DeAXyeuJXha7ynvBbpJr7L0P/+6RwiS95UflypXQWo1PdRI1pRT3rQJ+dXVKIJ0TbvdWTMBA3DA
 cFmLxHnlwLL1zA2LDC41g5BmqLXOczMtyLahOeGrzKszT17kHdgRGV83oqxePhiqx0LrWwCvAFy
 0RqUEC5Y3bgyG7RnMzvXmxrqM9oVY/C4Gt3vHhx1PQNwKgsxdolW3D20AbRxABwnI80I1A/7jkU
 1MRyhnl8dLfMCMqxtv/D0jZZfW0HRfpdTvsHbz2w=
X-Received: by 2002:a05:600c:8012:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-442d6d3e6e8mr170465545e9.14.1747141933739; 
 Tue, 13 May 2025 06:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLWZxmUovKr/xo9o+lOG9f6HpASzmkWeEIUriyP1zwENgilmHeG5byawF+qV0NJmEWXrnNGw==
X-Received: by 2002:a05:600c:8012:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-442d6d3e6e8mr170465255e9.14.1747141933291; 
 Tue, 13 May 2025 06:12:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34?
 (p200300d82f4d1a004fdf53e21a36ba34.dip0.t-ipconnect.de.
 [2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7d2bsm212687895e9.36.2025.05.13.06.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 06:12:12 -0700 (PDT)
Message-ID: <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
Date: Tue, 13 May 2025 15:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
To: Igor Mammedov <imammedo@redhat.com>, yuanminghao <yuanmh12@chinatelecom.cn>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
 <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On 13.05.25 14:13, Igor Mammedov wrote:
> On Mon,  3 Mar 2025 13:02:17 -0500
> yuanminghao <yuanmh12@chinatelecom.cn> wrote:
> 
>>>> Global used_memslots or used_shared_memslots is updated to 0 unexpectly
>>>
>>> it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
>>> It's likely a bug somewhere else.
> 
> I haven't touched this code for a long time, but I'd say if we consider multiple
> devices, we shouldn't do following:
> 
> static void vhost_commit(MemoryListener *listener)
>      ...
>      if (dev->vhost_ops->vhost_backend_no_private_memslots &&
>          dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
>          used_shared_memslots = dev->mem->nregions;
>      } else {
>          used_memslots = dev->mem->nregions;
>      }
> 
> where value dev->mem->nregions gets is well hidden/obscured
> and hard to trace where tail ends => fragile.
> 
> CCing David (accidental victim) who rewrote this part the last time,
> perhaps he can suggest a better way to fix the issue.

I think the original idea is that all devices (of on type: private vs. 
non-private memslots) have the same number of memslots.

This avoids having to loop over all devices to figure out the number of 
memslots.

... but in vhost_get_free_memslots() we already loop over all devices.

The check in vhost_dev_init() needs to be taken care of.

So maybe we can get rid of both variables completely?

-- 
Cheers,

David / dhildenb


