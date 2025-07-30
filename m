Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA260C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8TZ-00011C-Hq; Wed, 30 Jul 2025 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh7BD-0006mP-F2
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:49:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh7BB-0002o8-AO
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:49:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6154d14d6b7so3538973a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753883351; x=1754488151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVXwmGqwo+tahfXLAbQGC1re5IUYF1Llwgwv2Ssw8d4=;
 b=obaLm1QZtiTFJ/1P34i+8yIOjFk0JQVDD3Zvid4g/eRn2bgWx6r3kk8kXNMipjvWwa
 B3rqlM5bVOlUayavLu0A005HAk9Fmv+DHDzIqhuO2kKIsLzICuJpzNeESn6fOi17o8Bj
 kJXqxSCcKBJTkIqaFa/avGZ7rSb2ryRganNuYZbIElwyHpmK8m0Z5p62Tk2t4QLaDJ3B
 /u2WCvk8Ml3lz78YFho7rpz7w0IZSnzyZaCK94I+5QlT7iZKSdX7RxiZm0dCxCi2svqB
 KwSEqjOsZS3YVjxKwfGWZ7jMmYBVHdTfIo1HLskSyZUSIzPut9KLKdomHB9ZTAWtF0mS
 X9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753883351; x=1754488151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVXwmGqwo+tahfXLAbQGC1re5IUYF1Llwgwv2Ssw8d4=;
 b=NRGo4nSXZzLXjx/yyLIYhYZCuP2g7wBtFwO84RU32EjQz6e+CQPu0p+wqTnJAxC/B8
 h2BHsyiFWbuHwW73Rn8dCX9vKxLWfLVvfgvuUrG5oPR7knyk7Y65/GLx4VxX+tgsRKZ2
 vwXS1brukBbAR9OsPbfgbKRLyu+TBrotm5LdgNF+XTVg3fRbUz7mBbKKq7gF99qNjI1+
 BMxbQW51xfDOBGusZZKtl+PXuTIoN8uz+2OQ56zbSWN74zfZmeB9pqrH0j3yUBiAL1qI
 OaELNPXF7uSgb2DRfJ8rS2l68wvGJuJrGIVOpIavviMeLMXcbzCBUkJ6s2iVadWkjyCZ
 831g==
X-Gm-Message-State: AOJu0YzN6pcORSd3BzFVBvBg/u/lFFSc6Gf2QW15qFcAR+xm9byjePVe
 rPF/FWadF3HJu8sYRh/MS/F4Iebt5wb11hqAjn6zhzeN123voklQXq4EFWvspAcFDjHKlEltzhX
 3o29abG0Id7mk1lKNviAkyyR3IOSxjSWVB+JOzjxPyg==
X-Gm-Gg: ASbGnctHNgsDTQEJRyBcY7i01qQ9mPUGkTSq8sDTdslJ8hUs3XulnvTDeIAY8IIptIr
 yeR3AaJhQvMgiaTMxDl48Fq5lG8QjAOqlJOD4qXOAniKgTFhFNnWbp9xy4X4rX9pvb63HxFAE16
 0ulgForCFZojbqKLT/xb1iEK2lebRK3VudNOKHqm7kJyI2EBVvFfpYvMlYBR8VX3EDnkSWDr65u
 i4EdA9vumQDyaCTXA==
X-Google-Smtp-Source: AGHT+IHxPDApjMT+9P2MvATe4g0Wmtn3TvvkE1f28YWb9FKbs0tdJVpRz/zYIbUC+Gw2w3HaasBQu0DgaTv0z3Jwl+I=
X-Received: by 2002:a05:6402:2744:b0:615:5dbd:ccba with SMTP id
 4fb4d7f45d1cf-61586f2a770mr3737131a12.11.1753883350937; Wed, 30 Jul 2025
 06:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1753857212.git.asb@igalia.com>
In-Reply-To: <cover.1753857212.git.asb@igalia.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 30 Jul 2025 16:48:43 +0300
X-Gm-Features: Ac12FXzrdlvs1XSLtf5jbQIU2Uo2FFOE4Ly_e8fbyWWXZtslqREkkQtuGYo4vZg
Message-ID: <CAAjaMXbxpauL8V2FVbQ6-8TNVbG7ATRjm0Gn+J_cb=aiK_cG4A@mail.gmail.com>
Subject: Re: [PATCH 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
To: Alex Bradbury <asb@igalia.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org, 
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

Hi Alex,

On Wed, Jul 30, 2025 at 4:19=E2=80=AFPM Alex Bradbury <asb@igalia.com> wrot=
e:
>
> This series contains one minor feature addition and a series of small
> bugfixes/improvements. The addition that motivates the submission is to a=
dd a
> limit argument for the hotblocks plugin, allowing you to control how many
> blocks are printed rather than being hardcoded to the 20 most executed.
> Setting limit=3D0 and dumping information about all executed blocks is
> incredibly helpful for an analysis script I have downstream.
>
> This is my first contribution to QEMU. I've attempted to follow all of th=
e
> guidance in the "Submitting a Patch" guide, but apologies if I missed
> anything.
>
> Alex Bradbury (5):
>   contrib/plugins/hotblocks: Correctly free sorted counts list
>   contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>     blocks
>   contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>     PRId64
>   docs/about/emulation: Add documentation for hotblocks plugin arguments
>   contrib/plugins/hotblocks: Allow limit to be set as a command line
>     argument
>
>  contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>  docs/about/emulation.rst    | 12 ++++++++++++
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> --
> 2.50.1
>
>

I think the mailing list ate up your first patch. Not your fault
though. I did not receive it in my inbox and it's not on
lore.kernel.org either:

> $ b4 shazam cover.1753857212.git.asb@igalia.com
> Grabbing thread from lore.kernel.org/all/cover.1753857212.git.asb@igalia.=
com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 5 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   ERROR: missing [1/5]!
>   =E2=9C=97 [PATCH 2/5] contrib/plugins/hotblocks: Fix off by one error i=
n iteration of sorted blocks
>     =E2=9C=97 BADSIG: DKIM/igalia.com
>   =E2=9C=97 [PATCH 3/5] contrib/plugins/hotblocks: Print uint64_t with PR=
Iu64 rather than PRId64
>     =E2=9C=97 BADSIG: DKIM/igalia.com
>   =E2=9C=97 [PATCH 4/5] docs/about/emulation: Add documentation for hotbl=
ocks plugin arguments
>     =E2=9C=97 BADSIG: DKIM/igalia.com
>   =E2=9C=97 [PATCH 5/5] contrib/plugins/hotblocks: Allow limit to be set =
as a command line argument
>     =E2=9C=97 BADSIG: DKIM/igalia.com
> ---
> Total patches: 4
> ---
> WARNING: Thread incomplete!
> Applying: contrib/plugins/hotblocks: Fix off by one error in iteration of=
 sorted blocks
> Patch failed at 0001 contrib/plugins/hotblocks: Fix off by one error in i=
teration of sorted blocks
> error: sha1 information is lacking or useless (contrib/plugins/hotblocks.=
c).
> error: could not build fake ancestor

Could you resend it?

