Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E36DF45A19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 08:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBTds-0008Uf-JM; Sat, 11 Apr 2026 04:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1wBTdr-0008UX-Fq
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 04:24:35 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1wBTdp-0005UV-FT
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 04:24:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CAA4260145
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 08:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F09C2BCB1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775895863;
 bh=bqoQbqPELWRk5acf+ZyoEUs3D/b4C2lVsVH6ctZMC9Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=II3SqzEvF+aEL6T1Ktmj0vBQS9DSc2uPxqNvuP8+603V6vWSyr6/diOddLJiJrIs1
 oo12F27qxFcQjira7eoMCf4GI1T26cnuxkW2YmwWeBe8IqYwrQB4WDtaGrurozPIkt
 fssKMZcYE2OigchYXFD5BDvJjL/hSm8JSSv8WWaeBrJMqMffQV+rQP6ePE0CEq7nvz
 1aeP7YDa6GGsStwwkYgoPMsbEi976m7PcwUUEujZ2seM8JZrYgNXEq1RC9lCfraz3q
 XslLeKfMHcHZUPCDNZ56R51RQK2+YlQai2tUjoS5XHOIi788IpCbTsTLRjr2ZxQ3T8
 2l9VdXJRZtzHg==
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so468427966b.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 01:24:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUaJdgwdn4UCuKh03tn+BAMJ7MO6D7k3SFrGZtrSMIQUDS+9BpscDKD6dMq1z2wQZQeTqg1clmgxrff@nongnu.org
X-Gm-Message-State: AOJu0Yz3N7OE+mPwYKCbI7d+Plb23rcM7Zsie4jsIwbJ/0GI7fTXwZ1u
 9tnaVdOG9+adfY9Bt2pih3jjeNxYLhrICWPiKfyLltgx0XPCoabKMmEFtlo3ijB3+9Jqo2Jkc15
 KVpZYSKlusS9MnLyQTcQiDYlqJtOAkg4=
X-Received: by 2002:a17:906:2092:b0:b9d:705e:1dae with SMTP id
 a640c23a62f3a-b9d72777e58mr214554466b.45.1775895861761; Sat, 11 Apr 2026
 01:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
In-Reply-To: <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Apr 2026 16:24:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
X-Gm-Features: AQROBzDBFkqm0mDiVV5S0T1ys9AKylY71_Id4V7oF-ydWReoS3obfjTdvX-r68k
Message-ID: <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Cc: gaosong <gaosong@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu, 
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254; envelope-from=chenhuacai@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Apr 11, 2026 at 10:09=E2=80=AFAM Gyorgy Tamasi <gyorgy.tamasi@gmail=
.com> wrote:
>
> Hi,
>
> Thanks for the link of this separate Loongson-maintained 9.2-tcg-old
> branch - intended for use specifically with ABI 1.0 code.
>
> This separate branch still contains the same bug (in the context of
> the glibc-2.28-7cdc44d5a1 env of Loongson's gcc 8.3.0 rc1.6 - where
> fstatat syscall can be used by glibc, and it can trigger the usage of
> the related erroneous data-conversion workflow based on  struct
> target_stat64 with 4byte sec/nsec fields):
>
> This changeset was the last mod of syscall_defs.h - but it still
> incorrectly modifies the condition of struct target_stat64 usage:
> (~ "Add Loongarch64 old ABI support")
> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe45c2e=
864be99
> (line 2006)
> -----
> -#if !defined(TARGET_RISCV64)
> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.

Huacai

> -----
>
> This is the broader context in this 9.2-tcg-old original version:
> Here the 2nd embedded "|| defined(TARGET_LOONGARCH64)" normally a
> no-op: always true/false if the 1st "|| defined(TARGET_LOONGARCH64)"
> is true/false.
> -----
> #elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
>         || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || \
>         defined(TARGET_LOONGARCH64)
> /* These are the asm-generic versions of the stat and stat64 structures *=
/
>
> #define TARGET_STAT_HAVE_NSEC
> struct target_stat {
> ...
> };
>
> #if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> #define TARGET_HAS_STRUCT_STAT64
> struct target_stat64 {
> ...
> };
> #endif
>
> #elif defined(TARGET_HPPA)
> -----
>
> The correct fix is the same here (~ disable the use of this struct
> target_stat64 - instead of explicitly enabling it for
> TARGET_LOONGARCH64 with the "|| defined(...)" part):
> -----
> ~/qemu/qemu-9.2-tcg-old/linux-user$ diff -u syscall_defs.h.ori syscall_de=
fs.h
> --- syscall_defs.h.ori  2026-04-10 20:53:34.639034304 +0200
> +++ syscall_defs.h      2026-04-10 20:55:12.219347804 +0200
> @@ -2003,7 +2003,7 @@
>      abi_uint __unused5;
>  };
>
> -#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> +#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
>  #define TARGET_HAS_STRUCT_STAT64
>  struct target_stat64 {
>      abi_ullong st_dev;
> -----
>
> The same test-scenario of
> https://gitlab.com/qemu-project/qemu/-/work_items/3371 can be used
> [with the relevant gcc 8.3 rc1.6 & this qemu linux-user 9.2-tcg-old
> toolset] to show exactly the same bad & good test results - without &
> with this mod.
>
> Just a personal experience based side-note on ABI1.0 compatibility
> with mainline qemu (~10.2.2):
> I'm working on porting a quite large code-base (a commercial OCR &
> document conversion SDK) to LoongArch64 (for ABI1.0 and ABI2.0)...and
> I'm trying to check correctness of my actual builds using the
> regression-test package of this codebase. It runs quite complex
> workflows of general CLI code. I accept that this is not a
> comprehensive test with all of the edge cases or touching every
> special areas (like signal handling) of compatibility of ABI1.0 and
> mainline qemu, but...the ABI1.0 version of this test-code seems to be
> able to run with mainline qemu-user 10.2.2.
>
> Best regards,
> -tgy
>
> On Fri, Apr 10, 2026 at 11:37=E2=80=AFAM gaosong <gaosong@loongson.cn> wr=
ote:
> >
> > =E5=9C=A8 2026/4/9 =E4=B8=8B=E5=8D=888:14, Gyorgy Tamasi =E5=86=99=E9=
=81=93:
> > > Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> > >
> > > Additional independent testing (bug + fix cases) is documented here -
> > > see comments by sourav/@kishu279:
> > > https://gitlab.com/qemu-project/qemu/-/work_items/3371
> >
> > Hi.
> > Please note that QEMU is not compatible with ABI 1.0.
> >
> > If you absolutely must use ABI 1.0, the branch below is the version we =
use.
> > https://github.com/loongson/qemu/commits/9.2-tcg-old/
> >
> > However, this branch is quite far from the mainline.
> > The QEMU mainline follows the kernel mainline, and
> > I believe this is the case for other architectures as well.
> >
> > Thanks.
> > Song Gao
> > > On Wed, Apr 8, 2026 at 8:21=E2=80=AFPM Pierrick Bouvier
> > > <pierrick.bouvier@linaro.org> wrote:
> > >> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
> > >>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
> > >>> TARGET_LOONGARCH64 are defined!) we can not use the struct
> > >>> target_stat64 for data-transfer, since this struct target_stat64 is
> > >>> defined for 32bit environments with its int-sized (4byte) st_*time
> > >>> sec/nsec components.
> > >>> The user side compiler headers of the LoongArch64 env uses long-siz=
ed
> > >>> (8byte) st_*time sec/nsec components.
> > >>>
> > >>> (This is similar to the case of 32bit vs. 64bit RISCV: the original
> > >>> code does not use struct target_stat64 in 64bit RISCV env, when bot=
h
> > >>> TARGET_RISCV and TARGET_RISCV64 are defined.)
> > >>>
> > >>> This fix is important for LoongArch64 ABI1.0, where stat() is using=
 an
> > >>> fstatat syscall with this struct target_stat64, if its usage is
> > >>> enabled.
> > >>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where thi=
s
> > >>> problematic struct target_stat64 is not used, struct statx is corre=
ct
> > >>> in the LoongArch64 env.)
> > >>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
> > >>>
> > >>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> > >>> ---
> > >>>    linux-user/syscall_defs.h | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >

