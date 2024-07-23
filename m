Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54D0C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDLs-0002GE-4V; Tue, 23 Jul 2024 07:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWDLp-0001n2-Ut
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWDLn-0004S6-O5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOAq5zkHxaGlh/Z/41MZ39P9om+dFtrMCfFrF2bmocc=;
 b=BmRsywi78S34WXCYgltLX/VvyEoRTWq2xCPYISQEHKmLJmCvbV7ZNWquw5SDkypATVyWyg
 YuZaGbe70zw6fhtoKIVBtMNtTk3O1AYWyvl5HoUbiNZXzxigzi3xfUx+p/ntV8zc/Xy/WG
 DLGcCzjRmTpP1dQHogBTwv72T1PORKs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-eHXChOdbNd6-er7SLwXSag-1; Tue, 23 Jul 2024 07:06:32 -0400
X-MC-Unique: eHXChOdbNd6-er7SLwXSag-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3679ab94cdbso2870775f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732791; x=1722337591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOAq5zkHxaGlh/Z/41MZ39P9om+dFtrMCfFrF2bmocc=;
 b=AzzqDal1XeqEp5vxsAu9EwgVG4wMb7YyBruwo9ke2IX8BbKpe4JUwIBEezywldeITF
 dMEL19YIg8zD1AVmAk051HqKx4WpFjdhT+nYYcj1JHHlJK4NCZ1SKxQpXGSqZni/QF/q
 Fi0o2l+r9NkZCDM35St7J1E5c1W1upbAZqh+a74lJqcx9sUqkJ3drrg8UbonHSegjRxR
 Pvq+MT98TbBdfZc24k2zioJE9XGw96tkqSyJJR3acaogQf4WgjZnWmRUzIExwmrpNRZN
 /1F1eRCUEYJaQczUBmhT7ATKKjqPXH/BULHqjGEADA4aR0hDubucVu3g6mX5+9QDoUwe
 HeUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMOKdqcNF53Ri6aH23LYB6L+w9687Nep+scD3HD6vZOQNILzkODTr7Xa1V2Sa/HOpQqlRIY58pMreq2dgt8ef3JwsWuhk=
X-Gm-Message-State: AOJu0YwjbOalawFx2lirFmLEZ3lAqayPdJjFVS0ncVXvV/joS1IyJh2Y
 hdNi4M24Dr0c/xAYq9HF43xxv9espTpkx16kt5kz5zcrHqX6A2NvfEA8EiNCpowenygkTMDtZ0q
 sA47kM6p7Z+XWTfino1XwAldOjiJojPS/edfCjj3lmEH3Bt3BsHls
X-Received: by 2002:a05:6000:1283:b0:368:3b83:65be with SMTP id
 ffacd0b85a97d-369bae3585amr6025961f8f.26.1721732791344; 
 Tue, 23 Jul 2024 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHi4xI+jVX3YLD584Qjr/tIQouYsJ+mk+RikR5RriXcnYwEawy9VdttrlWZzs7lPO+QRdOCA==
X-Received: by 2002:a05:6000:1283:b0:368:3b83:65be with SMTP id
 ffacd0b85a97d-369bae3585amr6025921f8f.26.1721732790426; 
 Tue, 23 Jul 2024 04:06:30 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd0:4af1:f18b:763c:5dac?
 (p200300cfd74b1cd04af1f18b763c5dac.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd0:4af1:f18b:763c:5dac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eba8csm11263181f8f.91.2024.07.23.04.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 04:06:29 -0700 (PDT)
Message-ID: <322e0561-dd22-43c2-8754-6d1a13fcd03e@redhat.com>
Date: Tue, 23 Jul 2024 13:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1721607331.git.mst@redhat.com>
 <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
 <27fce655-4345-4ee7-af0a-0f11bde7074d@redhat.com>
 <20240723064525-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240723064525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On 23.07.24 12:45, Michael S. Tsirkin wrote:
> On Tue, Jul 23, 2024 at 12:18:48PM +0200, Hanna Czenczek wrote:
>> On 22.07.24 23:32, Richard Henderson wrote:
>>> On 7/22/24 10:16, Michael S. Tsirkin wrote:
>>>> A couple of fixes are outstanding, will merge later.
>>>>
>>>>
>>>> The following changes since commit
>>>> a87a7c449e532130d4fa8faa391ff7e1f04ed660:
>>>>
>>>>     Merge tag 'pull-loongarch-20240719'
>>>> ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28
>>>> +1000)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git
>>>> tags/for_upstream
>>>>
>>>> for you to fetch changes up to 67d834362c55d6fca6504975bc34755606f17cf2:
>>>>
>>>>     virtio: Always reset vhost devices (2024-07-21 14:45:56 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> virtio,pci,pc: features,fixes
>>>>
>>>> pci: Initial support for SPDM Responders
>>>> cxl: Add support for scan media, feature commands, device patrol scrub
>>>>       control, DDR5 ECS control, firmware updates
>>>> virtio: in-order support
>>>> virtio-net: support for SR-IOV emulation (note: known issues on s390,
>>>>                                             might get reverted if not
>>>> fixed)
>>>> smbios: memory device size is now configurable per Machine
>>>> cpu: architecture agnostic code to support vCPU Hotplug
>>>>
>>>> Fixes, cleanups all over the place.
>>>>
>>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>> Fails ubsan testing:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/7397450714
>>>
>>> ../publish/hw/net/virtio-net.c:3895:18: runtime error: member access
>>> within null pointer of type 'struct vhost_net'
>> Honestly, I saw this piece of code, but concluded it already doesn’t make
>> sense, so I assumed someone™ who wrote this would know why it’s been written
>> this way, and I should rather not touch it.
>>
>> Specifically, the problem is that get_vhost_net() can return a NULL
>> pointer[1], which is fine, but virtio_net_get_vhost() never checks this.  I
>> assumed this was written with intent (i.e. `(uintptr_t)&net->dev ==
>> (uintptr_t)net`, so that NULL remains NULL), because it’s so obvious that
>> get_vhost_net() can happily return NULL under many circumstances, but maybe
>> not.
>>
>> The same theoretically applies to virtio_crypto_get_vhost(), although I
>> don’t think that can ever be NULL in practice.
>>
>> I’ll re-send the reset patch in a series with two patches that fix those two
>> functions to check for NULL and explicitly return NULL if necessary.  In the
>> meantime, it probably makes sense to drop it from this pull request.
>>
>> Hanna
>>
>> [1] For some reason, it uses integer 0 throughout to signify NULL. That was
>> another reason that put me off touching this.
> drop what specifically?

My patch, "virtio: Always reset vhost devices".

Judging from the CI trace, the problem to me appears to be that not 
making get_vhost() depend on vhost_started lets ubsan find a way to have 
get_vhost_net() return NULL (which I don’t find surprising, that’s why 
we check get_vhost()’s return value for whether it’s NULL).  It then 
complains about the `&net->dev` in virtio_net_get_vhost(), because net 
is NULL, and it’s not entirely clear that `&net->dev == NULL`, too (it 
is, which is why I decided to leave that piece of code be, originally).

So dropping my patch should make CI succeed again.

Hanna


