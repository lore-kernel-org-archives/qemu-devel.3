Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36CEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 04:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rju6X-000423-Ok; Tue, 12 Mar 2024 00:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rju6V-00041h-VY; Tue, 12 Mar 2024 00:51:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rju6T-00071t-Ht; Tue, 12 Mar 2024 00:51:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6381df003so4436249b3a.0; 
 Mon, 11 Mar 2024 21:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710219063; x=1710823863; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv/BIKWdUlZNjkCMkKQZP50qURnDYVYHlxOgQJon8Es=;
 b=UU/7KKCxPR9jRbR1X8fV2nlOB7XJNQ+8rKhDy0RvEivfWhM6/WwlxF5YBkyxZX6GjM
 eSOFyY0Na5LUNEVII/P0ZiLu7qHbvpJUW6qUqM9z2f4/tFQD2oO1BCWMi01SBpenrWWc
 zQQFn1z18UGYrsefm+DibDCV3rF3ENLphqF35Vw6Lid/Zx2mBnCejLL3yOXP4aGghbwV
 Q0TYUJewoZlvteBY44FSIg+s+mPyXtmdINp7r8yzKM4Wlr1WCQtmeJFUA3ulrhXTxTZ4
 b32wcpwac5Ie8UrZ/mp0RNiCoAUg7ZlXfx+/yfEOaiU6BRM+YK7Jf3+lP4J2+f1Tb01v
 nbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710219063; x=1710823863;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tv/BIKWdUlZNjkCMkKQZP50qURnDYVYHlxOgQJon8Es=;
 b=YVT6PtoboIexjkM/RuGVpDA7kkf4ux4P6W2iQ6+YWXoKT6xQvJy4RYwdjmArPKeISj
 kOXNe65CiKGLXQAlSUhYSuwo7qX/oDY/4/T6w6ZZDVx7qfV4k2BMDDUAVRbrMuGeurhZ
 pt46wMKvDaISztxueQP3OC8z5tCCQcqGW5MTNTyqEGN0RfAbduPDfdtgY6SSSMFS5con
 VbJwbLOV58Qpw8GDqSS7/Iun70JNDFno1qgMjKwsgip5Evm27pvB76mrDKH0JD/m/YPj
 3kEzz9xDPBqYlNFCEGXCRxT1NPwe7WyryykZtXWaW7cQS/TqWTZcwuLrMuymlX348bKc
 gN5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0WI6x73Ul4cvrjea+tlA+whbrBKdb+ehE73F5p4IwUhlzRFuuLsqt0XiyI9g+y0lrcjop5F8EeFrEFOoxOm5qHNNaLMc=
X-Gm-Message-State: AOJu0Yxu0wtTc2vVNUdao7PNLGOVwx3yXvjDnkojI3RtvUPCXQUZf0sT
 zssUViFb0AEBWH7MiQS6CD+OO7EzhwC6mssSdyI1VeXuLLO+iCDv
X-Google-Smtp-Source: AGHT+IEsCSU+I76yNtWdLYOZq3NCA4pp9TKMEsMlbmBk6/q5gfrOWHzKOTCISzWMPPGriRe+1M6D3w==
X-Received: by 2002:a05:6a00:1951:b0:6e3:84cb:3d51 with SMTP id
 s17-20020a056a00195100b006e384cb3d51mr10793830pfk.33.1710219063578; 
 Mon, 11 Mar 2024 21:51:03 -0700 (PDT)
Received: from localhost ([1.146.55.44]) by smtp.gmail.com with ESMTPSA id
 p39-20020a056a0026e700b006e04553a4c5sm5175359pfw.52.2024.03.11.21.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 21:51:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 14:50:56 +1000
Message-Id: <CZRI248HGG4Y.2KVSZ18AGD6CA@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Benjamin Gray" <bgray@linux.ibm.com>
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
 <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
 <ef4c48d1-9e11-d6af-d4cc-3ae6c567f098@eik.bme.hu>
In-Reply-To: <ef4c48d1-9e11-d6af-d4cc-3ae6c567f098@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Tue Mar 12, 2024 at 7:07 AM AEST, BALATON Zoltan wrote:
> On Mon, 11 Mar 2024, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 11/3/24 19:51, Nicholas Piggin wrote:
> >> From: Benjamin Gray <bgray@linux.ibm.com>
> >>=20
> >> Add POWER10 pa-features entry.
> >>=20
> >> Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
> >> advertised. Each DEXCR aspect is allocated a bit in the device tree,
> >> using the 68--71 byte range (inclusive). The functionality of the
> >> [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
> >> bit 0 (BE).
> >>=20
> >> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> >> [npiggin: reword title and changelog, adjust a few bits]
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
> >>   1 file changed, 34 insertions(+)
> >>=20
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 247f920f07..128bfe11a8 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineStat=
e=20
> >> *spapr,
> >>           /* 60: NM atomic, 62: RNG */
> >>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> >>       };
> >> +    /* 3.1 removes SAO, HTM support */
> >> +    uint8_t pa_features_31[] =3D { 74, 0,
> >
> > Nitpicking because pre-existing, all these arrays could be static const=
.
>
> If we are at it then maybe also s/0x00/   0/ because having a stream of=
=20
> 0x80 and 0x00 is not the most readable.

Eh, it's more readable because it aligns colums. But probably better
more readable and  less error prone would be like -

    PA_FEATURE_SET(pa_features_31,  6, 0); /* DS207 */
    PA_FEATURE_SET(pa_features_31, 18, 0); /* Vector scalar */

I just didn't quite find something I like yet. I won't change style
before adding the missing bits either way, but certainly would be
good to clean it up after.

Thanks,
Nick

