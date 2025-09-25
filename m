Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E39CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jp4-0004N9-Fu; Thu, 25 Sep 2025 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jp0-0004Kq-Gl
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:07:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jom-0003g1-Hf
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:07:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e2562e8cbso7050175e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758798434; x=1759403234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EGJ+v7EjpOgKcmwagB2CC23aehgXIDcz1dCQpIYApz8=;
 b=T7YCYox9Tw0FB2g9B8LbhDX0dseTXkuitscEFjHsKoiu4SGgeBetxxAdNulF/Hs5/j
 zoQOuIjDMp08yQjs4Rnyy10LntQsk4TpHbimJGTXa5Zupm/ngQuJA46HgWgKklybpXTw
 Mg3UUywqIy1HFugmcDnXHuk+JGQl4y/pgNjOKg3mNkhiipx92Bh1TXyZHKaZN7Xj+O/W
 7NAh3rrIipFZ3AweEFl+TpLMhHodvbQYoALHwTx2+/JawTcnUKFOt21Xc0wjm3w5+MLO
 v5aXy5LrkLeMbIrIQZ4upz9q9VcCO8LBHE59PcbjAfB6GIE7Pa7Q6t2EQmF3NbfZSXfP
 qflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758798434; x=1759403234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EGJ+v7EjpOgKcmwagB2CC23aehgXIDcz1dCQpIYApz8=;
 b=X5/X8mKPWCGuYCd+onxZtkWYZK/H1nBJGZ4fwHqU/zjOvnLi4xqmYMK6/LTW2ZmExX
 /6NKp2FAIpJJMOA1ZLibec1XBCc5MsizmRb+LG+1P00yNmWih7GldMcaF4RvgcMzngDg
 WURiW6sm7IQXSSF0RwkeppyHKOp28eVUWXPnBiHuvgEUTAmYdOBRsJ4unmpMWV2fbu2l
 x0nRRRbF9Y5F9o5n4UcKnYfrG4xPj8Trc5kttg3q0bNMIl9HKtRuFNjiPSCZBx75y5P6
 ELnOMIyqzm47qgRmq52+2wmM8gf4953Ebc/fNLxl/smVuDNGeCI7nhXpX4/wW/zgJeJC
 eRCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRIjnSgGlaycKZoC3iF4CE8Hhcj6QuipExQvjcQ90VRKGTAk4A0EqIRSKJ3Fx5z9S7Dhz2CgWCqatd@nongnu.org
X-Gm-Message-State: AOJu0Yy5CE0/oi4qBvl3pg7C6C/xPkR3+RUanp5Ph6iP2PKW9Edr7iqG
 XFp6iT+WGM5lRA/TsdanrDkgN1PLArFEjwfgMuebfNBP44LIdtigLV29aUBOwuQw/0g=
X-Gm-Gg: ASbGncuSkU7MVSfM9JFXaG8WqcVG9twNlhqtYexaQs3qr7206Pr2BiVV+//Ifu+TlOs
 kt55LvkWiJwZF2fWnbvWFG8HyUqHnY5BPomDa0etWxUqXnHHnPkaCgp0IOhdNmuB+2JJLg0BgPs
 2mGoDgnwkrwGklOMBf/f/Qfq0lIZQ/ena01HeGR8C84uW3loSdidEuOvx9C161/DrFh0e9VRQso
 rL/JGpfmsiqRMoER22pRTnIZRAzEiEipz6p9bKSS2pWG2U9KrlEbqbCPG+RUU782SCKNCkzwHPS
 THD4JjFs5PMjAcQsKAVrK572WwWCqTcwixZdk2i1bDfVYM23UCA+hILiFHFB7D6H1USIBh7DNzS
 0XN65l67GWOztGTtjh6STd4kwaVWROUbSnBVAczx8QH1UKky/yVqQHvh7Zm3qWKsJsm7PKNVxoi
 Z4
X-Google-Smtp-Source: AGHT+IEy2H9kXSltcze/jFKG+7ojduFoorQ8Zfv5OhlPeToFvUsv5t5FyDqI/IJLIZGlUOcuNMHUFg==
X-Received: by 2002:a05:600c:35c1:b0:45f:bef7:670b with SMTP id
 5b1f17b1804b1-46e329afecamr33037025e9.3.1758798434373; 
 Thu, 25 Sep 2025 04:07:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb21esm2622452f8f.7.2025.09.25.04.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:07:13 -0700 (PDT)
Message-ID: <63a29a08-67ea-449f-954b-f62abbc39346@linaro.org>
Date: Thu, 25 Sep 2025 13:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/36] target/arm: Add key parameter to
 add_cpreg_to_hashtable
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Hoist the computation of key into the caller, where
> state is a known constant.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4a109a113d..a5195e296d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7424,26 +7424,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>   static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>                                      CPState state, CPSecureState secstate,
>                                      int cp, int crm, int opc1, int opc2,
> -                                   const char *name)
> +                                   const char *name, uint32_t key)
>   {
>       CPUARMState *env = &cpu->env;
> -    uint32_t key;
>       ARMCPRegInfo *r2;
> -    bool is64 = r->type & ARM_CP_64BIT;
>       bool ns = secstate & ARM_CP_SECSTATE_NS;
>       size_t name_len;
>   
> -    switch (state) {
> -    case ARM_CP_STATE_AA32:
> -        key = ENCODE_CP_REG(cp, is64, ns, r->crn, crm, opc1, opc2);
> -        break;
> -    case ARM_CP_STATE_AA64:
> -        key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
>       /* Overriding of an existing definition must be explicitly requested. */
>       if (!(r->type & ARM_CP_OVERRIDE)) {
>           const ARMCPRegInfo *oldreg = get_arm_cp_reginfo(cpu->cp_regs, key);
> @@ -7548,22 +7535,28 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
>        * (same for secure and non-secure world) or banked.
>        */
>       char *name;
> +    bool is64 = r->type & ARM_CP_64BIT;
> +    uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
>   
>       assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
>   
>       switch (r->secure) {
> -    case ARM_CP_SECSTATE_S:
>       case ARM_CP_SECSTATE_NS:
> +        key |= CP_REG_AA32_NS_MASK;
> +        /* fall through */
> +    case ARM_CP_SECSTATE_S:
>           add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
> -                               cp, crm, opc1, opc2, r->name);
> +                               cp, crm, opc1, opc2, r->name, key);
>           break;
>       case ARM_CP_SECSTATE_BOTH:
>           name = g_strdup_printf("%s_S", r->name);
>           add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
> -                               cp, crm, opc1, opc2, name);
> +                               cp, crm, opc1, opc2, name, key);
>           g_free(name);
> +
> +        key |= CP_REG_AA32_NS_MASK;
>           add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
> -                               cp, crm, opc1, opc2, r->name);
> +                               cp, crm, opc1, opc2, r->name, key);
>           break;
>       default:
>           g_assert_not_reached();
> @@ -7573,6 +7566,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
>   static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
>                                           int crm, int opc1, int opc2)
>   {
> +    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
> +
>       if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
>           cpu_isar_feature(aa64_xs, cpu)) {
>           /*
> @@ -7587,18 +7582,22 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
>            */
>           ARMCPRegInfo nxs_ri = *r;
>           g_autofree char *name = g_strdup_printf("%sNXS", r->name);
> +        uint32_t nxs_key;
>   
>           assert(nxs_ri.crn < 0xf);
>           nxs_ri.crn++;
> +        nxs_key = key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);

This is new but not mentioned. While the CRN bit is know to be 0,
we usually use '|' to set a bit, not '+'. Preferably using '|':

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           if (nxs_ri.fgt) {
>               nxs_ri.fgt |= R_FGT_NXS_MASK;
>           }
> +
>           add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
> -                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2, name);
> +                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
> +                               name, nxs_key);
>       }
>   
>       add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
> -                           0, crm, opc1, opc2, r->name);
> +                           0, crm, opc1, opc2, r->name, key);
>   }
>   
>   void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)


