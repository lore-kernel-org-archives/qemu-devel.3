Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AF3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nPu-0005dy-AM; Fri, 03 May 2024 03:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s2nPc-0005cO-5c
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:33:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s2nPZ-0003SX-7t
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:32:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so6498713a12.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714721571; x=1715326371;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9oHmSIa0ypJO8k9qV/cqecmO1VQfrkWrGhPP0XWaPuI=;
 b=EhsIzFErYnZzX+DlzMr85VnocCxFt3SRDzjwb2hhorFfavioTLbRtnrJtsJA4POMaK
 pt3NZ0/wxZeS33+KBQC6oIcDr5EssDf0WlR+xk2rVSYp0RzLEdeS0NdGUHXykWGmRi7x
 HtnvgYkaZH2ofaaTZoB1DCTNXRTikr1wPa1qOdz1xmIK7txWbvoY6hi/r1nV/3FQohLP
 OL4Uu2M3q44OL9CSRzySOXe31QBYDbR8xBDrkUZowvANPNyZN3fugmtX6dPatmb5aio2
 6CdE1Wr6cb6BYU1GNYTnFu5PyZAKM08qHqdqCy4kZBxR3ICX+Tt/ykxv1VcqfL++Q4n8
 f4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721571; x=1715326371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9oHmSIa0ypJO8k9qV/cqecmO1VQfrkWrGhPP0XWaPuI=;
 b=eMYEO54x3opKuQyDHpu7IlEUvqKm1VU4vPtpjVWLtIcKo5WRuRm7kQa77nG2BJ5/JK
 JWNBqSd6hRYZ3mUixCXjjVcnPxzWZO+xiqGzj5PVqLg4aWnCUw09OCmY5d6L6gRsgECD
 3/LRvPYYkbr5GUhhmvCZS8QjDahwoHzwKM2ODwC/DDmVzqGl38TSCUeCdskM/0DwSzqF
 +cNggUewNCjIHDPknwT2LElHemtNTuI2cqtFSQR8SSRebMdMpCoFHT54fm2MvHZbOS9C
 7wm0qIyM1xFRyvEMnufKgfRMeBgPB4lEGjoBCHObc0D2e3RXOqDZf2udeDsq6Byq9zK+
 Pwgw==
X-Gm-Message-State: AOJu0YydUbBboBVpPIrJXJm8Sy34Ts8OeDHhJ+F07Xd77KgUpOI1NhMK
 J2T+AaHK60rknDRzzAjcJvCw88rxsunO4oct/CnSDgFiaPeex21ZByUxZUveqVk=
X-Google-Smtp-Source: AGHT+IEfGaUciXxwdLaaF1lu3LiEL1vL3YHhirzx/cVM++us2o2tC9KA6zkZ44uRr0Lm4oWHv1EnQQ==
X-Received: by 2002:a05:6a21:830a:b0:1a9:499c:5778 with SMTP id
 oy10-20020a056a21830a00b001a9499c5778mr1700952pzb.35.1714721571044; 
 Fri, 03 May 2024 00:32:51 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a17090a064800b002ae2579ffeesm2704072pje.19.2024.05.03.00.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:32:50 -0700 (PDT)
Message-ID: <e3faaabd-9fed-4b79-ac77-c652ded9bf46@daynix.com>
Date: Fri, 3 May 2024 16:32:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/11] virtio-gpu: Register capsets dynamically
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
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-10-dmitry.osipenko@collabora.com>
 <557f5ddb-4326-48bc-b34e-bda9d51cadcc@daynix.com>
 <490016a8-965b-497b-9c12-5202d135407a@collabora.com>
 <66cd0301-7e92-4c0c-9dfa-fb1a4a13b607@collabora.com>
 <25e07a71-c597-43f9-b800-dde16ecfc358@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <25e07a71-c597-43f9-b800-dde16ecfc358@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
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

On 2024/05/02 4:52, Dmitry Osipenko wrote:
> On 5/1/24 22:38, Dmitry Osipenko wrote:
>> On 5/1/24 22:31, Dmitry Osipenko wrote:
>>> On 4/27/24 10:12, Akihiko Odaki wrote:
>>>>>    int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>>>>>    {
>>>>>        uint32_t capset2_max_ver, capset2_max_size;
>>>>> +
>>>>> +    if (g->capset_ids) {
>>>>
>>>> Move capset_ids initialization to virtio_gpu_virgl_init() to save this
>>>> conditional.
>>>
>>> Capsets are used before virgl is inited. At first guest queries virtio
>>> device features and then enables virgl only if capset is available.
>>> While virgl itself is initialized when first virtio command is
>>> processed. I.e. it's not possible to move to virtio_gpu_virgl_init.
>>
>> Though no, capsets aren't part of device features. I'll move it to
>> virtio_gpu_virgl_init, thanks.
>>
> 
> Number of capsets actually is a part of generic virtio device cfg
> descriptor. Capsets initialization can't be moved without probing
> capsets twice, i.e. not worthwhile.
> 

I see. Then I suggest replacing virtio_gpu_virgl_get_num_capsets() with 
a function that returns GArray of capset IDs. 
virtio_gpu_gl_device_realize() will assign the returned GArray to 
g->capset_ids. virtio_gpu_gl_device_unrealize(), which doesn't exist 
yet, will free g->capset_ids later.

This way, you won't need the conditional, and it will be clear that a 
GArray allocation happens in virtio_gpu_gl_device_realize() and is 
matched with the deallocation in virtio_gpu_gl_device_unrealize().

