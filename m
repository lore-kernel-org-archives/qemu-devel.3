Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D13D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJGk-0007SE-Nc; Fri, 11 Oct 2024 13:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1szJ8U-0004CO-7C
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:09:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1szDfw-0007rg-7U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:19:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e053cf1f3so1804965b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728645554; x=1729250354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t97p9zZl9/jmYPyVqbjQ4fbIa0dYpZbhd5CdMHNe5A0=;
 b=IA4jtYvvC2DtYvgldY0Cd+xNX9p3UfoMz+GNkP2pek9Z0GHBVcc31IX5tMSdHINBac
 9ovKsBv7wRfE/pshngVxxueqybPw8+cDaMfyp1QdpEeNFi5+/Ggvf8dSX6b+sxUePtUY
 nFBszZF3vBf60XR03w7rP3vSwrUTzy29Sy5pgVxpZn9hFcykrPbyHmNqpB25wTJIELPj
 lfO9hJDDdNYIroIuXDRl1S2TpeZMlcgLRwhoLzbi7ZzGjefGhA6+4Gcn1aCaAzWwMkJF
 QbRxdXKwS2JRYoKJt44EsJgjzGsPDJJsrhWcnlCeN43n+fJ2N/u9BwjNVsHy9QAkMHEt
 9H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728645554; x=1729250354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t97p9zZl9/jmYPyVqbjQ4fbIa0dYpZbhd5CdMHNe5A0=;
 b=q4nBentc6Tq38yA4NGacTws2/VaczTK9lRVdJU2liTtNIh9w40Dk/7uXZ+32V/XsV6
 1YucUFZbj5ycdQdU2L18jveB4Pt5klc9o1fVG7eAMzPRSz/i5W8oJkOWLEQI6R/8iovM
 An91W90/j6WWyli3dPoJ3XDV9nyQWS8eH2/X3lkUQWcE5u/zD9bGqJ6R7cAC0e1HpYiV
 BROEhXcKjaCzQ6fb0bbcFjLFBTU18uoYbvOFEMU3ejVTSPFqL6zaJS9YxqhQksuXTeeR
 OBOzaukJ2oI4P9oNL+ImGhRkW/aSBkrEEcnT/NoA3KYtYZBKyD7L8QKfLyBFjiajzOp6
 kRWQ==
X-Gm-Message-State: AOJu0YxHbKw0gqlOR2SDS3pAY0sI7lTklfPL87YYbAY/gjqZLUaK+1EY
 bS+nwulACeVeEMY9QXaBAY40Bhl3WiAK8DOXRHt5SBsusPZA/CxRCNc9TfcGZTY=
X-Google-Smtp-Source: AGHT+IHKNDheTB7yfXWt13ICE59DdO3XHt7Sg4EeFgg22+YZahJIwkR+l0rB1hbQ18VB/TpKpKyIZQ==
X-Received: by 2002:a05:6a21:1796:b0:1d7:2249:67a with SMTP id
 adf61e73a8af0-1d8bcf9f071mr3477871637.36.1728645554319; 
 Fri, 11 Oct 2024 04:19:14 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-198.dsl.telesp.net.br.
 [201.68.240.198]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aa938aesm2381903b3a.133.2024.10.11.04.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 04:19:13 -0700 (PDT)
Message-ID: <b7271701-195a-461d-ba64-e2a02c634177@ventanamicro.com>
Date: Fri, 11 Oct 2024 08:19:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv/kvm: add kvm-aia bools props
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <20240924124407.766495-4-dbarboza@ventanamicro.com>
 <CAKmqyKMMRCFvWYa1GjwkbJsBh8q_OgtA2UVdaNEJsr=N66hvkQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKMMRCFvWYa1GjwkbJsBh8q_OgtA2UVdaNEJsr=N66hvkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/10/24 10:57 PM, Alistair Francis wrote:
> On Tue, Sep 24, 2024 at 10:46 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Boolean properties are preferrable in comparision to string properties
>> since they don't require a string parsing.
>>
>> Add three bools that represents the available kvm-aia mode:
>> riscv-aia-emul, riscv-aia-hwaccel, riscv-aia-auto. They work like the
>> existing riscv-aia string property, i.e. if no bool is set we'll default
>> to riscv-aia-auto, if the host supports it.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 77 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 32f3dd6a43..e256e3fc48 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1671,6 +1671,62 @@ static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
>>       }
>>   }
>>
>> +static void riscv_set_kvm_aia_bool(uint32_t aia_bool, bool val)
>> +{
>> +    bool default_aia_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
>> +
>> +    g_assert(aia_bool <= KVM_DEV_RISCV_AIA_MODE_AUTO);
>> +
>> +    if (val) {
>> +        aia_mode = aia_bool;
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Setting an aia_bool to 'false' does nothing if
>> +     * aia_mode isn't set to aia_bool.
>> +     */
>> +    if (aia_mode != aia_bool) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Return to default value if we're disabling the
>> +     * current set aia_mode.
>> +     */
>> +    aia_mode = default_aia_mode;
>> +}
>> +
>> +static bool riscv_get_kvm_aia_emul(Object *obj, Error **errp)
>> +{
>> +    return aia_mode == KVM_DEV_RISCV_AIA_MODE_EMUL;
>> +}
>> +
>> +static void riscv_set_kvm_aia_emul(Object *obj,  bool val, Error **errp)
>> +{
>> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_EMUL, val);
>> +}
>> +
>> +static bool riscv_get_kvm_aia_hwaccel(Object *obj, Error **errp)
>> +{
>> +    return aia_mode == KVM_DEV_RISCV_AIA_MODE_HWACCEL;
>> +}
>> +
>> +static void riscv_set_kvm_aia_hwaccel(Object *obj,  bool val, Error **errp)
>> +{
>> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_HWACCEL, val);
>> +}
>> +
>> +static bool riscv_get_kvm_aia_auto(Object *obj, Error **errp)
>> +{
>> +    return aia_mode == KVM_DEV_RISCV_AIA_MODE_AUTO;
>> +}
>> +
>> +static void riscv_set_kvm_aia_auto(Object *obj,  bool val, Error **errp)
>> +{
>> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_AUTO, val);
>> +}
>> +
>>   void kvm_arch_accel_class_init(ObjectClass *oc)
>>   {
>>       object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
>> @@ -1681,6 +1737,27 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>>           "if the host supports it");
>>       object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
>>                                       "auto");
>> +
>> +    object_class_property_add_bool(oc, "riscv-aia-emul",
>> +                                   riscv_get_kvm_aia_emul,
>> +                                   riscv_set_kvm_aia_emul);
>> +    object_class_property_set_description(oc, "riscv-aia-emul",
>> +        "Set KVM AIA mode to 'emul'. Changing KVM AIA modes relies on host "
>> +        "support. Default mode is 'auto' if the host supports it");
>> +
>> +    object_class_property_add_bool(oc, "riscv-aia-hwaccel",
>> +                                   riscv_get_kvm_aia_hwaccel,
>> +                                   riscv_set_kvm_aia_hwaccel);
>> +    object_class_property_set_description(oc, "riscv-aia-hwaccel",
>> +        "Set KVM AIA mode to 'hwaccel'. Changing KVM AIA modes relies on host "
>> +        "support. Default mode is 'auto' if the host supports it");
>> +
>> +    object_class_property_add_bool(oc, "riscv-aia-auto",
>> +                                   riscv_get_kvm_aia_auto,
>> +                                   riscv_set_kvm_aia_auto);
>> +    object_class_property_set_description(oc, "riscv-aia-auto",
>> +        "Set KVM AIA mode to 'auto'. Changing KVM AIA modes "
>> +        "relies on host support");
> 
> This seems more confusing. What should happen if a user sets multiple to true?

It'll work like most options in QEMU: the last setting will overwrite the previous
ones. "-accel kvm,riscv-aia-hwaccel=true,riscv-aia-emul=true" will set the mode
to 'emul'. This is the same behavior that we have with the existing 'riscv-aia'
string option.

In case someone tries it out with multiple -accel options, this doesn't work. Only
the first '-accel <type>' are parsed. This happens due to a known command line
parsing/accel globals issue that I tried to fix in [1] and [2].

For now, using the existing 'riscv-aia' string option:

-accel kvm,riscv-aia=emul -accel kvm,riscv-aia=hwaccel -accel kvm,riscv-aia=auto

This will set riscv-aia to "emul" because all other "-accel kvm" options aren't
being parsed. You can do silly stuff like:

-accel kvm,riscv-aia=emul -accel kvm,riscv-aia=this_is_not_an_option

And the guest will boot normally, setting riscv-aia to 'emul'.


Thanks,

Daniel


[1] "[PATCH 0/2] system/vl.c: parse all '-accel' opts"
     https://lore.kernel.org/qemu-devel/20240701133038.1489043-1-dbarboza@ventanamicro.com/
[2] "[PATCH v2 0/2] object,accel-system: allow Accel type globals"
     https://lore.kernel.org/qemu-devel/20240703204149.1957136-1-dbarboza@ventanamicro.com/


> 
> Alistair
> 
>>   }
>>
>>   void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>> --
>> 2.45.2
>>
>>

