Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93016C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 03:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGVrW-0002up-II; Sun, 09 Jun 2024 23:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGVrV-0002uW-3L
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 23:38:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGVrT-0004wr-Cf
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 23:38:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6dfc17006so15421225ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717990701; x=1718595501;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/zKkLuArRJQG20dEbTUKgKUwQ4e36XoWCQ718GMLJXM=;
 b=kz+A6jtE+F5bvrwZc8HErDR8VHIm0t9qnrV0GOvMAe1S6licuWdJ673kDYIVB0oCn/
 rWLGgFHg4WI/CS9RgMDgmNGInPpcqKTDHxHZSLT5E3KZ4cD/BAlsle17gsBE7jdtg6nI
 Wuj51myvk4Ji25NWMUKWeib6GkMoVDSpGyQORgeSwXXmVEiMVNIMlFyZCFuRz+LDnQ/S
 yDS4nmgVD0yWlSSFZ3gFIHeA2hr3ERZN6MpO1okR41rTmwkg1wPeAkZSWxuX8R9lPatU
 NWyMlNqXbd4tBzRuONc1gOvdO2f/2Gdvk7APggGEWdnMqXj3wLNjj3QaaIYIYMxLk+x1
 Kvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717990701; x=1718595501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/zKkLuArRJQG20dEbTUKgKUwQ4e36XoWCQ718GMLJXM=;
 b=Y+Bl7eCmgzREm6gxIKEiPwEfT2jeSzdsK9Dbb3U6L6LZJLRFvyBKP4ewP6Ghyn4edS
 Z1Ku55qJFXDW81spmffmAgJ78+dLFmmyd2tY+9f3nPF44ebSL1qthz4qtb7VJzXNFVLO
 zJWaPV5kj+0V66zbJ0hjxRfcizW+wj4wAmvFgZBYbyX74QlzZMv+rE0NdEH576JQ2+j0
 pWJU62qLqvt2qe8valWrie/5GjtJ7Tbpc/BOIpew0Zo3tgK95JG0rv/If+aXpPy2O+x3
 4egnHc2zQQbTlcezR+X4Q9aZbyvVyh7spOjOmQTT5yGDjtMOn7zuPS9ulXKcbv1fFWqX
 U5Kg==
X-Gm-Message-State: AOJu0YwzJZ3X1cpHJ8ZtsdmQp0fshNGNkr5zfyIiRHquvyHswSCUWKSj
 XkXeWBAlnAHiXxBBm2r7pE/GO36G1YF4OtRmaYqj3MLRxiZjfQwaeTpZ6pjnFXE=
X-Google-Smtp-Source: AGHT+IFLC2UyAqWiQ6zUuDvmSHwn79SaqPi99Vsv/V4CJJ5rGPahokU8Np9cahFC2XW764xT1S5K/g==
X-Received: by 2002:a17:902:cec3:b0:1f7:13ac:e813 with SMTP id
 d9443c01a7336-1f713acea1cmr14774065ad.49.1717990701463; 
 Sun, 09 Jun 2024 20:38:21 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6da30cc2asm51393585ad.236.2024.06.09.20.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 20:38:21 -0700 (PDT)
Message-ID: <802327b2-f166-49b5-b063-f642bb78111f@daynix.com>
Date: Mon, 10 Jun 2024 12:38:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
 <c9891c82-b139-49cb-9f94-52a96cc20eea@daynix.com>
 <c2a4c684-24d8-4a3d-bed0-9b711b00b169@collabora.com>
 <24afb7f8-f091-4405-917e-ee7bb0a1e2b8@daynix.com>
 <70a2368c-2ed5-4035-a278-5d8a16c406ba@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <70a2368c-2ed5-4035-a278-5d8a16c406ba@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/10 4:02, Dmitry Osipenko wrote:
> On 6/3/24 08:44, Akihiko Odaki wrote:
>> On 2024/06/03 14:26, Dmitry Osipenko wrote:
>>> On 6/2/24 08:34, Akihiko Odaki wrote:
>>>>> +typedef enum {
>>>>> +    RS_START,       /* starting state */
>>>>> +    RS_INIT_FAILED, /* failed initialisation */
>>>>
>>>> Is the distinction between RS_START and RS_INIT_FAILED really necessary?
>>>
>>> The state stays in RS_INIT_FAILED once was failed until virtio-gpu is
>>> reset, re-initializing virglrenderer isn't allowed in this state.
>>
>> Can you elaborate more? Why isn't re-initializing allowed?
> 
> In practice, if virglrenderer initialization failed once, it will fail
> second time. Otherwise we will be retrying to init endlessly because
> guest won't stop sending virgl commands even if they all are timing out.
> Each initialization failure produces a error msg.
>
I see.

A better solution is to add a new function to GraphicHwOps to call back 
after initializating the displays and before starting the guest. You can 
do virgl initialization in such a function, and exit(1) if the 
initialization fails because the guest has not started yet, saving this 
enum. I don't require you to make such a change however; this is not a 
regression of your patches so you have no obligation to fix it.

