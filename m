Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 11:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzDxl-0006x0-7j; Tue, 23 Apr 2024 07:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzDxg-0006wU-Sd
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 07:05:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzDxe-0000uz-0X
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 07:05:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41aa2f6ff01so7086535e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713870316; x=1714475116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zjNMw4IiDJW5kAd78A6Ym2pSoz7mgUb9vzCrG9W6h0E=;
 b=ASbtjaz2a/+ARdAU45Gm8OrEXWEyXKeyOIL0XRtnF3S3QXqHZsLYJA9aTrheNw7IXy
 fbB7ZW5BiIfLTFpVcBDqMCxdfdubOFtsrFbecchUqZLA157RTRD2Qie4yhS3VS/6MZ07
 8DTNoT0XRmPZq/1V6KUse+dkd1ncULt22qvbFRE9S5LiXPLn9ydqZ7HeiDhKF6X/UGj8
 IEcr7HdINtsOYsxNvrMAN19zVuu+ZqOp3GGe8ZTtsG80vILbvcTo1Cnkb3cun+H4CsXA
 cehj+1Usg3B8POChmjM+aBGzb5F/h2JMVB/A9VTfP4qZneHrpbQS0aO4bJms1X4tOipp
 W55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713870316; x=1714475116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjNMw4IiDJW5kAd78A6Ym2pSoz7mgUb9vzCrG9W6h0E=;
 b=jfmorzUg5A1JKwPzf0mcl+sLSCjOwLO7yLWTcKbeVEoIhJuz+RJiNYaRCc1wEhlnc+
 Lja8kc2j1vELlceNSJtv2dg3zLUVYhWmYtFbH/i3uBM5fSzUSjCsTwn9ND3NhVwhgBO3
 4nc+YgYzn0Yafg9DXCfl7meDSxuKhIUGWC6yljqRAqIBldvO+AsVjeZl/p/U4UTzksOT
 OY800MFxIeFIa7PO/uXnF4P1ViOFc+Vt8ypOD39Hswm6Ldfng/zOxOfIJOIjZLFIvXpR
 zfc9Lfdzfs/Lxe6zQ6Q9FTkCRgph7Wmrhj0Czzh9QQlrrXvDG/pPlbV+NtIC58Gji3AC
 BwxA==
X-Gm-Message-State: AOJu0YwF07XBzWV7NWn6FmOU1AdPWfQ8DTM/dTfZw444fUk4dzA0gMxm
 eHEj6omjHQBk1ODO+vJYT4Hp9gRgji7KAgH4luViJa+aXbeS4zp1Q52LPp5WucU=
X-Google-Smtp-Source: AGHT+IF27WcsZ1koO3O7Ny0pbU0Owm95K3T1hCtUYcp4Jwv0Io/ciN0MhT7t0fMm3PbvkIb8zof6Bw==
X-Received: by 2002:a05:600c:5020:b0:41a:6441:4f48 with SMTP id
 n32-20020a05600c502000b0041a64414f48mr3888524wmr.38.1713870315922; 
 Tue, 23 Apr 2024 04:05:15 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c198d00b00417da22df18sm23448793wmq.9.2024.04.23.04.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 04:05:15 -0700 (PDT)
Message-ID: <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
Date: Tue, 23 Apr 2024 13:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/4/24 11:18, Manos Pitsidianakis wrote:
> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
>>
>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>> Since VirtIO devices can change endianness at runtime,
>>>>>> we need to use the device endianness, not the target
>>>>>> one.
>>>>>>
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>
>>>>>
>>>>>
>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 only.
>>>>> It is unconditionally little endian.
>>
>>
>> This part of the code is for PCM frames (raw bytes), not virtio spec
>> fields (which indeed must be LE in modern VIRTIO).
> 
> Thought a little more about it. We should keep the target's endianness
> here, if it's mutable then we should query the machine the device is
> attached to somehow. the virtio device should never change endianness
> like Michael says since it's not legacy.

Grr. So as Richard suggested, this need to be pass as a device
property then.
(https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org/)

