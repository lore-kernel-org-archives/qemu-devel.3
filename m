Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFCCC52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJEC-0001De-53; Sun, 11 Aug 2024 20:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJEA-00016C-TK; Sun, 11 Aug 2024 20:48:02 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJE9-00022k-2y; Sun, 11 Aug 2024 20:48:02 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-49294575ad8so2214761137.1; 
 Sun, 11 Aug 2024 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723423679; x=1724028479; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8X06D6MrnzEHxjPj7KuW/tymHe2zfOIMSLRta/HC0E0=;
 b=lnmcWMUCfOshofBQMwcX8LDH7tkup9/MC+543td9Js6d46Ig07zqxDhPJ5zaYkmV8s
 8U+rbHIJZHAH2E2X33SnJGlWG2cil5m6wlJZrqSrN/+JBrdYhmMMhJq61zahl3GbMyHi
 lfBXL1sph6PHgC+VgA0zvx3gvYTpJsGA8LIcAk394tB0ovDq8h+Lc+psl+Petfqr1r7J
 4+BXI6Hm6xKcfC652FCEb7mTFm7htMMpfPK97fl31kfYU3D6BPvV3aesTo5YkQwwJarm
 P2WEUKGM9Nmsc54qKDjrpkuxgyUCnWE0SYQZnTTKKcavbLglsWkQMxTzOJPTFmabcO1k
 DoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423679; x=1724028479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X06D6MrnzEHxjPj7KuW/tymHe2zfOIMSLRta/HC0E0=;
 b=n4K3Cjwo8RLBIXVsXyBqVKOItAYJoE443I09YHHzBWPt9fJYmfnwndAnCQJEmMiaDT
 4u75HLq/CmxeHpPMahLS29800oGGU5Fbk2XSGD3V2bRM5DDHWsa9UXgqNiS/kfMOPSCC
 M43z5ettMek2H9rVNBjqn2VQzKhRzfZaT0NTKFvXAEyFiGa1O9+EDGpzGQ23TV0vhsgk
 C+bKu58oQkrNGXV/l7sdhUstt+yMkpJoIyhldi/H8FDOVBPkA+aAC0IXo0q8ExZSxPD6
 qEyDmfnivnPZbsaJsh7eGBkNx4B5ErBk9zleaMm5QHuQALydML3mesIcmQvcXAfYO4ZN
 d85w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcEeJYqAf3tBtTxmHsSI08Z1wxOm5dXUQ5JU/2anFMCIQwKuPH6jyFDZnlPCwClz9O6Mn8q1oH9pj6XCJOKytunw/upx0=
X-Gm-Message-State: AOJu0YwIHAOcAi5EqY7XYIhCFOzBchKpOZMnhMEq9bwEBVPMSW+n4XKy
 nfxBCyFkGDHtYbdinKPAGtQCHstNHCIKGQsOWp3D5V8CsiWDZoWYhaVIM7w7wZv0q7XjQMOAJWy
 0pFg6CMrenywK5ntGxnyL1t27cx0=
X-Google-Smtp-Source: AGHT+IFspyyEIhwLad7t1hFkhHEkxLUt7HF52ORcpRyz3Ggf1o1Qru9mnSykBiEh2xhub/3tXJr8Cb1ugMYY6DHm09M=
X-Received: by 2002:a05:6102:390a:b0:492:98bf:75ef with SMTP id
 ada2fe7eead31-495d8c81951mr4185934137.8.1723423679455; Sun, 11 Aug 2024
 17:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101228.1247759-1-ethan84@andestech.com>
 <CAKmqyKN-YavB364d4wmwBBSi7TpsE1Y5CebvUCSi=CzfjWsJDQ@mail.gmail.com>
 <ZrXrXhJWoCeVqwtu@ethan84-VirtualBox>
In-Reply-To: <ZrXrXhJWoCeVqwtu@ethan84-VirtualBox>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Aug 2024 10:47:33 +1000
Message-ID: <CAKmqyKPPp2Dhti9KMPa=jgYyGJzgMsiGYMFSVTbMmpsrnaRsDQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] hw/misc/riscv_iopmp: Add API to set up IOPMP
 protection for system memory
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Fri, Aug 9, 2024 at 8:11=E2=80=AFPM Ethan Chen <ethan84@andestech.com> w=
rote:
>
> On Thu, Aug 08, 2024 at 02:23:56PM +1000, Alistair Francis wrote:
> >
> > On Mon, Jul 15, 2024 at 8:13=E2=80=AFPM Ethan Chen via <qemu-devel@nong=
nu.org> wrote:
> > >
> > > To enable system memory transactions through the IOPMP, memory region=
s must
> > > be moved to the IOPMP downstream and then replaced with IOMMUs for IO=
PMP
> > > translation.
> > >
> > > The iopmp_setup_system_memory() function copies subregions of system =
memory
> > > to create the IOPMP downstream and then replaces the specified memory
> > > regions in system memory with the IOMMU regions of the IOPMP. It also
> > > adds entries to a protection map that records the relationship betwee=
n
> > > physical address regions and the IOPMP, which is used by the IOPMP DM=
A
> > > API to send transaction information.
> > >
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  hw/misc/riscv_iopmp.c         | 61 +++++++++++++++++++++++++++++++++=
++
> > >  include/hw/misc/riscv_iopmp.h |  3 ++
> > >  2 files changed, 64 insertions(+)
> > >
> > > diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> > > index db43e3c73f..e62ac57437 100644
> > > --- a/hw/misc/riscv_iopmp.c
> > > +++ b/hw/misc/riscv_iopmp.c
> > > @@ -1151,4 +1151,65 @@ iopmp_register_types(void)
> > >      type_register_static(&iopmp_iommu_memory_region_info);
> > >  }
> > >
> > > +/*
> > > + * Copies subregions from the source memory region to the destinatio=
n memory
> > > + * region
> > > + */
> > > +static void copy_memory_subregions(MemoryRegion *src_mr, MemoryRegio=
n *dst_mr)

Maybe `alias_memory_subregions()` or `link_memory_subregions()`
instead of `copy_memory_subregions()`.

> > > +{
> > > +    int32_t priority;
> > > +    hwaddr addr;
> > > +    MemoryRegion *alias, *subregion;
> > > +    QTAILQ_FOREACH(subregion, &src_mr->subregions, subregions_link) =
{
> > > +        priority =3D subregion->priority;
> > > +        addr =3D subregion->addr;
> > > +        alias =3D g_malloc0(sizeof(MemoryRegion));
> > > +        memory_region_init_alias(alias, NULL, subregion->name, subre=
gion, 0,
> > > +                                 memory_region_size(subregion));
> > > +        memory_region_add_subregion_overlap(dst_mr, addr, alias, pri=
ority);
> > > +    }
> > > +}
> >
> > This seems strange. Do we really need to do this?
> >
> > I haven't looked at the memory_region stuff for awhile, but this seems
> > clunky and prone to breakage.
> >
> > We already link s->iommu with the system memory
> >
>
> s->iommu occupies the address of the protected devices in system
> memory. Since IOPMP does not alter address, the target address space
> must differ from system memory to avoid infinite recursive iommu access.
>
> The transaction will be redirected to a downstream memory region, which
> is almost identical to system memory but without the iommu memory
> region of IOPMP.
>
> This function serves as a helper to create that downstream memory region.

What I don't understand is that we already have target_mr as a
subregion of downstream, is that not enough?

Alistair

