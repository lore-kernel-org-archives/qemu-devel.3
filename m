Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E20FC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZT4E-0003D6-MD; Mon, 12 Feb 2024 04:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZT4D-0003CZ-7v
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:57:37 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZT4A-0002jI-It
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:57:36 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6e2dfc98664so675979a34.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707731853; x=1708336653;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lBS/iGypu0zdqgRPFAb8hRT4khIhZsJn3AV9DszOshs=;
 b=iOezpDzeRUvdVisjDLmW0na48GsHXoXmbTg8yWPG+DdBK1R6UQ8+s3gZDsXtfIGhg9
 O9TWAChBEKpKCuyZJs1urlwAnx6/9tvb/iFbOY8ZkP0C27WnbskPNqaJUkbEYjm+0q1u
 PtD9uMknG1+37k+5fX/toxocfT/VW6WrWJR+l6NOE0rvXEcq02jrR3BjlsWenlu03s+N
 T0EaI8g0Vpia2vJfzItNFMTuqxDzR7BwjjeT3kYmcSLh80X0ww/klJuPqLy1RAsmpsy1
 LXHA6K8c5OFtAzadzjDjZjZwglNBWRC0IO78LGzvjQwzkqjygg2JdJkeKRWB0MQ6GvqO
 rSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707731853; x=1708336653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lBS/iGypu0zdqgRPFAb8hRT4khIhZsJn3AV9DszOshs=;
 b=sfgKrJcnA/oVFjh7HZr/cgGdh5t45NTfMHD664qPOD9jfbxQeRP0oYF+h8BiKgUfhW
 6eReL0g9kCx28pAdF44/ltLjkllcvxjPVI1nJWHM0ezBgU9xrD2vUUGemOvxDw0pFas2
 jgTz91vNsv0ZIWaXX+IlXgZOAP/RWJSdgm+yvjVL3fCH60Kkp7wpsC9O3bhKIGmpcsaI
 wKQX00koYF4HKEhkgeKtCu+SwwPr0vYs2oGJXyk09Oac4YO9Svlpn7b4NIGpboQHD/DY
 AK5BHiuQVodoDQTAQ+1+Bx9VCJvJ3BMSuP8ofMWUnVW3gXcNIfLaMm9eHxgDVSq6zLy2
 6IOg==
X-Gm-Message-State: AOJu0YwgaYabgZarI0ewykeGAwbJGnyhLwjn1eS90AzNisf8Wv7Rakxe
 75i50Tv7qKXzpiAOc83eQzHpQyrpRtKO9lM30afVUN4K5dS2xFRTEiPE1L2FI5M=
X-Google-Smtp-Source: AGHT+IEz69w6DONHFtP7g20q1E7v2Av/AUe8NG2HPoqmAYBTgsgdKjpnOQGM++vbBb49jgodpymYMg==
X-Received: by 2002:a05:6358:2795:b0:178:62d5:dafc with SMTP id
 l21-20020a056358279500b0017862d5dafcmr10766132rwb.18.1707731853225; 
 Mon, 12 Feb 2024 01:57:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXwftdnEaG2f+VwFPfIIS2Cqc4sf2J5mF3wjq/QXeHIhPCo9/FRgZQDYigKRm0cFfa/eBTMt67sglDLZ0AHggofqhZC+2yDKLWB/dbkya95hDF97CeDN9I60k/qCKHh/jNObWc6zPdQJbw8hhVx43Mw+kaYUOIZI3SsQNSk16oqJFaqQiByfYFSMAe6LRUaSugTIZWHpNrRxv+Ey9bk4olWhUhqQObSTSez9Skh/3esBEZUrNkdrohCZZxMKkZwmJaneEvifj3eiU5gkoOY6vhnhtZ2VWCjZZCYzxykSH9s21jBbOch0873GGNRKVKxdGyFtpmkW5MJsEe4VRb6ch46JN9/GEKLdqfg0bwYH4EBK/7yJ33RQgtHqqGDQm+SYielcRp6ptr1YY26LRMlXY9YIZjlizGP
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a056a00175400b006e04553a4c5sm5159947pfc.52.2024.02.12.01.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 01:57:32 -0800 (PST)
Message-ID: <01943f92-08c0-454d-a5be-bf11cd6f4b8f@daynix.com>
Date: Mon, 12 Feb 2024 18:57:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] vfio: Avoid inspecting option QDict for rombar
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
 <20240210-reuse-v2-2-24ba2a502692@daynix.com>
 <318f6a01-a72e-417e-8017-80a758605e98@linaro.org>
 <10bb153f-8e93-47f6-bfcd-d3c2416f03dc@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <10bb153f-8e93-47f6-bfcd-d3c2416f03dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/12 17:25, Cédric Le Goater wrote:
> On 2/12/24 09:04, Philippe Mathieu-Daudé wrote:
>> On 10/2/24 11:24, Akihiko Odaki wrote:
>>> Use pci_rom_bar_explicitly_enabled() to determine if rombar is 
>>> explicitly
>>> enabled.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/vfio/pci.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index d7fe06715c4b..44178ac9355f 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -1010,7 +1010,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>>>   {
>>>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
>>>       off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
>>> -    DeviceState *dev = DEVICE(vdev);
>>>       char *name;
>>>       int fd = vdev->vbasedev.fd;
>>> @@ -1044,7 +1043,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>>>       }
>>>       if (vfio_opt_rom_in_denylist(vdev)) {
>>> -        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
>>> +        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
>>
>> "pdev" is considered internal field, please use the DEVICE() macro
>> to access it. 
> 
> Yes. I was just looking at  vfio_pci_size_rom(). There is a test at
> the beginning of this routine which should be changed to use DEVICE()

It should be fine since vdev is VFIOPCIDevice * (therefore vdev->pdev 
refers to PCIDevice instead of DeviceState) and this code is an internal 
implementation of vfio-pci.

Regards,
Akihiko Odaki

