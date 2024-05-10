Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E2C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NnR-0007ag-ET; Fri, 10 May 2024 06:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5NnK-0007X2-LI
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:48:06 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5NnH-0001Ka-Nj
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:48:06 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso26156971fa.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715338082; x=1715942882; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Y9akE0REaLDZgWsRgZpLu1R9ryJVuhFVT9XTqY1ygc=;
 b=dQRvxuU4bOoixxghkmXegioVJHzIhthcO+TOxxYAUAUh7MobkeoYO5oBnT9h8DP7LK
 wTKKn/3wvoUTZDJzrH3lyEwg9akcWDu2B70gxMiyVPCWcdNDjy1sXYpWN4ykRU1tDj/B
 Dm+5po3XbBGDqnb3iEqzSMvILatDv129J+ZqtawXMJm1rtWbkmSmWb0T8vdvzJuevixh
 zCZVgeybQMkaqqaH+JgLsRIWj84fljdgROV5q0solqfKkhUHzbTYnQ2gULRjwup6pbLi
 O5nM9jzDQWZ6CvfNdg3PMx3v9V2L8UDrfZK0rRWsRfmv7kGhlLtfV6U3+4dQEa7Uqyh8
 wCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338082; x=1715942882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Y9akE0REaLDZgWsRgZpLu1R9ryJVuhFVT9XTqY1ygc=;
 b=gy/CS0CkxoZBGu1PfGSLF9lMMr1Yt6yjGc4Dr8z1zFukgkSyWWUywQ3o2icKdNmo00
 kNwyosi7832cDoR3EIMyIGEzrywuv4pCbrWyLIsH/6QC2ax8OpW8LhrxccIjyEGmWEnU
 Q2iEqNGC2NPEfRrB85pb/xGmi6Ow3YDJlLdybsgZd9XiM+5g2TVT7jEkn+trb5D1TmAf
 iO8xnXXQu1gIzQ8FJ5funLYFowMlOXEeDatW3hCGugtxMbpOiETYec82uOQ8LVshkBF4
 8nthePkFNcnL/L5KcjnOWe6/zfXbL/XlvXtwBh48b0M4bFts2pIbx7uAwrUFG2jQn2Q2
 DAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUa0US/zbvdv0j62c22B0BlRajLuHKgU2C2oj+6Ux4ER9gUR9MC6nLzpul14Y75roX+Wyv2JMMnnF8il7wiR7cFrsOTNM=
X-Gm-Message-State: AOJu0Yy3EIovtcG/Xq+MTEBdiNT6C2q/3qFKCyaKyBiuPaQPF8hWq+82
 2iXjLorkWboUvmn5WufmhTGQucr70QUL5mICVpf2IocBaWcl9ZI7757XF1f3XHCJ0iiJkHV0Dtd
 8AcerivG8B5BNsBdFlbMss6utx2SGa6lggkT+Cp3xvJ6PdglDRgPHQrNnFNiciqbW9S8gt4xzUg
 dFgC2Df2RyavwJmLasAL7zmyDZ4Inx7mZBSht3KfAVwg==
X-Google-Smtp-Source: AGHT+IGSXrlWEBzxhMGLVEqjNeCYyDETYMmvaMSBM6XS89XvAJ+zlLrAekVvmxj3Av4qAk/840LFnw==
X-Received: by 2002:a2e:a71f:0:b0:2dd:987f:f9d7 with SMTP id
 38308e7fff4ca-2e51ff5e559mr11974841fa.25.1715338081669; 
 Fri, 10 May 2024 03:48:01 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d0ce39e6sm4864081fa.46.2024.05.10.03.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:48:01 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2dcc8d10d39so21261851fa.3; 
 Fri, 10 May 2024 03:48:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUCfZFUec5OMXfj3CGQ+XO+4WJRogdyMGmuR3EqfPVKqJ0T8gXMPZq+gvaDo/653BKQ1Q744b1WrieXzK+hIrirtCnkNTsLVIwE5zvkaGIjpGGMdNpDP/6BPE3cVQ==
X-Received: by 2002:a2e:e02:0:b0:2e2:72a7:843b with SMTP id
 38308e7fff4ca-2e52038a326mr12324901fa.34.1715338081048; Fri, 10 May 2024
 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
 <CAFEAcA_gu40QoTXUPP2f=8vGvEOTbGWKtqR3b-e7YYhbFG0aiw@mail.gmail.com>
 <d8fcb94e-86cf-4497-b450-1a32e4606512@ventanamicro.com>
In-Reply-To: <d8fcb94e-86cf-4497-b450-1a32e4606512@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 May 2024 18:47:49 +0800
X-Gmail-Original-Message-ID: <CANzO1D1VmQhETKY7zFC7PTu-QntOnZVmXcYor3m2B+6RVcC5mQ@mail.gmail.com>
Message-ID: <CANzO1D1VmQhETKY7zFC7PTu-QntOnZVmXcYor3m2B+6RVcC5mQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com, 
 kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Daniel,

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
5=E6=9C=888=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:42=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
>
>
> On 5/7/24 12:44, Peter Maydell wrote:
> > On Fri, 3 May 2024 at 13:43, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> Hi,
> >>
> >> In this RFC I want to check with Gerd and others if it's ok to add a P=
CI
> >> id for the RISC-V IOMMU device. It's currently under review in [1]. Th=
e
> >> idea is to fold this patch into the RISC-V IOMMU series if we're all o=
k
> >> with this change.
> >
> > My question here would be "why is this risc-v specific?" (and more
> > generally "what is this for?" -- the cover letter and patch and
> > documentation page provide almost no information about what this
> > device is and why it needs to exist rather than using either
> > virtio-iommu or else a model of a real hardware IOMMU.)
>
> The RISC-V IOMMU device emulation under review ([1]) is a reference imple=
mentation of
> the riscv-iommu spec [2]. AFAIK it is similar to what we already have wit=
h aarch64 'smmuv3'
> 'virt' bus, i.e. an impl of ARM's SMMUv3 that isn't tied to a specific ve=
ndor.
>
> The difference here is that the riscv-iommu spec, ratified by RISC-V Inte=
rnational (RVI),
> predicts that the device could be implemented as a PCIe device. But RVI d=
idn't bother
> assigning a PCI ID for their reference IOMMU. The existing implementation=
 in [1] is using
> a Rivos PCI ID that we're treating as a placeholder only. We need an ID t=
hat reflects that
> this is a device that adheres to the riscv-iommu spec, not to an IOMMU of=
 any particular
> vendor.
>
> Since RVI doesn't provide a PCI ID for it we went to Red Hat, and they we=
re kind enough
> to give us a PCI ID for the RISC-V IOMMU reference device.

That's great. Thanks to Red Hat.
I'm wondering do we have the plan to document the new PCI ID to the IOMMU s=
pec
or somewhere else that's publicly accessible?

Regards,
Frank Chang

>
> I'll do a proper job this time and add all this context in the commit msg=
. Including a
> proper shout-out to Gerd and Red Hat.
>
>
>
> Thanks,
>
>
> Daniel
>
>
> [1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@v=
entanamicro.com/
> [2] https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0
>
> >
> > thanks
> > -- PMM
>

