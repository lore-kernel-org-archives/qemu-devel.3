Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DFFCCD184
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 00:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v86Qj-0007hV-GP; Sun, 12 Oct 2025 20:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1v86Qg-0007hH-ID; Sun, 12 Oct 2025 20:28:47 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1v86Qe-00049k-0m; Sun, 12 Oct 2025 20:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1760315313;
 bh=zGeAhcRW40aSuvVnnsh5lqh1vqQmmRJ1NljvnSRXkv8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=gO+85y9bF4ICf74lDmjCIX28xyBNYuY/bx2WqB5hKEirUkKXctBAYZHgvnb6RwiTA
 gfsHwn2zsTLa5weuW2RGvtWVM0LhZEHP2f0M+S9PZuA0RO0hZIVBGEMiQvciW0F9+J
 dVdQ2eczvqUxAIKiaSdPhbrVSq/GS6akZjqt/G26IGsbprHjAktiWqHNHlfOOU+QaA
 XDuNHFK7d8vESm4mobbVMEZX0m60pHKX8vNOIG8bBtWFzgSyHe7KrxSyoIIxzFp+o4
 PwYy3AFeKiPliSMmfKAFnBebUO3S9dDcKlK/YeEONDftN81W90Z+dZ7qr4mzNLHs1c
 /Lu/3KMgSHelA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E81E372F2E;
 Mon, 13 Oct 2025 08:28:31 +0800 (AWST)
Message-ID: <cba74db296764fd7762a18e75d76b5acb053ec4d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits
 basis
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Coco Li <lixiaoyan@google.com>
Cc: clg@kaod.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 flwu@google.com,  Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 10:58:30 +1030
In-Reply-To: <CADjXwjguvA6tsAjc65Fc=6S+k=pz1xry6Gd=mz6093GozuWDDQ@mail.gmail.com>
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-2-lixiaoyan@google.com>
 <b601f750adc19ea0fe8ec8f2c578f9f23d7259cc.camel@codeconstruct.com.au>
 <CADjXwjguvA6tsAjc65Fc=6S+k=pz1xry6Gd=mz6093GozuWDDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2025-10-03 at 10:44 -0700, Coco Li wrote:
> On Wed, Oct 1, 2025 at 4:24=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Thu, 2025-09-25 at 00:58 +0000, Coco Li wrote:
> > > From: Felix Wu <flwu@google.com>
> > >=20
> > > Added 32 bits property for ASPEED GPIO. Previously it can only be acc=
ess in bitwise manner.
> > >=20
> > > This change gives ASPEED similar behavior as Nuvoton.
> >=20
> > I don't think this has adequately addressed my request on the prior
> > series:
> >=20
> > https://lore.kernel.org/all/e244fdb5d2d889674a583df8f8b9bc4bf8d476f4.ca=
mel@codeconstruct.com.au/
> >=20
> > Can you please improve the commit message?
> >=20
> > I don't have any particular concern with the implementation, other than
> > understanding whether it's something that's reasonable to add to begin
> > with. The "sets" and their indexes are somewhat an implementation
> > detail. Exposing them might preclude a different implementation design,
> > though I'm also not sure why we'd change at this point.
> >=20
> > Andrew
> >=20
>=20
> Hello Andrew,
>=20
> To confirm that I understand your request, I should do the following:
>=20
> 1) remove the reference to Nuvoton behavior in the ASPEED patches
> (will do in follow up)
> 2) you asked for discussion of complex simulations, is the addition in
> the cover patch sufficient? Otherwise, could you elaborate on your
> comment here on what I can help provide please?

Can you please integrate the description from the cover letter into the
commit message? It's not always the case that the series cover letter
is tracked in the git history.

Andrew

