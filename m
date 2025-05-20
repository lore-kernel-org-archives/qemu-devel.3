Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8216FC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 05:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHFpN-0001H0-BX; Tue, 20 May 2025 01:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHFpM-0001Gr-8d
 for qemu-devel@nongnu.org; Tue, 20 May 2025 01:47:48 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHFpK-0000Wu-K3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 01:47:48 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so3921859241.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747720065; x=1748324865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XL+HS1dG1owzSsUgzFcXeTc8h2D3plfUf4SHm65ZNwQ=;
 b=TAcnFv7SewydQ8qvUsSFMkWbbj2FAx0wzVekx2b16KyZJw9ica0/MXc1EiRtCJ4fSv
 40JonW1QP9jTl21+q4dN3GrLwKqsfVMpkVur/xTkwBzngs56QConBXt4Y5hAFO5qSaa1
 YJJNSNA9W8HKwIVbtDZhHY0N56rp7tO6tINAJ+NeWjbdiUqVf4ndp18oFopq/Mg2b2zy
 UMNzK+nDaY7zr/EUOWYMNe8Y2YRtVsADiF+CmXRJ6rfL6vXi0BRXtsDyqk7pcD+971Qw
 f1vm2zXDOrD5KLyAQbcpr/GhtNKrHwYwK8AAqC7TJZn7alWRA+E1W51HTc9FxmC1z9w4
 iGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747720065; x=1748324865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XL+HS1dG1owzSsUgzFcXeTc8h2D3plfUf4SHm65ZNwQ=;
 b=aBDQduCxKMfLFIdXNfLqyJt6h7hBXhmhtfQMBM/xUfLx10IBJpvmrVPlVfwxUnjwNg
 62V0zhU6ayZ6ZFYF+mJFMkdSbBOWsR3qDEVANYN3se1F5h8Ng5LSY/6UVETpuzK98r3Z
 JC022mBK8ZMgYwWVsmbQsQsF1xWkWpMimkGjr/lhSu7ORMRIUN4qS5JXmteZdh+hTPrH
 f5DNUymvCtm9JiF+5jRkbx1qU2k4dKDzqXJyJE7USlZKAYPGR0gOUwprpz/ZEzLQ5eqs
 DMiTOKVSbe5Emtndj5109dAPeJtuU12ghCWQ19ydih1eCKDMAPGzZw5xW+SmC/J9Qw7C
 XxmA==
X-Gm-Message-State: AOJu0YzRPdLNl3TKUICQeT0j4tdRWTIg4olBGFNUEsAiwE/+t0pZffUy
 Hfm13AGYCbPva5S+bFOkSHoetb6cglmC8/TbnPzVJm6a2iQjXxTBUzz2DAP6Eb89x+C9nonRNeN
 JQPqvqUqUukbeWtbmkbhiQaVv2HjBF5o=
X-Gm-Gg: ASbGncvw1knoinEGMZSRBN3lzqSs2px8lZBR3umE+MACwMMs3so0iPKaSBS4N8z9ufS
 amlHDClhy3k2NjB8twPJ3XnYHKMPj8i+cuHTyhSmW6rCFwnDjBNjqa3cGEXJHxxBrsUSsamqFaJ
 4U/c2isiT53rGWlAdJHBfO1/lEil7Lvd4EB41GlTk7J/c0v6sCLDm9Xoru3XslQkKQyOzbujaLX
 g==
X-Google-Smtp-Source: AGHT+IEgxL3hxwf1Ny1EvrcUmxetkuUswdGAyQ3worLXTyUGqdvonk3Hw9qq4cYSp8nanEegddgmSaBQ+VKK/1uLvvY=
X-Received: by 2002:a05:6102:2c08:b0:4c5:2c3e:3841 with SMTP id
 ada2fe7eead31-4dfc1162662mr17094065137.5.1747720064892; Mon, 19 May 2025
 22:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
 <53d1f06e-4419-44f1-b53b-037dc266d767@tls.msk.ru>
In-Reply-To: <53d1f06e-4419-44f1-b53b-037dc266d767@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 May 2025 15:47:18 +1000
X-Gm-Features: AX0GCFtdAz5sByS27xzeOESr0MPwWvBAN_-t3I1JBjI3jo53axiotlj3lo0HKvs
Message-ID: <CAKmqyKPZRw=6fJCuGTvh3G6uScjDdMyH9gumJmgAc=cnJrUPQw@mail.gmail.com>
Subject: Re: [PULL 00/56] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Tue, May 20, 2025 at 3:08=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 19.05.2025 07:04, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
>
> > First RISC-V PR for 10.1
> >
> > * Add support for RIMT to virt machine ACPI
> > * Don't allow PMP RLB to bypass rule privileges
> > * Fix checks on writes to pmpcfg in Smepmp MML mode
> > * Generate strided vector loads/stores with tcg nodes
> > * Improve Microchip Polarfire SoC customization
> > * Use tcg ops generation to emulate whole reg rvv loads/stores
> > * Expand the probe_pages helper function to handle probe flags
> > * Fix type conflict of GLib function pointers
> > * Fix endless translation loop on big endian systems
> > * Use tail pseudoinstruction for calling tail
> > * Fix some RISC-V vector instruction corner cases
> > * MAINTAINERS: Add common-user/host/riscv to RISC-V section
> > * Fix write_misa vs aligned next_pc
> > * KVM CSR fixes
> > * Virt machine memmap usage cleanup
>
> Hi!
>
> Alistar, there are multiple patches in this pull request which
> are tagged for stable.  Many of them (if not all) does not have
> a Fixes: tag, or any other indication where they're applicable.

Yeah, I tried to Cc stable if it was a fix.

> Is there some hint I can use to decide which active stable release
> to apply to, for each patch?  Maybe we should apply most of them

My initial thinking was to apply all of the patches tagged for stable
if they apply cleanly. If the patch doesn't apply cleanly then just
skip it. Don't bother trying to get it to apply.

> just to the latest releases (current: 9.2, to be end-of-line
> after the next release, and 10.0), or some of them should be
> applied for older release (current: 7.2)?

That is also fine with me. Most of the fixes are for vector
instructions, which is a fast moving target anyway, so just getting
them in the latest release will be fine.

Patches with a Fixes tag should be applied to branches with the
relevant commits though.

Alistair

>
> Thanks,
>
> /mjt

