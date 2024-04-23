Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8011C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 08:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzBL3-0000y8-4j; Tue, 23 Apr 2024 04:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzBL0-0000xh-Gy
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:17:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzBKw-0004f8-CS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:17:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41aa2f6ff2dso6134735e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713860229; x=1714465029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=61Q1FjTyktbfFWF8W2XkTRxxdpS0VIpoDTKoCDNwirw=;
 b=OK3GtZVFnvU3E/GLUPHRL7guAxQZf4yqmvtdGXvEwZTrYNL3eoRVXq9FwMcgRWRCfD
 lLoFE83jlY0sC90hXcbief36igIPLacUk8PkmmASSh1+eyZW7uyS4stKNZFZV3L6d8Sr
 B+m02LpaPf9ghc6zM5FgtNw6nmSh0g47YMsePyIzC19a30UzDyVN5yNh146nsH+Ogdnc
 16g6hQSezMMnevQzMxESKJRl+0clfQpTLaDareQH71IrEL8LBFQEjUL4R12f7DzXmIy8
 m1mNQjgxVkSVycICLbaI/H9YsN+kc8FsQxoi2WgsKqJGQ0RSjWA3YANVGz34yTD+dJWz
 AHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713860229; x=1714465029;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=61Q1FjTyktbfFWF8W2XkTRxxdpS0VIpoDTKoCDNwirw=;
 b=TW7TTDQdgWGFhTC/6aJYj0MnQzYSh04ewOfJCCDVIVxeu+a5RK60caD3nmHNxVsvwG
 nS5RJYrSC4XuYZtsM5zSx3maZIiadM/I9d2A2NhzvMIPLyUCcZo0e0XGA7xOfPqY/FEj
 hUwTOVkJUTXJL2b39bQC3+0aVgOCVvyKfbSLHTk0P8CmjXyRIhlH+wqqEfAcljiyG4vX
 4jNwwxjpudU8atKRWdX0dEtuYFv1h6ta0oBdTE6I0YSbKlnc/pxHnm0SFMHUwZfeEa7E
 NEiVKgK8V8ujOxaAH4OKsfLDhyfR5OKFdf5fGxFhLml48xK2r9Rv4s9Nhfs4zcJA9f5t
 SXlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsega/DXrI/l+eYdLfNcC9xGiMdyZI4yE4sScXCWbmiYtiJnq33BXufkjhi9dqGC0dgeyKR2aawq4VjmrGYzS1u7VhPVs=
X-Gm-Message-State: AOJu0YwvYOvgKkM9+0geADllygD6RnvGg5a0JcoKU8xAmKI5ek56aKmk
 F8bmkgqjkMGSCtKmM+oZitYLlfGS7KjtrCDhTRdNd8u7LdlR2/8CoueZW2OYPCA=
X-Google-Smtp-Source: AGHT+IEK7TYRLbsCu58xdkQ0nkS9cG2RRpjCXAMNKPRxgpgpWnh3VNfYDNX7W4AvSVJTGtvZluRqRA==
X-Received: by 2002:a05:600c:4688:b0:418:a2ce:77ae with SMTP id
 p8-20020a05600c468800b00418a2ce77aemr9151715wmo.27.1713860228816; 
 Tue, 23 Apr 2024 01:17:08 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 bg11-20020a05600c3c8b00b0041a9c3444a6sm2817287wmb.28.2024.04.23.01.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 01:17:08 -0700 (PDT)
Message-ID: <34e3bbc4-e2ec-4bbc-84c4-ebfb45f7095f@linaro.org>
Date: Tue, 23 Apr 2024 10:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] virtio-snd: factor card removal out of unrealize()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Zheyu Ma <zheyuma97@gmail.com>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
 <2231ee9229ba7259763c9814e6ec119d8954b81c.1713789200.git.manos.pitsidianakis@linaro.org>
 <2ebc4f49-4d50-4ad8-9d44-eb6ef2ff0066@linaro.org>
Content-Language: en-US
In-Reply-To: <2ebc4f49-4d50-4ad8-9d44-eb6ef2ff0066@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/4/24 15:27, Philippe Mathieu-Daudé wrote:
> On 22/4/24 14:52, Manos Pitsidianakis wrote:
>> Extract audio card removal logic out of the device unrealize callback so
>> that it can be re-used in follow up commits.
>>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   hw/audio/virtio-snd.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> 
>> -static void virtio_snd_unrealize(DeviceState *dev)
>> +/* Remove audio card and cleanup streams. */
>> +static void virtio_snd_unsetup(VirtIOSound *vsnd)
> 
> Maybe s/unsetup/cleanup/?

Or 'teardown'?

> 
>>   {
>> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> -    VirtIOSound *vsnd = VIRTIO_SND(dev);
>>       VirtIOSoundPCMStream *stream;
>> -    qemu_del_vm_change_state_handler(vsnd->vmstate);
>> -    trace_virtio_snd_unrealize(vsnd);
>> -
>>       if (vsnd->pcm) {
>>           if (vsnd->pcm->streams) {
>>               for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>> @@ -1370,6 +1366,18 @@ static void virtio_snd_unrealize(DeviceState *dev)
>>           vsnd->pcm = NULL;
>>       }
>>       AUD_remove_card(&vsnd->card);
>> +}


