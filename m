Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 11:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rA7-0006CI-7I; Fri, 03 May 2024 07:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2r9z-00069z-SJ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:33:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2r9x-0005ZJ-GU
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:33:02 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-572babec735so2167951a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714735972; x=1715340772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/TbeM/fPg8U0GiB5URaurHvHt+Aum+D52DEKWcmoZM=;
 b=zXUDod9fgDtZqqsmQY4TRYHlLfCBfid2wDMqWc+Ow/4lxZwkx4Rd/cWbsbVKTkqP5/
 h+FIutKv4xXBG9QnZWGS/ooCcaoQjL375mtmMy6Sz97BhMfg7+aJhLl7K7tXFqaGn50A
 7cpbv6Ew8u/pAOg9DvlB5xxKiBhegONl00i1+4TQC+XDZTMcWspPijHdOtEqB+Oh+q7X
 b1ElyNrsM8cXX9eTvt3Jabm1YRA+vHWScT/FBcjs3LPyuCy2IZ6zzyND9av+dsdf6eZm
 Z/VzWIPoKjiFf5rIQ4Nok71+17a9EvYP+P6bF6JlAMJCtQ3V15pOlR6CMrftyimNDaBw
 cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714735972; x=1715340772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/TbeM/fPg8U0GiB5URaurHvHt+Aum+D52DEKWcmoZM=;
 b=I4m4uN4PCNeWlH7Yo+hVSs+tQVuhKx1JSC6TCo04wFlbdHNEdSMqFDjEribYvgLT2D
 haXoUx7hb6QpXn+Kma0d72FOKxFw9+qY+rP+U59fjGdCQ5uiLS8o7bk4oHjKqc0qYYnv
 fh1jw1MV7njlqXUt3n3WCVWnJBd34uW2oq7JXAFGmzaXeoToPnnxHeSOGxlPCsamZlLG
 1Y2v+G+AbATAAvgtDmRntbwwQb/VKMVcdo0vUVcqHZl0IBNcofeEWiFRg/GFO41ri1ck
 zJLmR98dB7kXGKYeTm9c1/DpAS+Kdo8iX/MFI/TsZMW4cGDFk8u1zYkoZYx84wuyLbZ8
 zCFA==
X-Gm-Message-State: AOJu0YycZ3acg88TmwPkwBZ0e1u1fF/lalTWyIP1n3BJ3da9erpW9bSM
 eeMcQ/5/bQ9h0mgFqLT5HI1RX3lremZAZlQvXM3u/ZqYOwj7lobHrAxXJqwNvfLRrc4SU7/O43q
 eTDx47AvA5bJ9pbxik1m8VV2alRXmcMp26y4t7g==
X-Google-Smtp-Source: AGHT+IHzI8jKJRWGVdyVdTI0jefSgcTKBcejUWovPVsRdDeCNMXdJWofDmqgXgUMyvJGcl9XxamdqrIz5nSGaIfCjYY=
X-Received: by 2002:a50:c348:0:b0:56e:2daf:1edf with SMTP id
 q8-20020a50c348000000b0056e2daf1edfmr1773946edb.21.1714735972097; Fri, 03 May
 2024 04:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240503111019.210717-1-pbonzini@redhat.com>
In-Reply-To: <20240503111019.210717-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 12:32:40 +0100
Message-ID: <CAFEAcA8s5zWH7PMnKjdZFoPVEB+p2obo_0MKSXjrh0dxE244WQ@mail.gmail.com>
Subject: Re: [PATCH] stm32l4x5_usart: add missing class_size
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 3 May 2024 at 12:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Depending on the phase of the moon, this seems to be causing CI failures =
on FreeBSD.
> Fortunately, valgrind catches it too, and in a fully deterministic way:
>
> =3D=3D210026=3D=3D Invalid write of size 4
> =3D=3D210026=3D=3D    at 0x5222F3: stm32l4x5_lpuart_class_init (stm32l4x5=
_usart.c:611)
> =3D=3D210026=3D=3D    by 0xA499E1: object_class_foreach_tramp (object.c:1=
132)
> =3D=3D210026=3D=3D    by 0x5A60BEA: g_hash_table_foreach (ghash.c:2117)
> =3D=3D210026=3D=3D    by 0xA4A190: object_class_foreach (object.c:1154)
> =3D=3D210026=3D=3D    by 0xA4A190: object_class_get_list (object.c:1211)
> =3D=3D210026=3D=3D    by 0x7A5777: select_machine (vl.c:1664)
> =3D=3D210026=3D=3D    by 0x7A5777: qemu_create_machine (vl.c:2104)
> =3D=3D210026=3D=3D    by 0x7A5777: qemu_init (vl.c:3667)
> =3D=3D210026=3D=3D    by 0x47E528: main (main.c:47)
> =3D=3D210026=3D=3D  Address 0xe131340 is 0 bytes after a block of size 19=
2 alloc'd
> =3D=3D210026=3D=3D    at 0x4849E60: calloc (vg_replace_malloc.c:1595)
> =3D=3D210026=3D=3D    by 0x5A79F71: g_malloc0 (gmem.c:133)
> =3D=3D210026=3D=3D    by 0xA48E9B: type_initialize (object.c:361)
> =3D=3D210026=3D=3D    by 0xA48E9B: type_initialize (object.c:336)
> =3D=3D210026=3D=3D    by 0xA499E1: object_class_foreach_tramp (object.c:1=
132)
> =3D=3D210026=3D=3D    by 0x5A60BEA: g_hash_table_foreach (ghash.c:2117)
> =3D=3D210026=3D=3D    by 0xA4A190: object_class_foreach (object.c:1154)
> =3D=3D210026=3D=3D    by 0xA4A190: object_class_get_list (object.c:1211)
> =3D=3D210026=3D=3D    by 0x7A5777: select_machine (vl.c:1664)
> =3D=3D210026=3D=3D    by 0x7A5777: qemu_create_machine (vl.c:2104)
> =3D=3D210026=3D=3D    by 0x7A5777: qemu_init (vl.c:3667)
> =3D=3D210026=3D=3D    by 0x47E528: main (main.c:47)
>
> Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Cc: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/char/stm32l4x5_usart.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index 2627aab8324..8dbcc7e19e7 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -615,6 +615,7 @@ static const TypeInfo stm32l4x5_usart_types[] =3D {
>      {
>          .name           =3D TYPE_STM32L4X5_USART_BASE,
>          .parent         =3D TYPE_SYS_BUS_DEVICE,
> +        .class_size     =3D sizeof(Stm32l4x5UsartBaseClass),
>          .instance_size  =3D sizeof(Stm32l4x5UsartBaseState),
>          .instance_init  =3D stm32l4x5_usart_base_init,
>          .class_init     =3D stm32l4x5_usart_base_class_init,

This is already upstream as commit afdc29b4a3a5, I think.

thanks
-- PMM

