Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E715606BFE2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CjOH6b2I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5fS-0006or-3F; Thu, 19 Nov 2026 12:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5fN-0006oI-PP
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:11:23 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5fJ-0004bQ-Ps
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:11:20 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67db89857abso93178d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795108275; cv=none;
 d=google.com; s=arc-20260327;
 b=I7qNPQrZjBVc71pD9J85QePmuf+RadDstdn/mmsyIcMKNE6FOHyHECWTr7VTAsDLOw
 8I5Q9JtXO22udjuBtSOoCSkOReIdztElpcVg1++Ig6+nHjHWli9kvdJgo2VZNg+C+QFS
 HX1XP+FG+h0HbuYo0umuELdddTuPnadxFayaY6n7hsGqx3/Nrz+m1foy2PmpgA393IqY
 99stAeoZG1ohXglgqcDI9hObsvqLGKeF5WTm7AtZ46GuQAj2gtc30INQvv0HAa/m6OJH
 8W+7Dl1R/uMVXcc5vCEXZkZjN94ObmhBVQMBGU9xZliWX12GqEo3N/c/JLfRpvI1RQVc
 hzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sDLycmFM10VSeCwpRcCL/BHbk3esIzsonr7meP81oXE=;
 fh=50UGgAayIjtP2PiK8RuDiObpde6aaY5fvXjAwhTX27w=;
 b=lCgcrCNRxfhC2aO887Exhu21POmm1I/J3wGHgO+hqDhY7GmG+96PhHkIyeV/KN4Z0o
 9XEKWdBHQLeSr7qQVoGq9vZiuLImq8gC4hKZry16ebQzOr/yIVwACoF4s1uNu7UIdLlw
 etYtffgpIpJNN5BKd6pj1A2pE6AJ1oWrSuAMb04tVk0i1hb/SG7DtUPQBKQaDrmpSPhZ
 a0dwApAY/Y1gJhM1mnwrwoD5ixxX251rEAhjWswcag0R6KsSVz5lMG4rG6tV2tnCwBYw
 DyVCuuX/j8BAZk5upn67EqOZOmMccHHuR+ZgJne6Nm9B1P206oKrUrBNU8uVTEZjGO92
 muRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795108275; x=1795713075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sDLycmFM10VSeCwpRcCL/BHbk3esIzsonr7meP81oXE=;
 b=CjOH6b2Ib6vfxZilYs115+C3GddhfE05pWlMdThc78jueM5Vi3Ka55ESP9PJaSepdA
 FuK+vTbdTTKpIQ+hE40GOdfyRIdTbCMQLqJy8Ix7v1kws7HNSdRrnZreo45bvzWkgqZm
 SvLJt2peuX7wUwkYNAzfUtfmSE0v5byEUwEtS+44aYiL2+ps7TEKpXL3REPHgUYxUhWO
 Hom97PLpKfDwUWpSaTlr8mCIyhyqug1tiGZF9uM+VTQs6BNg8VTpcgDopzqb/DWYD70/
 S6zSfPse/isCHVHFwyLxx0s81l5os4kpc0ykVJ/ifNQhJ2pFiAj7Y+86yUcd2gDa6qKj
 g3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108275; x=1795713075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sDLycmFM10VSeCwpRcCL/BHbk3esIzsonr7meP81oXE=;
 b=gXmhLC4+daA/yVnONLrVUMGU6RzaYqiwfdS9fuR2jlv25UjI7ScrKRST6+VD+/kCYX
 zaTbiI+Ajxe5Ypp2zVzjni/b8FwkVOotLSIV3H93O1IKO3QBv6MYija+Qun4TR/yqOvy
 YcanvSa/TIuEOSDAd8Wn73dVQ7Ey/fU+JujCf29IZVIvpxuasP94Hq047WbSdHmOn0Ny
 +3x2IUWSUi5HXieqMlsOt302sklhib36fQBRx9Gscs5pV2d5i0GcMG08f1xKlzoRKuLR
 7BXo9vex2AfkOOQe8XWCLwk6OTo6FJ8/N/rpbmdxJ1p+vgqj8seFgYhzbuX5nkayxS1M
 SM4w==
X-Gm-Message-State: APuU4Z/DZAc54yb5pAszHMHukJmbxRkyYfvFU3QE6XA0FRr4ZR6T95QQ
 Jp36lSRQg6TjjPgYeT4iyWMA6Rkrlnw+lGXbve3/rrMTkMfXjm/EwYecoyD0AMPZM78MpTrQZQO
 6WGJ6Hlll5V3YqbOWTuJHktIZO+2ktmvy3mrYG9/fZg==
X-Gm-Gg: AZFdTZdnJwp7BcKCoYPvRjxPszloYncovRdQFw+egRQZ50nVverlGRjA41rtOxjvRUr
 EyzxdQg5GFvPq3m0/W+XEJI18oucVI5g42Co3IIvMVuy8w65OKVFugj3BmL+L01Gm/UmRsuScS0
 ++mPf58VBrr5WEN7y8118s9YlAp7dJ4rR/99/BVvVWzyxLN5q+IK0B9e7vw7eKjsFeiqF4B+Wwh
 4zh5WaJyYAWR2NmSRqTJEuEaFeKO1LBieQosAcN2pQ2mw3TQv2MZs7LlHLVr+3nJ1/E97c/zePV
 jde0X0ZITCbT5Q5ofD+jcJJ6Mf8H1vKVnwEWbhifKVZNi23xs+VZ89tgcLyX80TqTyLeHhoTnWl
 v+2jLwRHf4za/OH0z0noPO23koDxPC4eKSrCMfAd3e3icA/Dqwdvstz9zTMYV1TJs1Tef5VywCf
 SpDxRrTsuacRbGvm0DAImecw==
X-Received: by 2002:a53:d005:0:b0:67c:8ea:be19 with SMTP id
 956f58d0204a3-67df44c20c3mr35681d50.104.1795108275291; Thu, 19 Nov 2026
 09:11:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165716.130978-1-frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20261119165716.130978-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 17:11:02 +0000
X-Gm-Features: AclHuK-REbMp--VetPzEmoMK1BmQphHK9BF0kgPDPnwxqTrmzqVn_nSAMP45k-k
Message-ID: <CAFEAcA9FnuWKkHmV4dxv2Nnp=MehSXijKPcB=cc5czB-3XgoXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] target/riscv: Correct undefined behaviors in
 x-rv128
To: frederic.petrot@univ-grenoble-alpes.fr
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 16:57, <frederic.petrot@univ-grenoble-alpes.fr> wrot=
e:
>
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>
> Peter reported undefined behaviors in x-rv128 pmp configuration
> registers accesses detected by the clang sanitizer.
> This series introduces a 128-bit version of these accesses, and
> corrects other out-of-bound shifts within the handling of interrupts
> that were triggered afterwards.

I would really like some fix in this area for 11.2, please,
because this is I think the only place where a sanitizer
build falls over in "make check" / "make check-functional".
I don't particularly care if it's the full fix or just a
hack to avoid the immediate out of bound shift.

thanks
-- PMM

