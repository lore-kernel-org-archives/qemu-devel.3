Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233CEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 04:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rju1Q-00025t-Jl; Tue, 12 Mar 2024 00:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rju1H-00024e-8J; Tue, 12 Mar 2024 00:45:43 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rju1E-00066O-PO; Tue, 12 Mar 2024 00:45:42 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47259486a1fso1141264137.2; 
 Mon, 11 Mar 2024 21:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710218739; x=1710823539; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDlnElUnZQclpggVsBHT/fWsJOMkotZofahlKgudGxA=;
 b=ZLcxy6gzp8RTHilwb+EYZKLc6H8qY7Pk7GRLBu58WaislP+Xi2gxZRRuWiLMGaSGRy
 FfQHkZ68Y4KAUQHSVWsrUr80ik7fXoDJ6LQXqBEW/LSXvjg/bME+GStq8cAwYzcczEUs
 nriZohdJPzE40n/UQ8tfZ449dOUNKqNGVdZSrUTpAnZYcm3PCOFLPybkQyloyNArYTe2
 T/3+17rHAyaXQQfGmt2hDf2d+5kswK3RnIvmgZf1LdSP6eISI3YJ20EPCO5DKR3HRvbV
 Tw0akT0l75oth2lIbREgMmdrXTPvV85GvRht93TwGEn9buIZ0qfDxCWdLSYQMO42xGDs
 ERWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710218739; x=1710823539;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vDlnElUnZQclpggVsBHT/fWsJOMkotZofahlKgudGxA=;
 b=TrRf7cwZp1ga4DQiTejfPKbm4C3PQ3ypdzY4CFwnGvJr9B1+GInGkymABYu/RRD3Fk
 /f4IZIiTNse3NshP6kXjPnAucYa6veobCMyQybWN7LaezZGOeygdJyYK83Pii24q87RH
 mEHMDN8+hP5eMZfyfYaSjJTsO29gCWFwlsU91aYTs5dMB4U28/T/r0VlwwAHxM6nr0Wj
 i9QlVJ+2Vc6ZDr5Ct9m3IH+yjpaIWrl7TFuwrDsL1T0UG+huLQdV/qzP3pT4/lsTqvvm
 CV+y8aaBM8NsYw+kskDTDcEGwXUvo5tVyQvZlDW8v6hEr/c76kJtSZ/tx/2HgfscyhO2
 N7LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVkd5234Q8Z69SnBJ3ctDo0Dvaj9tuuS/mF0bpifyOcPl7Uad0Qd2gUhamiiay3wHSg+8sW/PaxPmVE2ow5uFPiMjt
X-Gm-Message-State: AOJu0YwgIhEk6uF4+9cv6xao+WClpQttFwoEX0YsQVgrl/fQiEy9EF2t
 WwQDWVvGpvPTfAJLUVq+Bx4TB7cyiGFhcgigQtIs6/6y5Djw5PO/
X-Google-Smtp-Source: AGHT+IHIVRywKvTjHT8DvJ2YsSbm356w5oKlfZDYOQBTJz7KLFclkKLwPa5CfXHbSIwSfbsDLMI6Fw==
X-Received: by 2002:a05:6102:3089:b0:472:d517:24e1 with SMTP id
 l9-20020a056102308900b00472d51724e1mr5833836vsb.29.1710218739289; 
 Mon, 11 Mar 2024 21:45:39 -0700 (PDT)
Received: from localhost ([1.146.55.44]) by smtp.gmail.com with ESMTPSA id
 m22-20020a056a00081600b006e52ce4ee2fsm5180492pfk.20.2024.03.11.21.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 21:45:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 14:45:32 +1000
Message-Id: <CZRHXZMN2451.1COUWNF5WK3MA@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Benjamin Gray"
 <bgray@linux.ibm.com>
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
 <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
In-Reply-To: <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=npiggin@gmail.com; helo=mail-vs1-xe35.google.com
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

On Tue Mar 12, 2024 at 6:05 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/3/24 19:51, Nicholas Piggin wrote:
> > From: Benjamin Gray <bgray@linux.ibm.com>
> >=20
> > Add POWER10 pa-features entry.
> >=20
> > Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
> > advertised. Each DEXCR aspect is allocated a bit in the device tree,
> > using the 68--71 byte range (inclusive). The functionality of the
> > [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
> > bit 0 (BE).
> >=20
> > Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> > [npiggin: reword title and changelog, adjust a few bits]
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 247f920f07..128bfe11a8 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState=
 *spapr,
> >           /* 60: NM atomic, 62: RNG */
> >           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> >       };
> > +    /* 3.1 removes SAO, HTM support */
> > +    uint8_t pa_features_31[] =3D { 74, 0,
>
> Nitpicking because pre-existing, all these arrays could be static const.

That's true. I was looking for a nicer way to do it, probably generate
the bits with macros and share between spapr and pnv. This is just a
quick dumb approach to getting the missing bits in for now.

Thanks,
Nick

