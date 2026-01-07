Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ABECFD621
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSsq-0002Ki-BJ; Wed, 07 Jan 2026 07:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdSsU-0002If-SZ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:43:07 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdSsS-0003qq-67
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:43:06 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2ae2eb49b4bso2366813eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767789782; x=1768394582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7eYkv/f/zCESLFHyLwZhrgGDlB/tsikgHpqDr0W9KKY=;
 b=agR967OqK5fZgimIly4tLwSx9wS2mTLWcdN3F9yj0ky+msQWf4z5bEKP9iLpYwVh4J
 mQDmfRmBlkbnJfR0MH/o1S2dKdg+pBHbeO/w7v+i3E0uxi5DGFFN+7ZmnnMnhI3EobTq
 r4Gx6KCz42ac25HnAKU2qzvyFcf6RxPEswf9n6Dvzqn2/Xc66wGaFmvd4LVQtgNAChMU
 so/Yo4gmOOdRInhfDSHxsh0Ovsf2N4uua5Q12VEATZX9NxiQCJkL5n7QL1p9EIOpaRjh
 JkOpm7ut4IECeFCsK/6kD2iYzyCHrxNC5rd3UK8AbVpEGAhK//PDZU5VSBoCK4cG7pi9
 Oa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767789782; x=1768394582;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7eYkv/f/zCESLFHyLwZhrgGDlB/tsikgHpqDr0W9KKY=;
 b=uplb3QHJyNFCsg7GQOT6qYsPrc/d+O6ogVV1PlhN55LWg9b0bdb8pk/XfEZfOcYL3g
 CS/kZpT6+k8tAw6+ijZE2sWcHnKfbf30mE7cKzJwenSL7RR/KeAB42WL6p2k6ODFvR6g
 pN99XnkL0vWJZWa6A39xfPtU1/IT3CMX3Fq4Xu2c7vjIBBEioGvxqUwFO0inNYwcWVp6
 5sJ+91HJdCSCP7Le7aoufhAsgOuocAa5fzTbLPBCeTx0NQtORqqLBN5klmlahiG+iJUY
 bS/XfA1W2DOrlh1F8KALAqPE1x+sLdFN3D/EbmZZ7V3AUJonLjuyS7ajO37XTQY+DXOt
 Uk7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNLOF3+5o1z/i2De8UohvfXh3WTDjQDoKVx55N6xwGscbbrEJdVHeaFuzIxeGBeQN2g/4IiKtph4g@nongnu.org
X-Gm-Message-State: AOJu0YwkXa44jUfeb9ccVfN3GopNcndJHVg4oim+v01abOjQsXk7caRr
 lab+m2TnpCboedgkI5oXdUul2NyGODERPEO84BCFs5RCSfd/pNgvHQmoEvHJAe897LY=
X-Gm-Gg: AY/fxX4qakPf4vrQuvfa80R6w9kTYidUq/Im83d80bI8szPXTaywz1oMOrxZyt67aSh
 wI9yIFR7rRF2XqVTUDmSJxtb1XKWycrwv+WLzZivl4QX6oOWcWk/wmzqAqnJMWaHuZFU66lt26u
 QszLB6X5wtVlhWH1mOe3oB7OuzgY1RpHyDEwfV3baXw74RP7tkqn+SBkGE/Z4EtDFVMv+415v9A
 aETgSgXZcqnmTFoOqRFS+fSJGrwzz90JIzg4W/gnN6x4r8jFJV5WFACahA0eAwQgLtDb5+3PuJI
 N63DxTrdXo40EDPFffaPcjpN/SIHkmSvoQWsEru6XdunQnhy2gg4dIr0wudjAQgaMpoGc3HtSk3
 JY7gEekXLCUCwGm2xtfRuzTgARKtyvXcmXzDFVuVHTlBchxKjrBAHtxK9oACliFBaAKlOxQ2+Pm
 tLwLbnHz9LXeQy7TuGIBp8JKkgN7jHnxjflYOuCKIL+UcnbZrkfw4KJc6vOX58FJfXW8eI/NtU
X-Google-Smtp-Source: AGHT+IH3kia/N1ykmTkUXc0W3vC4nmW2+EtCtktLdJZp847H6KlZvJY5+515/dH3E/d7EKCO/rY5Cw==
X-Received: by 2002:a05:693c:2293:b0:2a4:3592:cf83 with SMTP id
 5a478bee46e88-2b17d2e3416mr1743375eec.39.1767789782079; 
 Wed, 07 Jan 2026 04:43:02 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1706a6386sm6670565eec.14.2026.01.07.04.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 04:43:01 -0800 (PST)
Message-ID: <10b6d234-4bbf-4aec-a06a-ebd33f2044b4@ventanamicro.com>
Date: Wed, 7 Jan 2026 09:42:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvv: Allow fractional LMUL on vector SHA
 instructions
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260104233724.192886-1-antonb@tenstorrent.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260104233724.192886-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dy1-x1334.google.com
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



On 1/4/26 8:37 PM, Anton Blanchard wrote:
> Vector SHA instructions incorrectly raise an illegal instruction exception
> when LMUL < 1. The ISA only states that LMUL*VLEN >= EGW:
> 
>    For element-group instructions, LMUL*VLEN must always be at least as
>    large as EGW, otherwise an illegal-instruction exception is raised, even
>    if vl=0.
> 
> There is already a check for this:
> 
>    MAXSZ(s) >= egw_bytes
> 
> so just remove the check for a fractional LMUL.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/insn_trans/trans_rvvk.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
> index 27bf3f0b68..32255d3aa0 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -426,8 +426,7 @@ static bool vsha_check(DisasContext *s, arg_rmrr *a)
>              vsha_check_sew(s) &&
>              MAXSZ(s) >= egw_bytes &&
>              !is_overlapped(a->rd, mult, a->rs1, mult) &&
> -           !is_overlapped(a->rd, mult, a->rs2, mult) &&
> -           s->lmul >= 0;
> +           !is_overlapped(a->rd, mult, a->rs2, mult);
>   }
>   
>   GEN_VV_UNMASKED_TRANS(vsha2ms_vv, vsha_check, ZVKNH_EGS)


