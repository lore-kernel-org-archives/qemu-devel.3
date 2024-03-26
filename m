Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17660CD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5cN-0002O7-1l; Tue, 26 Mar 2024 08:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp5cF-0002NT-CL
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:09:21 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp5cB-0002hF-Tg
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:09:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6082eab17so4128314b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711454953; x=1712059753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIR8qz4HTWoBQMZ8nTE9DRw7vN7H9IWFCkZ+QLtQgMU=;
 b=iTu+z2zLmCo/FvP0wOFXjKd3DYyNf1Dd9uQEEXeqK4+8+eOVedY7K/hZsf+0qL70o9
 rbH4Ha61+1+IAOf42pOZRfig2alDJv/SCJR1MhROvtWDP/6EtQkKXqg+869IL0ZzgBO1
 POpKmIQdTh5IluzYm/bhvSABbDFzbaFfVkA3Uezr1aTMbY+1DrcPt+1ZQl18KnSEpvWI
 57IyElArgs4aY0fMIIcbdIJ7OV098BCJuvHcZdS2XbFX6DH009nhE51eXKOkSIxjPSXY
 gCv5shgNXiZ/rWqcikstF9ci7/ZeV7Tqd/uH+p50OK+aUTio/K387bde9SpdVrV8FK2h
 gq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711454953; x=1712059753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MIR8qz4HTWoBQMZ8nTE9DRw7vN7H9IWFCkZ+QLtQgMU=;
 b=fp2SDoS6C97bKLpV+fDE/6LL+isn0CK3VaW2gxCmFlsTwMqKUE6cfiBk5WROjdisUA
 A4Rhnr7WHPPu6Co7nMtOiyfVTF16fA9/xpXXgx9Ml5PlBjoS1BaFPe9KvjSecedluj+T
 tG+UQwBEZYhhYEbfQDS+zhbGct7+q3EP2pkaxrfryEugoCqbdWqzV69kGNcq+VyfgdLb
 1l6ET+t+dNuR1Y3RLjxARRozDUyKQc8wmLnShU6T3kRQX/DMncJGOqQn9jMTMHekAvKn
 nWi1FJjNmS0TBTi1cgLY/nvIyh6vbLrKl1aylrRT5qS1QOiIWlAoZ1BG1ilIup8V5J2C
 AARw==
X-Gm-Message-State: AOJu0Yxh587REAL3vDSbyfeX5wKocEbtQUX4hG++dMm2XrmHGzFMn9cB
 aWNEcj93RA+Z5N2WidF4Akz0Bdih+zDRVj4iRHsnRDTj6XjZgGrrOfIyqS4iLjw=
X-Google-Smtp-Source: AGHT+IG02Oc/vrz5E/RwPAVRVGcFE1d+6I38a6m7cGjCyidUcIf1hXcAfufsNkOUKLqHcg0fp84hoA==
X-Received: by 2002:a05:6a20:3d8e:b0:1a3:c5be:678c with SMTP id
 s14-20020a056a203d8e00b001a3c5be678cmr3169783pzi.47.1711454953573; 
 Tue, 26 Mar 2024 05:09:13 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa79d09000000b006e535bf8da4sm5765814pfp.57.2024.03.26.05.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:09:13 -0700 (PDT)
Message-ID: <bfb8856c-f154-4e54-a8f9-42586e45f424@ventanamicro.com>
Date: Tue, 26 Mar 2024 09:09:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
 <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
 <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
 <6fb5ca42-8e86-4144-b9a9-9d98d30f8fb9@ventanamicro.com>
 <19d5ffb8-8cf1-4d88-b66a-2cf961621b93@tls.msk.ru>
 <CAKmqyKOG1sr269TDERsGEvbAJfJ_MTtW-smMCdDUBbYaGwkPGA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKOG1sr269TDERsGEvbAJfJ_MTtW-smMCdDUBbYaGwkPGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 3/26/24 06:56, Alistair Francis wrote:
> On Tue, Mar 26, 2024 at 7:53 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> On 24.03.2024 21:12, Daniel Henrique Barboza wrote:
>>> On 3/24/24 12:07, Michael Tokarev wrote:
>>
>>>> Unfortunately this doesn't quite work, the following changes
>>>> fail to apply to 8.2:
>>>>
>>>> 929e521a47 target/riscv: always clear vstart for ldst_whole insns
>>>> b46631f122 target/riscv: remove 'over' brconds from vector trans
>>>> d57dfe4b37 trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>>>> bac802ada8 target/riscv: enable 'vstart_eq_zero' in the end of insns
>>>> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration
>>
>>> The amount of work can be non-trivial for this backport, so I'd say we should
>>> leave it aside for now. If someone has a good argument for this work then we
>>> can re-evaluate.
>>
>> So, out of 15 patches in this series (minus the first one already
>> mentioned) - should I pick 9 remaining patches for stable (the ones
>> which applies) or none at all? :)
> 
> Sorry for the confusion.
> 
> The 9 patches that applied and
> 
> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration
> 
> should all be picked for stable.
> 
> PS: What is the best way in future to help ease some of the stable
> burden? Should I try and cherry pick them beforehand and then mention
> that as a follow up to the PR?

We believe your judgement about what should or shouldn't be in stable, so IMO you can
be pro-active into cherry picking fixes into stable and mention it in the PR.


Thanks,

Daniel

> 
> Alistair
> 
>>
>> Thanks,
>>
>> /mjt

