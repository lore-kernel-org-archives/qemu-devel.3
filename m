Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2D4E6BF35
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 19:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vluBu-0000fs-As; Fri, 30 Jan 2026 14:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vluBs-0000eh-Id; Fri, 30 Jan 2026 14:30:00 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vluBq-0005k2-ER; Fri, 30 Jan 2026 14:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NkZA/WwDApVyA2GSTaoOKWs7bM2FnAlw6b6Zuylie78=; b=nhWUet+jMDErlFpSmsXCo7ubUf
 dExuOnJ65d6MIvkeDh+Wv45RRYVf/6Abf3LBJE//yoTJkxMuwTRkRUNLh04XtFwyW0sB2E3JDfp50
 E3LCEiMVyPLbcbqJ5acazzWIUjG3csNZQU4hMBsUc/MRu3eV6O6BnjR19cmK6hZIEMJWznj1P5pPN
 E0JVaBjh2ucBmB8PUzo1rKaI1guBwVEYNISyC1zsw69hmxAhyAgAQ/slpet7ZRM3lfKytWeyoHU/9
 33AVO7nd1zU8ySoOkqxRVjKBJMkuwOiMbVbaxzrLbj62dOXtvu68hapeH+iVp13vrvoFqukAexgo0
 /kybOzqeNQywRwIGTytjaEr/eb4XUVjAY39tF0j6YmPPfoeut0fFw0LGW774mJ6gKzJ86Waqrz6xr
 7tQN4TBtXufzTKyk1gmXnRd4js3P9CKRCO0RMvquK8QVy6oZP68IoX+rwoNF7w/4PfpUHC0rlJXzC
 uiTrsihDYjfVo4gdz25xdSTYlDKksErFa1hfS/Yyjjmx3dUHkyFuBjXcgZ1BDOxjyPoWWlIDpYLBe
 ycBMwySDZXkrvVuFFo878KhPEaoR9n4WVgtqTsyX9uLfdP+9puZ04bo71w//9tykq4mmdGxYNfpNy
 yFzJDvyHzRdg9zlG7J2gBPFkSv3mUOcEeKiLv1MWU=;
Received: from [2a02:8012:2f01:0:627e:3663:264b:92cd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlu94-0007Jf-KB; Fri, 30 Jan 2026 19:27:10 +0000
Message-ID: <5d69f1a3-f709-4bc1-86ae-a2c183efc445@ilande.co.uk>
Date: Fri, 30 Jan 2026 19:29:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260129164039.58472-1-philmd@linaro.org>
 <20260129164039.58472-6-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260129164039.58472-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:627e:3663:264b:92cd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 5/9] monitor: Have MonitorDef::get_value() return an
 unsigned type
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/01/2026 16:40, Philippe Mathieu-Daudé wrote:

> All implementations of the get_value() handler return an
> unsigned type:
> 
> - target/i386/monitor.c
> 
>    monitor_get_pc() -> target_ulong eip;
> 
> - target/ppc/ppc-qmp-cmds.c
> 
>    monitor_get_ccr() -> uint64_t ppc_get_cr(const CPUPPCState *env);
> 
>    monitor_get_xer() -> target_ulong cpu_read_xer(const CPUPPCState *env);
> 
>    monitor_get_decr() -> target_ulong cpu_ppc_load_decr(CPUPPCState *env);
> 
>    monitor_get_tbu() -> uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
> 
>    monitor_get_tbl() -> uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
> 
> - target/sparc/monitor.c
> 
>    monitor_get_psr() -> target_ulong cpu_get_psr(CPUSPARCState *env1);
> 
>    monitor_get_reg() -> target_ulong *regwptr;
> 
> Convert the MonitorDef::get_value() handler to return unsigned.
> 
> Rename the MD_I32/MD_TLONG definitions mechanically doing:
> 
>   $ sed -i -e s/MD_I32/MD_U32/g $(git grep -lw MD_I32)
>   $ sed -i -e s/MD_TLONG/MD_TULONG/g $(git grep -lw MD_TLONG)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   include/monitor/hmp-target.h |  7 ++---
>   monitor/hmp-target.c         | 12 ++++----
>   target/i386/monitor.c        |  8 ++---
>   target/m68k/monitor.c        | 60 ++++++++++++++++++------------------
>   target/ppc/ppc-qmp-cmds.c    | 25 +++++++--------
>   target/sparc/monitor.c       | 10 +++---
>   6 files changed, 59 insertions(+), 63 deletions(-)
> 
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 5167d17d41d..6d6653aee6e 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -32,14 +32,13 @@ typedef struct MonitorDef MonitorDef;
>   struct MonitorDef {
>       const char *name;
>       int offset;
> -    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
> -                             int val);
> +    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
>       int type;
>   };
>   #endif
>   
> -#define MD_TLONG 0
> -#define MD_I32   1
> +#define MD_TULONG 0
> +#define MD_U32    1
>   
>   const MonitorDef *target_monitor_defs(void);
>   int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 420969bd6eb..1600666ee92 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -67,7 +67,6 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>   {
>       const MonitorDef *md = target_monitor_defs();
>       CPUState *cs = mon_get_cpu(mon);
> -    void *ptr;
>       uint64_t tmp = 0;
>       int ret;
>   
> @@ -81,13 +80,14 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>                   *pval = md->get_value(mon, md, md->offset);
>               } else {
>                   CPUArchState *env = mon_get_cpu_env(mon);
> -                ptr = (uint8_t *)env + md->offset;
> +                void *ptr = (uint8_t *)env + md->offset;
> +
>                   switch(md->type) {
> -                case MD_I32:
> -                    *pval = *(int32_t *)ptr;
> +                case MD_U32:
> +                    *pval = *(uint32_t *)ptr;
>                       break;
> -                case MD_TLONG:
> -                    *pval = *(target_long *)ptr;
> +                case MD_TULONG:
> +                    *pval = *(target_ulong *)ptr;
>                       break;
>                   default:
>                       *pval = 0;
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 99b32cb7b0f..427f1990399 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
>       }
>   }
>   
> -static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> -                                  int val)
> +static uint64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> +                               int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       return env->eip + env->segs[R_CS].base;
> @@ -602,9 +602,9 @@ static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
>   
>   const MonitorDef monitor_defs[] = {
>   #define SEG(name, seg) \
> -    { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_I32 },\
> +    { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_U32 },\
>       { name ".base", offsetof(CPUX86State, segs[seg].base) },\
> -    { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
> +    { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_U32 },
>   
>       { "eax", offsetof(CPUX86State, regs[0]) },
>       { "ecx", offsetof(CPUX86State, regs[1]) },
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 6d101c75df0..1bb5012da91 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -24,36 +24,36 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   }
>   
>   static const MonitorDef monitor_defs[] = {
> -    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_I32 },
> -    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_I32 },
> -    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_I32 },
> -    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_I32 },
> -    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_I32 },
> -    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_I32 },
> -    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_I32 },
> -    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_I32 },
> -    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_I32 },
> -    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_I32 },
> -    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_I32 },
> -    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_I32 },
> -    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_I32 },
> -    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_I32 },
> -    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_I32 },
> -    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_I32 },
> -    { "pc", offsetof(CPUM68KState, pc), NULL, MD_I32 },
> -    { "sr", offsetof(CPUM68KState, sr), NULL, MD_I32 },
> -    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
> -    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
> -    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
> -    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_I32 },
> -    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_I32 },
> -    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_I32 },
> -    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_I32 },
> -    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_I32 },
> -    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_I32 },
> -    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_I32 },
> -    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_I32 },
> -    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_I32 },
> +    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_U32 },
> +    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_U32 },
> +    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_U32 },
> +    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_U32 },
> +    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_U32 },
> +    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_U32 },
> +    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_U32 },
> +    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_U32 },
> +    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_U32 },
> +    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_U32 },
> +    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_U32 },
> +    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_U32 },
> +    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_U32 },
> +    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_U32 },
> +    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_U32 },
> +    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_U32 },
> +    { "pc", offsetof(CPUM68KState, pc), NULL, MD_U32 },
> +    { "sr", offsetof(CPUM68KState, sr), NULL, MD_U32 },
> +    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_U32 },
> +    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_U32 },
> +    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_U32 },
> +    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_U32 },
> +    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_U32 },
> +    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_U32 },
> +    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_U32 },
> +    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_U32 },
> +    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_U32 },
> +    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_U32 },
> +    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_U32 },
> +    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_U32 },
>       { NULL },
>   };
>   
> diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
> index 7022564604f..07938abb15f 100644
> --- a/target/ppc/ppc-qmp-cmds.c
> +++ b/target/ppc/ppc-qmp-cmds.c
> @@ -33,26 +33,23 @@
>   #include "cpu-models.h"
>   #include "cpu-qom.h"
>   
> -static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
> +                               int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
> -    unsigned int u;
>   
> -    u = ppc_get_cr(env);
> -
> -    return u;
> +    return ppc_get_cr(env);
>   }
>   
> -static target_long monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       return cpu_read_xer(env);
>   }
>   
> -static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
> -                                    int val)
> +static uint64_t monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
> +                                 int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       if (!env->tb_env) {
> @@ -61,8 +58,8 @@ static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
>       return cpu_ppc_load_decr(env);
>   }
>   
> -static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       if (!env->tb_env) {
> @@ -71,8 +68,8 @@ static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
>       return cpu_ppc_load_tbu(env);
>   }
>   
> -static target_long monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       if (!env->tb_env) {
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 73f15aa272d..378967f8164 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -40,8 +40,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   }
>   
>   #ifndef TARGET_SPARC64
> -static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>   
> @@ -49,8 +49,8 @@ static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
>   }
>   #endif
>   
> -static target_long monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       return env->regwptr[val];
> @@ -154,7 +154,7 @@ const MonitorDef monitor_defs[] = {
>       { "otherwin", offsetof(CPUSPARCState, otherwin) },
>       { "wstate", offsetof(CPUSPARCState, wstate) },
>       { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
> -    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
> +    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_U32 },
>   #endif
>       { NULL },
>   };

For SPARC:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


