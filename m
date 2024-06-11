Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100D1C27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 00:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGpDy-0002vi-Ti; Mon, 10 Jun 2024 20:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGpDy-0002vQ-1q; Mon, 10 Jun 2024 20:18:54 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGpDv-0007Em-J3; Mon, 10 Jun 2024 20:18:53 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80b7f0910cbso1024349241.2; 
 Mon, 10 Jun 2024 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718065127; x=1718669927; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cghM+CEZUx8vh5anJ3JTmNY9YWd+PUagcGwEBxavVvA=;
 b=VvecxiIMCDv/8uH+MOdZk+DV8isKT4yHAqY3ick1DIeNWBKRXyZlHmoPqFEjJB1o46
 OReB1Qh3PJxB4g7mGYk6s6ndLYR/vpfttW/2EHFqozEi9370iXAZ5vFXKRnGH/ABzmQF
 LdasBGkeCjsDkfoK8Vuy+RdQKMPzhva8uVk/EscGH95XDIa/DkAM9assjJdjBreLa307
 +IpDYL6mZ32qZicd7e/aleN1vmsidbuNYGZwa3p5f8qGaxkwAxpk6ouPQbkFRUndmRtb
 EP7pCskTGxZ1TpXUcO6RA+zy3ZnfDI2z1G71qkIFUeeZGjMkUBM6ewrjme10RxEWKe0y
 jA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718065127; x=1718669927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cghM+CEZUx8vh5anJ3JTmNY9YWd+PUagcGwEBxavVvA=;
 b=HX7cqYsqU5mae8FpR4pHzHtHNdLiqJaodsgTJaYfxTUhtCvmP5MD6RODBiHH7haMzm
 u5RhUF2hR0x+zcVlFIZ/LICx6d+bHIJLdtOD47HrfJPKKV9h+kiiHyhyO5s8noUwTm42
 3+JsZ6IWJaTP1TptBYBnGfAQ4z8n76py3RYC5zUy0s+dHPl3LK1fYwZvSrQ7OVfGtuho
 uPdyjlVtBqst5/edEBZZc5ozAnw/ldIscVbgEjJUnFK/7RnfhFok2SKt28cAg/AbAmFu
 53vX0Bik+QxjMnKut5Efeqvc27AY0JSnv7nUL1pd6186Pv+oUGySGdzuEZTBGtMnziUn
 UdDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWn91Q1kc6BWVNVISppMJP5FBscyllc7BDdYlO/1c6d9YKrXxsZ+LlPCZZ5zAb0HGsRunJzwDuTe/1w3ZyZ5gmgngeHuTWShY8p0/HTgY6MgEEkZqJI/AXCrpU7A==
X-Gm-Message-State: AOJu0YySazoiVgGc1N9+ckOMCyxBLljn7LlJzeKKuwU2bUNwn2lkYsBB
 Dx/RiIoy7nkubmmjBzLMQ7cF/USxKl46rA+hRNGXqTmRnzgIjewkZkQ/H+BWNUq8pfibM4dyIA6
 7S6Cjvs38/7/zfiTq7Z5QNE9bM+4=
X-Google-Smtp-Source: AGHT+IE6k8hnoKRObcHZvP6335x8NTp0vRi8v27nMCSdo1DlFseaoRDPkH10JF48qc1ngJpYhyBbpUPGuNB0qQsrAOs=
X-Received: by 2002:a1f:cd87:0:b0:4e9:7f87:4c2b with SMTP id
 71dfb90a1353d-4eb5621cd6cmr9366843e0c.3.1718065127294; Mon, 10 Jun 2024
 17:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <CAKmqyKNd2BL-B12RnXu6ZRC0ApqgFXeZSTxggSxJSnbvcN=aSA@mail.gmail.com>
 <5ADE1DEF-D40E-4199-8646-5C539249796C@ventanamicro.com>
 <53fc947b-8301-44c6-8bf0-57e6a705ba64@ventanamicro.com>
In-Reply-To: <53fc947b-8301-44c6-8bf0-57e6a705ba64@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jun 2024 10:18:21 +1000
Message-ID: <CAKmqyKMy4r5x0RYoCBW1O7yw_Dc29Sory_usHPcUVYzmjn0_iA@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] riscv: QEMU RISC-V IOMMU Support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 11, 2024 at 5:16=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 6/10/24 3:32 PM, Andrew Jones wrote:
> > On June 10, 2024 2:34:58 AM GMT+02:00, Alistair Francis <alistair23@gma=
il.com> wrote:
> >> On Fri, May 24, 2024 at 3:43=E2=80=AFAM Daniel Henrique Barboza
> >> <dbarboza@ventanamicro.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> In this new version a lot of changes were made throughout all the cod=
e,
> >>> most notably on patch 3. Link for the previous version is [1].
> >>>
> >>> * How it was tested *
> >>>
> >>> This series was tested using an emulated QEMU RISC-V host booting a Q=
EMU
> >>> KVM guest, passing through an emulated e1000 network card from the ho=
st
> >>> to the guest. I can provide more details (e.g. QEMU command lines) if
> >>> required, just let me know. For now this cover-letter is too much of =
an
> >>> essay as is.
> >>
> >> It would probably be helpful to document these somewhere, so others
> >> can use them as a starting point for running this
> >>
> >
> > I've written up a testing procedure which I shared internally with Dani=
el. I'll sanitize it and post it somewhere public.
> >
>
> I can also add a QEMU docs under docs/system/riscv, both as a
> subsection of virt.rst and perhaps a new doc that describes the
> devices itself (riscv-iommu-pci and later on riscv-iommu-sys).

I think that would be great. Even if it isn't a simple "copy this
command and it works" it at least gives users a place to start to
figure out how to use this

Alistair

