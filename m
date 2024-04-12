Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2390EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 18:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvLfk-0002cU-Pq; Fri, 12 Apr 2024 14:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rvLfj-0002c9-Hh
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 14:30:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rvLfa-0006Xs-1H
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 14:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C5ONPIUOUXhnMtFmGWvQpLG8gmkOx58ShhOIZKnnGYg=; b=TDx2hgW4EL+pGT5xWybpw29wqy
 k0Qv6XPdggBgOVL4w6HKgt+k7rqEA+jFQPm7qzWDq648u3wWjIwxqRbXEtFZJgxsuL3BAskslLHqi
 QGi/dlkfvFbQfDE1xazNK3O+YuNSU0lthd+I2+Ej6ERaO5Vz/UJix0FdwPVZiXgvfNEbGH+8jyNJH
 wo0m51w4URnvTSe+WfpkbbIpXP2Ud2X4nF5YkdassuYw8jccWJpTmfgYQlYtsbrm0oFDoWYZ2+eAt
 emUgYA6NG0xXJXn8yizJ9qS+rWko2Fxw+uKwDkWrB3Mb/UCCoilRkNB16jwKUJnMJNc3YcIk0Otpl
 r1eESghXJOQH8O3bRhkUuGIc1BzF40WEk/WNRYsg918E1flP7iHxNM8ypXLCZU0SZ6IEfxblpgqQd
 9ZJ4rrhKLEPyBOYcgmqSgOTvRbY2KhIcVazSbzWdOg0SuGmCzZb9darXLXr/Jk0ICpeDpJN8HdPoL
 heRr7NBG/SMSs/r4ZBHNdswqXiTr4bFmX8QLEiHp5dDSbXSYOLg9ToK8FLDDHYzLc6/HjQKOF3S2u
 X6LaV9OFdt8aMLTqOSWAu9+6f1k6X4E+Ti+pirFILqUebKwOcGYh9UbP7M8A1/U5y+vi/pY0dY7Z5
 1/Dqynf8N3HBdw16FaxqIiKZO5erl297n3PR9G7Mo=;
Received: from [2a00:23c4:8bb3:1000:1eaa:f46b:9dfc:6948]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rvLeU-0006h5-3N; Fri, 12 Apr 2024 19:29:34 +0100
Message-ID: <8a9aee17-4245-487b-bf8e-08a84385cfac@ilande.co.uk>
Date: Fri, 12 Apr 2024 19:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: bazz@bazz1.com, atar4qemu@gmail.com
References: <20240412021509.145502-1-richard.henderson@linaro.org>
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
In-Reply-To: <20240412021509.145502-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1eaa:f46b:9dfc:6948
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and
 ASI_USERTXT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 12/04/2024 03:15, Richard Henderson wrote:

> Reads are done with execute access.  It is not clear whether writes
> are legal at all -- for now, leave helper_st_asi unchanged, so that
> we continue to raise an mmu fault.
> 
> This generalizes the exiting code for ASI_KERNELTXT to be usable for
> ASI_USERTXT as well, by passing down the MemOpIdx to use.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h      |  3 ++
>   target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++------------
>   target/sparc/translate.c   | 49 ++++++++++++++++++++++++++--
>   3 files changed, 95 insertions(+), 22 deletions(-)
> 
> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index e55fad5b8c..b8087d0d2b 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl)
>   DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)
>   DEF_HELPER_3(taddcctv, tl, env, tl, tl)
>   DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +DEF_HELPER_FLAGS_3(ld_code, TCG_CALL_NO_WG, i64, env, tl, i32)
> +#endif
>   #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
>   DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
>   DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index e581bb42ac..2846a86cc4 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -585,7 +585,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>   #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
>       uint32_t last_addr = addr;
>   #endif
> -    MemOpIdx oi;
>   
>       do_check_align(env, addr, size - 1, GETPC());
>       switch (asi) {
> @@ -684,24 +683,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>       case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
>       case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
>           break;
> -    case ASI_KERNELTXT: /* Supervisor code access */
> -        oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));
> -        switch (size) {
> -        case 1:
> -            ret = cpu_ldb_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        case 2:
> -            ret = cpu_ldw_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        default:
> -        case 4:
> -            ret = cpu_ldl_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        case 8:
> -            ret = cpu_ldq_code_mmu(env, addr, oi, GETPC());
> -            break;
> -        }
> -        break;
>       case ASI_M_TXTC_TAG:   /* SparcStation 5 I-cache tag */
>       case ASI_M_TXTC_DATA:  /* SparcStation 5 I-cache data */
>       case ASI_M_DATAC_TAG:  /* SparcStation 5 D-cache tag */
> @@ -779,7 +760,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>       case 0x4c: /* SuperSPARC MMU Breakpoint Action */
>           ret = env->mmubpaction;
>           break;
> -    case ASI_USERTXT: /* User code access, XXX */
>       default:
>           sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
>           ret = 0;
> @@ -787,6 +767,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>   
>       case ASI_USERDATA: /* User data access */
>       case ASI_KERNELDATA: /* Supervisor data access */
> +    case ASI_USERTXT: /* User code access */
> +    case ASI_KERNELTXT: /* Supervisor code access */
>       case ASI_P: /* Implicit primary context data access (v9 only?) */
>       case ASI_M_BYPASS:    /* MMU passthrough */
>       case ASI_LEON_BYPASS: /* LEON MMU passthrough */
> @@ -1161,6 +1143,49 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>   #endif
>   }
>   
> +uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
> +{
> +    MemOp mop = get_memop(oi);
> +    uintptr_t ra = GETPC();
> +    uint64_t ret;
> +
> +    switch (mop & MO_SIZE) {
> +    case MO_8:
> +        ret = cpu_ldb_code_mmu(env, addr, oi, ra);
> +        if (mop & MO_SIGN) {
> +            ret = (int8_t)ret;
> +        }
> +        break;
> +    case MO_16:
> +        ret = cpu_ldw_code_mmu(env, addr, oi, ra);
> +        if ((mop & MO_BSWAP) != MO_TE) {
> +            ret = bswap16(ret);
> +        }
> +        if (mop & MO_SIGN) {
> +            ret = (int16_t)ret;
> +        }
> +        break;
> +    case MO_32:
> +        ret = cpu_ldl_code_mmu(env, addr, oi, ra);
> +        if ((mop & MO_BSWAP) != MO_TE) {
> +            ret = bswap32(ret);
> +        }
> +        if (mop & MO_SIGN) {
> +            ret = (int32_t)ret;
> +        }
> +        break;
> +    case MO_64:
> +        ret = cpu_ldq_code_mmu(env, addr, oi, ra);
> +        if ((mop & MO_BSWAP) != MO_TE) {
> +            ret = bswap64(ret);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return ret;
> +}
> +
>   #endif /* CONFIG_USER_ONLY */
>   #else /* TARGET_SPARC64 */
>   
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 319934d9bd..c9b9b047df 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1117,6 +1117,7 @@ typedef enum {
>       GET_ASI_EXCP,
>       GET_ASI_DIRECT,
>       GET_ASI_DTWINX,
> +    GET_ASI_CODE,
>       GET_ASI_BLOCK,
>       GET_ASI_SHORT,
>       GET_ASI_BCOPY,
> @@ -1159,14 +1160,22 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
>                  || (asi == ASI_USERDATA
>                      && (dc->def->features & CPU_FEATURE_CASA))) {
>           switch (asi) {
> -        case ASI_USERDATA:   /* User data access */
> +        case ASI_USERDATA:    /* User data access */
>               mem_idx = MMU_USER_IDX;
>               type = GET_ASI_DIRECT;
>               break;
> -        case ASI_KERNELDATA: /* Supervisor data access */
> +        case ASI_KERNELDATA:  /* Supervisor data access */
>               mem_idx = MMU_KERNEL_IDX;
>               type = GET_ASI_DIRECT;
>               break;
> +        case ASI_USERTXT:     /* User text access */
> +            mem_idx = MMU_USER_IDX;
> +            type = GET_ASI_CODE;
> +            break;
> +        case ASI_KERNELTXT:   /* Supervisor text access */
> +            mem_idx = MMU_KERNEL_IDX;
> +            type = GET_ASI_CODE;
> +            break;
>           case ASI_M_BYPASS:    /* MMU passthrough */
>           case ASI_LEON_BYPASS: /* LEON MMU passthrough */
>               mem_idx = MMU_PHYS_IDX;
> @@ -1379,6 +1388,22 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
>       case GET_ASI_DIRECT:
>           tcg_gen_qemu_ld_tl(dst, addr, da->mem_idx, da->memop | MO_ALIGN);
>           break;
> +
> +    case GET_ASI_CODE:
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +        {
> +            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
> +            TCGv_i32 r_oi = tcg_constant_i32(oi);
> +            TCGv_i64 t64 = tcg_temp_new_i64();
> +
> +            gen_helper_ld_code(t64, tcg_env, addr, r_oi);
> +            tcg_gen_trunc_i64_tl(dst, t64);
> +        }
> +        break;
> +#else
> +        g_assert_not_reached();
> +#endif
> +
>       default:
>           {
>               TCGv_i32 r_asi = tcg_constant_i32(da->asi);
> @@ -1791,6 +1816,26 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
>           }
>           break;
>   
> +    case GET_ASI_CODE:
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +        {
> +            TCGv_i64 tmp = tcg_temp_new_i64();
> +            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
> +
> +            gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi));
> +
> +            /* See above.  */
> +            if ((da->memop & MO_BSWAP) == MO_TE) {
> +                tcg_gen_extr_i64_tl(lo, hi, tmp);
> +            } else {
> +                tcg_gen_extr_i64_tl(hi, lo, tmp);
> +            }
> +        }
> +        break;
> +#else
> +        g_assert_not_reached();
> +#endif
> +
>       default:
>           /* ??? In theory we've handled all of the ASIs that are valid
>              for ldda, and this should raise DAE_invalid_asi.  However,

Thanks for the excellent analysis, and also thanks to Richard for improving the 
correctness of the patch:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


