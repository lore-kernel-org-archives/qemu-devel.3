Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC7C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC71B-00048e-8f; Tue, 28 May 2024 20:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC718-00047a-SE; Tue, 28 May 2024 20:18:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC717-0000R8-5z; Tue, 28 May 2024 20:18:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f4a52d2688so12497615ad.3; 
 Tue, 28 May 2024 17:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716941887; x=1717546687; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwwNfKCIC8D9R+I16WnKmDu1zo7JANh0LjMYluw6MoY=;
 b=IZwt7uO80U+buQZmxTPDe9p9S+neJvZIPvTC8mSc742rIC27dDwd4akW3x4lPPvMPP
 N761ILWJv3VNgZpd/a0fdUfHT1IvsDkTRu7caRgFWEjhyy26967pkbizpD9g9mdB54rW
 wJKTp/aTQ2u/N0hFutVd8/pyCSHSJLdNFGGvkJgN59yPZrKohFytBsLpWMZ5HNsGGFsJ
 mZsfIaA75mSBW/mKh3qsCnAlHLPgOnGmsetcC16zhkfF+HUUcNebctxfUhzwNveyhpNQ
 kqNIV3fX+/uvA2OZMJeobpIiuYa4SF4Sj2YyJnDVKRACwZicw+YSRNiBk93nF5yyg+dB
 /tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716941887; x=1717546687;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PwwNfKCIC8D9R+I16WnKmDu1zo7JANh0LjMYluw6MoY=;
 b=KfnNH9lGCsnH2ZY7p4odTyccxaqER3Uqvq6JY4S+4G/sY61ymRH3X19mnZOzXgbfJC
 Dr6izgqK5QRNf+mmv7t9caKPd8lAuo5GGxbwxkuOBSJ++w583nIusoOzjjS3PxaxgR68
 4mHVVwXSuplZmHjcJ5yyzn99DpYz3tGEyEiHtiTckIdyvwPEJIgNGhw2NwRKHQdpTG3d
 PqaycgwnkBcxqut2bQfrBg+Y9Vo5pf5vp42Iwg3kXEBCsrkXzKuvf1RUmNfJ78i0mHaS
 Mjc64jsnpv1+E6OF3LtvoXYiEsUbd9qnz+9qgo66hTl7sbWuFzpeRa8ltDBbB4VpuY1X
 3FEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGDlYx4j+tBlqnHHVx9rTwX3FsdaIxfX9Ij8Oj4pRYtxtc9XzLoOaHG7JKFJgFpa5KcHOSLW+7s3AedTBxBv68T0bKPbTlgePqM5pYYSS0duvQYeGes68uTc8=
X-Gm-Message-State: AOJu0YwNoUZowiyhTh+MM0D3LLjnzAhbIVFF1B/NMbIFy9KKd4jbyVWS
 BCtU+ioKb/aW0se3AF0U4ROl9RhAp+baPfN7nAVK6ZTSLCIiPUft
X-Google-Smtp-Source: AGHT+IFBDfMzaeFfdy+Kmj/NSn8ILtquPhUm10dRDsduhDg6tBjBrB6tpYGFWOHUCqbzt8K/6b51tA==
X-Received: by 2002:a17:902:c94c:b0:1f4:7f18:6d7c with SMTP id
 d9443c01a7336-1f47f1870a4mr136344975ad.61.1716941887085; 
 Tue, 28 May 2024 17:18:07 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759d16sm86395635ad.28.2024.05.28.17.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:18:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:18:01 +1000
Message-Id: <D1LP3NMP0LDX.375776DM46MZR@gmail.com>
Subject: Re: [RFC PATCH 04/10] ppc/pnv: specialise init for powernv8/9/10
 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-5-npiggin@gmail.com>
 <721d6b4b-0026-44c9-a97b-a007cc1ff5eb@linux.ibm.com>
 <d56be3f2-0e63-4db3-aba5-112cda695cfe@kaod.org>
In-Reply-To: <d56be3f2-0e63-4db3-aba5-112cda695cfe@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Tue May 28, 2024 at 5:45 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/28/24 09:10, Harsh Prateek Bora wrote:
> > Hi Nick,
> >=20
> > On 5/26/24 17:56, Nicholas Piggin wrote:
> >> This will allow different settings and checks for different
> >> machine types with later changes.
> >>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >> =C2=A0 hw/ppc/pnv.c | 35 ++++++++++++++++++++++++++++++-----
> >> =C2=A0 1 file changed, 30 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 6e3a5ccdec..a706de2e36 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -976,11 +976,6 @@ static void pnv_init(MachineState *machine)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pnv->num_chips =3D
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->smp.ma=
x_cpus / (machine->smp.cores * machine->smp.threads);
> >> -=C2=A0=C2=A0=C2=A0 if (machine->smp.threads > 8) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Cannot suppo=
rt more than 8 threads/core "
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "on a powernv machine")=
;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> >> -=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_power_of_2(machine->smp.threads=
)) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("C=
annot support %d threads/core on a powernv"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "machine be=
cause it must be a power of 2",
> >> @@ -1076,6 +1071,33 @@ static void pnv_init(MachineState *machine)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0 }
> >> +static void pnv_power8_init(MachineState *machine)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 if (machine->smp.threads > 8) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Cannot suppo=
rt more than 8 threads/core "
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "on a powernv POWER8 ma=
chine");
> >=20
> > We could use mc->desc for machine name above, so that ..
> >=20
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> >> +=C2=A0=C2=A0=C2=A0 }
> >=20
> > with this patch, we can reuse p8 init for both p9 and p10 (and not just=
 reuse p9 for p10 with hard coded string?).
>
> Good idea. You could add a 'max_smt' attribute to PnvMachineClass to limi=
t
> POWER8 to one.

Okay I'll see how that goes. Good suggestions.

Thanks,
Nick

