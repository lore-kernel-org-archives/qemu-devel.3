Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260CBC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE45U-0006vZ-5t; Mon, 03 Jun 2024 05:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE45R-0006lU-Rk
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:34:41 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE45P-0002Uy-71
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:34:41 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a68b0a229so365927a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717407277; x=1718012077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgQpDvP/UpzpoOmwtvw0eqFBXRgnKzx5L7FxKPXeWDE=;
 b=kr5JH8I++aLBDjYer1/i+zefw8sE1PM2HvIxwQuco7+QlbXjjH+QI0ncnC786xRyur
 c7l4czf/GLzRdJGe3EBF2/UoNMJD199jtWJdgRYz2zbCu1wHoDqJ4tdM5H95bsVU7skI
 rzMp8d8nbkgD+nOF4V8z+ADdX3CJDwUevELv8ujsJs5CJcV7fACyhBe8lDTIB+WjRr13
 OMqtcO8zRZs5SbrJC+Y7VxDI3U+OIw+5+xcUAGQfjWv2mj42wZxyMvVElu4MANMSxH0g
 4v1ip2Qqh85RJ98wnTCLs6PNURqi6EuZ7PaUBvvf64/ScNal490FInFTlZRTfqu0YN28
 /STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717407277; x=1718012077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgQpDvP/UpzpoOmwtvw0eqFBXRgnKzx5L7FxKPXeWDE=;
 b=YBmqkQUB5vVTtc+vBJrjG71iFtk6YpvUveoLHRxYHePbRtKTy0k1KsxH2v/UkzZ+Rd
 TRtqhiJjZqX/a7AZn5fOVjZBcwZDlKoCFFqk7QUdXutDyb/fJe0p43JfJsBPgLwLqP1j
 45ZoWAwAeU47us599vZe4rCWncICjX1PJ9a6YOPwtPIRiyzFageqwJK6rRmnfiyOvElK
 vT9ItbZ2fSgrokC5oCAg4rEJ04ydX0H6YsfnG85g0gs8rqdEntDAz7daaxBta3fWxzCt
 j+7xFWGBJfZepACVscu/WtSnbPVX/nHwLKmWaQwNpU8UQKZzI8E9pQC+90zHbPQqZH7Q
 4eHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFutjhwmJmwVVuuk4WHYRaAJJ8zSnm6CQUN6bOfLJ6Hw1sliYWDJ0IQ/CVbmBTZP1kf1fQ0AhdAo9F33LMr4DB5MI3Js0=
X-Gm-Message-State: AOJu0YztMtguSp3mRdPLovXRvkZPXzXbTfGejaWg+4gdvlNngqm6NiAJ
 vT9rW1EwReKrHbgSXc7/ubGRv7R49tf4mz9iPaKeQltkQR19bmZrvg4+DgMn4d068208Yq27HEF
 ann0SaC2DyAP16cdvCN0ZVzdpSfq3+izDqkK1dA==
X-Google-Smtp-Source: AGHT+IEqoBGAUFUsrkahvySihbnLVgbGuXZDMVPrpINGwYc0b2jWUlcLyipW/Ug++wc8R1OqeiI688uuJph03l8q2yU=
X-Received: by 2002:a50:d4d6:0:b0:57a:253a:5ae8 with SMTP id
 4fb4d7f45d1cf-57a3644fe88mr5760988a12.34.1717407276944; Mon, 03 Jun 2024
 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-2-porter@cs.unc.edu> <ZlnajZpUHyGDTgNx@gallifrey>
 <1bafa185-25bd-44d2-8f4b-51ca28125115@linaro.org>
In-Reply-To: <1bafa185-25bd-44d2-8f4b-51ca28125115@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 10:34:25 +0100
Message-ID: <CAFEAcA_u1LWnnR-+rK03EkJp8W6UcjRMfPoBm3io5qLJ8Bkq8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add an "info pg" command that prints the current
 page tables
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, Don Porter <porter@cs.unc.edu>,
 qemu-devel@nongnu.org, nadav.amit@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 3 Jun 2024 at 09:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 31/5/24 16:11, Dr. David Alan Gilbert wrote:
> > * Don Porter (porter@cs.unc.edu) wrote:
> >> The new "info pg" monitor command prints the current page table,
> >> including virtual address ranges, flag bits, and snippets of physical
> >> page numbers.  Completely filled regions of the page table with
> >> compatible flags are "folded", with the result that the complete
> >> output for a freshly booted x86-64 Linux VM can fit in a single
> >> terminal window.  The output looks like this:
> >>
> >> VPN range             Entry         Flags            Physical page
> >> [7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
> >>    [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
> >>      [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
> >>        [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 0000007f14-00000=
07f15
> >>        [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
> >> ...
> >> [ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
> >>    [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
> >>      [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 0000001000-0000001=
dff
> >>    [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
> >>      [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
> >>        [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 00000=
fee00
> >>      [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
> >>        [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467
> >>
> >> This draws heavy inspiration from Austin Clements' original patch.
> >>
> >> This also adds a generic page table walker, which other monitor
> >> and execution commands will be migrated to in subsequent patches.
> >>
> >> Signed-off-by: Don Porter <porter@cs.unc.edu>
> >> ---
> >>   hmp-commands-info.hx              |  26 ++
> >>   include/monitor/hmp-target.h      |   1 +
> >>   target/i386/arch_memory_mapping.c | 486 ++++++++++++++++++++++++++++=
+-
> >>   target/i386/cpu.h                 |  16 +
> >>   target/i386/monitor.c             | 380 +++++++++++++++++++++++
> >>   5 files changed, 908 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> >> index 20a9835ea8..918b82015c 100644
> >> --- a/hmp-commands-info.hx
> >> +++ b/hmp-commands-info.hx
> >> @@ -237,6 +237,32 @@ ERST
> >>           .cmd        =3D hmp_info_mtree,
> >>       },
> >>
> >> +#if defined(TARGET_I386)
>
> FYI in order to unify all QEMU system binaries as a single
> one, we are trying to remove target-specific bits in monitor.
>
> How 'info pg' should work in a binary supporting heterogeneous
> emulation?

Like the existing "print page table" monitor commands,
this will need to change to be an indirect via a CPU method,
rather than a command directly implemented as a command
in the target/i386 code.

-- PMM

