Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F99C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HDX-0001A8-5Z; Tue, 07 May 2024 05:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HDQ-0000xz-3k; Tue, 07 May 2024 05:34:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HDN-0004Vz-FN; Tue, 07 May 2024 05:34:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1edc696df2bso21557735ad.0; 
 Tue, 07 May 2024 02:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715074461; x=1715679261; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WbINDgkkfPfKXjNvxW/gL34LtNLg70PMqKW40TMZN0=;
 b=QWYpIfl4pvLhmcDjpuRkgwtFxw1hXF5LeZGoHsudB2ngJft3d2bE9a4Nvqsh9xaBUa
 VlplTLfEOpF6ur4+73+oKZBBGxXG4VpTbeGC5/+M54pxiJl1PHPVmItWHfb34V2vO7wO
 I+0gjv9f4zTkN9yljJnRUgDtQJaDCfsZVaNbjxaUhin9mCUJzV8pF/355j4bgGqswvHO
 uMRT9GK58UdYuQD6esKpnl0vL/I+bX0CjmR9llmpVqaoM+5zGSUYGDH6Upku310BkHhY
 6TjR0u4FLLi3dttNih1Jse9Iut6LDIlrw+E3R0KmIsWT5XgaljapzNPVt+vexz1Mczs1
 yyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074461; x=1715679261;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4WbINDgkkfPfKXjNvxW/gL34LtNLg70PMqKW40TMZN0=;
 b=eK7YKAxpDruoOPgByD1W/Q63s0LxPDgI3TUIp6BWJBZkQa+RU8d5Fj/KcJ3TB4ExNs
 cmYqpEQiCOsHdK645wtVmpgaEq+8ial2Fx25kro2tuYi9fRbHujb3iKB6+Rx5fIvjTIE
 RV6MdtqqwD+AOpF0Dd7iRdf8YrZBEdiRoo5YgX4oAw5E56neu2CX0jUk7P2PgIUAI4ca
 dxX1gJc9dL7qRlw0feoMtuHC8XtKTOb1DQpwcA3oK+0KxmnDFWkdrE4PSBsPHAb7hU+T
 s3XrdLCi5WjD3DidyaZSjH/ipGLPSW/5b9t6F+ZuR1tz9/svznmt/A5H334q6VeZrqJP
 8DCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbVFPbvbnicvvJldA2tYYJM5/v+PyVwrgONPWx6RLftFXNaFZJF3PrSDc5GoKy7o5147iyQy6SHcB6NgthMjoMPp/NUn4YKghZQ7AVAinJYJI5N38uPvezy9Q=
X-Gm-Message-State: AOJu0YzdSlJ2wcHBVNctQm+6qFEBhP2FjUx/IXsU0AEOPddSzaPE3IKf
 3EshFNBJLVW16XB3GSpNZBBYXqHouQBuTw7gpzcKoVGqZ0W2t+2L
X-Google-Smtp-Source: AGHT+IFMsi4+VLJAbqQfwgzssNqfsMS90+nvzedOmy4pgqFR0zVZhCPjBW5ll75aSSIX2vri0QDxWA==
X-Received: by 2002:a17:902:d482:b0:1e2:d4da:6c72 with SMTP id
 c2-20020a170902d48200b001e2d4da6c72mr19095442plg.0.1715074461515; 
 Tue, 07 May 2024 02:34:21 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 kw4-20020a170902f90400b001e47972a2casm9714672plb.96.2024.05.07.02.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:34:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:34:16 +1000
Message-Id: <D13B5K3KLVFZ.3UKXRY5YPY58M@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 08/28] target/ppc/mmu_common.c: Simplify checking for
 real mode
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <6ff205449ce39d0aa76eef96cd8d758f568f4b50.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <6ff205449ce39d0aa76eef96cd8d758f568f4b50.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> In get_physical_address_wtlb() the real_mode flag depends on either
> the MSR[IR] or MSR[DR] bit depending on access_type. Extract just the
> needed bit in a more straight forward way instead of doing unnecessary
> computation.

Hopefully the compiler should be able to work it out, but IMO it
reads better with your change.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 74c3b814c9..45b6501ecb 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1183,8 +1183,10 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>                                       int mmu_idx)
>  {
>      int ret =3D -1;
> -    bool real_mode =3D (type =3D=3D ACCESS_CODE && !FIELD_EX64(env->msr,=
 MSR, IR)) ||
> -                     (type !=3D ACCESS_CODE && !FIELD_EX64(env->msr, MSR=
, DR));
> +    bool real_mode;
> +
> +    real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)
> +                                      : !FIELD_EX64(env->msr, MSR, DR);
> =20
>      switch (env->mmu_model) {
>      case POWERPC_MMU_SOFT_6xx:


