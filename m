Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FD7C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6wS-0006yb-Px; Fri, 13 Jun 2025 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6wR-0006yC-3D
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:07:43 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6wL-0001E2-Mj
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:07:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e6bddc30aso20413437b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749830856; x=1750435656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=runPSHNnAiofURFB4Prnk+4ZgiuQj3pP6BD3srb8FRw=;
 b=kPpEatApUCZ8jl6fwZNnpNr47fBeUbzoutlzlpNo+lfX1gEZNvtXv8AzcdguyO71zW
 1JWlFOyoBPkih35n9r5FiaOItEwF7oTpciA8sKgJducT9ZnCQMD08MTuIu6hnx+U5Iqg
 1yEEl8kvjmZdaSkHHgO9ETwJjMhFzbwNjnTpvEudxX4KXZL4h9NFSiIlpxkBLIclp/8X
 Ru9JBQgKFtQQ7lNPqOOb2v1W43uEjTkkutNUkOWxk33qu/KGRYeFaGaTQyBTilVNEQIO
 l4D+uWERZvOru3l/OKsFrn6zI01Rds5Dr2y6Sh9IMZUgxTvFBzjNrE+UBVhiojllO7EB
 vqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749830856; x=1750435656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=runPSHNnAiofURFB4Prnk+4ZgiuQj3pP6BD3srb8FRw=;
 b=QVq12LEyouWkAptlBqp2ZDzERD6pVaPTA4mErJIFALrwmoNV08kMuAuwzEhwsX//9g
 bpzx//tjsdW1WV7qY4chHBZYLV05jyTIEqXVcWNcOd5RBUgMNXyiGQJ/QbCqKk8/hvgb
 7G5P0dO1XIqxBrdUFc/MmaBcomcNbE6sSDDCm2lXXraOB22YL5BeqFE60IvQbyBEVGZ1
 JLwdPPoVqvWTsndlZMOJfz6MolL/r9zQEEzbz2XlzxikUd0eH0Imgbu4kMP6S1aV4vtS
 L6w9dd+oRsI87a2brW0w+Mh1YQMy8vMGU/nYt1dKJxmx1jQ9cqAB6Dbcrqj4hNv239Ip
 Y0HQ==
X-Gm-Message-State: AOJu0YxtJdjpV7nWs/w905PzEmK1uAi/17cXyPKFz12tKW/hiOSDygS5
 NbGJoSUATtsz9JygK/Hc2v/JZe44pFh0qIaHEGjx9ka6icjLqEs6ZxdvWvVoCk+pP1qfCztsIU5
 vSD7KCoSate58nfrOTRZ6iO2a6HT7EMHAHwcInpUTUg==
X-Gm-Gg: ASbGncvf1arzR3oaIL0L8ArrkVKCy6/NXJHYdgEMgnSUQuQ7nzkxkkPMvgETxbKj61T
 hnCWfUPX68cSjjuoX27C4V+bUkMwCJvpzyQirQh3ymyS4fB8OX+wheJdro4uQ3s/W7yxw9+6ChL
 tXQi3Bv7XRmvg3DhKjcjaeuXZxIyqFRM5YS/JUYDWBQfD8
X-Google-Smtp-Source: AGHT+IEt1SN6zbIZVZJ7Z2S/c4snZBWEGwekLPATt6rzh8CCPguf80eGpk0hQhWJ4FCS/m9fqbYDVpyBHmqiFVV4ea4=
X-Received: by 2002:a05:690c:968e:b0:70e:7a67:b4c5 with SMTP id
 00721157ae682-7116377cee5mr52563887b3.36.1749830855766; Fri, 13 Jun 2025
 09:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
 <CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
 <20250613162054.000003cf@huawei.com>
In-Reply-To: <20250613162054.000003cf@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 17:07:24 +0100
X-Gm-Features: AX0GCFsd8mxMT-w2iPsLlVwEKMHjA3lJ8J7CkRV_0qv7wyH083gjLI13UxLyzBI
Message-ID: <CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 13 Jun 2025 at 16:20, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 13 Jun 2025 13:57:39 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > Code based on i386/pc enablement. The memory layout places space for 16
> > > host bridge register regions after the GIC_REDIST2 in the extended memmap.
> > > The CFMWs are placed above the extended memmap.
> > >
> > > Only create the CEDT table if cxl=on set for the machine.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > ---
> > > v15: No changes.
> > > ---
> > >  include/hw/arm/virt.h    |  4 ++++
> > >  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
> > >  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
> > >  3 files changed, 67 insertions(+)
> >
> Hi Peter,
>
> Thanks for reviewing.
>
> > Can we have some user-facing documentation, please?
> > (docs/system/arm/virt.rst -- can just be a brief mention
> > and link to docs/system/devices/cxl.rst if you want to put the
> > examples of aarch64 use in there.)
>
> Given the examples should look exactly like those for x86/pc, do we need
> extra examples in cxl.rst? I guess I can add one simple arm/virt example
> in a follow up patch without bloating that file too badly..

That's fine too -- if the answer is "all these command lines work
for aarch64 too", then you can just say that in cxl.rst.

> Is the following sufficient for the board specific docs?
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 6a719b9586..10cbffc8a7 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -31,6 +31,7 @@ Supported devices
>  The virt board supports:
>
>  - PCI/PCIe devices
> +- CXL Fixed memory windows, root bridges and devices.
>  - Flash memory
>  - Either one or two PL011 UARTs for the NonSecure World
>  - An RTC
> @@ -189,6 +190,14 @@ ras
>  acpi
>    Set ``on``/``off``/``auto`` to enable/disable ACPI.
>
> +cxl
> +  Set  ``on``/``off`` to enable/disable CXL. More details in
> +  :doc:`../devices/cxl`. The default is off.
> +
> +cxl-fmw
> +  Array of CXL fixed memory windows describing fixed address routing to
> +  target CXL host bridges. See :doc:`../devices/cxl`.
> +
>  dtb-randomness
>    Set ``on``/``off`` to pass random seeds via the guest DTB
>    rng-seed and kaslr-seed nodes (in both "/chosen" and

Looks OK.

> >
> > > @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
> > >  static MemMapEntry extended_memmap[] = {
> > >      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> > >      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> > > +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
> >
> > This is going to shuffle the memory map around, even if CXL
> > isn't enabled, which will break migration compatibility.
> > You need to do something to ensure that the CXL region isn't
> > included in the calculations of the base addresses for these
> > regions if CXL isn't enabled.
> >
>
> It doesn't move any existing stuff because these are naturally aligned
> regions so this is in a gap before the PCIE ECAM region.

Is that true even when we have the maximum number of CPUs and
so the max number of redistributors in that VIRT_HIGH_GIC_REDIST2
region ?

> > >      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> > >      /* Second PCIe window */
> > >      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
> >
> > If you're OK with having the CXL host region at the end of the
> > list then that's a simpler way to avoid its presence disturbing
> > the layout of the existing regions, but you might not like it
> > being at such a high physaddr.
>
> From what I recall a higher address isn't a problem I just wanted to not waste any
> PA space at all so used the gap.
>
> Chunk of /proc/iomem with a random test case (in first case with the cxl bits
> removed as obvious that doesn't start until this patch is in place).
> Need more than 123 cpus to make the second gicv3 redist appear
> (I've no idea why that number I just printed the threshold where
> it was calculated to find out what I needed to wait for boot on).

It's 123 because that's the most redistributors we can fit into
the lower redistributor region. (We didn't really allow enough
space in the lower memory map, which is why we need this awkward
split setup.

(I have to run now, will look at the rest of the email next week.)

-- PMM

