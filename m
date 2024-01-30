Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362DAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiid-0005Jn-AD; Tue, 30 Jan 2024 02:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rUiiX-0005HA-0O
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:39:37 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rUiiU-0003r2-Qt
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706600366; x=1707205166; i=deller@gmx.de;
 bh=U9npsmrUwpz0AJQuqttEJ59f/PqYXX0I2PLeubV0zK4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=IV/+rDdy07ChveHB/CXspmxc/MizDoCe3dSy7WYHBhgWYOkhooy9omqU+cxhVSNl
 +LJNBy1fAc8iY/WNtG6imr+3H2fOLpk9ey2mkgi74GRY3Hn4rbvYpp5evGp8xJDWe
 sLuw1WTtG9U1EpeeGYZNiqNbPVenAKv5RqL4lecTqI5G891fhr2igs/9mysNwc3WO
 I+YuRFZ+GFxQYk72xEvQZlLLz+81BJi8O6oXVA8cyF0uNzcZhGownf4Gc7Q8a7d2S
 qEOT26baXYQUabrxbz/hHL9ML6tn06qUo14D0JoF9fhqqH+olKVsW7did176GZT9j
 AT51KAoE+YuKKT6VGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.154.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1rSWqz3tU0-002J4k; Tue, 30
 Jan 2024 08:39:25 +0100
Message-ID: <1eb27586-655b-49c5-a692-b7f17ff18b47@gmx.de>
Date: Tue, 30 Jan 2024 08:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] target/hppa: Populate CPUClass.mmu_index
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-10-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240129233043.34558-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JBIuJHLIWuQMmdWLmLjmklR2tnAgGBNM43lfvJAwjn9HlxRBcdP
 be/mpRfClli5mu955Tv7CM3XlPbcz6PnCR41Y2zmmyHI2tttCHRBp4gq8zzIiKCGFWloGes
 p9wXr3DLKYjIVYASOdCxnkfS/ptZQo7WFHsDwQsazZ5D4ZmuJmIS/ay7fUkJZ4mHls+7mG5
 lbuVcHirheedh13Y3FFnQ==
UI-OutboundReport: notjunk:1;M01:P0:SuAJNeM6hsg=;818TMrYE+GvulgKTq6GRw//Qkru
 nfKIfrSVs885n6egd1NTtkvu4O4EaFmS9EUABGTTRT8K4cc3BdXqo7qP5cC9TOn+XJUmyhGUM
 09+bBBJm9g8rO2Rmn2Z4FxS/KtvJBLtsOGJyml82G8INt7DY4hVJDFmNGbAQGc8HX8V8NLCd0
 ejHT1YxiImsuF1I+xkzLeAVSxX5zAB9yq3ORLqblZyuejbEnBEf2Ig5WQ9vN60k+YyvxBJqbR
 A7u1yV0cBFlyZcbf1WqOZc3dZCzqxQjWZzL8EZ792N1oVMg+juSJDNK9W0HqG7BdgWccJNZY8
 btd9TaJn+Ul+tmEQUIIejfZISC5JYcKhOzbGyk7b+WGTsGValCqn4nwpCTZDIyFn+DURL6yds
 0JPXyZgMp6spUnsfUIQOZmyzKEaCCvP/nXACZlJeen257iDxyA0RWdqjNOEGTGlJq7U19+Dz5
 CrqNmNeOvVuHZKe7ZcxEGyB6U2LUHNTV+U/Iw7vtGZFBFzC0CqvhyGXVF/79+uWMNE0Dn70wo
 6PTvmNNItmRrICHe9pm9139MYp8ZhksFZL2NlBz+kUZ7ULWw8EjjvOb5dfHH2yNhCWcD/icSN
 4iOYJQR+dg+4LJeXQXcw22IJE+vRs3fUCNepYaXTlTaYchuXGKzc2jzrgYW55PLNXKMLHtiq8
 y5uGoC0Egge3acnG4OL1degyrAykveh3IG90i/DfidGTYHFME2eTcT/wEaHKEeYur0c2Pdd8m
 FcYM9KjcpwepsrTKZY5PVAw3YNXDVYkR5uIZmigDX8jMuU0UgalldOi0nz8PlpoCHz1PfRJOc
 7DNV48Za67Yi0XpcU1CFvQQ1+huriWpc6jAKbqyOmWjuRP/YclOETa7UnWafFZdbPaP8dQa9n
 Jk3nTz67nrNFuCXpcEX+Jxgv/5hqjJrzrvV2MOEqkog8E4pO9ewRjSWjj70DmghRQXoCQzMym
 WGIFXw==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

On 1/30/24 00:30, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu.h |  7 ++-----
>   target/hppa/cpu.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>




> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 6a153405d2..04439f247d 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -281,16 +281,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *=
env)
>       return hppa_is_pa20(env) ? 0 : PA10_BTLB_FIXED + PA10_BTLB_VARIABL=
E;
>   }
>
> +int hppa_cpu_mmu_index(CPUState *cs, bool ifetch);
>   static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
>   {
>   #ifdef CONFIG_USER_ONLY
>       return MMU_USER_IDX;
>   #else
> -    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
> -        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
> -    }
> -    /* mmu disabled */
> -    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
> +    return hppa_cpu_mmu_index(env_cpu(env), ifetch);
>   #endif
>   }
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 3c019855b4..fbb37e541e 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -94,6 +94,17 @@ static bool hppa_cpu_has_work(CPUState *cs)
>       return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT=
_NMI);
>   }
>
> +int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +    CPUHPPAState *env =3D cpu_env(cs);
> +
> +    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
> +        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
> +    }
> +    /* mmu disabled */
> +    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
> +}
> +
>   static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *in=
fo)
>   {
>       info->mach =3D bfd_mach_hppa20;
> @@ -194,6 +205,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, voi=
d *data)
>
>       cc->class_by_name =3D hppa_cpu_class_by_name;
>       cc->has_work =3D hppa_cpu_has_work;
> +    cc->mmu_index =3D hppa_cpu_mmu_index;
>       cc->dump_state =3D hppa_cpu_dump_state;
>       cc->set_pc =3D hppa_cpu_set_pc;
>       cc->get_pc =3D hppa_cpu_get_pc;


