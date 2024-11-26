Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F1AD3B9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxlx-0003Bh-3C; Tue, 26 Nov 2024 10:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFxlv-0003BM-Sx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:46:40 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFxlu-0003Fp-40
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:46:39 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d0102fc7beso6530431a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732635995; x=1733240795; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mqyYsJjmj04WJN6uslctXf7A2iNkc7iA0x/seVmvNcM=;
 b=ZjSl/SC6fDxFh7esflLkAC+zRhyXifi+eNAOcnGL5vnit6qzHSUkZS5KZO4rFgoFD3
 IOuFWzeKLgGV5/yYPaiTeU4mb0i1nEP+BIXJHui3AFf4eV1miEcEb3iAmjXnfY/aL2PK
 H070kER5g9hwM45FqXSb8mh1I5pJiiPMvy0Kyx3ybMyb3ehNGn+T/EjXDy9vqb3ZWHDg
 MVhRD9RT0P0HG7xEufcSzrI3xVWbcw3BhUQxCGvYv2A99yNlCQtppFLekvnPp5JQzpAZ
 pRgeQtGC0XaBXETU+ViDtNcU9XMwwNwHHrJ4bN+qsN/TmZIgaLIjMCpQHIHd+htAF9it
 ZEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635995; x=1733240795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqyYsJjmj04WJN6uslctXf7A2iNkc7iA0x/seVmvNcM=;
 b=vdqKeurQX9M8TPZ0m1EhxU3a8AJToX7JTPoEyWaY2SsguHdXgRvaqHNwKxtxZSJTBL
 0kuba7yjQMY/DmGZj5p6W1GA6TQvK/3CPEoWHwxQh4EXhBXtCzUI9eznkNpkWTXtGt4V
 MPkflBv0XNmX3GO9anA856J5f8rBox1ZxmRSHPo/MkbbDpYzNCxLEhya18O8XWA6pP73
 oRjmyrJN2WcpaO8nRVFOVZOsPbT/yb1ZY38NAMhAilXkcJLz8hxnXnJcuvZl0PZD2yfS
 Wr0a1lOon7FSydACYuwPStJ+rqEGmUUi2l9huPFxWqOnlo4CZxXOSATQ3U4Lp1e4AVID
 ZsIw==
X-Gm-Message-State: AOJu0YxRGnhcpsezoNr0cTY2qZpSEG2LeVBVnZ32eoWrntSLCkbRYxv7
 KcbB2o7dEOg6x7v0BMjnI6djCN7JbLL07SEyQkwpCbAde4ufknzAN8ZSvkoEajH8hh8eQLMLUWt
 vmw+beRnRhfyw3/sx78c3MMr4t0egUdVBHmMk8NYQbHnmGKQ1
X-Gm-Gg: ASbGnct+b/FhW5NQXaL347XPPYDcz1mDwO287LI8yMHOmKoh3rGfnpdTCpqpm7yE220
 ZnQGbpiNcd8VErei7i2tPr9bDhF+7BLW5
X-Google-Smtp-Source: AGHT+IHwZslQC/y5oCFg/0mJaiwCjlvwZKoXWsXys7L5pPGcLsQY/9SUJesuYjgBb7034KTtHc9Tv3qdkr0clI5Pfyw=
X-Received: by 2002:a05:6402:1eca:b0:5cf:c97c:821b with SMTP id
 4fb4d7f45d1cf-5d020792a11mr14724654a12.23.1732635995407; Tue, 26 Nov 2024
 07:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20241126040607.1704-1-jasowang@redhat.com>
In-Reply-To: <20241126040607.1704-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 15:46:24 +0000
Message-ID: <CAFEAcA-8xH=Ws5c6f2CxYn8=Run_o8vhGSh2rU7ardzc+0M+6A@mail.gmail.com>
Subject: Re: [PULL 0/1] Net patches round 2
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 26 Nov 2024 at 04:07, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 791e3837c1105aec4e328674aad32e34056957e2:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-25 10:44:11 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 9379ea9db3c0064fa2787db0794a23a30f7b2d2d:
>
>   virtio-net: Add queues before loading them (2024-11-26 11:56:44 +0800)
>
> ----------------------------------------------------------------
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmdFRyQACgkQ7wSWWzmN
> YhFU1Qf/T9bBOCrbQqbZSG7eKk8QuH35zcgNU7FzFTrGeVCc1bUMNYhiioqAFmE+
> h5h/3vmkmt+01vaTuimTRumI2SJnFFwggveJDWf+ICSl9MRtCXB5+w0n71vJ6gUO
> njm36pIl+aMkZIrsDc7lLewVouZkF8mAKP7mn9x53s5lX/HbXZSdPJmrkdUXtNT5
> d3nXlUkNhEWKL9dKIQ9dWYmj3l+tLfuYPiR8a+kKFMEwHlGBuFbNoVN03v5VvFyf
> Dmy1P1ZFApP0SsR4SiccXg7C8AslBC6wc7Bhd0aiKpGBnlt20mE9EJSVyrU8yP1p
> UTKzzB0QHN7Nnd6AcFRhWvo9C74mGg==
> =qP+q
> -----END PGP SIGNATURE-----
>
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       virtio-net: Add queues before loading them
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

