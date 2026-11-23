Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=ATNtDYL8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVkA-0007Cw-Mq; Mon, 23 Nov 2026 10:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVin-0006YS-2i
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:12:50 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVik-0006Om-9N
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:12:44 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67db23d8892so3590241d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:12:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446761; cv=none;
 d=google.com; s=arc-20260327;
 b=Y8+bAsjIwZvee9SDLQXe5ABT7XlI7iw/O5DIp5GqgX9s9GrIsQUy+me+4qqVuD5OgY
 bvIcE+QWSJg10c7MJBznCgeardaRWk7+r4EaAtJufusrukPuMQQ2pjizln+UvDo0/deJ
 cM2dq/UMYTchJxHbShwfemTuRADF4FeH+15+gB+vHYBRK2pRbjAzSOYn59C7fHBAasyP
 kdxb5rNkerdRTH5KQp8ypCZ2wEhkp7brxIvrXaTx8iEXMtBoNXMzNFKs7h3qfpCm+NIe
 17ZCoTBZ3WmGb1id09sqs/L/6kLEDeQqdLpkOBcH1nAfXwoQ8zw9NrXK6zaBTyQXIqdo
 tYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CtGjttGjiRbvno6EBHpB5Jtwc+KOTQQoZUgh/y0R2D0=;
 fh=NLQEsyaHAaR/r1ZilKlHNSug1PhaFkpfWGnPfhqws+A=;
 b=Q1jMZFsVIryyKOkq8bw6OWG81VbvYqgtkCEeiJDt2HrCPIBDgGoMAhgYxvsyft0Sdy
 ElB88i1kHsDMYpW3ymHUnpqEEDEd2gwpZjmAQ2eEZi8JSuAV6bHKqVhmSbsDm0Ms18BS
 /0p2eZYoR+Rsj4CoIAHT7yAma8GU1LPAc4hIGn05ULbaogyx4EsXCZyeLVg6ZQFVbDNn
 F/oqvX6bNW++q9ZfQLUF+FW29hXyqeUBJ5/hMUYGo8yx9lYldYUD4K/uLrZEolG7ctnk
 98W9oKPYU5KNd9MnWa50YoaWeQ+TCKUlgqus0jK6qkYdWmq1TLIWTbgmTZtnyJOZ+Qp/
 44/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795446761; x=1796051561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CtGjttGjiRbvno6EBHpB5Jtwc+KOTQQoZUgh/y0R2D0=;
 b=ATNtDYL8GS9NENENeEBsz69ALVU6K/wBdL2EGcp6rw9KfFP2IWunD83UE7+Gw7tQQl
 iIdO4G4upedcSmphGZkgXk25VRJOH8w8HfWL+PkoLIYn3LDQKgKlR01PLO8LWM4Jcw9M
 7aAhC//0IRleoJVJvHGryOdXsDxOyFluyFLbCkwKirJ8S2QVHyRHewx/N94co6hrVk8X
 WWyIW0hItDBFNBPuBZ+txjJ/2k/G61qwUovNMpwdk681p0pAajvCONHgVSBK7wZXNzVD
 VkzCOMiX9iBDs90WbSSTDReGtFMsuj0Pl0qsZyclA3+X8tfildcgaJRjY13g6JadHCyg
 bkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446761; x=1796051561;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CtGjttGjiRbvno6EBHpB5Jtwc+KOTQQoZUgh/y0R2D0=;
 b=nCvD2A/T4AMKopd5z+JqFu1SDhHq4OON4TlkOCuK21mb5dhThypsYjn2LkWC26tArr
 mdupzF83uySqKhvGIhyz3GCSf4mvjV5l09iO4GSHFzyYxbwUGtzUo3YsIjsgwd2MKYeR
 y9miNUi8bToBMx+Jq2Fs2fR39/VV75qz+oM2zfsY/Qqc3YOZpallm9M//erEYYhJTQrr
 6ElNXX+83u1y0cQ1fz5I+kJjeShWK1/o0edIZ93Rz1vFLiJGfkAyvulrS9jrmM36vYiY
 j2AetOCGFpA1O0kSd2wyUi6TedmfScpwVrQbcyEaqK5gLt8OyQbBROsCvw/hAQkmNAhy
 YFsA==
X-Forwarded-Encrypted: i=1;
 AL+hErG1QrXir414KA1ZruEDabaa2/BoeGvN11Zhedoah0Ug9/DR4qtbnuB38eCjzUbxw81ymWN/FFJb9pO+@nongnu.org
X-Gm-Message-State: APuU4Z+SM/4jl7ik4ObbWjWpZ0Ok4PljFLCVAW824JrwvkWhLDGdVi4g
 sqC3iuvli2UxDtgIIohH62ZTDvon2StBbIJyU8GW7M0MzC2Qrz5PFNxxycl1c3alXhJ36Sxqzt1
 NNjc706Tu+iQaAB149KXG8ei3qLZsx3xE9t0ISVmQ3A==
X-Gm-Gg: AZFdTZdNfVTfLBh3qIvU9QIbsVUiAQF5HowM8UAAQsLChV16EPTo/v8QHs5crnRk8ml
 BRpO8mctF7wcdv5zj3VM1k/dwkIGt7kMnIYmc/mElzRSEwB0VGp63Du9O2DhcxnUZyjNiDEsiPR
 ntHEbr0fHEg93vfsEibuAZ4iOjr0DL70813iupqGdaHv7wD5EqzGIEtjdzJeYNXOU8ZuDmN7bwp
 8HzJ+IFElAT+SFogSbH944nN9kyOkHV7/1Or69q6IgLZnBqejtDFgaS5zWe0ITJlPirZWxrx4mX
 XYt6a2026zdgLTX2LAeZz6MafiKisKC8A5J7TSfasVP3A9qqBJZya02pcUxE3L7XrQ33e7V5Wf6
 mxdrArneRurTCijPufJI3JrKxDuqAb0ttvYICNj8KC7VMnGD52Z2dGT+ZYdicu2twrnhNZiA6c2
 fxGR/832SRJl2r6deNlxZ9m/w51w==
X-Received: by 2002:a05:690e:810:20b0:67d:b995:a5b9 with SMTP id
 956f58d0204a3-67df442229cmr3055985d50.49.1795446760721; Mon, 23 Nov 2026
 07:12:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
 <20261110-m25p80_write_enable_fix-v1-2-3a2abc0072b0@oss.tenstorrent.com>
 <39176a72-7756-477a-842b-e277ec07d321@kaod.org>
 <CAEev2e_SbbLENO3YhkJPtBXyd2JKZktmnxzD6UbbDyfyih6C2Q@mail.gmail.com>
 <c6bdf631-52f8-49db-b2a2-c028671a2753@kaod.org>
In-Reply-To: <c6bdf631-52f8-49db-b2a2-c028671a2753@kaod.org>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 23 Nov 2026 09:12:29 -0600
X-Gm-Features: Aa3M54o7RLBv5QJqjt0z2LroN4QAg3PNi3q5ZFH9xHZROZCqmdwgWQCJwhE7yfs
Message-ID: <CAEev2e8+9G_fEbGb4pxc22G-fHF6ebLOhBPJdDP47Y976pML8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] m25p80: Clear write_enable after page program and
 flash erase operation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi C=C3=A9dric,

On Mon, Nov 23, 2026 at 9:10=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 11/23/26 16:01, Anirudh Srinivasan wrote:
> > Hello C=C3=A9dric, Alistair,
> >
> > On Mon, Nov 23, 2026 at 1:13=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod=
.org> wrote:
> >>
> >> On 11/10/26 19:11, Anirudh Srinivasan wrote:
> >>> NOR flash drivers in EDK2[1] and its forks[2] poll for write enable
> >>> (WEL) to be deasserted at the end of a SPI operation to indicate that
> >>> the operation has been completed. The m25p80 spec[3] indicates that r=
eal
> >>> hardware would desassert WEL at the end of page program and erase
> >>> operations.
> >>>
> >>> The m25p80 model does not deassert WEL at the end of these operations=
.
> >>> Update the model to do so to match hardware behaviour.
> >>>
> >>> [1] https://github.com/tianocore/edk2/blob/3c890c11dfdb5908dcbc84f977=
dddc6c6d43789f/MdeModulePkg/Bus/Spi/SpiNorFlashJedecSfdp/SpiNorFlash.c#L987
> >>> [2] https://github.com/spacemit-com/edk2-platforms/blob/0b8b7182d8a20=
a771b97a487d0e6f4ab89fb3492/Silicon/Spacemit/Drivers/Spi/SpiNorFlashDxe/Spi=
NorFlashDxe.c#L532
> >>> [3] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICRO=
ELECTRONICS/M25P80.html
> >>>
> >>> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> >>
> >>
> >> If this change is to be merged in QEMU 11.2, could you please provide
> >> a Fixes: tag ?
> >
> > Looks like Alistair has picked up these to his branch already.
>
> b4 handles trailers updates nicely.
>
> > These would be the fixes tags. Not sure if i should send another
> > version or if Alistair could apply these tags.
> >
> > Patch 1/2 (aspeed smc test)
> > Fixes: 3e62a32ddb ("test/qtest: Introduce a new aspeed-smc-utils.c to
> > place common testcases")
>
> hmmm, this is for patch 1 and you have just replied to patch 2.
>
> > This bug was introduced in 7a2334f720 ("tests: add a m25p80 test")
> > back in 2016. The commit in the previous line refactored these tests,
> > so I think the fixes tag should mention that one.
> >
> > Patch 2/2 (m25p80)
> > Fixes: m25p80 ("Initial implementation of SPI flash device")
>
> This is not a git commit it.
>
> I think you should send a v2, the tools are now quite confused :
>
> $ b4 am 20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorren=
t.com
> Analyzing 7 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>    =E2=9C=97 [PATCH 1/2] test/qtest/aspeed_smc-test: Send write enable be=
fore each page program command
>    =E2=9C=97 [PATCH 2/2] m25p80: Clear write_enable after page program an=
d flash erase operation
>      + Fixes: 3e62a32ddb ("test/qtest: Introduce a new aspeed-smc-utils.c=
 to place common testcases") (=E2=9C=93 DKIM/tenstorrent.com)
>      + Fixes: m25p80 ("Initial implementation of SPI flash device") (=E2=
=9C=93 DKIM/tenstorrent.com)
>    ---
>    =E2=9C=97 BADSIG: DKIM/tenstorrent.com

Uhh, sorry about that. I'll send a v2.

Regards
Anirudh Srinivasan

