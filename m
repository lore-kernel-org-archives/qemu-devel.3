Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F25D2AB3A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5la9-0006Nn-LR; Tue, 29 Oct 2024 08:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5la8-0006Mh-2c
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:44:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5la6-0002QQ-B0
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:44:19 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so837657166b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730205856; x=1730810656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5dsyCqa5PtQPjgdqaipZkq0yxwMvNptP2rb+2tnD678=;
 b=OtpEyJa1uHuWDIQp1BWTdzYoW7mNdRE3avaCagoGMmgowl96oWIB7ahqdhxUOccImc
 y1bwlGomipdFObIlcDRLX6lKtVUepKsv/aILn3/HtGl4AgaB5vdwT+o3iiWOj/VHdtaK
 ducWtpJ7FkjJB88GHcBxGW92OaGArZVmNyaVjqfCZ9CR4D2PsWSQLE5YX5eAoiFzIEq7
 UqzgoM+3AubQJ5w1+SgH4g2UJjZBRZuhNRlHNu9lERjjk/UpGG8wI0HwFF2pH0GHAPH8
 sf7aS7/3ULRSuwwo8C0obzsdTW3EXv03TwTo88yfs+7zGOELb/rvkg7VdF/Sv9Tq8eDo
 3w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730205856; x=1730810656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dsyCqa5PtQPjgdqaipZkq0yxwMvNptP2rb+2tnD678=;
 b=Cz6+MbkVUKfmcIdp0OytdtnL5IMOios3bwjoKuI5mRSq9YDy18m59aazDzqeOOZOWg
 LI7551YePZrXupfBQWEAoYO/zwpPqJgQttPKH16NKovVomYgvQshW3Qms7nZRv9sWwhL
 Rl2912oiQ9DGt4b2j/5pSWFH52L7L5CL71pxrtnv49x0zhdXyKIPiOkBCwQwi/l4rWEw
 ACopJZ6ie3mHWLhVZfItuNlI6f4A+KV6n3BsK1EU6dQsEeBVS53H+itFfhkNFosdup8M
 twxAj4sj8TnnRYMKXMFvEgaRVsZgkMmIQgLX1KAqhQqUqzfSp9MdZjmRX0VTXGzBEWtZ
 X7tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTcNDTy4Qo1530UC1xNLTMsI/Sohu5QRmykrabaFxA4lusbPDEzkvlvqruMLgGNTC560LOaAgpIN/K@nongnu.org
X-Gm-Message-State: AOJu0Yw27evkFoL7DnPM8nx/kwrWv4Dnf6fAOuiz1wFS9MDbWTnuDG4B
 gvaoZpoecU8bSi5Mn3DaEBlXA6rT8T0e0Z0FtKVrvaOBj5DkBduI7PBYo+yMKcNm1kMDwrSSunj
 vJriIKOdYJwaOODfaq+47lQX8FL+OAenSaqW53g==
X-Google-Smtp-Source: AGHT+IEg3CPESgEp/xmmgn2rsGZw32C4mgQVe/MjGwEUMTtH9CzBc89Ms9W4JgZ/161JkxeAkkFnoxvOIHuD4D3hciM=
X-Received: by 2002:a17:907:9495:b0:a9a:5d15:26c2 with SMTP id
 a640c23a62f3a-a9de619c888mr1137088566b.45.1730205855750; Tue, 29 Oct 2024
 05:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <Zxvinao2jcZgyAVG@p100>
In-Reply-To: <Zxvinao2jcZgyAVG@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 12:44:04 +0000
Message-ID: <CAFEAcA9N4fq6E9PAtkVPh=qArfZ56jdNoKDNUTUb7+u3d4VNJg@mail.gmail.com>
Subject: Re: [PATCH] target/hppa: Add CPU reset method
To: Helge Deller <deller@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Fri, 25 Oct 2024 at 19:25, Helge Deller <deller@kernel.org> wrote:
>
> Add the missing CPU reset method, which resets all CPU registers and the
> TLB to zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not
> set) and start execution at address 0xf0000004.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index c38439c180..0cc696ccd3 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -235,15 +235,39 @@ static const TCGCPUOps hppa_tcg_ops = {
>  #endif /* !CONFIG_USER_ONLY */
>  };
>
> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
> +{
> +    HPPACPU *cpu = HPPA_CPU(obj);
> +    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
> +    CPUHPPAState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (scc->parent_phases.hold) {
> +        scc->parent_phases.hold(obj, type);
> +    }
> +
> +    memset(env, 0, sizeof(*env));

I would recommend doing what the other CPU classes do
and having an end_reset_fields marker in your state
struct to mark the last point which is zeroed out

    /* Fields up to this point are cleared by a CPU reset */
    struct {} end_reset_fields;

which you then do with:
    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));

In particular, I'm pretty sure you don't want to zero out
pointer fields like tlb_partial. (That kind of data-structure
piece of the cpu state struct either needs by-hand code to
reset it to power-on state, or in some cases may be OK to
simply leave alone across reset, depending on what it is.)

> +
> +    cpu_set_pc(cs, 0xf0000004);
> +    env->psw = PSW_Q;
> +
> +    cs->exception_index = -1;
> +    cs->halted = 0;

hppa_cpu_initfn() currently does these:

    cs->exception_index = -1;
    cpu_hppa_loaded_fr0(env);
    cpu_hppa_put_psw(env, PSW_W);

They should probably be moved to reset (or deleted, for
the cases where the reset code above already does that work).

PS: the PSW reset value looks like a behaviour change. If that's
intentional you probably want to do it in a separate patch.

> +}
> +
>  static void hppa_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      CPUClass *cc = CPU_CLASS(oc);
>      HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
>
>      device_class_set_parent_realize(dc, hppa_cpu_realizefn,
>                                      &acc->parent_realize);
>
> +    resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, NULL,
> +                                       &acc->parent_phases);
> +
>      cc->class_by_name = hppa_cpu_class_by_name;
>      cc->has_work = hppa_cpu_has_work;
>      cc->mmu_index = hppa_cpu_mmu_index;

The machinery for registering the reset handler function
all looks good.

thanks
-- PMM

