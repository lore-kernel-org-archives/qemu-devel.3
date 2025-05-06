Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF021C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCK3u-0004Kb-T9; Tue, 06 May 2025 11:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCK3p-0004IE-4S
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:18:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCK3l-0000fF-5m
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:18:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-309f3bf23b8so7627100a91.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746544695; x=1747149495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1qF/4YkbvVkMAeOW3oJDj8///733KHf3pnFEtujLnXQ=;
 b=tfam9Xn7blyqUI3CFSzSS8G/tOzOQZGdTeVhd2a35XnDJOgE4l882xJmX9nImOjPFN
 qhlR+nXcga4qeOTvSj9IT2lTD9wbtVP4x90dUhcgmUs96Wd3aquYXJV/XgOXfhOjNq75
 sPh8Uv8vx6qRnL/euENsmNCDBnNvirDXQsdGsi6SnEY7qEByeexb6qw5LtuONmJz6Y1s
 h1Gbkk1gdddJShIsCb+uVxKVUAapDkwPy3yzAmyb8V4ALR1axOSgXw+Th5EcbtU5aNfz
 6ai3xq08nh0AEJGenp0969KjHeUG6371aipblDF5V3vpVaGxDdg0rRW3WMaXHmYji/u0
 tMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746544695; x=1747149495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qF/4YkbvVkMAeOW3oJDj8///733KHf3pnFEtujLnXQ=;
 b=OV+2PTQ7KD19ZPyVgZXL//RXxPxWrTdNvnuR1KXXOwDMXnLN3rKJGrX1/ID5JE0KeU
 bRi4T3OyNZQhZljpYVs+sy7P9Axf0Kfv1ZDI2W5izzAsau4z8KDEYJI+7arX63D5RNNb
 xffIcvI8qbrXNZAyZQF7bqBI6OZdIYr/2m8wyIYqGsQ/PsskNqSh7spWISQXpaz12B+U
 LQ+n1HsUKPC5HoKuKbZr08xKOn/nnJdT8X85R8Xxy0f5hXyQOi10fCJCGI2/7j7AUwQ8
 nw4UDBShXscBajy93Y7uppw72bYzBFYQKeNo5+2pnotgZlG/QQtN39vRF7VO2vMQnCfr
 mRXA==
X-Gm-Message-State: AOJu0Yyv5URRyXFSYgolQYctLskjxPCQ8w8MribWDJCbJYOVyKqkvDgT
 jqA5pSsCnnCeVYqOWtkmhopQhMCvYvLru2AliGkveUVyIHpzBZ70M0MqsaCZCdI=
X-Gm-Gg: ASbGnctZtxWGRXrU/IWwgI2Hh2gOMrXnGHxrXuBssM8W1HH9PhxegODRdIZWz3JtsOM
 /kgvCAn4dTShMRhrdUm/0UojLwdK2YBx3JgycCGm1gujyt1aM1uy3REh1wXSfid74WZsgxXht7S
 5XgUMgDqWoQtJT7Qfk7prZTY+o7WjG/2XBugHSDq1ob+uDE9nUr+ifUh/PI5s91DpUDi8Y/r/yK
 zYJAG5rPRuP2v2RN6jf5nyXwIKxOaCvzUJxedpuN53G7RYjIjjwCP80mTEykVSY3VkRlHZtkGX/
 i69mrQkB5ODco4jLtCF/DXBTorA1a/XeqQnP/ni5MBeqzM1efeaQHg==
X-Google-Smtp-Source: AGHT+IFbZgWlItvlCQJY29igBTXBxQcw6cM2Sh4oq9nefMxNskd0xAMkyiBgfMB7th/i82gB1NzxHQ==
X-Received: by 2002:a17:90b:274e:b0:2ff:6af3:b5fa with SMTP id
 98e67ed59e1d1-30a7c0c8b6amr4786488a91.22.1746544695224; 
 Tue, 06 May 2025 08:18:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522f907sm74943835ad.219.2025.05.06.08.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 08:18:14 -0700 (PDT)
Message-ID: <0c753bdf-996f-4f1d-9fed-cc0ebfc6418b@linaro.org>
Date: Tue, 6 May 2025 08:18:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250502132441.64723-1-philmd@linaro.org>
 <aBnCk2WE_SNkRgSH@redhat.com> <20250506040903-mutt-send-email-mst@kernel.org>
 <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/6/25 1:55 AM, Philippe Mathieu-Daudé wrote:
> On 6/5/25 10:12, Michael S. Tsirkin wrote:
>> On Tue, May 06, 2025 at 09:04:50AM +0100, Daniel P. Berrangé wrote:
>>> On Fri, May 02, 2025 at 03:24:41PM +0200, Philippe Mathieu-Daudé wrote:
>>>> Legacy VirtIO devices don't have their endianness clearly defined.
>>>> QEMU infers it taking the endianness of the (target) binary, or,
>>>> when a target support switching endianness at runtime, taking the
>>>> endianness of the vCPU accessing the device.
>>>>
>>>> Devices modelling shouldn't really change depending on a property
>>>> of a CPU accessing it.
>>>>
>>>> For heterogeneous systems, it is simpler to break such dev <-> cpu
> 
>           ^^^^^^^^^^^^^
> 
>>>> dependency, only allowing generic device models, with no knowledge
>>>> of CPU (or DMA controller) accesses.
>>>>
>>>> Therefore we introduce the VIRTIO_LEGACY Kconfig key. We keep the
>>>> current default (enabled).
>>>> New binaries can set CONFIG_VIRTIO_LEGACY=n to restrict models to
>>>> the VirtIO version 1 spec.
>>>
>>> IMHO that isn't acceptable. In order to be able to provide an
>>> upgrade path from the old binaries, we need the need the new
>>> binaries to be able to serve the same use cases & disabling
>>> virtio 0.9 support prevents that.
> 
> This isn't for the single binary effort, there we are taking a
> lot of care to not introduce any change.
> 
> This is for after it; once we have a single binary (one architecture
> run by an instance) we can start testing heterogeneous emulation
> (different architectures in the same instance).
> 
>>> I don't see a compelling
>>> technical reason why we can't support virtio 0.9 from this
>>> endian point.
> 
> VirtIO 0.9 needs knowledge of the vCPU architecture to get its
> endianness. So we need to somehow propagate that at creation
> time, guarantying which vCPU (or set of vCPUs) will access a
> virtio device.
> 
> The use case I'd like to figure out is how should we model
> plugging a virtio 0.9 device in into a fully emulated
> ZynqMP machine, which has little-endian ARM cores and big
> endian MicroBlaze cores.
> 

Virtio devices are not the only one who will need to be extended to 
support such a scenario.
What happens when a disk or network card is added to the machine?
Should it be shared?
Should it be mapped only for one cpu address space?
Should address spaces be mixed or independent?
Per cluster, per cpu, per architure?

Having a concrete prototype will allow us to answer to those questions, 
and many others, and find solutions for the situations we meet.

> Alex said this is unlikely to happen, and better is to
> ignore this case by not allowing virtio pre-1.0 devices in
> our future heterogeneous emulator.
> 
> In this same thread Pierrick pointed me to the reference in
> the spec: '2.4.3 Legacy Interfaces: A Note on Virtqueue Endianness',
> "It is assumed that the host is already aware of the guest endian."
> 
> I suppose this means a pre-1.0 virtio device expect to be used by
> a single guest OS, but it is not clear the guest OS as fixed
> endianness, because the code path checks vCPU endianness at
> runtime, so passing guest endianness as a property to pre-1.0
> devices isn't really an option.
> 
> Anyway I think 1/ I posted this too early, "speculating" as Pierrick
> noticed, and confuse the community w.r.t. "single binary" and
> 2/ I don' t understand legacy virtio and its endianness handling
> enough to figure a clever idea to keep using it heterogeneous
> setup, so I'll let this task to someone more familiar with that tech.
>

An important mantra will be to keep that compatible with existing 
command line (potentially extending it to support those new use cases, 
in both the existing *and* the new binary).

The last thing we want to introduce is "yet another QEMU".

>>> Yes may be more ugly/messy than we would like, but that's par
>>> for the course with QEMU emulating arbitrary device models.
>>> If the new binaries can't cope with messy devices then I think
>>> we are doing something wrong.
> 
>>
>> To be more specific, having a kconfig knob modifying the device
>> without regards for machine types, means it is no longer
>> enough to inspect the command line to figure out the
>> compatiblity. That's a problem.
>>
> 
> OK. I won't pursue in this direction. I apologize for mentioning
> this topic again too early.
> 
> Regards,
> 
> Phil.


