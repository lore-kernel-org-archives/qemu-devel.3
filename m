Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FFDC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sich1-0000h1-3n; Mon, 26 Aug 2024 12:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sicgj-0000U9-AW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sicgc-0003GS-Na
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724690118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DRhuSVYwS5KtdDF6g3QhsrJCGr/1LZytTqqPyvoe5E=;
 b=N1WgVLD5NlyCzRu4tPUkrC4NOgHX2tzEnysWR6oZUJFYMOMGjuaJYLR80kgRkeIXCGJYoU
 fMfeEICTy+fhC6XNApYIjsDaUF9uWrCZfRkGBkkVPoia7rF87dqh7l4LzolhFO/dfUmrk6
 KEmK0mMk7jge6E+qEDuqrk3GJVNM8Ow=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-k78Z1dMJMAKfrJnSIeZDAQ-1; Mon, 26 Aug 2024 12:35:17 -0400
X-MC-Unique: k78Z1dMJMAKfrJnSIeZDAQ-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-827822a6908so59793039f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724690116; x=1725294916;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DRhuSVYwS5KtdDF6g3QhsrJCGr/1LZytTqqPyvoe5E=;
 b=H+99mPecwxl5BxGnwv5i4tykL86aRUm3qHXJbJDDbazgwzaicGDDa8c4iFcdzbQoQi
 lHxJdSXe9e+M3d4u/a9cJ8jSTFx/l61l6KvD+MLkIPNKTYUwrcjxvxeJMsi6gbfZyB8d
 gGL52vLeigngzef1aS/X/50DD9zsFah7NLAH9HLT66NFK8pbpduw2FFFb/zj8YT5W4rq
 pMjBsmpFIexRw5EEow4Wx3GtMxvNBhllIlx7hcMHe4DocZH5K4sPTEHiaJ6lxqBix0Oo
 2Voj/GUCIbllruFfXg9gthgTjtFMTXWgB+RF+x7Q1NDZV3ojPHxDlpZ0zwNxJermzrs9
 3sQA==
X-Gm-Message-State: AOJu0YysVssgpkRO5qrV8kEZLTCCLYFjmPPXxTJiS0IWgPaLfQZOmwMq
 y5YwbkidDaw65pVJ0EKtO8kU9KM9vgT19/aA+NJrgB2RqAwzbUizHXVe0dyPC1d9I3nAf+CANOw
 z7Dh5oX3xqLq9OKPuzHk4Jdi7rtOXREnD6IFcTG1Gue+fzNPepXFD4gmI0G51
X-Received: by 2002:a6b:e908:0:b0:822:3c35:5fc0 with SMTP id
 ca18e2360f4ac-82787361868mr666571639f.3.1724690116181; 
 Mon, 26 Aug 2024 09:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2YaatdzXHndueKTpwdUCEQa9fiWX2mfzJT7vy+re8TMDq3pNBUhiCam08RcxPtYZs2pyubw==
X-Received: by 2002:a6b:e908:0:b0:822:3c35:5fc0 with SMTP id
 ca18e2360f4ac-82787361868mr666570239f.3.1724690115667; 
 Mon, 26 Aug 2024 09:35:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce7113de45sm2247434173.167.2024.08.26.09.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:35:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:35:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Cc: <qemu-devel@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 4/7] vfio/igd: add new bar0 quirk to emulate BDSM mirror
Message-ID: <20240826103513.082360bd.alex.williamson@redhat.com>
In-Reply-To: <20240822111819.34306-5-c.koehne@beckhoff.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
 <20240822111819.34306-5-c.koehne@beckhoff.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 22 Aug 2024 13:08:29 +0200
Corvin K=C3=B6hne <c.koehne@beckhoff.com> wrote:

> =EF=BB=BFThe BDSM register is mirrored into MMIO space at least for gen 1=
1 and
> later devices. Unfortunately, the Windows driver reads the register
> value from MMIO space instead of PCI config space for those devices [1].
> Therefore, we either have to keep a 1:1 mapping for the host and guest
> address or we have to emulate the MMIO register too. Using the igd in
> legacy mode is already hard due to it's many constraints. Keeping a 1:1
> mapping may not work in all cases and makes it even harder to use. An
> MMIO emulation has to trap the whole MMIO page. This makes accesses to
> this page slower compared to using second level address translation.
> Nevertheless, it doesn't have any constraints and I haven't noticed any
> performance degradation yet making it a better solution.
>=20
> [1] https://github.com/projectacrn/acrn-hypervisor/blob/5c351bee0f6ae4625=
0eefc07f44b4a31e770f3cf/devicemodel/hw/pci/passthrough.c#L650-L653
>=20
> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> ---
>  hw/vfio/igd.c        | 97 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci-quirks.c |  1 +
>  hw/vfio/pci.h        |  1 +
>  3 files changed, 99 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 0b6533bbf7..863b58565e 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -374,6 +374,103 @@ static const MemoryRegionOps vfio_igd_index_quirk =
=3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> +#define IGD_BDSM_MMIO_OFFSET 0x1080C0
> +
> +static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
> +                                          hwaddr addr, unsigned size)
> +{
> +    VFIOPCIDevice *vdev =3D opaque;
> +    uint64_t offset;
> +
> +    offset =3D IGD_BDSM_GEN11 + addr;
> +
> +    switch (size) {
> +    case 1:
> +        return pci_get_byte(vdev->pdev.config + offset);
> +    case 2:
> +        return le16_to_cpu(pci_get_word(vdev->pdev.config + offset));
> +    case 4:
> +        return le32_to_cpu(pci_get_long(vdev->pdev.config + offset));
> +    case 8:
> +        return le64_to_cpu(pci_get_quad(vdev->pdev.config + offset));
> +    default:
> +        hw_error("igd: unsupported read size, %u bytes", size);
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
> +                                       uint64_t data, unsigned size)
> +{
> +    VFIOPCIDevice *vdev =3D opaque;
> +    uint64_t offset;
> +
> +    offset =3D IGD_BDSM_GEN11 + addr;
> +
> +    switch (size) {
> +    case 1:
> +        pci_set_byte(vdev->pdev.config + offset, data);
> +        break;
> +    case 2:
> +        pci_set_word(vdev->pdev.config + offset, data);
> +        break;
> +    case 4:
> +        pci_set_long(vdev->pdev.config + offset, data);
> +        break;
> +    case 8:
> +        pci_set_quad(vdev->pdev.config + offset, data);
> +        break;
> +    default:
> +        hw_error("igd: unsupported read size, %u bytes", size);
> +        break;
> +    }
> +}

If we have the leXX_to_cpu() in the read path, don't we need
cpu_to_leXX() in the write path?  Maybe we should in fact just get rid
of all of them since we're quirking a device that's specific to a
little endian architecture and we're defining the memory region as
little endian, but minimally we should be consistent.

> +
> +static const MemoryRegionOps vfio_igd_bdsm_quirk =3D {
> +    .read =3D vfio_igd_quirk_bdsm_read,
> +    .write =3D vfio_igd_quirk_bdsm_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOQuirk *quirk;
> +    int gen;
> +
> +    /*
> +     * This must be an Intel VGA device at address 00:02.0 for us to even
> +     * consider enabling legacy mode. Some driver have dependencies on t=
he PCI
> +     * bus address.
> +     */
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> +        !vfio_is_vga(vdev) || nr !=3D 0 ||
> +        &vdev->pdev !=3D pci_find_device(pci_device_root_bus(&vdev->pdev=
),
> +                                       0, PCI_DEVFN(0x2, 0))) {
> +        return;
> +    }
> +
> +    /*
> +     * Only on IGD devices of gen 11 and above, the BDSM register is mir=
rored
> +     * into MMIO space and read from MMIO space by the Windows driver.
> +     */
> +    gen =3D igd_gen(vdev);
> +    if (gen < 11) {
> +        return;
> +    }
> +
> +    quirk =3D vfio_quirk_alloc(1);
> +    quirk->data =3D vdev;
> +
> +    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_q=
uirk,
> +                          vdev, "vfio-igd-bdsm-quirk", 8);
> +    memory_region_add_subregion_overlap(vdev->bars[0].region.mem, 0x1080=
C0,

Use your macro here, IGD_BDSM_MMIO_OFFSET.  Thanks,

Alex

PS - please drop the confidential email warning signature when posting
to public lists.

> +                                        &quirk->mem[0], 1);
> +
> +    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
> +}
> +
>  void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      g_autofree struct vfio_region_info *rom =3D NULL;
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 39dae72497..d37f722cce 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1259,6 +1259,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int =
nr)
>      vfio_probe_nvidia_bar0_quirk(vdev, nr);
>      vfio_probe_rtl8168_bar2_quirk(vdev, nr);
>  #ifdef CONFIG_VFIO_IGD
> +    vfio_probe_igd_bar0_quirk(vdev, nr);
>      vfio_probe_igd_bar4_quirk(vdev, nr);
>  #endif
>  }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index bf67df2fbc..5ad090a229 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -215,6 +215,7 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
>  bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
>  void vfio_quirk_reset(VFIOPCIDevice *vdev);
>  VFIOQuirk *vfio_quirk_alloc(int nr_mem);
> +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
>  void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
> =20
>  extern const PropertyInfo qdev_prop_nv_gpudirect_clique;


