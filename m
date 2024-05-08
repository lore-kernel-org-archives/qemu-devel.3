Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE2CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hGO-0001s9-Gv; Wed, 08 May 2024 09:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hGH-0001lg-Fp; Wed, 08 May 2024 09:23:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hGE-0004Nz-Rd; Wed, 08 May 2024 09:23:08 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso2749063a12.2; 
 Wed, 08 May 2024 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715174585; x=1715779385; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPYJ0SW1ITRT82SO3h+64ftDXPKziYNO/iscT5aWmnc=;
 b=Hmiv8c+Y0U4Ej3r3fNwPYflmQcrCTzlwakI16w0wJAxy0SHDo5FP0LA0C8L9PMa2C2
 L2RyfbCoWGWCl8avl5KCgSTZv+0HfLDU33m0h2wCXDfyzUjpSZoNqGyjN7BGZ2ftcK8Y
 +7LuR+klkRm8kuyMHBTpPKDta/OAKh1uwfaXiU5pgDNLf7ZWhkWwbbTqItqM8a3GDc1a
 bxUw3FdNmP0coKrWuvgQNgJdT/+c4NvmHpP3ZRWMMHRU1miFiObI9ligYoo6OrU2375S
 nP9xEvaZv7hFxJGLSbYvWDzRfSE823Zte8MwJ43U8xWMaKEO/rLYAcQJPUsepu0u8If+
 5pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715174585; x=1715779385;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pPYJ0SW1ITRT82SO3h+64ftDXPKziYNO/iscT5aWmnc=;
 b=A8LJwLTIq+WgPOKU3MNA9S6/ASMXilyQamMVJ9Q8CNyxwFSm+BKLkKmQnh+mDnCH3B
 DlCyWI+6vFojgn1cy4qQABXT2jt+vNh0GAOg98n1ZT/wak+MrzeoXdqXUUw8rK6L+4Sw
 IBrJnrONHCXBw7N5HmkuxvYGIpyqib0wKwXMkpHNbcFNnZV4Mcb7ULszw7Q3gKc7YLLC
 7iKvB9DMJqGdgldO7U1ksrplXSvcmfmRbvrtNM4osE71HKO8gCQtdPZ16m4Ye5Lvc3IO
 itbPNKR120g9dlPmsGyr+2tQtwDIPyyP794N+kR+BJrvbUWK1DCA9lTDPTHTaRhxnH1P
 ZSTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu9rMKVv2+C9+ZzxK1xpdqMjkWmRKqKAttdp2oGxjwjDaueiMq/mCC/Ynwnv3SjmdKhJQmxSeoceVbr67V0L0euMtoXZBa9dwxND+QTujhons17N/F6OwCxKE=
X-Gm-Message-State: AOJu0Yy80b1uFEiR4LkdkIDc/Y4ZmXGgcNFuUD8djSJNXc/TVH3Ri8Ub
 ihZxRd44vnveX+rY03XDFD4595JQNfqMHEeaBQM1QiS0g2kV9TktR2GPUg==
X-Google-Smtp-Source: AGHT+IFFI3Da5TVxRLWMeeuzUppNgJd2n7jYGSEyPelFsGtOZbfg1XTkASl0Par9AWlnodHbiDXVdg==
X-Received: by 2002:a17:90a:de90:b0:2ac:86c6:da with SMTP id
 98e67ed59e1d1-2b6165adcafmr2546544a91.18.1715174585121; 
 Wed, 08 May 2024 06:23:05 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62863a265sm1397119a91.10.2024.05.08.06.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:23:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:22:59 +1000
Message-Id: <D14AN86BCH08.3M86UVKLH3BVT@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 32/33] target/ppc/mmu-radix64.c: Drop a local variable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <043208173865575e0148ad19b8a3b4e1a96f0c4c.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <043208173865575e0148ad19b8a3b4e1a96f0c4c.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> The value is only used once so no need to introduce a local variable
> for it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-radix64.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 8daf71d2db..395ce3b782 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -185,7 +185,6 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, M=
MUAccessType access_type,
>                                     int mmu_idx, bool partition_scoped)
>  {
>      CPUPPCState *env =3D &cpu->env;
> -    int need_prot;
> =20
>      /* Check Page Attributes (pte58:59) */
>      if ((pte & R_PTE_ATT) =3D=3D R_PTE_ATT_NI_IO && access_type =3D=3D M=
MU_INST_FETCH) {
> @@ -210,8 +209,8 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, M=
MUAccessType access_type,
>      }
> =20
>      /* Check if requested access type is allowed */
> -    need_prot =3D prot_for_access_type(access_type);
> -    if (need_prot & ~*prot) { /* Page Protected for that Access */
> +    if (prot_for_access_type(access_type) & ~*prot) {
> +        /* Page Protected for that Access */
>          *fault_cause |=3D access_type =3D=3D MMU_INST_FETCH ? SRR1_NOEXE=
C_GUARD :
>                                                          DSISR_PROTFAULT;
>          return true;


