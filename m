Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC62C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Hi0-000449-VR; Wed, 15 May 2024 12:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7Hhu-00042E-B3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:42:23 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7Hhr-0007fU-LB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:42:21 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-60585faa69fso4652719a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715791337; x=1716396137;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/skGmjREr8cq2MjI7eT9WfrQC6NCr+5tS1XnTq9kleI=;
 b=3GIsUzyGsQp3f6y2f1rLsZpSxUUfiJaCHnh1kC0Zz1KWJ+BwtzX8vkwSpHVBNdVOhS
 8vB+STJfTiz27txt9GWWSen6i0vh8HYt++7fcu3UhdenAzIWW+iRWloQnQGbsPOC+FT7
 T620h+vPq2PiIL1SWFknyh+F1SiIbtMoV0mTt0ptBfLFGa1sWdX6d6vlRSagynwx5t2T
 VDRxql/zT2FtX+Ml407mOQGc0VOQT4+U3mAzn7U6SF+AqDSYBaFKJumI1L60Xf/fUwcO
 nuJxh2c59WNtH1dXvrW3H3LzJWrCZZdfsJr9CGQ12e5TYa4E+tgOgGTpioHXPXrXtgIC
 s2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715791337; x=1716396137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/skGmjREr8cq2MjI7eT9WfrQC6NCr+5tS1XnTq9kleI=;
 b=O33AqrDvKjoUALjKhMNDxHTYAa1hhwxFK4c/RtWK7Vei90bFtHwSIgWxFrOG6hnN+X
 ITZGZUlDXeXEhvUNepUviYnLy93tdX0s5NF1gNWnYYl1n49E0wXlQnMLQjm699aSU4XT
 sy6eiR63N4Szo0ui+vhnYwXXHcLfPWUAC42eENl/4q88im+o3N1iyvzMAgXhwkc4Hkos
 7MMPS8E8OZGQMIEZHWfrqEHosfy2R4K/I7wDM+f5bXu3UZmnyjxwAhhyZsp8TxXFaST+
 D8AaAl4FEvnP2Y6zJSET3D/qXDcR7B42umd+XVWYSX32H6N0W3G10px7S3cNmnCkX9yN
 ol1g==
X-Gm-Message-State: AOJu0Yx0kGK2AUQETZE0a8Hb8jQoU8AcZvN5bB+nmu1KTbCbL+VDWS+W
 zqzSFPHjqRwOZ0LoGAKe/3IYfi4iyDJnWH1EA9YhPZEpXTQv94gwsemDmM3qJLQ=
X-Google-Smtp-Source: AGHT+IHpwAoLFKtWpv+kjmGgl7m/beGuzus/eEcoBx3TW2+FrwOaC707dtLvthpC1iIRTSmeyts+dg==
X-Received: by 2002:a17:90a:7e10:b0:2b3:390c:e3f0 with SMTP id
 98e67ed59e1d1-2b6c75dbe8fmr22253365a91.16.1715791336956; 
 Wed, 15 May 2024 09:42:16 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b67126adc4sm11845940a91.32.2024.05.15.09.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:42:16 -0700 (PDT)
Message-ID: <58dfa1ce-320c-468e-9aed-fe1b092b92f8@daynix.com>
Date: Thu, 16 May 2024 01:42:10 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4b30a810-211a-4ef6-ac28-c144615b402c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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

On 2024/05/16 1:39, Dmitry Osipenko wrote:
> On 5/13/24 12:18, Akihiko Odaki wrote:
>>>      static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>> -                                     struct virtio_gpu_ctrl_command
>>> *cmd)
>>> +                                     struct virtio_gpu_ctrl_command
>>> *cmd,
>>> +                                     bool *cmd_suspended)
>>
>> This parameter is not used as it returns an error if the resource is
>> still mapped.
> 
> Missed to remove it by accident
> 
>> It may be better to actually implement unmapping instead of returning an
>> error for consistency with the iov operation. Apparently crosvm also
>> unmaps blobs with VIRTIO_GPU_CMD_RESOURCE_UNREF.
> 
> Then I'll add back `async_unmap_in_progress` because resource can be
> both mapped/unmapped on unref, and we'll need flag to know whether async
> unmapping has been finished to do the final unmapping of the resource.

Such a situation should be already handled since unmapping in progress 
blocks all commands (not just VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB but 
literally all, including VIRTIO_GPU_CMD_RESOURCE_UNREF).

