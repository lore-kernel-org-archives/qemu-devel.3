Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBCBC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 04:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkce4-0002qK-A5; Thu, 14 Mar 2024 00:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rkce3-0002q0-AN; Thu, 14 Mar 2024 00:24:43 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rkce1-0007ap-RQ; Thu, 14 Mar 2024 00:24:43 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c1ea5f29a6so300775b6e.0; 
 Wed, 13 Mar 2024 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710390279; x=1710995079; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLeUg7k1kr6nK0wA17tOGr6q3wL9Ha2oB28Dwalb0Pw=;
 b=TB89LIyfoIzggPH1NosrFUhR86mijh3HRTlNlXl/vtVxXZwjElLUSrmfLGXqSkDnIu
 0r2VmZzJxgZhm26qsNNbXcHUCeAuLqzYl2NDh8TGeL4z7eZaBEO5yX4mOE21Sbd14Ut0
 yVCdCqnxGn3pOh/9gEVgEKCnMtcu1y9OhLR6/aCZKg1AdKDZ9Hb132EsffVkFJwSyZfP
 4wQ6gZ17baxtPww3JALOALJicsl3NzLM24hobTfCrIlDfv7IHUrogYeln1s82GpIAlJW
 9CGwQYrJ6BqfcUBlJS/u5GmXEPKY5BtoOzwltlt3R2h1IKaQ/pe1w1MmzSd2acO6Z6go
 z59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710390279; x=1710995079;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yLeUg7k1kr6nK0wA17tOGr6q3wL9Ha2oB28Dwalb0Pw=;
 b=VYA4kWtjpCvpz5llu8KOq+YmZ5KgYqmnDdCQMztZLR0JV1EdA1U73uabYKOdA2Wiw9
 PSipmpPPjFnSK1W9oYB1WjCe8DC5Nk2PHbIs5Puc8e9ue3kLKmKFHPQd6AKB0reBEWLz
 2evJovHIdBazygS4CraMwOlOZaais4wmZEMAQOFsjoDplC9zZCTDbHs8e+nNdzlC3yZh
 rDCqD9g+cXVIH+kMdZYRxWFeJHI+SLm+2tbA/wpcmZAHQgmsjEakC9FyG1sqrkKGipo/
 05Q/1EettXcDhQqTbltONTuFmrZymKvhJJ6dZzrOvjkM0eSsEzZ95zpbdLOobsX52IH3
 5S4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs+pjlSq0bS0EO6ZmGJvsygkALaqCT80UZeWX7BjhFRoM5KVm0loMC0Dpr6HyZftp+nfBqxz7S9ANAByffXMcx4zVpRqjSB9UYdBy8l9Z9/McY4wHWCeQQVUE=
X-Gm-Message-State: AOJu0YyogeUBuI8VMBSddQht4iAUMjrALkh7YO1Iz1O2Yaz1aNNMIMOc
 s6IXUGV5LAGn27K992DRdHNvt6OesVb9l6ZdDq+6EoL4vxo2qwRr
X-Google-Smtp-Source: AGHT+IFOk3SZz3vPdus/fMMnKX1q0wSHsOQcwJZgvTdFB6sB4WjFxLG4WcmL/NVKBlsYsNnRFbVDpA==
X-Received: by 2002:a05:6808:3c9a:b0:3c2:423a:5563 with SMTP id
 gs26-20020a0568083c9a00b003c2423a5563mr918170oib.45.1710390279326; 
 Wed, 13 Mar 2024 21:24:39 -0700 (PDT)
Received: from localhost ([1.146.49.180]) by smtp.gmail.com with ESMTPSA id
 fb12-20020a056a002d8c00b006e4f644dafbsm425405pfb.129.2024.03.13.21.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 21:24:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 14:24:31 +1000
Message-Id: <CZT6QZEBJJW3.2X68F2XKUKM7T@wheely>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Thomas Huth" <thuth@redhat.com>,
 <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH-for-9.0? 05/12] target/ppc: Rename
 init_excp_4xx_softmmu() -> init_excp_4xx()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-6-philmd@linaro.org>
In-Reply-To: <20240313213339.82071-6-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu Mar 14, 2024 at 7:33 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Unify with other init_excp_FOO() in the same file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/cpu_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7e65f08147..b208bd91a0 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -1642,7 +1642,7 @@ static void register_8xx_sprs(CPUPPCState *env)
> =20
>  /***********************************************************************=
******/
>  /* Exception vectors models                                             =
     */
> -static void init_excp_4xx_softmmu(CPUPPCState *env)
> +static void init_excp_4xx(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      env->excp_vectors[POWERPC_EXCP_CRITICAL] =3D 0x00000100;
> @@ -2120,7 +2120,7 @@ static void init_proc_405(CPUPPCState *env)
>      env->id_tlbs =3D 0;
>      env->tlb_type =3D TLB_EMB;
>  #endif
> -    init_excp_4xx_softmmu(env);
> +    init_excp_4xx(env);
>      env->dcache_line_size =3D 32;
>      env->icache_line_size =3D 32;
>      /* Allocate hardware IRQ controller */


