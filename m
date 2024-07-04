Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9F7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH2U-0001kT-Qf; Thu, 04 Jul 2024 03:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH2R-0001jl-Pn; Thu, 04 Jul 2024 03:37:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH2Q-0001ak-8x; Thu, 04 Jul 2024 03:37:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so2280715ad.0; 
 Thu, 04 Jul 2024 00:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078671; x=1720683471; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIg7ASQG2FHtWWPQ/4aSDUi30V3p0iwFrvwLp7QEGVg=;
 b=dG/3AezJIrSoG2qd+zZMqgvouzmc4DBpuGiycoCsJOiSjjhTOBT8w/YZuBr8bGJLLX
 lJCm+JYy/GNzwOSottmH+qg6VKtbjOMtWGGS1dadEEpnJlZ/FAJZTn2+3aN4tMjcK6CC
 gUprm4Z2Gcau3uMebjozrsblxtYW+EZzZrzwLTSmEzYlBJsZWwu8SvLWgx07K4ghIF9L
 6UTe4AQs1pEn2qQL4wVNMymL9cY3bxXeo4blikqifXCRo+M3nU132Lilqp7O04UsKf5J
 L/bsS2wvX9WS89dHxKjSPnOWI5OWUmIp06nUYHnnVtXcr+kSFiMT8dumE+jwYqZ4LEQG
 dSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078671; x=1720683471;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EIg7ASQG2FHtWWPQ/4aSDUi30V3p0iwFrvwLp7QEGVg=;
 b=ouzMQdKpcARbzfsUysLmty2DszcVUliGQtBMFiQ+lAvCeSUFiCMq7hIaL+jjvsKA2s
 RDNYpqruhZKAnVuM3p1/xaOiTzkahmegjukb1T/eg14I85xY4sbKUFeTdGRVpVtYqHS9
 RFC21aGlyhxJ6BpJYpoZcsZ4cTzBHlxWhRucBsbAZzDwfeyZv/BMgaV1f5PuL9lwa+FW
 8vmY+q06Dwqh4brPBf+sJ/4uH3BQbIZ4MwD+11yYCR0GXS4/9/ftXitD6RxkZBZCs/fU
 v4dNqcK/wjmg14dRO39+IWVeRgCJKuFaSwHH6zqTeKkW5ahzEbY060kXslCmgNRzVT8Y
 wwnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwfWySkFdOBflcZDJMmBohviYQ3mTpIfcnLL4Yh7BEqcwaCP+3zeUIKK6NreH2sQQG09FQJ9B/AI20YK571Wd5zKtk2IoxWBWSEYBSbKnwtQEd7KXhoeS9FWE=
X-Gm-Message-State: AOJu0Yxm61JTmmUW4sT3iQR7wIDBAct9RmpNlj/R0oGSxu57IL02iZ51
 aBh3n+5asdrfKMcEh4XUvFYUnN36ffijTB+e1N2Ibl63x25no6mo
X-Google-Smtp-Source: AGHT+IG0t7VaB57XjED6NQ0sR7uzeQjQqUtNNr9s9vbWQANenfQmIm2j7mno0iJn4iZKETKdgOsJPg==
X-Received: by 2002:a17:902:d4d1:b0:1fb:247b:aa1d with SMTP id
 d9443c01a7336-1fb33f35996mr7480605ad.68.1720078669902; 
 Thu, 04 Jul 2024 00:37:49 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb31c56576sm8807335ad.13.2024.07.04.00.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:37:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:37:44 +1000
Message-Id: <D2GKZXKACA3L.25STB8F1G4LLN@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 2/7] target/ppc: optimize hreg_compute_pmu_hflags_value
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-3-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-3-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 23, 2024 at 3:14 PM AEST, Harsh Prateek Bora wrote:
> Cache env->spr[SPR_POWER_MMCR0] in a local variable as used in multiple
> conditions to avoid multiple indirect accesses.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Compiler might cache it in a reg, but anyway I like it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/helper_regs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 945fa1a596..d09dcacd5e 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -50,15 +50,16 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
>  static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
>  {
>      uint32_t hflags =3D 0;
> -
>  #if defined(TARGET_PPC64)
> -    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
> +    target_ulong mmcr0 =3D env->spr[SPR_POWER_MMCR0];
> +
> +    if (mmcr0 & MMCR0_PMCC0) {
>          hflags |=3D 1 << HFLAGS_PMCC0;
>      }
> -    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
> +    if (mmcr0 & MMCR0_PMCC1) {
>          hflags |=3D 1 << HFLAGS_PMCC1;
>      }
> -    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
> +    if (mmcr0 & MMCR0_PMCjCE) {
>          hflags |=3D 1 << HFLAGS_PMCJCE;
>      }
> =20


