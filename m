Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C2606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j86PYD9P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMYA-0000ln-L3; Tue, 20 Oct 2026 22:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJMY3-0000lJ-V3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 22:59:28 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJMY1-0001Gw-TT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 22:59:27 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3ab39af88aeso2388861fa.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792551562; cv=none;
 d=google.com; s=arc-20260327;
 b=C8aVvwEva2+kca9v/6PKebBFApJw29L1T602Ex83qFTRvIARrmA8TPJfC0UldnAN5T
 4GFbPrx3ZAMFfFnyuHBz+4X4sKL2XHEyy2pwiy9CrNIfiu7m2ENPtcYN7D8X44UT2Zns
 EFu+AZEFYBt4dMSOY8HyeigwLxBegq/t6vEUYgF42UPSmKuX2fbT0dl37TWQqidB3zul
 aoC9yMoJ3XNxIlLYVjB2cvk+dqW7KT4NzZ3de03JXiGH+TlKSFQthXFqkiCnY369zEIq
 r+y2sCBZN+goEgJNvrn4WUnBBZZ+lThGC/I6+L84tJQ5YO79BwbnuODaHmLrXyT8RVhk
 zrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vah/WyMJCOuIHYo7cnXA6FuateYoiFGkcHlYeRsJl50=;
 fh=ESTH58NYpQ5zsnEHxKzx9CuAnzlnQYfpw5mOKPpEzGQ=;
 b=s7L49Ry7rpdzmWhKvFg727aRjoTASGeAUBOTvikOee/0yLkf+bqDmOWLUSDUteZB5A
 F4LDKicdka4ex9wzqqO4VTrpqf00vSvUMZA6Dhq6OKtFDz2xGeHopOXwFj/tifQVn84J
 TZAKPYsoYG0r8sE0eDtHT1AkI3O/QbS90YUrb26oo3MLnQh4E3tj7r9uejxNuD5jg2rC
 VpDgEMTvsokpdTbQCgMiE89Of0U0kcjGM3JsbkKXzuYNkACoBSoNnoXytYpQqToHXI/L
 barGI+hYpWM5UMobdglU3zpPVkZ5EFeswYKKaPYIDIVdrDcg4D5HuyQOier+ZrDjaBJr
 PPgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792551562; x=1793156362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vah/WyMJCOuIHYo7cnXA6FuateYoiFGkcHlYeRsJl50=;
 b=j86PYD9P7926hkLXFIiSL6jDrqsgOvmprx4KEQDWDI+0LJfg+uTllq5UJnl+oT4dQC
 /OCvPgFrkFkt1JaoQ769zZaXQWS6jpIfUob2pFhP1qltdDFdQ5mJUU70AaUevRqqNc35
 rDdUq2ocucc0cYDZkZjvcpnQI5s6hzWr0gRTrqG40EJpJXR+tXeZkock3mQfwTSCt581
 iHLSGcn99PrFng8I120OFe9MTr/5nrAS+X95N2GB6H76N6VTrTJovulZd/dcCx45Mwb5
 FGtstDXR4lFpXIMU+Ug41Z0XYEnth/lnnlwXhc/bYfqY8DSrppSghN4DPt8738TGwyQO
 RDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792551562; x=1793156362;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vah/WyMJCOuIHYo7cnXA6FuateYoiFGkcHlYeRsJl50=;
 b=AhWTEk6CYcO0aROLX3JdsMdnIoXLNsl1Wim+wyaZAT1PS7xF1d3nYCh7q2tpHxEKsl
 dd5qA+yQD5fYbO4p1XHyf9oGHl2hZ4Q7fD8ALhKXnyiSEqUVKfbvpj1IIo7+6IwJh9Ez
 A+CzB6W2HoRyA4azEvHLnyvQ52OGhw0dXmVeYwKKw1gL66kzlo/NIOaCvBYdNoRWloSw
 K58KbniNQ2EGCIAnF3jE5k/0KnpxsQbIwkv5fEoevT45vuSWD7kUBGVMFHk/DctHaxp0
 Rst62izdnrvgC76j/tywHEJ8oQg+KSrrLVfGyZp8ZaOu7G2hxp+DKQqg1TA0jsFsdmTi
 b3iw==
X-Gm-Message-State: AFq9FYL4ZUyddzgCD5fLrktVXqsY+9y316gjqOA8wEglUrI7bva9K81v
 HGKS8voXYRywBUaxAJeeO4NWxkvWD9vEZKcqFulduIm/a6mO6FmtqT4icIvJa85Kqc3x37esnff
 qWTKosvaTqtVUQUQP5xMD1buyZXRdyqBKs4OH
X-Gm-Gg: AYBFou1XjofTgh3Mf3eCFHbclPnIkyuLn2EtpiJFG9FHhT1ajA1BsgnK5ekCKkmU0cL
 Nfm3WvrpTmP7f7HSq4ZzQf3OYjJXFYn1vYk7pDTPffS6Mc+ydxUSSk3wkjWfrmnhEiBieZsE/YV
 bjJXWZisxQ1ZhFbRFz06wPvfVtsRzcHIXu2M2/oQ/iAoyVA+ckRNLG97aXG2XoeDdgDIrkp306j
 J4aYIybXKqsc7Uddf+OLUdXxRrURrf4hfbVHU6RnhJJXwXnqgU8G2n8Kmo/Y72S0ELAAXaxT2gk
 JQJyRnsKe/9EByenIXMaBZCyo4ncc58AW/+kxOhb+E7SWARdbeNzv36V/mcu3UepmGvwG5kJYxa
 9nIX+5Zwa9vWL+N05veRYHuTh/ewuwwSB+ddxhLeO7ltxDR6xF32Ywhw8n4HC7YXuO8xSfnwayW
 dOg4nTbDx4TTPib4iv1tDBynpsJkBGC5It/jhv3y07E2Y3tvTwIbNE
X-Received: by 2002:a05:651c:222c:b0:3a9:a8bc:e0f9 with SMTP id
 38308e7fff4ca-3ac4416296amr1811521fa.7.1792551561760; Tue, 20 Oct 2026
 19:59:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261008193119.1246259-1-mattst88@gmail.com>
In-Reply-To: <20261008193119.1246259-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 20 Oct 2026 22:59:09 -0400
X-Gm-Features: AclHuK--cJIsP8JNbPtY6t4i6b1NoJFOY6sUYXwfTvnHgqS0SoOOMiZGzFHSFwc
Message-ID: <CAEdQ38GhBsgLtHKdEsctYZeF9ro3BuT_xWbbOKeuFfqC9ipQxA@mail.gmail.com>
Subject: Re: [PATCH] target/alpha: honor the page table entry granularity hint
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 8, 2026 at 3:31=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> PTE<6:5> is the granularity hint. A hint of N says the entry is one of a
> block of 8^N pages (64KB, 512KB or 4MB) that are contiguous and naturally
> aligned in both address spaces, so that one translation buffer entry may
> map the whole block. Such an entry takes the frame number bits above the
> block size from the PTE and everything below from the virtual address.
>
> Do the same: mask the frame number down to the block base and take the
> offset within the block from the address. A well-formed block translates
> exactly as before. A block whose frames are not contiguous or not aligned
> now gets a wrong translation, as it can on hardware, instead of working
> by accident.
>
> The size passed to tlb_set_page() stays TARGET_PAGE_SIZE. A translation
> buffer is free to ignore the hint, so a guest already has to invalidate
> every page of a block, and one entry per page is all that is needed.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---

Ping for review. Kernel support for hugepages on Alpha landed in master tod=
ay.

