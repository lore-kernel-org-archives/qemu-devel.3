Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3482DC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujxuf-0007mG-Ft; Thu, 07 Aug 2025 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujxuP-0007YW-Sh
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujxuN-0003ng-9H
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754562696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2suiI2r+va/etvyeyBrjemESnkWeouuLVS9BoGTi7qc=;
 b=QckAD8OIROFbJz378BrC+LFgM/hVdMzATtYTptLTk4DV61UdzR6zw4AOoF+tpLoV6Ge3Fo
 rF2MqhWOhSr7wq5HfSmYcUErBRcu5kRQvp++SmUE9vkBqIQ005RMGX4kjK9oo+Py4cDBwx
 BCsNopQafheKKK8CiTQbWRq7MQribkM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-HOhMugPHNHKc9PN1M1P_1g-1; Thu, 07 Aug 2025 06:31:35 -0400
X-MC-Unique: HOhMugPHNHKc9PN1M1P_1g-1
X-Mimecast-MFC-AGG-ID: HOhMugPHNHKc9PN1M1P_1g_1754562694
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-458b301d9ccso4637755e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 03:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754562694; x=1755167494;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2suiI2r+va/etvyeyBrjemESnkWeouuLVS9BoGTi7qc=;
 b=il59b69Ca64inSc6jOwAMeXe5xf3p30LQko6cpFg3P5UziSvsZ9V5M5Ijs4TSihf0w
 1+zb7sJR36sZ4G8paZrHjY4AHFV6Oh2tfAzVv+sX12M0cBPRWwuis4d3tAG2PS7xSQR6
 P6PTvGjG8APaeWq9cSxmYFRJW4TWMBbsb1im5FoG2bky/nX4EPkEFhT5TrjUYI6EQYhP
 8/mYa1pc8/t0iqOV+lEEq+4dpGt89dJGKq47cCUhP4ZKfvAocTN1R5+r63V4EcxyJkLB
 ozEu3sRpwakICANtAYaK7jelMTYOHzhNWdjC2Z57AFQFsosodV9GUFwFxHebQnHt5aHC
 ux+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNBigIwup9TAUXLPbI/n2dUafJVYHK6prveszcUlN+n1znHLclpru0sHWwE2uaRVfAW1tnyQfGZI7N@nongnu.org
X-Gm-Message-State: AOJu0Yzgz2veuV9cpPFDVD70E+StufGfLIriwdCFUYzOpZftmFPmuxOo
 2et8hfyMPJNBwMVIZAc0puSoNdiBMC+7bNDF0dHtbQroyGeXPWoJY4ydGjGOGDxZRJbGJlkMwtB
 igKzfX6odftIixBDxZVeQFB6Ov6JoUifteRje6QOn/TT3MawAu6CiBZU4
X-Gm-Gg: ASbGncv2iUQAG7WB/Prw7om8BMN4ACxvTc4iBBg/1NyqbtsEMmUCwbebuXEio0cG3Vv
 +7lwE0MmTBwf/9/y5S3g+dV/bvMWuyrfQ4bG9tvzFrP4t5LGdWJEcSQs8c4IsjuQOLHG1XvR8x9
 2jLdulCMvUTO07fV0iq/yrh7YqBWEQAYVLN/M5GB+0xQY15sjdl3DA6F0nGrYSSnyLUuwGuglKZ
 bskbLOn9/bRzgV2ChRH3cISX0NHQqWl1oi3cJu9iU23etkFZKtQpSICtp88yCYLDp2nYBBDboCV
 9WFbO4EZ3sI6mHnnnN4TpOTh0KP666KryAJHiW8xXgGdpJox538C6d0QcLJwCyti1QVmiDKCRCz
 vnFApwKG6
X-Received: by 2002:a05:600c:4f47:b0:455:f187:6203 with SMTP id
 5b1f17b1804b1-459f3085544mr5605845e9.27.1754562693608; 
 Thu, 07 Aug 2025 03:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoj9KskCtFM2ko0Gn1KCPT3F4elRIhZNO41EM6gyYgON0EIRoecTe7Of+kKAr9P74hOCxBsg==
X-Received: by 2002:a05:600c:4f47:b0:455:f187:6203 with SMTP id
 5b1f17b1804b1-459f3085544mr5605615e9.27.1754562693171; 
 Thu, 07 Aug 2025 03:31:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b95desm25808399f8f.20.2025.08.07.03.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 03:31:32 -0700 (PDT)
Message-ID: <659004df-d0f8-40f0-82c3-ae747849d420@redhat.com>
Date: Thu, 7 Aug 2025 12:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250806152940.362418-1-lvivier@redhat.com>
 <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
 <36d5da25-8cae-40e0-bea4-47c6020b4f92@redhat.com>
 <e7a32cb5-9d60-4dd3-b8af-4dd734de2f03@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <e7a32cb5-9d60-4dd3-b8af-4dd734de2f03@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1 autolearn=no autolearn_force=no
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

On 07/08/2025 12:13, Akihiko Odaki wrote:
> On 2025/08/07 17:36, Laurent Vivier wrote:
>> On 06/08/2025 19:44, Akihiko Odaki wrote:
>>> On 2025/08/07 0:29, Laurent Vivier wrote:
>>>> A race condition between guest driver actions and QEMU timers can lead
>>>> to an assertion failure when the guest switches the e1000e from legacy
>>>> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
>>>> RDTR) is active, but the guest enables MSI-X before the timer fires,
>>>> the pending interrupt cause can trigger an assert in
>>>> `e1000e_intmgr_collect_delayed_causes()`.
>>>>
>>>> The function's assertion (`assert(core->delayed_causes == 0)`)
>>>> incorrectly assumes that it's impossible for a legacy delayed interrupt
>>>> to be pending once the device is in MSI-X mode.
>>>>
>>>> This behavior is incorrect. On a physical device, a driver-initiated
>>>> mode switch would mask interrupts, reconfigure the hardware, and clear
>>>> any stale interrupt states. The legacy delay timers (TIDV/RDTR) are not
>>>> used for moderation in MSI-X mode; the Interrupt Throttle Rate (ITR)
>>>> mechanism is used instead. Therefore, any pending interrupt from the
>>>> old mode should be ignored.
>>>
>>> It is true that triggering assertion is incorrect as per: docs/devel/ secure-coding- 
>>> practices.rst
>>>
>>> However, I don't see statements in the datasheet that says mode switch will clear stale 
>>> interrupts.
>>
>> The datasheet doesn't say "stale interrupts are cleared." but it describes two 
>> fundamentally separate and mutually exclusive hardware paths for generating interrupts:
>>
>> Intel® 82574 GbE Controller Family Datasheet
>> https://docs.rs-online.com/96e8/0900766b81384733.pdf
> 
> It is an old revision (2.5). More recent revision (3.4) can be found at:
> https://courses.cs.washington.edu/courses/cse451/18au/readings/e1000e.pdf
> 
>>
>> See 7.4.1 Legacy and MSI Interrupt Modes
>>
>> Legacy/MSI Path: An event (like a packet transmission completing) sets a cause bit in 
>> the ICR (Interrupt Cause Register). The legacy delay timers (TIDV/RDTR) can delay the 
>> propagation of this cause. When the timer expires, if the corresponding bit in the IMS 
>> (Interrupt Mask Set) is enabled, the hardware asserts the INTx pin to signal the CPU.
> 
> Both revisions 2.5 and 3.4 have the following statements, different from what you quoted:
> 
>  > In legacy and MSI modes, an interrupt cause is reflected by setting
>  > one of the bits in the ICR register, where each bit reflects one or
>  > more causes. This description of ICR register provides the mapping of
>  > interrupt causes (for example, a specific Rx queue event or a LSC
>  > event) to bits in the ICR.
>  >
>  > Mapping of causes relating to the Tx and Rx queues as well as
>  > non-queue causes in this mode is not configurable. Each possible queue
>  > interrupt cause (such as, each Rx queue, Tx queue or any other
>  > interrupt source) has an entry in the ICR.
>  >
>  > The following configuration and parameters are involved:
>  > • The ICR[31:0] bits are allocated to specific interrupt causes
> 
> Please ensure that you refer a correct datasheet and share it for me.
> 
>>
>> See 7.4.2 MSI-X Mode
>>
>> MSI-X Path: An event on a specific queue (e.g., Rx Queue 1) is mapped via the IVAR 
>> (Interrupt Vector Allocation Register) to a specific MSI-X vector. The ITR (Interrupt 
>> Throttle Rate) register for that vector then determines if an interrupt should be 
>> generated. If allowed, the hardware performs a memory write to the address specified in 
>> the PCI MSI-X table, delivering the message to a specific CPU core.
>>
>> Only non-queue causes are reflected in ICR (so not TIDV/RDTR).
>>
>> The key here is that a TIDV timer expiring is only connected to the legacy ICR->IMS- 
>> >INTx path. There is no described hardware path for a TIDV timer expiration to trigger 
>> an MSI-X memory write.
>>
>> Therefore, if a guest enables MSI-X, it reconfigures its interrupt controller (APIC) to 
>> listen for MSI-X messages, not legacy INTx pin assertions. So, even if the stale TIDV 
>> timer fires on the hardware, the interrupt it generates has no configured path to be 
>> received by the guest OS. From the guest's perspective, the interrupt is lost. Our 
>> emulation should model this by ignoring/clearing the stale event, which is precisely 
>> what the patch does.
>>
>>>
>>> The expression "TIDV/RDTR are not used for moderation in MSI-X mode" is also unclear. 
>>> Behaving drivers may indeed use ITR for that purpose, but the question for us is: what 
>>> will e1000e do when the guest tries to use TIDV/RDTR in MSI-X mode anyway? That defines 
>>> the behavior we need to implement.
>>
>> The TIDV and RDTR registers are part of the device's memory-mapped I/O space. The 
>> hardware will almost certainly allow a write to these registers at any time.
>>
>> However, based on the separate hardware paths described above, the write would be 
>> ineffective. A driver could set the TIDV timer, and the timer would likely count down, 
>> but its expiration event is only wired to the legacy interrupt generation logic. Since 
>> the device is configured for MSI-X interrupt delivery, that path is dormant. The write 
>> is accepted, but the action is inert.
>>
>>>
>>> If the datasheet describes the expected behavior with delayed interrupts in MSI-X, a 
>>> reference to the datasheet should be made at least in the patch message. Otherwise, 
>>> perhaps this "if (msix_enabled(core->owner))" is just extraneous and should be removed.
>>
>> The "if (msix_enabled(core->owner))" check is not extraneous and must be kept. It 
>> correctly separates the emulation logic for these two mutually exclusive hardware modes. 
>> Removing it would incorrectly allow a legacy delayed interrupt to be processed as if it 
>> were valid in MSI-X mode, which is not how the hardware works.
>>
>> Moreover it can introduce unexpected behavior in the guest as this case could not be 
>> managed.
> 
> Revision 3.4's 4.6.1 Interrupts During Initialization says:
>  > Most drivers disable interrupts during initialization to prevent
>  > re-entrancy. Interrupts are disabled by writing to the IMC register.
>  > Note that the interrupts need to be disabled also after issuing a
>  > global reset, so a typical driver initialization flow is:
>  >
>  > 1. Disable interrupts
>  > 2. Issue a global reset
>  > 3. Disable interrupts (again)
>  > 4. …
>  >
>  > After the initialization completes, a typical driver enables the
>  > desired interrupts by
>  > writing to the IMS register.
> 
> Drivers can ensure that old interrupts will not fire by following this procedure. The 
> behavior when not following this is undefined (in the datasheet I'm referring to).

So, do you agree if I only replace the assert() by a qemu_log_mask(LOG_GUEST_ERROR, ...)?

Removing totally the "if (msix_enabled(core->owner))" could introduce a behavior change in 
the current implementation and I'd like to avoid that.

Thanks,
Laurent

Thanks,
Laurent


