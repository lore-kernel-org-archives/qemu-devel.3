Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LToNxUJ0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN07d-0007Xd-NL; Fri, 30 Oct 2026 23:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN07a-0007XO-IT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:51:11 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN07W-0004oh-PV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:51:10 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3a98fc80925so19147181fa.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418659; cv=none;
 d=google.com; s=arc-20260327;
 b=plpLUOHofgIb+CY4cWyUxPyehJO3QioG3nIO1MvGsb/U6eUlG0zJe+eDZKvrXn94wS
 mIrKm5wU3EuUE+Cr8OopowN+c3DdaCIYH5EY/DOD8YoJVQGqVkNAzNe0S20zRxOqQgdM
 aLD741Xa0r/+P+MtxqdM4etX9/G9CT99MXCJesN15v4TsFIgxRoPBqScX9Eilm0TwAm1
 tFRrCpHp6upUcnVZ3qurFa/mrMz6kbEVxwqxDq8hdUwmCRzmAmC4LCpokHuOAYeiaOxG
 NLBZCcRO6CYjAtcQI0y86SZOr6zpJ7z1aAjVsxPttBqjwzawS+C7fdVOr2Gmq28xTLxb
 dwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wv9UJzyyJYtngv5BTQtB2E57DSAUFT6NOKI0p8rLb28=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=Iog/2cYxolGGwX5ro8MPD0Kcr2yVmhRR1C6TOOtQs4fqZl1Oa2aefxW1O3PmlReFrZ
 Vj5T0Fv1cL2a0NsdQT4jsb3jEQ/vL4rcqQVraXPJ6xAxiBGizxPJsJBJyor7KkJgb+QC
 VrS2xUz6mzJl8bJ3xrPqKhSgaisWMArZ9UTrcV/NRvMIuETdHmiyGMpzbtUWeissQ0h1
 AgNpDgsnrJXse6iS0YCuHya4i+pVpjVJYzeybxUyTECeNeWrxOqOlWQSqdqFw9LUGpn0
 B7RQh6xl5AlGmTraGgD3A5a2Rf2vV7s7WV1Tkq5iiVAz0dNvpdFHjz7IZe6q7WUm96VH
 H98Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418659; x=1794023459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wv9UJzyyJYtngv5BTQtB2E57DSAUFT6NOKI0p8rLb28=;
 b=LToNxUJ0/GZDvLzyK+fwoiRHBpGi45OrMrhZ6auMQGMBfZncN2TxBdg+fFVUdH+7wP
 b+AopuJ2pWYyyRINBWmvkYGvwMS1eDZXKhkv+Kf0JWJmkoKrMNUap8X7ezpniSq6hkaI
 nHEBMdrSqSdJXIU+ZyqnUq6R6IPHlvVziteAAbG+9NC45vJzgXGd0nNGb5KcOzXXnKM0
 PfJOMfpa5KmeGmJXK7rmnXnjCFwgkDl8sSRZ9fslp6ML8cpdOE+ZjnNgkVniwrZ7PBOk
 wj79yihlq6HisbDP6liX+cLraj5+WOHI7brK2kk6cw3nnFc6530Md0GubhXmbU37XhMQ
 nQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418659; x=1794023459;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wv9UJzyyJYtngv5BTQtB2E57DSAUFT6NOKI0p8rLb28=;
 b=SyVhrUEcgzY4wyPHvzdR2DBpj5tR+GqH/Yj1xn4uQcnVokaKr2uvZchpdVPSyVBgT7
 GhOVnjmks5t8614megwTIPOLF7HNF3LNw2zvtWJrtlneuaSwm3fBntIMTilrsrgmFwAl
 ADOSn2sDkXit18iumOy37iMwnkCax4zzRM79I9cljNWVfTwWt+1wkFeEMG9aGQcd7KjO
 oUsk6S+BaEwddRNoyKCYKxfOKzBUpoxYi3OCVbyLeVzhWgUjF3goQMygxzlSnNVvjLLc
 9T8aVIA4ft5xhidNJ3EUuC5ueX92sSrShFa78tW5Xh/HDvKAa7fBethnnPSfrXmxPcaJ
 yInw==
X-Gm-Message-State: AFq9FYJK74EmAO/l588B5nKWzBX7vi/gfMVzqYsZ+4G2ANUhs2j27RcO
 xGB5WUM3lcfRyxO6I9dhXwcnLd89M+CxoqipoNJlpXGZf9VfxAIERT0x/4B4FN83ECMA9OGffDx
 Bfl/BCWA2AeelpF/oXKxuXqTIsV2TLOo=
X-Gm-Gg: AYBFou3Ofg8wuJSKZGjODChU1Fh/mpcj1GGwvkI2TuMD7mF7S5ZKUf2df9/DU0n02G6
 8QpTilA/GiEG33E/TPGq9dzl/USjVboflnsTZ0qink5cAaO7HLfITMpUFPDDpGJFXUrjGrRNJOQ
 ZwxG2z5qyeWE1+0L8AitlB7aFz/oU5i9F2IyiJKUx4xHoFhbowrng9DOPFVf1AYUMuaFr5C6ZhI
 ZSO/d9B6VeP5jk+74PUz7+zIwCF1974Hx2Z8Xkc68CROQ8R3QIv+2UeQ/n0t6j22AiyBfORzPJr
 eBuT5OUEf44iNt/646k1HeVOvggUynJoxB6UqS390uqKrbE4LrbwBnrg/7PE2LwjEXhjnO/gI2x
 JeY5JJjP8ZBxQsqmG7FiZM1usmAyXGu959Khk7JFP50ULUJrz1ANvpnEHUE2N86YlJQe6RD8q93
 er55nEu8k6CHYqG95G2PV27mwLH4rCOPnyuOZEe4HSpiMVuxfij45UQE72CncRXXZlwB7rPxUBv
 g==
X-Received: by 2002:a05:651c:1b04:b0:3a8:bd3d:546d with SMTP id
 38308e7fff4ca-3acb7a9edf0mr9571531fa.5.1793418659518; Fri, 30 Oct 2026
 20:50:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-15-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-15-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:50:47 -0400
X-Gm-Features: AclHuK9ed891WEz1jJHeozZrUPUXvGWnuj2XENUSRJVzuVsRgAcNftnycMKg1L8
Message-ID: <CAEdQ38Fhz-S4fZZe9imTF86DN8e48ro4NzjM7amuFCMAf0cMSg@mail.gmail.com>
Subject: Re: [PATCH v7 14/14] accel/tcg: Move tb_jmp_cache to
 CPUNegativeOffsetState
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:56=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> Subject: [PATCH v7 14/14] accel/tcg: Move tb_jmp_cache to
>  CPUNegativeOffsetState

The body is empty. Could you add a line saying why? I assume it's the
shorter env-relative displacement, but the diff doesn't say, and
measured numbers would help if you have them.

