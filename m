Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA65606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qkI4wql6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVZK-0006c7-Tj; Thu, 29 Oct 2026 15:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMVZH-0006bg-86
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:13:43 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMVZD-000530-FC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:13:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b056d58f2aso24956427b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793301218; cv=none;
 d=google.com; s=arc-20260327;
 b=DmUzhm/xO6nMXKhM3nzLKKTLfmEOsHFbjU4JaT+hxsjW/T15lSRJQBYo6rQ3Vgn52m
 MwtxCzdoGKxzp/dEmFD8QTxEWpacZk7ibp2d+o142KvWL9SkSZ1QZTX0Dky9nv9YY0kA
 DohzZ5J3ZrRGp9O7TmOA465UTz3J2DHYXyL5VS7sKMfkpoG7NShhS/mFkW/PIS1LEkcX
 NyH8++SoOmNRptJofihsz74X53cggt0AGJdhN2XVhiil4gNYGI5GCqF0dhICOJOSn135
 OMu8KuXCoCf/0S+Tm3KGgFTdJA78JYj/FswCmzDSw+kLwXUignbH2Hf6IXBKBjtLyz+A
 Cf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SZEu8mV7OojmVUJlqjYu6aT+DwSudMCQUB6YEP4qbfs=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=Jf/onY3DwRsd7nB8d2spYXg6mtQ45c7a60SnQsTu7Ao49tQglSoxwxoJQfcxpS9I4P
 T0l2U6C3qp6z8iIIPRC+UU0InsAtGl14rnmKMdv9pkFNs01c7al7w9T3I4O5WFhfSZJ3
 ZKPwpV5STP9WZ3U464f7Ca4/w6e0HG0L3flXHosAGZyrRD0VYsVFAxKx+CKzaC9fm8GU
 5RJyKQcNHfP6rg8thK1ut4tmh12bpCTv5fKuFf/tEJiN/xBUlBVKTtjhU+0QKVwUwTFy
 5GeCcmQ1+R15rskHopMxpmVGo92ffO1MCDKZCso4Rk8JPkDM7wqvfpt1AQD3dFG1i4+r
 4s6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793301218; x=1793906018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SZEu8mV7OojmVUJlqjYu6aT+DwSudMCQUB6YEP4qbfs=;
 b=qkI4wql6xRsrqEwtMjbhS4k+OqD/PSH3SoipQ72F2ok20eyhhu5PbfJWDa+aDhursL
 beXT3zazwM1w15iPIZ0+oW5BN8s9K9orv1mvQdo1FvWLgwGi+zpZm0SlfyhE3lAM2i09
 4OgbFv2gdE/pEdDCcrCEQ6+Ec5ISIh2Akyl9GFiT3w9oIGkUOz5GigLFfj+E5afM043H
 R+dSMxcW4pU+uoj3qEQhiZQxcqZ9BN2TcIr+YNUhTTD8RCJSmz5K6VPMcgaIrurisn2N
 875N88bSjVmqw1BVvXAPG+7PO0HjD5tjRLm7I3ZaL50o/6ojizaYweexL5Qy3jylWafw
 mLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301218; x=1793906018;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SZEu8mV7OojmVUJlqjYu6aT+DwSudMCQUB6YEP4qbfs=;
 b=srOtLucpcnbwMAPxEsEGxHzQhWdyem1PVo778AHU01/GeWwWOEw/iW9J5JHWn2nHNH
 xD9XGw5wAZ9ZbXSGKGIgPHl3NaX3LYqDOkVNW5CcBbHyhXYNFjtBWev9/KXQkHeKR8Wt
 1cXnB0UkykOPSzctyAU3yarFXJcr/qbJfIW2OWTa85Yh8/A6jLN0bTRCAxOibtffrHLe
 GSuPi4Erk12Yf5X444u52CAumkt5FjHBJn1v/xyI1HNgKUgc8sFuKZsS5vgOjvbBOTow
 cuwZCZDFrSIznmKrpomUP+ZQGuhMK7p2L0RYa393pGlPohJy17rAWHpG4YeoOxuu/79X
 N0iQ==
X-Gm-Message-State: AFq9FYLeDSOXuOj3t+T6VQLLeMWoJEtPOerk7oTuI9ed78ver7n8QIJJ
 pXmA+sXCnpv+M/9i5bBA34bo7nDdcXthR+cKkKaxKgE+AONla9T9a6NCZAvex5XNCDqPgPc/k1/
 LHHKVAtOOVTnb4bEyhiCaR5VSbzxnO2IX0S7ZdzOI8g==
X-Gm-Gg: AYBFou3dTgmICmbGPCAww0h02e91oTO7zfN4zDz0ollmKFRQvE/QTAy+mgEihradZa9
 NL0aMw5sgAf7c/nI683ix+uUEvij7zIj0jCGEmOYwTHpwrCN88dhTSxxf2ODpHYLN1ZE8jQbfVc
 9dpnFIEX1a/ETEBnBtSEx4mZie9ew33y/J5AMegeXI20w3r8p1/i+Q7DX9tNkwmI3X+hBAGMwkr
 JtGzZ3u25J6q7zXuKE/3oxppI9597lYUZaW9HxBLLxFQI0l/ckue9EDSa1aRVi6+40w0H7EJ/Ui
 yM++AZRsFNCU3e2e582UNIJeRWy/g7HYYcmPJbOmHQnS//8venn6/TgOUUHEBsKpHjl85wTXYSp
 xAS2k0wqVfnFvdTfTdv5Upx7DBrxFPu2A1cPpr28Vx/eukAtIqgRZwU/s0U29I31XLqC+iNndXt
 ZMU+LoRDKJV2eUSjvByC5D
X-Received: by 2002:a05:690c:660d:b0:8af:e4ee:a91c with SMTP id
 00721157ae682-8b1b5bf6460mr35119367b3.41.1793301217835; Thu, 29 Oct 2026
 12:13:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <CAFEAcA-=bOxmonNOYC2_1MHDrdof6eciYrehJRDfWx_7kYsJmA@mail.gmail.com>
 <1016C70E-8B1C-4F3F-A19E-59D7A0E66A33@unpredictable.fr>
 <CAFEAcA8Ywq6MZxO5jt4AKay8wjWGLQYxnJ1rMkFjzoF1ppUJ3w@mail.gmail.com>
 <49C40F6F-EE09-4237-83B8-1CE18292DE3C@unpredictable.fr>
In-Reply-To: <49C40F6F-EE09-4237-83B8-1CE18292DE3C@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 19:13:26 +0000
X-Gm-Features: AclHuK_ukK5xHPQhT3re5FDOimXNL34x7bT0bR_4OnbyOJLBgKNV4MEce3dgtog
Message-ID: <CAFEAcA9sXa2DvJqP8VViesX72viaVa2bBqMekG1ZwFswnJ9UvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hvf: arm: fixes for QEMU 11.2
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 29 Oct 2026 at 17:33, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
> On 29. Oct 2026, at 18:13, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> > Do you think we should deprecate the "vmapple" machine type, or do
> > you hope to resurrect it still?

> I do hope to get it resurrected as an optional feature still, but
> the issue is that it=E2=80=99ll stay (by design) a reverse-engineered mod=
el.
>
> I need to spin a new revision of the patches for that though.
>
> It will break from time to time and cannot come with an expectation
> of short-term (as in, anything past 6 months) stability/build-ability.

Hmm. If it's going to break every six months or so then I'm not
sure it's really a good fit for upstream QEMU. As we've seen,
we haven't really in practice been able to get updates to it
into the tree particularly quickly, and most downstreams will
be operating on a slower cadence. If we had a larger group of
people interested in cooperating on maintaining it upstream
then that would help, but we don't really seem to have that.

thanks
-- PMM

