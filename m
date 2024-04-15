Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A36C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 08:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwHTW-0007TU-Jo; Mon, 15 Apr 2024 04:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rwHTU-0007NI-0M
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:14:00 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rwHTQ-0002b3-QF
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:13:59 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so2111946a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713168834; x=1713773634;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtRYwOrXP+Ej7wu6fAfZyKuvDln4LeXdfjvzzzWxx7U=;
 b=V4XINGjsN+wkhi/SXUPA+8q5aN7j6MHgILPF5R1dGaPj8tC5Aq9oZnouRuTQoyjhuI
 2HrzlXYODSQE5Pju178UmNq2p5C+9Cn1q/gVoYYgv8xndWg3e9d4Lme0jg4t40/AUfQq
 VM/A6Dw2tjNK7xQiUsaRkFFTo9N6LfW2Mqh+p2sEmKRevjNU2gZSumpgMD9TZcbRrh0Z
 masJkQyDXyBD88fk1kPG19NS9evKEfcvdJ2HOxC+TtvlfftaPv0XqGtLjbLdgyqJgwbX
 w/zao8xG8uBaZLzJ9b2il8EG5o8VbgtI8CIiUG1zX4tchoF3cY4RJEMZDfyXWU2O6yyB
 +y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713168834; x=1713773634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtRYwOrXP+Ej7wu6fAfZyKuvDln4LeXdfjvzzzWxx7U=;
 b=NDjfWt3qd+D9P77Rb69Jx8nCKCXH9jjNPhXmUW82e1cy60d1PIFCqFT/PMR1PFL9Fr
 j0nZzLIkrC//lIjI9xi3UkcrNYhKXIVT6tvI8OtrpLVuqPzhca2ExTxRQwiseu/jLodS
 vGgoHqgRkrdGd07l8oHIc5Cj7qaF9vhtVyeiN8vns6q3Yu6ipW+tmIriI07Nfzj3dp6m
 zEo5w9u+gm3sgKhZvvBQeMhuJ5n95nmms7O/HdpKxarGDqVGrxZ+nqc0WoNzQt/uO9O7
 BE1OyRhHYZjVSGNX0WKlQBJhcoRHOCLthgi/YFi8rqPi6qv04hkn56a9muLFjLIROL8G
 STsg==
X-Gm-Message-State: AOJu0YxNzH70CdJjs2dDnoARucvoMJgtRwUD2rlKnKnlZsF8+Ti/tUeL
 SyTHlyVri41PXs/Hc+CnxcEYk+mAtr7fJR1yQZWxCIfkmAsKZNAFF8dPtB2WIzE=
X-Google-Smtp-Source: AGHT+IGICxO75fUBtzj6usuiRj/1FFQK/eHdJih6vIUC4u2FtEX1/AhqB7kljnKH0BejMjof2OeOAw==
X-Received: by 2002:a05:6a20:de14:b0:1a9:84f6:dcb6 with SMTP id
 kz20-20020a056a20de1400b001a984f6dcb6mr6497949pzb.57.1713168834066; 
 Mon, 15 Apr 2024 01:13:54 -0700 (PDT)
Received: from [157.82.206.17] ([157.82.206.17])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902650e00b001e20be11688sm7468235plk.229.2024.04.15.01.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 01:13:53 -0700 (PDT)
Message-ID: <83e4454f-98d5-4e7d-b8d0-46d3d52442b1@daynix.com>
Date: Mon, 15 Apr 2024 17:13:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] virtio-gpu: Handle resource blob commands
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
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <20240411102002.240536-8-dmitry.osipenko@collabora.com>
 <29a55f63-593e-46d0-8dfe-f55e2b2de7ac@daynix.com>
 <918fb26b-72e9-446a-841b-810eb983dabe@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <918fb26b-72e9-446a-841b-810eb983dabe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

On 2024/04/15 17:03, Dmitry Osipenko wrote:
> Hello,
> 
> On 4/13/24 14:57, Akihiko Odaki wrote:
> ...
>>> +static void
>>> +virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>> +                                     struct
>>> virtio_gpu_simple_resource *res)
>>> +{
>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>> +
>>> +    if (!res->mr) {
>>> +        return;
>>> +    }
>>> +
>>> +    memory_region_set_enabled(res->mr, false);
>>> +    memory_region_del_subregion(&b->hostmem, res->mr);
>>> +
>>> +    /* memory region owns res->mr object and frees it when mr is
>>> released */
>>> +    res->mr = NULL;
>>> +
>>> +    virgl_renderer_resource_unmap(res->resource_id);
>>
>> Hi,
>>
>> First, thanks for keeping working on this.
>>
>> This patch has some changes since the previous version, but it is still
>> vulnerable to the race condition pointed out. The memory region is
>> asynchronously unmapped from the guest address space, but the backing
>> memory on the host address space is unmapped synchronously before that.
>> This results in use-after-free. The whole unmapping operation needs to
>> be implemented in an asynchronous manner.
> 
> Thanks for the clarification! I missed this point from the previous
> discussion.
> 
> Could you please clarify what do you mean by the "asynchronous manner"?
> Virglrenderer API works only in the virtio-gpu-gl context, it can't be
> accessed from other places.
> 
> The memory_region_del_subregion() should remove the region as long as
> nobody references it, isn't it? On Linux guest nobody should reference
> hostmem regions besides virtio-gpu device on the unmap, don't know about
> other guests.
> 
> We can claim it a guest's fault if MR lives after the deletion and in
> that case exit Qemu with a noisy error msg or leak resource. WDYT?
> 

We need to be prepared for a faulty guest for reliability and security 
as they are common goals of virtualization, and it is nice to have them 
after all.

You need to call virgl_renderer_resource_unmap() after the MR actually 
gets freed. The virtio-gpu-gl context is just a context with BQL so it 
is fine to call virgl functions in most places.

Also the command response must be delayed in a similar manner. Currently 
virtio_gpu_virgl_process_cmd() synchronously returns command responses 
so this needs to be changed.

Regards,
Akihiko Odaki

