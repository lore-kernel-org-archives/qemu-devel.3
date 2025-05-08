Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE3EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwlH-0002hd-7L; Thu, 08 May 2025 04:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uCwlF-0002hN-3D
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:37:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uCwlC-0000hY-JN
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:37:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22fb33898bbso2298175ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746693461; x=1747298261;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KKBjg0KfK1xBsSW92KZcrdd0nJsWQnOMpHvUQnXJW4o=;
 b=vJxWuUJwGX7igwI3shEA3Ck/pTveTWO6GMDZUG3XdsanfHFhcpM9U+WyZ3FQhFvhEe
 yFce4lNviDrSgH+AIJLH3SZRLv15S+lZaRAIHYFoX/58GH4X0Bs4nb3BBxtAmKYCJ9Np
 myV8C0e5516sD9Leq00RwOXD7X3WzOKH5Q+rcmuhlASGq8oxim+X8shkAWhaWyYjqVLI
 +jBgchchBFHS5gXwOAOIoHyPTf8tuSLeg3ePal+E4avkZ+WTRgcM1j1VGEOUik6BFCnj
 Ki1NIAe9iEKiywYsiQtPuEm3i05gZN9AmvVlUgDhYUM4OIvgBTdJkSEEZv+jFRjyEuCH
 N5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746693461; x=1747298261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKBjg0KfK1xBsSW92KZcrdd0nJsWQnOMpHvUQnXJW4o=;
 b=syrXkzUJyAnylzxTiEso/FDIT6TR0DGzfzExEaJ99PF7ExEfUmFsR/lYquvopf1//6
 C5dKBEvpo5cUmQ5tmy5W/vemWYY0tTMTyOFZNSNZfz8kDcfxeQ50rGzcg9W5Z+0N7lSa
 poYeOzXDGRnx4KAHnObytyJsFdJCibij3068JesVOB4Nzp4tsw/oUpHIDZTAd5i2RIqb
 ICAgtSlzj/JuT53JZKE/g/43oU41VQGFSkkr0gkji5EU2BJsevLBPDXKrzUJxPbexW3j
 WTaYmsGgiiXyc1xaQl3CG3Fm/HTnfViKlfDero0S3j8oRVyuuARVUxQgSatGF5T7g26U
 lMEQ==
X-Gm-Message-State: AOJu0Yzevq0JNyE+MBknXRUV2EjFr+38hWMm6D/4opE7KnxjNYN7gQPq
 V2Bt+i0tlVogjRRoIR2zf7ypuH6SMh872ekikmAWo0zlp5FJ5HzxX3Iq+b7GsDk=
X-Gm-Gg: ASbGncuN2L3FCciJucAIgeIUeOmJyU4WAh1fIMJD0IpPQCGQ1B/GuU+icglCpoZaPgz
 6BHIi/Cve7oZ/2mDTPfokLmLdDdNr5iI5dAMeh7rK6X6q+f+OwdUguM2dMbOvSWORAl0A4f02Ko
 CSHMdbkm86tqS+TE0lVqvFcDjY6qMaJER6u6USehGVSGBOMEXX+JIMQxFu8sORMErRla3PdbPbm
 omdcnC+i5zeV7F783oRD/Ci97kCe8bPIADZKFZP5r2c8mOqVVXGvuEF5t9qmmQJOIz/JoutXT8H
 XV+zTZ0VX5BUtfIbPssj4BW25l+4Kk1U4jFVCgfP2p1IpqlUWa8=
X-Google-Smtp-Source: AGHT+IHsDHwVelASjO1XWFYiZGLgmttX06RCgxVCP8Uji4ecUpUhtjUb41ybwOPYhOHZKBaddi2UyA==
X-Received: by 2002:a17:903:46d0:b0:22f:a1b4:b2b6 with SMTP id
 d9443c01a7336-22fa1b4b588mr27141855ad.52.1746693460783; 
 Thu, 08 May 2025 01:37:40 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150ebfa4sm107737995ad.13.2025.05.08.01.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 01:37:40 -0700 (PDT)
Message-ID: <6af5a9ec-a197-49d8-880f-cdd88621e180@daynix.com>
Date: Thu, 8 May 2025 17:37:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
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
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250502132441.64723-1-philmd@linaro.org>
 <aBnCk2WE_SNkRgSH@redhat.com> <20250506040903-mutt-send-email-mst@kernel.org>
 <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/06 17:55, Philippe Mathieu-Daudé wrote:
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
>          ^^^^^^^^^^^^^
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
It may not be too early as QEMU may already support heterogeneous 
endianness.

An Arm CPU have a register to switch the endianness, which depends on 
the current Exception level, and QEMU already implements it at least 
enough to switch the endianness for virtio if I read the code correctly.

This means QEMU should already be able to handle cases where the 
endianness changes depending on:
- timing (due to writes to SCLR or switches among Exception levels) or
- vCPUs (as each vCPU has its own register instance).

If virtio has a problem with heterogeneous endianness, I'm afraid that 
it matters even now for Arm emulation.

In my understanding, the virtio code is written carefully enough to 
avoid breaking migration and I found no other obvious problems like 
crashes and memory leaks with heterogeneous endianness, so I can 
conclude that the virtio code requires no change.

However, allowing to have legacy devices with heterogeneous endianness 
may still lead to mismatches between QEMU and user's expectations as the 
spec is not clear. Deprecating the combination of legacy devices with 
CPUs that can switch endianness (and other heterogeneous endianness 
scenarios in the future) may be a good idea to avoid that.

Regards,
Akihiko Odaki

