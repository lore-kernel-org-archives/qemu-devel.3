Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2DCC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 06:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3VV8-0007Cz-Ao; Sun, 05 May 2024 02:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s3VV6-0007CC-4t
 for qemu-devel@nongnu.org; Sun, 05 May 2024 02:37:32 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s3VV3-0000WU-Pf
 for qemu-devel@nongnu.org; Sun, 05 May 2024 02:37:31 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso628172a91.2
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714891048; x=1715495848;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QKMQzxrMRPgomZrUaIVHd65z4FA1pEpQNxl/vkgncNc=;
 b=Pvo2rxdReiwP+6BldXpp9hvWqokfX0jfknJ/9qnBa6URemiIidxnllQlxGSF3qO4JE
 8hmBgdKnEIre9HlputknD3HrXz31+rn3P2SoKALdn4hNkTHjztam6xG3K7S2OJfKuoBs
 EV5MhyUM0krQXnXSewx1eyMNpFQop0NoGFg/T6ONjeGF0H3ozjA37lze1U2wJI1WOT8s
 NGagmN6BWo/AfrHHPR5VYzT7FeyS1TmUQ7hg0ky0rCBUE8DiP+IyZ/TFtAmEss0fgR2r
 eA67YyVM5ggKiODRUS85z44XL280UKNPsJHch1dKku1D8N8jT4D4awcPTS8wU8gjypnq
 6OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714891048; x=1715495848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKMQzxrMRPgomZrUaIVHd65z4FA1pEpQNxl/vkgncNc=;
 b=ZGKykhBEM0AFa3gU9OQpmTJKZTHAiI+RdbEDtCLE0RPuYYpchLJA9DAQ4FSVLkR/PZ
 jOqQPU3n3WrkaUeZ8MqQUrifshJL3Fz2HYSx+rdK3axkIK7ByH8FMZTeCU6fdxJaViuX
 FEU9J6WWmAZe/Sru3dQQDwJ0jjenRTKFcqCRvukeoYXmpOjZBXlEyOmAe268XfXkXpK7
 jLKY3w6wRhEkM5melsqw0LXa8ZP5I4zZBBj872BOcr1s1s7hEMOLzGlQBibWacNbyAEN
 AJ3sd5ASXSFrNFIS1SAGDiubM9qUDCCSsFoS0fVLAgcjzUztTmMzUlpaGYBx1teXRxp4
 hWtQ==
X-Gm-Message-State: AOJu0YwEfN0snEEdmxMeT30cvMJzseGDT2qu0mvHQ4e+oozMLllFfoDK
 bOK4UuU4S/f+q5pzc/O5R3aD/Q5xPBjvQSosB6CeqjsTr4xkg9lzE05G4RFCH+8=
X-Google-Smtp-Source: AGHT+IE91jjWdz5j9i92uMDIgrpa0MVfBB3/2fundYtzi+vuoL/l+mKVrQP9N4JOSgOUZJ6hkhEixw==
X-Received: by 2002:a17:90b:92:b0:2a5:16c2:8551 with SMTP id
 bb18-20020a17090b009200b002a516c28551mr6181123pjb.19.1714891048112; 
 Sat, 04 May 2024 23:37:28 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 sz15-20020a17090b2d4f00b002aff85b97dfsm7792790pjb.27.2024.05.04.23.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 May 2024 23:37:27 -0700 (PDT)
Message-ID: <0360512c-eb25-4c93-adb3-7f43395ae699@daynix.com>
Date: Sun, 5 May 2024 15:37:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/11] virtio-gpu: Support suspension of commands
 processing
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
 <20240418190040.1110210-8-dmitry.osipenko@collabora.com>
 <8a153bf1-f86c-46c8-a29a-08e9a0197dc3@daynix.com>
 <4c6b3ca0-4813-48f4-87f8-a94e911c02d3@collabora.com>
 <10337ba0-70ce-436c-9cac-398851ebdfc9@daynix.com>
 <5b240c8a-f1c5-487f-a528-cbb4f440094f@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5b240c8a-f1c5-487f-a528-cbb4f440094f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

On 2024/05/02 4:02, Dmitry Osipenko wrote:
> On 4/27/24 08:48, Akihiko Odaki wrote:
>>>
>>> The VIRTIO_GPU_FILL_CMD() macro returns void and this macro is used by
>>> every function processing commands. Changing process_cmd() to return
>>> bool will require to change all those functions. Not worthwhile to
>>> change it, IMO. >
>>> The flag reflects the exact command status. The !finished + !suspended
>>> means that command is fenced, i.e. these flags don't have exactly same
>>> meaning.
>>
>> It is not necessary to change the signature of process_cmd(). You can
>> just refer to !finished. No need to have the suspended flag.
> 
> Not sure what you're meaning. The !finished says that cmd is fenced,
> this fenced command is added to the polling list and the fence is
> checked periodically by the fence_poll timer, meanwhile next virgl
> commands are executed in the same time.
> 
> This is completely different from the suspension where whole cmd
> processing is blocked until command is resumed.
> 

!finished means you have not sent a response with 
virtio_gpu_ctrl_response(). Currently such a situation only happens when 
a fence is requested and virtio_gpu_process_cmdq() exploits the fact, 
but we are adding a new case without a fence.

So we need to add code to check if we are fencing or not in 
virtio_gpu_process_cmdq(). This can be achieved by evaluating the 
following expression as done in virtio_gpu_virgl_process_cmd():
cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE

