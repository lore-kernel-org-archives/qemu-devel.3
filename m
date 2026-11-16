Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB890606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XS4yi2uX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSlcM-0008Sv-3B; Sun, 15 Nov 2026 20:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xSlcK-0008SO-4v
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 20:34:44 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xSlcI-0000KP-34
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 20:34:43 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67db5e13b0cso431297d50.3
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 17:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794792880; cv=none;
 d=google.com; s=arc-20260327;
 b=OLxCXyg8CGPKQcJxBXxSYyuWIX8Er3mPaVjjjpuMBzEAjCeEeR0zyPmu6kxZm70soW
 L8rkQ6b8VThhfqmyUPH+zzTARCtBSCQBp7QWL10RHMck2jmx4vVCq5wV8FxdRCMYHIWE
 /gPpu39Iug25nE3RynR4Fp7YiyuvGXQ+lmT4dMl2886uuhUiGjEA76WFo2Iy2VJ5y3G4
 N+pQABPvpy+0pbYqcsUS4mH25LYLdp0oBbJZNTUbSn96M7eUU77VwbS7e8KBUkMCioMX
 1uo1CqUWWJm4fIzqsoHdwkDi+g8SmQVdVRWUK/tYpj4FDU1AN/MnLuruPlOm6hUBXdWY
 qM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NsotAsNbi9b3GR2y0eDTtWttl8CLz1tk+jmPihOFLU0=;
 fh=+fgCq3kvB7YxezhfavlPQTuMgPjCaNHeAfq5hiOYvPY=;
 b=hsXvyjj1oVSWmrMxmrtHAKgJ7o9Ld8dC5CYTTuqDhJCXidFDh7jrV+/tyEuZ0VO0GG
 nwbDcKXyLpt5lmaQO+d6ZpODuriwK6w/KvTQWWdG+QPKPNXPlralQDQXuIIde2+WCrKQ
 z+Ft1HHHiabBeNy8pUXhBDPykzoZLIGfVHTaMTSpmjP0hT55hOJ7utJ3a5uoEf9S3HR1
 70um91l6oSjjoqZqIHRbxoyZzRwxx2YETA+6D7CVPJeGPiZxKXMt2BLh6WElU/GlJyoZ
 0EOGKpPHxSLR0IruutQbfUfLykidDDwzwUBKZSWzV+0w2HNr09sQPZGtwS81E7Niu0Os
 QvOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794792880; x=1795397680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NsotAsNbi9b3GR2y0eDTtWttl8CLz1tk+jmPihOFLU0=;
 b=XS4yi2uXyFEsQO2l2OmcUfpggJwVzaXS5leCvCxxCoeKegcoIUDAbWhMGP9blT2fs4
 +hJkPUtuDxlv2h8Go2Pl1MvUuZ8L0qhx8OujSTaEesFplsvJR3MaMJFCoBIH3EbcBdsS
 HujNaRUli7Mxc3e8htFf/gXniR8+oYvHZ5/evD9mxpj75Ljub5zyM1G2rUmRcetaGP4Q
 4R+ms35nNUF+9j1ab3jKD5yAqd/yXRRtayD/rFnTYQ7tnfH8K48i0jQ7GbHCvu2VeLtH
 DxTAmWeXY3nI+LawbJIJM+RN/PpQnrzxLUEQfgEdSDdh9dYz91HLC4MvcGlg0onutEzc
 kGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794792880; x=1795397680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NsotAsNbi9b3GR2y0eDTtWttl8CLz1tk+jmPihOFLU0=;
 b=Yw1GBrbzf6tVAf2kdSgVlirCapyDwKgEbbQDrW+PeS4BkWyL2aOnHkN39hZM97YSpB
 SlqhiCIG1A2fiESL1vFDwmTdVgTJ2U2NPtm0+o9jTqYFVl9JRIN4R3QA80IH9+KEj09z
 O+ZDXtcibc7mUyMz1pPt1X1eMjvEDOUzs1X3GQXc1ToCfrnSP503HqJQzosa+nYvju/C
 Ip7/NBrvTIx//RWzvT6lffpvlbVIGadvqrFIf7CdtE34zFUQ2y7fmcFlc1jwQYLGVNYK
 RN/4MtUKUJ2plApdmml6FJoklEJcIav4MpXgCrTK+7Pfg/yEqYDa+GbOE4E++N8oOJ2X
 1n/w==
X-Gm-Message-State: APuU4Z8zqKEeNj51oG+Shht289ykjzv+Xb7ujkYtgV3nhTP+/jNJGrjB
 psU6bJ9itkVyCXosfc0ddWt5tB7Nqqurm4bVP4Y1r6jSkzIOyB/7QSCU7asgdi94GSyC/EtEl7A
 c84tcfAJ3qR4iZfkez1utWvKSOzc4GQM=
X-Gm-Gg: AZFdTZfAseDYVByzpc6xhzM9VV/k+lDIvzagKZmdvoOt5byVc2q108RsavZMJTWdGri
 FAg566IwLhAZyGp59FGT0Sf4MdLAARY8ynVOIrAoTF0qw0mkQUfAiajiMHBLMOcEpkPZ9hDt4u+
 LadTRrFC0xzpHcesLl8KVkvX+px8o/b09Uy+2gtq+1q9cquJJ8LcWLd8tdf3+eyA8+X5sb+rpaq
 WocY3Z2xF4dNIKhqWSMS1UdSiObCgdWmWIhkQ7NDR4dHXST8cQsogSldVOZkmetJumAiVAcuRdZ
 l25jgoZy4DWmKYvLdmYOz+wJKNZHWSdlvIwd6q8L8emSOJsQ0nzkE6lxRYLc0fGkOsg0iIV8lUf
 10+R/ZVX0OifNnyTpYTz1G4a/Z74H5jiieVkmTHTD/z543Tgi3V68VP7/15DZa4J2W7eVF/Ny2u
 nW
X-Received: by 2002:a05:690e:47c9:10b0:67b:f324:f86a with SMTP id
 956f58d0204a3-67d895e6285mr2854311d50.25.1794792880232; Sun, 15 Nov 2026
 17:34:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108120034.1755008-1-bin.meng@processmission.com>
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 16 Nov 2026 09:34:29 +0800
X-Gm-Features: AclHuK-1o9Fc-g6b0oyp8LBHx96HNYc1Q2DaAbGqibwvLks1AZdR85ElPNjD3Tw
Message-ID: <CAEUhbmWFfi+ycKbN5SiKbtUyrygTXY0O3KnXG4yGngZ=iyGr_g@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] target/ppc: Correct Freescale Book E CPU models
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 8:04=E2=80=AFPM Bin Meng <bin.meng@processmission.co=
m> wrote:
>
> This series corrects SPR access, cache and MMU configuration, and
> instruction availability in the Freescale Book E CPU models. It also
> fixes host PVR matching and adds system TCG tests for e500mc, e5500
> and e6500.
>
> The patches are grouped as follows:
>
> - patch #1-#3 and #5, bug fixes to PIR write access, the MAS5 SPR number
>   and cache block/line sizes (qemu-stable cc'ed)
> - patch #4 and #6, complete e500mc/e5500 L1 cache configuration and
>   remove redundant e6500 cache geometry bits
> - patch #7-#11, register the missing cache, MMU-assist and several
>   control SPRs
> - patch #12-#14, split the PowerISA 2.05 instructions into integer and
>   floating-point groups, due to differences seen on e500 series cores
> - patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
>   comparison and parity results, and FPSCR field-mask handling
> - patch #18-#21, complete the e500 family MMU configuration, correct
>   PID register counts and express MMUCFG/TLBnCFG with named fields
> - patch #22-#23, fix EPCR write width and host PVR revision matching
>   for Book E KVM
>
> Changes in v3:
> - Cover the new system test directories in MAINTAINERS
> - Add the missing SPDX license identifier to the README
> - target/ppc: Build e6500 MMUCFG values from field encodings
> - target/ppc: Complete MMU configuration for e500 family cores
> - target/ppc: Limit e500mc and e5500 to one PID register
> - target/ppc: Express e6500 TLB configuration with named fields
> - target/ppc: Keep embedded processor control within 32 bits
> - target/ppc: Match e500mc/e5500/e6500 host PVR revisions
>
> Changes in v2:
> - Group ISA 2.05 features into integer and floating-point flags
> - Use the first free bit for the floating-point group
> - Align flag definitions and comment endings
> - Enable the shared ISA 2.05 integer flag on e5500 and e6500
> - Align the FPSCR W/L behavior flag comment ending
> - Rebase the PPC64 test entry onto the Meson variable cleanup
>
> Bin Meng (23):
>   target/ppc: Correct PIR write access on e500 cores
>   target/ppc: Correct the MAS5 SPR number
>   target/ppc: Correct the e500mc and e5500 cache block size fields
>   target/ppc: Complete e500mc and e5500 L1 cache configuration
>   target/ppc: Correct cache line size for e6500
>   target/ppc: Drop redundant e6500 L1 cache geometry bits
>   target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
>   target/ppc: Register L2CFG0 and L2CSR1 on e500mc and e5500
>   target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
>   target/ppc: Register PWRMGTCR0 on e6500
>   target/ppc: Register IVOR42 on e6500
>   target/ppc: Split the ISA 2.05 instruction feature group
>   target/ppc: Enable byte comparison and parity on e5500 and e6500
>   target/ppc: Ignore FPSCR W/L fields on e500mc, e5500 and e6500
>   tests/tcg/ppc: Add Book E illegal instruction tests
>   tests/tcg/ppc: Test byte comparison and parity on e5500/e6500
>   tests/tcg/ppc: Test FPSCR W/L handling on e500mc/e5500/e6500
>   target/ppc: Build e6500 MMUCFG values from field encodings
>   target/ppc: Complete MMU configuration for e500 family cores
>   target/ppc: Limit e500mc and e5500 to one PID register
>   target/ppc: Express e6500 TLB configuration with named fields
>   target/ppc: Keep embedded processor control within 32 bits
>   target/ppc: Match e500mc/e5500/e6500 host PVR revisions
>
>  MAINTAINERS                                |  2 +-
>  target/ppc/cpu.h                           | 45 ++++++----
>  target/ppc/cpu_init.h                      |  3 +-
>  target/ppc/cpu_init.c                      | 99 +++++++++++++++++-----
>  target/ppc/translate.c                     | 10 ++-
>  target/ppc/translate/fixedpoint-impl.c.inc |  6 +-
>  target/ppc/translate/fp-impl.c.inc         | 14 ++-
>  target/ppc/translate/fp-ops.c.inc          |  9 +-
>  meson_options.txt                          |  4 +
>  scripts/meson-buildoptions.sh              |  2 +
>  tests/tcg/meson.build                      |  1 +
>  tests/tcg/ppc/meson.build                  |  5 ++
>  tests/tcg/ppc/system/README                | 24 ++++++
>  tests/tcg/ppc/system/boot.S                | 92 ++++++++++++++++++++
>  tests/tcg/ppc/system/byte-parity.S         | 33 ++++++++
>  tests/tcg/ppc/system/fpscr.S               | 75 ++++++++++++++++
>  tests/tcg/ppc/system/isa.out               |  1 +
>  tests/tcg/ppc/system/kernel.ld             | 18 ++++
>  tests/tcg/ppc/system/macros.inc            | 56 ++++++++++++
>  tests/tcg/ppc/system/meson.build           | 39 +++++++++
>  tests/tcg/ppc/system/unsupported.S         | 31 +++++++
>  tests/tcg/ppc64/meson.build                |  2 +
>  tests/tcg/ppc64/system/meson.build         | 33 ++++++++
>  23 files changed, 554 insertions(+), 50 deletions(-)
>  create mode 100644 tests/tcg/ppc/meson.build
>  create mode 100644 tests/tcg/ppc/system/README
>  create mode 100644 tests/tcg/ppc/system/boot.S
>  create mode 100644 tests/tcg/ppc/system/byte-parity.S
>  create mode 100644 tests/tcg/ppc/system/fpscr.S
>  create mode 100644 tests/tcg/ppc/system/isa.out
>  create mode 100644 tests/tcg/ppc/system/kernel.ld
>  create mode 100644 tests/tcg/ppc/system/macros.inc
>  create mode 100644 tests/tcg/ppc/system/meson.build
>  create mode 100644 tests/tcg/ppc/system/unsupported.S
>  create mode 100644 tests/tcg/ppc64/system/meson.build
>
> ---

Ping for review?

