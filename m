Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACAEE9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBGD-0005oK-UM; Mon, 29 Dec 2025 06:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBG3-0005lR-21
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:17:54 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBG0-0005hF-4C
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:17:50 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so1345487666b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007066; x=1767611866; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1N9z5KEd2nuIFBPAfI9fAQzBoJ7xmNQYVnWwFYxPWCk=;
 b=EG/lrD0Fjy/RX9EWbNDXbEyoiLUHcFIXqbaOOU+mnTt78JMYIxLq+XeDFOPbHBXEUN
 VWvmWIBQJzd0gg4gRu1jmU7GXaVU9zBxHNGot18xihqyvDK+UngJnr+F5aYqY7ZZmst4
 Tu6cCskhj00vm9700ShW7H68xAlDn7KwH93I/RoCjqo+C5MZjPxlMxLBgTuxzFWItWOb
 VqPIHM+HNbUz7ZcT1tMilPPYbDzaj0AhrsoxlfJWjPZpsbRhNLKNUATQq/qvZg7d1G/L
 DCWAMxbl2AzaGLLcstbLwiMe6vADF5oQlgHGoKI6dL59nJm2hpo1O8abAZpF/I/MvXoa
 z2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007066; x=1767611866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1N9z5KEd2nuIFBPAfI9fAQzBoJ7xmNQYVnWwFYxPWCk=;
 b=mHT27z2i0myZ58z23loCRnn3MGyXtouBjykKYf/buNEgtf1EqSc/ADiUvkWb88DyTw
 GEmb/nHVddJlDQRkWvXNZpoOtJy8RpSZpRCP7RsvCPTMeqW0DzGHks00PsvLuiCkFj5e
 u67Te1ZflWGdnj4Xa/F8DzPj8aonbDwzWV96RigRUlGx3H71jp/9zGlBrxB0pGtOXHDa
 XPIuarg6eZrNSHH78EKc+wHzwJ3YK2skr1aH3hCI8JxOLJfZiSArVrkjqR7cbc+vrkyr
 YBZz2CpfqYCbJWwVaM9NeLqmm0i92pnVTfA1w81z3nE7hCfSGB81JrjC+8VLReZmaLrS
 KpGg==
X-Gm-Message-State: AOJu0YzfPMr74XZYuAKQrFMQjyQHDSWvKLCsA25T2SBbJwB5pMvX8I5e
 OdyYFueIjReTPV562bj2r7dr7vFEPDnQB3q5+suqYciYsjJOQLXW1SZEncXw4zM9SGquxkDlQfd
 iAOcYehmkx5mAg8vnzzuewh9RL1NnMxhb+DoTgPbzYg==
X-Gm-Gg: AY/fxX5UvP/QUhlMG4M0Jvv5INNopU+YwaLb95cEJhrftdk+4NR9hrR2TI64Mt+AtRx
 u5dNUk+uEVQJPLH4DqPL+PZ2YO+bkP1bITOMxdIyjO5fK/3O80PewZReBygLXKDIkIMHVIjoWuU
 pw0RixtbOIJFWnPp0rLjLAz61x1nxX/K02seuCauWVdRuL8WO9cTN2sJfQN6kTLU0kKOXGYEu2t
 aYJXYyCahXWGgGuj+uaiANdT3fdsHwqlhIYhhnMw6rf/PJyWKr63XT2PAoHs02olGQnOm4fGZlj
 1OU5uMYTTJxrfDaJDHKCDlIhjzWDfmGuUWWcXB0=
X-Google-Smtp-Source: AGHT+IEIp9op8sVlumQUNqwXXkQTBtT3E11j01g317R5ykla+VE6fsLdm0mpa/Ly9csZyFp+0kKXMtN428JADOsJlxg=
X-Received: by 2002:a17:906:730f:b0:b80:b7f:aa10 with SMTP id
 a640c23a62f3a-b80371d8c5cmr3277663066b.59.1767007066393; Mon, 29 Dec 2025
 03:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-8-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-8-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:17:20 +0200
X-Gm-Features: AQt7F2q9JaAjbGLEs5_8dZmLz1kTYTUm9oC9gJ-dVxiFQsOWLoBJ80Si72flaK8
Message-ID: <CAAjaMXba3gAevXN+CGO4YTxQ4X_rfOZBn9LEmLdP=gtLAhE7Dw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] target/sparc: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> In preparation of removing the cpu_ldl_code wrapper, inline it.
>
> Since SPARC instructions are always stored in big-endian order,
> replace MO_TE -> MO_BE.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  target/sparc/int32_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index b29f693a6bf..d6bb3fa1e54 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -149,9 +149,11 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>           * mimic delayed trap delivery as if by the subsequent insn.
>           */
>          if (!env->fsr_qne) {
> +            MemOpIdx oi =3D make_memop_idx(MO_BEUL, cpu_mmu_index(cs, tr=
ue));
> +
>              env->fsr_qne =3D FSR_QNE;
>              env->fq.s.addr =3D env->pc;
> -            env->fq.s.insn =3D cpu_ldl_code(env, env->pc);
> +            env->fq.s.insn =3D cpu_ldl_code_mmu(env, env->pc, oi, 0);
>          }
>          env->pc =3D env->npc;
>          env->npc =3D env->npc + 4;
> --
> 2.52.0
>

