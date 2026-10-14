Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A4CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGwXg-0006he-RZ; Wed, 14 Oct 2026 06:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGwXe-0006hN-Fc
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 06:49:02 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGwXc-0000zY-LW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 06:49:02 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so6010643a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791974939; cv=none;
 d=google.com; s=arc-20260327;
 b=NfHWrXT8Qz2VdEGdF7mL7GXpwQY6qpmxoCR11WAM5uPm7jTNo8FwLc1C6XJEtCLBkX
 YoRRmqaiYFwUGWFMsPTciT+mwRoI+Hgo2g/dpaK1XuqEdiG+2THV7N3FEscEkBsE5ETA
 QMZn7m0gaHH+vhPs+9qsbF1G779YiU+9ISQOP86qDkFv6xnjiGzO0wqspRMV0o6bJiAL
 m2u+7auJN7IodOVcdEYaMnCJhPfAaqRt0+TMH5pAYycIduc/9nDj7QPyAe/4c/lvmwK5
 BneMhJhGSwQ7pAPf93/s5GMBe/T86zzeDskWx8/5ijg34z1cKdTWJaI6YesgJ4ywS3H1
 MaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Vm4UdWBLGMY1/33zteiFmhB7a2Bd38ynxMbjpAoT3XQ=;
 fh=F+oCjl8UPsyR0d3O50sTkoVJ0qNANg8HwyOTMRSEVSc=;
 b=lOpRxtOOkhzO1F6fVfoDm3U2+w6amfeHu9whmBVYyK+fdkd5bQ/60HeDW9zx/lyL4B
 RXAqDQABT69MeVdGvJZNiuK4kpP+ufwQo36iNcP9AcaRaoE1NvlPwouxXC7gcJtFYLqs
 SsWF4oB6DjackhC+XqySYmq+/dzeYVtr4l8klSunXzBK5ciqrleGfRhE65j+u23arHft
 DxpZe8+TTsN/TyG5tyzwnJ4GBN14ky3c5jWks6MVLYO8EV34/B4vRMkNIZMvrEMZD6cU
 KdvPma624bTcZ5imWIA9u0VbrhthBhDxvWcgaF+j13IYZS7cJPTjztio10MT5rN0+k9v
 0yYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791974939; x=1792579739; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vm4UdWBLGMY1/33zteiFmhB7a2Bd38ynxMbjpAoT3XQ=;
 b=dhmOeUn98u18Ozv6JjCQkWnOhHHL31N1FNiZCN3jR/CvfNgdAdUB79OazvNbw5XPsP
 +U8MvWQcPeC9u6J+WxoKBPU9tWhkh+4lnCzMYnbl1znimcI+1YASWATJ2qWTiVRfbWxm
 i7vRMssoyiWcedPyEyOvSbVYJ3wbPVzQUhhDMbkkoCM4/dkHE987vn7bWeI4F9GHJ+AO
 3sWrp491NYwXh1jgU7g2pZoCCET5bFhrkzu7tFoO468TzBPJpuL/Dsms64lKtizRIpbN
 dUdqC+4ElLH0ItGdXRtx2qwRcndLhnsWjkfrxxuv4wONR8gOrQ5CQjyXp8jyBucY6xpM
 puvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791974939; x=1792579739;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vm4UdWBLGMY1/33zteiFmhB7a2Bd38ynxMbjpAoT3XQ=;
 b=FE1pijse3KXfG6u7V/SHdf0vKUNZt3JlXQDzAcyUQK3oKf+Y8YXsqk1vrYSxcUyPYN
 T9LySfMiEIuZvVpA/KcHgD8ahxY0k2wh6TaVig9c/oKpNGmcTaxQDWy7zTEPBvIJ7vlw
 kzeY/UUI7kqm0PlAZZi/7vrN80/Zd6U5Xv97XYEPrVEXX1G0e2crkE5iozJT59IbW4t/
 d4ebVJ/xQ+Yj/AM3gFh8y/SQJ+Ljuf63BkteBm6CqVBLP+0HHLav1W8HU7bVMYIlA7nE
 5bTeCcUn6XTfnLdqwTeDhwkjd64ekoo1t24AV8XG35wjJrE5rvam0n7jmWhUwSpHWWaa
 f37g==
X-Forwarded-Encrypted: i=1;
 AKwUvByyphMIVetDqj1XZZcExoCFoCGAaRkb5ahN7cZiVgkAzZoLPbKLubCP+b6xDnR1Wl52a0w10Xp/PUNq@nongnu.org
X-Gm-Message-State: AFq9FYI6n5bP51qln1M1i26E8buP8uj0OqCX/l0h5IlcaS7K5PRPnG2W
 /dn6Y1quFiGnPo1/oTFB4Os6sUtNsQyS8AH2zoGh7kXTWdJLcOi009+teQe31bUCRsjtbTvwPE+
 1j7Ux+uoSSJdlm/E1frq4A55ozWaJIhkAT/0U+Ek=
X-Gm-Gg: AYBFou27toJhyJPQ4fpJMxHxgmAaGqjjgsx5FffhbChD9su7bF+3/4nkIMf9bYwm0WK
 3O6yG8gv5LE3VIlK8mzNkSJK+3uUaTwErijUZiIlWEkytXSZwh+qTe5vS90q5uPlOlMt4I+HAXb
 ePuevXktIQZh597FMfKZEfT8qnc1MJAxTjm9ETrbT2J1++d37bcc6zL5BihtdDSlz6yvo7bVfIX
 i9RrAdJTCDlA3P0u0Bd3FVW86q3q+0asqHB6KuTyqlTgXK5j+koKlls2+t4Bp8KDxU2DXK845f3
 0+CA320fdn5NgsRjXMyUKZgrVnsIQPV0uMmPjvzvZdoQtr7NJfbGIoo=
X-Received: by 2002:a05:6402:44da:b0:6af:8022:ffe4 with SMTP id
 4fb4d7f45d1cf-6b17c2b5870mr9690638a12.38.1791974938747; Wed, 14 Oct 2026
 03:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261014093152.834-1-luoyonggang@gmail.com>
 <20261014093152.834-6-luoyonggang@gmail.com>
 <e09a64d3-7632-4f90-bd69-0c6097f8cd78@oss.qualcomm.com>
 <as9ZvlmXQUwvm0vz@redhat.com>
 <5d86e4c0-43b3-475b-b135-29b9d685d13b@oss.qualcomm.com>
In-Reply-To: <5d86e4c0-43b3-475b-b135-29b9d685d13b@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 18:48:46 +0800
X-Gm-Features: AclHuK9uPxvtfRhW7ESLgpVV_cu6gA6XspSKH1AK2-K599jdYaeO_JC3w74U-Vw
Message-ID: <CAE2XoE9uPmQUDNUubFZ7v+E=++PDEmNTz7LXVpzHB-EdrJipfQ@mail.gmail.com>
Subject: Re: [PATCH 05/34] qapi: add missing Linux user-mode targets to
 EmuTarget
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@kernel.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 qemu-arm@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 6:45=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 14/10/26 12:30, Daniel P. Berrang=C3=83=C2=A9 wrote:
> > On Wed, Oct 14, 2026 at 12:24:57PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> On 14/10/26 11:31, Yonggang Luo wrote:
> >>> This usermode targets:
> >>> aarch64_be
> >>> armeb
> >>> microblazeel
> >>> mipsn32
> >>> mipsn32el
> >>> ppc64le
> >>> sparc32plus
> >>> are not in machine.json
> >>>
> >>> This is a prepare for directly using TARGET_ARCH_VARIANT latter.
> >>>
> >>> Also get target-info.c to be compatible with future TARGET_ARCH_VARIA=
NT only usage.
> >>> So that we can define TARGET_ARCH_VARIANT to target_name directly
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>    include/qemu/base-arch-defs.h | 13 +++++++++++++
> >>>    qapi/machine.json             | 25 +++++++++++++------------
> >>>    target-info.c                 | 26 +++++++++-----------------
> >>>    3 files changed, 35 insertions(+), 29 deletions(-)
> >>
> >>
> >>> diff --git a/qapi/machine.json b/qapi/machine.json
> >>> index 07fac4f0764..a3d6e08a847 100644
> >>> --- a/qapi/machine.json
> >>> +++ b/qapi/machine.json
> >>> @@ -15,11 +15,10 @@
> >>>    ##
> >>>    # @EmuTarget:
> >>> -#     The comprehensive enumeration of QEMU system emulation
> >>> -#     ("softmmu") targets.  Run "./configure --help" in the project
> >>> -#     root directory, and look for the \*-softmmu targets near the
> >>> -#     "--target-list" option.  The individual target constants are n=
ot
> >>> -#     documented here, for the time being.
> >>> +#     The comprehensive enumeration of QEMU system and user-mode
> >>> +#     emulation targets.  Run "./configure --help" in the project ro=
ot
> >>> +#     directory, and look for the targets near the "--target-list"
> >>> +#     option.  Individual target constants are not documented here.
> >>>    #
> >>>    # @rx: since 5.0
> >>>    #
> >>> @@ -30,17 +29,19 @@
> >>>    # @hexagon: since 11.0
> >>>    #
> >>>    # .. note:: The resulting QMP strings can be appended to the
> >>> -#    "qemu-system-" prefix to produce the corresponding QEMU
> >>> -#    executable name.  This is true even for "qemu-system-x86_64".
> >>> +#    "qemu-system-" prefix for system emulation, or the "qemu-" pref=
ix
> >>> +#    for user-mode emulation, to produce the corresponding executabl=
e
> >>> +#    name, where that target supports the respective emulation mode.
> >>>    #
> >>>    # Since: 3.0
> >>>    ##
> >>>    { 'enum' : 'EmuTarget',
> >>> -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i=
386',
> >>> -             'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
> >>> -             'mips64el', 'mipsel', 'or1k', 'ppc',
> >>> -             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> >>> -             'sh4eb', 'sparc', 'sparc64', 'tricore',
> >>> +  'data' : [ 'aarch64', 'aarch64_be', 'alpha', 'arm', 'armeb', 'avr'=
,
> >>> +             'hexagon', 'hppa', 'i386', 'loongarch64', 'm68k', 'micr=
oblaze',
> >>> +             'microblazeel', 'mips', 'mips64', 'mips64el', 'mipsel',
> >>> +             'mipsn32', 'mipsn32el', 'or1k', 'ppc', 'ppc64', 'ppc64l=
e',
> >>> +             'riscv32', 'riscv64', 'rx', 's390x', 'sh4', 'sh4eb', 's=
parc',
> >>> +             'sparc32plus', 'sparc64', 'tricore',
> >>>                 'x86_64', 'xtensa', 'xtensaeb' ] }
> >>
> >> 'machine.json' is for system binaries.
> >>
> >> If we want to expose these QAPI types to the user binaries
> >> (I'm not sure we want...) then this declaration block should
> >> be moved in another {qapi}.json file. QAPI types are versioned,
> >> so we'd need some "  @aarch64_be   # Since v13.0" comments.
> >>
> >> Anyway I doubt we want to alter EmuTarget, I'd rather let it
> >> die as a legacy field, and expose {arch, wordsize, endianness}
> >> to management layer if this is important to consume.
> >
> > Libvirt uses query-target so we don't want that data to go away.
> > If we want to expose other data alongside the target name that's
> > fine.
>
> I'm not suggesting to change 'query-target' format; the opposite...
> If we are going to add 'query-targets' (the plural form) then we
> should report something more useful like {arch, wordsize, endianness}
> but not that EmuTarget type which I consider legacy.

I think it should be moved to qapi.json. As I needed it, do you have a bett=
er
way to have an enum for mapping target-name to that enum?


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

