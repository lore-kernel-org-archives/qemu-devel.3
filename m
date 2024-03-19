Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6CEC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmggO-0008Cq-B8; Tue, 19 Mar 2024 17:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmggN-0008Cg-CH
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:07:39 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmggL-0006qP-KP
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:07:39 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so6825474e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710882456; x=1711487256; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rl1if+eAqtqGLWrCTfzjQCETM7aCC2QzWW/zbIuFllA=;
 b=Rzq1I7Cpl7Xr2320rk76uRCH+6wK72sjzLF8zaK+tQ0+Gkjfcu6Fa5EG5cR4FTTd6w
 aj15B0RndDTWkZBE5xqz0vHvQFU5uYtY44Y7QuExC8lQ3kmXN/kHwkA0RbxRd40BcDn4
 vcq7AaQHNchL0wSEtB/zxtEDiOYIaMAr2o9BRNQSpnxxSqRgXT54x200j/UMZ957erCn
 J8hqmMLBbP0sm5kqS4CVofFfzKDueYCHLR2y3kcbHyYVqfmcf8CMEXGsUbpKq1k8Fv0A
 UuUgB255b6NRAM6cBX3SZDZ1z6F1W7aBEvVMwl1HZ4iNMh/JvVdeOV/nYbQmaJ67Eqj4
 2ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882456; x=1711487256;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rl1if+eAqtqGLWrCTfzjQCETM7aCC2QzWW/zbIuFllA=;
 b=P7V64WZmkUIqhYgVX9C0ZJiuGrxMuGV6m8P7Unb2eZrj4PYPTMJcK8FLuK9f4o1m7S
 Yzrj1iwpawmBp8zJgB659bmMmyfVztpKY5JLay0r9ORaifLg82F3wBnQk+jhqZlBzzBz
 rL0GJGjdbObHAzC90IM4Atorgi2+CH/J5Ae6fSuKj098wYQUQszQXdLvsnaPTpN/n1v0
 J9sQOPQCZ80cx9jzGKZ7aKAHUj1zWzHK2GYsiM0l29/b+z8wbHJMnhIxydfzB2tzPTi+
 6BlmJx+equIy7iv2s4xcTOV5gb7+gl4MDaJBWC/K8LiVMGim7SLLYAWdh7zE0MYoXEMD
 lOGg==
X-Gm-Message-State: AOJu0YwyWujMZd5UThtz+kg8I5GU3416///IovkZihQZZDOLMbiMlKCw
 LCq1HA7SQrQ7TbMVOEW754OBZznbTkcLn8j+JtOrPl+/61ppGZx8
X-Google-Smtp-Source: AGHT+IHEu3Bk4/VNe8qk8UpxDMvSJLi74/2J5bmI7D0QuRxrTtvo6MvtWsitUzfMu98z+MCtAQCtug==
X-Received: by 2002:a19:2d15:0:b0:513:2329:4308 with SMTP id
 k21-20020a192d15000000b0051323294308mr11926458lfj.14.1710882455476; 
 Tue, 19 Mar 2024 14:07:35 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a19ca04000000b00513d3cb2d15sm1933102lfg.68.2024.03.19.14.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:07:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:07:34 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [RFC PATCH-for-9.1 8/8] target/microblaze: Widen $ear to 64-bit
Message-ID: <Zfn-lnYlSmPSS_8F@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-9-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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

On Tue, Mar 19, 2024 at 07:28:55AM +0100, Philippe Mathieu-Daudé wrote:
> The Exception Address Register is 64-bit wide.
> User emulation only access the 32 lower bits.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/cpu.h       | 2 +-
>  linux-user/elfload.c          | 2 +-
>  target/microblaze/gdbstub.c   | 2 +-
>  target/microblaze/translate.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index c3e2aba0ec..a9f93b37b7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -251,7 +251,7 @@ struct CPUArchState {
>      uint32_t pc;
>      uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
>      uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
> -    target_ulong ear;
> +    uint64_t ear;
>      uint32_t esr;
>      uint32_t fsr;
>      uint32_t btr;
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 60cf55b36c..4612aef95a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1498,7 +1498,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
>      (*regs)[pos++] = tswapreg(env->pc);
>      (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
>      (*regs)[pos++] = 0;
> -    (*regs)[pos++] = tswapreg(env->ear);
> +    (*regs)[pos++] = tswapreg((uint32_t)env->ear);
>      (*regs)[pos++] = 0;
>      (*regs)[pos++] = tswapreg(env->esr);
>  }
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index 09d74e164d..147d20c3e4 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -63,7 +63,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>          val = mb_cpu_read_msr(env);
>          break;
>      case GDB_EAR:
> -        val = env->ear;
> +        val = (uint32_t)env->ear;
>          break;
>      case GDB_ESR:
>          val = env->esr;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 493850c544..19b180501f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1835,7 +1835,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>      }
>  
>      qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
> -                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
> +                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
>                   env->esr, env->fsr, env->btr, env->edr,
>                   env->ear, env->slr, env->shr);
>  
> -- 
> 2.41.0
> 

