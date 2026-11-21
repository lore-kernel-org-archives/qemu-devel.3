Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A07606A681
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifeYVkzh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUsgw-0004Mh-F5; Sat, 21 Nov 2026 16:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUsgu-0004MC-RG
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 16:32:12 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUsgs-0003KI-Sb
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 16:32:12 -0500
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-92106d5371dso25359286d6.1
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 13:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795296729; cv=none;
 d=google.com; s=arc-20260327;
 b=hj6dN0OTvE+QgLBIF+19ZYdMAr4ssrkBmLeF4nApMrHNV+5MGjNNvDDLZyE17tWonR
 YN0LuB4L/IA4VI1QuB0eRb2FI+IQ+aH+bn7D7OFT2Qw/Ql6VAsPatscdMEYjS96ZGmFp
 +7VyEwzGbG7CetkghfU4LrsWKN7GjH1P08bpY5qXRWYBUxNrHB20MjyAQRVZ2eSaOJAc
 B8lFZgfijZ0HtBBQxpFUR1PJWxdCJsIVranaAJM7zdEthZ+HrH2SrxEuof5FAcZ2sIdC
 ez/ZfH2GdButyJgBWj0G3OxiOvrh8HvlafeGlT1h46aYPdMCXXqBwgqqgzNoKORamlio
 CcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iwEREc2iV/sJ/aK1NASNvmtJjk9qKty843oHVWMgqI8=;
 fh=03AmPWFaHef3r0pr6lywoT+NsG/gfH+n4yTbB9xciVM=;
 b=qdCKeh4Ab0e5RuQRXAhGRdX647VUFgMp7vWUVdz0wbkWnDQ2TNUloHXMe3NaQ+pkk7
 7eXmPyIZKdO+jwXmACH3n7uTQ7OXq50sLNF0szyIwqVW+ep7tXqBNKa61Yd1Y1hZl6X9
 jJsvZHga1O1s7UPNqv3EjfQlGrwVjk5YeA7/zqGTrI5XnUH3jEkr8+mC6h1gmHlcPjSm
 CjzhkNSW+bxjk5gTOP5DHJM147Renod0nlV9kxJoWMIz7+6eivaDrmFDzkBw2bJObAYg
 t6oa/+9DZF2SFPORSNEYx3VWAU2AovJDNXgyd9CR5ZFY1pcgsAN+KfDtFwL8NMj4EeAc
 PG/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795296729; x=1795901529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iwEREc2iV/sJ/aK1NASNvmtJjk9qKty843oHVWMgqI8=;
 b=ifeYVkzhHcxsx0fzS3unB2MV0nIxQTaN7y5z7XIhv5H+J3WPHLPp7PBDuhsqhm3vPT
 cXfIHeh0t38dimG368ZcjLXLN7C9k/N8vakNME/OCIijxzo1sBWEJ7xgJ9XuJiNsSKHO
 p/z9KP8Vh3Nb3XdrXdA9QWr1OwOLsMNiQHQNHlAgOjgB7wHL3mHudHb5zZFK/PGu+w8n
 kojKB2rlInfr/XCovyreJ4HifUI/cDq7kbsJQq7pYjANOIB1e1c0gtu7GrUTVeDaF6Lf
 I3JuO+RcnqCTTsu+CiuMJ+d9Ls7uiVD+dhJl0esWc8eHd5VE6O4dtqrp7I7weRy0Yw+C
 0xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795296729; x=1795901529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iwEREc2iV/sJ/aK1NASNvmtJjk9qKty843oHVWMgqI8=;
 b=0OEM4MWqxlcQpPv42sBzgiS3XJOL18hZ66m8tesfnemviSh9bwv+iD5tthMVdCCiQl
 ON58WEk4IIIp/v5cZEWSiHCE92DVmwrwO5YFfJ8pJQo+MpR4oMM5bUpYAzowsTIupAVS
 GLuAGR+0lSSGQIouIPCo4M2lGSKe/6Es/1+YxjYbWg3/K8rK4HlZyVEAlCab1eIdTJ8D
 9Y8tlNrs8oLsnFYaREKFa9pUJewKuxs5eIhkh+WlJPzUTo7HHcEjUQOV6UozRQsuFYKI
 BJY+4JQKK25QkCMGlPyyvnmnUIOA0Qn2qDi+SZEOwBFok/Y/GIUHApVanL8jwSWxxRDi
 Mtkg==
X-Gm-Message-State: APuU4Z8Z/A6m0Xqv6T9/L9d/vVJQq46jgj8qEhw+gpZDd1eifT2fQcqS
 DreUJzZR2UlEYXe5Z//qTLG5BMQgqOUtuKgk+Xu1hgOJ9DHq3BQev3zo0momj49lMm33iesd+wo
 D6JFPW0dXmKy/3S/NJ8tklPUWgFO1wPY=
X-Gm-Gg: AZFdTZf7hECNMEOpv4geNFbVwU15JcfAce5hBZhq4Ji0vDx1rqCVN5FkbtOKRe/nl2c
 H1SEXXVRLeTo5Md6OmGNExm8ak77oe3tlfwiI1AWCPZWRE6Uo4oPIX+YRokzMh+s7821KhGXayJ
 7H6bSzn4hEMITYNBO33tA9dYz2rYn5MGjsTH3dG7WghC9yo6iz/TN2DoJuxKRmGXpOSqncuEY+a
 oDSQ7Qsv5SFPm0aZ8TnRcHDTX7SGLkH6C8FdDSTdh+9Z9b6peizFM7EiSK7a/bVI/0ensmWsmRT
 /n8GMVep0ge9VrXz381I5+lxXx53BomAKA/TYGWZrQxQaxkNFtnBsDHHwy5GEhD9zLxXV5rT+Rz
 FV3tBrYh/Xd66549lJv5E7xTGkJydKfhBIzxbiBSNw5ykTlqGtND8X3d/WcXT3FT4DvocUQjAKO
 O3cVsh9lJb7661/g==
X-Received: by 2002:ad4:41c9:0:b0:921:3439:58d4 with SMTP id
 6a1803df08f44-921343963ebmr94162156d6.36.1795296729369; Sat, 21 Nov 2026
 13:32:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120104431.733136-1-mdspan.github@gmail.com>
 <20261120104431.733136-4-mdspan.github@gmail.com>
 <e4159fa3-e122-43f7-8ce3-e108ce8dcbf9@linaro.org>
In-Reply-To: <e4159fa3-e122-43f7-8ce3-e108ce8dcbf9@linaro.org>
From: mdspan <mdspan.github@gmail.com>
Date: Sat, 21 Nov 2026 15:31:58 -0600
X-Gm-Features: Aa3M54oLtzvYmYd5HUhkfSGKjxrPUUySM9tE2GeXOuqZgTPOf0zkfaTEYnUxS4M
Message-ID: <CALU8FV_p8we36GXdsMB5QR3LO2VfKwiTZ68gAKb37Q5UrXK+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] target/i386: use separate MMU indexes for
 instruction fetch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=mdspan.github@gmail.com; helo=mail-qv1-xf41.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yes, that seems like a more logical approach. I'll do that in v3.
Masking only changes 64-bit linear addresses, so I plan to add masked
forms of the three 64-bit data indexes (KSMAP64, KNOSMAP64, USER64).
While LAM is enabled, x86_mmu_index_pl() and x86_mmu_index_kernel_pl()
would return them, and the walk would mask only for those indexes.
x86_cpu_mmu_index() would return the normal index when ifetch is true,
so the fetch indexes from v2 go away.

One question before I write it. With this, the data mmu_idx depends on
CR3.LAM_U48/LAM_U57 and CR4.LAM_SUP, and translate.c captures it in
dc->mem_index. So the LAM state has to be part of the TB flags. I'd add
an hflags bit, set when any of those three bits is set, and update it
in cpu_x86_update_cr3() and cpu_x86_update_cr4(). Is an hflags bit
acceptable for this, or would you rather it be handled another way?

Thanks,
Tim

On Fri, Nov 20, 2026 at 12:31=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/20/26 02:44, Tim wrote:
> > x86_cpu_mmu_index() ignores ifetch, so instruction fetches and data
> > accesses at the same privilege level share a TLB.  Add user and
> > supervisor fetch indexes, each in 64-bit and 32-bit forms, and return
> > them for fetches.  Supervisor fetches need no SMAP variant, since SMAP
> > does not apply to instruction fetches.
> >
> > This lets the fetch and data translations of a linear address differ,
> > which LAM needs.
> >
> > Signed-off-by: Tim <mdspan.github@gmail.com>
> > ---
> > v2: new patch, as suggested in review of v1.
> >
> >   target/i386/cpu.h         | 11 ++++++++---
> >   target/i386/tcg/tcg-cpu.c |  9 ++++++++-
> >   2 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 3945e903..5bc19d5e 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2838,8 +2838,12 @@ uint64_t cpu_get_tsc(CPUX86State *env);
> >   #define MMU_USER32_IDX     3
> >   #define MMU_KNOSMAP64_IDX  4
> >   #define MMU_KNOSMAP32_IDX  5
> > -#define MMU_PHYS_IDX       6
> > -#define MMU_NESTED_IDX     7
> > +#define MMU_KFETCH64_IDX   6
> > +#define MMU_KFETCH32_IDX   7
> > +#define MMU_UFETCH64_IDX   8
> > +#define MMU_UFETCH32_IDX   9
> > +#define MMU_PHYS_IDX       10
> > +#define MMU_NESTED_IDX     11
> >
> >   #ifdef CONFIG_USER_ONLY
> >   #ifdef TARGET_X86_64
> > @@ -2856,7 +2860,8 @@ static inline bool is_mmu_index_smap(int mmu_inde=
x)
> >
> >   static inline bool is_mmu_index_user(int mmu_index)
> >   {
> > -    return (mmu_index & ~1) =3D=3D MMU_USER64_IDX;
> > +    return (mmu_index & ~1) =3D=3D MMU_USER64_IDX ||
> > +           (mmu_index & ~1) =3D=3D MMU_UFETCH64_IDX;
> >   }
> >
> >   static inline bool is_mmu_index_32(int mmu_index)
> > diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> > index 167ff769..b8f20f20 100644
> > --- a/target/i386/tcg/tcg-cpu.c
> > +++ b/target/i386/tcg/tcg-cpu.c
> > @@ -130,7 +130,14 @@ int x86_mmu_index_pl(CPUX86State *env, unsigned pl=
)
> >   static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
> >   {
> >       CPUX86State *env =3D cpu_env(cs);
> > -    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
> > +    unsigned pl =3D env->hflags & HF_CPL_MASK;
> > +
> > +    if (ifetch) {
> > +        int mmu_index_32 =3D (env->hflags & HF_CS64_MASK) ? 0 : 1;
> > +
> > +        return (pl =3D=3D 3 ? MMU_UFETCH64_IDX : MMU_KFETCH64_IDX) + m=
mu_index_32;
> > +    }
> > +    return x86_mmu_index_pl(env, pl);
> >   }
> Instead of "normal" vs "fetch", I suggest "normal" vs "masked".
>
> This way, if no mask is enabled, only one mmu_idx is used and fewer page
> table walks are required.
>
> Thus ifetch would always be "normal".
>
>
> r~
>
>
> r~

