Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596C9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3DY-0001rF-9G; Tue, 12 Mar 2024 10:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk3DW-0001lZ-CI; Tue, 12 Mar 2024 10:34:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk3DT-0006w7-8i; Tue, 12 Mar 2024 10:34:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so16180b3a.1; 
 Tue, 12 Mar 2024 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710254093; x=1710858893; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etAG06ZPmlDB4lRPJUkmDhc4BVIz8mW8ThuFfuOP6Ug=;
 b=GnP7hzlbklkRsgji0x0ytjALUu9VdxEuIswpjxvA+J0TN+trgdiIGNZGKxtrOL0dOE
 d488TCuZldoZ/WYWx29TbF/UXORKukLc+HWY0eWSwbEoRbkoXAJEvB64I/xcmOZp9FiZ
 H0rC6utacFpWeDtPLlQL+a/yaQ48C7thOFTz/qy3Xmguu2b8ERc+jHGrsskcHxEuM5NV
 Q9VbSanHpbleG6FL+YIHo2X+x6ohxUAKOdZTKMRweI4CH8l7OAdjE3ytSGITcrJjrZYF
 HbezQG/P4Xk0jTYJIAIAuCO8fmBkTrpZ72VZ+15v/uUwkdEaRTWBiMEnUqgc8xKWwJ0x
 7sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254093; x=1710858893;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=etAG06ZPmlDB4lRPJUkmDhc4BVIz8mW8ThuFfuOP6Ug=;
 b=jTOwuuOXFKIr2tRmU440RVGfc6ztrtMQ4jMNY4TffpozTPG9TbqsQaHyqx8HaehnY4
 rxxigb6W4dsm12iCmIHqewImEEyMJS6ygmV2TPr5AUfvUcA8WdnQ20zJ8IHhlDenRA6F
 KT6u322a4x3qH2WS4FLMN4NL0bXAbBCkYgohdA2Fp9OA7/TYEAbQLhWmkvNmm0hiqbFQ
 OnjEZBgJB2djCNYI0zjUyQd6DxrMyTAy9JrCu1Pl/XvpuCVmO+cpzSvjrJAss0zr4nEW
 H+es82WHiG59BN8ene/nSNO7N17eMwYFiy/dT+0Z45wwywYyG7aAjmH4/kQIklu5EpL9
 GokA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpolK/kVIp9bdAEWdn5H5BPI0RTxJIrAUAV6jlaytmriU9JOh533o+i4bMDm5nRDM79HT4guaTYPkT1mjHt7J9W8FIbKaZUfV8GVhsWVypkvHzSI35aZZyyhQ=
X-Gm-Message-State: AOJu0YxLJJWucg3hbsAxSL9TBLC+IbjhOy4TaFsW/3dAZK2FTUqajooU
 N2B0u+mLFq2/y9JF5MZZ5Tq/BHolshvQtZ7WG2yewmkbCmdNnjXf
X-Google-Smtp-Source: AGHT+IE0bjZuD08A5k37kxWIZFSe3vrBt9psIAMGzWck8ErYarWjEY7mG/gvuoaF6tC13mLGGHLleQ==
X-Received: by 2002:a05:6a00:1309:b0:6e6:6e12:493f with SMTP id
 j9-20020a056a00130900b006e66e12493fmr12200315pfu.2.1710254093175; 
 Tue, 12 Mar 2024 07:34:53 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 a24-20020a62e218000000b006e6755f0f6bsm6361472pfi.172.2024.03.12.07.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 07:34:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 00:34:47 +1000
Message-Id: <CZRUH5CRDRDU.3NS44E5KB0SSY@wheely>
Subject: Re: [PATCH v3] docs/system/ppc: Document running Linux on AmigaNG
 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Bernhard Beschow"
 <shentey@gmail.com>, "BALATON Zoltan" <balaton@eik.bme.hu>,
 <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
X-Mailer: aerc 0.15.2
References: <20240220232200.042DA4E6005@zero.eik.bme.hu>
 <c9dc84be-c7bf-c676-491b-2c6b1164d502@eik.bme.hu>
 <a9814b1b-98d7-29d8-36f9-228f20206917@eik.bme.hu>
 <3E4E29CA-AE91-4C8D-BB51-B3759CF3110F@gmail.com>
 <CZRPETJSO62V.5YV22F323JKC@wheely>
In-Reply-To: <CZRPETJSO62V.5YV22F323JKC@wheely>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

On Tue Mar 12, 2024 at 8:36 PM AEST, Nicholas Piggin wrote:
> On Tue Mar 12, 2024 at 7:28 PM AEST, Bernhard Beschow wrote:
> >
> >
> > Am 9. M=C3=A4rz 2024 11:34:56 UTC schrieb BALATON Zoltan <balaton@eik.b=
me.hu>:
> > >On Thu, 29 Feb 2024, BALATON Zoltan wrote:
> > >> On Wed, 21 Feb 2024, BALATON Zoltan wrote:
> > >>> Documentation on how to run Linux on the amigaone, pegasos2 and
> > >>> sam460ex machines is currently buried in the depths of the qemu-dev=
el
> > >>> mailing list and in the source code. Let's collect the information =
in
> > >>> the QEMU handbook for a one stop solution.
> > >>=20
> > >> Ping? (Just so it's not missed from next pull.)
> > >
> > >Ping for freeze.
> >
> > Has this patch been tagged yet? It would really be a pity if it didn't =
make it into 9.0.
>
> Will send out a PR today and I'll include it.
>
> >
> > FWIW:
> >
> > Reviewed-by: Bernhard Beschow <shentey@gmail.com>
>
> Thanks, always helpful.

Oh you are Co-author. Sorry, took some time for light bulb
to turn on... In that case it needs your SOB to merge.

I will have to leave it out of the PR if I don't get that in
time, but we should be able to get a doc improvement past
the soft freeze. It's essentially a usability bug-fix.

Thanks,
Nick

>
> Thanks,
> Nick
>
> >
> > >
> > >> Regards,
> > >> BALATON Zoltan
> > >>=20
> > >>> Co-authored-by: Bernhard Beschow <shentey@gmail.com>
> > >>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > >>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> > >>> Tested-by: Bernhard Beschow <shentey@gmail.com>

[...]


