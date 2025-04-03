Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F7C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 03:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Atc-00040G-LN; Wed, 02 Apr 2025 23:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1u0AtY-000402-HH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 23:05:32 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1u0AtW-0000QY-VI
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 23:05:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 19BF2A41F4B
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 02:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8FDC4CEEA
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 03:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743649524;
 bh=7e4LFV1wQFPG/QhKz5c5IUmh9QjSXNG5yMM5Z9j21Sg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tyBQpI/64kukcTOol+unhQUE5QuphuHhcTrM6NKiTBpcvcwVtEj+ZbBPX60xhm59J
 +s7IhlQOsldOpB3MA2yEp1Vvb0UvZvaPDwdnJqHpt/8+kdPjXs+wUZCxBIY32O2xrM
 sDorcVVgUXkE8X77WEf/hfXN/RAWZNVKKhvLnjbU2KMv9hXzIji3v5ExLYbrANMMaj
 lx4mtnhvi37svxe8zzMAHqAj6DNUGP9wSR1uoBdUau3waYlroNQq2tZKxsj5xeknjj
 qeT1kFdyPRgqYkHynMXySoWf3STwEox0hJ/o2i1ecZuLXiXhL3DY/dXvRVstiTDt3J
 0Fsvz8kTnTrUw==
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so56435766b.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 20:05:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxw4ypDATbNx9Ri0RgGHyeokvLOZCF27evMB9EzbnvTnsyZx1LQ
 izbAGXD/Hu7/K7FMenFbzpn4digw5DAmCCsZQKMF2kPjN4TCbvN9NLaGRYpvKpexDLUP6EJq1MA
 og7aTS0gIL3h+KZTmAFKcy8NZWXk=
X-Google-Smtp-Source: AGHT+IEKENLCYrgqkyp5/MaHl0sM8p7PV01z60kX+TZUndRC5U2CwcKa/SOKggtmI/nW+cWNym64BSvBiCCOTednllY=
X-Received: by 2002:a17:907:9710:b0:ac2:cf0b:b806 with SMTP id
 a640c23a62f3a-ac7bc26ec1cmr93589166b.56.1743649522871; Wed, 02 Apr 2025
 20:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
 <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
 <b17663bc-40c3-4501-be88-065363138038@linaro.org>
 <CAAhV-H4mmKvJ75uSm_LCFrCFYM0QG=4oh0ZLVTGXdKX+svs5eA@mail.gmail.com>
 <8d897be6-24b6-4fe3-8201-59f0bd08763d@linaro.org>
In-Reply-To: <8d897be6-24b6-4fe3-8201-59f0bd08763d@linaro.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 3 Apr 2025 11:05:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6BFRRg_4ZS9S50kgE+ZEJWRMwgm45zBWLwqVP1JLwE_Q@mail.gmail.com>
X-Gm-Features: ATxdqUG3p9bPBYD41twDeVj-hWkaftU6hoPi38PskN7osywj3Qotjv7ZjdE_h_E
Message-ID: <CAAhV-H6BFRRg_4ZS9S50kgE+ZEJWRMwgm45zBWLwqVP1JLwE_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com, 
 arikalo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=chenhuacai@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 3, 2025 at 2:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/1/25 20:04, Huacai Chen wrote:
> > Hi, Richard,
> >
> > On Tue, Apr 1, 2025 at 9:39=E2=80=AFPM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 3/31/25 20:15, Huacai Chen wrote:
> >>>>    #  define TARGET_VIRT_ADDR_SPACE_BITS 32
> >>>>    #endif
> >>>>    #endif
> >>>> -#ifdef CONFIG_USER_ONLY
> >>>>    #define TARGET_PAGE_BITS 12
> >>>> -#else
> >>>> -#define TARGET_PAGE_BITS_VARY
> >>>> -#define TARGET_PAGE_BITS_MIN 12
> >>>> -#endif
> >>> I'm a bit confused about TARGET_PAGE_BITS and other macros.
> >>>
> >>> In my opinion, if we define TARGET_PAGE_BITS as 12, that means we onl=
y
> >>> support 4K pages. And if we define TARGET_PAGE_BITS_VARY and
> >>> TARGET_PAGE_BITS_MIN as 12, that means we support the minimum page as
> >>> 4K, but we also support larger pages.
> >>>
> >>> Am I wrong?
> >> Yes.
> >>
> >> TARGET_PAGE_BITS is a minimum value that is used by the memory subsyst=
em for managing ram
> >> and i/o.  If variable, via TARGET_PAGE_BITS_VARY, this is set very ear=
ly in qemu startup
> >> and cannot be changed.
> >>
> >> The page size for the mips cpu, like many others, may be changed at ru=
ntime.  The page
> >> size used at that point is reported to softmmu during tlb_fill.
> >>
> >> The value of TARGET_PAGE_BITS must be the minimum supported by the cpu=
.
> >>
> >> For Arm, the minimum for armv6 was 1k, then armv7 dropped support for =
tiny pages so the
> >> minimum is 4k.  At runtime, armv8 supports page sizes of 4k, 16k, and =
64k.
> >>
> >> For MIPS, ignoring those cpus which support 1k pages, the minimum is 4=
k.
> > If all types of cpus of the target arch has the same minimum supported
> > page size, we only need to define TARGET_PAGE_BITS; otherwise we need
> > to define TARGET_PAGE_BITS_VARY, and TARGET_PAGE_BITS_MIN means the
> > minimum supported page size of the smallest supported page's cpu type.
> > Here we remove TARGET_PAGE_BITS_VARY because we just ignore the 1K
> > pages.
> >
> > Am I right now?
>
> Yes.
OK, then it is fine to remove the TARGET_PAGE_BITS_VARY and
TARGET_PAGE_BITS_MIN definition. But Loongson still prefers 16K pages
(4K pages cause cache alias on Loongson), so I want to keep
mc->minimum_page_bits =3D 14.

Huacai

>
>
> r~

