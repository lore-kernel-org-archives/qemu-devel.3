Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20857C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 21:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro8Th-000416-8Z; Sat, 23 Mar 2024 17:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ro8Tf-00040w-5a
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 17:00:31 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ro8Td-0003hO-1Y
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 17:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711227626; x=1711832426; i=deller@gmx.de;
 bh=OB8LnwGKMHCksjprKdFp2bD91zuciiMJxj/Uyzz86cw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=NHbVzfwr2UHDzjJxNzhlWyy/kXWUMC0zuiDeQs6l/mJbgW3KYZIApp8jAWba5kf3
 ELDf3wq350oL9pnZV0kKDMuESYIQ6RaQDv2WHieIO3G2lmXxXBlr14J9SHHsifDVH
 heGZOrIEKJwfoJ3z48CD0EvTKL0La4S+RujzcCQ1lN0BRWuch++dvopVwIPS8/Tgm
 SxO2oh/UoPATK4xzaWsMn1I8kny/7g058nLyCjDBYpHeZ5vlEXLLjw8CCKyVUY9+7
 /0otg1cHVjs0D/3bV5U5zZ1MEQD+DoejeYhfnZhbPooTyi+MoCY13hlTNNzQNCZd6
 4LJubWYdBPzmL3NDJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.187.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1rnaFH3zfu-000ZfX; Sat, 23
 Mar 2024 22:00:26 +0100
Message-ID: <d819d5cb-8e9c-4b9f-a6b4-c7f2bd6ca680@gmx.de>
Date: Sat, 23 Mar 2024 22:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] target/hppa: Fix EIRR, EIEM versus icount
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
 <20240323172954.1041480-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240323172954.1041480-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xAo1ty+ZfOcYOCWeVJr1UH37Iivqq3kY5cfhJBLP3KG0QXFJU+L
 ziuJV6gxPhSXjXBPmJ+vLSlUxOBZ906SQjWqRe9n6LXbDhU/ZumYl5QQ5KeeGHraDIoD0OM
 Aw8mPWHBMGnmNHOOk1lTw1hU4entkvjv0+SjGQaMw6ElYL6a15VT96YsmH0Ve45GLQLDfUJ
 /LqJQvotG0GRcV9vgWJaQ==
UI-OutboundReport: notjunk:1;M01:P0:hJxtmsEyRHA=;0dGjEJ9GMp/6rAAgk0+j076x1Hq
 Jz0BV5zoFq5UET2ri5DUn35PBpzwDUJ3X5Ky56hrbtgFtZf6BOa2e4bL13N2m+xh5RTpCQ6L9
 LNBUPbJ3RGujFVtroGOIUrKfYjzf01TeiLdDcpvVMvyQvj4qxFtmTPJBXvhEUEbWKQ5wMtBLc
 VMLaL3LJW5yt/zc3hKJ+Nk8/WoFBK89rVhEqHlXV8YbdoyHHZ3WXB69IaHGkyN6gGSBhXWJBk
 sObg7mNtmMjfiQ+sCGFYzoLe3dK2xWrCTe9TKZ+/QlWAmPoAFsKWWe6e8iZSb35XaJbpef46B
 2S9uplZlPpRN8zRNt17phb2CwtZ7GtpCV7GDIOKAuVTAb8v36jVaIO4Hfxc0JG2LO2kQY9Nuf
 tjiw7hVdc7/NcSTOGeP70f+35ycjfEoqhOnflLt3cBCHUPAR43yWgDNL3+kX/QsPgU2Fb/0tW
 57XLRyG8TrmaNe0U9noV3Kh2FRr+oY6FEBfBe41+ag599iwRQcl4L+9OsGysiJSnN0SI2Qbxy
 gkE9we/b5J4uhlUnGPGsAQ3LX4lk4M0tiihhgqmlRyv82zjzEOYXb93Q9DBp1oVGNfwJRP0AQ
 DEUFe4sFCniMQzsLkfXnNCIsh6d6xEKWiHvcOEsmda46i+xMQE9gEOTwZ8PHVSH1qgrjndo2a
 S8rrUnyGkPZnzgAsfWHjVLwtiVZm31/7ybVkMuBAY4Iyap2rI8S4iAJGQEQJYgWqxX5WCyS9u
 idTX8Smt0iaEaejCANiq1+ozjtCiwgrEAAXSJdFM+3jZ+XFDI0pXxK0DffH9oTOT2+kF6kl+k
 SamvsfbbKv5hMV6VO1wh4S/3ZB28AuKCl9+8Tldwf3jD0=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/23/24 18:29, Richard Henderson wrote:
> Call translator_io_start before write to EIRR.
> Move evaluation of EIRR vs EIEM to hppa_cpu_exec_interrupt.
> Exit TB after write to EIEM, but otherwise use a straight store.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


> ---
>   target/hppa/helper.h     |  1 -
>   target/hppa/int_helper.c | 14 ++++----------
>   target/hppa/translate.c  | 10 +++++++---
>   3 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/target/hppa/helper.h b/target/hppa/helper.h
> index 1bdbcd8f98..8fd7ba65d8 100644
> --- a/target/hppa/helper.h
> +++ b/target/hppa/helper.h
> @@ -91,7 +91,6 @@ DEF_HELPER_1(rfi, void, env)
>   DEF_HELPER_1(rfi_r, void, env)
>   DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, t=
l)
>   DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tl)
> -DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tl)
>   DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tl, env, tl)
>   DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
>   DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index efe638b36e..90437a92cd 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -28,7 +28,7 @@
>   static void eval_interrupt(HPPACPU *cpu)
>   {
>       CPUState *cs =3D CPU(cpu);
> -    if (cpu->env.cr[CR_EIRR] & cpu->env.cr[CR_EIEM]) {
> +    if (cpu->env.cr[CR_EIRR]) {
>           cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>       } else {
>           cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -89,14 +89,6 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ulo=
ng val)
>       bql_unlock();
>   }
>
> -void HELPER(write_eiem)(CPUHPPAState *env, target_ulong val)
> -{
> -    env->cr[CR_EIEM] =3D val;
> -    bql_lock();
> -    eval_interrupt(env_archcpu(env));
> -    bql_unlock();
> -}
> -
>   void hppa_cpu_do_interrupt(CPUState *cs)
>   {
>       HPPACPU *cpu =3D HPPA_CPU(cs);
> @@ -280,7 +272,9 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int inter=
rupt_request)
>       }
>
>       /* If interrupts are requested and enabled, raise them.  */
> -    if ((env->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD))=
 {
> +    if ((interrupt_request & CPU_INTERRUPT_HARD)
> +        && (env->psw & PSW_I)
> +        && (env->cr[CR_EIRR] & env->cr[CR_EIEM])) {
>           cs->exception_index =3D EXCP_EXT_INTERRUPT;
>           hppa_cpu_do_interrupt(cs);
>           return true;
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 5b8c1b06c3..46b2d6508d 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2166,10 +2166,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_m=
tctl *a)
>           gen_helper_write_interval_timer(tcg_env, reg);
>           break;
>       case CR_EIRR:
> +        /* Helper modifies interrupt lines and is therefore IO. */
> +        translator_io_start(&ctx->base);
>           gen_helper_write_eirr(tcg_env, reg);
> -        break;
> -    case CR_EIEM:
> -        gen_helper_write_eiem(tcg_env, reg);
> +        /* Exit to re-evaluate interrupts in the main loop. */
>           ctx->base.is_jmp =3D DISAS_IAQ_N_STALE_EXIT;
>           break;
>
> @@ -2195,6 +2195,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mt=
ctl *a)
>   #endif
>           break;
>
> +    case CR_EIEM:
> +        /* Exit to re-evaluate interrupts in the main loop. */
> +        ctx->base.is_jmp =3D DISAS_IAQ_N_STALE_EXIT;
> +        /* FALLTHRU */
>       default:
>           tcg_gen_st_i64(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
>           break;


