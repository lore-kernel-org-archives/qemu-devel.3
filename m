Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F576FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAnL-0008Ir-1s; Tue, 05 May 2026 04:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAnJ-0008I3-Ab
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:06:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAnH-00025g-Os
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:06:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0046078so41679115e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777968373; x=1778573173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=43D0rSs772N28MZUYjSQoo7KjBWj5Qvya9gKSJ3ZpcY=;
 b=oAI3mXNBWbah2gT0Gbc0buoWyPZuSWFxJ01MmZWxTRX9YCkP57yihrx+no8xJsJS4r
 0KGoZ5y4FAnlgl96a0KLNrNFh/NN+xZKRdg79gBk11efXs56P71mQupir4hcWFOZ+0hm
 sTEkCuyLEZf1ynLlryrh4iZ9qe+TwE+rovOixxQ1+0SCiPnlic1b6IBZhX+8/rWrj4B7
 EAiy4AxkrhcRaGahmVBbgX51Xcl+kNKSMSywbqJ2KnF/9hKPxIgAkCwauSALQx1IVUCF
 okKsK9wPcgmReto5JT5ZTFUU8TdCpBCEg0jDcF2BFBGj86YgtXwbbJ8uZS1/TeMzEeWy
 wz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777968373; x=1778573173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43D0rSs772N28MZUYjSQoo7KjBWj5Qvya9gKSJ3ZpcY=;
 b=q13NgjfWZSdtLEhZZ/qS33BGQkMRhII/vb7sxHA5j83VB/ZjR1+Rrp49+GwoahUblg
 bhmjXxL2knZ1R1EfRtnVFdNbJHpJNM2qSOZ8snKLhzMEirhoZq2wV1kPTKkbRVB6n0m6
 dC9U4lrIqOiKBx4GYsi2Lw6DfM6JMGW6D7Rv1MkTenlrH3xDMwV3OBAPrG+t3VjpA67y
 eyoVqujQ5RJf1JwOD/5XQ3n6o1uNxpBU3zW/PlsgkdLzHZ7K66JAQ9iLP8AkK46kYhEy
 JgDi0dqcZbUSYO/ZTGNP7eQyEOBhWjOPXo4B5NmJNEuaTCV6QGiuz0hg5D5NgYVjOpWq
 LfAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HBFUAVcIv8vU/fWFQESa2i4FkH0rDaZaoTzGtngptRd11kofx+cldIgEo7ILV2idf6EjCbfM8yvdz@nongnu.org
X-Gm-Message-State: AOJu0YwdUz3IeemtbLBC4XziXFHfAdms4HsYQZSx8iKh0vxOZUHdKAWt
 beoNVBBPUvgnwaUGe1V2u31W2hlFYED09arg0BW+ZU4YXN6jTE/b1DRsco0A+7KTAaI=
X-Gm-Gg: AeBDievz7bQZYvQDxyTDubvi0sj4MeActlyxGuht0Zti46fFW4FbcKoxSrnVj154PCf
 89MlOsAEfRSoe+AdGAQ4ZLHfzjQXV35DFl711St1aJoeqaGnV2bvnEbQZ9fuhyHYRYdkn1esACO
 89tL0gY6jyOiFFrfYT8MlvMnUU1Rl4wybxRETarlmzr3Z9o3zfq+Mu1BrrzLiMTZFUBpohrt0Qg
 Hx1laIR0NwA3joz6BvvwC9mbN82EFyBGB28LeAu5ohjodi4UkzDw6iYHk1k4cZOzN1a6lJtn8iy
 afMxCz4+FmQ0TEzSEIgM9tJpPdRMXYxExUslzvkfT38BKeIbwcPGPF3+ugGIYONNFfFQVmKRpkg
 U3YDQVEuYKGR1lG9uxD8ksaonPq0H+J678yCY+qzT9Gi0xp5pJ5yR7IIhw18DirnqwYpLXLaqat
 bKQQUK+hWGEACRkq2CYwhb7S06GVL3TNgoSdXoxrqQI9urh8KWCH4oyvD5HHpIO+RrpA==
X-Received: by 2002:a05:600c:3549:b0:48a:93d2:60d2 with SMTP id
 5b1f17b1804b1-48a980fd5d4mr199443355e9.0.1777968373146; 
 Tue, 05 May 2026 01:06:13 -0700 (PDT)
Received: from [10.115.35.66] (95.170.88.92.rev.sfr.net. [92.88.170.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb69698sm593535185e9.1.2026.05.05.01.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 01:06:12 -0700 (PDT)
Message-ID: <c20e1c76-a9aa-400b-8ad7-129347c1b9c0@linaro.org>
Date: Tue, 5 May 2026 10:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] hw/riscv/boot: Provide a simple halting payload
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-5-joel@jms.id.au>
 <CAKmqyKNiJ9hGQVPsq8pEz8ydEWydW=umT4XwWanwk-etADgf_Q@mail.gmail.com>
 <afkvnrQveMGC1lcE@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afkvnrQveMGC1lcE@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/26 01:52, Nicholas Piggin wrote:
> On Thu, Apr 30, 2026 at 09:35:33AM +1000, Alistair Francis wrote:
>> On Sat, Apr 25, 2026 at 11:21 PM Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> OpenSBI hangs before any console output if the domain init code sees the
>>> next stage is not in an executable region.
>>
>> That's an OpenSBI bug though and needs to be fixed there and not just
>> hacked around in QEMU.
> 
> You're right of course. OpenSBI has other no-output crash cases in early
> boot code (not just this), so it would be nice to fix properly. It wasn't
> trivial to fix (IIRC because serial device is not detected before a
> bunch of the early failures), I have some hacks, but I need to go back
> and come up with something nicer.
> 
> This is only related to Atlantis by coincidence of the physical address
> map. It can be dropped out of the series.

Meanwhile add it in hw/riscv/tt_atlantis.c:

   static void
   tt_atlantis_setup_opensbi_halting_payload_fixup(RISCVBootInfo *info,
                                                   hwaddr addr)
   { ... }

and call in tt_atlantis_machine_init()!

