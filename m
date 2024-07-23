Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C975EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCbh-0005lK-Sk; Tue, 23 Jul 2024 06:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWCbg-0005hH-R1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWCbe-0001Y1-JL
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721729933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAdywfXvB7Yf5F9ng0zS6j4eosox2Jre9FZYRcCdNsY=;
 b=d2utr6kwGkUJcAy6HJBpPkRMZ/C+WgATAIOgxuvt3qyCtM3BW0+rILEqpc6Ngxk8mWgbGC
 vwUtI0YQBoe1x3OX5I4JR6TWvJt+5km0KxDsxr+oo4XV3m8pTfzJ2Lu5Z9pgZEOM4/wKQh
 pj6hStizGYRXd+dGmkV7lYXKOTojL5E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-cgo9yHddPOyDiccLSChnEQ-1; Tue, 23 Jul 2024 06:18:52 -0400
X-MC-Unique: cgo9yHddPOyDiccLSChnEQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36841edbc32so2662662f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729931; x=1722334731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BAdywfXvB7Yf5F9ng0zS6j4eosox2Jre9FZYRcCdNsY=;
 b=aCf77ytpNDvf1sX7hXhGQXkLE4457YTD98RmDQmYrrSmndl21NMSGytJvJSp6zJum3
 ndZzUFQZTqEp0XW6Oe0x2O2zKfvsIysA5mTr1myQKwJGvG7ZMz5MGMq0DsFZhq/qSZZr
 M/qCw8pch4Ygacm/oDUilwZzbrnECCuOnePQYKMc+5iGES6YVZtxmI5STa/1mecqbcJ/
 EY/6oQcDcgcEdZayJshgvZk46wqC6fOEZFzCoilfq2CNym77+IsWnp4D8Qt6/s6gIbAC
 JZxmO0nReU1wwGKSGypzN/oPF+ENLHfckXMX3TjaOYrCprsYy0ym5tNZEii+nQztmMlu
 TyQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Pwyb0jmHgbd0wTzFwP5Apj39u/gtaevtD9TgvwimF6P/SA7G0JgHj2TXg3PCBR1SYmTXC3mfb6izI+0CL2k93kklLrQ=
X-Gm-Message-State: AOJu0YzQP/cUwOeOR8gnhJIFCLEOXsch+41tYsLAic/GDLR9ax4hw1I4
 4TxaPZjpzEYz4Ng3v5nzrebtpbPak/P7/Z+gbcgD3XIM1wz2kM4eBTjoUxlx/aGw5fDuhwe248J
 oWK5gOOwEm/vwGAXfvY6wOePvQGDI8ftxCTKhZdffv/pM8kge3fNi
X-Received: by 2002:a5d:4648:0:b0:368:7a18:908c with SMTP id
 ffacd0b85a97d-369bb2ba939mr5777075f8f.51.1721729930751; 
 Tue, 23 Jul 2024 03:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHcZ65mfsclAcg2RccnCYVMBiE4AcPHmYjERbLnX1K+0JER7JlQsHACT+UQJ4S3HFAMkKmAQ==
X-Received: by 2002:a5d:4648:0:b0:368:7a18:908c with SMTP id
 ffacd0b85a97d-369bb2ba939mr5777058f8f.51.1721729930079; 
 Tue, 23 Jul 2024 03:18:50 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd0:4af1:f18b:763c:5dac?
 (p200300cfd74b1cd04af1f18b763c5dac.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd0:4af1:f18b:763c:5dac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-369b76fbf2asm9047088f8f.60.2024.07.23.03.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 03:18:49 -0700 (PDT)
Message-ID: <27fce655-4345-4ee7-af0a-0f11bde7074d@redhat.com>
Date: Tue, 23 Jul 2024 12:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
To: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1721607331.git.mst@redhat.com>
 <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22.07.24 23:32, Richard Henderson wrote:
> On 7/22/24 10:16, Michael S. Tsirkin wrote:
>> A couple of fixes are outstanding, will merge later.
>>
>>
>> The following changes since commit 
>> a87a7c449e532130d4fa8faa391ff7e1f04ed660:
>>
>>    Merge tag 'pull-loongarch-20240719' 
>> ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 
>> +1000)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git 
>> tags/for_upstream
>>
>> for you to fetch changes up to 67d834362c55d6fca6504975bc34755606f17cf2:
>>
>>    virtio: Always reset vhost devices (2024-07-21 14:45:56 -0400)
>>
>> ----------------------------------------------------------------
>> virtio,pci,pc: features,fixes
>>
>> pci: Initial support for SPDM Responders
>> cxl: Add support for scan media, feature commands, device patrol scrub
>>      control, DDR5 ECS control, firmware updates
>> virtio: in-order support
>> virtio-net: support for SR-IOV emulation (note: known issues on s390,
>>                                            might get reverted if not 
>> fixed)
>> smbios: memory device size is now configurable per Machine
>> cpu: architecture agnostic code to support vCPU Hotplug
>>
>> Fixes, cleanups all over the place.
>>
>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>
> Fails ubsan testing:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7397450714
>
> ../publish/hw/net/virtio-net.c:3895:18: runtime error: member access 
> within null pointer of type 'struct vhost_net'

Honestly, I saw this piece of code, but concluded it already doesn’t 
make sense, so I assumed someone™ who wrote this would know why it’s 
been written this way, and I should rather not touch it.

Specifically, the problem is that get_vhost_net() can return a NULL 
pointer[1], which is fine, but virtio_net_get_vhost() never checks 
this.  I assumed this was written with intent (i.e. 
`(uintptr_t)&net->dev == (uintptr_t)net`, so that NULL remains NULL), 
because it’s so obvious that get_vhost_net() can happily return NULL 
under many circumstances, but maybe not.

The same theoretically applies to virtio_crypto_get_vhost(), although I 
don’t think that can ever be NULL in practice.

I’ll re-send the reset patch in a series with two patches that fix those 
two functions to check for NULL and explicitly return NULL if 
necessary.  In the meantime, it probably makes sense to drop it from 
this pull request.

Hanna

[1] For some reason, it uses integer 0 throughout to signify NULL. That 
was another reason that put me off touching this.


