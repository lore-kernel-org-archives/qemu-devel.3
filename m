Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B2CA6011
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xErgM-00084J-7K; Thu, 08 Oct 2026 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xErgK-00083n-Ho
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 13:13:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xErgI-00038n-I5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 13:13:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso3762402a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 10:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791479601; cv=none;
 d=google.com; s=arc-20260327;
 b=mrEp5K/417wGzIBTMQGtvfRxy3cl/pds228kJCUHm6CwGFgnsfk8afjW8+nLIelt4q
 6rJtYwiiuCmA1Ul1lPEvKzzgwx3IllTZ65HlhGwGxddQW6XZ+bBL0UfzJ9BmVU5ANpRr
 cPP+GPEMPsXa15TBcJeqBPl49D5zIAjE9sTQ6gqT8bAowvklv+Wjy8gWARC+QVo2svzJ
 6Z2Vd1CCPx4yCTkuJHztBUe7gJH1ZwfWEITm+TyxrDck5cy6zyHZOTSqVyE1Lxzz0XLs
 oE9pQ/tuySfnSfkgkfg8/FbdYuAvPMpLL+ql0XamX7DFqZiFmxhK1YW8USH9yrbsoE6h
 Wlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qHizU6jSNi8b80NXnXgXhGC92UoulxXTaBBxf0UADME=;
 fh=hZLh1xUAwZOD7mgeF+wNtnVeD7BcV+z2IlwkvfbaLEQ=;
 b=pVwxlbSYNqmbfJmD4ikCF4pyAzdiAQftsH/h4bT+dPLyzPxuAY7T3aM9lgILbXLCXI
 4xCHBiyRK3no/o7GHJ2hpa/LQzSuNDjRgsg/3wzIIEHQC7GMhuhVk4o1gV9UkQdrmkgj
 X15PXhqOSvuMJ3Fshoht+9hY03+NDy+KEzxXJ2YisYHc0Ute0IoUfidEoc7RctqMMfeq
 yMI7eUuNHYnerFiQZPbJlRVgm2iLD/d9WoZz+LwbI6/M00DpT3nnxx4cWGqZwd4CTTP7
 INd6NGr2dp0D/O0qXAV823a3eLkdC4ZyGcxzfgwUsF/g9hu3WqN2yB8hzI8bJkFtEiFI
 KjoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791479601; x=1792084401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qHizU6jSNi8b80NXnXgXhGC92UoulxXTaBBxf0UADME=;
 b=cPE3FKq8XVFCzfX6ZlYucCwbDIoAwDpFES2kn+5VMhtociUxhK5a6JaIizCEaubsbf
 M6A5G/a4C4Ar3GW9j6Tgtx7GBs8/DMzyeBLIaQQAsWui6LbXzUY1CJUFyL0tq9QjooiJ
 rxUI6pqQ8j5vVfu4DTgq8/t/vwS2lmOpgVovNRRHiHEZL+HV+k3WkqfqyXuTi1hyk73k
 eHk4Q1K7BTfVVNCxM4ASbWmuyHBdUB2IFIMxTu+VezpfzRQrT1owR1PJdZm8fjLm2Yxt
 eMipYbVrQ4XgBNl8XacSziYbX431xNlZih6pN1hV+3dxI72CYrgYogmGNbvV7zjsCA1w
 D+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791479601; x=1792084401;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qHizU6jSNi8b80NXnXgXhGC92UoulxXTaBBxf0UADME=;
 b=LBVzfelR6Ps7iWQ6tUVSWaASXqFDKitrQ74ij7G3JPvn2rCULG2I4k2KP7tmw8lGWF
 Zi4jYgAjs1OabW01FhWb/MDPo459rhZZeZUQ0HYZbNBxw0Q/z3r8RFz0wqvH7RLixDrY
 NpQ44PFrKXxDitUmuf3LVBTqsTMDGCCWFST3bznNBYN6JfXPHsf/aT0CmGElPt3YH7hL
 5LmtQmCownxbaclckrJaVX0P+4xQzQiHahNfkPRTJlb5wiMto4cESxKcHxY7JHktw+V1
 R6q5O6q07XqvmSPBlEIFcnFQ6BM7ag4AhA4RtYZGZBwOXTJFjTRdaKUaxR80ZafRWfrl
 8pwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2et0fm1RBSR5+MFpACUJNbuam2ilyjvU9knz37IJDKJ4mOkUeGWtZ1Xr18V7JyIKegDEMyMSQQQwS@nongnu.org
X-Gm-Message-State: AFq9FYK85fyzC+f6NcsJdRaPyJwEESstHDtsnr/LI8Swh0Mkn/fk1gfv
 qvESIkQYYyGUSqgTJNjKbB4uD26dvqhHXNu2ejfJAhStngDXJoTfa3AD8XgqI3040hW67dsLKHC
 UVi/ImN0u2KJ77mYjKVGAIhOxaQAJuKc=
X-Gm-Gg: AYBFou1tWnJap35Hvlq4Ia2MLqqEmyKjT81QiK4k1TOnisTmAdkGZ1MPDGs4jqVcuDc
 PzGLGyX9Afd87++hNAHX76DBoQJVApUdxx0q+BeTHIgtol+V2crolyIbLEd9ZTjqDQUU9KBzbbG
 Db1WG4UxG07819vdgQ+l4B9o1KlAZuc9I2qeAi1Y6fThieVntSuykNFJBj9KfQAzffbNWXXaIiW
 vyEbTWBqqe3Y1W4DnSl2XBl78W0eyWgUaQ+14cAJyGOSAfFWBGBJ6WiYSe5dinmiu8BBZNLewGx
 iRXkLs+zmIVs6OAhSSaxHCawH3N/foAJ/kw3hJA5abCToJYny6B6bKo=
X-Received: by 2002:a05:6402:c4e1:20b0:6b0:c1d:a7ce with SMTP id
 4fb4d7f45d1cf-6b00c1da88emr2675938a12.12.1791479600657; Thu, 08 Oct 2026
 10:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
 <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
 <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
In-Reply-To: <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2026 01:13:06 +0800
X-Gm-Features: AclHuK9csGmRw3GpXW4BwLyYvk1PCsDiAVec9g0e7PI-vvgWskxaPV32iVH4rIs
Message-ID: <CAE2XoE-gN5-vmE8r00Ds_Z=E1WePSFi_MJXjmy9ZuXEU_=o31g@mail.gmail.com>
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 9, 2026 at 12:06=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> > On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> >>
> >> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
> >>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> >>>> This allows a combined binary to register machine types from all its=
 targets.
> >>>> Consequently, QMP `query-machines` can return machine entries from e=
very
> >>>> target, even when `none` is selected. For example, a client can quer=
y the
> >>>> combined machine list with:
> >>>>
> >>>> ```json
> >>>> { "execute": "query-machines" }
> >>>> ```
> >>>>
> >>>> The returned list includes the registered machine classes from all l=
inked
> >>>> targets. This is separate from selecting a machine: with `-target no=
ne`,
> >>>> `-M virt` reports the targets that provide `virt` instead of choosin=
g one
> >>>> arbitrarily:
> >>>>
> >>>> ```text
> >>>> qemu-system -target none -M virt
> >>>> unsupported machine type: "virt" for target "none"
> >>>> Available for targets:
> >>>>   aarch64
> >>>>   arm
> >>>> ```
> >>>>
> >>>
> >>> From the long conversation on a previous thread, I thought we reached
> >>> the conclusion that if we didn't expose any ambiguous name, then -tar=
get
> >>> option is unnecessary, or maybe I got lost on track of this thread.
> >>>
> >>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
> >>>
> >>> I'm not sure which semantic we want to have with -target none. If the=
re
> >>> is no ambiguous name registered, we just don't need it at all. It's a
> >>> win-win IMHO.
> >>
> >> Yes, if we expose unique names for every machine, then -target is then
> >> redundant.
> >
> > so how to diff riscv32-virt and risv64-virt? oh so for this machine we
> > needs two name?
> > "virt" needs register twice for it? or register only a single time,
> > but we prefix the target_name()
> > automatically? for example machine::name =3D=3D=3D "virt", but we can u=
se
> > "riscv32-virt" "risv64-virt" to reach it?
> >
>
> Yes, ideally we should have different variant of virt for 32/64 bit.
> Same goes for cpu max types.
>
> QOM type is always registered unambiguously ("$arch-virt"). Then, for
> the "alias" name, which is virt, in case multiple matches are found,
> command line can return an error with list of unambiguous names to call i=
t.
>
> $ qemu-system -M virt
> Multiple virt machines are available. Please choose one of them:
> - aarch64-virt
> - riscv64-virt
>
> There is no "parsing" of the argument, it's just the real QOM type. Then
> we can find which target it implements from mc->targets.
> And then, we can automatically choose which cpus should be available
> based on that, thanks to cpu->targets.
>
> For existing binaries, nothing change.

Good, I think we found a clean way now, is_available should be
removed, and TypeInfo::targets and TypeImpl::targets should be added.
I think
for "virt" we can add a shared hw/machine-virt.c instead, and forwarding to
the $arch specific virt. so that we only have a single "virt" registered.
And it's
targets is
QEMU_ARCH_I386 |
QEMU_ARCH_ARM |
QEMU_ARCH_RISCV |
QEMU_ARCH_LOONGARCH |
QEMU_ARCH_M68K |
QEMU_ARCH_OR1K |
QEMU_ARCH_XTENSA |
QEMU_ARCH_HEXAGON

So that we won't have a list of conflict QOM names for "virt" machines.
As now we indeed have only a single "virt" machine that redirects to
different targets.


For other types also conflict can be handled in the same way, such as
"-cpu host" "-cpu max"
maybe others, but I think they all have the same way to deal with.


That's why  TypeInfo::targets and TypeImpl::targets better than sole
Machine::targets

>
> >>
> >> With regards,
> >> Daniel
> >> --
> >> |: https://berrange.com       ~~        https://hachyderm.io/@berrange=
 :|
> >> |: https://libvirt.org          ~~          https://entangle-photo.org=
 :|
> >> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com=
 :|
> >>
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

