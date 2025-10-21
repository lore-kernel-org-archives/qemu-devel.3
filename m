Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F793CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGl6-0001Pm-4f; Tue, 21 Oct 2025 14:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBGl2-0001Pd-Bi
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:06:52 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBGky-0008MF-Ti
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:06:51 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so3852889a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761070007; x=1761674807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvLZkVfc1JG+QQQ7InzLgwDS5ubXKKyjx0FX5JlIpks=;
 b=HaybcBTXOUzvhhehtl9H/a8dhmjyUjEgm9wzQSeIqxeV+s4P3pEVzb1jYS2ZRY1xXd
 xTXnXYaHw8AgpQQnrG34hWdxF9oIOhEX0HAZVTCI732h/o3/nmPDl8hTpolgTBkPyhAf
 si0wFN+patLL9Tjtc9aJ7uJpN3G4eFTHm3ti/WIU+aQrUSjKtq0h3fSFwCYg+9w2I/40
 ntFJsfDVuVWZQygVIOkS2DAPTT5CK0yaILooEB3xhNjxn70DTzrZOXr5yZ3ZgnTuqz6R
 RVJbTvmBeZs7PT3R1HLMhdPfbBAovFDxT2DrPWCLnctafIWsRi2UbBNa++7Jq635hlmP
 3sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070007; x=1761674807;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvLZkVfc1JG+QQQ7InzLgwDS5ubXKKyjx0FX5JlIpks=;
 b=IFCF4t4P5hw/Gj+vUyYIMeU7v7O2qFOWh3D0HkEl3rppS0lbgJpwuXh/BJwItsAflC
 HCHyXwi/Dl9aPWgMyDGa/5zPi0dR9DMBsN3A2ftq0bjLaNtxRlmf7/f9Hj4CUbOLrHrq
 dgGgkzJkdlgma+4hgu5dO5IkvfwCXXxRc0KDlBChkwGMaKKDuodh58Ym2LL2xbclTE42
 yF7J/as3NJQXhDVPr3M8MioHQeHeeVNBOh2bQ/pPom4JPDxXgZjNLLb10NpvO94I59Mo
 yKY3V0N1N31uh6ybW5XsqGlrzjQZuoo6hYlisYZQMmvxKEMcaBChVl7wkkKityUyV7Fz
 /j2A==
X-Gm-Message-State: AOJu0Yw+s+VJ3KDK+fiGBLNMv8c4tPwoQkODWaHfVlEj4HjHUsurECQq
 36LbN0s5fNzfmaYSvtEch5odL1DiFNq93A/QqF2AdBS/eKFHH2xqrBgByjosQaXb/wA=
X-Gm-Gg: ASbGncsCctdb9rjlNkgv0lKUGBG8BfTOBePyOFlul3oTeO9iEnf711/X8umDM91zFA4
 BHteYt41hhXHlLB+ko1DeyRAT6bd0s2eOb74Gxih9jDBBUqnBldYF0I5M1fxHIdGiHULgViTYob
 qztvF6m6WDEaQEiP6b0LeoTm2dFCcFZE0Js3xjA0yR4uCO1P5aX6h/hLZ6NZWZ+61ROKFNandZZ
 9fnkEypxNsPmULs6WCoqgjchWj7eaZ4xwFcjntCDGFKZAhiz3vSvP3rngOUFT2gOR6jU2SHzm4g
 wWkjzWeRSOGAy1JamPrKHrRhsPLagu0UQmTRYXYeJ967+iuB9Ya9USTsZCf+ekbipOE4URrd6ZU
 /hQyVJTcZmnuL53OVSwpI30EQiguzT2xzV6Z5nDPMz1W0Vhh+o7L2llZGBm42uECU+N00W/jdAK
 zKivm+dR78BejEDWZDr5lTg+Y=
X-Google-Smtp-Source: AGHT+IGivorxOnM+ImIyQsqfmSmlKnBw9ePTEgvNl/qkhwal/Y9DnWmQLBbaotst2zgWZXcU66oZjg==
X-Received: by 2002:a17:902:e881:b0:269:7c21:f3f8 with SMTP id
 d9443c01a7336-290cb07d394mr256735485ad.39.1761070006431; 
 Tue, 21 Oct 2025 11:06:46 -0700 (PDT)
Received: from [192.168.68.110] ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d5c0bsm114829805ad.69.2025.10.21.11.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:06:46 -0700 (PDT)
Message-ID: <46b6cbff-0dfe-4c77-84a0-cadbb238eab7@ventanamicro.com>
Date: Tue, 21 Oct 2025 15:06:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/26] target/riscv: implement MonitorDef HMP API
To: Peter Maydell <peter.maydell@linaro.org>, alistair23@gmail.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
 <20251003032718.1324734-5-alistair.francis@wdc.com>
 <CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+A-VkQS5V6f0+BFRAA@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+A-VkQS5V6f0+BFRAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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



On 10/21/25 12:23 PM, Peter Maydell wrote:
> On Fri, 3 Oct 2025 at 04:29, <alistair23@gmail.com> wrote:
>>
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> The MonitorDef API is related to two HMP monitor commands: 'p' and 'x':
>>
>> (qemu) help p
>> print|p /fmt expr -- print expression value (use $reg for CPU register access)
>> (qemu) help x
>> x /fmt addr -- virtual memory dump starting at 'addr'
>>
>> For x86, one of the few targets that implements it, it is possible to
>> print the PC register value with $pc and use the PC value in the 'x'
>> command as well.
>>
>> Those 2 commands are hooked into get_monitor_def(), called by
>> exp_unary() in hmp.c. The function tries to fetch a reg value in two
>> ways: by reading them directly via a target_monitor_defs array or using
>> a target_get_monitor_def() helper. In RISC-V we have *A LOT* of
>> registers and this number will keep getting bigger, so we're opting out
>> of an array declaration.
>>
>> We're able to retrieve all regs but vregs because the API only fits an
>> uint64_t and vregs have 'vlen' size that are bigger than that.
> 
> Hi; Coverity complains about these functions
> (CID 161401, CID 1641393):
> 
>> +static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>> +                                 target_ulong *val, bool is_gprh)
>> +{
>> +    const char * const *reg_names;
>> +    target_ulong *vals;
>> +
>> +    if (is_gprh) {
>> +        reg_names = riscv_int_regnamesh;
>> +        vals = env->gprh;
>> +    } else {
>> +        reg_names = riscv_int_regnames;
>> +        vals = env->gpr;
>> +    }
>> +
>> +    for (int i = 0; i < 32; i++) {
>> +        g_autofree char *reg_name = g_strdup(reg_names[i]);
>> +        char *reg1 = strtok(reg_name, "/");
>> +        char *reg2 = strtok(NULL, "/");
>> +
>> +        if (strcasecmp(reg1, name) == 0 ||
> 
> Coverity complains because we call strtok() to get reg1,
> and that might return NULL, but strcasecmp() wants a
> non-NULL pointer.
> 
> Similarly with the use of strtok() in reg_is_u64_fpu().
> 
> We could fix this with an assert(reg1) since the
> names are compile-time fixed and it would be an error
> for the string to be empty.
> 
> But taking a step back, strtok() isn't thread safe.
> Maybe we should use g_strsplit() instead ?
> 
> More speculatively, do we need to care about locale here?
> strcasecmp() does a locale-aware comparison, which is
> probably not what we want. (Notoriously Turkish locales
> don't have the upper/lowercase mapping you would expect
> for "i" and "I".) glib has a g_ascii_strcasecmp() which
> might be helpful here.

I don't mind doing both changes. I'll see if things are still working as
expected after doing them and send a fix.

And thanks for the analysis and heads up! I saw the Coverity Scan email in
my inbox today and haven't opened it yet. Seems like I'm on the hook for
CID 161401 and CID 1641393.


Daniel

> 
>> +            (reg2 && strcasecmp(reg2, name) == 0)) {
>> +            *val = vals[i];
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
> 
> thanks
> -- PMM


