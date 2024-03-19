Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB17C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcJL-0006ya-BX; Tue, 19 Mar 2024 12:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmcJJ-0006yD-Ul
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:27:33 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmcJI-0005gp-ES
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:27:33 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51381021af1so8395150e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710865650; x=1711470450; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4CnI4OJ+Mu7USDVO7zhXd32fpbmAfaMlKRv1FQ8aBMw=;
 b=JzHhlVoyeYgr/11ryJMI4LCDcAE5foA1NLNGaef5M5wSd9La9L40CwFREJu718iKQz
 c5v1JZJFTEgprRMSWn5jAlocgqae59vTwMlhATPq60v0c5roeUUtLydHoJv8iM4izECz
 gGDusOsHX0wUE4fiQoSKLrPF/tPeiHO0ShM7KKczrylA8DOHJWmFdkq60H54niMJ8PRN
 V3cSjlslObQ4Y/Z3GgCQtKKTIvsCYlPmjiLZfIeVfwV/eJkDwQTpHLtPQx4P9g8I3eQG
 0Lb8TayyTOEV7FdCzzO0fiX+PuZoskVO0Gsh41Rq7CCVUYuRNPpm0wCcAXgTeOQYwQMr
 vv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710865650; x=1711470450;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4CnI4OJ+Mu7USDVO7zhXd32fpbmAfaMlKRv1FQ8aBMw=;
 b=Y9zv2BN83gAu4urPR6YBeEPGcSHNplp9hcjCa04sQfH/RDK6l0Q1GVzXEBX+Jnz+yT
 xuGLmyRVEReguvadmyUMNmxZkhHwZeJ38xQuSmWLRR6QGa5Y5puFDDA5ASBheU7nf3Ps
 Ws5wge+9CkmzdQMNi+lPwyvKJlG+my6syGsYsBsVYFz/MD9NOsoyGA1Jvy2abAlpQsVZ
 vkW7w6++zms0o7nI9qfIj5b0uGn6jIoIjr1OIRJeHymR4pF7miI7p4TZrVbdbt+OsLUF
 ypn6fiPJATe7N3kV0jgfY2WjOgJ2Zbo5LHYOlgfiDL73smo+HS6pbrANmEk9kfRVk4+E
 t25Q==
X-Gm-Message-State: AOJu0Ywa5PgfPD6I0pHPpLCgmt1kesmAEyi3FQeJt8/qUF+oNUw4EoIs
 zUNVxcd31gyEbKfkP9lBMXROOOtBIIgNEfL15kPw2jPlVbzOCn05HXiiJTApic5loQ==
X-Google-Smtp-Source: AGHT+IGQaFs0McGvQ3WogCXp5Bnbv0tjNHmDFtCyBMTChjCDP6OjqkAwmLNjMSALn7SGoUBT1uWwTA==
X-Received: by 2002:a05:6512:b9e:b0:513:ed17:af03 with SMTP id
 b30-20020a0565120b9e00b00513ed17af03mr5607735lfv.59.1710865649507; 
 Tue, 19 Mar 2024 09:27:29 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 v23-20020ac25597000000b00513a9d105a3sm2000148lfg.262.2024.03.19.09.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 09:27:29 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:27:28 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 5/8] target/microblaze: Restrict 64-bit
 'res_addr' to system emulation
Message-ID: <Zfm88Hit3Kni1f_4@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-6-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 07:28:52AM +0100, Philippe Mathieu-Daudé wrote:
> 'res_addr' is only used in system emulation, where we have
> TARGET_LONG_BITS = 64, so we can directly use the native
> uint64_t type instead of target_ulong.


Hi Philippe,

This breaks linux-user, lwx and swx are valid user-mode insns.

Best regards,
Edgar


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/cpu.h       | 10 +++++-----
>  target/microblaze/cpu.c       |  2 ++
>  target/microblaze/machine.c   |  2 +-
>  target/microblaze/translate.c |  9 +++++++--
>  4 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index c0c7574dbd..c3e2aba0ec 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -260,11 +260,6 @@ struct CPUArchState {
>      /* Stack protectors. Yes, it's a hw feature.  */
>      uint32_t slr, shr;
>  
> -    /* lwx/swx reserved address */
> -#define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
> -    target_ulong res_addr;
> -    uint32_t res_val;
> -
>      /* Internal flags.  */
>  #define IMM_FLAG        (1 << 0)
>  #define BIMM_FLAG       (1 << 1)
> @@ -286,6 +281,11 @@ struct CPUArchState {
>      uint32_t iflags;
>  
>  #if !defined(CONFIG_USER_ONLY)
> +    /* lwx/swx reserved address */
> +#define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
> +    uint64_t res_addr;
> +    uint32_t res_val;
> +
>      /* Unified MMU.  */
>      MicroBlazeMMU mmu;
>  #endif
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 96c2b71f7f..9e393cf217 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -193,7 +193,9 @@ static void mb_cpu_reset_hold(Object *obj)
>      }
>  
>      memset(env, 0, offsetof(CPUMBState, end_reset_fields));
> +#ifndef CONFIG_USER_ONLY
>      env->res_addr = RES_ADDR_NONE;
> +#endif
>  
>      /* Disable stack protector.  */
>      env->shr = ~0;
> diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
> index 51705e4f5c..4daf8a2471 100644
> --- a/target/microblaze/machine.c
> +++ b/target/microblaze/machine.c
> @@ -78,7 +78,7 @@ static const VMStateField vmstate_env_fields[] = {
>      VMSTATE_UINT32(iflags, CPUMBState),
>  
>      VMSTATE_UINT32(res_val, CPUMBState),
> -    VMSTATE_UINTTL(res_addr, CPUMBState),
> +    VMSTATE_UINT64(res_addr, CPUMBState),
>  
>      VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
>  
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index d6a42381bb..493850c544 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1872,7 +1872,9 @@ void mb_tcg_init(void)
>          SP(iflags),
>          SP(bvalue),
>          SP(btarget),
> +#if !defined(CONFIG_USER_ONLY)
>          SP(res_val),
> +#endif
>      };
>  
>  #undef R
> @@ -1883,6 +1885,9 @@ void mb_tcg_init(void)
>            tcg_global_mem_new_i32(tcg_env, i32s[i].ofs, i32s[i].name);
>      }
>  
> -    cpu_res_addr =
> -        tcg_global_mem_new(tcg_env, offsetof(CPUMBState, res_addr), "res_addr");
> +#if !defined(CONFIG_USER_ONLY)
> +    cpu_res_addr = tcg_global_mem_new_i64(tcg_env,
> +                                          offsetof(CPUMBState, res_addr),
> +                                          "res_addr");
> +#endif
>  }
> -- 
> 2.41.0
> 

