Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C437FC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 03:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzoPb-0006qp-Jd; Tue, 01 Apr 2025 23:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1tzoPZ-0006or-By
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:05:05 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1tzoPW-0002gj-KV
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:05:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 42504435CB
 for <qemu-devel@nongnu.org>; Wed,  2 Apr 2025 03:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D3BC4CEE4
 for <qemu-devel@nongnu.org>; Wed,  2 Apr 2025 03:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743563096;
 bh=KHZlvIMG0u9rb1ecYI9KGfB2uA3BeCnzKvI5pX0v3SY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pqA+Nirnw4ikCNpmW2j5u3W5pcw4bT9PeFl0FTvZSbQ+sqhHWUL3B5kv/q8e0VKFd
 01Q5knQBXKSLEB8W97VGrYojI/cwfZoLh7SiBA0xj6qUllu8RCWgvKe2aLvDWJ8ruV
 LZURQjX3WQ32mPiAbHnP7U9FDXepNUkzQmfihIuUtmWOPgB70FWjaLI+wvkWVQtI1p
 PLl4ADBw919IQ7nFZn44N+xUBKymEuytFSpocPcrYzl867UcrzWyNKmvOs8ZHs1nFC
 FLIfKmlWz/ZcXcdfBG/sQymUzdB5rqCanugNhJz0BdQ/E1SHHGvA3dN5hSExjqJSSu
 bl96I8eQsIb3w==
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso10147803a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 20:04:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWkQqvyukk2i8yiV75BejQL6Yn1+SXgblx5iBqYQDKMKdcryvB
 rTg/WLMwn06cY8oPsqshjGlSZfnw4y5FoS48I4uf7vvIRJz0UjjtzqhILGZmbk9tpgzk40qPWlb
 R/z4R2qI8rDIEiY+L3Am1URle/T8=
X-Google-Smtp-Source: AGHT+IEIHAOFDbDB4x9NbQ8ctBZXIn4e++Gk3sJxzUr2VpvqPex6VDEy9MoicEPh1TSeHSgOIRLrLwdXdYsCzWIlEL8=
X-Received: by 2002:a17:906:f58e:b0:ac1:e881:8997 with SMTP id
 a640c23a62f3a-ac73895fe8emr1287305466b.3.1743563095238; Tue, 01 Apr 2025
 20:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
 <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
 <b17663bc-40c3-4501-be88-065363138038@linaro.org>
In-Reply-To: <b17663bc-40c3-4501-be88-065363138038@linaro.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 2 Apr 2025 11:04:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4mmKvJ75uSm_LCFrCFYM0QG=4oh0ZLVTGXdKX+svs5eA@mail.gmail.com>
X-Gm-Features: AQ5f1JqIG1ic5SGJ5xEaslBzFYTkVI4ahxdSQJ1y3ur0ahM_e9EJjbWc0Bdfxos
Message-ID: <CAAhV-H4mmKvJ75uSm_LCFrCFYM0QG=4oh0ZLVTGXdKX+svs5eA@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com, 
 arikalo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=chenhuacai@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi, Richard,

On Tue, Apr 1, 2025 at 9:39=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/31/25 20:15, Huacai Chen wrote:
> >>   #  define TARGET_VIRT_ADDR_SPACE_BITS 32
> >>   #endif
> >>   #endif
> >> -#ifdef CONFIG_USER_ONLY
> >>   #define TARGET_PAGE_BITS 12
> >> -#else
> >> -#define TARGET_PAGE_BITS_VARY
> >> -#define TARGET_PAGE_BITS_MIN 12
> >> -#endif
> > I'm a bit confused about TARGET_PAGE_BITS and other macros.
> >
> > In my opinion, if we define TARGET_PAGE_BITS as 12, that means we only
> > support 4K pages. And if we define TARGET_PAGE_BITS_VARY and
> > TARGET_PAGE_BITS_MIN as 12, that means we support the minimum page as
> > 4K, but we also support larger pages.
> >
> > Am I wrong?
> Yes.
>
> TARGET_PAGE_BITS is a minimum value that is used by the memory subsystem =
for managing ram
> and i/o.  If variable, via TARGET_PAGE_BITS_VARY, this is set very early =
in qemu startup
> and cannot be changed.
>
> The page size for the mips cpu, like many others, may be changed at runti=
me.  The page
> size used at that point is reported to softmmu during tlb_fill.
>
> The value of TARGET_PAGE_BITS must be the minimum supported by the cpu.
>
> For Arm, the minimum for armv6 was 1k, then armv7 dropped support for tin=
y pages so the
> minimum is 4k.  At runtime, armv8 supports page sizes of 4k, 16k, and 64k=
.
>
> For MIPS, ignoring those cpus which support 1k pages, the minimum is 4k.
If all types of cpus of the target arch has the same minimum supported
page size, we only need to define TARGET_PAGE_BITS; otherwise we need
to define TARGET_PAGE_BITS_VARY, and TARGET_PAGE_BITS_MIN means the
minimum supported page size of the smallest supported page's cpu type.
Here we remove TARGET_PAGE_BITS_VARY because we just ignore the 1K
pages.

Am I right now?

Huacai

>
>
> r~

