Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344A8C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezRu-00044X-GM; Tue, 27 Feb 2024 10:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezRt-00043s-1T
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:32:53 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezRq-0005CY-Hd
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:32:52 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56657bcd555so231589a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709047969; x=1709652769; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2N2ryzAbZSNxl9SrwXCGoeVoeV2TQywNprJQRi5gziI=;
 b=G9c6kDG5u+pGkWo0RYSPzXoteHPChwXiB1nI/oi9VPNf+HcawUlKO0JkJIY1zLH04J
 ZJNxgly3wFiF6XKXVOZeezocFUgAtO9TyZdMIppgXbO1WRy8wGXx+pr6a3EPgAsGmk0q
 7/EHbDjrTSdDLaoVn9hQOCRQ06ccK5KudnRct5MOxERY6INcp5bKvz1gFBvYiusp6E0+
 6R+cgbmpDAgCsSO/VcA4aXveKSNyBHekwgx0e3ltYA4LPRfC11x6m9wzQLBJZ0IMNf3j
 inqagUc0l9gfG7DSX1RFGgjAzkHz31/wTO1unadW4qCzfceG1ZTKJbtn+3dUmOCibqES
 1aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709047969; x=1709652769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2N2ryzAbZSNxl9SrwXCGoeVoeV2TQywNprJQRi5gziI=;
 b=IiYheR83PhXqUmsPBCS3hg8+cV//UU7nSyezxMqbeFKODB4cWQrYl4u+rLQHf0k4GN
 vL8yh4xqw6RPpb9/+dPrWeKP8I6Kcc78IfHP0vG4X+UBHjmgloN3ejXgQrhHQQLTXVyv
 qeEFyqFv6oBqlkT9LTcAD59Jv0QLQjl1MuZYvCh8icgnIPRl6K5Vx7PNzBb9gzBCFowO
 zZzc4yx7DoPGrALqVIqWuL5iOX4Tzd0bT2/E+zt7/uIvx98hA6DsUQUR3gkqothl8hg1
 8znryHY2nxAv6Ag0RzQgMYRgLso9Cnzyw/ua99+Gk4q8AodvwcgPORVEZgQ9nuRpU1RF
 Xkig==
X-Gm-Message-State: AOJu0YxDg6iqXUl76ELK4tWI1nPlaewE6t4kj7Y9l/kNwQK+bhO7ZzQB
 PCs2lJtWNpV60xNoUJW7m0jCqS68Z5LKdXRu2mZT8nO5WfR5AMvaaa/IEvmOkvNfJ31WCz8+Guq
 TTYd9Nq2rJJ/Kse1HnafCuyfse4sNPX0nS/LHCQ==
X-Google-Smtp-Source: AGHT+IHLPOkQMh2Tx16LNLq/vxtBHB08/r8hjD3DzNCiW831OmDDXrUhXcov+V4bD87s3Hxo0qqY9X/xhHixRLajihU=
X-Received: by 2002:aa7:d912:0:b0:564:a62e:dad with SMTP id
 a18-20020aa7d912000000b00564a62e0dadmr7192968edr.34.1709047968487; Tue, 27
 Feb 2024 07:32:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1709045654.git.balaton@eik.bme.hu>
 <a06f6259d7a37aa88145fb13e4bce153ff763f86.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <a06f6259d7a37aa88145fb13e4bce153ff763f86.1709045654.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 15:32:37 +0000
Message-ID: <CAFEAcA_6R2wLaLOoOBQ0-Z_QydAEgxANmNPdKaAF=iiroFEhmA@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] target/ppc: Readability improvements in
 exception handlers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 27 Feb 2024 at 15:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Improve readability by shortening some long comments, removing
> comments that state the obvious and dropping some empty lines so they
> don't distract when reading the code.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>


> -    /*
> -     * new interrupt handler msr preserves existing ME unless
> -     * explicitly overridden.
> -     */
> +    /* new interrupt handler msr preserves ME unless explicitly overriden */

Minor typo introduced here: should be "overridden".

>      new_msr = env->msr & (((target_ulong)1 << MSR_ME));

> @@ -575,16 +558,10 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>      /* new srr1 value excluding must-be-zero bits */
>      msr = env->msr & ~0x783f0000ULL;
>
> -    /*
> -     * new interrupt handler msr preserves existing ME unless
> -     * explicitly overridden
> -     */
> +    /* new interrupt handler msr preserves ME unless explicitly overriden */

Ditto, and similarly for other instances later in the patch.

thanks
-- PMM

