Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A4606A325
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VfNHcQ+r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJMb-0005Ri-3H; Mon, 26 Oct 2026 07:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLJMZ-0005RH-Lg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:59:39 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLJMX-00044a-VR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:59:39 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0e21048f8so25060477b3.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 04:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793015976; cv=none;
 d=google.com; s=arc-20260327;
 b=JZWBwKXc0sIpD/16axM8TUf2O+E73oBvNUoNdUINGfgtwiLN+qEm+4bDzx0HdWgTTa
 DDy87q4EALlZeV7SjQDHO59vAm5r+fyhQ3yqq270wsPMF6nwbNrviY2T5wYjdVScq4zM
 3SlCVnH0ZWETGXT1GTdf506m8Cx2n8DXKdWanvLvRdxd7ZmE9Q8RO7TnCkJudySiTOv1
 eFIf4HzZBobhxocWcyoDgCXrzgrvDmMRw57Rhk8XdWAc7xiaIW8Z1d1kPKqhnB2GMKNT
 nXPlJd7tp6psa7QX9KUlhlN/y5UHdQu8rswJ6Cll523LnR9Uo7PrVi3si6b/m3uTQc4+
 decQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=899Dii2gSLoNjy8fOpby8R6kcqlhk0ZLuIwDdFI4jD8=;
 fh=9vbVNIdRsO0paNhZWc2/4JcInsvPbgZ5nIOMIbgIuW4=;
 b=AWBml0QjsoXJ3glK/sgZq7mNxSsnyxUrXckQwVx1AeAKBnOT7pF1Q6BHEGHCycLo7o
 zZqAgf9mMaGo7akuU9AjT7oay3CPyIh4Iow2hjKvjV7OjdjddxUy85g+GlzbIL3Z1yUk
 Y1Zp11fjJhKEDK0ZOdtpkXh75YEDOw+AvUkuPf6cruYeGDwJrYBhSGjhAz2LThJSpyv0
 ZOEAZ2N3Xv4i+3zUXeRRzemRBM0epIr59KAmR43dLLJ36bnHfhchLkCjUyL8ux+SUTVA
 qBHswHUn2PaO5TankMwWEyBbxDwn5yVSoO7YarWPvMFh4BPw/R/fLlSd7YYM4UlOhTWK
 tazA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793015976; x=1793620776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=899Dii2gSLoNjy8fOpby8R6kcqlhk0ZLuIwDdFI4jD8=;
 b=VfNHcQ+rZU6gwteBwPci0hux7T7ZA7Y72bfOmepDFPlsWz+j4c9H24ZT3SxplyelBV
 qXBBORvXznxNW24/zz1zGhqv8RgKssPnLk7kDzyo/G997WYz7YjWXwm8ImCdzeZOIVA5
 OFlqeh3Fj7XpOnRGyTL6o3Xufhc94t5tGyp+/ZidRAK5o+WFd1KeDwVm4G3EsKWSo5rd
 lhad5ESWgiBniIXlR9KDrx553/JSRA5TBZ+m9cU0gMECjkH9zMOJ/GRAvp3xuL9QYq8f
 uPfZqte5aNptwpIBG/D4cOxWTYDfFgeFW93wr72p5JdVBwl09G4Wylrq5ekABqWoYAxK
 HErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793015976; x=1793620776;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=899Dii2gSLoNjy8fOpby8R6kcqlhk0ZLuIwDdFI4jD8=;
 b=iJOGeE9Pr1Pce16srDTAXJttbuLlEophWdguGAFJSUxJ2TKK4l9LrmVRSMwH07+StE
 IWsBfNgbOvT0XlPY6e+MhTdq0NpT3W2y8DEhG0yVHOu73aYRTHa4nRdViKoOXg5PQYSO
 Lp1nOAxUgYhSui3mZ1LccB90dgqZExLcWdFbHz00Fv1lPCjEOGKGWr8QNwl6a0S8LNfD
 VO1F9qlHDBZ9pc/XELd5rwU2r9WQ9Oz8Pq14dDQuEZrWuWavqaOBjoEXC6dLDs3BGBh8
 6H30lltQbH8Zd8imUGY/QA+m7VYJryw37Bd8qo5Lqfigp/sXZelDPWToE7EZCoBXMJ3K
 wCTw==
X-Gm-Message-State: AFq9FYIhS0e3KzOnGcuvo9tRu8G6SzrjuSBttd7pd+OzCO85A4UhOb89
 wWYGhVk6t/BrlTz+QfBLegaER/fJ1CzM56sK9D2Ok2JXxeDrxNbNkELGN1OzN/XY7Xq+cMJjwCm
 MjvYp5DQ2zlDXNscVnpUooW6UatT3p1Yl/Ohv5ciIkg==
X-Gm-Gg: AYBFou0JFTwuBGgRsHR3VD96ZHDqM4sE9kd/A7I0iJbDjJFi8yAtlUSPvGIuU9xsMQg
 /xNr4Vzr9/z+GKaHqN8CE5zmCdUQxEN0pwzLzF7esBD32xASWLAw4JKQ2Zu39Fkt6CvxuHce9LC
 6G+OWsYYCd/TtcW46Ka5JsmwRiKBA04n5kK9UNtruFdGP5Zd7QepSVm2pPwBhIhTryrYNYnD0j6
 j7TI14ru0qgSd1lVNfDinGWLQuhjXoob699UrsTONxJeS5WDk5ZTAyAomLrOrw1Lo0tUNbBy8tc
 wkkceaI3knBrdXttFIpntQ1DJGuqSfG2I+TyN+QeSbtx7A0HprIPZfW1l2ot/aD5qV1s+npUzm6
 htXuTe+s8V6QXmTxcQpaGJKchsJ9T+PtjXBS9EGGpmBIm+FwRyszS6z9lD1mEWujOH4yUdfuey+
 KnPO2qyjFNBi1TcoyK1pN+
X-Received: by 2002:a05:690c:45c5:b0:8ab:4a67:71b9 with SMTP id
 00721157ae682-8b166c442femr54428217b3.29.1793015976296; Mon, 26 Oct 2026
 04:59:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
 <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 11:59:23 +0000
X-Gm-Features: AclHuK96NYsbOwrJ_CwKJkxVnXzBkRPE56daCWYEA1F3VH1nRe1rxjVL4lJEKdQ
Message-ID: <CAFEAcA_BNjFC4vEJ2h62NytzYQXKE0o4MvB2jpN74S05kHRLMg@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 11:26, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote=
:
> I investigated why the secondaries don't start with MPIDR_EL1.MT clear.
> The final DT passed to Linux has cpu@0 ... cpu@500 with reg =3D 0x000 ...=
 0x500, matching the mp-affinity values of the QEMU CPU objects. So, this i=
s not a DT-versus-QEMU affinity mismatch.
>
> The MT dependence is in OP-TEE. The i.MX95 build uses the generic get_cor=
e_pos_mpidr() in https://github.com/OP-TEE/optee_os/blob/master/core/arch/a=
rm/kernel/misc_a64.S-.  So,
>
> With MT set, OP-TEE reads Aff1 as the core and Aff2 as the cluster.
> With MT clear, it assumes the core is in Aff0 and shifts everything up on=
e level, so Aff1 is read as the cluster.
>
> With MT clear - OP-TEE gets the wrong core position for CPU2 (example - 8=
 instead of 2), loads an empty page table, and faults forever when it enabl=
es the MMU.
>
> This is OP-TEE's generic implementation rather than i.MX-specific code. T=
he implementation is appropriate for the conventional layouts it
> supports:
>
>   MT=3D0: Aff0=3Dcore, Aff1=3Dcluster
>   MT=3D1: Aff0=3Dthread, Aff1=3Dcore, Aff2=3Dcluster
>
> Therefore, I think the problem is not limited specifically to i.MX95. Ano=
ther platform could encounter the same issue if QEMU presents a core ID in =
Aff1 with Aff0 fixed at zero while leaving MT clear, and the guest uses the=
 generic OP-TEE core-position implementation.

But shouldn't QEMU's Aff0/Aff1 be the MT=3D0 arrangement? That's
how arm_build_mp_affinity() sets them up, for instance.

Is your SoC model specifically overriding the default values
to something else via the mp-affinity QOM property?

thanks
-- PMM

