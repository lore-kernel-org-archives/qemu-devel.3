Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B931C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 18:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roSL0-0001pH-FS; Sun, 24 Mar 2024 14:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1roSKm-0001o4-A5
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 14:12:40 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1roSKj-00025H-M3
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 14:12:39 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29fb11f4b34so3198181a91.0
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711303956; x=1711908756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jkbdW3eorgIsu5Hony6gjNwQckwa5A9q0Q7uAfZjU34=;
 b=l7GiD43XNSQ8Wrm6vQ8cU52Cv2uiP48DAKFjqmJItRNZafVYHx+NVQrlRtmRS1skBs
 Fhr4z6mvGwywvnlEGahKmK8HfYrgkZBm13CMVLOZVYxIrMYNbMfdG+BUhZ9vMbkaemNK
 hXUVYVPW5ygiP1Yv2Kj5QhIx5oKBcVhhEUyOv0OxcQB8jk1RtVpugW2NihIWS+KeSuLj
 RUC2R5Xoy7Tuhy0Who22+lUrAuGmDqGqISZAxmSg0xyuBO6a7x33rSQSn4wA8SBSa7Ia
 2zYVUEBgzot7/H+pY7oT5PFX68m5Pk+PbEjwj+Sz6w0sNCIvFK0Yr5Pg064AF3pUwor1
 evlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711303956; x=1711908756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jkbdW3eorgIsu5Hony6gjNwQckwa5A9q0Q7uAfZjU34=;
 b=kNjzXsWtO/Dt7SOl4Pr+m+n1VonIDmLc9LucRQ50hXWlYJ4+6V8V+2M1XzXJNFQprb
 fUSXnmO5m8XPskkoE2sHLCQYVRKkTFMyGY5XGfeIoAwJTmlGVSIaZVeWv69zUwTY6itQ
 BLw3BLomoUZJdCNPMmZFQsm8V2KzxxWixEZCpyAkvw3Y24Vl/kw1ar1DEw7h/0uKHUWV
 6j06QJUH4q8/eBtI2s6Wv7Ii+GVriMBnxLjHAjZZeRR8LyCB485mM596w2K8OVe04CNz
 rF8Z4o0kroaSdu6md36kWCzuLcKjLE/nbqznXR0ifOM4U/cOZYAHXJBa5L/7PZrjnLxo
 ki3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLxZ/NDaC1mYA4lUM0SFLWSiLbSE5J+Zvcc5DZW8+qxryRECF8HJLf5BQTUOginfqZqOmoIX1aJjL1ZwIVxSNfDN0RS7k=
X-Gm-Message-State: AOJu0YwJwEjIJ95g1vJNYJ3x5vW0DZF2Oa9+ce1SYrrxlYYvQx+JN2s8
 L75nMPbBcW3MLtBNTgnj32/nB3U94996OOx/fUB7p2zt/x4UFTWKbgCFYVpyESh2Q/9lsSqmzD1
 y
X-Google-Smtp-Source: AGHT+IFnFfcp5JXdQKqzTJ7t/gz+oXu2EPOQP+oot+ORIIWqicD7kgYvG079wk2g1PFCs0b1C2sggA==
X-Received: by 2002:a17:90a:a085:b0:29e:5e:33bd with SMTP id
 r5-20020a17090aa08500b0029e005e33bdmr6201029pjp.21.1711303955850; 
 Sun, 24 Mar 2024 11:12:35 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 sx16-20020a17090b2cd000b002a053cdd4e5sm2590472pjb.9.2024.03.24.11.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 11:12:35 -0700 (PDT)
Message-ID: <6fb5ca42-8e86-4144-b9a9-9d98d30f8fb9@ventanamicro.com>
Date: Sun, 24 Mar 2024 15:12:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis
 <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
 <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
 <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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



On 3/24/24 12:07, Michael Tokarev wrote:
> 22.03.2024 22:46, Daniel Henrique Barboza :
>>
>>
>> On 3/22/24 14:16, Michael Tokarev wrote:
>>> 22.03.2024 11:53, Alistair Francis :
>>>
>>>> RISC-V PR for 9.0
>>>>
>>>> * Do not enable all named features by default
>>>> * A range of Vector fixes
>>>> * Update APLIC IDC after claiming iforce register
>>>> * Remove the dependency of Zvfbfmin to Zfbfmin
>>>> * Fix mode in riscv_tlb_fill
>>>> * Fix timebase-frequency when using KVM acceleration
>>>
>>> Should something from there be picked up for stable (8.2 and probably 7.2)?
>>
>> Ignore the "Do not enable all named features by default" since it's fixing something
>> that were added in 9.0.
>>
>> The rest you can pick it up to 8.2 at least. Thanks,
> 
> Unfortunately this doesn't quite work, the following changes
> fail to apply to 8.2:
> 
> 929e521a47 target/riscv: always clear vstart for ldst_whole insns
> b46631f122 target/riscv: remove 'over' brconds from vector trans
> d57dfe4b37 trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
> bac802ada8 target/riscv: enable 'vstart_eq_zero' in the end of insns
> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration
> 
> I tried to back-port at least the first one but it turned out to be
> another failure.  Didn't try looking at the rest.

This particular code (vector emulation) has been going through a lot of
changes in the last couple of releases, so I'm not surprised with the
difficulty with backporting these.

> 
> If these really should be in 8.2 (it's your guys to decide, not me),
> I need help with back-porting these to 8.2 (and/or cherry-picking
> additional patches from master).

The amount of work can be non-trivial for this backport, so I'd say we should
leave it aside for now. If someone has a good argument for this work then we
can re-evaluate.


Thanks,

Daniel

> 
> Thanks,
> 
> /mjt
> 
>>>> ----------------------------------------------------------------
>>>> Daniel Henrique Barboza (10):
>>>>        target/riscv: do not enable all named features by default
>>>>        target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
>>>>        trans_rvv.c.inc: set vstart = 0 in int scalar move insns
>>>>        target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
>>>>        target/riscv: always clear vstart in whole vec move insns
>>>>        target/riscv: always clear vstart for ldst_whole insns
>>>>        target/riscv/vector_helpers: do early exit when vstart >= vl
>>>>        target/riscv: remove 'over' brconds from vector trans
>>>>        trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>>>>        target/riscv/vector_helper.c: optimize loops in ldst helpers
>>>>
>>>> Frank Chang (1):
>>>>        hw/intc: Update APLIC IDC after claiming iforce register
>>>>
>>>> Irina Ryapolova (1):
>>>>        target/riscv: Fix mode in riscv_tlb_fill
>>>>
>>>> Ivan Klokov (1):
>>>>        target/riscv: enable 'vstart_eq_zero' in the end of insns
>>>>
>>>> Max Chou (1):
>>>>        target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin
>>>>
>>>> Yong-Xuan Wang (1):
>>>>        target/riscv/kvm: fix timebase-frequency when using KVM acceleration
>>>
>>
> 

