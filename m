Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F7AC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I3R-0005Gg-Oa; Wed, 15 May 2024 13:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7I3K-00059t-II
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:04:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7I3F-0008Dg-HG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:04:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ec92e355bfso67281935ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715792663; x=1716397463;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t0ro/6LWr3ZV8epNtwDUpaFr6Q0Xy6fB+kD/1HnVOR4=;
 b=zGZRiCo4DZaT3Yv0SBL/jUD4pBShVAf3hEC66ZmDWMTs3ivZ2A3OPTKkxvqkgeoFYo
 9KI22F26Y7fSaodY5Kh+vDKMTgCl60/F1+NXWhIlcgdEArG7rS9SWjrVBdi3I2L2zrHF
 vq7DXCqNEI90sTvIigQU+yq91hekgmhIO1dFlb5WNU7JzTD5/bOfzscjtt+iSnnjrohk
 eLsuEZjcBCNTgfA+OpuZsF25kIhncQBkyD/vAKApLcx2AQGImor9QH8oOusqWK0gqkrN
 iLMSFu6IXlc2oZGY4ljnWuGkNfFaLsd5u5GLE+84nWn0C44wzHNc9JC3fVa8ngqraMyi
 dCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792663; x=1716397463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0ro/6LWr3ZV8epNtwDUpaFr6Q0Xy6fB+kD/1HnVOR4=;
 b=Z0V0ME28nbsrzFVr45xBLQDiNdmjDgBXn7nc7AWYDRhGeiMGgdPIrLBFvCGYqZ56or
 R8TKhphajY+fyAbf1vR2kLjZeD2Y37DJ7qoc1aTU3hm3WKQc2Sw7Fy+Wv0/QBs/j/Tb2
 ns1nZCBfTLdE4mYR78IKJHzBwr8Wo84G7+hIOLhGwYJqWbjkpBdAtNdNZRhLaKdr5Wpb
 yOk9FMdfiOenY1qRu7QhzFLDsld3719WgDwNo7USZnl8RIBTyQ9hIqMedYF7Ipd3vsxN
 IILoibWozoyVfv7R5/qrdTxJxEZt1mjikcskEsVoNPcsznxeySS0aBSa2me9SeKUYkzq
 iQ7A==
X-Gm-Message-State: AOJu0YzInVlK60F71eWoKQ6+7NcIVmxmH6GeuRYtQZdk8qDC9J5ndO2y
 dsSMPR/NFoMN+WsNfRpno/PPSjxCqrOmhrUfvLMnhFTYA41Hj+ZdmxVY90+kDHU=
X-Google-Smtp-Source: AGHT+IFRLBX8LHV68F1X/Q0Yxhum0IuDYjpNNg7lnW3mUx8hh2pv8lssFGfJG4P37hGSYlELiWlUEg==
X-Received: by 2002:a17:90a:f98e:b0:2b4:33cd:173c with SMTP id
 98e67ed59e1d1-2b6ccd8612emr15404681a91.42.1715792663573; 
 Wed, 15 May 2024 10:04:23 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62863a1besm14021589a91.9.2024.05.15.10.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 10:04:23 -0700 (PDT)
Message-ID: <5b20d3dd-1749-45ba-baa7-a8c21d79f839@daynix.com>
Date: Thu, 16 May 2024 02:04:17 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <9c9e174d-079c-4186-8b01-95549167852c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2024/05/16 2:01, Dmitry Osipenko wrote:
> On 5/15/24 19:42, Akihiko Odaki wrote:
>>>> It may be better to actually implement unmapping instead of returning an
>>>> error for consistency with the iov operation. Apparently crosvm also
>>>> unmaps blobs with VIRTIO_GPU_CMD_RESOURCE_UNREF.
>>>
>>> Then I'll add back `async_unmap_in_progress` because resource can be
>>> both mapped/unmapped on unref, and we'll need flag to know whether async
>>> unmapping has been finished to do the final unmapping of the resource.
>>
>> Such a situation should be already handled since unmapping in progress
>> blocks all commands (not just VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB but
>> literally all, including VIRTIO_GPU_CMD_RESOURCE_UNREF).
> 
> The async unmapping consists of 3 parts:
> 
> 1. begin async unmapping with memory_region_del_subregion() and suspend
> 2. wait for res->mr to be freed and resume
> 3. finish the unmapping with final virgl_renderer_resource_unmap()
> 
> Parts 1 and 3 are handled by  virtio_gpu_virgl_async_unmap_resource_blob()
> 
> 
> The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB is different because we know that
> blob is mapped in the first place. Hence we can safely perform the part
> 3, assuming that parts 1/2 has been completed.
> 
> In case of VIRTIO_GPU_CMD_RESOURCE_UNREF, blob can be unmapped in the
> first place and we can't do the part 3 because it will error out for
> unmapped resource since parts 1/2 were not performed.
> 

VIRTIO_GPU_CMD_RESOURCE_UNREF should also call 
virtio_gpu_virgl_async_unmap_resource_blob(). I guess that's the 
original intention of having a function for this instead of inlining the 
content of this function to virgl_cmd_resource_unmap_blob().

