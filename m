Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696B9CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98TN-00048L-I4; Wed, 15 Oct 2025 16:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98TL-00047o-DY
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:51:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98TF-0006GA-Sk
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:51:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so32515f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561499; x=1761166299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tjrmy1Z3U9BD8e55zir0PEsRtADKxT53ZcB5dvG2itg=;
 b=PYtg60vyB7UhO+l0lIRd9nUrXKyajvB61TtbczBktB6YKkq2Khfotljkwh8671TgQR
 78nGChYpIV1mFS2xtcQqoMS+N4Hl3rz236rT06i52bw2Xwp3S+0NNzQnblUEXQogUl31
 UKW+tn7mZ8djL31IcubqYl7+GNnEuds4Q/rugWtTHt0V/qHQHSfFAtV7lss5ADmF9OBF
 q74ym3YKsw/KYi+JCcU/bHWMOjrZlDKmOI/4rbfu4zaDKHvZShDZPPOEoLZ5N35jkw4D
 cOdd3Err5nvNiXFPLLEi8e12x9tRsqdGQePiJi21Y5sCSAKMx0OkJFJEaEn9eH3EXa1O
 pJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561499; x=1761166299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tjrmy1Z3U9BD8e55zir0PEsRtADKxT53ZcB5dvG2itg=;
 b=tNUGBTPz+7LjJicIQh4qX2LmXGcvbLFKx2TadMOqlU+761ciLSvUZUry+fYV1nru2n
 OSptGHWeNH+kq0g+AMM8T6rRwHvhg7efmExEhdkx6/DOfrH//cAk1nRPnQMxzrVeI+ye
 J6/ZXZ5O2BZirA1qd0rhlAn0KT+bdsJ8j9VLJkSn/aWPi2cYDZC7eHCkJ3h2INRBL1/q
 MM+3oM1LXyieOsR0YWG6PSFJVVI5TME3oEECJ7LcBkj8O9Q0ZLELffgPiho35/3kYvur
 b+z3yeC99gjc+HxQhYexPfsMKkc8mLEy/b+Ut8vjdfRPB4lP0V4ckf6ZP/QHtDoU+EFO
 J27A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlJklCEtL2CVXXf6OdRvfymB39mnQjwu4QMYtSjJU4mm71CZhm3iCZNwIJW3CXRWW7xYZtHanFHasF@nongnu.org
X-Gm-Message-State: AOJu0Yzw/CYeTSDrllq1Ld3noOyfjMKfxDOJ5qLAsr6xBxZ/chefsbPf
 Y+yBRbfD7hOuNwpjJpRt2wQgcXyn0lsDyaZ3MPr5xrAEQCzpff8kCwL0CS0xLqqv1bo=
X-Gm-Gg: ASbGncsoTnH5lCCwx+lor5PWcdAuTQYhtj1q2Z9TCfwo7UGu4W2nqpPnMlbqMsKOmuw
 kNRW33I+v9bb4xu9f0wm9pu/wvMQMmpD5es9mae8+zW/Xk1q0IzfQaUsQjy1lsOMed9N80Fjzvx
 5AlkBzwEaOpA2DHY+kXtRsC94i5vPEHuk1RIpb5IQ5pcDTOuIZfr7FYgOwMfJyzpUmjQB2dVCUd
 NqUl81k0Zh1jAk4nksCE1Lwvz6B8w/Dg7kTg24giu9sud8c6Y8I+0sHK4Hua+a8+90dzBa0eY7a
 fR7RJz1vAspJhA6Ln4mGxH+kzCSR1fzPS7Jv1SoOKaO+DJzwNtLdYc+8m2cbBnK1Mtp/xuaubCH
 FR/7pgQQg92L0goXGsfRZBgDs+VjwOkoJJUXogpcXiBstSvG/DVVvKAQZEvUKgYfP3vKPzfhy8o
 etbFQGkFFkNZR8MEDwKeKroWs=
X-Google-Smtp-Source: AGHT+IFc166vMA9FgH0KMCkdfdAfkFL5qYy6l3QIlUoA/txUx4qmvGl/2OyS2WpkKUgW/HNBXbKTGw==
X-Received: by 2002:a05:6000:2dc5:b0:3ec:1b42:1f8d with SMTP id
 ffacd0b85a97d-4266e7cdc81mr18559861f8f.10.1760561498946; 
 Wed, 15 Oct 2025 13:51:38 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583664sm31002575f8f.22.2025.10.15.13.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:51:38 -0700 (PDT)
Message-ID: <3395a80a-d3db-4ebd-a11c-e7746d59c9ce@linaro.org>
Date: Wed, 15 Oct 2025 22:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/34] target/riscv: Fix size of trigger data
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-30-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-30-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 14/10/25 22:35, Anton Johansson wrote:
> mcontext is at most 14 bits in size with the H extension, fix to 16
> bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
> elements, fix to 8 bits.
> 
> Note, the cpu/debug VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h     | 10 +++++-----
>   target/riscv/machine.c | 12 ++++++------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 85ad250a8f..e404b120bc 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -466,11 +466,11 @@ struct CPUArchState {
>       target_ulong mseccfg;
>   
>       /* trigger module */
> -    target_ulong trigger_cur;
> -    target_ulong tdata1[RV_MAX_TRIGGERS];
> -    target_ulong tdata2[RV_MAX_TRIGGERS];
> -    target_ulong tdata3[RV_MAX_TRIGGERS];
> -    target_ulong mcontext;
> +    uint16_t mcontext;
> +    uint8_t trigger_cur;
> +    uint64_t tdata1[RV_MAX_TRIGGERS];
> +    uint64_t tdata2[RV_MAX_TRIGGERS];
> +    uint64_t tdata3[RV_MAX_TRIGGERS];
>       struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>       struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
>       QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 376075b2bd..e86fc58e43 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -239,15 +239,15 @@ static int debug_post_load(void *opaque, int version_id)
>   
>   static const VMStateDescription vmstate_debug = {
>       .name = "cpu/debug",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .needed = debug_needed,
>       .post_load = debug_post_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
> +        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),

Pre-existing, but mcontext is not migrated. Deliberate?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           VMSTATE_END_OF_LIST()
>       }
>   };


