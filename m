Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9BDC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH1u-00012a-Bw; Thu, 04 Jul 2024 03:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH1s-00010r-3N; Thu, 04 Jul 2024 03:37:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH1f-0001Xq-0Z; Thu, 04 Jul 2024 03:37:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so2729925ad.1; 
 Thu, 04 Jul 2024 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078625; x=1720683425; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZ1Jm6Uo6MZRf/4w1iyxc8nzwpH8u35CAUfcuquDORw=;
 b=dnpeMdkdWaBz4X3W6aGt8d6yKt8iCrVMtAAmwOWsgTvFR4cdQeecVrxD09tk2yXgYK
 iRqeK+j5F0QpqdPxGgbpfENDEC1FE6eTArNN1L6T9APCL8H7ZKMdIfivM0GTwhk4hm6q
 29z1YZL5XYUlLlUItwwLmyYCPXmCgMypZEAElHSD6Y7kBouQ9k903hrKEwOBFmA252Ja
 pop2wNdT1mSM0G7JCR0dtoxxR7y3TjD5oTXTJUphMPsotZrEsKIWIT5VFHPzbAv+395l
 +Tf7qlF0guR4/xx1rRMchZY//0RcViGlBZEft6BB1Cmvy9VwGCblh0qUE0R6SeN+m12W
 e9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078625; x=1720683425;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QZ1Jm6Uo6MZRf/4w1iyxc8nzwpH8u35CAUfcuquDORw=;
 b=mdY6/MJIN6oHDkQtfYr6Sjnf1eC3hoOl0ZKp6QW0kq0Bk5+/NyYBbuFiP3VJBtnLra
 f36vNj7SlGu4mjrzN7S44H4GWyQeXE+Y8bJo8XkfiyDbwdXYenLPBstq7c86eHD6qpgs
 GikbXwejrnA9h0ClV/y8hiShRhDzhR4gfndZjQn/E83/FmIJpo5nYybcGcuq/fTYbDKm
 Dl3eESR0ga/lP3gxV5FJ0wArSaQloGePewsZwTsuKkO6PLzoZsQZ7zCfiM0466ieRgE/
 FbGFOZ9SHagEu0lG+xn28NzkVNzl3ZCEH7mJDn0dYM/4T5LIu8td7Yoj04BZroNj0NRD
 iR3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3gffnyfcugVERlTpXX9bBBU5tnD7zPorZLaLyCZoPG5Be+prw8LEJPDlNd7gcLdGKbGt0lsGauIJQET0OnOOsa3LCz00dDtHLNT0cxmxpHzBshP16nKrf50c=
X-Gm-Message-State: AOJu0Yy7lGCaIqCjmD9aeTwyr2OTpvqtwHRmko2DOAphTvkCLehUsTYH
 /iFlz8nBArbe974RKKq59MIosV/IJrG85d00Hhbi8xq3ClSWMiuMA1cQbg==
X-Google-Smtp-Source: AGHT+IGzI3pJU1FlO6KByF4+po1ao2DJt5/VdlUJsVQBo0ajcVEbYp5dHxF4e1lCG1jgmggMUTRZVg==
X-Received: by 2002:a17:902:d4d1:b0:1fb:d7d:7406 with SMTP id
 d9443c01a7336-1fb37016346mr9010835ad.7.1720078624873; 
 Thu, 04 Jul 2024 00:37:04 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15b8ea6sm116172255ad.308.2024.07.04.00.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:37:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:36:59 +1000
Message-Id: <D2GKZCUQCJC2.2PUUC0GX1ZB83@gmail.com>
Subject: Re: [PATCH v2 1/7] target/ppc: use locally stored msr and avoid
 indirect access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-2-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-2-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> hreg_compute_hflags_value already stores msr locally to be used in most
> of the logic in the routine however some instances are still using
> env->msr which is unnecessary. Use locally stored value as available.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/helper_regs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 25258986e3..945fa1a596 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -106,10 +106,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCSta=
te *env)
> =20
>      if (ppc_flags & POWERPC_FLAG_DE) {
>          target_ulong dbcr0 =3D env->spr[SPR_BOOKE_DBCR0];
> -        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(env->msr, MSR, DE)) {
> +        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(msr, MSR, DE)) {
>              hflags |=3D 1 << HFLAGS_SE;
>          }
> -        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(env->msr, MSR, DE)) {
> +        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(msr, MSR, DE)) {
>              hflags |=3D 1 << HFLAGS_BE;
>          }
>      } else {


