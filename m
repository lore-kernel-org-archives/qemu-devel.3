Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBCEC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 10:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiWEQ-0004c2-6p; Thu, 13 Feb 2025 05:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1tiWEI-0004az-Ot; Thu, 13 Feb 2025 05:13:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1tiWEG-00078x-Aw; Thu, 13 Feb 2025 05:13:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B8D8A5C53A1;
 Thu, 13 Feb 2025 10:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA05C4CED1;
 Thu, 13 Feb 2025 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739441634;
 bh=6Vca/JaGuKes76BeKlU7+5zMdE+wx0RB2G6+FZ9cjoc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eqxSAQXqIWGpkjfQAodVEuFzy2L1OumLOdjEcvbFX3LsB30q/eNVPmWDT06nWzkOu
 DJWNxO6hGqT72IQ4FbFZoXySn/vjh5g344yC+e3JvMwCmhPzLkWXk24gy3uOIiinLt
 GHHJJUiomjD8OMYOn15wKy/xdNN7UTwiP+AxV6x0edNTap015gjhaQUPWa6FuQ76oI
 +BauJVkcTKqwRQnpow6ZuH9CVhA45WtwEUrZgX3dqIoQEdopNQ0o8/d/Y0bqTnkkqN
 R0I411I2wLQ4z/nenYw4dAODEcBP1489aXzucqEoaKBp3XxFea2JhCRp/0gmZ3OfMk
 OXXwFNL3QdSiQ==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-545097ff67cso654490e87.2; 
 Thu, 13 Feb 2025 02:13:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUiZj5X6FOd4nRHkRIbHS8dOUDnJXyXzWEzng+QCVdxXhkGT7HfPYSAQSHaXPgBjTKib17MiXking==@nongnu.org,
 AJvYcCW+g4nXgmOPpJ3HOXxnzYvjB0uRB0sumAQ//j1IB3/MH1xJjIjk10nzCp7Tntnc8eSceYrAxiEuxUq08A==@nongnu.org
X-Gm-Message-State: AOJu0Yyz3fuVEVX7Nd/yq1iWk4QHav7X0FtFRAIUckNgJHXw4hFJ1Vnl
 cLllBdwsrUA0j5ffe7LcxJyc6AwkKt6wm0C8eHRMbCNQt18EG22j1HajcRciz2UpyxXXemTPQCD
 Bcq9foWBnUsbs1IREf+yOezGSp2o=
X-Google-Smtp-Source: AGHT+IFGqKWEfyhySzMXVFDBRn2O7H7zq6aSkVOgEAQi6NeHYPFZf7j+9QgD+CTeroYlOa0ebnvJWCu0bfEyJOhp9+Y=
X-Received: by 2002:a05:6512:e97:b0:545:4b0:8a1d with SMTP id
 2adb3069b0e04-545184bcfe9mr2162009e87.51.1739441632369; Thu, 13 Feb 2025
 02:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20250211092324.965440-1-kraxel@redhat.com>
 <CAMj1kXE289FkzV=GZSUARF7TFUyRuxYVX-090ic06Erb_RLGrg@mail.gmail.com>
 <cc41f19c-5778-4376-a1a1-762a92c8584c@amazon.com>
In-Reply-To: <cc41f19c-5778-4376-a1a1-762a92c8584c@amazon.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Feb 2025 11:13:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFaoZCnXpAsq+i5nzpCOjcrsN4QA2r6Z=F6UUwcUe_qJA@mail.gmail.com>
X-Gm-Features: AWEUYZlg51Z1Tt_zVC_1CRwzJSq_hfim0Du2WMOrMWNA-JlBE_QiSF49Jd7zHV0
Message-ID: <CAMj1kXFaoZCnXpAsq+i5nzpCOjcrsN4QA2r6Z=F6UUwcUe_qJA@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] hw/uefi: add uefi variable service
To: Alexander Graf <graf@amazon.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 13 Feb 2025 at 11:11, Alexander Graf <graf@amazon.com> wrote:
>
>
> On 13.02.25 10:41, Ard Biesheuvel wrote:
> > On Tue, 11 Feb 2025 at 10:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> This patch adds a virtual device to qemu which the uefi firmware can use
> >> to store variables.  This moves the UEFI variable management from
> >> privileged guest code (managing vars in pflash) to the host.  Main
> >> advantage is that the need to have privilege separation in the guest
> >> goes away.
> >>
> >> On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> >> not liked much by various stakeholders in cloud space due to the
> >> complexity SMM emulation brings.
> >>
> >> On arm privileged guest code runs in el3 (aka secure world).  This is
> >> not supported by kvm, which is unlikely to change anytime soon given
> >> that even el2 support (nested virt) is being worked on for years and is
> >> not yet in mainline.
> >>
> > The secure counterpart of this would never execute at EL3 on ARM, but
> > at secure EL1 (or potentially at secure EL2 on more recent CPUs). But
> > the general point that this is difficult to virtualize stands; I've
> > contemplated doing something similar to SMM emulation using non-secure
> > EL1 in a separate VM to provide an execution context that could those
> > the secure EL1 payload (using standalone MM) but I never found the
> > time to work on this.
>
>
> Sounds very similar to what Ilias built a few years ago?
>
> https://lore.kernel.org/all/20200511085205.GD73895@apalos.home/T/
>
> Which reminds me: How similar is the protocol in this patch set to the
> one implemented in U-Boot? No need to reinvent the wheel over and over
> again.
>

Identical afaik

