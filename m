Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634A0C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8HC-0005j1-Uz; Mon, 03 Mar 2025 11:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp8HA-0005iP-Jk
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:04:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp8H8-0002Bl-QF
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741017852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T4ax79lrVmUFx52jI+hAC7doaUD0zpnihUVPye6lCyM=;
 b=hNrlOT6svWQ8bbxasNxr4cy1XIgQSkTMkw+pDjQSkdSuFNXndmhr60R3/fyhHG2TnoV2oV
 xb8peta6xjn+2JCUxxvHSnw9uqovE0oGUF/myRMhmrNOM7IMiZWpSK6Y1bJ1kb2HlKJf4t
 3az55BwHG1wE/zMlGmx+4hXUCs6T/lE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-u3AUXwzUPp-umS1JB2tZzg-1; Mon, 03 Mar 2025 11:04:09 -0500
X-MC-Unique: u3AUXwzUPp-umS1JB2tZzg-1
X-Mimecast-MFC-AGG-ID: u3AUXwzUPp-umS1JB2tZzg_1741017848
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ba50406fbso33523525e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741017848; x=1741622648;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T4ax79lrVmUFx52jI+hAC7doaUD0zpnihUVPye6lCyM=;
 b=sWFwgl+r7qCabNklG5eDWTnVwjT27U/fA6h8z73ewKLr7aUp5vd0HxZ+F02+EvSFzS
 MJwwb7cSUemPxxJqOGc/MPeVm0SK2zVf2ijWIBu+M0xy4s78z34sfC7As+J+WGlSqZYw
 ljOHUpyL6uMZgwsT6+mNzzzN8LC8E1X/8bgfHPdOX1at7n8Qmbkpghm24uR9guFDHmA7
 xAq0WdiT6UQTRiXEKw/dkMCND1Yamxe0BS29leTq4r3NmRbfV1oxVMz2L4WMyDSXhUw6
 ftZ6HNmN6FXMfAc4a8TljHiL/G/sbNVEaFmKt/7OmDmhuZN+rPhbes7cT43Vmd5TqoKH
 LStw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUieKp2puOAtE0vYF0gnJTnKqpB9Yr79vfNG9DBU0PZSP8H/k8MaF6cH7IL/KlE35r3RnRAk7yXVJ3z@nongnu.org
X-Gm-Message-State: AOJu0YzqjgY2eDheycDQ92OGnlegl7BKvdhW0djdSm+ugSRWATzMijLT
 JA2nhG4abwxwCUFLaKy0Xw8g6Q1TmbeRmO3ZV6W5+C7oAmKmKFDQvzexe3vIHqRoe16CvDH8Evx
 P230xu7w0f6wQ6NVY+B+LMGbA5gcphR2AaDT//WCAg3wdwMTJcUa6
X-Gm-Gg: ASbGncsxeZ/Vs5mtpdUrlBiuRil8GQXhqBRMPp27b88AHrymVmr1L3Ta8bi9le6VsPp
 Ulh2+G+RCShTqbxBIm2Gi2RCf6OCADymUMhodL+qxD4kCpfUszoI1dEpMI/UGcmt4QYboN9HyAz
 Fx3X9WBhzslkZfTkWBZ7mtCvQnkKEGkrGdLO+8PDhKvUceS4R82BPIjC7wHRPceGyuPtBqQ+fN9
 oa8bogVU6byySUDtIPE9Zvyxhk+1QEfJjyJNBID+lnmoVnL3j0iKeE9r9JeHQj38C7ct55RjSMd
 vDM89+FkWxOjPv+j1S333HEEwZOYa5m2S8/VbtgJKgoXiTSwBmtsoQ==
X-Received: by 2002:a05:600c:a03:b0:43b:a397:345f with SMTP id
 5b1f17b1804b1-43bad820605mr124895895e9.11.1741017848330; 
 Mon, 03 Mar 2025 08:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnuRBoo4KcPVk1Gg+4yxu0t6rB5mfQoJPNw8RsfStZOZyy5+zlVt9i8CIxfFDu/pDZXVz35w==
X-Received: by 2002:a05:600c:a03:b0:43b:a397:345f with SMTP id
 5b1f17b1804b1-43bad820605mr124894575e9.11.1741017847554; 
 Mon, 03 Mar 2025 08:04:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53943asm192636185e9.19.2025.03.03.08.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 08:04:06 -0800 (PST)
Message-ID: <9806cbc5-5587-4175-b7ae-ad5a8b0963dc@redhat.com>
Date: Mon, 3 Mar 2025 17:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
 <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/3/25 16:48, Cédric Le Goater wrote:
> On 3/3/25 16:26, BALATON Zoltan wrote:
>> On Mon, 3 Mar 2025, Cédric Le Goater wrote:
>>> On 3/3/25 15:46, Paolo Bonzini wrote:
>>>> On 3/3/25 15:30, Philippe Mathieu-Daudé wrote:
>>>>>>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the target not the host. Vfio-pci works with qemu-system-ppc 
>>>>>>
>>>>>> I've seen people do this on x86_64 host
>>>>>
>>>>> Since this patch does:
>>>>>
>>>>>    LINUX && PCI && (...  X86_64 ...)
>>>>>
>>>>> these users won't see any change.
>>>>
>>>> This is wrong---clearly this patch was never tested on the 32-bit platforms where it was supposed to have an effect.
>>>
>>> euh it was.
>>>
>>> With this patch, on 32-bit and 64-bit host systems :
>>>
>>>  # build/qemu-system-i386 -device vfio-pci,?
>>>  # qemu-system-i386: -device vfio-pci,?: Device 'vfio-pci' not found
>>>
>>> Same for qemu-system-ppc and qemu-system-arm
>>>
>>> What I am doing wrong ?
>>
>> These QEMU targets aren't deprecated, compiling QEMU on 32 bit hosts is. But you can still use qemu-system-i386 and qemu-system-ppc on 64 bit hosts and vfio-pci works with these so it should not be disabled when building these QEMU targets. I think you meant to do something else not what this patch does.
> 
> I meant to remove all VFIO devices on 32-bit host platforms (which
> is not needed anymore since 32-bit host platforms are dying anyway).
> 
> The patch is actually doing more, as it is removing VFIO devices for
> 32-bit targets too. That said, I doubt this config is tested at all
> on i386. Something to add on the TODO list.

So,

     root@vm15:~# uname -a
     Linux vm15 6.10.12-686-pae #1 SMP PREEMPT_DYNAMIC Debian 6.10.12-1 (2024-10-01) i686 GNU/Linux
     root@vm15:~# lspci -s 0000:01:00.0 -v
     01:00.0 Ethernet controller: Intel Corporation Ethernet Virtual Function 700 Series (rev 02)
     	Subsystem: Intel Corporation Device 0000
     	Physical Slot: 0
     	Flags: bus master, fast devsel, latency 0
     	Memory at fba00000 (64-bit, prefetchable) [size=64K]
     	Memory at fba10000 (64-bit, prefetchable) [size=16K]
     	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
     	Capabilities: [a0] Express Endpoint, IntMsgNum 0
     	Capabilities: [100] Advanced Error Reporting
     	Capabilities: [1a0] Transaction Processing Hints
     	Capabilities: [1d0] Access Control Services
     	Kernel driver in use: iavf
     	Kernel modules: iavf
     root@vm15:~# ip link show dev enp1s0
     3: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
         link/ether 06:0a:3d:59:01:11 brd ff:ff:ff:ff:ff:ff
         altname enx060a3d590111
     
It works well. I will make sure it continues to work.

Thanks,

C.



