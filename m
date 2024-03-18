Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E36C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJow-000680-8c; Mon, 18 Mar 2024 16:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJok-00066V-Sl
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:42:48 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJof-0004N8-6k
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710794558; x=1711399358; i=deller@gmx.de;
 bh=W6eN3FgxLgY2PbDFMFT6LJe4gOtKyDRK02n94wFWF20=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=RvLbpzprLTbYqo9N897XUeRZ1x182YAG+SBaaIULFyzDQZk8hod402o818Nl2FmP
 UGh6PHFGDDMvkAfQMPTZuv0es5nkUxsx5BMx+ImZxiFs3yria4PWXSIunnnlX7A6N
 WdNLNsomsEwrrXJefp36julI5L6ZhWUdMKl7JYTMlKtve82rFPRqQF+KKoksPl94m
 L9aoFfW2+4rZg3P2JQqMNKj2qIsAZZDoZNWS+/X2AyaZ0/yD67DaYegbU4qnmzur2
 eb58qW3Vhc/AzyX2A3hZHLviByBmsEUiL1Bg6ivKtuG9YI+mrriZ4Z8xmP/3GEDXc
 tjpgFqDPWVijoeQvYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.237]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1qphZu3pPP-00yPLF; Mon, 18
 Mar 2024 21:42:37 +0100
Message-ID: <3d775a25-c082-427c-9a7d-967852fa197e@gmx.de>
Date: Mon, 18 Mar 2024 21:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/hppa: exit tb on flush cache instructions
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-5-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240317221431.251515-5-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t26kqNWXwMFh3B/hqqWVryqmSVfNqZG4uXV0tclIO9g+57tGjha
 Uo3kl9Hj5biBoyUEe3EALLSkyBY1hpcEEy71SlXIvdqGTvX+IGcccFmmjydIVWxrzm0BCix
 Em4JbEeNIVkUAef8mKEcOebiM1Zvqid7jRjAKo9GHQ7M2PRJPdwOBXobpesnLaOpFDgFnwy
 DUM5vrd6ZX50kVpYfhu4A==
UI-OutboundReport: notjunk:1;M01:P0:dWLV8P1fyYI=;UwSfBURu7kX5bixGn8XZXkftK61
 R3BJ0MeVzj3LrUe6DorZSQ92oh/PjSIOVm7YwCiVGhF7ju60KJqi7hpwtGFCj1mUzCH7BBlXw
 Df+NWJJmJmxNHMWBzxEIlVtlpQ4QYKJ0zBGWzTQ/CRHDv3vpFp9pudsKtWSqAISLKdoPfy91V
 tGhtyIVOv5el/8yokTXKveYmVB416tNnn3oZD6ldHoSMkxpHeePWl01kn6kfC/AWiXsymo7SD
 A8UGJPgiksHcrLR86shFyBJ9BqLApljKRCQT/1IAr+Lue6ev0O910rwIl31vA+QXCU0Ig6ce9
 zyP1P9MS06KPc5ziSAUd6UBfWS7XXTQmyB6tk88Ze7UfEKiStJR9ycLXxlka8IdA6DUtXJN8e
 qHn7ryYnz+8ij020cmSEtxhZqeYVoX5PCXsCd5miDTFrfgaTHOEcfX4wBPopdrQa2RlW5AcuB
 RAUlFT75CDnJoFVVcyOBtKPpwwBaMGbLVUr7Grv0tXJPCK1FmL/fburViJQXoPNfvSLfVxQSn
 lkbq9GEQcAQ4Xah392bNgwYVYko9by/IuCDF4DNMDLkT6dwEMfNGkhK+evqnpQzmcsa//XEF7
 4ssIZYaOUBazrgf63CMh/Uec+ssxb3mzQHqsfTUW3Kwt8nh0lJMv1yluxa8ZzA3TXytl7S41K
 +uZ6b45QMBtFwMwKqh9AAouDOeWqXf4N2NNRfCLr1UhaCfkNftsc6nzsx9285zmb3xmADlbHk
 9zSpx1vqA1XcllflW8rcArjQ91ESIYYK3RvZkZ01TVzyPL2K19dgd+7uqOzHvLe6T2+01h0Q5
 T5BNHXQN3axYEGJTW6f0FBdBkV27YR8zopOAIRGVnGB6Q=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/17/24 23:14, Sven Schnelle wrote:
> When the guest modifies the tb it is currently executing from,
> it executes a fic instruction. Exit the tb on such instruction,
> otherwise we might execute stale code.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 8ba31567e8..58d7ec1ade 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1940,6 +1940,7 @@ static void do_page_zero(DisasContext *ctx)
>   static bool trans_nop(DisasContext *ctx, arg_nop *a)
>   {
>       cond_free(&ctx->null_cond);
> +    ctx->base.is_jmp =3D DISAS_IAQ_N_STALE;
>       return true;
>   }
>
> @@ -2290,6 +2291,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg=
_ldst *a)
>           save_gpr(ctx, a->b, dest);
>       }
>       cond_free(&ctx->null_cond);
> +    ctx->base.is_jmp =3D DISAS_IAQ_N_STALE;

I wonder if it makes sense to rename trans_nop() and trans_nop_addrx()
to something like trans_cache_flush() and trans_cache_flush_addrx() ?

Other than that:
Reviewed-by: Helge Deller <deller@gmx.de>

Helge

