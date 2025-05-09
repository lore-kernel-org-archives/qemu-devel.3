Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E197C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPdd-0005BW-6N; Fri, 09 May 2025 11:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDPdb-0005Ap-OW
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:27:47 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDPda-0008Bo-06
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:27:47 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e733a6ff491so2418877276.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746804464; x=1747409264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fo9OcAbrNLsD2a7f50+Dm7QG8zYmPULAcM7xDP6trQA=;
 b=BCMQ3KY95qESfmhEFFo7it3m9SAF1RuI+8VpRXdyrczVt6y6zGSvQErNe7SIk9dwcB
 zK5brfeuOLg6FZiwTog9ys7G097K1OSO1PprZftMlw2Djoyd08csYNY8GesfaJykViHn
 VTtH16uFH+yN9syyPc+FYSojLqsl+mLujAd+B31yrkjg4sz8jwdfmLT+vnD6wPrMrHe7
 Bqng98pdoc9iWNYych3OZano8BEv/10HbTHsWBCXLDc40dxEK2HEjW4s8aS3thy1KW7L
 CJQ3CCwfN65cn3vp/IXZ5wPtXpHM6TvfPWDQCnkafvfxLmYvqOJ8nIRugx+UkTy6pzBx
 D1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804464; x=1747409264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fo9OcAbrNLsD2a7f50+Dm7QG8zYmPULAcM7xDP6trQA=;
 b=miYBE7WtNEgxY9s2Nk0ler5H8177shyN62x0wikXHouEXuZIRVZpIXxS6/6x0R6Fe/
 5d1+kzu56QNx1mAtJZ9AQEUeVtVkMK/Txz8jFKHThDDIj/NP+3nn0u0rnfiCpM1zS8Gm
 pzRJnQVpGeQEER6mlFdcFfOZ8xQq7+Ug9/6NN/u5DyrhnbbQeADUsxhkonKf/n2g000h
 62qwl8D1pI/7o4WfV2eril+UGPQNks2i2SgEoMcsD58ldm3Rv40RCSa7INQRit5JyIQJ
 4ydyvCChhvWqe+PWUuHnCo71zZFDeuCLhMRDbnImkSTfaLDo/X+kDSesUgJzxKwWhMZ4
 WWMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsC+8M9OYBJwdqZ/mRG4Iyhj0/b7x9aADWQBPT9ZZMYG1L1Uao/6wiJFMdpFQ7qCDurFIlN6bDpp/K@nongnu.org
X-Gm-Message-State: AOJu0YwjSzHI2HkFuloRBgL/V2DU9HFw5Pe5TOJ/nKEpI5oSASq2THFl
 FJtZElRcm1l3wc/XOK3HCpBPQufxuZEHdJ7TVjDA3sntQ1f/ojKZy8YJpzfwVAA//WDxLOSbTcU
 95XPUiNG8QV1CZn7VUv5NuYRUQlbbGHgUHIPpCw==
X-Gm-Gg: ASbGnctW1f/aPvyAT5d8XyIu92lrdJ9TaYbfUedGXyBy/aTum/wkNF9yCHHEiWhuU1T
 D6iAyAvm5jL+Uhswg4BC0tOLsP/OMP6w71lJ14FQBI3eFCYgu5LEetPVY2x8Dty5+ankEdz0Ntq
 KH3e1wvjHhsH+PjrCsAIgdV6A=
X-Google-Smtp-Source: AGHT+IEc7DiU3hjJr/YtJtes5XgOMf2lAth19VZI+vppp4HYHp2DkhMUgr9vyWg3Dr8IUpctDFtGKLk7gm+V3cJD/CI=
X-Received: by 2002:a25:7b87:0:b0:e78:ff9f:4935 with SMTP id
 3f1490d57ef6-e78ff9f4ad8mr2627217276.34.1746804464531; Fri, 09 May 2025
 08:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-23-clg@redhat.com>
 <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
 <ce9162f3-a3d3-4a76-a261-af16384ea82e@redhat.com>
In-Reply-To: <ce9162f3-a3d3-4a76-a261-af16384ea82e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 16:27:32 +0100
X-Gm-Features: ATxdqUEF2muhkKyVPw7UZ9BWrBBl61yCtzy507J8xOQVAFZeS_ItKXuOX-STwSQ
Message-ID: <CAFEAcA-OJmmKgLrd6P-+Kb=-Zh52GL0y+vfNLrivM97T4DDDwg@mail.gmail.com>
Subject: Re: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 9 May 2025 at 15:32, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> In the ast2700fc machine and the fby35, each SoC has its own memory
> region and, since there is no need for the global system memory
> region, it's empty. But in some places, like
> rom_check_and_register_reset(), it's a problem for the flattened
> global view.

Generally speaking, board models should set things up so
that the "main" SoC for the board uses the main system memory
MR, rather than creating its own empty MR for that purpose,
I think.

But separately from that, it's weird to get into flatview_lookup
with an empty FlatView here. We called memory_region_find(),
which is a wrapper around memory_region_find_rcu(). That
function doesn't make assumptions about where the MR it's
passed is from: it walks up the tree of MRs to find the
root MR, it looks up the AddressSpace for that root MR,
and then it gets the FlatView for that AS and calls
flatview_lookup(). If the FlatView we end up with doesn't
have the MR in it, what's happened ?

-- PMM

