Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7597D26D92
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veHKZ-0007EL-Ni; Fri, 09 Jan 2026 13:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veHKX-0007Cr-Gr
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:35:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veHKV-00077z-Jr
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:35:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so32773185ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767983722; x=1768588522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/B7FXO9doS4KJrmAFc+kmK6Yc8Xt2URaw1dLL1hS4W4=;
 b=Zso+t2w1s7eWg0ZBrkM4NfAbgKGwQRq7rmuU30bUpJTixIcomWXzzXy8F6wH6j3iYn
 3iTKk5v5eiM7EQCQCSnkTSFHf7wMOVNPpTUg4/TSZhLSc2llviijcCURdtUdHihkj3RZ
 b04UIi0j6a7eoQ0ZAfaugPMzyUVF34GhF8lQolQqDnvuAQgP55HJxuUvc4esQNZdBuEU
 ATkENPN4DqjE4qNCvjy/hcZKWH7mVtygZldGNTFL3B/Tq9LFyETW46NrwF7y1A0GBpSZ
 f1U2ZJ8OBzitSt+yVSo0bKfGwNV93rxXVPWBsrP3Zjdg1baPq4bN9NTCh9xnW0bWhcQa
 qQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983722; x=1768588522;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/B7FXO9doS4KJrmAFc+kmK6Yc8Xt2URaw1dLL1hS4W4=;
 b=j8trCj/S3KeW3ao8X5X6kMvKsgN1kJbgWWIUPeeij3VxHHq65EMyljZtq/f2TDsU5n
 8j4g8vMLLe+bHv+p1EELgmW9mNf1RvTF5+CSUs1h6tq5vIJF4veBUmCBZI8GIx6aom28
 DtdlC1l241d4VXDjjxxY+yTVS+mRqDnffS3lBXFP2rVgVnBmUATdxJwNPAq5REKbgwMy
 GYXUSwDz5ekL2JTEX0KocP3t0E0Xvd72/ZfWfeCLBNEBPGiOYQlnJYhAJjL3TWSPA3ma
 cqP+blZ/ThgJ3MZUyiAzlQ9w1q3k7sVdrg5FXcWLZrOKIt0/sFYPJGp+XV2i4T+rmHw+
 o5kA==
X-Gm-Message-State: AOJu0YyNXFOIozYf6+oI7SDr8ajPuIcVLus3Q1Cytukh+P+agIICI5B8
 17m5n4nNW4Go/kajFZEGrMe0+grgyamq8mMtYqAzFfPDJsAklHAbgzF+gDOGnMsRJHI=
X-Gm-Gg: AY/fxX6CdWXp+H14ohSnTbmV7/qR7Rs4JJ/nclaJNNjngQbDm5cATsaHf8OSKsKe3rb
 WDiHc9mTYQ4+8iHP7ONt4jzQVoW8SX/L3Wl343HE1FGRzYTCrX+x3eGY4KBFod9MlZwXnBUvsaE
 KJ7Px/3Twx2NXFVtM8P4ifQ8weiXnKd6ofqC3CpKW9pQmffK1rgj91F1yawb69klr/UWBiHy5rU
 uYwJ5gJagcCLrjmWY90tXD9gJk0XUu1LGuYtGuPqToCxrpiMzzbQVfGPXifxBUDjwWTrgM2L+WT
 HXt3V8o9c1TGM7xtl8UWrDNJ8zE5qVfT/QJGNnTMEsYcQBYf0w6PkCSv0Dngk7x+VBzvymNGvYl
 yNx03XHJFRv/OrEcKoKg+FA2D///REzAgyTsZOZ07vwIY/jyRT+4lDmLkFrPxnooMjfS/iuo11W
 AwNaOgE0f3s71D+yqCqjRneaWMTWNe+jNR+3ooEbVZhyrtNAJHxACj2osH
X-Google-Smtp-Source: AGHT+IE/pkes6krTOUdF1ekKTMoenVH3rc8x6lJaEvaydaD2Gd5qII3fy18NoyQFi45tKfZMHe+zCQ==
X-Received: by 2002:a17:902:ebcb:b0:2a0:c84f:412c with SMTP id
 d9443c01a7336-2a3ee4e2e12mr106896985ad.57.1767983721641; 
 Fri, 09 Jan 2026 10:35:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd46a9sm112685765ad.93.2026.01.09.10.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 10:35:21 -0800 (PST)
Message-ID: <7e742b47-7c7c-4d96-9462-2d98d678a62f@linaro.org>
Date: Fri, 9 Jan 2026 10:35:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
 <13d81894-53c2-4fda-86da-c9ec484c6ef3@linaro.org>
 <CABgObfb916FeNESDjOhkGx9wqNXqwovWDVx1breg6E8vF9QYvg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfb916FeNESDjOhkGx9wqNXqwovWDVx1breg6E8vF9QYvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/9/26 9:42 AM, Paolo Bonzini wrote:
> 
> 
> Il ven 9 gen 2026, 17:21 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
>      > For them, the death of target_long/target_ulong is not really
>     possible,
>      > because they will have to reinvent include/exec/target_long.h for
>     their
>      > CPUStates.
>      >
> 
>     At this time, I don't have a simple solution to provide to workaround
>     this. As long as compilation units are duplicated, you will have
>     duplicated symbols for any extern symbol, thus preventing to link the
>     final qemu-system binary. So duplication has to be eliminated, one way
>     or another. And multiple type definitions is a barrier for this.
> 
> 
> Yes, the idea is that if the "single binary" will include both i386 and 
> x86_64 targets, they will both use the TARGET_LONG_BITS==64 version 
> (using it also for the 32-bit target) of CPUState, of the TCG frontend 
> and helpers, etc.
> 
> IOW the single binary could build a third copy of target/i386, or reuse 
> the x86_64-softmmu one.
> 
>     By making all files for an architecture "common", TARGET_LONG_BITS is
>     eliminated by design, since it's a poisoned identifier.
> 
> 
> Good point.
> 
>      > include/exec/target_long32.h
>      > ----------------------------
>      > #ifndef TARGET_LONG_BITS
>      > #define TARGET_LONG_BITS 32
>      > #endif
>      > #define TARGET_ADDRESS_BITS 32
>      > #define TARGET_LONG_SIZE 4
>      > typedef int32_t target_long;
>      > typedef uint32_t target_ulong;
>      > #define TARGET_FMT_lx "%08x"
>      > #define TARGET_FMT_ld "%d"
>      > #define TARGET_FMT_lu "%u"
>      > #define MO_TL MO_32
>      >
>      > include/exec/target_long64.h
>      > ----------------------------
>      > #ifndef TARGET_LONG_BITS
>      > #define TARGET_LONG_BITS 64
>      > #endif
>      > #define TARGET_ADDRESS_BITS 64
>      > #define TARGET_LONG_SIZE 8
>      > typedef int64_t target_long;
>      > typedef uint64_t target_ulong;
>      > #define TARGET_FMT_lx "%016" PRIx64
>      > #define TARGET_FMT_ld "%" PRId64
>      > #define TARGET_FMT_lu "%" PRIu64
>      > #define MO_TL MO_64
>      >
>      > ... and use them in include/exec/target_long.h:
>      >
>      > include/exec/target_long.h:
>      > #ifndef TARGET_LONG_BITS
>      > #error TARGET_LONG_BITS not defined
>      > #elif TARGET_LONG_BITS == 32
>      > #include "exec/target_long32.h"
>      > #elif TARGET_LONG_BITS == 64
>      > #include "exec/target_long64.h"
>      > #endif
>      >
>      > Then the single-size targets can replace TARGET_LONG_BITS with:
>      > - a "#define TCG_ADDRESS_BITS" in their translate.c
>      > - a #include "exec/target_longNN.h" in their cpu.h.
>      >
>      > Dual-size targets, instead, can add to their cpu.h an initial stanza
>      > like this:
>      >
>      > #ifdef TARGET_I386
>      > #include "exec/target_long32.h"
>      > #else
>      > #include "exec/target_long64.h" // x86_64 or single binary
>      > #endif
>      >
>      > and keep using target_long.
>      >
> 
>     I'm not sure what we gain from this header mechanics, wouldn't that be
>     better to eradicate TARGET_LONG_BITS completely instead?
> 
> 
> The problem is that dropping target_long in CPUState would be 
> inefficient. For example i386 registers occupy 32 bytes vs. 256 for 
> x86_64. So I would like to keep 32-bit registers for the 32-bit single- 
> target binary.
>

I agree, and that's why the current solution is not the final word on 
this question. My position on the single binary is that runtime 
compromises can be acceptable on our translation path (since it's not 
where we spend most of our time anyway), but definitely not on code 
generated by tcg, which has to be optimal.

In the first version of this series, I defined TCGv as an opaque type 
(i.e. not typedef to i32 or i64), and wrote wrappers for tcg_gen_* ops 
that were casting it to appropriate type and called the i32 or i64 
variants based on current context. After talking with Richard, I 
understood it was not useful for target/arm, since code has been cleanly 
splitted between 32/64 bits, so dropped it for the TCG_ADDRESS_BITS 
approach.

That said, I still think the opaque type + wrapper approach has its 
place for some architectures. It could be used for code where rewriting 
is too complicated, and still allow to generate efficient code. The 
downside is that we need some boilerplate in headers to generate this, 
but it's not something a macro can't help to deal with.

> Compared to the current mechanism, it decouples the choice of 
> TARGET_LONG_BITS from configs/targets/ and makes it possible for target/ 
> */ to pick its preferred length when built for the single binary.
> 
> But anyway this was just a brain dump—we are in sync for what is needed 
> for this series.
> 
>     With Philippe, we introduced target-info.h, to precisely find this
>     information at runtime, with target_long_bits().
>     As well, as you can see in codebase, target_long_bits() is not used in
>     many places, and especially, it's not needed anywhere in target/arm. So
>     it does not seem needed to keep it alive.
> 
> 
> I agree that target_long_bits() should be needed almost nowhere (maybe 
> it's needed for VMSTATE_UINTTL migration but not much else) because 
> ideally all use of target_long/ulong would really be confined to target/ 
> and not be in common code.
> 
> It could be called like an x86_ulong, but it would have to be redone 
> almost the same across all the dual-size targets, hence it's easier to 
> keep the current name and provide a common mechanism.
> 
> Thanks,
> 
> Paolo
> 
>     Thanks for the feedback,
>     Pierrick
> 


