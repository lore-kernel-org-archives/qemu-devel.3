Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB754CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsPE-0007lV-9U; Mon, 18 May 2026 03:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsPB-0007ks-PS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:28:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsP8-0006jU-H2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:28:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so989142f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779089324; x=1779694124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PvpEhJkbS4tG30UKHyo37GodO1FIgoR7eP2D7LXpmfM=;
 b=ag2sVXi3XDUNVlDLDNtpK1/afcvY3ubYfABVWN2DoFqYJU0194Ne2LyYcUVC4tV4BJ
 dURBjtlALUJIJSm9LJ82a0KXCDmEEpbN1qRE4Mp4at8s/EyUjcxvjFZVDR4Zc5XKYkmA
 /vIsZorhE3rFYM02uwLXjVX6Yq6IkpMGxnuUGJ7AJc/VMHsIUqKIiCH+oNZqe90O0HWN
 HrQD/Fgye/1f7QxyqI6LBAHM+PDHQ2lJ5xLWEidCttcm6rPuN/nzt0C4KO4ll62O5UXW
 UZS7UcOLKrNQy4PZKSOi6Uh4uC25dnVkxErNNVy7a1SAp7JBYvb5QlvQ4RrM38bEr36g
 dIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089324; x=1779694124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PvpEhJkbS4tG30UKHyo37GodO1FIgoR7eP2D7LXpmfM=;
 b=QqtgTGY83EHDCUyE30dlhER2qZTJ2DEzY6jmFtyf7MQ6wFjLNTisdQlkdpBBJ3vvpN
 nA0r0XGzssQTEv7ZU57ly3CXB2B2vtxZajxmC8DJMZtqjdKd6XwAITDcZm/sE36ptk60
 kYMTf1ieMgO7AHQQApu0ziDHWsK+35cSdknc85/ofjECH9acOh904oRE97L8NBiv5wrp
 yL2F+c+DMVVv7QF737GCQ8CVSo66RjUmKVTnp5VPoACmq5HC6PEJ8NsgB5EZm72znB+7
 BYTZTEnRCVg6i2p76jScK4XvJoMiAB8rbK0p+y0Lruqo/VMDxsHuE2kC0wBJac/iB/y8
 uukg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZpkEfYU356xXrtMlPWrPp7t4pusSPQ/5SQ5YUQo3jDlDtnN0fr6vKay6I0+qJz+RT1PLX0I2wWjYN@nongnu.org
X-Gm-Message-State: AOJu0Yy4AqBG5RBldZS34HeeMIZRtC7kZTVbOsECLbPZyrr6A7jc6mYq
 zbfVPIslrk6/g+/SwZPCMTHwx2nxXIB/VfAnl0+gUUONveS+6mHviEvAaedm+WfVOLw=
X-Gm-Gg: Acq92OFtjfOWQ2wzojSBMjgWeYv6jJUSk6dgs9hRrEnprPifktFdQSk74bknrPmRi9H
 TOM0fg5g/EJRM2XPsMoFSsHzQx1EeCb1mLWHFD8uCEYRJ3u1Fi0x5i5YEJnCkKgrtTwEwItQdxs
 v9+18immdqML2bZfhTqfw/G8IOS2UslYIacfTAJZOGh1KOila9DPOsQwr/0nWl3YkKu3Yx9y+4W
 ATltWQ2LrIO8LqiqiaCsfdBdzI6ZWsqgUYuP8JZalv4ci7CKoIBhlNWPBX3wDb2cJtsvJLRIwvd
 0dpIRN9kb8Y4WVY62RPd2QKq5c7pdAjLNj8odoS7MjpUjU9U1xmYW0Pt5aM5ILWQ9ZDvN0KuyxU
 7JHwfuRGahBXn2zKrBBiSivB1xTweV/LjMhJwJ14pIthzhZP72UuXG233icFmMPfjYwSb0zp9sI
 PZq5J1C4R3lwXI1mk4/job6Tft6I7tUawgRcJuOvEkzyv4ZKF+bbTCY0LYnPDRaXMEdQTSO2br8
 kGB
X-Received: by 2002:a5d:5d01:0:b0:43d:73d4:b34 with SMTP id
 ffacd0b85a97d-45e5c5a10b0mr21057067f8f.16.1779089324249; 
 Mon, 18 May 2026 00:28:44 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm36227965f8f.21.2026.05.18.00.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:28:43 -0700 (PDT)
Message-ID: <b0facd32-6684-48e9-8dbf-9b779ad994ca@linaro.org>
Date: Mon, 18 May 2026 09:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Convert priv_spec property from string to
 enum
Content-Language: en-US
To: khaled saleh <khaled.saleh.req@gmail.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, Markus Armbruster <armbru@redhat.com>
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Cc'ing QAPI maintainer

On 17/5/26 21:28, khaled saleh wrote:
> The priv_spec property accepts a fixed set of values (v1.10.0, v1.11.0, v1.12.0, v1.13.0) but was implemented as a string type with manual string-to-enum conversion in custom getter/setter functions.
> 
> Convert it to use QEnumLookup with visit_type_enum() for:
> - Automatic input validation by the visitor framework
> - QMP introspection support (valid values are discoverable)
> - Reduced boilerplate (priv_spec_from_str/to_str removed)
> 
> This resolves the "FIXME enum?" comment in cpu.c.
> 
> Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
> ---
>   target/riscv/cpu.c         | 59 +++++++++++---------------------------
>   target/riscv/cpu.h         |  1 +
>   target/riscv/tcg/tcg-cpu.c |  3 +-
>   3 files changed, 20 insertions(+), 43 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 506a018d52..8365471572 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -26,6 +26,7 @@
>   #include "internals.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> +#include "qapi/util.h"
>   #include "qemu/error-report.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-prop-internal.h"
> @@ -1655,51 +1656,25 @@ static const PropertyInfo prop_pmp_granularity = {
>       .set = prop_pmp_granularity_set,
>   };
>   
> -static int priv_spec_from_str(const char *priv_spec_str)
> -{
> -    int priv_version = -1;
> -
> -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> -        priv_version = PRIV_VERSION_1_13_0;
> -    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> -        priv_version = PRIV_VERSION_1_12_0;
> -    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
> -        priv_version = PRIV_VERSION_1_11_0;
> -    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_10_0_STR)) {
> -        priv_version = PRIV_VERSION_1_10_0;
> -    }
> -
> -    return priv_version;
> -}
> +static const char *const priv_spec_str[] = {
> +    [PRIV_VERSION_1_10_0] = PRIV_VER_1_10_0_STR,
> +    [PRIV_VERSION_1_11_0] = PRIV_VER_1_11_0_STR,
> +    [PRIV_VERSION_1_12_0] = PRIV_VER_1_12_0_STR,
> +    [PRIV_VERSION_1_13_0] = PRIV_VER_1_13_0_STR,
> +};
>   
> -const char *priv_spec_to_str(int priv_version)
> -{
> -    switch (priv_version) {
> -    case PRIV_VERSION_1_10_0:
> -        return PRIV_VER_1_10_0_STR;
> -    case PRIV_VERSION_1_11_0:
> -        return PRIV_VER_1_11_0_STR;
> -    case PRIV_VERSION_1_12_0:
> -        return PRIV_VER_1_12_0_STR;
> -    case PRIV_VERSION_1_13_0:
> -        return PRIV_VER_1_13_0_STR;
> -    default:
> -        return NULL;
> -    }
> -}
> +const QEnumLookup priv_spec_lookup = {
> +    .array = priv_spec_str,
> +    .size = ARRAY_SIZE(priv_spec_str),
> +};
>   
>   static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> -    g_autofree char *value = NULL;
> -    int priv_version = -1;
> -
> -    visit_type_str(v, name, &value, errp);
> +    int priv_version;
>   
> -    priv_version = priv_spec_from_str(value);
> -    if (priv_version < 0) {
> -        error_setg(errp, "Unsupported privilege spec version '%s'", value);
> +    if (!visit_type_enum(v, name, &priv_version, &priv_spec_lookup, errp)) {
>           return;
>       }
>   
> @@ -1718,15 +1693,15 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> -    const char *value = priv_spec_to_str(cpu->env.priv_ver);
> +    int value = cpu->env.priv_ver;
>   
> -    visit_type_str(v, name, (char **)&value, errp);
> +    visit_type_enum(v, name, &value, &priv_spec_lookup, errp);
>   }
>   
>   static const PropertyInfo prop_priv_spec = {
> -    .type = "str",
> +    .type = "RISCVPrivSpec",
>       .description = "priv_spec",
> -    /* FIXME enum? */
> +    .enum_table = &priv_spec_lookup,
>       .get = prop_priv_spec_get,
>       .set = prop_priv_spec_set,
>   };
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fae839cade..522b63016f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
>   #define RVG RV('G')
>   #define RVB RV('B')
>   
> +extern const QEnumLookup priv_spec_lookup;
>   extern const uint32_t misa_bits[];
>   const char *riscv_get_misa_ext_name(uint32_t bit);
>   const char *riscv_get_misa_ext_description(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 02c98cc2db..2ec4b8e98e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -27,6 +27,7 @@
>   #include "time_helper.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> +#include "qapi/util.h"
>   #include "qemu/accel.h"
>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
> @@ -86,7 +87,7 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
>   
>   static const char *cpu_priv_ver_to_str(int priv_ver)
>   {
> -    const char *priv_spec_str = priv_spec_to_str(priv_ver);
> +    const char *priv_spec_str = qapi_enum_lookup(&priv_spec_lookup, priv_ver);
>   
>       g_assert(priv_spec_str);
>   


