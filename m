Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AE0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxrEi-0005zl-5W; Fri, 19 Apr 2024 12:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1rxrEf-0005zM-Jk; Fri, 19 Apr 2024 12:37:13 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1rxrEb-0007PH-Tt; Fri, 19 Apr 2024 12:37:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A9366CE1B4D;
 Fri, 19 Apr 2024 16:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DFEC32783;
 Fri, 19 Apr 2024 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713544615;
 bh=xEmo7+57RzWgUeRA1Hw9WBrxAdSuJ75zownMKbjKdaQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IA9lYGEm8FUmOBhO/3yrBXsni9iZeK7wW5O/GxQZK0zQHg5B6Zwarx9GPXFJxKUA0
 6iCEu4vK7G0nmRWXw+RvRj6mLyD1o3UfKfVqb93ZWg24wXiQqgVM4YcH0ok5umDBfQ
 jNosEy5uwLDVp7bGiRRYV9ZR5RFjVSk8T2Ih6nEMPapioBmnOfDmZDSPKX8aOiYxeh
 VxsTR/aI3ZzgGSK03lDKsi3eoeiDOboDgHPf9j01K7dCGWxDlAzcCxw7waUkGJrDAY
 GZkUG0cofJYRnzPg0s5I6ObaN6ZjV+ScEsSjm9dnZ64hvp1zglpfiD9++vTzThCOud
 1DYgppEWao95Q==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-516d68d7a8bso2133656e87.1; 
 Fri, 19 Apr 2024 09:36:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXcHXfzm/VYj8hXGlWtqZT+mUx1Ldcd30KO5vYtTaWxkzSZTR2YiF0Bq39rlIN/xEAfxpFc//XFpA+mMEQ0IH9IEXW0YXoTr3uRb3FgLYdbeQVpyYYlqldTyGk=
X-Gm-Message-State: AOJu0Yy8ikyFrXpcu4U4wI6Ca5NV4tCmThXGFRV/FIqu/0My9mdYTa5I
 kzSfdW6tseYs64ml0arN/E+tnElpv/ZcpcD5Hn9UPgHATkMMbRAlk389A7UQ2et4Z2aaf12EcWv
 WbnjVV1JBl82nodWcFzbrMBL+DLM=
X-Google-Smtp-Source: AGHT+IEXm9sbgybt/g7hFtY3tcnslbNK6rEr9BEf2v6EJyd9YvfCV7hYtaq6T1c4Fst1aViPDd2yoFQue38DOa3ziDY=
X-Received: by 2002:ac2:4651:0:b0:519:99c:9018 with SMTP id
 s17-20020ac24651000000b00519099c9018mr816835lfo.11.1713544614093; Fri, 19 Apr
 2024 09:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <20240416161111.0000607c@huawei.com>
 <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
 <20240418091555.00006666@Huawei.com>
 <20240418183600.00000345@huawei.com>
 <kjpkyoux2xcegrqshde5ddhicf33jnlelobuzuo4uj4svvlzdn@rilun7dz6776>
 <20240419170938.00000551@huawei.com>
In-Reply-To: <20240419170938.00000551@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Apr 2024 18:36:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+0mUfFq_FrhZT0m_YOJkWiuPndWt3GsRn1eMyCVrmMw@mail.gmail.com>
Message-ID: <CAMj1kXE+0mUfFq_FrhZT0m_YOJkWiuPndWt3GsRn1eMyCVrmMw@mail.gmail.com>
Subject: Re: [edk2-devel] [PATCH v3 5/6] target/arm: Do memory type alignment
 check when translation disabled
To: devel@edk2.groups.io, jonathan.cameron@huawei.com
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron via <qemu-devel@nongnu.org>, linuxarm@huawei.com, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Idan Horowitz <idan.horowitz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=145.40.73.55; envelope-from=ardb@kernel.org;
 helo=sin.source.kernel.org
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

On Fri, 19 Apr 2024 at 18:09, Jonathan Cameron via groups.io
<jonathan.cameron=huawei.com@groups.io> wrote:
>
> On Fri, 19 Apr 2024 13:52:07 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> >   Hi,
> >
> > > Gerd, any ideas?  Maybe I needs something subtly different in my
> > > edk2 build?  I've not looked at this bit of the qemu infrastructure
> > > before - is there a document on how that image is built?
> >
> > There is roms/Makefile for that.
> >
> > make -C roms help
> > make -C roms efi
> >
> > So easiest would be to just update the edk2 submodule to what you
> > need, then rebuild.
> >
> > The build is handled by the roms/edk2-build.py script,
> > with the build configuration being in roms/edk2-build.config.
> > That is usable outside the qemu source tree too, i.e. like this:
> >
> >   python3 /path/to/qemu.git/roms/edk2-build.py \
> >     --config /path/to/qemu.git/roms/edk2-build.config \
> >     --core /path/to/edk2.git \
> >     --match armvirt \
> >     --silent --no-logs
> >
> > That'll try to place the images build in "../pc-bios", so maybe better
> > work with a copy of the config file where you adjust this.
> >
> > HTH,
> >   Gerd
> >
>
> Thanks Gerd!
>
> So the builds are very similar via the two method...
> However - the QEMU build sets -D CAVIUM_ERRATUM_27456=TRUE
>
> And that's the difference - with that set for my other builds the alignment
> problems go away...
>
> Any idea why we have that set in roms/edk2-build.config?
> Superficially it seems rather unlikely anyone cares about thunderx1
> (if they do we need to get them some new hardware with fresh bugs)
> bugs now and this config file was only added last year.
>
>
> However, the last comment in Ard's commit message below seems
> highly likely to be relevant!
>
> Chasing through Ard's patch it has the side effect of dropping
> an override of a requirement for strict alignment.
> So with out the errata
> DEFINE GCC_AARCH64_CC_XIPFLAGS     = -mstrict-align -mgeneral-regs-only
> is replaced with
>  [BuildOptions]
> +!if $(CAVIUM_ERRATUM_27456) == TRUE^M
> +  GCC:*_*_AARCH64_PP_FLAGS = -DCAVIUM_ERRATUM_27456^M
> +!else^M
>    GCC:*_*_AARCH64_CC_XIPFLAGS ==
> +!endif^M
>
> The edk2 commit that added this was the following +CC Ard.
>
> Given I wasn't sure of the syntax of that file I set it
> manually to the original value and indeed it works.
>
>
> commit ec54ce1f1ab41b92782b37ae59e752fff0ef9c41
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Wed Jan 4 16:51:35 2023 +0100
>
>     ArmVirtPkg/ArmVirtQemu: Avoid early ID map on ThunderX
>
>     The early ID map used by ArmVirtQemu uses ASID scoped non-global
>     mappings, as this allows us to switch to the permanent ID map seamlessly
>     without the need for explicit TLB maintenance.
>
>     However, this triggers a known erratum on ThunderX, which does not
>     tolerate non-global mappings that are executable at EL1, as this appears
>     to result in I-cache corruption. (Linux disables the KPTI based Meltdown
>     mitigation on ThunderX for the same reason)
>
>     So work around this, by detecting the CPU implementor and part number,
>     and proceeding without the early ID map if a ThunderX CPU is detected.
>
>     Note that this requires the C code to be built with strict alignment
>     again, as we may end up executing it with the MMU and caches off.
>
>     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>     Acked-by: Laszlo Ersek <lersek@redhat.com>
>     Tested-by: dann frazier <dann.frazier@canonical.com>
>
> Test case is
> qemu-system-aarch64 -M virt,virtualization=true, -m 4g -cpu cortex-a76 \
> -bios QEMU_EFI.fd -d int
>
> Which gets alignment faults since:
> https://lore.kernel.org/all/20240301204110.656742-6-richard.henderson@linaro.org/
>
> So my feeling here is EDK2 should either have yet another config for QEMU as a host
> or should always set the alignment without needing to pick the CAVIUM 27456 errata
> which I suspect will get dropped soonish anyway if anyone ever cleans up
> old errata.
>

This code was never really intended for execution at EL2, but it
happened to work, partially because TCG's lack of strict alignment
checking when the MMU is off.

Those assumptions no longer hold, so yes, let's get this fixed properly.

Given VHE and nested virt (which will likely imply VHE in practice), I
would like to extend this functionality (i.e., the use of preliminary
page tables in NOR flash) to EL2 as well, but with VHE enabled. This
means we can still elide TLB maintenance (and BBM checks) by using
different ASIDs, and otherwise, fall back to entering with the MMU off
if VHE is not available. In that case, we should enforce strict
alignment too, so that needs to be fixed regardless.

I'll try to code something up and send it round. In the mean time,
feel free to propose a minimal patch that reinstates the strict
alignment if you are pressed for time, and I'll merge it right away.

