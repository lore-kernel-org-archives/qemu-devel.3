Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F10FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCD7T-0001Ay-Qq; Wed, 29 May 2024 02:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCD7S-0001AP-9W
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCD7Q-00008O-KC
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716965343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=keKN0wOWslKEDnBf9kbq8JEIVczX+m0ev86obbmJbiM=;
 b=Vb9JTeN3NifwijdqM44KZN8RyxLGOMTP17NO4/jp7v/rX19RVQFFq/tOaNZeigWvnnHZxa
 3KnoQuXYINP2oPkpdHlDP9APt17TYZ+/j/AxG67YxhDObr5lucumPPjgBAnNlB6KbsNBzl
 WCmy7f4M3+YhhLQC+FRgQ5lef0FlTVA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-pHVN0Lv0M_6oUYsH5JVZrg-1; Wed, 29 May 2024 02:49:01 -0400
X-MC-Unique: pHVN0Lv0M_6oUYsH5JVZrg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35559d30617so1385628f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716965339; x=1717570139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=keKN0wOWslKEDnBf9kbq8JEIVczX+m0ev86obbmJbiM=;
 b=N6+g2oTJWhVeeHxpNuXfeqYt1RZLKAzb9ICa1jA6TFK7+PJjGwWgVKMjh0m5Y5jHam
 /2uMLg2hPUFMGzVDjeu5HvQ1gp4gCxewh/oZQm5Um4QxLbITZSf35t6Re0I0fwzsSCco
 Gtu+eVzmTfyV469/KkC7s9fqKiow7TJvyoj6/DDP+d3lUwi3AKdFeZmeX0vqcItjy41W
 f+/sP0HDct25J/yK2pzzEpI7UQXPz1e+bnrFIGplMoJEdZyyowY89QZZCbl0c2VBDjD/
 2JN1QRUId4vrQuFB1ysK/o5wgSYmgivNkmMXLxqDRzd25t7QD/EnSKs/jXQlDNwv6sSH
 +0mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwzQluFmov9brPf2+o5ukStilkV0qrQtmRo2lNM/gP7HQjkd8pf4yfwwNpWSeFUq94S3U/6/WPO1AMJVgLJcY7qwR9Cqg=
X-Gm-Message-State: AOJu0YxiFon6EmmHEJg7GbtL4ZQn4fSwsJSD0JSb1UXRsnX/o2xcr16p
 QzuyhJOwAig1hCPo27tKE8NiPTlNXmcLIcwU6oskLhd6sY/3D7/qiC6SjXw/1d5MFNzOhWRrGDU
 BbXnKzM7xCqT+ZbAaetLxuAycGbKhTbWOtWi9YGa2BYtkOFpL8qPdmYfZI6Py
X-Received: by 2002:a05:6000:4028:b0:357:9017:48a2 with SMTP id
 ffacd0b85a97d-357901748f2mr10971606f8f.26.1716965339612; 
 Tue, 28 May 2024 23:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYqJwsN0jaJwXeGZfBYMlmj6OLWiAIpruVmBmQBB3UKLyKJIwotzsabfnFZosZLx4DUUEIRQ==
X-Received: by 2002:a05:6000:4028:b0:357:9017:48a2 with SMTP id
 ffacd0b85a97d-357901748f2mr10971588f8f.26.1716965339257; 
 Tue, 28 May 2024 23:48:59 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a857sm13933135f8f.27.2024.05.28.23.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:48:58 -0700 (PDT)
Message-ID: <2b46e524-15b3-4c47-af50-1baa2b4c160d@redhat.com>
Date: Wed, 29 May 2024 08:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] backends/hostmem: Round up memory size for
 qemu_madvise() and mbind()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1716912651.git.mprivozn@redhat.com>
 <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
 <57fabde4-3282-4d10-aaa6-e14c2169d893@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <57fabde4-3282-4d10-aaa6-e14c2169d893@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/28/24 18:47, David Hildenbrand wrote:
> Am 28.05.24 um 18:15 schrieb Michal Privoznik:
>> ./build/qemu-system-x86_64 \ -m
>> size=8389632k,slots=16,maxmem=25600000k \ -object
>> '{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"hugepages2M","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \ -numa node,nodeid=0,cpus=0,memdev=ram-node0
> 
> For DIMMs and friends we now (again) enforce that the size must be
> aligned to the page size:
> 
> commit 540a1abbf0b243e4cfb4333c5d30a041f7080ba4
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Jan 17 14:55:54 2024 +0100
> 
>     memory-device: reintroduce memory region size check
> 
>     We used to check that the memory region size is multiples of the
> overall
>     requested address alignment for the device memory address.
> 
>     We removed that check, because there are cases (i.e., hv-balloon) where
>     devices unconditionally request an address alignment that has a very
> large
>     alignment (i.e., 32 GiB), but the actual memory device size might
> not be
>     multiples of that alignment.
> 
>     However, this change:
> 
>     (a) allows for some practically impossible DIMM sizes, like "1GB+1
> byte".
>     (b) allows for DIMMs that partially cover hugetlb pages, previously
>         reported in [1].
> ...
> 
> Partial hugetlb pages do not particularly make sense; wasting memory. Do
> we expect people to actually ave working setup that we might break when
> disallowing such configurations? Or would we actually help them identify
> that something non-sensical is happening?
> 
> When using memory-backend-memfd, we already do get a proper error:
> 
>  ./build/qemu-system-x86_64 -m 2047m -object
> memory-backend-memfd,id=ram-node0,hugetlb=on,size=2047m,reserve=off
> -numa node,nodeid=0,cpus=0,memdev=ram-node0 -S
> qemu-system-x86_64: failed to resize memfd to 2146435072: Invalid argument
> 
> So this only applies to memory-backend-file, where we maybe should fail
> in a similar way?
> 

Yeah, let's fail in that case. But non-aligned length is just one of
many reasons madvise()/mbind() can fail. What about the others? Should
we make them report an error or just a warning?

Michal


