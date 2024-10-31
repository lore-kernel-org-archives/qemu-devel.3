Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAEBE68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MSE-0005ye-Mg; Thu, 31 Oct 2024 00:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MS4-0005kt-Bi
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:06:31 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MS2-00059j-IG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:06:28 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so4170701fa.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347585; x=1730952385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GmrS8B+JczQ1TlR014IIWntHN+nwu6EE4ORZxiZAXaM=;
 b=w7kOI9te08Xynk6YkFiLDPSz2ruVm6r+XsFVQCZzN0rJPRRWB+rWXFRjB5wKYKeBTU
 5TYnHJXOlBfV6q5GcXD7JlVevm9FJ4t0jCTFVdC/E5iLpVPeDwEHN38FZ0XNESSwZLXm
 o/XRX15kw/xKv2SO79SuVVWNvfnx8+XjF0GwxxJsXROr5ceZTcKFKeIXVWQmWdZHC9ex
 fB0+q1NrbXesKXPKCGqFhPXHFKjk5CkDwptnZiEBrBqk85qZ40nTYBrgTHqvgK+hWCCV
 ZJb3XqTrJWBihh8bmaCAZpuAlCs2ejMG2jabrYbH4TKoSlOy1HK8VLFFTrFRATmMPVqJ
 B5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347585; x=1730952385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GmrS8B+JczQ1TlR014IIWntHN+nwu6EE4ORZxiZAXaM=;
 b=SuxY3kZnxPXnUxE1nWd77Wt958s1vXiTJ0ATTrJ7T9moDEo21ry7NlCN4iy7mKGc8i
 j7YkEKL0ZOOUrUPEAc83WZSoVIZyZeo9wdQMwdG0oXUd750u+7/OcauJYg2Vndg7lmXn
 ogMHgYK9Q4x7azheEFoVWfbW4qAzzR09EH1XKVOglpqG4VVNFGC+6vBfwIiQJT91Qm9Z
 mizdF2HMlys1OXUxt5RAkYW2rZsQXgkbY4uGnO/vpEe0FDxsQo3cC2lWUXZNdA5WWyWy
 Y6EIhsgOFzjoZIPOs50zMs3diQf5TpFLCUszjTHq6chlu9y2GWHF1JYazvn3UAelYPas
 Bl0w==
X-Gm-Message-State: AOJu0YwecLGbjZ6FXTkyY59lW7IvKLm26S1DENknSfYR+SZiP23JEVs9
 nwNZc+xtBCfPQ3NMuZ9eb3BxS0Ivchg1apt4tERpuvGrLje0RVXS2VxMW5Qd5aPRFpy+FTxmpPN
 0
X-Google-Smtp-Source: AGHT+IH0YFVYChHlz/cDTEYxkXIRbSXAH/o0GY+XAzmKGJv7fq+/4RKBAFoIXrLbamZt4e13VmGvuA==
X-Received: by 2002:a2e:6112:0:b0:2fb:599a:a900 with SMTP id
 38308e7fff4ca-2fcbdfb978emr74082851fa.15.1730347584453; 
 Wed, 30 Oct 2024 21:06:24 -0700 (PDT)
Received: from [192.168.21.226] ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef5d5ca0sm921721fa.30.2024.10.30.21.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 21:06:22 -0700 (PDT)
Message-ID: <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
Date: Thu, 31 Oct 2024 01:06:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
To: Michal Simek <michal.simek@amd.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
 <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
 <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Hi Michal,

On 30/10/24 02:53, Michal Simek wrote:
> Hi Alistair,
> 
> On 10/30/24 03:54, Alistair Francis wrote:
>> On Thu, Oct 17, 2024 at 5:26 PM Sai Pavan Boddu 
>> <sai.pavan.boddu@amd.com> wrote:
> 
>>> diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-virt.c
>>> new file mode 100644
>>> index 00000000000..6603e6d6b06
>>> --- /dev/null
>>> +++ b/hw/riscv/microblaze-v-virt.c
>>> @@ -0,0 +1,181 @@
>>> +/*
>>> + * QEMU model of Microblaze V (32bit version)

Is there a 64-bit model planned?

>>> + *
>>> + * based on hw/microblaze/petalogix_ml605_mmu.c
>>
>> Just a question, are you sure the virt board should be based on the
>> petalogix_ml605_mmu?
> 
> It is definitely based on ml605 and it is fair to say it and keep origin 
> copyrights around.
> 
>> This will be the reference Microblaze V implementation in QEMU, and
>> the petalogix_ml605_mmu might be a bit old now. It also uses a lot of
>> the Microblaze architecture components (like the interrupt controller)
>> compared to the RISC-V architecture components which might cause
>> issues for you in the future.
>>
>> Just something to keep in mind
> 
> And the reason is that it is really design like that in design tool 
> (Vivado).
> There is no risc-v specific interrupt controller use but origin axi intc 
> used in origin Microblaze designs. Timer is the same story.
> 
> ml605 board and it's chip is old but IPs which are used are still 
> supported and used in new designs.
> 
> And regarding using virt in name. We can create design like it is 
> described but it is not going to work on standard evaluation boards 
> without extra fmc cards for example.
> It means word virt is just description that it is not really target any 
> specific board. Definitely name can change and suggestions are welcome.

What about 'generic'?


