Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77F9C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkcc-0000ep-NJ; Mon, 23 Jun 2025 13:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTkcZ-0000e4-Rc
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTkcW-0002oD-WD
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750698371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IlKDlRRSDRgn0u0EMd22FO5dVrNf0VUxFuaJYkwIuDs=;
 b=f0l+bsHU/O5e4d4l2p6HDXhRfgfRGWqXrU42O2hSPtICMUDTbAutho1akmN4mIN8cg44e7
 Lp6iWviGlBntiennhQSeteE/rNI224UAVf3BuOd2xJCH+Y4M+0HauJhN6t5XL7OFj7L9Uo
 sV6rdVScNP3MQ4hBgWQGiqi470+dKwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-tx0uCx3EPQi9sFAli24TdQ-1; Mon, 23 Jun 2025 13:06:08 -0400
X-MC-Unique: tx0uCx3EPQi9sFAli24TdQ-1
X-Mimecast-MFC-AGG-ID: tx0uCx3EPQi9sFAli24TdQ_1750698367
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so38050445e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 10:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750698367; x=1751303167;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlKDlRRSDRgn0u0EMd22FO5dVrNf0VUxFuaJYkwIuDs=;
 b=Vg1ZDiGHXuiP88IXoXIk9wIgP81MTmlSj4ss2z5gRctp25S8LAJ+QP+kjW0DX7Buew
 l7CUYbqnUz+wgGxzGt7lHVQ8bjCxWF4r+ZhS2exFjlbewPIQMxNYrWoh0miWiVJzCeSS
 Uqfw7B46rSB8vTpeKk1S59Vietln9jSeSw3N7Mr+K0zfDOG4vYlLpLtVPDFppFrPabH4
 fplBCD/GRFbNo8Z6RfxgwPddOWV0l0O4p/FmCNHNcP9BZXNsSaykVO+RGPkiCPFKSFk5
 TJJk+z3GCPamt0BAvUoSoU0yx69FgRV6D0GcKkHKpf3yRmW2yeLGpTAk0JBTV89QxLjm
 zQWA==
X-Gm-Message-State: AOJu0YyOWqupWq5AwyJ9xSfsYYUDsonOATMA3L16YKrmfzgbd4apdRI1
 TjtjQuBtE8ck5APDQjnHh0sm/vyHy8yBQymdEqzhsO9DeNZIKwjUzsmpMvCRKdjP64MDpEUTg/G
 8wRWMZeHVuh2f+24Lj8JhdiAN2HSP702hhMTryaaMsiEFyQJVuqud806Z
X-Gm-Gg: ASbGncuRIRX1SjCuBqqa9OmD5bTWG//qwb/ntYfaPd7OIl0YSHPd/zR+O1/moffBFm6
 fmeJ5CuRICG3veMLHXXsHM3wtHgyajSwro10IL6s9FLmULrIH1VMAn4y9Jw3R1nJsw8m9glSIxs
 5gYYuVr3/hThM++2LsKeEre/1NS9fgVmdt6Fr9exuzmwCsuj3wOCrKhrLkn4kf5UKGL6gCNm0GM
 km5pS0JFvV4AvgYAyaSD/Ez/0dt2/mDyZWrOuzQP7u/hwTQAHJRpZboV/AZwGM01haCW6sKQmOo
 2LW2uogbQt9ROxBol5xz1EAQ1JBYq/yg1k0uTJz02eJXFmLK1flYnzP8R4Yy
X-Received: by 2002:a05:600c:1c83:b0:453:5c30:a2c2 with SMTP id
 5b1f17b1804b1-453659ca60fmr121687315e9.8.1750698366922; 
 Mon, 23 Jun 2025 10:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAcL8hYOSQDHwxBGAIxHxeEhRH7sjbTWu/rSxD68yj5ZVtHpnYWc7FKwi5hX7dAYV2YsEhkA==
X-Received: by 2002:a05:600c:1c83:b0:453:5c30:a2c2 with SMTP id
 5b1f17b1804b1-453659ca60fmr121686765e9.8.1750698366430; 
 Mon, 23 Jun 2025 10:06:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebd02basm148195735e9.39.2025.06.23.10.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 10:06:05 -0700 (PDT)
Message-ID: <6dbc8562-1187-4367-8e41-b998cde9a6be@redhat.com>
Date: Mon, 23 Jun 2025 19:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] vfio-user client
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com> <aErh-v3SfFo-2Br0@lent>
 <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
 <3b311f79-fc87-4b1b-8ba5-728d696a14b3@nutanix.com>
 <65274f7d-59ee-407e-a57f-dbf9e47890b5@redhat.com> <aFakD1PqE6Ew8whG@lent>
 <e27a3a2f-9277-490b-a8ba-22202bb57c70@redhat.com>
 <993cbd0f-fad8-4d27-bb52-b5d198ae5f2b@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <993cbd0f-fad8-4d27-bb52-b5d198ae5f2b@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/23/25 18:09, Mark Cave-Ayland wrote:
> On 22/06/2025 13:57, Cédric Le Goater wrote:
> 
>> Hello,
>>
>> On 6/21/25 14:22, John Levon wrote:
>>> On Fri, Jun 20, 2025 at 10:32:10AM +0200, Cédric Le Goater wrote:
>>>
>>>> Before merging, I would like to be able to experiment a minimum.
>>>>
>>>> Does a dummy device (server side) implementation exist ? and a
>>>> GH repo I could pull the code from.
>>>>
>>>> John,
>>>>
>>>> How do you test ?
>>>
>>> I use these scripts for smoke-testing:
>>>
>>> https://urldefense.proofpoint.com/v2/url? u=https-3A__github.com_jlevon_grot_blob_master_tests_vfio-2Duser_run.sh&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=V-sTFYIBuNsRDS6PAkkLHCjd5V2lvtIYfbhCV4BsWHxVWzLB_Dj21kOCZ_00B8wZ&s=ZZtYgH13tGNzKPUfKumHJno3qZjfUTg5z6GMJ_9o5so&e= is easiest - you just need to compile libvfio-user and qemu
>>> and you should be good if you have a suitable Linux image.
>>
>> PCI enumeration work but the kernel module won't load on ubuntu 24.04
>> and 25.04 :
>>
>> root@ubuntu:~# lspci -s 00:0d.0 -k -vv
>> 00:0d.0 Non-VGA unclassified device: ACCES I/O Products, Inc. PCI- IDIO-16 Isolated Digital Input / FET Output Card
>>      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>      Interrupt: pin A routed to IRQ 21
>>      Region 2: I/O ports at 6000 [size=256]
>>      Kernel modules: gpio_pci_idio_16
>>
>> root@ubuntu:~# dmesg | grep 0000:00:0d.0
>> [    0.381550] pci 0000:00:0d.0: [494f:0dc8] type 00 class 0x000000 conventional PCI endpoint
>> [    0.382696] pci 0000:00:0d.0: BAR 2 [io  0x6000-0x60ff]
>> [    4.017654] pci-idio-16 0000:00:0d.0: error -EINVAL: Unable to initialize register map
>> [    4.027063] pci-idio-16 0000:00:0d.0: probe with driver pci-idio-16 failed with error -22
>>
>> Any idea why ?
> 
> Annoyingly this is because the gpio_pci_idio_16 module is currently 
> broken upstream :(  

Is is a known issue ? the gpio_pci_idio_16 module seems well maintained.

> The last LTS I was able to able to successfully test here was 6.1, 
> and so that's what I've used to generate my functional test images.

All seems to work fine with the debian-12-nocloud-amd64.qcow2 imageand the gpio-pci-idio-16 kmod is even provided by default.


It would be nice to be able generate some interrupts

Thanks,

C.



