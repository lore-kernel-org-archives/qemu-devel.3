Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ADBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gb0-0000Gk-Pk; Wed, 08 Oct 2025 22:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gaz-0000Fm-1y
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:41:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gav-00008S-IG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:41:32 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62ecd3c21d3so708476a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759977687; x=1760582487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/w9QYWnjBWyEooYmuNJbii3Pdy/Lz/NskVJam5LMGmk=;
 b=mVYpADwaOJStBdTpjA9r1n6GLVKIUg1EoA0DCHDyS3DYzygA0U/eS80juePoK91p6l
 95cAnx3UEGApWrHOkcfKguRI9f+ZnDhYq8XH/dD9SoGraDwK4I1MakiG9XgwIiGaqqFx
 l13CGwLw2IcBS2dgHrE3sSpT8hZ3J2NbA2Dz+yj7xjg7nkhQ9hK90dTThJpHoFqbsIfb
 cSZaxDIZ6ZgesLIA2D9EqpDxL97jEATD8wB6bIFS/qz5wOdy49JZBLmlPuSGdM7HlUrW
 0VHalmcIAFRHhe1WlAlasZaY14yL1ddswRowvewXpLvuTbRgjYDCGs2ky2JzZef1cVpq
 osUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759977687; x=1760582487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/w9QYWnjBWyEooYmuNJbii3Pdy/Lz/NskVJam5LMGmk=;
 b=tLDj0eATgZDq9fCesdgwwbnELSk6QVShym1YGzfPqQhIowYtL0Zy1IBjkOFN1iWJuP
 Zabk0tKERYHKk7lxHVlWee+3hm34NCAcdJOn5bQGeNzAydQW0hV/1xJEeSOrEiKKHLvA
 /caNOWU+VuUfC/PN478Lqv9z6Uz91zXL+j04/uFB/k8spFXcYsMxbwhbMTAEXqkgSq8F
 vjwYG87FVrlcn2nQ18D7ElxJzlOpD2w4M8FjAie2o5ambw3O80i+TUr3jBs9cHwiJFYR
 fCQVI/8D9fIQqcJwJdsu62080DosdRmpkJCdR1qhYBoYW29gKSJyM3COa1xJ5ka0+sHh
 8e7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWljPIkohGqUglwkayy3302E4VmNVMuvZtDyh/2jlmblPVdbm1Q+iOz7DualM7E+QhWNfGtM2x7ySNP@nongnu.org
X-Gm-Message-State: AOJu0Yw49hDzYKEmkk8DEmlSq/6CTI8MLDFaPGo9NHvts8VqXXeUjHY9
 W5eRv9st91g8KmZnGDHAwPQEcsLP9wkydwN8lptRzF2enSgJo9XX0CMhP8ByPJc8zYSPE/Rnokp
 LA6ah6iLxX+05HyFch/jWpx2Mg5mF4bs=
X-Gm-Gg: ASbGncsuGfpSvxuOtdGZF/sW5ljrtN1G10daUJJSf8pWPN5wR7WieBIviVYCyqnpNN2
 Rdg+PTwg7NBp2e1sTKuO47Hq0AtDMlv5WC2lv/lsovMPFjRhx4mtYow4Z4ITE/QQhPes8nX7Hp8
 PuUQXKWAlpulnj54hLMIVjRDHeinw+MmE0i+qrZ7qq40slvjWdHzYdsbRHMiOZW0ETXz91Eh65b
 89iAHkKgnBy/xdIqDp0P6rDv1qnw8TdX+Ln3YCCsMuzh+FtxhHEoPOzQaIG9w==
X-Google-Smtp-Source: AGHT+IEzvYWqd+DVYvdEzd/HHGE1dR/DEB57w8YQ2R8Q9OTRKDCvjLUAl18UZom5bdoD7xB5PPKnxqPXvPT1JmCJl1o=
X-Received: by 2002:a05:6402:3486:b0:639:fbd0:4e39 with SMTP id
 4fb4d7f45d1cf-639fbd051e2mr721113a12.1.1759977687403; Wed, 08 Oct 2025
 19:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250924074818.230010-1-jim.shu@sifive.com>
 <7817d067-6bf4-4628-a5b3-8e8743415c9c@tls.msk.ru>
In-Reply-To: <7817d067-6bf4-4628-a5b3-8e8743415c9c@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Oct 2025 12:41:01 +1000
X-Gm-Features: AS18NWDWr1-9BOV29Ea9bSe-Z_9eEJ7nQW0QN9JAsgKV7KivuPUmqPQbR_sB4sQ
Message-ID: <CAKmqyKNkDiEEE0KbL7U9zmGAL=czXnbs09NZACUA9X7itO81eA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Minor fixes of RISC-V CFI
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Oct 4, 2025 at 5:33=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> On 9/24/25 10:48, Jim Shu wrote:
> > This patch series contains several CFI fixes:
> >    (1) Fix the mepc in the exception from sspopchk instruction
> >    (2) Fix the exception type from SSP CSR and ssamoswap instruction
> >
> > Jim Shu (3):
> >    target/riscv: Fix the mepc when sspopchk triggers the exception
> >    target/riscv: Fix SSP CSR error handling in VU/VS mode
> >    target/riscv: Fix ssamoswap error handling
>
> Hi!
>
> Is there anything in there which should be picked up for
> qemu stable series (10.0.x lts and 10.1.x) ?

If it's easy to apply then it can be applied, but it's still a very
new extension so I wouldn't worry too much about back porting the
fixes

Alistair

>
> Thanks,
>
> /mjt
>

