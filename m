Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E00C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEu3-0004Dh-Ba; Fri, 12 Apr 2024 07:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvEtp-0004AI-Fc
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:16:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvEtn-0007EI-MX
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:16:53 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so760391a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712920608; x=1713525408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jqSbrxyi5xSCUnUddcbVQoWDnwGwMym4KBlHA4R8Qk=;
 b=Nwydtu5IIP5KPJPMB2IzoY8cv4fxHSOanT1Y+5QsroYwxG85DDWCy4E+gXmg0+omLm
 e0R/pwRtqttzsQpSumJi7Zx8cBipI28v/E1ihBjbSqstp5KtOHOI94T+hern8qeCjwMx
 R7H2x+zD4qc/7uql7uffCA9amA3NmmokkwscqqQ2EMuZyCa1s52FtQpdIQUYNOxHQFE/
 IDgGI+8dJuCbzwiZgUYOt/lNRJJ/TCG1d7hYvVDY7FoK3mG40n+oR5+1lZyNE8DKnqfz
 2I+uRuPGIa4psz2hAWVY7+wMvvPmEE4c49x8mgPelGYjcKLWZ6bsxnSfeuVfiuBw3SY7
 KGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712920608; x=1713525408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jqSbrxyi5xSCUnUddcbVQoWDnwGwMym4KBlHA4R8Qk=;
 b=f3Y6JUrssL36AgKvYpYNz7/b+u3AdrGFcdVN2Ly/UsB0GfrEDs04aAs4eP4+ulquGy
 aNSRc895vR5+TGU8IbED+IP/3vErgkAvwysyOqTaAV8UrwWZEapXPmAdG06JlDAFJgnG
 lxHCqPfivsnVFRNbBXRVhljB7XfcJoqWZl6hdViAd6e5ooNW1s5vb1l1alttJtY4QxEc
 pK/Gl+G3q6WCQXeTGh+wldPnt3LShRqueZOEH0Dow91njzm5bzZlXUD5dM9YvTKmmNfP
 /98g26ruEQLhr/bPkmzxtQiJRy9P3+sy2hvdMK+uOeTJ+Z62TS4VZ0sf8kFOSYqUsBfE
 Bifg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE0UQXbQJQj0nMOx30vXBFWOB9eFrQRKd+iNGYu2+EGtuZ6RogZraqE/IudKvFmf2DCUF6x403HL/p31d7NEtxWy8L51A=
X-Gm-Message-State: AOJu0YzUcv1eldb3H9cIat4wt955Q1NrxNmMHa4/aQyd9mYnikcH5X1N
 LlGaxtmfEtSmDHPcyRtk/B7vs+XI3bDdPuMQ3NOb3ouTuDRs8ucJkXE6t2lCc4K47KY92H34bBn
 EmVEklxd9iCd6muqkmmcm47+WqfwVHbuoV6hGHA==
X-Google-Smtp-Source: AGHT+IHUmT7JAI2k4DaLb54JQQQB8CMKRHyRXR/6bNAHUX9AKjpV2sIcamOP6QZtrPSbcGVreinGadVRr+eRpHDtPCs=
X-Received: by 2002:a50:f60c:0:b0:56e:23a1:a0da with SMTP id
 c12-20020a50f60c000000b0056e23a1a0damr1672479edn.7.1712920608502; Fri, 12 Apr
 2024 04:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240412100401.20047-1-pbonzini@redhat.com>
 <0eb8a3b5-cff2-4ce8-8e6d-ab4dc2dda84a@linaro.org>
In-Reply-To: <0eb8a3b5-cff2-4ce8-8e6d-ab4dc2dda84a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 12:16:37 +0100
Message-ID: <CAFEAcA-nZ6hEnSy-Xdt8ovmhs3mQ_5dKTTqZsZVvUNp-8XW3Hw@mail.gmail.com>
Subject: Re: [PULL 0/2] Final build system fixes for 9.0
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 12 Apr 2024 at 12:07, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 12/4/24 12:03, Paolo Bonzini wrote:
> > The following changes since commit 02e16ab9f4f19c4bdd17c51952d70e2ded74=
c6bf:
> >
> >    Update version for v9.0.0-rc3 release (2024-04-10 18:05:18 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 2d6d995709482cc8b6a76dbb5334a28001a14a9a=
:
> >
> >    meson.build: Disable -fzero-call-used-regs on OpenBSD (2024-04-12 12=
:02:12 +0200)
> >
> > ----------------------------------------------------------------
> > build system fixes
>
> Since these 2 patches don't modify what we can build with v9.0.0-rc3,
> would it be acceptable to merge them without having to produce a
> v9.0.0-rc4 tag before the final release?

As a principle, I don't ever do a final release that doesn't
match the last rc tag. If the changes are minimal I might
reduce the time between last-rc and final release.

But we'll see if anything else turns up that needs to go
into 9.0. There was so much late stuff for rc3 that I
have a feeling this might not be the only 9.0 pullreq.

thanks
-- PMM

