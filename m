Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51702C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 17:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxsCK-0004bV-5Z; Fri, 19 Apr 2024 13:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1rxsCH-0004a1-1G; Fri, 19 Apr 2024 13:38:49 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1rxsCC-0003zh-6v; Fri, 19 Apr 2024 13:38:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 80526CE1B60;
 Fri, 19 Apr 2024 17:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FEAC072AA;
 Fri, 19 Apr 2024 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713548319;
 bh=xFMTjOU9FaSmOc2TGsUAJWnbrTmxvTQIzUny4ULRBDQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=adCfsPE4xUZ++eve9Tnr2rWu3ZZhm/ZQMD/wb8Fl/tuN/OtpMWO/S6zNDEKjoYop9
 0RLJXJXVeZnstgr4E706sHTqpse6kaWwcKRZuiUiwvppmE0fQCptyxvSaihTdEYtSK
 KPfx/L/75Have8ks28ZjcY7/reR93pU+XwF/kZIdG2nTU2vfSuIPg4ZTcp0LFTmXBq
 5ahSCuNH0M7kH+ok4N7OJ8ILuMPYLb8CDLREntSmY+j4kNM0SGwwO+sX6SyuH3mucC
 jTZwrMqpKsHUL+SVLAT8JAeLtZ5Mfa0hst5nv4fmJ2mhuHyAjCz9XSevLpMpUGVSqA
 VUC5f9qw+Zt+w==
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso30207581fa.0; 
 Fri, 19 Apr 2024 10:38:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXcftqTDb6eNpHTv6PnPJrVAdN3J5YhHT9WovVQJyvJCLvqqP68cHfWe9Y90aCBQVoyJkRSc3ikG6sJWOlbglpC8Mzb/rhrAReAtRw1HWDwkUXSOJn3apX5owE=
X-Gm-Message-State: AOJu0YxVrJYM6C7u9sY6JgU346CBuG9dcjRPmW3Fw0E34hIRE9eV+BKw
 YwVhz/eMMktrckAn0LfLwsnIsPXB951OqJLc+NDFtuDpE9OCLpO8FNvOxhi/FxQkcmndotUBG58
 14l86kZ9YBqi8tv01uFtU8S7RMgA=
X-Google-Smtp-Source: AGHT+IFi5z5fnH8BG2u+jRYH1xTrUkI8887vezK/4uwcjOxEWZjSnalD1oK952RGvlZ7fU8YtTRGHWmyw4kk0qiFreA=
X-Received: by 2002:a05:6512:159:b0:518:b283:1078 with SMTP id
 m25-20020a056512015900b00518b2831078mr2445253lfo.26.1713548318060; Fri, 19
 Apr 2024 10:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <20240416161111.0000607c@huawei.com>
 <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
 <20240418091555.00006666@Huawei.com>
 <20240418183600.00000345@huawei.com>
 <kjpkyoux2xcegrqshde5ddhicf33jnlelobuzuo4uj4svvlzdn@rilun7dz6776>
 <20240419170938.00000551@huawei.com>
 <CAMj1kXE+0mUfFq_FrhZT0m_YOJkWiuPndWt3GsRn1eMyCVrmMw@mail.gmail.com>
In-Reply-To: <CAMj1kXE+0mUfFq_FrhZT0m_YOJkWiuPndWt3GsRn1eMyCVrmMw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Apr 2024 19:38:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMT=rM=2ivrcUXEtZYEqSbTG6ZokJgDcpd4ufwYm34Xw@mail.gmail.com>
Message-ID: <CAMj1kXFMT=rM=2ivrcUXEtZYEqSbTG6ZokJgDcpd4ufwYm34Xw@mail.gmail.com>
Subject: Re: [edk2-devel] [PATCH v3 5/6] target/arm: Do memory type alignment
 check when translation disabled
To: devel@edk2.groups.io, jonathan.cameron@huawei.com
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron via <qemu-devel@nongnu.org>, linuxarm@huawei.com, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Idan Horowitz <idan.horowitz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=ardb@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Fri, 19 Apr 2024 at 18:36, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 19 Apr 2024 at 18:09, Jonathan Cameron via groups.io
> <jonathan.cameron=huawei.com@groups.io> wrote:
> >
> > On Fri, 19 Apr 2024 13:52:07 +0200
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > >   Hi,
> > >
> > > > Gerd, any ideas?  Maybe I needs something subtly different in my
> > > > edk2 build?  I've not looked at this bit of the qemu infrastructure
> > > > before - is there a document on how that image is built?
> > >
> > > There is roms/Makefile for that.
> > >
> > > make -C roms help
> > > make -C roms efi
> > >
> > > So easiest would be to just update the edk2 submodule to what you
> > > need, then rebuild.
> > >
> > > The build is handled by the roms/edk2-build.py script,
> > > with the build configuration being in roms/edk2-build.config.
> > > That is usable outside the qemu source tree too, i.e. like this:
> > >
> > >   python3 /path/to/qemu.git/roms/edk2-build.py \
> > >     --config /path/to/qemu.git/roms/edk2-build.config \
> > >     --core /path/to/edk2.git \
> > >     --match armvirt \
> > >     --silent --no-logs
> > >
> > > That'll try to place the images build in "../pc-bios", so maybe better
> > > work with a copy of the config file where you adjust this.
> > >
> > > HTH,
> > >   Gerd
> > >
> >
> > Thanks Gerd!
> >
> > So the builds are very similar via the two method...
> > However - the QEMU build sets -D CAVIUM_ERRATUM_27456=TRUE
> >
> > And that's the difference - with that set for my other builds the alignment
> > problems go away...
> >
> > Any idea why we have that set in roms/edk2-build.config?
> > Superficially it seems rather unlikely anyone cares about thunderx1
> > (if they do we need to get them some new hardware with fresh bugs)
> > bugs now and this config file was only added last year.
> >
> >
> > However, the last comment in Ard's commit message below seems
> > highly likely to be relevant!
> >
> > Chasing through Ard's patch it has the side effect of dropping
> > an override of a requirement for strict alignment.
> > So with out the errata
> > DEFINE GCC_AARCH64_CC_XIPFLAGS     = -mstrict-align -mgeneral-regs-only
> > is replaced with
> >  [BuildOptions]
> > +!if $(CAVIUM_ERRATUM_27456) == TRUE^M
> > +  GCC:*_*_AARCH64_PP_FLAGS = -DCAVIUM_ERRATUM_27456^M
> > +!else^M
> >    GCC:*_*_AARCH64_CC_XIPFLAGS ==
> > +!endif^M
> >
> > The edk2 commit that added this was the following +CC Ard.
> >
> > Given I wasn't sure of the syntax of that file I set it
> > manually to the original value and indeed it works.
> >
> >
> > commit ec54ce1f1ab41b92782b37ae59e752fff0ef9c41
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Wed Jan 4 16:51:35 2023 +0100
> >
> >     ArmVirtPkg/ArmVirtQemu: Avoid early ID map on ThunderX
> >
> >     The early ID map used by ArmVirtQemu uses ASID scoped non-global
> >     mappings, as this allows us to switch to the permanent ID map seamlessly
> >     without the need for explicit TLB maintenance.
> >
> >     However, this triggers a known erratum on ThunderX, which does not
> >     tolerate non-global mappings that are executable at EL1, as this appears
> >     to result in I-cache corruption. (Linux disables the KPTI based Meltdown
> >     mitigation on ThunderX for the same reason)
> >
> >     So work around this, by detecting the CPU implementor and part number,
> >     and proceeding without the early ID map if a ThunderX CPU is detected.
> >
> >     Note that this requires the C code to be built with strict alignment
> >     again, as we may end up executing it with the MMU and caches off.
> >
> >     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >     Acked-by: Laszlo Ersek <lersek@redhat.com>
> >     Tested-by: dann frazier <dann.frazier@canonical.com>
> >
> > Test case is
> > qemu-system-aarch64 -M virt,virtualization=true, -m 4g -cpu cortex-a76 \
> > -bios QEMU_EFI.fd -d int
> >
> > Which gets alignment faults since:
> > https://lore.kernel.org/all/20240301204110.656742-6-richard.henderson@linaro.org/
> >
> > So my feeling here is EDK2 should either have yet another config for QEMU as a host
> > or should always set the alignment without needing to pick the CAVIUM 27456 errata
> > which I suspect will get dropped soonish anyway if anyone ever cleans up
> > old errata.
> >
>
> This code was never really intended for execution at EL2, but it
> happened to work, partially because TCG's lack of strict alignment
> checking when the MMU is off.
>
> Those assumptions no longer hold, so yes, let's get this fixed properly.
>
> Given VHE and nested virt (which will likely imply VHE in practice), I
> would like to extend this functionality (i.e., the use of preliminary
> page tables in NOR flash) to EL2 as well, but with VHE enabled. This
> means we can still elide TLB maintenance (and BBM checks) by using
> different ASIDs, and otherwise, fall back to entering with the MMU off
> if VHE is not available. In that case, we should enforce strict
> alignment too, so that needs to be fixed regardless.
>
> I'll try to code something up and send it round. In the mean time,
> feel free to propose a minimal patch that reinstates the strict
> alignment if you are pressed for time, and I'll merge it right away.

Actually, let's just so that first - I'll send out a patch.

