Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EBAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 21:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scB34-0007xC-Um; Thu, 08 Aug 2024 17:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1scB33-0007wf-OH
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:51:53 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1scB32-000428-0Y
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:51:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 285DF615C7;
 Thu,  8 Aug 2024 21:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB63C32782;
 Thu,  8 Aug 2024 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723153909;
 bh=3TwS60iIKkqYIWLXbVPdeRGu64tLBLQpiHvY1xMb4xY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rShFr4c0XMySRfus8TDmx/uyPwFwu03rtMybAa2GpZNuFDoEuG9ReBBVD1zfRIbkB
 nAMHbWdw5aHi+zKcy0/oMgYtuNDVZQ/1XyoxtvsJXBcBl0UlmmZGgGBPiQpcKlR6Ty
 /wlgTuyPW7z3+FxK/+87xlWeBQjeviO/UIf/GRtJAfT/DnasoKgfR7hPhtJNBnlPJ0
 ndUd2OoTdUu0O+3xXeLjN6hXk1A2Cxvgvb2cpd675HA3Gd9zId1GlPMGqE/MmhJn3H
 VPrq3uGiwcmhu3unWTHLMEjproGLYgb1rz3r5NPV9U/78nkR1nDDlhwTPoYMZMaUwZ
 241d+m3L/r39w==
Date: Thu, 8 Aug 2024 23:51:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240808235144.726ab8e4@foz.lan>
In-Reply-To: <CAFn=p-bM3oECXtPt5zVZSh53dJx+TDciU_N+vCW4Xp-Jd0MaHw@mail.gmail.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
 <CAFn=p-bM3oECXtPt5zVZSh53dJx+TDciU_N+vCW4Xp-Jd0MaHw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Thu, 8 Aug 2024 16:58:38 -0400
John Snow <jsnow@redhat.com> escreveu:

> On Fri, Aug 2, 2024 at 5:44=E2=80=AFPM Mauro Carvalho Chehab <
> mchehab+huawei@kernel.org> wrote: =20
>=20

> > +#!/usr/bin/env python3
> > +#
> > +# pylint: disable=3DC0301, C0114, R0912, R0913, R0914, R0915, W0511
> > =20
>=20
> Out of curiosity, what tools are you using to delint your files=20

Primarily I use pylint, almost always with disable line(s), as those lint
tools have some warnings that sound too silly (like too many/too low=20
functions/branches/arguments...). From time to time, I review the disable
lines, to keep the code as clean as desired.

Sometimes I also use pep8 (now named as pycodestyle) and black, specially=20
when I want some autoformat hints (I manually commit the hunks that make
sense), but I prefer pylint as the primary checking tool. I'm not too
found of the black's coding style, though[1].

[1] For instance, black would do this change:

	-        g_arm.add_argument("--arm", "--arm-valid",
	-                           help=3Df"ARM valid bits: {arm_valid_bits}")
	+        g_arm.add_argument(
	+            "--arm", "--arm-valid", help=3Df"ARM valid bits: {arm_valid_b=
its}"
	+        )

IMO, the original coding style I wrote is a lot better than black's
suggestion - and it is closer to the C style I use at the Linux Kernel ;-)

> and how are
> you invoking them?

I don't play much with such tools, though. I usually just invoke them with
the python file names(s) without passing any parameters nor creating any
configuration file.

> I don't really maintain any strict regime for python files under
> qemu.git/scripts (yet), so I am mostly curious as to what regimes others
> are using currently. I don't see most QEMU contributors checking in pylint
> ignores etc directly into the files, so it caught my eye.

Having some verification sounds interesting, as it may help preventing
some hidden bugs (like re-defining a variable that it was already used
globally), if such check is not too picky and if stupid warnings can be=20
bypassed.

Regards,
Mauro


