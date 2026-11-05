Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEB606B06E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWCtvuJW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3an-0002UH-NR; Thu, 05 Nov 2026 14:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3aY-0002SZ-MZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:57:35 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3aU-0003YD-58
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:57:34 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso3452785a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793908648; cv=none;
 d=google.com; s=arc-20260327;
 b=UfbrYQoSfEx0zcRSfRSAEwp9iTLFXlBcQM6L5wOYxSN8TOJljS2Fak/y10/nmCTyqH
 REnVUBETyKeHo9FJUJ2n4NjE0ZXQhoKm/8+Z8Nf0X23RYzyzfMsQGWnbtN6leMGMWg89
 OrvB3SasdUyeq9qxiAdgUSe049DVyvaunRzhesTAYFdkIaRuYQymtBaTCwb4cmrdHAS/
 TEi40/a9hLLfbdAUPz3HLaV9eILeNoGJtUB6yhyxn2S2L+ODTkewpuuwCO2eLK+uPHG6
 93i/fkb1JO+3dXpaUkU2DoUBlb+x2pYpppQN/pY7P8i5rDPnODUdMVEoVvlt0PMKtJGT
 s0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cOTFJKPTMLwVXkQjkh4mz6shUhsMkSn42+JP5o/VDoU=;
 fh=N5r7iwXxDXk95AKwdQD/HVS6rZgWa4uUlDaCF7ukMyM=;
 b=P90X3lFIwZX+lPbpWfcEOaUvC5sAHIRCoeSvXrG51tSWjCNhB6ECu8wMBvGy5y3bXD
 dD1uk4+rMGpMi7X/L7LZ2iWkho+/fvRiewG7nw+TduIBsaAEvCP01L9yMcGPLg4BOxzz
 Abg2N5xJPAMVn4TfBe8n1GQkT5CvIGqeieKrO0KMqwwZ2DUOVBDOVEQCzNw0Ml/vh7PY
 kAp5TX2u4uz54Vpm7Y+8iQOlhgMOvR/S148uNhRtezBwGyshfaBul7YsVpXgWG6x+6P+
 gjLOj+1m8G++Qg/Bh/I8xnabH23TDRbvPITWAdvtOyYMCm7swgHRpMew2PMCfzsPG/Lb
 YsLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908648; x=1794513448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cOTFJKPTMLwVXkQjkh4mz6shUhsMkSn42+JP5o/VDoU=;
 b=fWCtvuJWDc5MPSCRp92I+SwdvIhdjoyrYCOZtNFAYKcuW2eDE5PkbqGuB1G/hpxYzs
 LLG97lCjHR+yx6z10G+BEgCYCJpCxHGJ9CqwrChoWOIx5P5u5J/Xf/VCy+l3sdkJBiXi
 3MMv2i9YaydhtAIFdRd4/WzFnK6LcBWLJsKrOrKxYgWa+M1lBClJ4wkLDZwAqo8F90+i
 trFndch8Wd/TrEJIuDuaXaLhwLCykFHOq5ceZB56RW9vQMmSBphK9Qi8jP08K9zIv83W
 UbU7XS/uirEBoyPyV1Xj1ddfqm8y4f6Ef3GiltVRexJaLKw7drZHhctQ6BBg6VDfFh3N
 cg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908648; x=1794513448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cOTFJKPTMLwVXkQjkh4mz6shUhsMkSn42+JP5o/VDoU=;
 b=Zue6ttnAK9YYVWZCfU4HVfg7Xo+V8Bo5ZVmA/lPqLnrb+UdW5jFWx4TaTR4lomINCq
 +ITW2nVIHnnSAUBw9qnL8gax/VpsIIEa68aW8kMH91C0iP++uW70P2MB+x3PICjsgC9f
 HIsVMJLC33S1nV6z66IMfKWJxRifXYksOklC5PHM+1IBPbKZE3hm5BHu+z6OmcMrXGg5
 kVEZ3EiMuU9ixxMXBTESj757cxMxzKPPd8M/vDMUf6fnrUdLF9XfCajg5ut23vb6XCyY
 0ktQhUTQNeNCB2m9jbydhtgQRm9yaqJBUyZ/lKWT7o7IfvF57RlSWNY6xuGQq245y/5G
 LFDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMF2WDYjnelmlXoLCqsx1z8fYaIRQPBHRiXfcMDyw3G1Wiam+cqoB0I8BZjJn5NJGNjdX65N0U8Nz6@nongnu.org
X-Gm-Message-State: APuU4Z/P1cd4202WjjGPgP/VIaHs9shPztS73fkdoueyhkeF4Bc1UESy
 CT72rSSTfPIPyEwtkSXXvAJw/UYy9ki3QY93JSDKHK2EJJ6ZjY+h19ncO4gs6AyAwzGxAGOqgud
 eYn+UmOyUvH1k1HbL6ZvyiRA2mr0u4dw=
X-Gm-Gg: AYBFou0pARWJwJ1bctMsrtbrB2XQa65jFQ0lNIqtRN6iStA7jkE1i6K+5IF4kcmLVjz
 l3Rq5ZMmV+1ZgSQqb7W7pKgLEAFJI4qssrO1n8pZu70UkK6I3tI3iLb9TJf0SbdqCxSId/sDAdA
 zAp5NhtnPbB/UCHcu377sq6MXVwlNtJgul90Muk5v+ptIXQUnV1NDQIoybyRdfx6lyaa6swKzmc
 bckA4Tc0Vl3Pau8L0NYDi7jSN1tiKUBa0RukIh9Y74MHv2eZPJ+U7H/pE17zZTSgNHtGmExH6WL
 OtHqOND3+4H6GrDvxNs3BdyoP+HIWWFz+THjHByP0IpvhzInqBww1DoFgKxVYKaLnz0ryxIlVtf
 IuuminF/t+MPHd2BhHGiEq0wYPqnluxABSJQnPg==
X-Received: by 2002:a05:6402:546:b0:6b5:6193:28c4 with SMTP id
 4fb4d7f45d1cf-6b5977f38e8mr173116a12.17.1793908648383; Thu, 05 Nov 2026
 11:57:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103133500.2295582-1-pbonzini@redhat.com>
 <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
 <5de7e4a0-70dc-4a0a-936d-d66b1eefcc09@oss.qualcomm.com>
In-Reply-To: <5de7e4a0-70dc-4a0a-936d-d66b1eefcc09@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 6 Nov 2026 03:57:14 +0800
X-Gm-Features: AclHuK_6YUtUNdGKabgb7n1ABZr8XH2ckBC15SX2Z4HXeu5OsqewDrybUA0EI50
Message-ID: <CAE2XoE-o_K=npvHPPb+pxeS=hFwEYJh-PYEVGrcbeF4nAW+ULg@mail.gmail.com>
Subject: Re: [PULL v2 00/10] i386, AGENTS.md,
 meson changes for QEMU 11.2 soft freeze
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 3:53=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/5/2026 2:27 AM, Peter Maydell wrote:
> > On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be8b=
e4386:
> >>
> >>   Merge tag 'pull-target-arm-20261102-1' of https://gitlab.com/pm215/q=
emu into staging (2026-11-02 20:19:27 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >>
> >> for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1ea5=
8:
> >>
> >>   meson: rewrite scripts/qemu-version.sh directly in meson.build (2026=
-11-03 14:31:24 +0100)
> >>
> >> ----------------------------------------------------------------
> >> * target/i386/tcg: bugfixes and cleanups
> >> * AGENTS.md: add final instructions
> >> * meson: rewrite scripts/qemu-version.sh directly in meson.build
> >>
> >> ----------------------------------------------------------------
> >
> > The qemu-version.h changes here seem to have broken incremental builds:
> >
> > In file included from ../../monitor/qmp-cmds-control.c:28:
> > /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> > qemu-version.h: No such file or directory
> >    11 | #include "qemu-version.h"
> >       |          ^~~~~~~~~~~~~~~~
> > compilation terminated.
> >
> > This happens even though the incremental rebuild decided it had
> > to re-run configure.
> >
> > Blowing away the build tree and doing a complete rebuild avoids the
> > error, but it would be nice for incremental builds to work.
> >
>
> It works fine on my side, with both ninja and make. qemu-version.h is
> correctly regenerated as the first target being executed.
>
> Can you reproduce this with a clean build folder?

Hi, it's for incremental builds, that is a build (exists) before these patc=
hes,
then reset hard to the version after this PR, then ninja will fail.
Clean build folder won't trigger issue. but for fast bisect, issues will ha=
ppen.


>
> > thanks
> > -- PMM
> >
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

