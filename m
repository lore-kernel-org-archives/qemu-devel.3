Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AABC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 06:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3Ver-0004XJ-2C; Sun, 05 May 2024 02:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s3VeV-0004K4-FM
 for qemu-devel@nongnu.org; Sun, 05 May 2024 02:47:20 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s3VeT-0004YV-EG
 for qemu-devel@nongnu.org; Sun, 05 May 2024 02:47:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c730f599abso587194b6e.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 23:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714891632; x=1715496432;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hEa0NI/QLS8EAks0UyGKcbthlP3DtJ6BCVS3wqFCMA4=;
 b=hfnx0ooZ9qQquY+i1BzfeH437RsjVlQd8o6hSYQ48ltXyqo64KVAkR87R81XbL4104
 HNCaFR7465CQR3I7MrmhIRXx/TmrXwtSv1tADi5D0HPjRscuC++kNkjWXYT584yjnI9Z
 PiSyEEGWnOgpcJWHpUZa4UV8+U9RtRU7RR1Sq5JP9lyH8w5bEJ7CNZY3Px6hlky7WaHQ
 fNRXuHVktBws2QsOgjC2rJDS1SdyM8KM39hyL8x+va0XMxLrli+SWm8u5zLiNoLVyLab
 MwooPbV9qYDQI6UTVKfPO8H6PGiHwgsq/QpzPeIvKfenbCe2AnAyxSK87O2/pf1Mh2gU
 MtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714891632; x=1715496432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hEa0NI/QLS8EAks0UyGKcbthlP3DtJ6BCVS3wqFCMA4=;
 b=ceO5oAksh42mU4nKslHXFNJJRA7dSmSidUOQiK1xG0p2WTvttwCNyUufqD6i+/L38M
 cgAt1sPcyiXhJzkWx+hjOUUbm9vNIcUVwaGGGUHbULW2ymfcnWGwY3LS4FPhqt3tOcLw
 k9WYPfKBfDJJZ/pIfMs/lsdv6UXMkzoD0IXGuaX8Giy+BIR0C8FYWzqy3n0nFO5vPpN+
 /3ql/yvramqy8ZPAJb0vP1k/TuGixi5wkvUz5Dc+Sx0izBeeRePyHnmY1ezI12VI/vq2
 ueNG+qBunQCg67ou3sBLhO4ysAaYsAChQ7UDSk4j3MSp4EAGqQHw0bm4XDUhjUqC30vW
 8N4w==
X-Gm-Message-State: AOJu0YwPV99FMZrFx61khnmF/ZC5ZiUwhGThoxsHx835ZeUtrxgmW9S7
 VAsbj5r2hpSyHBSfkLp4KHlacwMtl1Gh/G0P7uJq2xN8JwYBk/7EIQ8D+2n6eZ8=
X-Google-Smtp-Source: AGHT+IFbi+7tYt7BIdh8O7iF2niehk13bmwouCeqbTUAdlq61HsVkmA4fsGqR3YPsQyMTBGD6cMwrg==
X-Received: by 2002:a05:6808:116:b0:3c8:41ed:8738 with SMTP id
 b22-20020a056808011600b003c841ed8738mr7990109oie.22.1714891632243; 
 Sat, 04 May 2024 23:47:12 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a637017000000b0061c60a12026sm4323072pgc.72.2024.05.04.23.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 May 2024 23:47:11 -0700 (PDT)
Message-ID: <48d03070-6002-4953-aa09-47ae72b8f291@daynix.com>
Date: Sun, 5 May 2024 15:47:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/11] virtio-gpu: Handle resource blob commands
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-9-dmitry.osipenko@collabora.com>
 <2c5a0b2e-58ef-4766-baea-5df98fa6fc2f@daynix.com>
 <51b45c53-b7d3-4f3c-984c-44a94e6cf5af@collabora.com>
 <a0808d93-fb2c-4663-bd5b-8ae06e813492@daynix.com>
 <b4d78255-cc83-482b-a9f6-781c1b795ee9@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b4d78255-cc83-482b-a9f6-781c1b795ee9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/05/02 4:20, Dmitry Osipenko wrote:
> On 4/27/24 08:52, Akihiko Odaki wrote:
>> On 2024/04/24 19:30, Dmitry Osipenko wrote:
>>> On 4/19/24 12:18, Akihiko Odaki wrote:
>>>>> @@ -61,6 +61,10 @@ struct virtio_gpu_simple_resource {
>>>>>         int dmabuf_fd;
>>>>>         uint8_t *remapped;
>>>>>     +    MemoryRegion *mr;
>>>>> +    bool async_unmap_completed;
>>>>> +    bool async_unmap_in_progress;
>>>>> +
>>>>
>>>> Don't add fields to virtio_gpu_simple_resource but instead create a
>>>> struct that embeds virtio_gpu_simple_resource in virtio-gpu-virgl.c.
>>>
>>> Please give a justification. I'd rather rename
>>> virtio_gpu_simple_resource s/_simple//. Simple resource already supports
>>> blob and the added fields are directly related to the blob. Don't see
>>> why another struct is needed.
>>>
>>
>> Because mapping is only implemented in virtio-gpu-gl while blob itself
>> is implemented also in virtio-gpu.
> 
> Rutubaga maps blobs and it should do unmapping blobs asynchronously as
> well, AFAICT.
> 

Right. It makes sense to put mr in struct virtio_gpu_simple_resource in 
preparation for such a situation.

Based on this discussion, I think it is fine to put mr either in struct 
virtio_gpu_simple_resource or a distinct struct. However if you put mr 
in struct virtio_gpu_simple_resource, the logic that manages 
MemoryRegion should also be moved to virtio-gpu.c for consistency.

