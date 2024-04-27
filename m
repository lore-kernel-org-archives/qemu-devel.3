Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6989C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 05:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0az2-0001dL-IK; Sat, 27 Apr 2024 01:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0ayv-0001bP-H5
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 01:52:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0ayu-0001No-38
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 01:52:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e5aa82d1f6so25864055ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714197134; x=1714801934;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vLq1Bv8QKTTn0IzD9DiHXcSLN6zW0a/72vO8WPEk6qo=;
 b=Hdw7Sp4o95Sydw5wxc83+3D5KTkU2xz+ixyTP04Mmlnzk81axjv0sDx/ZTnVlvPVDR
 5dQJBkQ5t74Ewsi1drQmR+0sTsnk3frqapEYZZbp8AJNkJZxEjlVG8VX+f2IeW84JDkT
 49edHlqxh5gaesAQf7RZhZ+HfZltv9w+gRmo+eEvbBBAqmHiQj9oNg9FGlsxYiJv9MQS
 ND3EbXMiLz6h0i+ufApkoooeML6kIITVm7yzVCr2VvGCfjVVsTXZZ/Wb9j3zp9ZXOeNu
 cah5x8jQ9qwcOcsiaunn1RcQURrThVtaTdcJRqRKDNPRnoPk1fC7xf3r2o3ZO3CA1tE8
 07sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714197134; x=1714801934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vLq1Bv8QKTTn0IzD9DiHXcSLN6zW0a/72vO8WPEk6qo=;
 b=puaNQrbcyttJoCbsvlvxALaTv2OglvTOlkORNE/XmYHuiMRyaRxC0cM/anhOAy3KBy
 7KRed9AGdSSU7s0ZmGydIBSr099hxKwVhYKurhu4sGB54tamU69JhxbZSulqWKDfzRv7
 coht2HWvKCdgDe416RFO/Qw7SZpMIi3fZh1und5KSb84jtn4l40BZMLficUNimaeKU2S
 LA6UibyROjTixSmWJrRu23tU/MWo4c33XBjB8XLtg44PBK5rGFQlIoW/4/lFsrcpkiBx
 bn7OBBMpTzQqHqAKbWcNrHpWkr9clcIysKzPtq+jxUjj7pFjRdBo5e/heoZt7WuJoY9N
 zOBA==
X-Gm-Message-State: AOJu0YzaYYrgKBG2Ya6jVLWOrihW+u0vDmCB/49pDbsImsZKuewwgC9h
 YwN9caF1E8IymU3C5O7+uQtGjTBmsjiGyqaqNjURY4QzIF8flYGK7KFUuXUdK0I=
X-Google-Smtp-Source: AGHT+IEh2cFMoC+47ukQc0OdGSXcVxnQZYpYNRqmToxVQ0Pi65+l2qcgjv2U4IYVaZgdEDha5atGCg==
X-Received: by 2002:a17:903:2312:b0:1ea:964f:9b0b with SMTP id
 d18-20020a170903231200b001ea964f9b0bmr2750475plh.5.1714197134484; 
 Fri, 26 Apr 2024 22:52:14 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a170902dac600b001eb03a2bb0asm2193608plx.53.2024.04.26.22.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 22:52:14 -0700 (PDT)
Message-ID: <a0808d93-fb2c-4663-bd5b-8ae06e813492@daynix.com>
Date: Sat, 27 Apr 2024 14:52:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/11] virtio-gpu: Handle resource blob commands
Content-Language: en-US
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <51b45c53-b7d3-4f3c-984c-44a94e6cf5af@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2024/04/24 19:30, Dmitry Osipenko wrote:
> On 4/19/24 12:18, Akihiko Odaki wrote:
>>> @@ -61,6 +61,10 @@ struct virtio_gpu_simple_resource {
>>>        int dmabuf_fd;
>>>        uint8_t *remapped;
>>>    +    MemoryRegion *mr;
>>> +    bool async_unmap_completed;
>>> +    bool async_unmap_in_progress;
>>> +
>>
>> Don't add fields to virtio_gpu_simple_resource but instead create a
>> struct that embeds virtio_gpu_simple_resource in virtio-gpu-virgl.c.
> 
> Please give a justification. I'd rather rename
> virtio_gpu_simple_resource s/_simple//. Simple resource already supports
> blob and the added fields are directly related to the blob. Don't see
> why another struct is needed.
> 

Because mapping is only implemented in virtio-gpu-gl while blob itself 
is implemented also in virtio-gpu.

