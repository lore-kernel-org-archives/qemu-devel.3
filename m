Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBC8C28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgvg-0007Pf-P3; Thu, 13 Mar 2025 07:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tsgvf-0007P7-U8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:40:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tsgvZ-0004tK-1z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:40:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso13719635ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741866038; x=1742470838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2C0/1iiRnXXrGzsGkuEmeEE64O9iSLHDARRgo/qxu6E=;
 b=GCmpv3rKSv90aSIGoptfD9g5sYDp0fZy/+qLZOSXi2MA0BDAlf9PAwUSulX013CNe2
 8A7Sqj9G/zhHmiy2MYMfX+jYC857pmN8uxKfwuiOuBhiHQwJMLJ9/OHvTspEm+e0a2us
 dNm3tDkWM7gO8LC/M+8k5BEaDosFR464yoAjksofqBSbOvbvNF7vrrkkrN88k/YxiCZ6
 +Fu4dvMVfR0nouc3gK8VfawJL/9/F9wW4mFA1WsGkBxw2HCyPX1N10MU2L0R+jSowvPq
 QJhY+icHR/+193WsRekoJ4cOg3C8kd29BkBjKJIgDFyyPEUbpmMdW7qQD8ozL9hMSETy
 BkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741866038; x=1742470838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2C0/1iiRnXXrGzsGkuEmeEE64O9iSLHDARRgo/qxu6E=;
 b=VxrAc6ofVN3I69q4zE9FTOTl/lD4T80qiRONpgmRDlv0g5Nx+fKphPeH+EdjiSqLCJ
 AJ5bbSLzP9uhFqtFFjVMkjKWQ2RMQKwYz0kcd5aLKqa8Bl5uLUK+OUdQGcgKKajtWSGj
 /CsYGTDPjnxwpTxB7kT/2GMT4udIRGXiDMyrvVxJezkArx4jP8KxaCpQDg8GO/cviWv1
 HXzQvuJ2eGw5uVO11N5O7JLFagz8pDM8Fuw3A9q7BKtnl9VWrwFxLrlThRn4sElXkoG4
 wZYfR7XofZJfUcqR7sWJ/m5Wwj1i9gwtot0fik2MiNdSOl3rWCbMBQyAjzeqrKWjBT8f
 z2og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWsROuW/3KxhNS9hd8h7TXu672lo0kEMfISsXFUuAzGMMUx75k3Ud9e9iFCE6oPj+e2HU8Unbh5NiT@nongnu.org
X-Gm-Message-State: AOJu0YzSrtGyTy1/dv2fkOWCgZFcrXVcFC8uDc6R7pQLKbPOTclDpuES
 a1TqGpgobUANZlAZBkvd99Nm81Z70lyo3Le11BjngRd1LIZM+PfIMMlDvdNyzuM=
X-Gm-Gg: ASbGncu5QyNQssR9aHwnCHuldCPsio9T269trlXbN1LzBrQxfoJxgYrI+ps5AeKm+MI
 4Y88MCEPQbmQZw0Ir0fQmntquGeoYD4LNPx6QKp4CLvw6GTX52usCuZjqvqV+R+KOdZoLHO9SlN
 NvZaJSG0jRq+5gjqT3xkGZOmzogMZaFmzX9CzfAZlO8eIJm3BmtGn9o+lhDipbrArGcOUBteAYb
 ZEEge2NdJsD/HXEcoqhRotbQEzICD3mjh0+UPP6yuqy9/OfkUrMjcvBilL/whDu6hPf4PlpfykG
 5j58IA1fZ1D7m4lkYhus/LQZlXEykAqzPDG/noB8/0BEYLj0B+O9id3LC1ICeeE9HHeOZkiDWPe
 I1rPjjbfo1EynWL+ojdbXhnU=
X-Google-Smtp-Source: AGHT+IFGlaTJIgxPDUWlYnZAtrIDJ6AvK54lJzRxChoydGs0UWkGcbT0YrnFGKKhSUYA6CTADoqEtw==
X-Received: by 2002:a05:6a00:174c:b0:736:450c:fa54 with SMTP id
 d2e1a72fcca58-736aa9f132fmr33383943b3a.6.1741866038094; 
 Thu, 13 Mar 2025 04:40:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:89fc:59f0:a5a7:feb2:304e?
 ([2804:7f0:bcc0:89fc:59f0:a5a7:feb2:304e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711559289sm1149037b3a.68.2025.03.13.04.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 04:40:37 -0700 (PDT)
Message-ID: <bb50a8a4-9d82-4f57-b1d6-b2e6b4b95212@ventanamicro.com>
Date: Thu, 13 Mar 2025 08:40:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
 <20250225160052.39564-2-loic@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250225160052.39564-2-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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



On 2/25/25 1:00 PM, Loïc Lefort wrote:
> When Smepmp is supported, RLB allows bypassing locks when writing CSRs but
> should not affect interpretation of actual PMP rules.
> 
> pmp_is_locked is changed to only check LOCK bit and a new pmp_is_readonly
> function is added that checks both LOCK bit and mseccfg.RLB. pmp_write_cfg and
> pmpaddr_csr_write are changed to use pmp_is_readonly while pmp_hart_has_privs
> keeps using pmp_is_locked.


Note that this change (removing  MSECCFG_RLB_ISSET(env) check from pmp_is_locked())
can impact the behavior of at least one caller in pmp_hart_has_privs():


             if (!MSECCFG_MML_ISSET(env)) {
                 /*
                  * If mseccfg.MML Bit is not set, do pmp priv check
                  * This will always apply to regular PMP.
                  */
                 *allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
                 if ((mode != PRV_M) || pmp_is_locked(env, i)) {
                     *allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
                 }
             }

Setting allowed_privs requires !MSECCFG_RLB_ISSET(env), and after this patch allowed_privs
will be set regardless of MSECCFG_RLB_ISSET(env), at least w.r.t how pmp_is_locked() works.

This might not be an issue and there's not behavioral change. In this case it would be good
to mention in the commit msg why this is the case.

We can just add a !MSECCFG_RLB_ISSET(env) at this point to preserve behavior too.


> 
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> ---
>   target/riscv/pmp.c | 43 ++++++++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 85ab270dad..ddb7e0d23c 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
>    */
>   static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>   {
> -    /* mseccfg.RLB is set */
> -    if (MSECCFG_RLB_ISSET(env)) {
> -        return 0;
> -    }
> -
>       if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
>           return 1;
>       }
> @@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>       return 0;
>   }
>   
> +/*
> + * Check whether a PMP is locked for writing or not.
> + * (i.e. has LOCK flag and mseccfg.RLB is unset)
> + */
> +static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
> +{
> +    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
> +}
> +
>   /*
>    * Count the number of active rules.
>    */
> @@ -90,39 +94,40 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> -        bool locked = true;
> +        bool readonly = true;
>   
>           if (riscv_cpu_cfg(env)->ext_smepmp) {
>               /* mseccfg.RLB is set */
>               if (MSECCFG_RLB_ISSET(env)) {
> -                locked = false;
> +                readonly = false;
>               }
>   
>               /* mseccfg.MML is not set */
> -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index)) {
> -                locked = false;
> +            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
> +                readonly = false;
>               }
>   
>               /* mseccfg.MML is set */
>               if (MSECCFG_MML_ISSET(env)) {
>                   /* not adding execute bit */
>                   if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
> -                    locked = false;
> +                    readonly = false;
>                   }
>                   /* shared region and not adding X bit */
>                   if ((val & PMP_LOCK) != PMP_LOCK &&
>                       (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
> -                    locked = false;
> +                    readonly = false;
>                   }
>               }
>           } else {
> -            if (!pmp_is_locked(env, pmp_index)) {
> -                locked = false;
> +            if (!pmp_is_readonly(env, pmp_index)) {
> +                readonly = false;

Here we can do:

                   readonly = pmp_is_readonly(env, pmp_index);

And spare an extra if.


Thanks,

Daniel

>               }
>           }
>   
> -        if (locked) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
> +        if (readonly) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ignoring pmpcfg write - read only\n");
>           } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
>               /* If !mseccfg.MML then ignore writes with encoding RW=01 */
>               if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> @@ -524,14 +529,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
>               is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
>   
> -            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
> +            if (pmp_is_readonly(env, addr_index + 1) && is_next_cfg_tor) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
> -                              "ignoring pmpaddr write - pmpcfg + 1 locked\n");
> +                              "ignoring pmpaddr write - pmpcfg+1 read only\n");
>                   return;
>               }
>           }
>   
> -        if (!pmp_is_locked(env, addr_index)) {
> +        if (!pmp_is_readonly(env, addr_index)) {
>               if (env->pmp_state.pmp[addr_index].addr_reg != val) {
>                   env->pmp_state.pmp[addr_index].addr_reg = val;
>                   pmp_update_rule_addr(env, addr_index);
> @@ -542,7 +547,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               }
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR,
> -                          "ignoring pmpaddr write - locked\n");
> +                          "ignoring pmpaddr write - read only\n");
>           }
>       } else {
>           qemu_log_mask(LOG_GUEST_ERROR,


