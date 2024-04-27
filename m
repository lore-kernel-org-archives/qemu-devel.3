Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88292C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 05:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0avB-0000dG-3h; Sat, 27 Apr 2024 01:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0av6-0000bz-Jh
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 01:48:21 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0av4-0000fI-Ku
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 01:48:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso2097117a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 22:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714196897; x=1714801697;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3naJtlI4gf0M7keP8Y/upIj8ZtsTn9AXjgP4Nm2XiVQ=;
 b=ZJeM/rCgNhqsZbufY0xjiXdHt73RbfE9MQK6hIOJmcfnCPFojz0Cx2kN6pMBevj3PE
 VI7ADEdCsDDffcmYi8qt/gOVKQG0BPRjp+6GCQOTExG4dBvSnP95SjzQpvKaMYomr+jn
 W186nYNZxbJBWSgmh9VqOkIiWJV8XU8HkSGzMzLxZrs7S/q/SLNige6PHkxTQNJBu6El
 9gO19NU6qpUPZaUuMP9SNDxewGJah0M7TnFRJugRQMLy7TsrBZed4hLKlb4AymaKJ62M
 o/2DgJ0OiiJx6BD5VVDTbiZPTyY2G9MmeqjrfMvsAAAnIkS1B64XgiMpItIvuFLGpotc
 Ddrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714196897; x=1714801697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3naJtlI4gf0M7keP8Y/upIj8ZtsTn9AXjgP4Nm2XiVQ=;
 b=G42Iimz6GO5PEWQnjn2HcZaN+yegALr+hBc587eMDgnr+lFlj0G0n6XhBu2OYkqwO6
 r1Yza3egqAj5ns+58fTwRvQQWnehz86TvnHPblTPoTkiIWxNmG+ObpH78B8brQfEGUlZ
 WWr8BX9JlkTrKeRbNpink2qaTfXT32r5youraIvXiLX+1QSKdCLwGXjk/6z2dDfxwbOJ
 Ght835DpUhz+Vqbsz8DzX84zeNzWIpY1ib4N+ghxFnzXbEqCgbMb4nut8qd4qOahXmfM
 hxcWEKiYlBkD+yhmTxsVS6VP+N2SoCS2vfqVu7LANctGy1YelpOxbLepp++V50jjddQF
 68Uw==
X-Gm-Message-State: AOJu0Yx4cqh4UBY01BkkPO+vFK3lb1xaE0OJ9cN0TJYV4oly4zh/hxwA
 fPOKIQbeqyyRVedt1TBGO8z6KLyip9Xt+j0aH5mJUU3PJcmM7Q7kyFR2eA8GyGY=
X-Google-Smtp-Source: AGHT+IGBpUNuGEhZZ6V3SoCz1BeU48qHck+hcNalijNvEfw1172XDfQJImkCEwP3nUcnp2TobU9AHw==
X-Received: by 2002:a05:6a20:a105:b0:1ac:c455:c126 with SMTP id
 q5-20020a056a20a10500b001acc455c126mr6474591pzk.19.1714196896993; 
 Fri, 26 Apr 2024 22:48:16 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a17090a5b0500b002aaa404eb8asm15615605pji.14.2024.04.26.22.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 22:48:16 -0700 (PDT)
Message-ID: <10337ba0-70ce-436c-9cac-398851ebdfc9@daynix.com>
Date: Sat, 27 Apr 2024 14:48:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/11] virtio-gpu: Support suspension of commands
 processing
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
 <20240418190040.1110210-8-dmitry.osipenko@collabora.com>
 <8a153bf1-f86c-46c8-a29a-08e9a0197dc3@daynix.com>
 <4c6b3ca0-4813-48f4-87f8-a94e911c02d3@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4c6b3ca0-4813-48f4-87f8-a94e911c02d3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

On 2024/04/24 18:43, Dmitry Osipenko wrote:
> On 4/19/24 11:53, Akihiko Odaki wrote:
>> On 2024/04/19 4:00, Dmitry Osipenko wrote:
>>> Add new "suspended" flag to virtio_gpu_ctrl_command telling cmd
>>> processor that it should stop processing commands and retry again
>>> next time until flag is unset.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>
>> This flag shouldn't be added to virtio_gpu_ctrl_command. suspended is
>> just !finished in virtio-gpu.c. Only virtio_gpu_virgl_process_cmd()
>> needs the distinction of suspended and !finished so it is not
>> appropriate to add this flag the common structure.
> 
> The VIRTIO_GPU_FILL_CMD() macro returns void and this macro is used by
> every function processing commands. Changing process_cmd() to return
> bool will require to change all those functions. Not worthwhile to
> change it, IMO. >
> The flag reflects the exact command status. The !finished + !suspended
> means that command is fenced, i.e. these flags don't have exactly same
> meaning.

It is not necessary to change the signature of process_cmd(). You can 
just refer to !finished. No need to have the suspended flag.

> 
> I'd keep the flag if there are no better suggestions.
> 

