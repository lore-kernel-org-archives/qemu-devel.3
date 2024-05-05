Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE62C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fWv-0008Nu-Oi; Sun, 05 May 2024 13:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.muzzammilashraf@gmail.com>)
 id 1s3fWm-0008IG-Ap
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:19:56 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.muzzammilashraf@gmail.com>)
 id 1s3fWk-0006q9-2P
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:19:56 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b24162dd6so7559996d6.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714929592; x=1715534392; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytbYUHdwVfzuj4JdnIK7In99yjAH+Y60KWD23eZYUA4=;
 b=HAiPnLgmBB1QJ2rcJqEI7qRpO7HTrQk81tzcKDNje9AgmbSrJNNO/bDmpWbHtp2MCO
 GKPyW1xdKBkK/2ZlxY2exbTKfA1lhYzoIqP2zXlGRXtfeqOdLpe9vzBLIFMmiXGrGg2W
 6nPVmX6lTsEk4BFbsGFeEpZc3MRziWU3des7uSmwvPYavzFuF6DU2nhHhYuftGfTZx9u
 m6T7DyMMJwmhlXOdGU+k7VkOwqOM0TLxJD+rYi2OTWgbc0QMG0POKjGY8h/UKGwR//cD
 EYwclVIod5D6/8i4FOVKbVzMhmAGK5EjCAvbVsRqmxmvVwI6JLN7OaMNFEk2bjmmAj2a
 ioKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714929592; x=1715534392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytbYUHdwVfzuj4JdnIK7In99yjAH+Y60KWD23eZYUA4=;
 b=BIrQ3NYheuSGJveOnCCPkBwsD369TQlxaEjB+3Lon4dxCmVc5xuxOyDLs2xRHh5GYE
 x8sUqKnwSFPy3nWKFz0n9cVJgJvHZZu//Z1wCm5WtcYXTMMjA6Uh/XqObTpl55OfFpiN
 d0arwhBRmmkliBPhbbK+avLMowf0F3s2Vg4z82AkfPmnePktd2xj02LpOlHBGaXM8gbo
 ADH+hBlNqhWnpiPNoK/dOGZzFp5Y0QsX0Owa6YKPSzx++vPIJL0EOetUlfRBVP88iDDn
 31l3blIJxmc7N3ipOV1IaLrrvr+arAv0czxdqDN+2ggTODN2UXEUhWfiFpN/iuzEnl/m
 o+lA==
X-Gm-Message-State: AOJu0YxcnPzOIUqo67DyIipgBFTB25CYtUb5+PCTRtpjOW/yKD1Bm+54
 IRKnLnOTYvBBIH0TS7wQG87aaxj/TTLWNI0Ilfg1jal5c3MOX5/lYqnlmzEUAAeFibVP/el+y5U
 tDoRUq55ZzkN91+ogv+w0DQz3KB/OKA==
X-Google-Smtp-Source: AGHT+IH2egIvWYJZKogfrjmbGZc/Mc6oIi5bb+L6Vsa+Ekk2KVsQxdvjG5CXrVW5yYDhbxl8UjhVnl02n26VJWlJkjU=
X-Received: by 2002:a05:6214:2b0e:b0:6a0:6f04:b290 with SMTP id
 jx14-20020a0562142b0e00b006a06f04b290mr9090901qvb.42.1714929592106; Sun, 05
 May 2024 10:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHePoZ=+vJt_8CC3eYN5kjfUcqQMRjnzM+xEfoBswq8-8JWfQ@mail.gmail.com>
 <1a1f5642-fc0e-4d1f-bc29-66da97cccd1e@linux.ibm.com>
In-Reply-To: <1a1f5642-fc0e-4d1f-bc29-66da97cccd1e@linux.ibm.com>
From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
Date: Sun, 5 May 2024 22:19:41 +0500
Message-ID: <CAJHePoZiH6eTWJNASrk_0Fm4iEhqJfskCr6StToY2Xy6BFXB6A@mail.gmail.com>
Subject: Re: PCIE Memory Information
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=m.muzzammilashraf@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I have already studied this document and tested the overlap of MemoryRegion=
s.

There is a structure named PCIHostState and in this struct there is a
field named config_reg. I want to understand where it gets changed.

On Sun, May 5, 2024 at 6:45=E2=80=AFPM Aditya Gupta <adityag@linux.ibm.com>=
 wrote:
>
> Hi Ashraf,
>
> On 04/05/24 12:45, Muzammil Ashraf wrote:
>
> Hi All,
>
> I am debugging a PCI subsystem. I saw callbacks registered here to
> catch the pcie config read/write request at hw/pci/pci_host.c:201. How
> can I make my subregion to overlap this area and How to receive those
> pcie config read/write requests to my callbacks?
>
>
> Can go through this doc: https://www.qemu.org/docs/master/devel/memory.ht=
ml#overlapping-regions-and-priority
>
> Normally the callbacks you mentioned will be registered on a MemoryRegion=
. You can create your own MemoryRegion, and set your custom .read, .write c=
allbacks.
>
> And setting the MemoryRegion's priority as a big positive number.
>
>
> FWIW, had did something like this in past:
>
>
> +static uint64_t adi_region_read(void *chip10, hwaddr addr, unsigned size=
) {
> + // your code
> +}
> +
> +static void adi_region_write(void *chip10, hwaddr addr, uint64_t value, =
unsigned size) {
> + // your code
> +}
> +
> +static const MemoryRegionOps adi_region_ops =3D {
> +    .read =3D adi_region_read,
> +    .write =3D adi_region_write,
> +        .endianness =3D DEVICE_BIG_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
>
> +    static hwaddr ADI_REGION_BASE =3D 0x0006010000000000ull + 0x100;
> +
>
> +    memory_region_init_io(&chip10->adi_region, OBJECT(chip10), &adi_regi=
on_ops, chip10, "custom region: adityag", 0x100);
> +    memory_region_add_subregion(get_system_memory(), ADI_REGION_BASE, &c=
hip10->adi_region);
>
> Instead of 'get_system_memory', you will have to see what is the PCI conf=
ig region a subregion of.
>
>
> Then, set the MemoryRegion's priority to some big number.
>
> Then, you can verify if your overlapping was successful, with something l=
ike this:
>
>
> +    MemoryRegion *mr =3D address_space_translate(&address_space_memory, =
ADI_REGION_BASE, &xlat, &l, false, MEMTXATTRS_UNSPECIFIED);
>
> or
>
> +    cpu_physical_memory_read(ADI_REGION_BASE, &val, 4);
>
>
> 1st should return your MemoryRegion, and second one should call your .rea=
d callback.
>
>
> Thanks,
>
> Aditya Gupta

