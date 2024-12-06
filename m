Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7210E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXXy-0002ZF-8t; Fri, 06 Dec 2024 07:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1tJXXu-0002UH-D2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:34:58 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1tJXXs-0005b4-I9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:34:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-215853ed047so19074195ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488494; x=1734093294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rm9Wr3JXKR1JN+f6IReZIpjxF/cd/DU36egFVglp+8s=;
 b=YMBCZ/SCkDvehIeY0Q9L/HOwIscBFikzeFNsKUHuhEeb2uf4Eil9P0FQ4whFgDSD3B
 90ko8OX0mnAcg38XUjtkTnOM2E7AUcJkEMaBMi2n6x/gc5TQB0wj7JE5XCkBIzfy/yb6
 2iguvi+WtghKbopcYooUDdJroVapN6scwDgAwNMEBERZOeNJhug7VL0qiedpGXCn8/qf
 ciVE04q1ILJsTDUmQRNr3f2PKEbbF/zcgHTL4ZpjHc0IqEZgK2v7veDv1EP3Xa6NhGRf
 EO5DmMRwFNXBuj8EEwspXOpTuypMC2IOK5Ax5zeJWs7SckWDae5QtCrVjoULQiG8RpsT
 o5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488494; x=1734093294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rm9Wr3JXKR1JN+f6IReZIpjxF/cd/DU36egFVglp+8s=;
 b=ClMRXbbrZRFcuH2k3+mTMh/qP9zmTP94d+sDXavm6f1u3HdejYwy91QOX3y748qxKj
 ftlPqtuBEgNQ60JsX/RnXwZLAFD82HC8ufrbsHZ7ilGN8st6BYuBYkPD5YTQhOI1rhTL
 sUHOMKDH6tS92sHJ3NegHO6AL8pK0aindpIoSl5aVOGqs3+y3rqf/FblQFQTlq+0vDLh
 StMDV+Vk3WbRen4mQGfCtzQNopHK4zH8+fTphKGGQSvyr5Tin/CZwDaR8wQL6HVv+AxW
 qNM3XSjUgWobb26IMqgEFyibLYmnvvsOGdxLvCyfyxTMB+i7sVigDoJsMynj9OJ7Abmr
 bpSg==
X-Gm-Message-State: AOJu0YyyxZ0YT8sNav3451EHSkpJTh9rgEQ7VQOqdwd+DVZPiRGXlo9c
 vTZ5qTps2r9kPZhlzOwXme1+fU8pC8OjueCdCYxXty04VdPT208cOwFcjjQaM8R0uLD+hBrbCJp
 BgBdcHs7cGT0vMMKSd/zBIPrBMtx078qD
X-Gm-Gg: ASbGncuAaCL7C2zX+7adnXVpoURE8yYOoOuVn256OQZgaNhXNwZFcRI15XDLUEtq9bq
 Yqj1E9nDWPAusbfwchbIQ3eQt7hQieA==
X-Google-Smtp-Source: AGHT+IFAGsptArtdz1n1C9bSWq4ukhqGSpvz0JYkuHcMZfEZESI8m1Efim9N8k/7lmYpUpAJiYtbKXmbl0TttDFWT84=
X-Received: by 2002:a17:902:ce90:b0:215:98fd:cb0a with SMTP id
 d9443c01a7336-21614d4b6a2mr32612295ad.4.1733488494459; Fri, 06 Dec 2024
 04:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20241205232437.85235-1-philmd@linaro.org>
 <20241205232437.85235-2-philmd@linaro.org>
In-Reply-To: <20241205232437.85235-2-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 6 Dec 2024 04:35:05 -0800
Message-ID: <CAMo8Bf+621bwyf523i_P11q7rgr=DgpcPPdyh2vaiixZRqN3_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/xtensa: Implement xtensa_isa_is_big_endian()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.828,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 5, 2024 at 3:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> Xtensa internal fields are opaque, only accessible by
> the Xtensa libisa. Implement xtensa_isa_is_big_endian()
> to get vCPU endianness. This should be implemented in
> libisa, not QEMU, but I couldn't figure out where to
> contribute this.

This is a beautified version of what xtensa has in binutils, but
binutils is also
just another user of that internal Tensilica library. Perhaps I should make
an artificial "upstream" for this library just to track this kind of change=
s.
Let me look at it.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/xtensa/xtensa-isa.h | 1 +
>  target/xtensa/xtensa-isa.c     | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-is=
a.h
> index a289531bdc8..1cb8e6ccb66 100644
> --- a/include/hw/xtensa/xtensa-isa.h
> +++ b/include/hw/xtensa/xtensa-isa.h
> @@ -829,6 +829,7 @@ const char *xtensa_funcUnit_name(xtensa_isa isa, xten=
sa_funcUnit fun);
>
>  int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun);
>
> +bool xtensa_isa_is_big_endian(xtensa_isa isa);

This file doesn't include stdbool.h and other boolean functions in it
(e.g. xtensa_opcode_is_branch()) return int. I'd suggest sticking with
that. With that change:

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

>  #ifdef __cplusplus
>  }
> diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
> index 630b4f9da1b..36eb4bcf3d4 100644
> --- a/target/xtensa/xtensa-isa.c
> +++ b/target/xtensa/xtensa-isa.c
> @@ -1741,3 +1741,10 @@ int xtensa_funcUnit_num_copies(xtensa_isa isa, xte=
nsa_funcUnit fun)
>      CHECK_FUNCUNIT(intisa, fun, XTENSA_UNDEFINED);
>      return intisa->funcUnits[fun].num_copies;
>  }
> +
> +bool xtensa_isa_is_big_endian(xtensa_isa isa)
> +{
> +    xtensa_isa_internal *intisa =3D (xtensa_isa_internal *)isa;
> +
> +    return intisa->is_big_endian;
> +}

--=20
Thanks.
-- Max

