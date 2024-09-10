Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E51EDE9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5rV-0006Pi-K5; Tue, 10 Sep 2024 14:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so5rQ-0006Ol-Ol
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so5rO-0002xg-VY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725993904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kqvs3C90iGzm135MXlx1sXrGkv4nj93AotCP0HHWwpY=;
 b=gZr5xCguC4Pc/KXDmftOLBqw1a+IgtB2bKsyg6NuTF5dHX57YddALLHv1uwP2XUuVQ0vad
 tJlS+J1iL5X5gnLKTYM+Ak0Y5uXeeOclmeWjRfC2gcRD5BpcncuEruScRMMMCY57f4/N11
 bzMVXkII/O6GjknmPkxPLHpCR8ZlF1s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-JY_aux3pMkyhFdCLw-9Y5g-1; Tue, 10 Sep 2024 14:45:03 -0400
X-MC-Unique: JY_aux3pMkyhFdCLw-9Y5g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb635b108so8732965e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993902; x=1726598702;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kqvs3C90iGzm135MXlx1sXrGkv4nj93AotCP0HHWwpY=;
 b=AFgocG14ts/7Wby28C5dLcf3D5c7s0B2SgNSRL+qGbDznh4VKTrDc5oBpsF4ZiZQTl
 WgDQG4OtNlh1LktIFfJ8u9hbNAU4nXYYHpcXbTbzWAGQoLcRAAHgk1MaHWDSGELPb+Kp
 rc938lHHGbjaZMCHVKByNhOjM+Q5QbWA7M1ztn/wtT2mcLfNsGbuPefrY5+8rqw8cwi2
 ce77vkFNCfI+uOcFw83GWakvqYqNRk7f+dMWMiJmTgdw8Gq8H88bnqbYDliAaDkqVczc
 CVYh271NHVP7TsXiRWx6Gd2zaLB0m9qXki1H+VZYKxjK1m8Ba/WH9mVZwkYLk79VDBn7
 MzLQ==
X-Gm-Message-State: AOJu0Yx8chD95DohItYHBinaPFzHpft3qos5UpUA2Rr1IfrTM+YVjVXb
 +maFuA0hwjpyJnAQJEtgniptiajxsoBlexfyufiIHddcRes/w0+SqmxKX9zJXtT6CfIcwR0tkTw
 cCzlFb4z4yx8qzw0US7EY/DopuxWzQx2Y6h+VldW25P596qdPVSRf
X-Received: by 2002:a5d:4b41:0:b0:374:c945:2569 with SMTP id
 ffacd0b85a97d-378b07acbf5mr414913f8f.15.1725993902151; 
 Tue, 10 Sep 2024 11:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL0YWazQw2YCqVYbw7fBRzj1BZNp5xXXGg7SJQjOwx0VRSc/4VZDbYy0DPNEIyRlqyKl9chA==
X-Received: by 2002:a5d:4b41:0:b0:374:c945:2569 with SMTP id
 ffacd0b85a97d-378b07acbf5mr414887f8f.15.1725993900752; 
 Tue, 10 Sep 2024 11:45:00 -0700 (PDT)
Received: from [192.168.3.141] (p4ff237ad.dip0.t-ipconnect.de. [79.242.55.173])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb58d815esm90463485e9.31.2024.09.10.11.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:45:00 -0700 (PDT)
Message-ID: <56233de5-69b3-4274-a995-7529221fedbb@redhat.com>
Date: Tue, 10 Sep 2024 20:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-mem: don't warn about THP sizes on a kernel
 without THP support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20240910163433.2100295-1-david@redhat.com>
 <20240910142458-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240910142458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10.09.24 20:26, Michael S. Tsirkin wrote:
> On Tue, Sep 10, 2024 at 06:34:33PM +0200, David Hildenbrand wrote:
>> If the config directory in sysfs does not exist at all, we are dealing
>> with a system that does not support THPs. Simply use 1 MiB block size
>> then, instead of warning "Could not detect THP size, falling back to
>> ..." and falling back to the default THP size.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Gavin Shan <gshan@redhat.com>
>> Cc: Juraj Marcin <jmarcin@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Okay, I picked it up. But I have a question

Thanks, I can also route it via my memory device tree, whatever you prefer.

> 
>> ---
>>   hw/virtio/virtio-mem.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index ef64bf1b4a..4075f3d4ce 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -88,6 +88,7 @@ static uint32_t virtio_mem_default_thp_size(void)
>>   static uint32_t thp_size;
>>   
>>   #define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
>> +#define HPAGE_PATH "/sys/kernel/mm/transparent_hugepage/"
> 
> 
> If this code runs e.g. on windows, it will poke at cwd root with
> unpredictable results.
> It doesn't look like this is linux specific, did I miss anything?


VIRTIO_MEM has

"depends on LINUX"

so that code will never run on Windows.

Thanks!

-- 
Cheers,

David / dhildenb


