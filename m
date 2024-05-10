Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E70C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NvJ-0000JV-3N; Fri, 10 May 2024 06:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s5NvF-0000JD-FS
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:56:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s5NvD-0002vq-4s
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:56:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so11709815ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715338573; x=1715943373;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zkFkqEFCjyo203k/RBxP+TefND6H+hFF7ONitKHgC4s=;
 b=uBBqddSBuclnZiRYW5TupJvTElzzhTH7QTzpePxHvgrD00eGQLDhzuSDovrF9zzXQW
 mG3AJFQRygaPQeQfzufIwBm2e/FEYKWxnOfGvB3A2qmk14Dh63/GvD9FtAsYUaTk8beF
 dYb1mCaVKPgcrASjgO+BLQCWGp2c/CwEWA39SVd3YSo27YYIJHAET28Mga4SygBTrtGz
 DIonPPcVsErdhz+66d/Ey2eZ3upyW7bRtzgofeWU3o1VsXfKkBHherpLbk2Xn/I1a4iS
 Ol9lV+VLlSax+UUN0mv/o//14ewzgiZfLU4vJvtdZeaUfe7vEbvnlxmahzdRiL/HmOAO
 W0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338573; x=1715943373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zkFkqEFCjyo203k/RBxP+TefND6H+hFF7ONitKHgC4s=;
 b=mSHg6iWiCmrVCL6ynMwq5umZcgEuKWAmXj5TqQSLv27kXbdDY5Jr/7qqZsX8sACoRj
 +GASfdcuOTOqLMQ4kSMAIqzZv6oBHDZ9ZDlOc9e3ET0bHB5NL3aHAfPuWnYhHk7MFrx9
 pRluwpv18tmu4rfAEri9klAjyiTbTtUS14JFA5Q9OiIEOBcvsQH3Y+iSoSEI+XjWzeBI
 rBG1nexE9x7AQi06ySZt3DUALbjm/hiTJm/26K8WwmzXyCLiVjPJZnQfosgL/gxviAe5
 7V2sZX20lwHINy/Gi3KdfsZywNQF6l5ZkuRE4KMAGJnTv/UXQwnG6p9pPI3yCuWmp6Ob
 PEzA==
X-Gm-Message-State: AOJu0Yz7fFadpVMRLpYesJRNEXYTOwYGN1rARUrSBIBWLCCqcapWMJe5
 wyLbAH1ZPHIUX8UR0fIK4D60/Xe68e1SKxcByYv4knsRWdsMdxMeEZvNEsre9wY=
X-Google-Smtp-Source: AGHT+IEsByg7knry0wPb5Y6WLqpY2x9tJfvQ15qjv+GmLKywWIun9aHZpAIPX5h7nMUGaE8/xwkDiw==
X-Received: by 2002:a17:902:c947:b0:1e5:5760:a6c1 with SMTP id
 d9443c01a7336-1ef4318d79fmr37270595ad.21.1715338573443; 
 Fri, 10 May 2024 03:56:13 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c256a4esm29242925ad.309.2024.05.10.03.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:56:13 -0700 (PDT)
Message-ID: <e4c9c32d-31ad-414c-8713-9faee92f81e9@daynix.com>
Date: Fri, 10 May 2024 19:56:07 +0900
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
 <0360512c-eb25-4c93-adb3-7f43395ae699@daynix.com>
 <8007338d-72ea-4896-89d3-ff98c66f979e@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8007338d-72ea-4896-89d3-ff98c66f979e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

On 2024/05/09 21:39, Dmitry Osipenko wrote:
> On 5/5/24 09:37, Akihiko Odaki wrote:
>> On 2024/05/02 4:02, Dmitry Osipenko wrote:
>>> On 4/27/24 08:48, Akihiko Odaki wrote:
>>>>>
>>>>> The VIRTIO_GPU_FILL_CMD() macro returns void and this macro is used by
>>>>> every function processing commands. Changing process_cmd() to return
>>>>> bool will require to change all those functions. Not worthwhile to
>>>>> change it, IMO. >
>>>>> The flag reflects the exact command status. The !finished + !suspended
>>>>> means that command is fenced, i.e. these flags don't have exactly same
>>>>> meaning.
>>>>
>>>> It is not necessary to change the signature of process_cmd(). You can
>>>> just refer to !finished. No need to have the suspended flag.
>>>
>>> Not sure what you're meaning. The !finished says that cmd is fenced,
>>> this fenced command is added to the polling list and the fence is
>>> checked periodically by the fence_poll timer, meanwhile next virgl
>>> commands are executed in the same time.
>>>
>>> This is completely different from the suspension where whole cmd
>>> processing is blocked until command is resumed.
>>>
>>
>> !finished means you have not sent a response with
>> virtio_gpu_ctrl_response(). Currently such a situation only happens when
>> a fence is requested and virtio_gpu_process_cmdq() exploits the fact,
>> but we are adding a new case without a fence.
>>
>> So we need to add code to check if we are fencing or not in
>> virtio_gpu_process_cmdq(). This can be achieved by evaluating the
>> following expression as done in virtio_gpu_virgl_process_cmd():
>> cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE
> 
> This works, but then I'll add back the res->async_unmap_in_progress
> because we need to know whether unmapping has been started.
> 

Isn't the command processing paused when an unmapping operation is in 
progress?

