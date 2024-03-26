Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9741C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3YK-0000WV-Nh; Tue, 26 Mar 2024 05:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rp3YI-0000Sg-QU; Tue, 26 Mar 2024 05:57:06 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rp3YG-00074D-M5; Tue, 26 Mar 2024 05:57:06 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7e083af7ceaso1874914241.3; 
 Tue, 26 Mar 2024 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711447023; x=1712051823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4Qh71echu8TOpAN8csffDy4UogXCOhO8udCfWyCYH8=;
 b=GxWYeICn547W+TWqTr9Qet7jb7xe/SBHiLuu3qlQ8bPIWzJGLzWUS/UYINQjXyqzfM
 rhJxmKb0W/aH38tplHfrNYq1xj9hGJWIVD3Qi1ueUNp1h3LXaswonsMnXHxRgkectQB4
 mb8ks+3oX0vC66Zp9KUfIo331L2iN+hFwJz4EGez4ZlRlnS8mJxjRGT82MzwaLi34QJM
 L18lzTpHTp718rSb6UsRw65FI8d3IiIJl2DlbLYv3tEOTawIS8e+CmoEmmfod0/GsV/n
 f+5eSMbRUzkCOSl+98I5HNiaaTn9wYeYOK2lfCuzmTw9naYxJqfCVKiBaxPFWnbxIt9W
 uW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447023; x=1712051823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4Qh71echu8TOpAN8csffDy4UogXCOhO8udCfWyCYH8=;
 b=a5/o9PlXhMRHubcPxGJoRjHF0omR8RLtQ3r3p0m4NCRFagZzRXbUzLt3rrG3NwQKAr
 7sUymEMRmd7bsgtkdc/oQZB8VFeVGmDvkHTQ0vpSxAC3IOh7c7dohWNhF6isbHr+6/UB
 8HhsUi3LsD3ZctCg5ZXvvTzhPC/aRHbr/9jKuGL7MErIp2hr2SuHj7Nt1kThq3YzDvmK
 k6VYHS7JmFrmbySqeJTMfLEObUvKyImnQ79upU04/A2/urQpijFMR/vWC1RAG0rbosBs
 sqtFeHSV3se8R+apijey15WEjkSacdOanuibnEYBAp22ScK10KRoDsIwfs8AbIugZVeD
 0/Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJR4HKGQuhecEXtzJ+SsiTA4bcxs8ju/XG4mc+2CBjlseTSchAxZN+psLfH0UsLml71G7nmP2fM6fA/z7dCX5wlYDkGXIuC1QFORu+3gRmT8s2CgX6ulFJ6AdGjos=
X-Gm-Message-State: AOJu0Yyl8mh2jaariy3Kis4yOAltkpvJTussSKl3zNxfOxteUg35NYqE
 r7l/iZKt3tsGCety5xmh62Zr0/7WaBLEHEfyLoYSyTUwahVRWIUJ5lrDJw5v57TsftlxQlgW6sp
 XhE7iHs+EWjf89NiFE3n438ADKvU=
X-Google-Smtp-Source: AGHT+IHZn620JcbXBe9yS2kvOa/9OI141QtOV3ocyzQFGQfZhOylgbdaOIA7H+dZ2JrypW8OPQPDFmsW9BG7+Nf95rA=
X-Received: by 2002:a67:b14a:0:b0:476:dd2e:cd19 with SMTP id
 z10-20020a67b14a000000b00476dd2ecd19mr6027081vsl.7.1711447021155; Tue, 26 Mar
 2024 02:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
 <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
 <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
 <6fb5ca42-8e86-4144-b9a9-9d98d30f8fb9@ventanamicro.com>
 <19d5ffb8-8cf1-4d88-b66a-2cf961621b93@tls.msk.ru>
In-Reply-To: <19d5ffb8-8cf1-4d88-b66a-2cf961621b93@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Mar 2024 19:56:34 +1000
Message-ID: <CAKmqyKOG1sr269TDERsGEvbAJfJ_MTtW-smMCdDUBbYaGwkPGA@mail.gmail.com>
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Mar 26, 2024 at 7:53=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 24.03.2024 21:12, Daniel Henrique Barboza wrote:
> > On 3/24/24 12:07, Michael Tokarev wrote:
>
> >> Unfortunately this doesn't quite work, the following changes
> >> fail to apply to 8.2:
> >>
> >> 929e521a47 target/riscv: always clear vstart for ldst_whole insns
> >> b46631f122 target/riscv: remove 'over' brconds from vector trans
> >> d57dfe4b37 trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
> >> bac802ada8 target/riscv: enable 'vstart_eq_zero' in the end of insns
> >> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acc=
eleration
>
> > The amount of work can be non-trivial for this backport, so I'd say we =
should
> > leave it aside for now. If someone has a good argument for this work th=
en we
> > can re-evaluate.
>
> So, out of 15 patches in this series (minus the first one already
> mentioned) - should I pick 9 remaining patches for stable (the ones
> which applies) or none at all? :)

Sorry for the confusion.

The 9 patches that applied and

385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM accelera=
tion

should all be picked for stable.

PS: What is the best way in future to help ease some of the stable
burden? Should I try and cherry pick them beforehand and then mention
that as a follow up to the PR?

Alistair

>
> Thanks,
>
> /mjt

