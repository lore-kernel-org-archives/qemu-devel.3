Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D80CD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 20:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpDOZ-00064R-LR; Tue, 26 Mar 2024 16:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rpDOY-00063q-3k
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:27:42 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rpDOW-0002SZ-G9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711484858; x=1712089658; i=deller@gmx.de;
 bh=yIdayzR1q4qOS/twn9Px394YZTeXMRPRPwDGaULmT/U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=VWyQ6zCC0Q+eAYXQdUu7YcNOaMXmGIbsgbgB82V8q8EmbxpPaELQP+u2oz9zVFWg
 PdnRzFasBmVoLWMH3bEncURnLtVIBu/udtZXB3+nP6rU+hfE3lvf7mIzYzmix88bI
 U40pAtNfpAXjW/1cH/WFqk1okr05WlOUSqqxPjHqYC4Ve+Fj8BAi4uEDV5KHTRNZd
 aBIEoipL4mylJMr7uC79yOb9NpQWJ+ix2FZwKX6EvRNV5uQqLoka8wq0hHa8N3puI
 p0dOnPu7Py0b6gRxxgtglYl/z/w4c5wt2dRj2HWLXIhIQyehqdA9Pa9sE3eNx07nM
 aq+xSCxPsVDBjN5rdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.180.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1sqLUP0vfP-012qlZ; Tue, 26
 Mar 2024 21:27:38 +0100
Message-ID: <63212915-764c-47d0-81d7-f1479e3df3d9@gmx.de>
Date: Tue, 26 Mar 2024 21:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/hppa: Move diag argument handling to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org
References: <20240326181028.332867-1-richard.henderson@linaro.org>
 <20240326181028.332867-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240326181028.332867-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4dOQX/g6KOCkv+e6LjKvbgjZarj/B0S4Cw5EDMI6uLvEuBk9bAn
 O/9ZkpQw57bFYyLu/BLvPuDh6/LrYSEf2/mMGVY8ewfc4kjdZNLrZ5fmrm0wOWqN+P7a7OR
 O9FqxpQtsF4AKOwho9/BIhGMTG++JYxlCavTrO9iEuVzd0xpODac4Ta3xx2aXnhR5eqF3UC
 79KZV+IWub9U2+G6nw/Iw==
UI-OutboundReport: notjunk:1;M01:P0:r+sFdi75APY=;Kg/oMPNlVwmTTxHTUzo8AZumCQB
 Q27uuqfuO4g8nD7YgnOQ954J+3E4RGK8WmWkMMSuX6ACCaeuhljadR8S3LEP++Sb1XP2CHe6s
 TPmmxXdobVrbuEH6/s6bvN5Gj0QPbGHU+lmMb0mnrbyCPI0m8g9XLWl+X8Q2V8ryz0UQ0N5qm
 p/igVn2IOE4SKWgHCjF9KAVQvyD4BrQlkp5LPL58f/vTDNgo1ofgIkQ5/70FSQPrKqzgdxAB7
 Drn7lQumbzDHU8x5y4LDN+L5hVB00BcLo0qdWTaYMf7dSr6R00bJsDsf0SdVN1QfXgwoYaok2
 kA4S11i3jc/UgsjLbbxbYoJqTGEMzIVcWfV/62UggjiV+NS4LwuGaKJeO9xhd8nGBE6a4VgY7
 e47iHcA9zw/aQ7c2vGqCNsw3Hpf55qE6LyaoxW4TX/sjBDEjQThV9IJThPvXKtJc4VpaAHfZc
 upfEA4D3ypl6ffm5c9DYSrGYjF5kL0Fg3CRrLLGoQHC+ocbHkXPj4JkxiuUB6KCZSkUvYm8tK
 sn2RG4+EWeOVKQrtkD6H7SawLyGR+lsL20o0JWPOZO573ggvcirPI49UYcvU/gvJx/XBAVlln
 V/Bps45ZrX1k/NBNYMZbElL68OejJdBaGznOo93g6pEVp1/tezSHOZQidceVPDy2vhuQkkVM1
 V6pQ5agoEr9yJbv1z9p53ZkPHOhdpM2XsybCVpkROEArFVGYPkQksdO8ugV2Vt6FunCqSFRnd
 Pd8IDWLvnkHP7VjhTZQ93Z6onGOWHtgzg5gFjaB2UlHlIjkBf2qmJn9g2c4CCfodw3X9c+xQh
 PeH0OvwUn7HTzY0rIwoZw6axj3b8kwLWhrqJv9AmCNanw=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 3/26/24 19:10, Richard Henderson wrote:
> Split trans_diag into per-operation functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/insns.decode |  8 +++++++-
>   target/hppa/translate.c  | 34 +++++++++++++++++++++-------------
>   2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 6a74cf23cd..9f6ffd8e2c 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -634,4 +634,10 @@ fdiv_d          001110 ..... ..... 011 ..... ... ..=
...  @f0e_d_3
>   xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=3D%ra64 r2=
=3D%rb64
>
>   # diag
> -diag            000101 i:26
> +{
> +  [
> +    diag_btlb               000101 00 0000 0000 0000 0001 0000 0000
> +    diag_cout               000101 00 0000 0000 0000 0001 0000 0001
> +  ]
> +  diag_unimp                000101 i:26
> +}
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 29e4a64e40..42dd3f2c8d 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -4572,23 +4572,31 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, =
arg_fmpyfadd_d *a)
>       return nullify_end(ctx);
>   }
>
> -static bool trans_diag(DisasContext *ctx, arg_diag *a)
> +/* Emulate PDC BTLB, called by SeaBIOS-hppa */
> +static bool trans_diag_btlb(DisasContext *ctx, arg_diag_btlb *a)
>   {
>       CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
>   #ifndef CONFIG_USER_ONLY
> -    if (a->i =3D=3D 0x100) {
> -        /* emulate PDC BTLB, called by SeaBIOS-hppa */
> -        nullify_over(ctx);
> -        gen_helper_diag_btlb(tcg_env);
> -        return nullify_end(ctx);
> -    }
> -    if (a->i =3D=3D 0x101) {
> -        /* print char in %r26 to first serial console, used by SeaBIOS-=
hppa */
> -        nullify_over(ctx);
> -        gen_helper_diag_console_output(tcg_env);
> -        return nullify_end(ctx);
> -    }
> +    nullify_over(ctx);
> +    gen_helper_diag_btlb(tcg_env);
> +    return nullify_end(ctx);
>   #endif
> +}
> +
> +/* Print char in %r26 to first serial console, used by SeaBIOS-hppa */
> +static bool trans_diag_cout(DisasContext *ctx, arg_diag_cout *a)
> +{
> +    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
> +#ifndef CONFIG_USER_ONLY
> +    nullify_over(ctx);
> +    gen_helper_diag_console_output(tcg_env);
> +    return nullify_end(ctx);
> +#endif
> +}
> +
> +static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
> +{
> +    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
>       qemu_log_mask(LOG_UNIMP, "DIAG opcode 0x%04x ignored\n", a->i);
>       return true;
>   }


