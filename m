Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081B5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7TB7-0000Hr-NW; Thu, 16 May 2024 00:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7TB4-0000HG-Oi
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:57:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7TB3-0001RN-12
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:57:14 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso5695072a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715835430; x=1716440230;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5uLWPEV2IQz01J7RrmpN2F9RySoifu2n8RUPk6jWRps=;
 b=yB9U+7xTdcYYtkmgtSMqYDVgCx01HHi613g4lhvFnRTqGlHd2cQGRYpEHjwkrk0IBK
 zrKDAbdsn/3/6hjycCEX1jDnIfGJH5dj8IyDGuMSRE+GpeC7KQx0jtlSp3f+hlneez+u
 B7vhleY7bX5ceOUFs8ve/9VFxA7TpBs7JJrcY/jUYazv+q0w0feBF3R1jEzeV2r9EHz2
 gMiqk9IFs0C9L/gj1n6p09AKk5XyipYZ/omGlxvMeazWLXUYOZmQBVQiSfZ3jKlSrDwC
 9/MpKhOxv1xqNw966JPikre0u31jPJP6CO6TBMloyrOjK6a3Lf/zDrggsOi0OxQhJ5Sb
 i1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715835430; x=1716440230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5uLWPEV2IQz01J7RrmpN2F9RySoifu2n8RUPk6jWRps=;
 b=U0jRouo/m0r28LrbXT48UW79ksEhwx/GnbZUCz8lLJwe2/6opTJgNM+N8PsMfCEf7b
 ctLAJ711TK36XDakno7kQdARd40gtHdinfFv/aMtSVoReoGkThLShToJcN+3gmj21D8o
 Z6BcoA93ErI0UC+ONRIj7I3/OwBa7gtOMktJm55E9NfETcFGrrlNswGEcfGFl4cxfn0e
 f8hBgVcOPVX/sEOARs48c9oiYA4oE5PBOz8sKPWzJNpo53wFMOlQGVDVu9pmPqQ2ID4d
 70vU/EgrjFnbTdBZ8QVWI5yKPH6G9M4R4cqe2o2UdA4Kfj8pk3r97/fkF30Xrmq9TJGQ
 x9SA==
X-Gm-Message-State: AOJu0YwBZdiKucq7NSjNdpsg3v1REUCMhin33A5NEElQDjgS52RcV6SC
 XBTg2Pkea0VwO5n5iSTAXz2WfXg4WByAcuMN4BIhZ9QQmwy2mVDLM0RZje652rw=
X-Google-Smtp-Source: AGHT+IGsqGDNQsLH4qGrK+nTvAWbkt+AA4FILAJhcyVAh8z7ZyJFkliVfAl4sFtQeWO/SAAOmJB9BA==
X-Received: by 2002:a17:90a:658a:b0:2a5:e087:768a with SMTP id
 98e67ed59e1d1-2b6cc87ab65mr19022528a91.29.1715835430516; 
 Wed, 15 May 2024 21:57:10 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a83sm14595368a91.56.2024.05.15.21.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 21:57:10 -0700 (PDT)
Message-ID: <b97c44ce-5f4d-4ff4-b981-e0a67e522b2e@daynix.com>
Date: Thu, 16 May 2024 13:57:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/10] virtio-gpu: Handle resource blob commands
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
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
 <20240511182251.1442078-9-dmitry.osipenko@collabora.com>
 <727b125a-530e-4881-bde0-2215f62e155d@daynix.com>
 <4b30a810-211a-4ef6-ac28-c144615b402c@collabora.com>
 <58dfa1ce-320c-468e-9aed-fe1b092b92f8@daynix.com>
 <9c9e174d-079c-4186-8b01-95549167852c@collabora.com>
 <5b20d3dd-1749-45ba-baa7-a8c21d79f839@daynix.com>
 <8b26ac10-40b3-4654-8123-ce07e9dff9d9@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8b26ac10-40b3-4654-8123-ce07e9dff9d9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
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

On 2024/05/16 2:15, Dmitry Osipenko wrote:
> On 5/15/24 20:04, Akihiko Odaki wrote:
>>>
>>
>> VIRTIO_GPU_CMD_RESOURCE_UNREF should also call
>> virtio_gpu_virgl_async_unmap_resource_blob(). I guess that's the
>> original intention of having a function for this instead of inlining the
>> content of this function to virgl_cmd_resource_unmap_blob().
> 
> Correct, previous patchset versions unmapped resource on unref.
> 
> In v11 I dropped unmapping from unref to avoid adding additional
> `async_unmap_in_progress` flag because normally map/unmap will be
> balanced by guest anyways.
> 
> The virtio-gpu spec doesn't tell that resource have to be implicitly
> unmapped on unref. In a case of Linux guest, it actually will be a bug
> to unref a mapped resource because guest will continue to map and use
> the destroyed resource.
> 

Additional `async_unmap_in_progress` flag should not be necessary as 
explained earlier.

It is a valid design not to issue UNMAP_BLOB before UNREF if the 
automatically performs the unmapping operation. A guest needs to ensure 
the blob is not mapped in a guest userspace virtual address space, but 
it does not require issuing UNMAP_BLOB, which is to unmap the blob from 
the guest physical address space.

In case of Linux, virtio_gpu_vram_free() calls virtio_gpu_cmd_unmap() to 
issue UNMAP_BLOB before UNREF, which is actually not necessary. Linux 
still needs to ensure that the blob is not mapped in a guest userspace 
virtual address space, but that is done before virtio_gpu_vram_free() 
gets called, and virtio_gpu_cmd_unmap() has nothing to do with that.

It is still a good practice for a guest to issue UNMAP_BLOB in such a 
case because the spec does not say the VMM will automatically unmap the 
blob for UNREF, and that's what Linux does. From the VMM perspective, 
it's better to perform the unmapping operation for UNREF because the 
spec does not say the guest always issue UNMAP_BLOB before UNREF.

